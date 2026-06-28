---
layout: page
title: Indexes in Oracle Database
description: Indexes in Oracle Database
keywords: Oracle Database, Indexes
permalink: /docs/architecture/indexes/
---

# Indexes in Oracle Database

<br/>

Oracle indexes provide fast access to table rows by storing sorted values of specified columns and using these sorted values to quickly find associated table rows. Indexes allow you to find a row with a specific column value while scanning only a small portion of the total number of table rows. Thus, proper use of indexes minimizes expensive I/O operations.

Using indexes represents a trade-off between speeding up query results and slowing down updates and inserts. The first part of this trade-off – speeding up queries – is fairly obvious: if a search is performed on a sorted index instead of a full table scan, the query runs much faster. But whenever you update, insert, or delete a row in an indexed table, the indexes must also be updated accordingly. That is, such operations on tables with indexes are more expensive.

Generally speaking, if tables are primarily used for reading (selecting) information, as in data warehouses, it's better to have many indexes. If the database is of the OLTP type, with many inserts, updates, and deletes, it's better to have fewer indexes.

Unless you need to access most of the table rows, indexed queries provide faster result retrieval than queries that don't use indexes. There are no limits on the number of indexes that can belong to one Oracle table, but as mentioned earlier, performance depends on their number. An index is completely transparent to the user – i.e., the user's SQL statement does not need to change as a result of index creation. However, application developers should have a good understanding of what indexes are and how they work to build efficient queries.

Indexes can be of several types, the most important of which are listed below:

<ul>

<li> Unique and non-unique indexes. Unique indexes are based on a unique column – usually something like an employee's social security number. Although unique indexes can be created explicitly, Oracle does not recommend this. Instead, you should use unique constraints. When a unique constraint is placed on a table column, Oracle automatically creates unique indexes on those columns.</li>
<li> Primary and secondary indexes. Primary indexes are unique indexes on a table that must always have some value and cannot be null. Secondary indexes are other indexes on the table that may or may not be unique.</li>
<li> Composite indexes – indexes containing two or more columns from the same table. They are also known as concatenated indexes. Composite indexes are especially useful for ensuring uniqueness of a combination of table columns when there is no single column that uniquely identifies a row.</li>
</ul>

<br/>
<h2> Index Creation Guidelines</h2>

Although it's well known that indexes improve database performance, you should know how to make them work properly. Adding unnecessary or inappropriate indexes to a table can even lead to performance degradation. Below are some recommendations for creating effective indexes in Oracle Database.

<ul>
<li> An index makes sense if you need to access no more than 4-5% of the table data simultaneously. The alternative to using an index to access row data is a full sequential table read from start to finish, called a full table scan. Full table scan is more suitable for queries that require retrieving a larger percentage of table data. Remember that using indexes to retrieve rows requires two read operations: the index and then the table.</li>

<li> Avoid creating indexes on relatively small tables. Full table scans are more suitable for such tables. In the case of small tables, there is no need to store both data and indexes.</li>

<li> Create primary keys for all tables. When assigning a column as a primary key, Oracle will automatically create an index on that column.</li>
<li> Index columns involved in multi-table join operations.</li>
<li> Index columns that are frequently used in WHERE clauses.</li>
<li> Index columns involved in ORDER BY and GROUP BY operations or other operations such as UNION and DISTINCT that involve sorting. Since indexes are already sorted, the amount of work required to perform the necessary data sorting for the mentioned operations will be significantly reduced.</li>

<li> Long character string columns are usually poor candidates for indexing.</li>

<li> Columns that are frequently updated should ideally not be indexed due to the associated overhead.</li>
<li> Index tables where few rows have the same values.</li>
<li> Keep the number of indexes small.</li>
<li> Composite indexes may be needed where single-column values alone are not unique. In composite indexes, the first key column should be the column with the fewest rows having the same value.</li>
</ul>

Always remember the golden rule of table indexing: a table index should be based on the types of queries that will be executed on the table's columns. More than one index can be created on a table: for example, you can create an index on column X, or column Y, or both, as well as one composite index on both columns. When making the right decision about which indexes to create, think about the most frequently used types of queries on the table data.

