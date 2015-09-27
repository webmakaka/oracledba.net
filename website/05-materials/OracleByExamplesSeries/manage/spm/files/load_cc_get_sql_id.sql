select sql_id
from v$sql
where sql_text like 'select /*LOAD_CC*/%';