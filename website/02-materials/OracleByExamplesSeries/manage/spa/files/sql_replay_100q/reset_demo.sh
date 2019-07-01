#!/bin/ksh

#
# initialize the demo 
#
sqlplus apps/apps << ! > /tmp/reset_demo.log
 @ scripts/init_demo.sql
!
