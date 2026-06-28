---
layout: page
title: Data export and import utilities in Oracle Database - Data Pump
description: Data export and import utilities in Oracle Database - Data Pump
keywords: Oracle Database, export, import, Data Pump
permalink: /database/backup-and-restore/oracle-data-pump/
---

# Data export and import utilities in Oracle Database - Data Pump

Data Pump technology includes the following utilities: Data Pump Export (expdp) and Data Pump Import (impdp).

Data Pump Export – exports data to operating system files called dump files, in a special format that only the Data Pump Import utility can understand.

You can get help on the utilities by running the following commands:

    expdp help=y
    impdp help=y

If you need to export a schema or its objects, use the privileges of that schema. Using sys and system account credentials is not recommended (because importing may require sys and system privileges respectively).

Schema export parameter file.

    $ vi exoprt_schema_name.config

<br/>

```
JOB_NAME=impdp_schema_name
DUMPFILE=dpdumps:schema_name.dmp
LOGFILE=dplogs:expdp_schema_name_YYYYMMDD.log

```

JOB_NAME - job name, so that if necessary the job can be identified by name.

DUMPFILE - directory for dump
LOGFILE - directory for logs

dplogs - a reference in the database to the directory where the schema export result logs should be saved.

dpdumps - a reference in the database to the directory where the database dump file should be saved.

dplogs and dpdumps should point to real operating system directories with sufficient write permissions.

<br/>

    # mkdir -p /u03/oradata/datapump/dumps
    # mkdir -p /u03/oradata/datapump/logs

<br/>

    # chown -R oracle11:dba /u03/oradata/datapump/dumps
    # chown -R oracle11:dba /u03/oradata/datapump/logs

Creating a reference in the database to operating system directories

<br/>

    $ sqlplus / as sysdba

<strong>View existing directories for datapump:</strong>

    SQL> set linesize 200;
    SQL> set pagesize 0;
    SQL> col directory_name format a30;
    SQL> col directory_path format a60;
    SQL> select directory_name, directory_path from dba_directories;

I don't like the default directory. I prefer to delete it

    DROP DIRECTORY DATA_PUMP_DIR;

Create directories

    CREATE DIRECTORY  dpdumps  as '/u03/oradata/datapump/dumps';
    CREATE DIRECTORY  dplogs   as '/u03/oradata/datapump/logs';

Grant write permissions on this directory to user scott

    GRANT READ, WRITE ON DIRECTORY dpdumps TO scott;
    GRANT READ, WRITE ON DIRECTORY dplogs TO scott;

If you need to grant the ability to export data to these directories for any schemas:

    GRANT READ, WRITE ON DIRECTORY dpdumps TO PUBLIC;
    GRANT READ, WRITE ON DIRECTORY dplogs TO PUBLIC;

<strong>Export schema using parameter file:</strong>

    $ nohup expdp scott/tiger parfile=exoprt_schema_name.config &

In some cases, you must explicitly specify the database SID.

```
$ nohup expdp scott/tiger@SID parfile=exoprt_schema_name.config &
```

<strong>Export can be done with a single command without using a parameter file:</strong>

<br/>

```
$ nohup expdp scott/tiger job_name=scott_export_job_01 dumpfile=dpdumps:scott_YYYYMMDD.dmp logfile=dplogs:scott_YYYYMMDD  &
```

<br/><br/>

<strong>Data Pump technology consists of three main components:</strong>

<ul>
	<li>DBMS_DATAPUMP package – the main mechanism for loading and unloading data dictionary metadata. The DBMS_DATAPUMP package contains the fundamental elements of Data Pump technology in the form of procedures that actually drive data load and unload jobs. This package is responsible for the operation of both Data Pump Export and Data Pump Import.</li>
	<li>DBMS_METADATA package – for extracting and modifying Oracle metadata.</li>
	<li>Command-line interface clients – impdp and expdp</li>
</ul>

<br/>

### Data Pump Export modes

<strong>Data Pump Export supports several modes for executing jobs.</strong>

<ul>
	<li>Full database export mode. Allows exporting the entire database in a single export session using the FULL parameter. This mode requires EXPORT_FULL_DATABASE privileges.</li>
	<li>Schema mode. Allows exporting data and/or objects of a specific user using the SCHEMAS parameter.</li>
	<li>Tablespace mode. Allows exporting all tables contained in one or more tablespaces using the TABLESPACES parameter, or only metadata of objects contained in one or more tablespaces using the TRANSPORT_TABLESPACES parameter. Exporting tablespaces between databases can be done by first exporting metadata, then copying the tablespace files to the target server, and then importing the metadata into the target database.</li>
	<li>Table mode. Allows exporting only one or more specific tables using the TABLES parameter. </li>
