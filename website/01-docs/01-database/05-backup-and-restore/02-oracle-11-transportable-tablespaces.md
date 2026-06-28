---
layout: page
title: Transportable tablespaces in Oracle 11g
description: Transportable tablespaces in Oracle 11g
keywords: Oracle Database, Transportable tablespaces
permalink: /database/backup-and-restore/oracle-11-transportable-tablespaces/
---

# Transportable tablespaces in Oracle 11g

Original:<br/>
https://habr.com/ru/post/148535/<br/><br/>

Marley: I have never used this feature. I always use dpdump and dpimp utilities. I haven't verified the correctness.<br/>
The imp and exp utilities only make sense to use if you are working with version 9 of the database.

<br/><br/>

A tablespace can be cloned and then included in another database by copying, or it can be excluded from one Oracle database and included in another Oracle database on the same platform by moving.<br>
<a name="habracut"></a><br>
Data transfer using tablespace transport is an order of magnitude faster than export/import or unload/load operations, since moving tablespaces consists only of copying data files and integrating tablespace metadata. Moving tablespaces also allows you to move the corresponding indexes, so after importing or loading table data, you do not need to rebuild indexes.<br>
 &nbsp;<br>

<h5>Working with export and import utilities</h5><br>
Oracle Database allows you to copy data between databases, as well as exchange it with external files. Copying is done through export and import.<br>
For this task, there are imp.exe and exp.exe utilities<br>
<br>
<h5>Transportable tablespaces </h5><br>
On-demand provisioning of developers with a fresh copy of production data. Using information published on non-rewritable media (CD-ROM, DVD, etc.). Quickly moving data from an OLTP system to a warehouse or data mart.<br>
The acceleration of information transfer is achieved by replacing resource-intensive export-import or unload-load processes with much faster copying of data files from one computing facility to another.<br>
<br>
<h6> Selecting a self-contained set of tablespaces </h6><br>
There are a number of conditions limiting the application of this feature. <br>
Tablespaces can only be moved between databases that: <br>
<br>
1. Have the same block size (db_block_size), are created with the same character set, the COMPATIBLE parameter in the INIT.ORA files of the source and target databases must be set to a value, and they run on compatible platforms from the same hardware vendor. <br>
Compliance can be checked by running the following query in the source and target databases: <br>
<pre><code class="sql"><span class="operator"><span class="keyword">select</span> name, <span class="keyword">value</span> <span class="keyword">from</span> v$parameter <span class="keyword">where</span> name <span class="keyword">in</span> (<span class="string">'db_block_size'</span>,<span class="string">'compatible'</span>)
<span class="keyword">union</span> <span class="keyword">all</span>
selct parameter, <span class="keyword">value</span> <span class="keyword">from</span> nls_database_parameters <span class="keyword">where</span> parameter <span class="keyword">like</span> <span class="string">'%characterset'</span>
</span></code></pre><br>
The query results in the source and target databases must be the same.<br>
<br>
2. The target database must not have a tablespace with the same name as the one being attached.<br>
<br>
3. Transport of the following is not supported: snapshots and replicated tables, function-based indexes, local object references, domain indexes.<br>
<br>
4. Selecting a self-contained set of tablespaces<br>
A self-contained set of tablespaces is a collection of tablespaces whose objects do not reference any objects not contained in the set.<br>
To check self-containment, it is convenient to use the TRANSPORT_SET_CHECK procedure (the EXECUTE_CATALOG_ROLE role is required to execute the procedure). <br>

<pre><code class="sql">begin
sys.dbms_tts.transport_set_check (ts_list =&gt; 'USER_DATA', incl_constraints =&gt; true);
end;
</code></pre>

