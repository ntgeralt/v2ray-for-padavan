操作概要：
用modify把trx解包成一个文件夹 - v2ray文件夹放进去/etc_ro/ - 重新打包，确保在flash大小以内 - breed重新刷入trx

环境：linux

下面用Debian 9 x86-64操作一遍：


#modify文件夹放进/root/

#padavan.trx放进/root/modify/

#权限
chmod 775 -R /root/modify/

#进入目录
cd /root/modify

#解包
./modify.sh e padavan.trx

#把/etc_ro/v2ray文件夹复制进/root/modify/squashfs-root/etc_ro/

#改权限
chmod 775 -R /root/modify/squashfs-root

#重新封包为newrom.trx
./modify.sh c newrom.trx

#breed下刷入newrom.trx

#zip里的 /etc/stroage/v2ray 复制进路由/etc/stroage/

#改config.json为你客户端信息



#在自定义设置-脚本-'在防火墙规则启动后执行下'粘贴

#chnroute mode:
sh /etc/storage/v2ray/start-whitelist.sh

#stop v2ray:
sh /etc/storage/v2ray/start-whitelist.sh



完

-------------（非必要）debian删除文件夹和zip打包操作---------------------------
#删除squashfs-root文件夹
rm -rf squashfs-root

#把squashfs-root文件夹打包成padavan-newrom.tar
tar cvf padavan-newrom.tar squashfs-root