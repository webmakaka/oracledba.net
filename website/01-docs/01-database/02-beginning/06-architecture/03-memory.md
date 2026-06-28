---
layout: page
title: Oracle DataBase Memory Structures
description: Oracle DataBase Memory Structures
keywords: Oracle Database, Memory
permalink: /docs/architecture/memory/
---

# Oracle DataBase Memory Structures

<br/>

```sql
SQL> SELECT component, current_size, min_size, max_size
FROM v$sga_dynamic_components;
```

<br/>

```sql
SQL> SELECT name, value
FROM v$pgastat
WHERE name in ('maximum PGA allocated','total PGA allocated');
```

<br/>

Oracle uses a portion of its allocated memory to store both program code and data, which can significantly speed up processing compared to constantly having to retrieve data from disk. These memory structures allow Oracle to share the same executable code among multiple users, without spending time on preparatory procedures before calling each piece of code.

The Oracle server does not always write data to disk directly. It writes database changes to a memory area, and when the right moment comes, flushes them to disk. Since memory access is many times faster than physical disk access (measured in nanoseconds, while disk access is measured in milliseconds), Oracle can overcome the I/O limitations of the disk system. The more work your database performs in memory compared to disk accesses, the faster it responds to requests. Of course, as I/O decreases, CPU load also decreases, increasing system efficiency.

<br/>

### Main Memory Concept

All computers use memory, which actually consists of a hierarchy of different memory levels. At the heart of the hierarchy is main memory, which contains all executable instructions and data manipulations. All main memory is random access memory (RAM), meaning any byte can be read from any part of it in the same amount of time. Typically, you can access data in main memory in 10-100 nanoseconds.

An important part of Oracle information stored in its allocated RAM is the program code currently executing or that has just been executed. If a new user process needs the same code, it is available to them in memory in compiled form, significantly speeding up its execution time. Memory areas also contain information about which users have locked a particular table, thereby improving communication efficiency between different sessions. But perhaps most importantly, memory areas help in processing data located in permanent disk storage. Oracle does not directly make changes to data on disk: data is always read from disk, held in memory, and modified there before being written back to disk.

These memory areas are commonly referred to as buffers. Memory buffers are page-sized memory areas into which Oracle transfers the contents of disk blocks. If the database needs to read (select) or update data, it copies the corresponding blocks from disk into memory buffers. After making the necessary changes, Oracle transfers the contents of the memory buffers to disk.

Oracle uses two types of memory structures – shared and process-specific. The System Global Area (SGA) is a portion of shared memory that all server processes (including background processes) share. The process-specific portion of memory is known as the Program Global Area (PGA), or process-private memory. In the following sections, we will discuss these two Oracle memory components in more detail.

<br/>

### System Global Area

SGA is the most important memory component in an Oracle instance. Especially in large OLTP databases, the SGA is much larger and more important than the PGA. In data warehouse environments, on the other hand, PGA can be a more important Oracle memory area – due to its decisive impact on the efficiency of sorting and hashing large volumes of data, which is inherent in analytical computations in data warehouses.

The purpose of SGA is to speed up query performance and support a large amount of concurrent activity. Since in-memory processing is much faster than disk I/O, SGA size is one of the most important configuration parameters when tuning a database for optimal performance. When you start an Oracle instance, it occupies a certain amount of memory from the operating system's RAM, and this amount is determined by the SGA component in the initialization file. When the instance stops, the memory used by SGA is returned to the operating system.

SGA is not a homogeneous area. It is actually a combination of several memory structures.

At a minimum, SGA includes the following data structures:

<ul>
<li>buffer cache</li>
<li>log buffer</li>
<li>shared pool:</li>
<li>- library cache</li>
<li>- data dictionary cache</li>
<li>- PL/SQL area</li>
<li>- SQL query and PL/SQL function result caches</li>
</ul>

<br/><br/>

It may also include:
<br/><br/>

<ul>
	<li>large pool</li>
	<li>java pool</li>
	<li>streams pool</li>
</ul>

<br/><br/>

**The main SGA components are listed below.**

<br/><br/>

<ul>
<li>
Database buffer cache. Stores copies of data blocks read from data files.
</li>
<li>
Shared pool. Contains the library cache for storing parsed SQL and PL/SQL code, ready for use by all users. It also contains the data dictionary cache, which stores all dictionary information.
</li>
<li>
Redo log buffer. Contains information needed to recover changes made to the database by DML operations. This information is then written to redo log files by the log writer.
</li>
<li>
Java pool. Provides heap space for creating Java objects.
</li>
<li>
Large pool. Stores large memory allocations, such as RMAN backup buffers.
</li>
<li>
Streams pool. Supports Oracle Streams (a data replication facility between databases).
</li>
</ul>

