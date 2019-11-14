#!/bin/sh

modprobe ip_set_hash_net
modprobe xt_set

iptables -t nat -D PREROUTING CLASH  >/dev/null 2>&1
iptables -t nat -D OUTPUT CLASH  >/dev/null 2>&1
/bin/iptables -t nat -F CLASH >/dev/null 2>&1
/bin/iptables -t nat -X CLASH >/dev/null 2>&1


iptables -t nat -N CLASH
iptables -t nat -A CLASH -d 0.0.0.0 -j RETURN
iptables -t nat -A CLASH -d 127.0.0.1 -j RETURN
iptables -t nat -A CLASH -d 192.168.0.0/16 -j RETURN

# Anything else should be redirected to clash

#iptables -t nat -A CLASH -p tcp --dport 22:500 -j REDIRECT --to-ports 7892
#iptables -t nat -A CLASH -p tcp --dport 22 -j REDIRECT --to-ports 7892
#iptables -t nat -A CLASH -p tcp --dport 80 -j REDIRECT --to-ports 7892
#iptables -t nat -A CLASH -p tcp --dport 443 -j REDIRECT --to-ports 7892
iptables -t nat -A CLASH -p tcp -j REDIRECT --to-ports 7892

iptables -t nat -A PREROUTING -p tcp -j CLASH

sleep 1

pid=$(ps | awk '/[c]lash /{print $1}')
if [ "$pid" == "" ]; then
echo ""
echo "clash started"
else
echo ""
 echo "clash restarted"
kill $pid
fi
cd /tmp/clash/ 
#SSL_CERT_FILE=./cacert.pem ./clash --config=/tmp/clash/config.yaml &
/tmp/clash/clash -d /tmp/clash >/dev/null 2>&1 &

echo "-----------------------------------------------------------------"
echo ""
echo "restart clash:sh /tmp/clash/start-whitelist.sh"
echo ""
echo "stop clash:sh /tmp/clash/stop.sh"
echo ""
echo "------------------------------------------------------------------"
echo ""



