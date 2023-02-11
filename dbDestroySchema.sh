#!/bin/bash

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

# Define our function for schema creation
destroy_schema()
{
    # 1. Drop schema tables
    #
    ${ORACLE_HOME}/bin/sqlplus appdba/appdba @${ORACLE_DBSCRIPTS}/ZDBT01L_destroy_stg1.sql

    # 2. Drop Users / Schemas and tablespaces
    #
    appDataDir=${ORACLE_BASE}/oradata/$ORACLE_SID/app01
    if [ -d $appDataDir ]; then
        ${ORACLE_HOME}/bin/sqlplus system/$SYSTEM_PASS @${ORACLE_DBSCRIPTS}/ZDBT01L_destroy_stg2.sql
    fi
}

# Call our function and log output
destroy_schema > $ORACLE_DBSCRIPTS/destroy_schema.log
