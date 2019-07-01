#!/bin/ksh

#
# make changes 
#
sqlplus apps/apps << ! > /tmp/demo_make_changes.log
 @ scripts/make_changes.sql
!
