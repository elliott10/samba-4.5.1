#!/bin/sh

if [ $# -ne 2 ];then
	echo "Usage: $0 user password"
	exit
fi

cd `dirname $0`
pwd

chmod 755 bin/* sbin/*
source enV

newUser=$1
newPassword=$2

bin/smbpasswd -a $newUser << EOF
$newPassword
$newPassword
EOF
