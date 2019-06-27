#!/bin/bash

##
## Author: Jakit
## Date: 2019/05/08
##

lsnrctl stop
lsnrctl start

sleep 5

sqlplus -s "/ as sysdba" <<EOF
create spfile from pfile;
startup nomount;
exit;
EOF

echo "mount ok" >> /tmp/sync_log.log

sleep 5

rman target sys/system@pri auxiliary sys/system@std <<EOF
duplicate target database for standby from active database nofilenamecheck;
exit;
EOF

echo "duplicate ok" >> /tmp/sync_log.log

sleep 30

sqlplus -s "/ as sysdba" <<EOF
alter database recover managed standby database disconnect from session;
exit;
EOF

# sqlplus -s "/ as sysdba" <<EOF
# alter database recover managed standby database cancel;
# alter database open read only;
# alter database recover managed standby database disconnect from session;
# exit;
# EOF

echo "recover ok" >> /tmp/sync_log.log

sleep 5

sqlplus -s "/ as sysdba" <<EOF
shutdown immediate;
exit;
EOF

sleep 5

sqlplus -s "/ as sysdba" <<EOF
startup;
exit;
EOF

echo "restart ok" >> /tmp/sync_log.log

exit
