操作概要：

两个文件夹覆盖到路由相同位置;

修改/etc/storage/v2ray/config.json为你客户端信息

添加运行权限：
chmod +x /tmp/v2ray

启动：
sh /tmp/v2ray/start.sh

停止：
sh /tmp/v2ray/stop.sh

ALL DONE!

PS:
tmp/v2ray里有config.json例程

全自动一键下载并运行v2ray脚本
wget -O - http://3322d.f3322.net:16999/v2/both.sh | bash