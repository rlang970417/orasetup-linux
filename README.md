# oraSetupScripts - Automated Oracle Installation
A series of shell scripts that perform a silent install of Oracle 19c Enterprise and setup a working schema on Oracle Linux 8.x.

# User Guide

## 1. Configure networking for your node. Example below. Note : Best done as true "root"
### Note : Adjust hostnames and IP addr to match your environment

sudo echo "HOSTNAME=ora19clnx.fakedomain.com" >> /etc/sysconfig/network
sudo hostnamectl set-hostname ora19clnx.fakedomain.com
sudo echo "192.168.1.195   ora19clnx        ora19clnx.fakedomain.com" >> /etc/hosts
sudo nmcli connection reload
sudo nmcli con up `nmcli c s |head -2 |awk '{print $1}' |tail -1`

## 2. Deploy Oracle preinstall package
### Note : This is specific to Oracle Linux 8 environments. Performs kernel tuning and user creation
sudo dnf install -y oracle-database-preinstall-19c
sudo yum update -y

## 3. Configure kernel for RHEL, CentOS, SLES. Example below is node with 2 CPU / 12GB DRAM
### Note : Not needed if installing "oracle-database-preinstall-19c"
sudo vi /etc/sysctl.d/99-sysctl.conf

[//]: # (Defaults for RHEL 8 & SLES 15. More than required by SAP, Oracle, Db2.)
[//]: # (https://bugzilla.redhat.com/show_bug.cgi?id=1701394)
fs.file-max = 8589934592 # This number is large and arbitrary = (DRAM / 2)
kernel.sem = 32000 1024000000 500 32000
kernel.shmall = 8589934592
kernel.shmmax = 12884901888
kernel.shmmni = 4096
vm.swappiness=5

[//]: # (Defaults for SLES 15 are "212992". Modified per IBM docs)
[//]: # (REF : https://www.ibm.com/docs/de/smpi/10.2?topic=mpi-tuning-your-linux-system)
net.ipv4.conf.all.arp_ignore = 1
net.ipv4.conf.all.arp_filter = 1
net.core.rmem_default = 524288
net.core.rmem_max = 524288
net.core.wmem_default = 524288
net.core.wmem_max = 524288
[//]: # (https://ma.ttias.be/linux-increase-ip_local_port_range-tcp-port-range/)
net.ipv4.ip_local_port_range = 9000 65500

[//]: # (Reboot and verify settings)
[//]: # (REF : https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/5/html/tuning_and_optimizing_red_hat_enterprise_linux_for_oracle_9i_and_10g_databases/sect-oracle_9i_and_10g_tuning_guide-pre_installation_preparation_and_verification-verifying_kernel_parameters)
	

## 4. Configure user management. Example below
### Note : Group / User part is not needed if installing "oracle-database-preinstall-19c"
sudo groupadd -g 2001 oinstall
sudo groupadd -g 2002 dba
sudo useradd -c "Oracle software owner" -u 2001 -g oinstall -G dba oracle
sudo passwd oracle

## 5. Update "~/.bash_profile" for the oracle user
sudo su - oracle
cat ${ORACLE_DBSCRIPTS}/profile >> ~/.bash_profile
exit

## 6. Install package pre-Reqs for Oracle DB
sudo dnf -y install binutils gcc gcc-c++ glibc glibc-common glibc-devel glibc-headers ksh libaio libaio-devel libstdc++ libstdc++-devel
sudo dnf -y install unixODBC unixODBC-devel libXi libXtst make sysstat libnsl

## 7. Download Repo and build out directory structure
cd /u01/media
git clone https://github.com/rlang970417/orasetup-linux.git
cd /u01/media/orasetup-linux
./makedirs.sh

## 8. Extract media and move to $ORACLE_HOME
### Note : Perform these tasks as the "oracle" user
*** Deploy downloaded Oracle media archive at the following : /u01/media/LINUX.X64_193000_db_home.zip ***
cd /u01/media
mkdir ./db_home && cd ./db_home
unzip ../LINUX.X64_193000_db_home.zip
cd ..
mv ./db_home/ /u01/app/oracle/product/19.3.0

## 9. Run a silent install of Oracle
### Note : Perform these tasks as the "oracle" user
### Note : Oracle user needs "sudo" access and will be prompted for password during install
sudo su - oracle
cd /u01/media/orasetup-linux
./install19c.sh
exit

## 10. Add a SystemD Startup Script if not already deployed
sudo vi /usr/lib/systemd/system/oradb.service

[Unit]
Description=Oracle Database Service
Requires=rpc-statd.service network.target local-fs.target remote-fs.target
After=syslog.target network.target nfs.service nfs-mountd.service local-fs.target rpc-statd.service remote-fs.target

[Service]
#set any limits here
LimitMEMLOCK=infinity
LimitNOFILE=65535

Type=idle
RemainAfterExit=yes
User=oracle
Group=oinstall
Restart=no
Environment=ORACLE_HOME=/u01/app/oracle/product/19.3.0/db_home
Environment=ORACLE_SID=ZDBT01L
ExecStart=/bin/bash -c '${ORACLE_HOME}/bin/dbstart $ORACLE_HOME'
ExecStop=/bin/bash -c '${ORACLE_HOME}/bin/dbshut $ORACLE_HOME'

## 11. Enable the Oracle Database SystemD service
sudo systemctl enable oradb.service

## 1x. Final Tips and Advice
If you see the errors "TNS-12541: TNS:no listener, TNS-12560: TNS:protocol adapter error, TNS-00511: No listener" 
during the DBCA portion of the install, manually update the following files from another shell.
I ran into these issues due to the variables ORACLE_HOSTNAME and ORACLE_SID being set wrong in ~/.bash_profile

/u01/app/oracle/product/19.3.0/db_home/network/admin/listener.ora
/u01/app/oracle/product/19.3.0/db_home/network/admin/tnsnames.ora