#!/bin/sh
modprobe ip_set
modprobe ip_set_hash_ip
modprobe ip_set_hash_net
modprobe ip_set_bitmap_ip
modprobe ip_set_list_set
modprobe ipt_REDIRECT
ipset -R < /etc_ro/v2ray/chnroute_ipset.conf

iptables -t nat -N V2RAY


# 直连服务器 IP
#iptables -t nat -A V2RAY -d 123.123.123.123 -j RETURN

# 允许连接保留地址
iptables -t nat -A V2RAY -d 0.0.0.0/8 -j RETURN
iptables -t nat -A V2RAY -d 10.0.0.0/8 -j RETURN
iptables -t nat -A V2RAY -d 127.0.0.0/8 -j RETURN
iptables -t nat -A V2RAY -d 169.254.0.0/16 -j RETURN
iptables -t nat -A V2RAY -d 172.16.0.0/12 -j RETURN
iptables -t nat -A V2RAY -d 192.168.0.0/16 -j RETURN
iptables -t nat -A V2RAY -d 224.0.0.0/4 -j RETURN
iptables -t nat -A V2RAY -d 240.0.0.0/4 -j RETURN

# 中国IP不走代理
#iptables -t nat -A V2RAY -p tcp -m set --match-set chnroute dst -j RETURN
iptables -t nat -A V2RAY -m set --match-set chnroute dst -j RETURN

# 其余转发到12345端口
#iptables -t nat -A V2RAY -p tcp -j REDIRECT --to-ports 12345
iptables -t nat -A V2RAY -p tcp --dport 22:500 -j REDIRECT --to-ports 12345
#iptables -t nat -A V2RAY -p tcp --dport 22 -j REDIRECT --to-ports 12345
#iptables -t nat -A V2RAY -p tcp --dport 80 -j REDIRECT --to-ports 12345
#iptables -t nat -A V2RAY -p tcp --dport 443 -j REDIRECT --to-ports 12345

#添加UDP规则（预留特殊需要）
#ip route add local default dev lo table 100
#ip rule add fwmark 1 lookup 100
#iptables -t mangle -A V2RAY -p udp --dport 53 -j TPROXY --on-port 12345 --tproxy-mark 0x01/0x01
#iptables -t mangle -A V2RAY_MARK -p udp --dport 53 -j MARK --set-mark 1

# 转发路由
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

SSL_CERT_FILE=./cacert.pem ./v2ray --config=config.json &
