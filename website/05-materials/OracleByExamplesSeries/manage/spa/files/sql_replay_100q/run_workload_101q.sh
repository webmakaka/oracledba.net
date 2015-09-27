#!/bin/ksh
PRG=`basename $0`

usage()
{
  echo
  echo $1
  echo
  echo "  Usage: $PRG <execution#>"
  echo
  exit 1
}


#
# Ensure that number of executions
#
if [ "$1" = "" ]; then
  usage "Syntax error: number of time to execute queries must be specified"
fi

#
# Get executions
#
EXEC_MAX=$1
EXEC_CNT=0
echo "exec_cnt    : " $EXEC_CNT 
echo "exec_max    : " $EXEC_MAX 

#
# flush the shared pool
#
sqlplus apps/apps << ! > /tmp/demo_flush_shared_pool.log
  alter system flush shared_pool;
  alter system flush shared_pool;
  alter system flush shared_pool;
!


echo "workload started ..." 
#
# run the workload
#
while [ $EXEC_MAX -gt $EXEC_CNT ]; do

 sqlplus apps/apps << ! > /tmp/demo_run_queries_100q.log
   @ scripts/run_queries_101q.sql;
!

 let EXEC_CNT="EXEC_CNT+1"
 echo "exec_count    : " $EXEC_CNT 

done

echo "workload finished ..." 
