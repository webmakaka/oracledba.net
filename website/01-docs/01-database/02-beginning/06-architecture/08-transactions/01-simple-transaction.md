---
layout: page
title: Simple Oracle Database Transaction
description: Simple Oracle Database Transaction
keywords: Oracle Database, Transaction
permalink: /docs/architecture/transactions/simple-transaction/
---

# Simple Oracle Database Transaction

<br/>

So far, you have become acquainted with the components of the Oracle database system: the necessary files and memory allocation, as well as ways to configure them. Now it's time to see how Oracle processes user queries and how it performs data changes. It is important to understand the mechanics of SQL transaction processing because all interaction with the Oracle database occurs either in the form of SQL queries that read data, or SQL (or PL/SQL) operations that modify, insert, or delete data.

A transaction is a logical unit of work in an Oracle database, consisting of one or more SQL statements. A transaction begins with the first executable SQL statement and ends when you commit or roll back the transaction. Committing a transaction makes permanent the changes you made, while rolling back, of course, undoes them. Once you commit a transaction, all other users' transactions that started after it will be able to see the changes made by your transactions.

When a transaction cannot complete at all (say, due to a power outage), the entire transaction must be undone. Oracle rolls back all changes made by preceding SQL statements, returning the data to its original state (which it had before the transaction began). The entire process is designed to maintain data integrity – i.e., the "all or nothing" concept.

The following simple example of inserting a row describes how Oracle processes a transaction.

1. The user requests a connection to the Oracle server through a 3-tier or n-tier client, using Oracle Net Services. <br/>
2. After verifying the request, the server starts a new dedicated server process for this user. <br/>
3. The user executes a statement to insert a new row into the table. <br/>
4. Oracle checks the user's privileges to ensure they have the necessary rights to perform the insert. If the user's privilege information is not yet in the library cache, it will be read from disk into this cache. <br/>
5. If the user has the necessary privileges, Oracle checks whether a similar SQL statement has been executed recently and whether it is in the shared pool. If so, Oracle executes this version of the SQL statement; otherwise, it parses and executes the new user SQL statement. Oracle then creates a private SQL area in the PGA of the user session. <br/>
6. First, Oracle checks whether the needed data is in the buffer cache. If not, the server process reads the necessary table from the data files on disk. <br/>
7. Oracle immediately applies row-level locks where necessary, preventing other processes from attempting to modify the same data concurrently. <br/>
8. The server writes change vectors to the redo log buffer. <br/>
9. The server modifies the table data (inserts the new row) into the data buffer cache. <br/>
10. The user commits the transaction, finalizing the insert. Oracle releases row locks after the commit completes. <br/>
11. The log writer process immediately writes the changed data from the redo log buffers to the online log file. <br/>
12. The server process sends a message to the client process, signaling the successful completion of the INSERT operation. In this case, the message will contain "COMMIT COMPLETE". (If it cannot complete the query successfully, it sends a message indicating operation failure). <br/>
13. The changes made to the table through the insert may not be immediately written to disk. The database writer process writes in batches, so some time may pass before the inserted information actually reaches the data file on disk.

<br/>

### Commit and Rollback

You must clearly understand two fundamental terms related to transactions: committing and rolling back transactions. Below, both terms are briefly explained.

<br/>
<strong>Committing a transaction</strong>

When you commit a transaction, say, with the COMMIT statement, Oracle makes all changes made by all SQL statements within that transaction a permanent part of the database. Before Oracle commits the transaction results, it does the following.

<ul>
<li>
Generates undo information, which consists of the data values to be modified, before changes. This data is stored in an undo segment located in the undo tablespace.
</li>
<li>
It also generates redo data containing changes to data blocks and undo blocks, in the redo log buffer. The database can write the contents of the redo log buffers to disk before committing transactions.
</li>
<li>
Makes changes to the database buffers in the SGA. The database can write modified buffers to disk before committing the transaction.
</li>
</ul>

The database can write transaction changes that were executed first from the database buffers in the SGA to data files immediately or some time after the transaction commit, or even before its commit. When the database commits a transaction, it does the following.

<ul>
<li>
The database assigns and writes an SCN for the transaction being committed.
</li>

<li>
The log writer writes redo log entries to the redo log file on disk from the redo log buffer in the SGA: it also writes the transaction SCN to the redo log file, thereby marking the official commit of the transaction.
</li>
<li>
The database releases all table and row locks.
</li>
<li>
The database marks the transaction as complete.
</li>
</ul>

<br/>
<strong>Rolling back a transaction</strong>

Changes made by a transaction that have not yet been committed can be undone with the ROLLBACK command. While the redo log contains all changes made during a transaction, the undo segment contains all old values that existed before the changes were made. You can either roll back changes made by the entire transaction, or simply return to a marker that you placed earlier within the transaction, called a savepoint. There are several types of rollback, including those listed below:

<ul>
<li>
User-requested rollback.
</li>
<li>
Rollback due to abnormal process or instance termination.
</li>
<li>
Rollback of uncommitted transactions during recovery.
</li>
<li>
Statement-level rollback due to an error in executing that statement.
</li>
</ul>

<br/>

Regardless of the rollback reason, the procedure is always the same.

<ul>
<li>
The database uses the data in its pre-change form in the undo tablespace to undo all changes made during the transaction.
</li>
<li>
The database releases all transaction and table locks.
</li>
<li>
The database terminates the transaction.
</li>
</ul>

<br/>

### Data Integrity and Concurrency

A database would not be very useful if multiple users could not access and modify data simultaneously. Concurrency refers to the ability of a database to provide parallel access for multiple users. To ensure consistent results, the database needs a mechanism that guarantees users won't run into each other's changes. Data consistency is the ability for a user to get a consistent view of data, including all changes made to it by other users.

