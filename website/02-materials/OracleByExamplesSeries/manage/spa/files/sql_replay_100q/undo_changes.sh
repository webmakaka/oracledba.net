#!/bin/ksh

#
# undo changes 
#
sqlplus apps/apps << ! > /tmp/demo_undo_changes.log
 @ scripts/undo_changes.sql
!
