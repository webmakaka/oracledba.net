---
layout: page
title: Collect user session statistics
description: Collect user session statistics
keywords: Oracle Database, Collect user session statistics
permalink: /database/performance/collect-session-statistics/
---

# Collect user session statistics:

That is, get the most complete report on what actions the user performed and how the database responded to these actions.

Show current sessions

```sql
select t.SID, t.SERIAL#, t.osuser as "User", t.MACHINE as "Computer", t.PROGRAM as "Program"
from v$session t
--where (NLS_LOWER(t.PROGRAM) = 'myprogram.exe') -- view sessions from myprogram.exe
--where status='ACTIVE' and osuser!='SYSTEM' -- view user sessions
order by 4 asc;
```

Enable tracing

```sql
begin
dbms_system.set_sql_trace_in_session(sid => 139 , serial# => 40063, sql_trace => true);
end;
```

Disable tracing

```sql
begin
dbms_system.set_sql_trace_in_session(sid => 139 , serial# => 40063, sql_trace => false);
end;
```

Convert the trace file into a human-readable format.

```sql
CMD> tkprof filename.trc filename.txt
```