<br/>
<h2> Oracle Index Schemes </h2>

Oracle offers several indexing schemes to meet the requirements of different types of applications. At the design phase, after a thorough analysis of specific application requirements, you need to choose the right type of index.

<br/>
<h2> B*tree</h2>

B-tree index implementation uses the concept of a balanced (indicated by the letter 'B') search tree as the basis of the index structure. Oracle has its own variant of B-tree. These are regular indexes created by default when you use the CREATE INDEX statement.

B-tree indexes are structured in the form of an inverted tree, where the top-level blocks are called branch blocks and the bottom-level blocks are called leaf blocks. In the node hierarchy, all nodes except the top, or root node, have a parent node and can have zero or more child nodes. If the depth of the tree structure, i.e., the number of levels, is the same from each leaf block to the root node, then such a tree is called a balanced tree, or B-tree.

B-trees automatically maintain the necessary index level based on table size. B-trees also guarantee that index blocks will always be filled at least half and less than 100%. B-trees allow select, insert, and delete operations with very few I/O operations per statement. Most B-trees have three or fewer levels. When using a B-tree, you only need to read the B-tree blocks, so the number of I/O operations will be limited to the number of B-tree levels (say, three) plus two I/O operations for update or delete (one for reading and one for writing). To perform a B-tree search, only three or fewer disk accesses are needed.

Oracle's B-tree implementation always keeps the tree balanced. Leaf blocks contain two elements: the indexed column values and the corresponding ROWID identifier for the row that contains this column value. ROWID is a unique Oracle pointer that identifies the physical location of a row and provides the fastest way to access a row in Oracle Database. Index scanning quickly gives the ROWID of a row, and from there you can quickly access it directly. If the query only needs the value of the indexed column, then of course the last step is skipped since no additional data beyond what was read from the index needs to be retrieved.

<br/>
<h2> Estimating Index Size</h2>

To estimate the size of a new index, you can use the DBMS_SPACE package. The CREATE_INDEX_COST procedure of this package requires the DDL statement creating the index as an attribute.

    SET SERVEROUTPUT ON
    DECLARE
    l_index_ddl varchar2(1000);
    l_used_bytes NUMBER;
    l_allocated_bytes NUMBER;
    BEGIN
    DBMS_SPACE.create_index_cost (
    ddl => 'create index repsons_idx on EMP(ENAME)',
    used_bytes => l_used_bytes,
    alloc_bytes => l_allocated_bytes);
    DBMS_OUTPUT.PUT_LINE ('RESULT:');
    DBMS_OUTPUT.PUT_LINE ('used_bytes = ' || l_used_bytes || ' byte');
    DBMS_OUTPUT.PUT_LINE ('alloc_bytes = ' || l_allocated_bytes || ' byte');
    END;
    /

Note the difference between the size-related attributes in the CREATE_INDEX_COST procedure:

<ul>
<li> Used_bytes shows the number of bytes representing the index data;</li>
<li> Alloc_bytes shows the number of bytes that the index will occupy in the tablespace after its creation. </li>
</ul>

<br/>
<h2> Creating an Index</h2>

An index is created using the CREATE INDEX statement
<br/><br/>

    CREATE INDEX employee_id ON employee(employee_id)
    TABLESPACE MY_INDEXES;

By default, Oracle allows duplicate values in index columns, which are also called key columns. However, you can specify a unique index, which will prevent duplicate column values in multiple rows.

To create a unique index, use the CREATE UNIQUE INDEX statement.

<br/>
<h2> Special Index Types</h2>

A normal or standard index created in the database is called a heap index, or unordered index. Oracle also provides several special types of indexes for specific needs.

<br/>
<h2> Bitmap Indexes</h2>

Bitmap indexes use bitmaps to indicate the value of the indexed column. This is an ideal index for a column with low cardinality (the number of unique records in the table is small) with a large table size. These indexes are generally not suitable for tables with intensive updates, but are well suited for data warehouse applications.

