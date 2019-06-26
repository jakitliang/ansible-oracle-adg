#!/bin/bash

##
## Author: Jakit
## Date: 2019/06/25
##

netca -silent -responseFile /oracle/soft/database/response/netca.rsp

echo "Setting netca"

lsnrctl start

lsnrctl status

echo "restart listener ok"

if [[ /tmp/dbca.rsp ]]; then
	cp /tmp/dbca.rsp /home/oracle
fi

dbca -silent -responseFile /home/oracle/dbca.rsp

echo "database init finish"

exit
