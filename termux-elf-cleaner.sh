#!/bin/bash
# elf cleaner: https://github.com/termux/termux-elf-cleaner.git

elfCl="/home/os/dl/termux-elf-cleaner/termux-elf-cleaner"
sambaDir="/data/data/samba"

toCD="
bin
sbin
lib
lib/private
"

for i in $toCD
do
	cd $sambaDir/$i
	pwd

	for j in `ls`
	do
		$elfCl $j
	done
done
