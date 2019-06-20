#!/bin/bash

su - oracle <<EOF
netca -silent -responseFile /home/oracle/database/response/netca.rsp
lsnrctl start
lsnrctl status
dbca -silent -responseFile /tmp/dbca.rsp
EOF

exit 1
