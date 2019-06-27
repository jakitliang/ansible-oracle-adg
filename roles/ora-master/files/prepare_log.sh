#!/bin/bash

##
## Author: Jakit
## Date: 2019/05/08
##

lsnrctl stop
lsnrctl start

sleep 20

sqlplus -s "/ as sysdba" <<EOF
shutdown immediate;
create spfile from pfile;
startup mount;
alter database force logging;
alter database archivelog;
alter database open;
alter database add standby logfile group 4 '/oracle/app/oracle/oradata/pri/std_redo04.log' size 50m;
alter database add standby logfile group 5 '/oracle/app/oracle/oradata/pri/std_redo05.log' size 50m;
alter database add standby logfile group 6 '/oracle/app/oracle/oradata/pri/std_redo06.log' size 50m;
alter database add standby logfile group 7 '/oracle/app/oracle/oradata/pri/std_redo07.log' size 50m;
exit;
EOF

sleep 15

exit