When you start an Oracle instance, it allocates memory as needed until it reaches the MEMORY_TARGET initialization parameter value, which sets the total memory allocation limit. If the allocated memory volume already equals MEMORY_TARGET, you cannot dynamically increase the size of any memory component without decreasing the size of some other. Oracle allows moving memory from one dynamically allocated component to another.

For example, you can increase the memory allocated to the buffer cache by taking it from the shared pool. If you have a job scheduled to run at a certain time of day, you can write a simple script executed before the job runs that modifies memory allocation among various components. After the job completes, you can run another script that returns the memory distribution back to the original settings.

In the following sections, we will discuss the various SGA components. You can manage SGA yourself by calibrating the memory allocated to the Oracle instance as the memory requirements of the running instance change. However, the best way to manage SGA (as well as PGA) is simply to adapt memory management.

<br/>

### Database Buffer Cache

The database buffer cache consists of memory buffers that Oracle uses to store data read by server processes from data files on disk in response to user requests. Access to the buffer cache is, of course, much faster than reading data from disk storage. When a user modifies data, these changes are also made in the database buffer cache. Therefore, the buffer cache contains both original blocks read from disk and modified blocks that are to be written to disk.

Memory buffers in the database buffer cache can be divided into three groups:

<br/>

<ul>
<li>
Free buffers. These are buffers that do not contain useful data, so the database can use them to store data read from disk.
</li>
<li>
Dirty buffers. These store data that has been read from disk and then modified, but not yet written to data files on disk.
</li>
<li>
Pinned buffers. These are data buffers that are in active use by a user session.
</li>
</ul>

<br/>

When a user process requests data, Oracle first checks whether that data is in the buffer cache. If it is, the server process reads this data directly from SGA and sends it to the user. If the data is not found in the buffer cache, the server process reads it from the corresponding data files on disk and places it in the database buffer cache. Of course, there must be free buffers available in the buffer cache, or the database must write some dirty buffers to disk, thereby freeing up space for new data.

Oracle maintains an LRU list of free, pinned, and dirty buffers in memory. It is the responsibility of the database writer process to write dirty buffers to disk to ensure a constant supply of free buffers in the database buffer cache. To determine which dirty buffers should be written to disk, Oracle uses a modified LRU algorithm that guarantees only the most recent data remains in the buffer cache. Writing data to disk that is not currently being requested improves database performance.

The larger the buffer cache, the fewer read/write operations are required and the higher the database performance. Thus, correctly sizing the buffer cache is very important for your database's performance. Of course, simply assigning an extremely large buffer cache can harm performance because you may take more memory than necessary and thereby cause undesirable swapping on your server.

<br/>

### Using Multiple Buffer Pool Caches

Typically, a single default buffer cache is sufficient for servicing instance memory. Assigning the same buffer cache to all database objects can sometimes be not very efficient because different objects and different data types may have different requirements for how long they stay in the data cache. For example, table A may have hundreds of thousands of accesses per day, while table B may have only two accesses per day. Clearly, it makes sense to keep table A in the buffer cache all day to speed up access, and remove table B from the cache each time after use to save cache space.

Oracle provides flexibility in using the buffer cache by allowing you to configure the database buffer cache into multiple buffer pools. Buffer pools in this context are simply parts of the overall buffer cache that meet certain data retention criteria for database objects such as tables. For example, you can take a total buffer cache of 500 MB and divide it into three pools – two of 200 MB and one of 100 MB. Once you create these buffer pools, you can assign tables to them at creation for exclusive use. You can also use the ALTER TABLE or ALTER INDEX command to modify the type of buffer pool that a table or index should use.

Note that any database objects for which you do not assign a specific keep or recycle buffer pool will be assigned to the default buffer pool, whose size is determined according to the value specified in the DB_CACHE_SIZE initialization parameter. Keep or recycle buffer pools are optional, while the default buffer pool is mandatory.

Remember that the main goal of assigning objects to different buffer pools is to minimize cache misses and consequently minimize disk I/O operations. Virtually all buffer caching strategies are aimed at this. If you don't know which objects in your database belong to which buffer cache types, query this information from the V\$DB_CACHE_ADVICE view to get advice from Oracle.

Main buffer pool types.

<br/><br/>

