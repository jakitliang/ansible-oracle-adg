#!/bin/bash

##
## Author: Jakit
## Date: 2019/06/25
##

if [[ -e /tmp/install.sh ]]; then
	sudo chown oracle:oinstall /tmp/install.sh
	su - oracle -c "bash /tmp/install.sh"
fi
