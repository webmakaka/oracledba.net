---
layout: page
title: Questions asked to candidates for Oracle DBA position at interviews
description: Questions asked to candidates for Oracle DBA position at interviews
keywords: Oracle DataBase, Interview questions
permalink: /database/beginning/questions-on-interview/
---

# Questions asked to candidates for Oracle DBA position at interviews

COLLECTING QUESTIONS!

<h3>Yandex:</h3>

<br/>

Question 1:

<br/><br/>

On the DBMS server, disk space is running out (Linux is used). You found that the lns1 process for some reason started writing very actively to the file <diagnostic*dest>/dbname/sid/trace/<sid>\_lns1*<pid>.trc, causing disk space to run out.
<br/><br/>
How to free up disk space using OS tools (the lns1 process cannot be terminated (normally or via kill))?

<br/>
<br/><br/>
Question 2:
<br/><br/>
Can two stored functions of the same Oracle user have the same names?

<br/>
<br/><br/>
Question 3:
<br/><br/>

Briefly describe the differences in interaction between Oracle DBMS (version 10.2 and later) and Linux OS when using AMM (Automatic Memory Management, starting from version 11.1) and ASMM (Automatic Shared Memory Management), Oracle DBMS and Linux OS 64-bit.

<br/>
<br/><br/>
Question 4:
<br/><br/>

There is an Oracle DB of 7 TB, which among other things stores data in 10 partitioned tables (range partitions, 1 partition — one day) for 3 years. You need to create a partial copy of this DB that would contain data only for the last month. On the server where the DB copy needs to be created, there is not enough space for a full recovery of the original DB.
<br/><br/>
How would you solve this problem?

<br/>
<br/><br/>
Question 5:
<br/><br/>
What is the difference between hash join and nested loops operations in a query execution plan. Which one executes faster, under what conditions?

<br/>
<br/><br/>
Question 6:
<br/><br/>

Given a PL/SQL collection declared as follows:

<br/><br/>

    declare
       type TNumList is varray(10) of number;
       lstN TNumList;
    ...

<br/>

List which of the 5 logical expressions are true regardless of the contents of the lstN variable:

lstN.Limit is not NULL

lstN.First = 1 or lstN.First is NULL

lstN.Trim is NULL

Nvl(lstN.Last,0) = lstN.Count

lstN.Prior(lstN.First) is NULL

<br/>
<br/><br/>
Question 7:
<br/><br/>

How, in a 4-node Real Application Cluster, to make a task launched using dbms_scheduler run on only 1 node when all nodes are available, and on any working node if 1 node is unavailable.
