#!/bin/sh
ipset destroy chnroute

iptables -t nat -N V2RAY
iptables -t nat -A V2RAY -d 0.0.0.0/8 -j RETURN
iptables -t nat -A V2RAY -d 10.0.0.0/8 -j RETURN
iptables -t nat -A V2RAY -d 127.0.0.0/8 -j RETURN
iptables -t nat -A V2RAY -d 169.254.0.0/16 -j RETURN
iptables -t nat -A V2RAY -d 172.16.0.0/12 -j RETURN
iptables -t nat -A V2RAY -d 192.168.0.0/16 -j RETURN
iptables -t nat -A V2RAY -d 224.0.0.0/4 -j RETURN
iptables -t nat -A V2RAY -d 240.0.0.0/4 -j RETURN


# ×ª·¢µ½12345¶Ë¿Ú
#iptables -t nat -A V2RAY -p tcp -j REDIRECT --to-ports 12345
iptables -t nat -A V2RAY -p tcp --dport 22:100 -j REDIRECT --to-ports 12345
#iptables -t nat -A V2RAY -p tcp --dport 22 -j REDIRECT --to-ports 12345
#iptables -t nat -A V2RAY -p tcp --dport 80 -j REDIRECT --to-ports 12345
#iptables -t nat -A V2RAY -p tcp --dport 443 -j REDIRECT --to-ports 12345

# ×ª·¢Â·ÓÉ
iptables -t nat -A PREROUTING -p tcp -j V2RAY
#iptables -t nat -A OUTPUT -p tcp -j V2RAY
#iptables -t mangle -A PREROUTING -j V2RAY
#iptables -t mangle -A OUTPUT -j V2RAY_MARK


sleep 2

pid=$(ps | awk '/[v]2ray --config/{print $1}')

if [ "$pid" == "" ]; then
    echo "started"
else
    echo "restarted"
    kill $pid
fi

cd /etc_ro/v2ray/

SSL_CERT_FILE=./cacert.pem ./v2ray --config=gfwconfig.json &
