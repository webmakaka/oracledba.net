---
layout: page
title: Sessions to Oracle Database
description: Sessions to Oracle Database
keywords: Oracle Database, Sessions
permalink: /docs/architecture/schemas/sessions/
---

# Sessions to Oracle Database

<h3>List:</h3>

<ul>
    <li><a href="#sessions1">View current database sessions</a></li>
    <li><a href="#sessions2">Find the blocking session</a></li>
    <li><a href="#sessions3">Kill a session</a></li>
    <li><a href="#sessions4">Kill all sessions for one schema</a></li>
    <li><a href="#sessions5">Track which query the application is executing</a></li>
</ul>

<h3><a name="sessions1">View current database sessions</a></h3>

```sql
    SELECT t.SID, t.SERIAL#, t.osuser as "User", t.MACHINE as "PC", t.PROGRAM as "Program"
    FROM v$session t
    --WHERE (NLS_LOWER(t.PROGRAM) = 'cash.exe') -- view sessions from cash.exe program
    --WHERE status='ACTIVE' and osuser!='SYSTEM' -- view user sessions
    --WHERE username = 'schema' -- view sessions for a schema (user)
    ORDER BY 4 ASC;
```

<br/>
<h3><a name="sessions2">Find the blocking session</a></h3>

```sql
SELECT status, SECONDS_IN_WAIT, BLOCKING_SESSION, SEQ#
FROM v$session
WHERE username=upper('scott');
```

<br/>
<h3><a name="sessions3">Kill a session</a></h3>

    ALTER SYSTEM KILL SESSION 'SID,Serial#' IMMEDIATE;

Replace 'SID' and 'Serial#' with the current session values.

<br/>
<h3><a name="sessions4">Kill all sessions for a specific schema</a></h3>

```sql
define USERNAME = "USER_NAME"

begin
    for i in (select SID, SERIAL# from V$SESSION where USERNAME = upper('&&USERNAME')) loop
    execute immediate 'alter system kill session '''||i.SID||','||i.SERIAL#||''' immediate';
    end loop;
end;
/
```

<br/>
<h3><a name="sessions5">Track which query the application is executing</a></h3>

```sql
SELECT PROCESS pid, sess.process, sess.status, sess.username, sess.schemaname, sql.sql_text
FROM v$session sess, v$sql sql
WHERE sql.sql_id(+) = sess.sql_id AND sess.type = 'USER';
```
