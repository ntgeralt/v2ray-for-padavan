#!/bin/sh

#载入模块
modprobe ip_set_hash_net
modprobe xt_set

#执行停止脚本
cd /tmp/v2ray
sh stop.sh

#清理iptable
iptables -t nat -D PREROUTING V2RAY  >/dev/null 2>&1
iptables -t nat -D OUTPUT V2RAY  >/dev/null 2>&1
/bin/iptables -t nat -F V2RAY >/dev/null 2>&1
/bin/iptables -t nat -X V2RAY >/dev/null 2>&1
/sbin/ipset destroy chnroute >/dev/null 2>&1

#绕过内网及大陆ip
ipset -exist create chnroute hash:net hashsize 64
sed -e "s/^/add chnroute /" /tmp/v2ray/chnroute.txt | ipset restore
echo ""
echo ""
echo "[setting iptables]"
iptables -t nat -N V2RAY
iptables -t nat -A V2RAY -d 0.0.0.0 -j RETURN
iptables -t nat -A V2RAY -d 127.0.0.1 -j RETURN
iptables -t nat -A V2RAY -d 192.168.0.0/16 -j RETURN
iptables -t nat -A V2RAY -m set --match-set chnroute dst -j RETURN

#22-500 tcp端口的海外流量交给v2ray
iptables -t nat -A V2RAY -p tcp --dport 22:500 -j REDIRECT --to-ports 1234
#iptables -t nat -A V2RAY -p tcp --dport 22 -j REDIRECT --to-ports 1234
#iptables -t nat -A V2RAY -p tcp --dport 80 -j REDIRECT --to-ports 1234
#iptables -t nat -A V2RAY -p tcp --dport 443 -j REDIRECT --to-ports 1234
#iptables -t nat -A V2RAY -p tcp -j REDIRECT --to-ports 1234
iptables -t nat -A PREROUTING -p tcp -j V2RAY


echo "-----------------[V2Ray started]---------------------------"


#启动v2ray
cd /tmp/v2ray
SSL_CERT_FILE=./cacert.pem ./v2ray --config=/etc/storage/v2ray/config.json >/dev/null 2>&1 &
echo "[V2ray start]"

#启动守护
./v2ray-watchdog >/dev/null 2>&1 &
echo "[v2ray-watchdog started]."
