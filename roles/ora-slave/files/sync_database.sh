#!/bin/bash

##
## Author: Jakit
## Date: 2019/05/08
##

lsnrctl stop
lsnrctl start

sqlplus -s "/ as sysdba" <<EOF
create spfile from pfile;
startup nomount;
exit;
EOF

rman target sys/system@pri auxiliary sys/system@std <<EOF
shutdown;
startup nomount;
duplicate target database for standby from active database nofilenamecheck;
exit;
EOF

sqlplus -s "/ as sysdba" <<EOF
alter database open;
alter database recover managed standby database disconnect from session;
exit;
EOF

exit
