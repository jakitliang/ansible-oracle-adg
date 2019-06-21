#!/bin/bash

##
## Author: Jakit
## Date: 2019/05/08
##

/u01/app/oracle/oraInventory/orainstRoot.sh
/u01/app/oracle/product/11.2.0/db_1/root.sh

cp /tmp/listener.ora /u01/app/oracle/product/11.2.0/db_1/network/admin/
cp /tmp/tnsnames.ora /u01/app/oracle/product/11.2.0/db_1/network/admin/
cp /tmp/initpri.ora /u01/app/oracle/product/11.2.0/db_1/dbs

su - oracle

lsnrctl stop
lsnrctl start

sqlplus -s "/ as sysdba" <<EOF
shutdown immediate;
create spfile from pfile;
startup mount;
alter database force logging;
alter database archivelog;
alter database open;
alter database add standby logfile group 4 '/u01/app/oracle/oradata/pri/std_redo04.log' size 50m;
alter database add standby logfile group 5 '/u01/app/oracle/oradata/pri/std_redo05.log' size 50m;
alter database add standby logfile group 6 '/u01/app/oracle/oradata/pri/std_redo06.log' size 50m;
alter database add standby logfile group 7 '/u01/app/oracle/oradata/pri/std_redo07.log' size 50m;
exit;
EOF

exit
