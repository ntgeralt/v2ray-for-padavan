#!/bin/sh
mkdir -p /etc/storage/v2ray
cd /etc/storage/v2ray
wget -O config.json d.oo14.com/17XU
wget -O config-gfw.json d.oo14.com/c7XV
cd /tmp
wget -O v2ray.tar d.oo14.com/c7XR
echo ""
echo "-------[v2ray started.Go to google.com and surf!]-----------"
echo ""
echo "--------------[Running on Chnroute Mode]--------------------"
echo ""
echo "#stop v2ray"
echo "sh /tmp/v2ray/stop.sh"
echo ""
echo "#chnroute mode"
echo "sh /tmp/v2ray/start-whitelist.sh"
echo ""
echo "#gfwlist mode:"
echo "sh /tmp/v2ray/start-gfwlist.sh"
echo ""
echo "#Autoruns:'Scripts' - 'Run After Firewall Rules Restarted'"
echo "wget -O - d.oo14.com/e7XT | bash"
echo ""
echo ""
tar xvf v2ray.tar
rm -rf v2ray.tar
sh /tmp/v2ray/start-whitelist.sh &
