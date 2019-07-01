set echo on
set pagesize 2000
set long 10000
set linesize 200
REM
REM
connect sh/sh
drop table sales_nocompress purge
/
drop table sales_compress purge
/
set echo on
set timing on
create table sales_nocompress
as select * from sales
/

create table sales_compress compress for all operations
as select * from sales where 1=0
/

select count(*)
from sales_compress
/

@oltp_insert

set timing off
select count(*) from sales_compress
/
select count(*) from sales_nocompress
/
