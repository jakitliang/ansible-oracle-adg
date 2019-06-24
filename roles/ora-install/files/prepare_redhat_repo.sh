#!/bin/bash

##
## Author: Jakit
## Date: 2019/05/08
##

# Download and mount iso DVD

# rhel_iso_url=http://localhost/rhel-server-6.5-x86_64-dvd.iso

# wget $rhel_iso_url

# mkdir /dvd

# mount -t iso9660 -o loop rhel-server-6.5-x86_64-dvd.iso /dvd

# tar cvPf /etc/yum.repos.d.tar /etc/yum.repos.d

# rm /etc/yum.repos.d/*

# cat > /etc/yum.repos.d/local.repo <<EOF
# [base]
# name=Red Hat Enterprise Linux \$releasever - \$basearch
# baseurl=file:///dvd
# enabled=1
# gpgcheck=0
# gpgkey=file:///dvd/RPM-GPG-KEY-redhat-release
# cost=500
# EOF

cat > /etc/yum.repos.d/local.repo <<EOF
[base]
name=Red Hat Enterprise Linux \$releasever - \$basearch
baseurl=http://192.168.5.236/dvd
enabled=1
gpgcheck=0
gpgkey=http://192.168.5.236/dvd/RPM-GPG-KEY-redhat-release
cost=500
EOF

# Disable redhat product ID
if [[ -e /etc/yum/pluginconf.d/product-id.conf ]]; then
	sed -i s/enabled=1/enabled=0/g /etc/yum/pluginconf.d/product-id.conf
fi

if [[ -e /etc/yum/pluginconf.d/subscription-manager.conf ]]; then
	sed -i s/enabled=1/enabled=0/g /etc/yum/pluginconf.d/subscription-manager.conf
fi

yum clean all

yum check-update

# yum install -y -q gcc \
# compat-libstdc++-33 \
# elfutils-libelf-devel \
# glibc-devel \
# glibc-headers \
# gcc-c++ \
# libaio-devel \
# libstdc++-devel \
# sysstat \
# compat-libcap1-* \
# make \
# smartmontools

yum install -y -q binutils \
compat-libstdc++-33 \
elfutils-libelf \
elfutils-libelf-devel \
expat \
gcc \
gcc-c++ \
glibc \
glibc-common \
glibc-devel \
glibc-headers \
libaio \
libaio-devel \
libgcc \
libstdc++ \
libstdc++-devel \
make \
sysstat \
unixODBC \
unixODBC-devel

rpm -e ksh
rpm -i /tmp/pdksh-5.2.14-30.x86_64.rpm

# yum install -y pdksh
# yum install -y ksh
