#!/bin/bash

##
## Author: Jakit
## Date: 2019/05/08
##

cd /home/oracle

if [[ -e /tmp/env.txt ]]; then
	cat /tmp/env.txt >> .bash_profile
fi

source .bash_profile
echo "oracle's environmental variables are set OK!"

cd /oracle/soft

unzip -q /oracle/soft/p13390677_112040_Linux-x86-64_1of7.zip
unzip -q /oracle/soft/p13390677_112040_Linux-x86-64_2of7.zip
#su - oracle -c "unzip -q /oracle/soft/p10404530_112030_Linux-x86-64_4of7.zip"
echo "unzip is OK!"

echo "begin installing oracle software......"
echo "when the command is completed, excute the two shell scripts by root, then press enter to finish the installing!"

if [[ -e /tmp/db_install.rsp ]]; then
	cp /tmp/db_install.rsp /home/oracle
fi

# install db
/oracle/soft/database/runInstaller -silent -ignorePrereq -showProgress -responseFile /home/oracle/db_install.rsp

# install client
#su - oracle -c "/home/oracle/client/runInstaller -silent -responseFile /tmp/client_install.rsp"

# timeout_test=$(cat /oracle/app/oracle/oraInventory/logs/installActions*.log | grep "Adding ExitStatus SUCCESS_WITH_WARNINGS to the exit status sets" | wc -l)
# timeout_limit=240
# timeout_count=0

# while [[ $timeout_count < $timeout_limit ]]; do
# 	sleep 5

# 	timeout_test=$(cat /oracle/app/oracle/oraInventory/logs/installActions*.log | grep "Adding ExitStatus SUCCESS_WITH_WARNINGS to the exit status sets" | wc -l)
# 	timeout_count=$((timeout_count + 1))

# 	if [[ $timeout_test == 1 ]]; then
# 		exit
# 	fi
# done

exit
