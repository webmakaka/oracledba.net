#!/bin/ksh

#
# create apps user and give it the dba privs.
#
sqlplus / as sysdba << ! > /tmp/create_apps_user.log

 -- grant dba to scott
 grant dba to scott; 

 --  create new user apps
 @ scripts/create_apps_user.sql

!

#
# import gfk schema and database into APPS user
#
imp apps/apps file=scripts/tmandwh.dmp full=yes commit=yes buffer=1000000

#
# import gfk schema and database into SCOTT user
#
imp scott/tiger file=scripts/tmandwh.dmp full=yes commit=yes buffer=1000000

#
# create some apps new tables.
#

sqlplus / as sysdba << ! > /tmp/create_apps_newtables.log

 @ scripts/create_apps_new_tables.sql

!

#
# initialize demo
#
sqlplus apps/apps << ! > /tmp/setup_reset_demo.log
 @ scripts/init_demo.sql

!


