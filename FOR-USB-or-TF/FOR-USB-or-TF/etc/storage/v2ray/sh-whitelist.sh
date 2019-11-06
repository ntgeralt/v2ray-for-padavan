#!/bin/sh
modprobe ip_set_hash_net
modprobe xt_set

ipset -R < /media/AiDisk_a1/v2ray/cn.conf

iptables -t nat -N V2RAY
iptables -t nat -A V2RAY -d 0.0.0.0 -j RETURN
iptables -t nat -A V2RAY -d 127.0.0.1 -j RETURN
iptables -t nat -A V2RAY -d 192.168.0.0/16 -j RETURN
iptables -t nat -A V2RAY -m set --match-set cn dst -j RETURN

# Anything else should be redirected to Dokodemo-door's local port
iptables -t nat -A V2RAY -p tcp --dport 22:500 -j REDIRECT --to-ports 12345
#iptables -t nat -A V2RAY -p tcp -j REDIRECT --to-ports 12345
#iptables -t nat -A V2RAY -p tcp --dport 22 -j REDIRECT --to-ports 12345
#iptables -t nat -A V2RAY -p tcp --dport 80 -j REDIRECT --to-ports 12345
#iptables -t nat -A V2RAY -p tcp --dport 443 -j REDIRECT --to-ports 12345

iptables -t nat -A PREROUTING -j V2RAY

sleep 1

pid=$(ps | awk '/[v]2ray --config/{print $1}')

if [ "$pid" == "" ]; then
    echo "started"
else
    echo "restarted"
    kill $pid
fi

cd /media/AiDisk_a1/v2ray/

SSL_CERT_FILE=./cacert.pem ./v2ray --config=/etc/storage/v2ray/config.json &
#sh /etc/storage/v2ray/sh-whitelist.sh