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

sleep 30

rman target sys/system@pri auxiliary sys/system@std <<EOF
duplicate target database for standby from active database nofilenamecheck;
exit;
EOF

sleep 120

sqlplus -s "/ as sysdba" <<EOF
shutdown immediate;
startup;
exit;
EOF

sleep 20

sqlplus -s "/ as sysdba" <<EOF
alter database recover managed standby database disconnect from session;
exit;
EOF

exit
