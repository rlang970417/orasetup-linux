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
create_schema()
{
    # 1. Create User / Schema for our DB
    #
    ${ORACLE_HOME}/bin/sqlplus system/$SYSTEM_PASS @${ORACLE_DBSCRIPTS}/ZDBT01L_tbl_usr.sql

    # 2. Create APP01 Tables
    #
    ${ORACLE_HOME}/bin/sqlplus appdba/appdba @${ORACLE_DBSCRIPTS}/ZDBT01L_create_app01_db.sql

    # 3. Load Data into APP01 Tables
    #
    ${ORACLE_HOME}/bin/sqlplus appdba/appdba @${ORACLE_DBSCRIPTS}/ZDBT01L_load_app01_db.sql

    # 4. Grant permissions for our DB
    #
    ${ORACLE_HOME}/bin/sqlplus appdba/appdba @${ORACLE_DBSCRIPTS}/ZDBT01L_grant_app01_db.sql
}

# Create Directory for our data files if not already there
appDataDir=${ORACLE_BASE}/oradata/$ORACLE_SID/app01
if [ ! -d $appDataDir ]; then
    mkdir $appDataDir
fi

# Call our function and log output
create_schema > $ORACLE_DBSCRIPTS/create_schema.log
