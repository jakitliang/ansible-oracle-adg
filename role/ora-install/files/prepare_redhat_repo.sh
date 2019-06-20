#!/bin/bash

rhel_iso_url=http://localhost/rhel-server-6.5-x86_64-dvd.iso

wget $rhel_iso_url

mkdir /dvd

mount -t iso9660 -o loop rhel-server-6.5-x86_64-dvd.iso /dvd

tar cvf /etc/yum.repos.d.tar /etc/yum.repos.d

rm /etc/yum.repos.d/*

cat > /etc/yum.repos.d/local.repo <<EOF
[base]
name=Red Hat Enterprise Linux \$releasever - \$basearch
baseurl=file:///dvd
enabled=1
gpgcheck=0
gpgkey=file:///dvd/RPM-GPG-KEY-redhat-release
cost=500
EOF

# Disable redhat product ID
sed -i s/enabled=1/enabled=0/g /etc/yum/pluginconf.d/product-id.conf
sed -i s/enabled=1/enabled=0/g /etc/yum/pluginconf.d/subscription-manager.conf

yum install -y gcc \
compat-libstdc++-33 \
elfutils-libelf-devel \
glibc-devel \
glibc-headers \
gcc-c++ \
libaio-devel \
libstdc++-devel \
pdksh \
sysstat \
compat-libcap1-* \
ksh \
smartmontools

