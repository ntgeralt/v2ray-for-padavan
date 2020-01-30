操作概要：
#复制AiDisk_a1里的v2ray文件夹到路由相同目录（相当于复制到外储存设备里）

#修改v2ray/config.json为你客户端信息（默认gfwlist模式，公益节点均衡负载）

#添加运行权限
chmod 775 -R /media/AiDisk_a1/v2ray/

#启动命令
sh /media/AiDisk_a1/v2ray/start.sh

#停止操作
sh /media/AiDisk_a1/v2ray/stop.sh

自启动：
在自定义设置-脚本-'在防火墙规则启动后执行下'粘贴
sleep 10
sh /media/AiDisk_a1/v2ray/start.sh


ALL DONE!

ps:更多config.json可参考example-config文件夹；

注意：有的路径可能不是/media/AiDisk_a1/，而是/media/TFCARD_或其他；
修改start.sh，路径改为你的路径（一共两处）


（非必须）下面这句放进自定义dnsmasq.conf可让gfwlist网站走特定dns
conf-dir=/media/AiDisk_a1/v2ray/dnsmasq-gwlist/, *.hosts

