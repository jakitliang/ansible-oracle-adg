#!/bin/bash

if [[ -e /tmp/prepare_log.sh ]]; then
	chown oracle:oinstall /tmp/prepare_log.sh
	su - oracle -c "/tmp/prepare_log.sh"
fi
