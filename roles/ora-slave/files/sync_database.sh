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

sleep 20

rman target sys/system@pri auxiliary sys/system@std <<EOF
duplicate target database for standby from active database nofilenamecheck;
exit;
EOF

sleep 60

sqlplus -s "/ as sysdba" <<EOF
shutdown immediate;
startup;
alter database recover managed standby database disconnect from session;
exit;
EOF

exit