To ensure data consistency, Oracle uses special structures called undo segments. For example, when you read a data set for a transaction, Oracle ensures that the read data is consistent with a set of transactions, i.e., it guarantees that the data you see reflects one set of committed transactions. Oracle also provides read consistency, meaning that all data selected by your queries belongs to the same point in time. Oracle's undo segments are part of the undo tablespace mentioned earlier in this chapter.

Oracle uses a locking mechanism to ensure data concurrency. By allowing one user to lock individual rows or entire tables, it guarantees them exclusive use of the table for update purposes. An important characteristic of Oracle's locking mechanisms is that they mostly occur automatically. You don't need to worry about the details of locking objects you want to modify – Oracle handles it "behind the scenes."

Oracle uses two basic locking models. The exclusive locking model is used for updates, while the shared locking model is used for SELECT operations on tables. The shared locking model allows multiple users to read the same table rows simultaneously. The exclusive locking model, since it involves updating the table, can only be used by one user at any given moment. Exclusive locks are almost always applied to specific rows being updated, allowing many users to use the database simultaneously. After executing a COMMIT or ROLLBACK command, Oracle automatically releases locks on tables and other important resources.

Oracle locks are complex, and you will become familiar with them in detail in Chapter 8, along with how Oracle ensures consistency and concurrency.

<br/>

### Database Writer and Write-Ahead Log Protocol

The database writer, as you saw earlier, is responsible for writing all modified buffers from the database buffer cache to data files. In addition, it monitors the availability of free space in the buffer cache so that the server process can read new data from data files when needed. The write-ahead log protocol also requires that redo entries in the redo log buffer associated with modified information in the buffer cache be written to the redo log buffer before they are reflected in data files. The importance of redo log content dictates that Oracle must write the contents of the redo log file to permanent storage before data changes are made to the data files on disk.

When a user commits a transaction, the log writer process immediately writes a commit record to the redo log files. The complete set of records affected by the committed transaction may not be written simultaneously to the data files. The fast commit mechanism, along with the write-ahead log, ensures that the database does not have to wait for all physical write operations to complete after each transaction. As you can imagine, large OLTP databases with numerous changes throughout the day could not function optimally if they had to perform disk writes after each committed data change.

With a huge number of transactions and, consequently, a huge number of commit requests, the log writer process may not immediately write each committed transaction record to the redo log. It may accumulate several commit requests if it is very busy at that moment. This batched writing of information about multiple committed transactions is called group commit.

<br/>

### System Change Number

The system change number, or SCN, is an important evaluation factor used by the Oracle database to track the state at any given point in time. When you read (SELECT) data in tables, you don't affect the database state, but when you modify, insert, or delete a row, the database state changes relative to what it was before the operation. Oracle uses SCN to track all changes made to the database over time. SCN is a logical timestamp used by Oracle to order events occurring in the database. SCN is very important for several reasons, not least of which is database recovery after a failure.

SCNs are like incrementing sequence numbers, and Oracle first increments them in the SGA. When a transaction modifies or inserts data, Oracle first writes a new SCN to the rollback segment. The log writer process then immediately writes the transaction commit record to the redo log, and this record gets a unique SCN for the new transaction. Writing this SCN to the redo log effectively marks the committed transaction in the Oracle database.

SCN helps Oracle determine the need for recovery after a failure, after an abrupt instance shutdown, or after issuing a SHUTDOWN ABORT command. Whenever the database performs a checkpoint operation, Oracle writes a START SCN to the data file headers. The control file maintains an SCN value for each data file, called the STOP SCN, which is usually set to infinity, and whenever the instance shuts down normally (with SHUTDOWN NORMAL or SHUTDOWN IMMEDIATE), Oracle copies the START SCN in the data file headers to the STOP SCN for data files in the control file. When you restart the database after a successful shutdown, no recovery is needed because the SCN numbers in the data files and control files match. On the other hand, an abrupt instance shutdown leaves no time to align the SCN numbers, and Oracle detects the need for instance recovery because the SCN numbers in the data files on one side, and the control file on the other, differ. They play a key role in database recovery. Oracle determines how far back to go by applying archive redo logs during SCN-based recovery.

<br/>

### Undo Management

When you make changes to the database, you must be able to undo or roll back that change if necessary. The information needed to undo or roll back transaction changes, which mainly consists of table information prior to the change, is called undo data (change vectors) and is stored in undo records. When a ROLLBACK command is issued, Oracle uses these undo records to replace the changed data with their original versions. Undo records are vital for database recovery when incomplete or uncommitted transactions must be undone to leave the database in a consistent state.

Oracle strongly recommends using Automatic Undo Management (AUM), where the Oracle server itself maintains and manages undo segments. All you need to do is provide a dedicated undo tablespace and set the UNDO_MANAGEMENT initialization parameter to auto. Oracle will create the necessary number of undo segments, which are structurally similar to traditional rollback segments, and will expand them as needed. It is not unusual for new undo segments to be created and old ones deactivated depending on the number of transactions being performed in the database.

Since Oracle independently manages the sizes of individual undo segments, the two decisions you must make concern the size of the undo tablespace and the setting of the UNDO_RETENTION initialization parameter (which determines how long Oracle will try to retain undo records for you in the undo tablespace). Remember that your undo tablespace must not only accommodate all long-running transactions but also be large enough to allow all the flashback features you may implement in your database; Oracle's flashback features allow you to undo data changes at various levels. Some of them, such as Flashback Query, Flashback Versions Query, and Flashback Table, use undo data.

You can use Oracle's Undo Advisor through OEM to find the ideal size for undo tablespaces and the ideal duration to specify for the UNDO_RETENTION parameter. Through statistics of current undo space usage, you can estimate the optimal parameters for undo data generation for your instance.
