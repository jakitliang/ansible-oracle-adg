#!/bin/bash

##
## Author: Jakit
## Date: 2019/05/08
##

if [[ -e /etc/hosts.bk ]]; then
	cp -f /etc/hosts.bk /etc/hosts
fi

if [[ -e /tmp/hosts ]]; then
	cp -f /etc/hosts /etc/hosts.bk
	cat /tmp/hosts >> /etc/hosts
fi
