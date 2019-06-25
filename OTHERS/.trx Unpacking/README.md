## How to USE

``` python
#Unpacking
./modify.sh e RT-N56U.trx
#edit config.json
#chmod 775
chmod 775 -R squashfs-root
#Repackage
./modify.sh c NEW-RT-N56U.trx
#Reflash .trx firmware
#Autorun: `sh /etc_ro/v2ray/sh-whitelist.sh`
```

<br>

## 使用方式：
* #解包·./modify.sh e RT-N56U.trx·

* v2ray文件夹放入squashfs-root/etc_ro/里
* 修改config.json（白名单）或config-gfw.json（黑名单）;
* 递归775权限·chmod 775 -R squashfs-root·
* 封包·./modify.sh c NEW-RT-N56U.trx·
* #### 设置自启动:
 * 在'防火墙规则启动后执行'里添加一段`sh /etc_ro/v2ray/sh-whitelist.sh`
 
<br>

-----------------------------

<br>


 
##### * 更多信息请看`/v2ray/sh-whitelist.sh`
  
 <br>
 
-------------
## Thanks:
感谢以下的项目,排名不分先后

https://github.com/hanwckf/rt-n56u

https://gitee.com/felix-fly/v2ray-dnsmasq-dnscrypt

https://w2x.me/2018/09/20/ASUS-66u-%E6%90%AD%E5%BB%BA%E9%80%8F%E6%98%8E%E4%BB%A3%E7%90%86/
