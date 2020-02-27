支持MT7620/7621; 
<br>
实测K1/K2/优酷路由宝/K2P/NEWIFI3正常运行
 <br>
## USB启动方式：
* 下载FOR-USB-or-TF.zip，把里面文件夹放在路由内对应目录
* 修改v2ray/config.json为你客户端信息
* 添加权限：chmod 775 -R /media/AiDisk_a1/v2ray/
* 执行 `sh /media/AiDisk_a1/v2ray/start.sh` 启动
 <br>
* ALL DONE . Just Go surfing !  
 <br>
* 自启动：在自定义设置-脚本-'在防火墙规则启动后执行下'粘贴
    * `sleep 10 && sh /media/AiDisk_a1/v2ray/start.sh`
 <br>
  <br>
## 主文件除了放USB外部储存，还可以放在TMP、[STORAGE空间](https://www.right.com.cn/forum/thread-714749-1-1.html)或[trx固件封包](https://www.right.com.cn/forum/thread-747762-1-1.html)



* 推荐USB TF 外部储存和trx封包重刷； 
* trx封包操作:
    * 选中你的trx固件解包 - 放入v2ray文件夹后重新打包成trx - breed重刷。
    * 请下载'FOR-封装.zip'并看里面<指引>

 <br>
  
 <br>
 
-------------
## Thanks:
感谢以下的项目,排名不分先后

https://github.com/hanwckf/rt-n56u

https://gitee.com/felix-fly/v2ray-dnsmasq-dnscrypt

https://w2x.me/2018/09/20/ASUS-66u-%E6%90%AD%E5%BB%BA%E9%80%8F%E6%98%8E%E4%BB%A3%E7%90%86/