<table>
<tr>
<td> Buffer pool</td>
<td> Initialization parameter</td>
<td> Description </td>

</tr>

<tr>
<td> Keep buffer pool</td>
<td> DB_KEEP_CACHE_SIZE </td>
<td> Permanently stores data blocks in memory. You may have small tables that are frequently accessed, and to prevent them from being removed from the buffer cache, you can assign them to the keep buffer pool when creating the table.
 </td>

</tr>
<tr>
<td> Recycle buffer pool</td>
<td> DB_RECYCLE_CACHE_SIZE </td>
<td> Removes data from the cache immediately after use. This buffer pool should be used cautiously, if at all. The recycle buffer pool removes the object from the cache as soon as the transaction completes. Obviously, it should only be used for large tables that are infrequently accessed and do not need to be kept in the cache indefinitely. </td>

</tr>
<tr>
<td> Default buffer pool</td>
<td> DB_CACHE_SIZE </td>
<td> Contains all data and objects that are not assigned to the keep or recycle buffer pools. </td>

</tr>

</table>

<br/>
<h3> Multiple Database Block Sizes and Buffer Cache</h3>

You can have multiple block sizes in your database. First, you need to select a standard block size, and then define up to four other non-standard sizes.

The DB_BLOCK_SIZE parameter in the initialization parameter file determines your standard and often only block size for the entire database. The DB_CACHE_SIZE parameter in your initialization parameter file specifies the size (in bytes) of the buffer cache with the standard block size. Note that you do not set the number of database buffers; instead, you specify the size of the buffer cache itself in the DB_CACHE_SIZE parameter.

You can have up to five different block sizes in your databases, i.e., you can create tablespaces with one of five available block sizes. Although most databases use a single standard block size (such as 4 KB, 8 KB, or 16 KB), you can also specify some or all of the four non-standard block sizes. For example, you can have some data warehouse type tables that would benefit from a large block size, such as 32 KB. However, most other tables in the database may serve online processing needs and therefore should use a standard block size of 4 KB. If you happen to use all four non-standard block sizes in addition to the standard one, you can create tablespaces with all five block sizes. However, before you create these tablespaces with non-standard block sizes, you must configure non-standard subcaches in the buffer cache for each block size you want to use. You can specify non-standard buffer subcaches using the DB_nK_CACHE_SIZE initialization parameter, where n is the block size in KB, which can be 2, 4, 8, 16, or 32.

As you can see, the database buffer cache can be divided into three pools: default, keep, and recycle. The total size of the buffer cache will be the sum of memory blocks assigned to all buffer cache components. Keep and recycle buffer pools can be created with a standard block size, and for the default buffer pool, up to four other block sizes can be used.

Here is an example demonstrating how to specify various values for each buffer cache subcache in the initialization file. In this example, the numbers on the right show the memory size allocated for a specific buffer cache type.

DB_KEEP_CACHE_SIZE = 48MB<br/>
DB_RECYCLE_CACHE_SIZE = 24MB<br/>
DB_CACHE_SIZE = 128MB /* Standard block size 4 KB */<br/>
DB_2k_CACHE_SIZE = 48MB /* non-standard block size 2 KB */<br/>
DB_8k_CACHE_SIZE = 192MB /* non-standard block size 8 KB */<br/>
DB_16k_CACHE_SIZE = 384MB /* non-standard block size 16 KB */<br/>

The total size of the buffer cache in this example will be the sum of all the listed subcaches, equal to 824 MB.

<br/>

### Buffer Cache Hit Ratio

Reading from a buffer is much faster than reading from disk. The most important principle of correctly sizing the buffer cache can be summarized in one phrase: "touch as few blocks as possible," because disk I/O required to read data from Oracle blocks on disk is much more expensive than reading data from SGA. That is why the hit ratio, which measures the percentage of time a user gets the data they need from the buffer cache (instead of reading from disk), is such an important indicator of Oracle instance performance.

The buffer cache hit ratio is calculated as follows.

Hit ratio = (1 - (physical reads) / (logical reads) * 100)

In this formula, physical and logical reads (reads from disk and from memory, respectively) accumulate from the moment the Oracle instance starts. Therefore, if you calculate the ratio on Monday morning after a database restart on Sunday night, it will give a very low value. As the days of the week pass, the ratio value may increase significantly because more read requests occur, and Oracle satisfies them by retrieving data already in memory.

Unfortunately, Oracle does not offer any hard rules or guidelines on how much memory you should allocate for the buffer cache in SGA. You can get an idea of the optimal size through trial and error.

