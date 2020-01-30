#!/bin/sh
#echo "Load modprobe"
modprobe ip_set_hash_net
modprobe xt_set

cd /media/AiDisk_a1/v2ray
sh stop.sh

#echo "[cleanning iptables]"
iptables -t nat -D PREROUTING V2RAY  >/dev/null 2>&1
iptables -t nat -D OUTPUT V2RAY  >/dev/null 2>&1
/bin/iptables -t nat -F V2RAY >/dev/null 2>&1
/bin/iptables -t nat -X V2RAY >/dev/null 2>&1
/sbin/ipset destroy chnroute >/dev/null 2>&1
#echo "ipset chnroute"
ipset -exist create chnroute hash:net hashsize 64
sed -e "s/^/add chnroute /" /media/AiDisk_a1/v2ray/chnroute.txt | ipset restore
echo ""
echo ""
echo "[setting iptables]"
iptables -t nat -N V2RAY
iptables -t nat -A V2RAY -d 0.0.0.0 -j RETURN
iptables -t nat -A V2RAY -d 127.0.0.1 -j RETURN
iptables -t nat -A V2RAY -d 192.168.0.0/16 -j RETURN


iptables -t nat -A V2RAY -m set --match-set chnroute dst -j RETURN

# Anything else should be redirected to Dokodemo-door's local port

iptables -t nat -A V2RAY -p tcp --dport 22:500 -j REDIRECT --to-ports 1234
#iptables -t nat -A V2RAY -p tcp --dport 22 -j REDIRECT --to-ports 1234
#iptables -t nat -A V2RAY -p tcp --dport 80 -j REDIRECT --to-ports 1234
#iptables -t nat -A V2RAY -p tcp --dport 443 -j REDIRECT --to-ports 1234
#iptables -t nat -A V2RAY -p tcp -j REDIRECT --to-ports 1234

iptables -t nat -A PREROUTING -p tcp -j V2RAY


echo "-----------------[V2Ray started]---------------------------"
echo ""
echo ""
echo "#stop v2ray"
echo "sh /media/AiDisk_a1/v2ray/stop.sh"
echo ""
echo "#Default config.json use GFW Mode"
echo ""
echo "[media/AiDisk_a1/v2ray/example-config]"
echo ""
echo "#Autoruns:"
echo "'Scripts' - 'Run After Firewall Rules Restarted'"
echo "sleep 10"
echo "sh /media/AiDisk_a1/v2ray/start.sh"
echo ""
echo "USE 5353 DNS FOR GFWLIST:"
echo "Custom 'dnsmasq.conf'"
echo "conf-dir=/media/AiDisk_a1/v2ray/dnsmasq-gwlist/, *.hosts"
echo ""
echo "-------------you can close this Window---------------------"
echo ""
echo ""

cd /media/AiDisk_a1/v2ray

SSL_CERT_FILE=./cacert.pem ./v2ray --config=/media/AiDisk_a1/v2ray/config.json >/dev/null 2>&1 &
echo "[V2ray start]"
#./v2ray-watchdog >/dev/null 2>&1 &
#echo "[v2ray-watchdog started]."
