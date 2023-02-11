#!/bin/bash
#
#   Script : install19c.sh
#	USAGE : ${SCRIPT}
#	ARGS : None
#	DESC : This script performs a silent install of Oracle 19C via response file.
#

# Verify the script is being executed as "oracle"
if [ "$(whoami)" != "oracle" ]; then
    printf "This script must be run as oracle. \n"
    exit 1
fi

# Set our environment variables
export ORACLE_BASE=/u01
export ORACLE_HOME=${ORACLE_BASE}/app/oracle/product/19.3.0/db_home
export ORACLE_SID=ZDBT01L
export SYSTEM_PASS="OrA_Sup3r_Pa55"
export ORACLE_DBSCRIPTS=`pwd`
export CV_ASSUME_DISTID="OEL7.6"

${ORACLE_HOME}/runInstaller -silent -force -responseFile ${ORACLE_DBSCRIPTS}/ZDBT01L-19C.rsp && \
${ORACLE_HOME}/runInstaller -executeConfigTools -responseFile ${ORACLE_DBSCRIPTS}/ZDBT01L-19C.rsp -silent