A high buffer cache hit ratio is not always associated with high database performance. It is quite possible that your database will show a very high hit ratio – say, 90% - and still have performance problems. For example, despite a high total number of logical reads and a high hit ratio value, your SQL queries may be inefficient.

<br/>

### Shared Pool

The shared pool is a very important part of Oracle SGA, and correctly sizing it for your instance will help eliminate several types of bottlenecks in the Oracle instance. Unlike the database buffer cache, which stores actual data blocks, the shared pool stores executable PL/SQL code and SQL statements together with information related to data dictionary tables. The data dictionary is a set of key tables maintained by Oracle and containing critical data about database tables, users, privileges, and the like.

Correctly sizing the shared pool area provides benefits in two respects. First, your database response time will be lower because you reduce processing time – if you don't need to recompile the same Oracle code every time a user executes a query, time is saved. Oracle reuses previously compiled code if it encounters it again. Second, more users can use the system because code reuse allows the database to serve more users with the same resources. Both I/O volume and process load are significantly reduced when your database efficiently uses memory from the shared pool.

Next, we will talk about the library cache and data dictionary cache, both of which are components of the shared pool.

<br/>

### Library Cache

Application code – whether simple SQL code embedded in PL/SQL program units such as procedures and packages – is first parsed and later executed. Oracle stores all compiled SQL statements in a shared pool component called the library cache. This pool component is shared by all database users. Every time a SQL statement is issued, Oracle first checks the library cache to see if this statement has already been parsed and is ready for execution. If it is there, Oracle uses the version from the library cache, significantly reducing processing time. This is called a soft parse.

If Oracle does not find a ready-to-execute version of the SQL code in the library cache, it must be built from scratch – this is called a hard parse. Oracle uses part of the library cache memory to store newly parsed code. If there is not enough memory for this in the shared pool, Oracle displaces the oldest code from it to make room for new code.

Hard parsing involves the use of critical system resources, such as CPU power, and internal Oracle structures like latches; you should do everything possible to reduce the number of such situations. A large number of hard parses leads to resource contention and subsequent slowdown of database response to user queries.

You should make a decision about the size of the library cache based on the hit and miss ratio. If your system shows more than normal misses (meaning frequent reparsing or code reloading), it's time to increase the size of the library cache. The way to do this is to expand the shared pool.

Missing required information in the data dictionary cache or in the library cache of the shared pool has a greater impact on database performance than missing it in the buffer pool cache. For example, reducing the data dictionary cache hit ratio from 99% to 89% leads to a more noticeable performance degradation than a similar decrease in the buffer cache ratio.

<br/>

### Result Cache

In Oracle Database 11G, a remarkable new SGA component appeared, called the result cache. The result cache is an area of SGA where the database stores results of both SQL queries and PL/SQL functions, if you enable these caches. When the database executes an SQL query again, it can simply retrieve the result from the result cache instead of re-executing the same query, thereby significantly improving performance. Caching of PL/SQL function results works very similarly to the SQL query result cache. When a cached function is executed again, the database does not execute its body again, but instead simply returns the cached result immediately.

You use the RESULT_CACHE_MODE initialization parameter to control the database's caching behavior for SQL query and PL/SQL function results. You can also use the new result cache hint to override the RESULT_CACHE_MODE parameter setting. You can manage caching through the DBMS_RESULT_CACHE PL/SQL package or using Enterprise Manager.

<br/>

### Redo Log Buffer

The redo log buffer is usually no larger than a couple of megabytes in size, unlike the buffer cache and shared pool sizes, but is nevertheless a critical SGA component. When a server process modifies data in the buffer cache (through insert, delete, or update), it generates redo data, which is written to the redo log buffer. The log writer process writes this information from the memory buffer to the redo log files on disk.

The LOG_BUFFER initialization parameter is used to set the size of the redo log buffer, and it remains fixed for the life of the instance. That is, the size of the redo log buffer cannot be changed dynamically, unlike other SGA components.

The log writer process writes the contents of the redo log buffer to disk in any of the following cases.

<ul>
<li>
The redo log buffer is one-third full
</li>
<li>
A user commits a transaction
</li>
<li>
The database buffer cache has little free space and needs to write changed data to the redo log. The database writer instructs the log writer process to flush the log buffer contents to disk to free up space for new data.
</li>
</ul>

The redo log buffer is circular – the log writer process writes redo entries from the buffer to the redo log files, and the server process writes new redo log entries into the buffer over those flushed to the log files. The database allocates a small amount of memory – 5 MB or so – for the redo log buffer. A large size for this buffer will reduce log file I/O performance (especially if you have large or numerous transactions), but your commits will also take longer.

