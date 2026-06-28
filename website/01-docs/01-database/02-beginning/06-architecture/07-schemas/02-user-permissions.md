---
layout: page
title: Managing access to Oracle Database
description: Managing access to Oracle Database
keywords: Oracle Database, Access management
permalink: /docs/architecture/schemas/user-permissions/
---

# Managing access to Oracle Database:

Privileges are the right to perform a specific type of SQL statement or to access a database object belonging to another user. In Oracle Database, you must explicitly grant a user privileges to perform any actions, including connecting to the database or selecting, modifying, and updating data in any table except their own.

There are two main types of Oracle privileges: system privileges and object privileges. The GRANT statement is used to grant users both system and object privileges.

<br/>
<h3> System privileges: </h3>

System privileges allow a user to perform a specific action in the database or an action on any schema object of a specific type. A good example of the first type of system privilege is the privilege that allows connecting to the database, called the CONNECT privilege. Other privileges of this type are CREATE TABLESPACE, CREATE USER, DROP USER, and ALTER USER.

The second class of system privileges grants users the right to perform operations that affect objects in any schema. Examples of this type of system privilege include ANALYZE ANY TABLE, GRANT ANY PRIVILEGE, INSERT ANY TABLE, DELETE ANY TABLE, etc. System privileges are very powerful and granting them to the wrong user can have a devastating impact on the database.

Below are some of the most commonly used Oracle database privileges:

<ul>
<li> ADVISOR</li>
<li> ALTER DATABASE</li>
<li> ALTER SYSTEM</li>
<li> AUDIT SYSTEM</li>
<li> CREATE DATABASE LINK</li>
<li> CREATE TABLE</li>
<li> CREATE ANY INDEX</li>
<li> CREATE SESSION</li>
<li> CREATE TABLESPACE</li>
<li> CREATE USER</li>
<li> DROP USER</li>
<li> INSERT ANY TABLE</li>
</ul>

<strong>Example: </strong><br/>

    GRANT CREATE SESSION TO scott;

<br/>
<h3> Object privileges: </h3>

Object privileges are privileges related to various types of database objects. Object privileges give a user the ability to perform actions on a specific table, view, materialized view, sequence, procedure, function, or package. Consequently, all database users need object privileges.

The following SQL statements can be used to grant object privileges.

<ul>
<li> ALTER </li>
<li> SELECT </li>
<li> DELETE</li>
<li> EXECUTE</li>
<li> INSERT</li>
<li> REFERENCES</li>
<li> INDEX</li>
</ul>

<strong>Example: </strong>

    GRANT SELECT, UPDATE
    ON table_name TO scott;

<br/>
<h3>Main user privilege views:</h3>

<pre>
ROLE_SYS_PRIVS - System privileges granted to roles.
ROLE_TAB_PRIVS - Table privileges granted to roles.
USER_ROLE_PRIVS - Roles available to the user.
USER_TAB_PRIVS_MADE - Object privileges that the user granted on their objects.
USER_TAB_PRIVS_RECD - Object privileges granted to the user.
USER_COL_PRIVS_MADE - Object privileges that the user granted on columns of their objects.
USER_COL_PRIVS_RECD - Object privileges granted to the user on columns of other users' objects.
USER_SYS_PRIVS - List of system privileges granted to the user.
</pre>

<br/>
<h2>Get a list of all roles, system and object privileges of a user. (Run under the user's account)</h2>

<h3>Method 1:</h3>

    SET feedback off
    SET serveroutput ON

    BEGIN
      dbms_output.enable(100000);
      dbms_output.put_line('-- Fetching roles');
      FOR i IN (SELECT username, granted_role FROM user_role_privs) LOOP
        dbms_output.put_line('grant '||i.granted_role||' to '||i.username||';');
      END LOOP;
      dbms_output.put_line('-- Fetching system privileges');
      FOR i IN (SELECT username, privilege FROM user_sys_privs) LOOP
        dbms_output.put_line('grant '||i.privilege||' to '||i.username||';');
      END LOOP;
      dbms_output.put_line('-- Fetching object privileges');
      FOR i IN (SELECT grantee, owner, table_name, privilege FROM user_tab_privs) LOOP
        dbms_output.put_line('grant '||i.privilege||' on '||i.owner||'.'||i.table_name||' to '||i.grantee||';');
      END LOOP;
    END;
    /

<br/><br/>
<strong>Result:</strong>

    grant UNLIMITED TABLESPACE to PLSQL_PROJECT;
    grant CREATE SESSION to PLSQL_PROJECT;
    grant CREATE TABLE to PLSQL_PROJECT;

<h3>Method 2:</h3>

Our task is get all privileges granted for user and create report based on this information. As you know privileges gives on user directly or on his role. Privileges divided by 2 part: system and object.

Let see example, create report for user Scott

<strong>1.Create repository table for store data:</strong>

    create table vm_user_privs(privilege varchar2(100),user_name varchar2(100),object_name varchar2(100));

<strong>2. Main script:</strong>

    declare
    cursor c_user is
    select distinct(a.username) from dba_users a
    where a.username='SCOTT';
    p_user varchar2(100);

    begin
    open c_user;
    loop
    fetch c_user into p_user;
    insert into vm_user_privs
    select /*+ rule */ a.privilege,p_user,a.table_name from dba_tab_privs a where a.grantee=p_user
    union all
    select /*+rule */ b.privilege,p_user,b.table_name from dba_tab_privs b where b.grantee in (select b1.granted_role from dba_role_privs b1 where b1.grantee=p_user)
    union all
    select /*+ rule */ c.privilege,p_user,null from dba_sys_privs c where c.grantee=p_user
    union all
    select /*+rule */ d.privilege,p_user,null from dba_sys_privs d where d.grantee in (select b2.granted_role from dba_role_privs b2 where b2.grantee=p_user);
    commit;
    EXIT WHEN c_user%NOTFOUND;
    end loop;
    close c_user;
    end;

<strong>3. See result:</strong>

    select * from vm_user_privs

Thank's to<br/>
http://ocp.community.ge/post/Script-generate-all-user-privileges-in-one-report.aspx
