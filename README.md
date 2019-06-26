## How to USE

``` python
#chnroute mode:
sh /etc_ro/v2ray/sh-whitelist.sh

#gfwlist mode:
sh /etc_ro/v2ray/sh-gfwlist.sh
```
use   <a href="https://github.com/ntgeralt/v2ray-for-padavan/tree/master/OTHERS/.trx%20Unpacking" target="_blank">modify</a>  to inject v2ray to *.trx

<br>

## 使用方式：
* 样例为*.trx解包，v2ray放入/etc_ro/里封包使用。<a href="https://www.right.com.cn/forum/thread-747762-1-1.html" target="_blank">如何解包</a>
* 修改config.json（白名单）或config-gfw.json（黑名单）为你客户端信息;
* 添加755权限;
  
  
* #### 设置自启动:
 * 在'防火墙规则启动后执行'里添加一段`sh /etc_ro/v2ray/sh-whitelist.sh`
 
<br>

-----------------------------

<br>

* OTHER文件夹有三种不同路径启动方式，其中只在执行路径有变化：
  * * 启动脚本sh /etc_ro/v2ray/sh-whitelist.sh` 
  * * 和脚本`v2ray/sh-whitelist.sh` 内两处。

 <br>
 
##### * 更多信息请看`/v2ray/sh-whitelist.sh`
  
 <br>
 
-------------
## Thanks:
感谢以下的项目,排名不分先后

https://github.com/hanwckf/rt-n56u

https://gitee.com/felix-fly/v2ray-dnsmasq-dnscrypt

https://w2x.me/2018/09/20/ASUS-66u-%E6%90%AD%E5%BB%BA%E9%80%8F%E6%98%8E%E4%BB%A3%E7%90%86/
