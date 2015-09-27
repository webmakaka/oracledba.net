#!/bin/csh

sqlplus sys/manager2 as sysdba < wcr_unlock_scott.sql

sqlplus scott/tiger < wcr_demo.sql
