#!/bin/bash

##
## Author: Jakit
## Date: 2019/05/08
##

mkdir -p /u01/app/oracle/admin/std/adump
mkdir -p /u01/app/oracle/diag/rdbms/std/std/trace
mkdir -p /u01/app/oracle/arch
mkdir -p /u01/app/oracle/oradata/std
mkdir -p /u01/app/oracle/oradata/standbylog
mkdir -p /u01/app/oracle/flash_recovery_area

cp /tmp/listener.ora /u01/app/oracle/product/11.2.0/db_1/network/admin/
cp /tmp/tnsnames.ora /u01/app/oracle/product/11.2.0/db_1/network/admin/
cp /tmp/initstd.ora /u01/app/oracle/product/11.2.0/db_1/dbs
cp /tmp/orapwstd /u01/app/oracle/product/11.2.0/db_1/dbs

sleep 300

su - oracle

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

exit