</ul>

By default, Data Pump Export and Data Pump Import use schema mode.

<strong>Exported data filtering parameters.</strong>

The CONTENT parameter allows filtering the data that should be placed in the dump file during export. It can take the following values:

<ul>
	<li>ALL – indicates that both table data and table and other object definitions (metadata) should be exported;</li>
	<li>DATA_ONLY – indicates that only table rows should be exported.</li>
	<li>METADATA_ONLY – indicates that only metadata should be exported.</li>
</ul>

**Example:**

```
$ nohup expdp scott/tiger dumpfile=dpdumps:mydump01.dmp logfile=dplogs:mydump01.log CONTENT=DATA_ONLY &
```

<br/>

<strong>EXCLUDE and INCLUDE parameters</strong>

The EXCLUDE and INCLUDE parameters are two mutually exclusive parameters that can be used for so-called metadata filtering. Metadata filtering allows you to selectively exclude or include certain object types during Data Pump Export or Data Pump Import. In the previous export utility, the CONSTRAINTS, GRANTS, and INDEXES parameters were used to specify whether such objects should be exported. By using the EXCLUDE and INCLUDE parameters, it has now become possible to include and exclude objects of many other types besides those four that could be filtered previously. For example, if you need to ensure that no packages are exported during export, this behavior is set using the EXCLUDE parameter.

Simply put, the EXCLUDE parameter helps skip certain database object types during export or import operations, while the INCLUDE parameter does the opposite – includes only a specific set of objects in these operations. Below is the general syntax of these parameters:

    EXCLUDE=object_type[:name_clause]
    INCLUDE=object_type[:name_clause]

The EXCLUDE and INCLUDE parameters are mutually exclusive. Therefore, only one of them can be used during the same job execution; both cannot be used simultaneously.

For both the EXCLUDE and INCLUDE parameters, the name_clause element is optional. As is known, some objects in the database, such as tables, indexes, packages, and procedures, have names, while some, such as GRANT objects, do not. The name_clause element in the EXCLUDE or INCLUDE parameter allows you to apply an SQL function to filter named objects.

Below is a simple example of excluding all tables whose names start with EMP.

    EXCLUDE=TABLE:”LIKE ‘EMP%’”

In this example, ”LIKE ‘EMP%’” is the name clause.

The name_clause element is optional in the EXCLUDE and INCLUDE parameters. It is simply a filtering means that allows more precise definition of the type of objects to be excluded or included (indexes, tables, etc.). If omitted, all objects of the specified type will be included or excluded.

In the following example, Oracle will exclude all indexes from the export operation because no value was specified in the name_clause element requiring that only specific indexes be excluded:

    EXCLUDE=INDEX

Additionally, the EXCLUDE parameter can be used to exclude an entire schema, as shown in the following example:

    EXCLUDE=SCHEMA:”=’HR’”

The INCLUDE parameter is the opposite of the EXCLUDE parameter and allows you to force only a specific set of objects into the export operation. As with the EXCLUDE parameter, a name_clause element can also be used with INCLUDE to specify exactly which objects should be exported.

Below are three examples demonstrating the use of the name_clause element to limit selected objects:

    INCLUDE=TABLE:”IN (‘EMPLOYEES’,’DEPARTMENTS’)”;
    INCLUDE=PROCEDURE
    INCLUDE=INDEX:”LIKE ‘EMP%’”

In the first example, the INCLUDE parameter specifies that only two tables should participate in the export process: EMPLOYEES and DEPARTMENTS; in the second – only procedures; and in the third – only indexes, and only those whose names start with EMP.

The following example shows how to use the backslash character to escape double quotes:

    $ expdp scott/tiger DUMPFIEL=dum.file%U.dmp
    schemas=SCOT EXCLUDE=TABLE:\”=’EMP’\”, EXLUDE=FUNCTION:\”=’MY_FUNCTION’\”

