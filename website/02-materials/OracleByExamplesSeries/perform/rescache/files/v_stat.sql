--- v_stat.sql

--- Query v$result_cache_statistics

connect / as sysdba

col name format a55

select *
from v$result_cache_statistics
/