The redo log writer process usually writes to log files very quickly, even under high load. A redo log buffer that is too small leads to high load on the writer process – it ends up constantly writing to disk. Moreover, if the log buffer is too small, it frequently overflows when accepting new redo log entries.

Oracle offers an option called nologging, which allows you to completely bypass redo logging and avoid contention during some operations (such as large data loads). You can also batch commits into one long job, allowing redo logs to write more efficiently.

<br/>

### Large Pool and Java Pool

The large pool is simply an optional memory pool that Oracle manages differently from the shared pool. The large pool will need to be configured only if you use parallel queries in the database. Oracle also recommends configuring this pool if you use RMAN or a shared server configuration instead of the standard dedicated server configuration. You set the size of this pool in the initialization file using the LARGE_POOL_SIZE parameter. The large memory pool is important if a shared server architecture is used.

The Java pool (set by the JAVA_POOL_SIZE parameter) is intended for databases that contain a lot of Java code, so that the regular SGA area is insufficient to accommodate components using Java objects. The Java memory pool is reserved for the Java Virtual Machine (JVM) and for your Java applications. When deploying Enterprise JavaBeans or using CORBA, a Java pool size of over 1 GB may potentially be needed.

<br/>

### Streams Pool

Oracle Streams is a technology that allows sharing common data between different databases and between different application environments. The Streams pool is memory allocated to support Streams activity in your instance. If you manually set the Streams pool component using the STREAMS_POOL_SIZE initialization parameter, memory for this pool is transferred from the buffer cache after the first access to Streams. If you use automatic memory management, memory for the Streams pool is borrowed from the global SGA pool. The transferred amount is up to 10% of the shared pool size.

<br/>

### Program Global Area

Oracle creates a Program Global Area (PGA) for each user when a user session opens. This area contains data and control information for the dedicated server process that Oracle creates for each individual user. Unlike SGA, PGA is intended for exclusive use by each server process and cannot be shared among multiple processes. Session registration information and persistent information, such as variable binding information and data type conventions, are still part of SGA unless you use a shared server configuration, but the runtime area used by SQL statements resides in PGA.

For example, a user process may have some cursors (descriptors of memory areas where you store variable values) associated with it. Since these are user cursors, they are not automatically shared with other users and therefore PGA is the appropriate place to store these private values. Another main use of PGA is oriented towards executing memory-intensive SQL operations that involve sorting, such as queries with ORDER BY or GROUP BY clauses. Such operations need some working area, and PGA provides this memory area.

PGA memory relates to the following two types:

<ul>
<li>
Private SQL area. This memory area contains information about SQL variable binding and runtime memory structures. Each session executing a SQL statement gets its own private SQL area.
</li>
<li>
Runtime area. The runtime area is created for a user session when it issues a SELECT, INSERT, UPDATE, or DELETE statement. After the SELECT, INSERT, UPDATE, or DELETE statement completes, or after fetching results from a SELECT statement, the runtime area is freed by Oracle.
</li>

</ul>

If a user session uses complex joins or intensive sorting (grouping and ordering), the session uses the runtime area to perform these memory-intensive operations.

To reduce response time, all sorts performed in PGA should complete entirely in the work area cache. This is called optimal mode operation because all work is done in memory, without disk I/O. If a sort requires disk access because there is insufficient memory area for it, this significantly slows down the sort operation. A SQL operation that is forced to access disk memory even to a limited extent – a one-pass operation – is slower than an operation fully performed in the memory area. However, if your runtime memory area is too small compared to the needs of the sort operation, Oracle has to perform multiple passes over the sorted data, which heavily loads the disk and significantly increases response time for the user. Thus, there is a direct relationship between PGA size and query performance.

You can tune the sizes of these private work areas, but this is a "hit-or-miss" approach that requires considering many complex Oracle configuration parameters related to memory work areas. Parameters that need to be set manually include SORT_AREA_SIZE, HASH_AREA_SIZE, and BITMAP_AREA_SIZE.

The sum of all PGA memory used by all sessions constitutes the PGA volume used by the instance. Oracle recommends using automatic PGA management, which automates PGA memory allocation. This helps to more efficiently use the memory allocated to the database. This feature behaves particularly well under high workload because it dynamically adjusts the boundaries of available memory and constantly monitors the situation. Manual PGA management can lead to either too little or too much memory allocation, which is fraught with performance problems.

