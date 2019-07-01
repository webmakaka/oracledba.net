set echo off
set pagesize 2000
set long 10000
set linesize 200
set feedback on

REM
REM

set echo on

select segment_name, sum(bytes)/1024/1024 mb
from dba_segments
where owner = user
and segment_name in ('SALES_COMPRESS','SALES_NOCOMPRESS')
group by segment_name
order by segment_name
/

select table_name,compression,compress_for from user_tables where table_name like '%COMPRESS%';

