---
layout: page
title: FlashBack queries
description: FlashBack queries
keywords: Oracle Database, FlashBack queries
permalink: /docs/architecture/restore-files-and-data/flashback-queries/
---

# FlashBack queries

If a user has committed changes, you can execute flashback queries to find out the values that existed before the change (and then modify the data, restoring their old values)

    SQL> SELECT salate FROM employees
    AS OF TIMESTAMP (SYSTIMESTAMP-INTERVAL'10' minute)
    WHERE employee_id=100;

If someone recently mistakenly changed an employee's salary, you can restore the old value by executing an UPDATE command with a subquery that returns the previously stored salary value.

    SQL> UPDATE employees SET salary =
    (SELECT salary FROM employees
    AS OF TIMESTAMP TO_TIMESTAMP
    ('2005-05-04 11:00:00', 'yyyy-mm-dd hh24:mi:ss')
    WHERE employee_id = 200)
