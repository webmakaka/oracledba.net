---
layout: page
title: Schema in Oracle Database
description: Schema in Oracle Database
keywords: Oracle Database, schemas
permalink: /docs/architecture/schemas/basics/
---

# Schema in Oracle Database

The term schema in Oracle Database refers to a created user account and the objects that belong to it (for example, indexes, triggers, stored procedures).

View existing schemas in the database:

    SQL> set pagesize 0;
    SQL> select username from dba_users order by 1;

---

Create a new schema in the database

    SQL> CREATE USER scott IDENTIFIED BY tiger;

Create a new schema with explicit specification of where data and indexes should be stored.

    SQL> CREATE USER scott
    IDENTIFIED BY tiger
    DEFAULT TABLESPACE MY_DATA
    TEMPORARY TABLESPACE MY_TEMP
    ACCOUNT UNLOCK;

Grant the user the ability to connect to the database and work with it

    SQL> grant connect, resource to scott

Delete a schema with the following command:

    SQL> drop user scott cascade;

Unlock a schema with the command:

    SQL> alter user scott account unlock;

And change the password

    SQL> alter user system identified by NewPassword;