When performing metadata filtering using the EXCLUDE and INCLUDE parameters, it is important to remember that all objects that depend on a filtered object will be handled the same way as the filtered object itself. For example, if the EXCLUDE parameter is used to exclude a particular table, the indexes, constraints, triggers, and other objects dependent on that table will also be automatically excluded.

There are many other parameters including encryption, compression, etc.

<br/>

## Data Pump Import

```
$ nohup impdp scott/tiger dumpfile=datapumps:mydump01.dmp logfile=datapumps:mydump01.log &
```

Sometimes (in my case during an unsuccessful import) you can extract all DDL code from the dump file.

For this, you can use the SQLFILE parameter.

<br/>

```
$ nohup impdp scott/tiger dumpfile=datapumps:mydump01.dmp logfile=datapumps:mydump01.log sqlfile=datapumps:scott.sql job_name=scott_import_job_01 &
```

A scott.sql file with DDL is created.

<br/>

### Filtering parameters

The CONTENT parameter is used in Data Pump Import, as in Data Pump Export, to specify whether only rows (CONTENT=DATA_ONLY), rows and metadata (CONTENT=ALL), or only metadata (CONTENT=METADATA_ONLY) should be loaded.
The EXCLUDE and INCLUDE parameters serve the same purpose in Data Pump Import as in Data Pump Export and are mutually exclusive, specifically:

<ul>
<li>The INCLUDE parameter is used to list objects to be imported;</li>
<li>The EXCLUDE parameter is used to list objects that should not be imported.</li>
</ul>

Below is a simple example of using the INCLUDE parameter. In this example, import is limited to table objects only. As a result, only the PERSONS table will be imported.

    INCLUDE=TABLE:”= ‘persons’ “

To import only tables whose names start with PER, you can use INCLUDE=TABLE:”LIKE ‘PER%’”. Additionally, the INCLUDE parameter can also be used negatively, specifying that all objects with a certain syntax should be ignored:
INCLUDE=TABLE:”NOT LIKE ‘PER%’”

Please note that if the CONTENT parameter is set to DATA_ONLY, neither the EXCLUDE nor the INCLUDE parameter can be used during import.

The TABLE_EXISTS_ACTION parameter tells Data Pump Import what to do if a table already exists. This parameter can have four different values:

<ul>
<li>SKIP – (default value) – skip the table if it already exists;</li>
<li>APPEND – append rows to the table;</li>
<li>TRUNCATE – truncate the table and load data from the export dump file.</li>
<li>REPLACE – drop the table if it exists, recreate it, and load data into it.</li>
</ul>

<br/>

### Remapping parameters

<br/>

### REMAP_TABLE parameter

The REMAP_TABLE parameter allows renaming a table during import using the transportable tablespace method.

    TABLES=hr. employees REMAP_TABLE=hr. employees:emp

In this example, the REMAP_TABLE parameter specifies that during import, the name of the hr.employees table should be changed to hr.emp

<br/>
<h3>REMAP_SCHEMA parameter</h3>

The REMAP_SCHEMA parameter allows moving objects from one schema to another. This parameter is specified approximately like this:

    REMAP_SCHEMA=hr:oe

In this example, the REMAP_SCHEMA parameter specifies that during import, all objects from the source HR schema should be moved to the target OE schema. Data Pump Import can even create the OE schema if it does not exist in the target database.

<br/>

### REMAP_TABLESPACE parameter

Sometimes you need the tablespace into which data is imported to differ from the one used in the source database. The REMAP_TABLESPACE parameter allows moving objects from one tablespace to another during import.

    REMAP_TABLESPACE=’example_tbs’: ‘new_tbs’

<br/>

### REMAP_DATAFILE parameter

When moving databases between two different platforms, each of which uses its own file naming convention, the REMAP_DATAFILE parameter is very useful because it allows changing the file naming format. Below is an example showing how to use this parameter to tell Data Pump Import to use UNIX file system format instead of Windows file system format. Then, when the import dump file contains any reference to a file named in Windows file system format, Data Pump Import will automatically change the file name to match UNIX file system format.

    REMAP_DATAFIELE=’DB1$:[HRDATA.PAYROLL]tbs6.f’:’/db1/drdata/payroll/tbs6.f’

<br/>

### TRANSFORM parameters

