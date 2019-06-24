#!/bin/bash

##
## Author: Jakit
## Date: 2019/05/08
##

oracle_download_host="http://192.168.5.236/"
oracle_download_part_1="${oracle_download_host}p13390677_112040_Linux-x86-64_1of7.zip"
oracle_download_part_2="${oracle_download_host}p13390677_112040_Linux-x86-64_2of7.zip"

oracle_down="/oracle/soft"
oracle_base_dir="/oracle/app/oracle"
oracle_inventory_dir="${oracle_base_dir}/oraInventory"
oracle_home_dir="/oracle/app/oracle/product/11.2.0/db_1"

if [[ ! -e $oracle_down ]]; then
	mkdir -p $oracle_down
fi

if [[ ! -e $oracle_base_dir ]]; then
	mkdir -p $oracle_base_dir
fi

if [[ ! -e $oracle_home_dir ]]; then
	mkdir -p $oracle_home_dir
fi

cd $oracle_down

wget $oracle_download_part_1
wget $oracle_download_part_2

chkconfig iptables off
echo "firewall closed!"

cat >> /etc/sysctl.conf <<EOF
kernel.shmall = 2097152
kernel.shmmax = 2147483648
kernel.shmmni = 4096
kernel.sem = 250 32000 100 128
fs.file-max = 6815744
fs.aio-max-nr = 1048576
net.ipv4.ip_local_port_range = 9000 65500
net.core.rmem_default=262144
net.core.rmem_max=4194304
net.core.wmem_default=262144
net.core.wmem_max=1048576
EOF

echo 1048576 >/proc/sys/fs/aio-max-nr
/sbin/sysctl -p;
echo "linux kernel parmameters is set!"

cat >> /etc/security/limits.conf <<EOF
*               soft    nproc   2047
*               hard    nproc   16384
*               soft    nofile 1024
*               hard    nofile 65536 
EOF
echo "limits.conf is set!"

cat >> /etc/pam.d/login <<EOF
session    required     /lib/security/pam_limits.so
EOF
echo "login is set!"

# /etc/selinux/config   SELINUX=disabled
# rpm -ivh /oracle/soft/libaio-0.3.96-3.x86_64.rpm
# rpm -ivh /oracle/soft/libaio-devel-0.3.106-3.2.x86_64.rpm
# if [ `rpm -qa | grep libaio-devel` == "libaio-devel-0.3.106-3.2" ]; then
# 	echo "libaio-devel is installed OK!"
# fi

# rpm -ivh /oracle/soft/pdksh-5.2.14-30.x86_64.rpm
# rpm -ivh /oracle/soft/elfutils-libelf-devel-0.152-1.el6.x86_64.rpm


useradd -m oracle

groupadd oinstall
groupadd dba
useradd -g oinstall -G dba oracle
# passwd oracle

mkdir -p $oracle_home_dir
chown -R oracle:oinstall /oracle/
chmod -R 775 $oracle_base_dir
echo "installing directories is set OK!"

if [[ -e /tmp/env.txt ]]; then
	su - oracle -c "cat /tmp/env.txt >> .bash_profile"
fi

su - oracle -c "source .bash_profile"
echo "oracle's environmental variables are set OK!"

su - oracle -c "unzip -q /oracle/soft/p13390677_112040_Linux-x86-64_1of7.zip"
su - oracle -c "unzip -q /oracle/soft/p13390677_112040_Linux-x86-64_2of7.zip"
#su - oracle -c "unzip -q /oracle/soft/p10404530_112030_Linux-x86-64_4of7.zip"
echo "unzip is OK!"

echo "begin installing oracle software......"
echo "when the command is completed, excute the two shell scripts by root, then press enter to finish the installing!"

# install db
su - oracle -c "/home/oracle/database/runInstaller -silent -responseFile /tmp/db_install.rsp"

# install client
#su - oracle -c "/home/oracle/client/runInstaller -silent -responseFile /tmp/client_install.rsp"

sleep 30

exit
