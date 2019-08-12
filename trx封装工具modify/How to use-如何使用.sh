#把modify文件夹放到x86-64 debian或Ubuntu下

#把路由固件RT-N56U.trx放进modify

#解包Unpacking
./modify.sh e RT-N56U.trx

#复制压缩包etc_ro/v2ray文件夹到etc_ro/里

#chmod 775
chmod 775 -R squashfs-root

#封包Repackage
./modify.sh c NEW-RT-N56U.trx

#chnroute mode
sh /etc_ro/v2ray/sh-whitelist.sh