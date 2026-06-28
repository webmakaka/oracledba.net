---
layout: page
title: Finding duplicate records in the database (duplicate search)
description: Finding duplicate records in the database (duplicate search)
keywords: Oracle Database, duplicate search
permalink: /docs/architecture/other/poisk-dublikatov/
---

# Finding duplicate records in the database (duplicate search)

```sql
select do, count(*)
from region
group by do
having count(*) > 1;
```

<br/>

See also [here](//plsql.ru/other/interview-questions/plsql/).