<br>
The results of its work are written to a temporary table and can be viewed through the system view SYS.TRANSPORT_SET_VIOLATIONS:<br>
<pre><code class="sql"><span class="operator"><span class="keyword">select</span> * <span class="keyword">from</span> sys.transport_set_violations
</span></code></pre><br>
<h6>Transporting a set of tablespaces </h6><br>
First, put the tablespaces into READ ONLY state (hereinafter XXX is the tablespace name): <br>
<pre><code class="sql"><span class="operator"><span class="keyword">ALTER</span> TABLESPACE TS_XXX <span class="keyword">READ</span> <span class="keyword">ONLY</span>;</span>
</code></pre><br>
Then using the EXP utility, export the dictionary metadata.<br>
In the command line, change the encoding for correct information display.<br>
<pre><code class="dos"><span class="keyword">set</span> nls_lang=russian_cis.ru8pc866
</code></pre><br>
<pre><code class="dos">exp transport_tablespace=y tablespaces=(TS_XXX) triggers=y constraints=y grants=y file=d:\exp_xxx log=d:\exp_xxx
</code></pre><br>
Oracle will ask for username and password:<br>
Username: sys/system@orcl2012 as sysdba <br>
orcl2012 – connection string to the source database.<br>
TRANSPORT_TABLESPACE=Y — indicates that metadata export of transportable tablespaces is being performed, TABLESPACES=(USERS, USER_DATA, INDX) — specifies the list of transportable tablespaces, TRIGGERS=Y – Export table triggers (if N, triggers will not be exported) CONSTRAINTS=Y – Export integrity constraints (if N, PRIMARY KEY, UNIQUE, FOREIGN KEY and CHECK constraints are not exported, but NOT NULL constraints are exported), GRANTS=Y – Export table access privileges (N cancels privilege export), FILE=exp_tts and log=exp_tts export data file name and export log file name. <br>
After the utility successfully exports the metadata, the output will be a file with the .dmp extension (exp_xxx.dmp)<br>
After exporting the metadata, you can put the tablespaces back into READ WRITE state:<br>
<pre><code class="sql"><span class="operator"><span class="keyword">ALTER</span> TABLESPACE TS_XXX <span class="keyword">READ</span> <span class="keyword">WRITE</span>;</span>
</code></pre><br>
<h6>Attaching the set of tablespaces to the target database</h6><br>
Before importing, you need to transfer the data from the source database to the target:<br>
This can be done via ftp, command line, or Windows copy.<br>
You need to copy the tablespace file (.dbf) from the source database to the target.<br>
In the command line.<br>
<pre><code class="dos"><span class="keyword">Copy</span> \\server1\oradata\orcl\TS_XXX.dbf  \\server2\oradata\orcl\
</code></pre><br>
\\server1\oradata\orcl\TS_XXX.dbf — path to the transportable tablespace file on the source database<br>
\\server2\oradata\orcl\ — path where the transportable tablespace will be stored on the target database<br>
Now you can attach the set of tablespaces to the target database<br>
<pre><code class="dos">imp transport_tablespace=y DATAFILES=('E:\server2\oradata\orcl\TS_XXX.dbf') TABLESPACES=(TS_XXX) TTS_OWNERS=(XXXCORE) fromuser=(XXXCORE) touser=(XXXCORE) FILE=D:\ exp_xxx.dmp LOG=D:\imp_xxx.log
</code></pre><br>
Oracle will ask for username and password:<br>
sys/system@ora2015 as sysdba <br>
ora2015 – connection string to the target database.<br>
TRANSPORT_TABLESPACE=Y – indicates that metadata of the set of transportable tablespaces is being imported, DATAFILES=(…) – list defining the names and location of the data files being attached, TABLESPACES=(TS_XXX) – list of tablespaces. If the parameter is not set, the list is taken from the export file. If set, it is checked against the list in the export file (if mismatch, an error message will be issued). TTS_OWNERS=(XXXCORE) – list of schemas that own objects in the transportable tablespaces. If the parameter is not set, the list is taken from the export file. If set, it is checked against the list in the export file (if mismatch, an error message will be issued). FROMUSER=(XXXCORE), TOUSER=(XXXCORE) – names of the source and corresponding target schemas.<br>
If the import is completed successfully, you can check the data in the target database.