You automate PGA memory allocation by setting the WORKAREA_SIZE_POLICY initialization parameter to its default value – auto. If you set this parameter to manual, you must specify all the PGA work area parameters mentioned above. The WORKAREA_SIZE_POLICY parameter guarantees PGA memory automation. However, you must also set the total allocated PGA memory size by specifying the PGA_AGGREGATE_TARGET initialization parameter. For example, if you set PGA_AGGREGATE_TARGET=5000000000 in the initialization parameter file, Oracle will use 5 GB of allocated PGA memory as a global setting for the instance. Oracle will keep the total PGA memory used by all server processes of the instance within this limit.

If you do not set the PGA_AGGREGATE_TARGET parameter, you must use manual work area management mode. Alternatively, you can activate manual mode by setting the WORKAREA_SIZE_POLICY parameter to manual. Oracle strongly recommends using automatic PGA management because it allows more efficient memory usage. For users, this means higher performance and reduced query execution time overall.

When you use automatic PGA memory management by setting PGA_AGGREGATE_TARGET, Oracle tries to allocate enough memory to all work areas in an optimal manner, performing all memory-intensive SQL operations in the cache memory. In the worst case, some work areas use disk space in one-pass mode. However, if you set the PGA_AGGREGATE_TARGET parameter too low relative to the work area needed by your instance, Oracle will start multi-pass execution of SQL operations with intensive sorting or hashing, which has catastrophic consequences for instance performance.

In manual management mode, all PGA memory that was not used is automatically returned to the system. Each session connecting to the database is allocated a certain amount of PGA memory, which is retained until the session ends, regardless of whether SQL statements are executed in it. With automatic PGA management, the Oracle server returns all unused PGA memory to the operating system. In a loaded environment, this leads to a huge difference in database and system performance. Suppose you set the PGA_AGGREGATE_TARGET parameter to 5 GB. Oracle will not immediately grab 5 GB of memory when the instance starts, as it does with the SGA_TARGET parameter. It borrows memory from the operating system as needed, up to the 5 GB limit. As soon as a session releases its allocated memory area, this memory is immediately returned to the operating system.

<br/>

### Automatic Memory Management

In earlier versions of Oracle, administrators spent considerable time figuring out the correct SGA size. It was not unusual to frequently recalibrate the SGA size, trying to achieve optimal instance tuning. In Oracle Database 11g, you can configure automatic memory management using the new MEMORY_TARGET initialization parameter. All you need to do is assign a specific value to the MEMORY_TARGET parameter, and Oracle will take care of automatically distributing memory between SGA and PGA components. Oracle's SGA memory allocation to various components is not static but changes as the database load changes. Oracle can automatically manage the following five SGA components (the corresponding Oracle initialization parameters are indicated in parentheses):

<ul>
<li>
Database buffer cache (DB_CACHE_SIZE);
</li>
<li>
Shared pool (SHARED_POOL_SIZE);
</li>
<li>
Large pool (LARGE_POOL_SIZE);
</li>
<li>
Java pool (JAVA_POOL_SIZE);
</li>
<li>
Streams pool (STREAMS_POOL_SIZE);
</li>
</ul>

As you can see, Oracle automatically tunes five SGA components, which we call automatically sizable SGA parameters. You must still manage the remaining SGA components yourself, even with automatic memory management.

Below are the manually tuned SGA components:

<ul>
<li>
Keep buffer cache (DB_KEEP_CACHE_SIZE);
</li>
<li>
Recycle buffer cache (DB_RECYCLE_CACHE_SIZE);
</li>
<li>
All non-standard block size buffer caches (DB_nK_CACHE_SIZE);
</li>
<li>
Redo log buffer (LOG_BUFFER).
</li>
</ul>

Note that the first three components in this list are optional. As a database administrator, you must set the values of all manual SGA components.

<br/>
<h3> Memory Management Options and Defaults in Database Installation</h3>

When you create a database using Database Configuration Assistant (DBCA) and if you select the basic installation option, automatic memory management is enabled by default. If instead you prefer the advanced installation option, you will need to select one of the following three memory configurations:

<ul>
<li>
Automatic Memory Management;
</li>
<li>
Automatic Shared Memory Management plus Automatic PGA Memory Management;
</li>
<li>
Manual Shared Memory Management plus Automatic PGA Memory Management.
</li>
</ul>

If you create a database with the CREATE DATABASE statement and do not specify any initialization parameters related to memory management, manual shared memory management is taken by default. For PGA, the default configuration will be automatic memory management.