Suppose you need to import a table from another schema or even another database and not import other object storage attributes, i.e., you just need to transfer the data contained in the table. The TRANSFORM parameter allows you to tell Data Pump Import not to import certain storage attributes and attributes of other types. By using the TRANSFORM parameter, you can exclude STORAGE and TABLESPACE clauses or just STORAGE clauses from a table or index.
During import, Data Pump creates objects using DDL statements found in the export dump files. The TRANSFORM parameter essentially tells Data Pump Import to modify the DDL statements that create objects in a certain way.

The general syntax of the TRANSFORM parameter is:

Below is a brief description of what each element represents.

<strong>1) Transform name.</strong> There are only four options that can be specified in place of this element. These options allow you to change four main types of object characteristics.

<br/><br/>

<ul>
	<li>SEGMENT ATTRIBUTES. This option allows influencing segment attributes, which include physical attributes, storage attributes, tablespaces, and logging. You can force Data Pump Import to include all these attributes by specifying this option with the value Y (SEGMENT_ATTRIBUTES=Y), which is the default value for this parameter. In this case, Data Pump Import will include all four segment attributes together with their DDL statements.</li>
	<li>STORAGE. By specifying the STORAGE option with the value Y (STORAGE=Y) in the transform name element, which is the default value, you can only get the storage attributes of those objects that are part of the Data Pump Import job.</li>
	<li>OID. If you specify the OID option with the value Y (OID=Y) in the transform name element, which is the default value, object tables will be assigned a new OID during import.</li>
	<li>PCTSPACE. By specifying the PCTSPACE option with a positive number as the value in the transform name element, you can increase the space allocated for objects and data files by the corresponding percentage.</li>
</ul>

<strong>2) Value.</strong> In the value element of the TRANSFORM parameter, either Y (yes) or N (no) can be specified. As mentioned above, for the first three options that can be specified in the transform name element, the default is Y. This means that by default, Data Pump is set to import both segment attributes and object storage attributes. As an alternative, you can set the value N for these options and thus tell Data Pump not to import the original segment and/or storage attributes. For the PCTSPACE option, only some number can be specified in the value element.

<strong>3) Object_type.</strong> In the object_type element, you can tell Data Pump Import which type of objects need to be transformed. These can be tables, indexes, tablespaces, types, clusters, constraints, and other objects, depending on the options specified in the transform name element. If no object type to transform is specified when using the SEGMENT_ATTRIBUTES and STORAGE options, these options will apply to all tables and indexes that are part of the import operation.

Below is an example of using the TRANSFORM parameter:

    TRANSFORM=SEGMENT_ATTIBUTES:N:table

In this example, SEGMENT_ATTRIBUTES is set to N, and the object type is specified as table. In this specification, the TRANSFORM parameter tells Data Pump Import not to import existing storage attributes for any tables.

<br/>

## Monitoring Data Pump job execution

The most important views for monitoring Data Pump job execution are
DBA_DATAPUMP_JOBS and DBA_DATAPUMP_SESSIONS.

The DBA_DATAPUMP_JOBS view allows you to get summary information about all currently executing Data Pump jobs.

<br/>

```sql
SQL> set pagesize 0;
SQL> set linesize 220;
SQL> col owner_name format a20;
SQL> col job_name format a20;
SQL> col operation format a20;
SQL> col state format a20;

SQL> SELECT owner_name, job_name, operation, state
FROM dba_datapump_jobs
WHERE state = 'EXECUTING';
```

<br/>

```
SYS                  IMP_M2M_SVT          IMPORT               EXECUTING
```

<br/>

The DBA_DATAPUMP_SESSIONS view allows you to find out which user sessions are currently connected to a Data Pump Export or Data Pump Import job.

<br/>

```sql
SQL> SELECT sid, serial#
FROM v$session s, dba_datapump_sessions d
WHERE s.saddr = d.saddr;
```

<br/>

## Viewing progress information on Data Pump job execution

Below is a typical script that can be used to obtain information
about how much time is left until the completion of a Data Pump job:

<br/>

```sql
SQL> SELECT opname, target_desc, sofar, totalwork, start_time, time_remaining
FROM v$session_longops;
```

<br/>

<ul>
	<li>OPNAME - Data Pump job name</li>
	<li>TOTALWORK - shows how many megabytes total were counted for the execution of this job;</li>
	<li>SOFAR - shows how many megabytes have been transferred so far during the execution of this job;</li>
</ul>

<br/>

### Additional

**Oracle Data Pump 21c and Cloud Object Stores**  
https://www.youtube.com/watch?v=6S2N1-V5qc8
