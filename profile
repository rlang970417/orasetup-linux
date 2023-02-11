# Add me to the "oracle" user ~/.bash_profile
#    Note : modify hostnames to match your environment

# Oracle Settings
TMP=/tmp; export TMP
TMPDIR=$TMP; export TMPDIR

ORACLE_HOSTNAME=ora19clnx.fakedomain.com; export ORACLE_HOSTNAME
ORACLE_UNQNAME=ora19clnx; export ORACLE_UNQNAME
ORACLE_BASE=/u01; export ORACLE_BASE
ORACLE_HOME=$ORACLE_BASE/app/oracle/product/19.3.0/db_home; export ORACLE_HOME
ORACLE_SID=ZDBT01L; export ORACLE_SID
ORACLE_TERM=xterm; export ORACLE_TERM
PATH=/usr/sbin:$PATH; export PATH
PATH=$ORACLE_HOME/bin:$PATH; export PATH

LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib; export LD_LIBRARY_PATH
CLASSPATH=$ORACLE_HOME/JRE:$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib; export CLASSPATH
