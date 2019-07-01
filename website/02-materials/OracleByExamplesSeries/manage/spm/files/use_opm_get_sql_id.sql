select sql_id
from v$sql
where sql_text like 'select /*USE_OPM*/%';