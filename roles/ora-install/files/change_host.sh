#!/bin/bash

##
## Author: Jakit
## Date: 2019/05/08
##

if [[ -e /tmp/oracle_install_change_host.conf ]]; then
	cp /etc/hosts /etc/hosts.bk
	cat /tmp/oracle_install_change_host.conf >> /etc/hosts
fi
