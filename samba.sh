#!/bin/sh

#zip -r samba.zip samba/
#"-y" to store symbolic links

if [ $# -ne 1 ];then
	echo "Usage: $0 start|stop|restart"
	exit
fi

cd `dirname $0`
pwd

chmod 755 bin/* sbin/*
chmod 777 tmp
source enV

case "$1" in  
restart)  
kill $(cat var/run/*.pid)
sbin/smbd  
sbin/nmbd  
;;  
stop)  
kill $(cat var/run/*.pid)
;;  
start)
sbin/smbd  
sbin/nmbd  
;;  
*)  
echo "Invalid param: $1"  
;;  
esac 

exit 0

#########
#
# SAMBA
# 类似 NFS 是架构在 RPC Server, SAMBA 是架构在 NetBIOS (Network Basic Input/Output System, NetBIOS) 通讯协议上的。
# 早期NetBIOS 在局域网络内无法跨路由 (Router / Gateway), 现在可以通过 NetBIOS over TCP/IP 连接外网；
# 
# nmbd ：用来管理工作组、NetBIOS name 等的解析。主要利用 UDP 协议开启 port 137, 138 来负责名称解析的任务；
# smbd ：用来管理 SAMBA 主机分享的目录、档案与打印机等。 主要利用可靠的 TCP 协议来传输数据，开放的端口为 139 及 445(不一定存在) ;
# 注意SELinux 命令getsebool/setsebool/chcon 和iptables的安全设置
#
# /var/lib/samba/private/{passdb.tdb,secrets.tdb}： 管理 Samba 的用户账号/密码时，会用到的数据库档案；
# /etc/samba/smb.conf： Samba 的主要配置文件; testparm命令可检查配置文档语法, --show-all-parameters 显示可能的参数值
### smb.conf 配置

[global]
# security = share # 与登入密码验证有关的设定, 新版已没有share值

# 语系编码
# unix charset    = utf8
# display charset = utf8
# dos charset     = cp950

# 跟防火墙的有关的IP访问设定
hosts allow = 127. 192.168. 192.168.100.10

# 用于ios的文件访问兼容
vfs objects = acl_xattr catia fruit streams_xattr

# 由不同的身份登入, 可以取得不通的home浏览目录；
[homes]
comment = Home Directories
browseable = no
writable = yes

[mydir]
comment = My Directories
path = /tmp/dir
browseable = yes
read only = no
#或 writable = yes 
#write list = root, os, @lpadmin #用户, @用户组 #当read only =yes, 其他都只读，只有指定用户或组可写,  注意文件夹对应的权限。(在ios客户端试验复制写有漏洞)

[temp]
comment = Temporary file space
path = /tmp
browseable = yes
writable = yes

# 允许anonymous登入
guest ok = yes

### smb.conf 末尾
#

# 常用命令
smbclient -L //192.168.0.215 -U user%pass #命令查看远程samba服务
smbclient //192.168.0.215/temp -U user%pass #登入查看共享自由目录
mount -t cifs //192.168.0.215/temp /mnt -o user=anon,pass= #挂载远程samba目录
pdbedit -vL #查看samba已建的账户信息
pdbedit -a -u user #创建samba账户。只能创建系统存在的账户,如root
pdbedit -x -u user #删除账户user

smbstatus # 查看本机的共享状态
# smbtree # 树状查看网络邻居的共享资源

# smbpasswd user #修改账户密码
# 当与非root的一般用户运行"smbpasswd"修改samba密码时,密码6位数以上, "unix password sync =yes"配置了与Linux的该用户的密码同步；
# 其中，root或sudo运行时不同步，Linux用户修改密码也不与samba用户同步； 

systemctl restart nmbd smbd #重启服务

# Ref: http://cn.linux.vbird.org/linux_server/0370samba.php

