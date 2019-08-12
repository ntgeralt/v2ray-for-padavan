#!/bin/sh
echo "Starting..."
MKSQSHFS4='./mksquashfs'
PADJFFS2='./padjffs2'
UNSQSHFS='./unsquashfs'
case "$1" in
'extract'|'e')
offset1=`grep -oba hsqs $2 | grep -oP '[0-9]*(?=:hsqs)'`
offset2=`wc -c $2 | grep -oP '[0-9]*(?= )'`
size2=`expr $offset2 - $offset1`
#echo $offset1 " " $offset2 " " $size2
dd if=$2 of=kernel.bin bs=1 ibs=1 count=$offset1
dd if=$2 of=secondchunk.bin bs=1 ibs=1 count=$size2 skip=$offset1
rm -rf squashfs-root 2>&1
$UNSQSHFS -d squashfs-root secondchunk.bin
rm secondchunk.bin
;;
'create'|'c')
$MKSQSHFS4 ./squashfs-root ./newsecondchunk.bin
chown $USER ./newsecondchunk.bin
cat kernel.bin newsecondchunk.bin > $2
$PADJFFS2 $2
rm newsecondchunk.bin
;;
*)
echo 'run
"modify-firmware.sh extract firmware.bin"
You will find file "kernel.bin" and folder "squashfs-root".
Modify "squashfs-root" as you like,after everything is done,run
"modify-firmware.sh create newfirmware.bin"
And you will get a modified firmware named newfirmware.bin.
'
;;
esac

