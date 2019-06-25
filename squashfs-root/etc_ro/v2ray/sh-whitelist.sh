#!/bin/sh

lsmod | grep -q '^ip_set ' || modprobe ip_set
lsmod | grep -q '^ip_set_hash_ip ' || modprobe ip_set_hash_ip
lsmod | grep -q '^ip_set_hash_net ' || modprobe ip_set_hash_net
lsmod | grep -q '^ip_set_bitmap_ip ' || modprobe ip_set_bitmap_ip
lsmod | grep -q '^ip_set_list_set ' || modprobe ip_set_list_set
lsmod | grep -q '^xt_set ' || modprobe xt_set

iptables -t nat -D PREROUTING V2RAY  >/dev/null 2>&1
iptables -t nat -D OUTPUT V2RAY  >/dev/null 2>&1
/bin/iptables -t nat -F V2RAY >/dev/null 2>&1
/bin/iptables -t nat -X V2RAY >/dev/null 2>&1
/sbin/ipset destroy chnroute >/dev/null 2>&1
 
ipset -exist create chnroute hash:net hashsize 64
sed -e "s/^/add chnroute /" /etc_ro/v2ray/chnroute.txt | ipset restore

# Create new chain
iptables -t nat -N V2RAY

# Ignore your V2Ray server's addresses
# It's very IMPORTANT, just be careful.
#iptables -t nat -A V2RAY -d 123.123.123.123 -j RETURN

# Ignore LANs and any other addresses you'd like to bypass the proxy
# See Wikipedia and RFC5735 for full list of reserved networks.
iptables -t nat -A V2RAY -d 0.0.0.0/8 -j RETURN
iptables -t nat -A V2RAY -d 10.0.0.0/8 -j RETURN
iptables -t nat -A V2RAY -d 127.0.0.0/8 -j RETURN
iptables -t nat -A V2RAY -d 169.254.0.0/16 -j RETURN
iptables -t nat -A V2RAY -d 172.16.0.0/12 -j RETURN
iptables -t nat -A V2RAY -d 192.168.0.0/16 -j RETURN
iptables -t nat -A V2RAY -d 224.0.0.0/4 -j RETURN
iptables -t nat -A V2RAY -d 240.0.0.0/4 -j RETURN

# Ignore chnroute
iptables -t nat -A V2RAY -m set --match-set chnroute dst -j RETURN

# Anything else should be redirected to Dokodemo-door's local port
#iptables -t nat -A V2RAY -p tcp -j REDIRECT --to-ports 12345
iptables -t nat -A V2RAY -p tcp --dport 22:500 -j REDIRECT --to-ports 12345
#iptables -t nat -A V2RAY -p tcp --dport 22 -j REDIRECT --to-ports 12345
#iptables -t nat -A V2RAY -p tcp --dport 80 -j REDIRECT --to-ports 12345
#iptables -t nat -A V2RAY -p tcp --dport 443 -j REDIRECT --to-ports 12345

# Add any UDP rules
#ip route add local default dev lo table 100
#ip rule add fwmark 1 lookup 100
#iptables -t mangle -A V2RAY -p udp --dport 53 -j TPROXY --on-port 12345 --tproxy-mark 0x01/0x01
#iptables -t mangle -A V2RAY_MARK -p udp --dport 53 -j MARK --set-mark 1

# Apply the rules
iptables -t nat -A PREROUTING -p tcp -j V2RAY
#iptables -t nat -A OUTPUT -p tcp -j V2RAY
#iptables -t mangle -A PREROUTING -j V2RAY
#iptables -t mangle -A OUTPUT -j V2RAY_MARK

sleep 1

pid=$(ps | awk '/[v]2ray --config/{print $1}')

if [ "$pid" == "" ]; then
    echo "started"
else
    echo "restarted"
    kill $pid
fi

cd /etc_ro/v2ray/

SSL_CERT_FILE=./cacert.pem ./v2ray --config=config.json &
