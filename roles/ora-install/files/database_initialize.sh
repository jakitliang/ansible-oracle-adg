#!/bin/bash

##
## Author: Jakit
## Date: 2019/05/08
##

su - oracle <<EOF
netca -silent -responseFile /home/oracle/database/response/netca.rsp
lsnrctl start
lsnrctl status
dbca -silent -responseFile /tmp/dbca.rsp
EOF

exit
