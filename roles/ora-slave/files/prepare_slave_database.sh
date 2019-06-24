#!/bin/bash

##
## Author: Jakit
## Date: 2019/05/08
##

mkdir -p /oracle/app/oracle/admin/std/adump
mkdir -p /oracle/app/oracle/diag/rdbms/std/std/trace
mkdir -p /oracle/app/oracle/arch
mkdir -p /oracle/app/oracle/oradata/std
mkdir -p /oracle/app/oracle/oradata/standbylog
mkdir -p /oracle/app/oracle/flash_recovery_area

cp /tmp/listener.ora /oracle/app/oracle/product/11.2.0/db_1/network/admin/
cp /tmp/tnsnames.ora /oracle/app/oracle/product/11.2.0/db_1/network/admin/
cp /tmp/initstd.ora /oracle/app/oracle/product/11.2.0/db_1/dbs
cp /tmp/orapwstd /oracle/app/oracle/product/11.2.0/db_1/dbs

# Wait for master ready
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
