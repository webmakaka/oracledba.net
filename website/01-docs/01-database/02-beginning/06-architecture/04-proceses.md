---
layout: page
title: Oracle DataBase Processes
description: Oracle DataBase Processes
keywords: Oracle Database, processes
permalink: /docs/architecture/proceses/
---

<br/>

<div style="padding:10px; border:thin solid black;">

    <h3>Received a letter from the copyright holder Elena Savelyeva <saveljeva.williamspublishing@gmail.com></h3>

    <br/>

    Hello. You have published materials from our publishing house's book on your website:

    <br/>

    Oracle Database 11g: administrator's guide. : Trans. from English — M.: LLC "I.D. Williams", 2010. — 1440 p. : ill. — Parallel title English.
    	ISBN 978-5-8459-1592-4 (Russian)

    <br/>

    Without having any rights to do so. Demands to remove the publication to avoid a lawsuit and blocking of the site by Roskomnadzor. We also demand to remove other materials from our publishing house's books from your website.

    <br/>

    We demand that the removal be completed by September 7, 2018. "Non-receipt" of this letter does not relieve you of responsibility. Understood?

</div>

<br/><br/>

<div style="padding:10px; border:thin solid black;">
    The book has been publicly available on torrent trackers for over 4 years. Yes, the book is good in my opinion. The best I've come across. However, the material in it is based on database version 11.1, i.e., a ten-year-old database.
</div>

<br/>

# Oracle DataBase Processes

Let's try to rewrite the material ourselves. It should be noted that it was described quite complexly in the book.

If you are planning to take an exam, you'd better refer to another source on this topic. (Or better correct the inaccuracies written below).

<br/>

To get information about processes in Linux, you can run the command:

    $ ps -eaf | grep ora112

<br/>

    oracle11  2722     1  0  2011 ?        01:02:06 ora_pmon_ora112
    oracle11  2726     1  0  2011 ?        00:39:42 ora_psp0_ora112
    oracle11  2730     1  0  2011 ?        05:12:43 ora_vktm_ora112
    oracle11  2736     1  0  2011 ?        00:32:43 ora_gen0_ora112
    oracle11  2740     1  0  2011 ?        00:22:40 ora_diag_ora112
    oracle11  2744     1  0  2011 ?        00:35:09 ora_dbrm_ora112
    oracle11  2748     1  0  2011 ?        01:14:24 ora_dia0_ora112
    oracle11  2752     1  0  2011 ?        00:31:44 ora_mman_ora112
    oracle11  2756     1  0  2011 ?        00:46:33 ora_dbw0_ora112
    oracle11  2760     1  0  2011 ?        00:40:06 ora_lgwr_ora112
    oracle11  2764     1  0  2011 ?        01:28:04 ora_ckpt_ora112
    oracle11  2768     1  0  2011 ?        00:18:38 ora_smon_ora112
    oracle11  2772     1  0  2011 ?        00:15:23 ora_reco_ora112
    oracle11  2776     1  0  2011 ?        01:30:37 ora_mmon_ora112
    oracle11  2780     1  0  2011 ?        01:15:35 ora_mmnl_ora112
    oracle11  2784     1  0  2011 ?        00:15:53 ora_d000_ora112
    oracle11  2788     1  0  2011 ?        00:16:04 ora_s000_ora112
    oracle11  2838     1  0  2011 ?        00:33:21 ora_rvwr_ora112
    oracle11  2845     1  0  2011 ?        00:16:10 ora_arc0_ora112
    oracle11  2849     1  0  2011 ?        00:17:40 ora_arc1_ora112
    oracle11  2853     1  0  2011 ?        00:15:52 ora_arc2_ora112
    oracle11  2857     1  0  2011 ?        00:15:55 ora_arc3_ora112
    oracle11  2861     1  0  2011 ?        00:17:30 ora_qmnc_ora112
    oracle11  2992     1  0  2011 ?        01:13:39 ora_cjq0_ora112
    oracle11  3027     1  0  2011 ?        00:17:59 ora_q000_ora112
    oracle11  3031     1  0  2011 ?        00:15:07 ora_q001_ora112
    oracle11  3083     1  0  2011 ?        00:32:57 ora_smco_ora112
    oracle11  5167     1  0 Jan24 ?        00:00:02 oracleora112 (LOCAL=NO)
    oracle11 16833     1  0 14:42 ?        00:00:00 ora_w000_ora112
    oracle11 16866  5073  0 14:46 pts/0    00:00:00 grep ora112

