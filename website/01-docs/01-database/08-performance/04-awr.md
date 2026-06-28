---
layout: page
title: Preparing Automatic Workload Repository (AWR) report - Windows - Oracle 10.2
description: Preparing Automatic Workload Repository (AWR) report - Windows - Oracle 10.2
keywords: Oracle Database, Preparing Automatic Workload Repository (AWR) report - Windows - Oracle 10.2
permalink: /database/performance/awr/
---

# Preparing Automatic Workload Repository (AWR) report - Windows - Oracle 10.2

<br/>

Done in 2010

<br/>

**1. Copy files**

<br/>

```
awrrpt.sql
awrrpti.sql
awrinput.sql
awrinpnm.sql
```

<br/>

from the server directory C:\oracle\product\10.2.0\db_1\RDBMS\ADMIN to the local client disk (e.g., to directory C:\AWR)

<br/>

**2. Create a file named connections.sql**

<br/>

```sql
conn system/master@<"ip adress">:1521/<"service name">;

@awrrpt.sql
```

<br/>

**3. Create a file named Run.bat**

<br/>

```sql
chcp 1251

sqlplus /nolog @connections.sql
exit;
```

<br/>

**Result:**

<br/>

![Oracle DBA](/img/database/performance/awr/awr01.png 'Oracle AWR report preparation'){: .center-image }

<br/>

**4. Run run.bat. The program asks in which format to present the information.**

![Oracle DBA](/img/database/performance/awr/awr02.png 'Oracle AWR report preparation'){: .center-image }

<br/>

**5. For which period the information is of interest**

![Oracle DBA](/img/database/performance/awr/awr03.png 'Oracle AWR report preparation'){: .center-image }

<br/>

**6. Start and end snapshot for this period**

![Oracle DBA](/img/database/performance/awr/awr04.png 'Oracle AWR report preparation'){: .center-image }

![Oracle DBA](/img/database/performance/awr/awr05.png 'Oracle AWR report preparation'){: .center-image }

<br/>

**7. Name for the report file being created. In this case report**

![Oracle DBA](/img/database/performance/awr/awr06.png 'Oracle AWR report preparation'){: .center-image }

<br/>

**8. Generated report.LST file. Rename it to report.html and run**

![Oracle DBA](/img/database/performance/awr/awr07.png 'Oracle AWR report preparation'){: .center-image }

<br/>

**9. Report prepared**

![Oracle DBA](/img/database/performance/awr/awr08.png 'Oracle AWR report preparation'){: .center-image }
