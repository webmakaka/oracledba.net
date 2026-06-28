---
layout: page
title: Oracle Database - Change db_unique_name in RMAN catalog
description: Oracle Database - Change db_unique_name in RMAN catalog
keywords: Oracle Database, change db_unique_name in RMAN catalog
permalink: /database/backup-and-restore/rman/change-db-unique-name-in-catalog/
---

# Change db_unique_name in RMAN catalog (needed if db_unique_name of the instance has changed)

First, you need to change the unique instance name of the database.

    SQL> show parameter db_unique_name

<br/>

    $ rman target / catalog rman/rman123@rman12

</br>

    RMAN> LIST DB_UNIQUE_NAME OF DATABASE;


    List of Databases
    DB Key  DB Name  DB ID            Database Role    Db_unique_name
    ------- ------- ----------------- ---------------  ------------------
    1       ORCL12   3487575625       PRIMARY          ORCL12

// If you need to change the unique database name in the rman catalog.

    RMAN> CHANGE DB_UNIQUE_NAME FROM ORCL12 TO ORCL12C