<br/>

You can view all available Oracle background processes by querying the v\$BGPROCESS view

    SQL> SELECT name, description FROM v$BGPROCESS ORDER BY 1;

<br/>

    SQL> SELECT pname FROM v$PROCESS;

<br/>

There are mandatory processes without which Oracle cannot work, and optional ones.
The process responsible for connecting to the database and for the user to work with it is not mandatory.

Mandatory processes start when the instance starts and remain active for its entire lifetime.

Below we list the most important processes (I haven't had to touch the others much):

<ul>
	<li> DBWn (DataBase Writer) - writes modified data from the buffer cache to data files</li>
	<li> LGWR (Log Writer) - writes the contents of the redo log buffer to redo log files.</li>
	<li> ARCn (Archiver) – archives filled redo logs if this option is enabled. Not mandatory. Consumes additional resources. But you can recover the database to any point in time when this option is enabled. (simplified)</li>
	<li> CKPT (checkpoint) – responsible for creating checkpoints</li>
	<li> PMON (Process Monitor) – monitors processes and recovers process operation in case of failure</li>
	<li> SMON (System Monitor) – responsible for system recovery in case of failures</li>
	<li>MMON (manageability monitor) - statistics collection</li>
  <li> .... </li>

</ul>

<br/>

### DBWn (DataBase Writer) - writes changes to data files

Data files:

    SQL> select file#, name, status from v$datafile;

The DBWn process writes changes to these data files.

But it does this under the following conditions:

1. Every 3 seconds <br/>
2. When creating a checkpoint<br/>
3. When there is no space to write changes.

<br/>

### LGWR (Log Writer) - writes changes to redo log files

When table data changes (INSERT, UPDATE, DELETE), Oracle writes committed and uncommitted changes to the redo buffer in memory.

After that LGWR writes these changes to redo log files.

```
SQL> select group#, member from v$logfile order by group#;
```

<br/>

But it doesn't do this immediately, but under the following conditions:

<ul>
	<li> Every 3 seconds</li>
	<li> Immediately after transaction commit</li>
	<li> When the redo log buffer is one-third full (??? that's what is written, I don't know myself.)</li>
	<li> DBWn (DataBase Writer) - reports the need to write the redo log to disk. DBWn signals LGWR to first write its information so that DBWn can then write its own information to disk.</li>
	<li>The user enters commands like: alter system switch logfile to switch the group</li>

</ul>

Writing is performed to all files in the group. Usually 3 groups of 2 files each are made.

Example. In the first group there are 2 identical files. LGWR must write the same thing to both. If it fails to do so, database operation will be stopped.

If it's unclear, see the oracle installation example. There you'll find adding files to groups, switching, etc.

<br/>

### ARCn - writes changes to archivelog files (if enabled)

    SQL> select name from v$archived_log;

When Archivelog mode is enabled, a copy of the redo log is saved on disk and also archived.

That's what this process does.

<br/>

### CKPT (checkpoint)

Responsible for synchronizing buffer cache information with information on disk.

CKPT tells DBWn that it should write "dirty" data to files on disk.

After that, it updates the data file headers and control file, entering checkpoint details there.

Each checkpoint record consists of a list of all active transactions and the address of the last log entry for these transactions.

What happens when a checkpoint is created:

1. Writing the contents of redo log buffers to redo log files<br/>
2. Writing a checkpoint record to the redo log file<br/>
3. Writing the buffer cache to the data file<br/>
4. Updating data file headers and control files after checkpoint completion. <br/>

You can create a checkpoint manually and roll back to it if necessary.

    SQL> alter system checkpoint;
    SQL> alter system switch logfile;

<br/>

Control files are located here:

    SQL> select name from v$controlfile;

<br/>

### PMON (Process Monitor)

Makes sure that dead user processes don't block resources.

<br/>

### SMON (System Monitor)

As the name suggests, the process periodically monitors whether everything is fine with the database.

When the instance restarts, SMON determines the integrity of the database.

<br/>

### MMON (manageability monitor)

Collects statistics that allow diagnosing database operation. Such as AWR.

<br/>

And others.

When using ASM, RAC, DataGuard, other processes are also involved.

<br/>

### P.S. Listener processes used for remote connection to the database are not discussed here.
