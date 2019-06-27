#!/bin/bash

##
## Author: Jakit
## Date: 2019/05/08
##

lsnrctl stop
lsnrctl start

sleep 20

sqlplus -s "/ as sysdba" <<EOF
create spfile from pfile;
startup nomount;
exit;
EOF

echo "mount ok" >> /tmp/sync_log.log

sleep 30

rman target sys/system@pri auxiliary sys/system@std <<EOF
duplicate target database for standby from active database nofilenamecheck;
exit;
EOF

echo "duplicate ok" >> /tmp/sync_log.log

sleep 120

sqlplus -s "/ as sysdba" <<EOF
shutdown immediate;
startup;
exit;
EOF

echo "restart ok" >> /tmp/sync_log.log

sleep 20

sqlplus -s "/ as sysdba" <<EOF
alter database recover managed standby database disconnect from session;
exit;
EOF

echo "recover ok" >> /tmp/sync_log.log

exit
