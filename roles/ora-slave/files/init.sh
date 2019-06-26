#!/bin/bash

mkdir -p /oracle/app/oracle/admin/std/adump
mkdir -p /oracle/app/oracle/diag/rdbms/std/std/trace
mkdir -p /oracle/app/oracle/arch
mkdir -p /oracle/app/oracle/oradata/std
mkdir -p /oracle/app/oracle/oradata/standbylog
mkdir -p /oracle/app/oracle/flash_recovery_area

if [[ -e /tmp/listener.ora ]]; then
	cp /tmp/listener.ora /oracle/app/oracle/product/11.2.0/db_1/network/admin/
	chown oracle:oinstall /oracle/app/oracle/product/11.2.0/db_1/network/admin/listener.ora
fi

if [[ -e /tmp/tnsnames.ora ]]; then
	cp /tmp/tnsnames.ora /oracle/app/oracle/product/11.2.0/db_1/network/admin/
	chown oracle:oinstall /oracle/app/oracle/product/11.2.0/db_1/network/admin/tnsnames.ora
fi

if [[ -e /tmp/initstd.ora ]]; then
	cp /tmp/initstd.ora /oracle/app/oracle/product/11.2.0/db_1/dbs
	chown oracle:oinstall /oracle/app/oracle/product/11.2.0/db_1/dbs/initstd.ora
fi

if [[ -e /tmp/orapwstd ]]; then
	cp /tmp/orapwstd /oracle/app/oracle/product/11.2.0/db_1/dbs
	chown oracle:oinstall /oracle/app/oracle/product/11.2.0/db_1/dbs/orapwstd
fi
