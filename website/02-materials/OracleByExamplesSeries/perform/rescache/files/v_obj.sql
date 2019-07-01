--- v_obj.sql

--- Query v$result_cache_objects

connect / as sysdba

col name format a55

select type, namespace,status, scan_count,name
from v$result_cache_objects
/
