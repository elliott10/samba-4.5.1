#!/bin/sh

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
