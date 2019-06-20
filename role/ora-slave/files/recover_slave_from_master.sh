#!/bin/bash

sqlplus -s "/ as sysdba" <<EOF
alter database open;
alter database recover managed standby database disconnect from session;
exit;
EOF
