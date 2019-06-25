#Unpacking
./modify.sh e RT-N56U.trx

#chmod 775
chmod 775 -R squashfs-root

#Repackage
./modify.sh c NEW-RT-N56U.trx

#chnroute mode
sh /etc_ro/v2ray/sh-whitelist.sh