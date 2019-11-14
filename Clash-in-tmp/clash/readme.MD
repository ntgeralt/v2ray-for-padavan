预设的clash运行在大陆白名单模式（全tcp转发到clash），启动的dns服务预设为fake 
ip并发查询3路dns.

启动前关闭路由自身dns 53端口服务：
自定义配置文件 "dnsmasq.conf"
加入
port=0

```js
--------------copy clash to /tmp-------------------------

js
cd /tmp
chmod +x clash

start:

sh /tmp/clash/start-whitelist.sh




stop:

sh /tmp/clash/stop.sh




kill:

kill -9 $(pidof clash)
-----------------------------------------------------
```


vmess节点加入方式：
config.yaml里的Proxy

rule里的有去广告规则，和哪些直连哪些代理，初步预设好。