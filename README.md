## How to USE

``` python
#chnroute mode:
sh /etc_ro/v2ray/whitelist.sh

#gfwlist mode:
sh /etc_ro/v2ray/gfwlist.sh
```
use   <a href="https://www.lanzous.com/i4p480b" target="_blank">modify</a>  to inject v2ray to *.trx

<br>

## 使用方式：
* 样例为*.trx解包，v2ray放入/etc_ro/里封包使用。<a href="https://www.right.com.cn/forum/thread-747762-1-1.html" target="_blank">如何解包</a>
* 修改config.json（白名单）或gfwconfig.json（黑名单）为你客户端信息;
* 添加755权限;
  
  
* #### 设置自启动:
 * 在'防火墙规则启动后执行'里添加一段`sh /etc_ro/v2ray/whitelist.sh`
 
<br>

-----------------------------

<br>

 * v2ray文件夹可放入USB设备、TMP目录或storage空间;
 *  如放入`/etc/storage`，需把上面sh `/etc_ro/v2ray/`whitelist.sh更改为 `/etc/storage/v2ray/`
 * `v2ray/whitelist.sh` 也有两处地址需要更改。
      
 <br>
 
##### * 更多信息请看`/v2ray/whitelist.sh`
  
 <br>
 
-------------
## Thanks:

<br>

感谢以下的项目,排名不分先后

<br>

https://github.com/hanwckf/rt-n56u

https://gitee.com/felix-fly/v2ray-dnsmasq-dnscrypt

https://w2x.me/2018/09/20/ASUS-66u-%E6%90%AD%E5%BB%BA%E9%80%8F%E6%98%8E%E4%BB%A3%E7%90%86/
