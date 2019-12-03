#!/bin/sh

modprobe ip_set_hash_net
modprobe xt_set

iptables -t nat -D PREROUTING V2RAY  >/dev/null 2>&1
iptables -t nat -D OUTPUT V2RAY  >/dev/null 2>&1
/bin/iptables -t nat -F V2RAY >/dev/null 2>&1
/bin/iptables -t nat -X V2RAY >/dev/null 2>&1
/sbin/ipset destroy chnroute >/dev/null 2>&1

iptables -t nat -N V2RAY
iptables -t nat -A V2RAY -d 0.0.0.0 -j RETURN
iptables -t nat -A V2RAY -d 127.0.0.1 -j RETURN
iptables -t nat -A V2RAY -d 192.168.0.0/16 -j RETURN


# Anything else should be redirected to Dokodemo-door's local port
#iptables -t nat -A V2RAY -p tcp -j REDIRECT --to-ports 1234
#iptables -t nat -A V2RAY -p tcp --dport 22:500 -j REDIRECT --to-ports 1234
iptables -t nat -A V2RAY -p tcp --dport 22 -j REDIRECT --to-ports 1234
iptables -t nat -A V2RAY -p tcp --dport 80 -j REDIRECT --to-ports 1234
iptables -t nat -A V2RAY -p tcp --dport 443 -j REDIRECT --to-ports 1234

iptables -t nat -A PREROUTING -p tcp -j V2RAY

sleep 1

pid=$(ps | awk '/[v]2ray --config/{print $1}')

if [ "$pid" == "" ]; then
    echo "started"
else
    echo "restarted"
    kill $pid
fi

cd /media/AiCard_01/v2ray/

SSL_CERT_FILE=./cacert.pem ./v2ray --config=/etc/storage/v2ray/config-gfw.json &
#sh /etc/storage/v2ray/sh-gfwlist.sh