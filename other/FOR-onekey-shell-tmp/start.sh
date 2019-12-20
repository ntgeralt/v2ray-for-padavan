#!/bin/sh
#载入modprobe模块
modprobe ip_set_hash_net
modprobe xt_set

#结束v2ray-watchdog进程
while [ -n "`pidof v2ray-watchdog`" ] ; do
	kill -9 "`pidof v2ray-watchdog`"
	sleep 1
done
echo "v2ray-watchdog killed."



#清理V2RAY iptable
iptables -t nat -D PREROUTING V2RAY  >/dev/null 2>&1
iptables -t nat -D OUTPUT V2RAY  >/dev/null 2>&1
/bin/iptables -t nat -F V2RAY >/dev/null 2>&1
/bin/iptables -t nat -X V2RAY >/dev/null 2>&1
/sbin/ipset destroy chnroute >/dev/null 2>&1

#iptable绕过大陆ip和内网
ipset -exist create chnroute hash:net hashsize 64
sed -e "s/^/add chnroute /" /tmp/v2ray/chnroute.txt | ipset restore

iptables -t nat -N V2RAY
iptables -t nat -A V2RAY -d 0.0.0.0 -j RETURN
iptables -t nat -A V2RAY -d 127.0.0.1 -j RETURN
iptables -t nat -A V2RAY -d 192.168.0.0/16 -j RETURN


iptables -t nat -A V2RAY -m set --match-set chnroute dst -j RETURN


# 其余22-500端口交给v2ray
iptables -t nat -A V2RAY -p tcp --dport 22:500 -j REDIRECT --to-ports 1234
#iptables -t nat -A V2RAY -p tcp --dport 22 -j REDIRECT --to-ports 1234
#iptables -t nat -A V2RAY -p tcp --dport 80 -j REDIRECT --to-ports 1234
#iptables -t nat -A V2RAY -p tcp --dport 443 -j REDIRECT --to-ports 1234
#iptables -t nat -A V2RAY -p tcp -j REDIRECT --to-ports 1234

iptables -t nat -A PREROUTING -p tcp -j V2RAY



#关闭v2ray
pid=$(ps | awk '/[v]2ray --config/{print $1}')

if [ "$pid" == "" ]; then
echo ""
echo "[V2Ray started]"
else
echo ""
echo "[V2Ray restarted]"
    kill $pid
fi

echo "-----------------[V2Ray started]---------------------------"

#启动v2ray
cd /tmp/v2ray/ 

SSL_CERT_FILE=./cacert.pem ./v2ray --config=/etc/storage/v2ray/config.json >/dev/null 2>&1 &

#启动v2ray-watchdog
/tmp/v2ray/v2ray-watchdog >/dev/null 2>&1 &
echo "v2ray-watchdog started."
