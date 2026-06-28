---
layout: page
title: Oracle Database - Database Incarnations
description: Oracle Database - Database Incarnations
keywords: Oracle Database, change db_unique_name in RMAN catalog
permalink: /database/backup-and-restore/rman/rman-incarnations-sample/
---

# Oracle Database - Database Incarnations

    $ rman target / catalog rman/rman123@rman12

A new incarnation is created during incomplete database recovery, when the database is opened with the resetlogs option. That is, data from redologs is deleted. The database starts a new life, so to speak. The history of the database's lives can be viewed in the following ways.

    RMAN> LIST INCARNATION OF DATABASE;


    List of Database Incarnations
    DB Key  Inc Key DB Name  DB ID            STATUS  Reset SCN  Reset Time
    ------- ------- -------- ---------------- --- ---------- ----------
    1       16      ORCL12   3487575625       PARENT  1          07/07/2014 05:38:47
    1       2       ORCL12   3487575625       CURRENT 1594143    16/08/2015 21:29:45

<br/>

        SQL> select incarnation#, resetlogs_change# from v$database_incarnation;

        INCARNATION# RESETLOGS_CHANGE#
        ------------ -----------------
       		   1		     1
       		   2	       1594143

In general, the point of incarnations is that the database rolls back to some state in the past and from that state a new life begins. Like snapshots on virtual machines, when you roll back to one state, then to another. The result is some kind of tree with different branches. How often is this used in databases? Not often. Well, think about it yourself, how can you do any rollbacks on a production database and work from some point? There must be serious reasons for this. I saw it once or twice long ago when an archive log was lost and the database required recovery. So they rolled back to the state preceding that archivelog and created an incarnation. But, as I see it, these were all crutches because they didn't prepare a server with additional redundancy. And they did it solely to avoid losing the entire database.

<br/>

    RMAN> backup database;

<br/>

    SQL> create table test as select * from all_objects;

<br/>

    SQL> select count(1) from test;

      COUNT(1)
    ----------
         89402

<br/>

     SQL> select current_scn from v$database;

     CURRENT_SCN
     -----------
         1891044

<br/>

    SQL> delete from test;

<br/>

    SQL> commit;

<br/>

    SQL> select current_scn from v$database;

    CURRENT_SCN
    -----------
        1891093

<br/>

    SQL> drop table test;

<br/>

    SQL> select current_scn from v$database;

    CURRENT_SCN
    -----------
    1891136

<br/>

    SQL> alter system switch logfile;

<br/>

    SQL> select incarnation#, resetlogs_change# from v$database_incarnation;

    INCARNATION# RESETLOGS_CHANGE#
    ------------ -----------------
       1		     1
       2	       1594143

<br/>

Recovery to a specific scn in the past

    SQL> shutdow immediate;
    SQL> startup mount;

<br/>

    $ rman target / catalog rman/rman123@rman12

<br/>

    Recovery to a point before the deletion of the test table.
    That is, the table should be restored, but there should be no data in it.

    RUN {
        set until scn=1891093;
        restore database;
        recover database;
    }

<br/>

    SQL> select status from v$instance;

    STATUS
    ------------
    MOUNTED

<br/>

    SQL> alter database open resetlogs;

<br/>

    SQL> desc test;
     Name					   Null?    Type
     ----------------------------------------- -------- ----------------------------
     OWNER					   NOT NULL VARCHAR2(128)
     OBJECT_NAME				   NOT NULL VARCHAR2(128)
     SUBOBJECT_NAME 				    VARCHAR2(128)
     OBJECT_ID				   NOT NULL NUMBER
     DATA_OBJECT_ID 				    NUMBER
     OBJECT_TYPE					    VARCHAR2(23)
     CREATED				   NOT NULL DATE
     LAST_DDL_TIME				   NOT NULL DATE
     TIMESTAMP					    VARCHAR2(19)
     STATUS 					    VARCHAR2(7)
     TEMPORARY					    VARCHAR2(1)
     GENERATED					    VARCHAR2(1)
     SECONDARY					    VARCHAR2(1)
     NAMESPACE				   NOT NULL NUMBER
     EDITION_NAME					    VARCHAR2(128)
     SHARING					    VARCHAR2(13)
     EDITIONABLE					    VARCHAR2(1)
     ORACLE_MAINTAINED				    VARCHAR2(1)

<br/>

    SQL> select count(1) from test;

      COUNT(1)
    ----------
     	 0

<br/>

Now rollback to the point before the data was deleted from the table.

    RUN {
        set until scn=1891044;
        restore database;
        recover database;
    }

<br/>

    executing command: SET until clause
    new incarnation of database registered in recovery catalog
    starting full resync of recovery catalog
    full resync complete

    Starting restore at 18/08/2015 08:31:19
    RMAN-00571: ===========================================================
    RMAN-00569: =============== ERROR MESSAGE STACK FOLLOWS ===============
    RMAN-00571: ===========================================================
    RMAN-03002: failure of restore command at 08/18/2015 08:31:19
    RMAN-06004: ORACLE error from recovery catalog database: RMAN-20208: UNTIL CHANGE is before RESETLOGS change

<br/>

    RMAN> LIST INCARNATION OF DATABASE;


    List of Database Incarnations
    DB Key  Inc Key DB Name  DB ID            STATUS  Reset SCN  Reset Time
    ------- ------- -------- ---------------- --- ---------- ----------
    1       16      ORCL12   3487575625       PARENT  1          07/07/2014 05:38:47
    1       2       ORCL12   3487575625       PARENT  1594143    16/08/2015 21:29:45
    1       255     ORCL12   3487575625       CURRENT 1891094    18/08/2015 08:26:32

<br/>

// example that should be executed

    RMAN> reset database to incarnation "Inc Key";

// execute

    RMAN> reset database to incarnation 2;

<br/>

Retrying.

    RUN {
        set until scn=1891044;
        restore database;
        recover database;
    }

<br/>

    SQL> alter database open resetlogs;

<br/>

    SQL> slect count(1) from test;

<br/>

    SQL> select count(1) from test;

      COUNT(1)
    ----------
         89402

<br/>

     RMAN> LIST INCARNATION OF DATABASE;

     new incarnation of database registered in recovery catalog
     starting full resync of recovery catalog
     full resync complete

     List of Database Incarnations
     DB Key  Inc Key DB Name  DB ID            STATUS  Reset SCN  Reset Time
     ------- ------- -------- ---------------- --- ---------- ----------
     1       16      ORCL12   3487575625       PARENT  1          07/07/2014 05:38:47
     1       2       ORCL12   3487575625       PARENT  1594143    16/08/2015 21:29:45
     1       335     ORCL12   3487575625       CURRENT 1891045    18/08/2015 08:38:31
     1       255     ORCL12   3487575625       ORPHAN  1891094    18/08/2015 08:26:32
