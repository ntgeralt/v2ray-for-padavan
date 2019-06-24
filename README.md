## 3.45MB V2Ray-mipsle 
* For MT7620/7621 Padavan

## How to USE?

``` python
#chnroute mode:
sh /etc_ro/v2ray/whitelist.sh

#gfwlist mode:
sh /etc_ro/v2ray/gfwlist.sh
```
use<a href="https://www.lanzous.com/i4p480b" target="_blank">modify</a>to inject v2ray to *.trx

## 使用方式：

* v2ray文件夹放入下列任意一处：
* USB设备，TMP目录，storage空间、或padavan trx解包后的etc_ro位置;

* 修改config.json（白名单）或gfwconfig.json（黑名单）为你客户端信息;
* 添加755权限;
  
  
* #### 设置自启动:
 * 在'防火墙规则启动后执行'里添加一段sh /etc_ro/v2ray/whitelist.sh
 * 样例为trx解包，放入/etc_ro/重新封包使用。
 * 如放入`/etc/storage`，需要把上面`/etc_ro/v2ray/`更改为 `/etc/storage/v2ray/`
 * `/etc/whitelist.sh` 也有三处地址需要更改。

##### * 更多信息请看`/v2ray/whitelist.sh`
  
  
-------------
## Thanks:
感谢以下的项目,排名不分先后

https://github.com/hanwckf/rt-n56u

https://gitee.com/felix-fly/v2ray-dnsmasq-dnscrypt

https://w2x.me/2018/09/20/ASUS-66u-%E6%90%AD%E5%BB%BA%E9%80%8F%E6%98%8E%E4%BB%A3%E7%90%86/