Bitmap indexes consist of a bit stream (ones and zeros) for each index column. Bitmap indexes are very compact compared to normal B-tree indexes.

<table border="1">
<tr>
<td>B-tree Indexes</td>
<td>Bitmap Indexes</td>
</tr>
<tr>
<td>Good for data with high cardinality</td>
<td>Good for data with low cardinality</td>
</tr>
<tr>
<td>Good for OLTP databases</td>
<td>Good for OLAP data warehouse applications</td>
</tr>
<tr>
<td>Take up a lot of space</td>
<td>Use relatively little space</td>
</tr>
<tr>
<td>Easy to update</td>
<td>Difficult to update</td>
</tr>
</table>

<br/>

To create a bitmap index, use the statement

    CREATE BITMAP INDEX  gender_dx ON employee(gender)
    TABLESPACE MY_INDEXES;

Sometimes you can observe significant performance improvements when replacing regular B-tree indexes with bitmap indexes on some very large tables. However, each bitmap index entry opens a huge number of rows in the table, so when data is updated, inserted, or deleted from the table, the necessary bitmap index updates are very large, and the index itself can significantly increase in size. The only way to avoid this index size increase with subsequent performance degradation is to rebuild it regularly. A bitmap index is not a very sensible alternative for tables subject to a large number of inserts, deletes, and updates.

<br/>
<h2> Reverse Key Indexes</h2>

Reverse key indexes are essentially the same as B-tree indexes, except that the bytes of the key column data are reversed during indexing. The column order remains untouched, only the byte order changes. The biggest advantage of using reverse key indexes is that they eliminate the unpleasant consequences of ordered insertion of values into an index. Here's how a reverse key index is created:

    SQL> CREATE INDEX reverse_idx ON employee(emp_id) REVERSE;

When using a reverse key index, the database does not store index keys one after another in lexicographic order. Thus, when a query contains an inequality predicate, the response is slower because the database must perform a full table scan. With a reverse key index, the database cannot run a range scan on the index key.

<br/>
<h2> Compressed Key Indexes</h2>

You can save index storage space while improving performance by creating a compressed key index. Whenever an indexed key has a repeating component, or a unique multi-column index is created, you benefit from using key compression. Here's an example:

    SQL> CREATE INDEX emp_indx1 ON employees(ename)
    TABLESPACE MY_INDEXES
    COMPRESS 1;

The above statement compresses all duplicated occurrences of the indexed key in the index leaf block (at level 1).

<br/>
<h2> Function-Based Indexes</h2>

Function-based indexes precompute the values of functions on a given column and store the result in the index. When a WHERE clause contains function calls, function-based indexes are the ideal way to index a column.

Below shows how to create an index based on the LOWER function

<br/>
<br/>

    SQL> CREATE INDEX lastname_idx ON employees(LOWER(l_name));

This CREATE INDEX statement will create an index on the l_name column, which stores employee last names in uppercase. However, this index will be function-based because the database will create it on the l_name column, first applying the LOWER function to convert its value to lowercase.

<br/>
<h2> Partitioned Indexes</h2>

Partitioned indexes are used to index partitioned tables. Oracle offers two types of indexes for such tables: local and global.

The essential difference between them is that local indexes are based on the partitions of the table on which they are created. If a table is partitioned into 12 partitions by date ranges, then the indexes will also be distributed across the same 12 partitions. In other words, there is a one-to-one correspondence between index partitions and table partitions. No such correspondence exists between global indexes and table partitions, because global indexes are partitioned independently of the base tables.

The following sections will reveal important differences between managing globally partitioned indexes and locally partitioned indexes.

<br/>

## Global Indexes

Global indexes on partitioned tables can be either partitioned or non-partitioned. Global non-partitioned indexes are similar to regular Oracle indexes for non-partitioned tables. The regular CREATE INDEX syntax is used to create such indexes.

