#!/bin/bash

if [[ -e /tmp/listener.ora ]]; then
	cp /tmp/listener.ora /oracle/app/oracle/product/11.2.0/db_1/network/admin/
	chown oracle:oinstall /oracle/app/oracle/product/11.2.0/db_1/network/admin/listener.ora
fi

if [[ -e /tmp/tnsnames.ora ]]; then
	cp /tmp/tnsnames.ora /oracle/app/oracle/product/11.2.0/db_1/network/admin/
	chown oracle:oinstall /oracle/app/oracle/product/11.2.0/db_1/network/admin/tnsnames.ora
fi

if [[ -e /tmp/initpri.ora ]]; then
	cp /tmp/initpri.ora /oracle/app/oracle/product/11.2.0/db_1/dbs
	chown oracle:oinstall /oracle/app/oracle/product/11.2.0/db_1/dbs/initpri.ora
fi
