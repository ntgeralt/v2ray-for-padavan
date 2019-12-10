修改/etc/storage/v2ray/config.json(黑名单模式config-gfw.json)为你客户端信息

chmod 775 -R /etc/storage/v2ray/

在自定义设置-脚本-'在防火墙规则启动后执行下'粘贴

#chnroute mode:
sh /etc/storage/v2ray/start-whitelist.sh

#stop v2ray:
sh /etc/storage/v2ray/start-whitelist.sh

#gfwlist mode:

FIRST:
edit & copy config-gfw.json to /etc/storage/v2ray/

THEN:
sh /etc/storage/v2ray/start-whitelist.sh

ALL DONE!