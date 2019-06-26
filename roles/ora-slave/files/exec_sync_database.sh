#!/bin/bash

if [[ -e /tmp/sync_database.sh ]]; then
	chown oracle:oinstall /tmp/sync_database.sh
	su - oracle -c "bash /tmp/sync_database.sh"
fi
