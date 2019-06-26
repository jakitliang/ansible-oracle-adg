#!/bin/bash

if [[ -e /tmp/create_database.sh ]]; then
	chown oracle:oinstall /tmp/create_database.sh
	su - oracle -c "/tmp/create_database.sh"
fi
