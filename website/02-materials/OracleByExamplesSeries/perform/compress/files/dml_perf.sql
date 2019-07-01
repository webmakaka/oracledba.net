set echo off
set pagesize 2000
set long 10000
set linesize 200
REM
REM
connect sh/sh
set echo on
set timing on
delete from sales_nocompress
/

delete from sales_compress
/

set timing off
select count(*) from sales_nocompress
/
select count(*) from sales_compress
/