Below is an example of a global index on the ticket_sales table:

    SQL> CREATE INDEX tickersales_idx ON ticket_sales(month)
    GLOBAL  PARTITION BY range(month)
    (PARTITION ticketsales1_idx VALUES LESS THAN (3)
    PARTITION ticketsales1_idx VALUES LESS THAN (6)
    PARTITION ticketsales2_idx VALUES LESS THAN (9)
    PARTITION ticketsales3_idx VALUES LESS THAN (MAXVALUE);

Note that managing globally partitioned indexes requires significant effort. Whenever a DDL operation is performed on a partitioned table, its global indexes need to be rebuilt. DDL operations on the underlying table mark global indexes as invalid. By default, any maintenance operation on a partitioned table invalidates global indexes.

Let's use the ticket_sales table as an example to understand why this is the case. Suppose you drop the oldest partition quarterly to free up space for a new partition that will contain data for the new quarter. When a partition belonging to the ticket_sales table is dropped, global indexes may become invalid because part of the data they point to ceases to exist. To prevent such index invalidation due to partition dropping, you need to use the UPDATE GLOBAL INDEXES option with the DROP PARTITION statement:

```
SQL> ALTER TABLE ticket_sales
DROP PARTITION sales_quarter01
UPDATE GLOBAL INDEXES;
```

If you don't include the UPDATE GLOBAL INDEXES clause, all global indexes will become invalid. You can also use the UPDATE GLOBAL INDEXES option when adding, coalescing, exchanging, merging, moving, splitting, or truncating partitioned tables. Of course, you can rebuild any index that becomes invalid using ALTER INDEX..REBUILD, but this option also requires additional time and maintenance.

For a small number of index leaf blocks, which leads to high contention, Oracle recommends using hash-partitioned global indexes. The syntax for creating a hash-partitioned global index is similar to that used for a hash-partitioned table. For example, the following statement creates a hash-partitioned global index:

```
SQL> CREATE INDEX hgidx ON tab (c1,c2,c3) GLOBAL
PARITION BY HASH (c1,c2)
(
PARTITION p1 TABLESPACE tsb_1,
PARTITION p2 TABLESPACE tsb_2,
PARTITION p3 TABLESPACE tsb_3,
PARTITION p4 TABLESPACE tsb_4,
);
```

<br/>
<h2> Local Indexes</h2>

Locally partitioned indexes, unlike globally partitioned indexes, have a one-to-one relationship with table partitions. Locally partitioned indexes can be created according to partitions and even subpartitions. The database constructs the index so that it is partitioned the same way as its table. Whenever a table partition is modified, the database automatically accompanies this with a corresponding modification of the index partition. This is perhaps the biggest advantage of using locally partitioned indexes – Oracle automatically rebuilds them whenever a partition is dropped or some other DDL operation is performed on it.

Below is a simple example of creating a locally partitioned index on a partitioned table:

    SQL> CREATE INDEX ticket_no_idx ON
    Ticket_sales(ticket_no) LOCAL
    TABLESPACE localidx_01;

<br/>
<h2> Invisible Indexes</h2>

By default, the optimizer "sees" all indexes. However, you can create an invisible index that the optimizer does not detect and does not consider when creating the statement execution plan. An invisible index can be used as a temporary index for certain operations or for testing before making it "official". Additionally, sometimes declaring an index invisible can be used as an alternative to dropping an index or declaring it unavailable. You can temporarily make an index invisible to test the effect of dropping it.

The database maintains an invisible index exactly the same way as a normal (visible) index. After declaring an index invisible, it and all other invisible indexes can be made visible again to the optimizer by setting the optimizer_use_invisible_index parameter to TRUE at the session or system level. The default value of this parameter is FALSE, meaning the optimizer cannot use invisible indexes by default.

Creating an invisible index.

To make an index invisible, add the INVISIBLE clause to the CREATE INDEX statement.

You can use the ALTER INDEX command to turn an existing index into an invisible one.

    ALTER INDEX test_idx INVISIBLE;

And the reverse command

    ALTER INDEX test_idx VISIBLE;

The following query to the DBA_INDEXES view shows the visibility status of an index:

    SQL> SELECT index_name, visibility
    FROM user_indexes
    WHERE index_name ='indx1';

<br/>
<h2> Monitoring Index Usage</h2>

If you are unsure about the usage of a particular index, you can ask Oracle to monitor its usage. Thus, if the index turns out to be redundant, you can drop it and save storage space as well as reduce DML overhead.

Let's describe what needs to be done to track an index in the database. Suppose you're trying to find out whether the p_key_sales index is used in certain queries on the sales table. Provide a representative time period for evaluating index usage. For an OLTP database, this period could be relatively short. For a data warehouse, you may need to run test monitoring for several days to accurately verify how the index is being used.

To start monitoring index usage, log in as the owner of the p_key_sales index and run the following command:

    SQL> ALTER INDEX p_key_sales MONITORING USAGE;

Now run some queries on the sales table. End monitoring by applying the following command:

    SQL> ALTER INDEX p_key_sales NOMONITORING USAGE;

After that, you can query the V\$OBJECT_USAGE data dictionary view to determine whether the p_key_sales index is being used.

    SQL> SELECT index_nm, used FROM v$object_usage
    WHERE index_name='P_KEY_SALES';

The reason you cannot know the number of index usages is related to the fact that the database monitors its usage only during the parsing phase; if parsing were performed at each execution, performance would suffer.

<br/>
<h2> Index Maintenance</h2>

Index data is constantly changing due to DML actions associated with its table. Indexes often become too large if many row deletions occur, because the space occupied by deleted values is not automatically reused by the index. By periodically applying the REBUILD command, you can reorganize indexes and make them more compact, and therefore more efficient. The REBUILD command also serves to change storage parameters that were set during the initial index creation.

    ALTER INDEX sales_idx REBUILD;

Rebuilding indexes is better than dropping and recreating a problematic index because during this operation users continue to have access to the index during the rebuild process. However, indexes being rebuilt impose many restrictions on user actions. An even more efficient way to rebuild indexes is to do it in online mode, as shown in the following example. During an online index rebuild, all DML operations are allowed, but not DDL operations.

    ALTER INDEX sales_idx REBUILD ONLINE;

An online index rebuild can be accelerated by adding the ONLINE NOLOGGING clause to the ALTER INDEX statement shown above. After adding this clause, the database will not generate redo data for the index rebuild operation.

<br/>

### Example query that shows which foreign keys are missing indexes

<br/>

```sql
select table_name, constraint_name,
        cname1 || nvl2(cname2,','||cname2,null) ||
        nvl2(cname3,','||cname3,null) || nvl2(cname4,','||cname4,null) ||
        nvl2(cname5,','||cname5,null) || nvl2(cname6,','||cname6,null) ||
        nvl2(cname7,','||cname7,null) || nvl2(cname8,','||cname8,null)
               columns
     from ( select b.table_name,
                   b.constraint_name,
                   max(decode( position, 1, column_name, null )) cname1,
                   max(decode( position, 2, column_name, null )) cname2,
                   max(decode( position, 3, column_name, null )) cname3,
                   max(decode( position, 4, column_name, null )) cname4,
                   max(decode( position, 5, column_name, null )) cname5,
                   max(decode( position, 6, column_name, null )) cname6,
                   max(decode( position, 7, column_name, null )) cname7,
                   max(decode( position, 8, column_name, null )) cname8,
                   count(*) col_cnt
              from (select substr(table_name,1,30) table_name,
                           substr(constraint_name,1,30) constraint_name,
                           substr(column_name,1,30) column_name,
                           position
                      from user_cons_columns ) a,
                   user_constraints b
             where a.constraint_name = b.constraint_name
               and b.constraint_type = 'R'
             group by b.table_name, b.constraint_name
          ) cons
    where col_cnt > ALL
            ( select count(*)
                from user_ind_columns i
               where i.table_name = cons.table_name
                 and i.column_name in (cname1, cname2, cname3, cname4,
                                       cname5, cname6, cname7, cname8 )
                 and i.column_position <= cons.col_cnt
               group by i.index_name
            )
```

<br/>

https://t.me/oracledba_net/8136
