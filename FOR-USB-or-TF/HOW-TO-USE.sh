修改/etc/storage/v2ray/config.json(黑名单模式config-gfw.json)为你客户端信息

chmod 775 -R /media/AiDisk_a1/v2ray/

chmod 775 -R /etc/storage/v2ray/

在自定义设置-脚本-'在防火墙规则启动后执行下'粘贴

#白名单chnroute mode: 
sh /etc/storage/v2ray/sh-whitelist.sh

#或

#黑名单gfwlist mode: 
sh /etc/storage/v2ray/sh-gfwlist.sh

ALL DONE!