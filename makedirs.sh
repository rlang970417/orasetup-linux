#!/bin/bash

# Simple batch script to create the needed directories for our Oracle install
sudo mkdir -p /u01/app/oracle
sudo mkdir -p /u01/app/oracle/product/19.3.0/db_home
sudo mkdir -p /u01/app/oraInventory
sudo mkdir -p /u01/oradata
sudo mkdir -p /u01/recovery_area
sudo mkdir -p /u01/media/db_home
sudo chown -R oracle:oinstall /u01

sudo mkdir -p /etc/oracle
sudo chmod 777 /etc/oracle
sudo chown -R oracle:oinstall /etc/oracle
