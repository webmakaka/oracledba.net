---
layout: page
title: Creating Tablespaces
description: Creating Tablespaces
keywords: Oracle Database, Tablespaces
permalink: /docs/architecture/tablespaces/create-new-tablespace/
---

<hr>

Taken from http://subscribe.ru/archive/comp.soft.db.oraclefromzero/200304/03160028.html<br/>
Slightly edited.

# Overview of Tablespaces

<p>An Oracle tablespace is the lowest logical layer of the data
  structure. It consists of one or more data files. In early versions of Oracle
  RDBMS, the size of data files was fixed, but now files can be increased
  either automatically or manually.</p>
<p>The significance of tablespaces is that they provide a great
  degree of granularity for the location of information in data files. After creating
  a tablespace, the process of locating and distributing tables within it is
  beyond your control. With careful configuration of the tablespace,
  you will have a few generalized options, but the bulk of the work for internal
  object placement will be done automatically.</p>

<p>Tablespaces can contain any of four types of segments:</p>
<blockquote>
  <p>- <b>Data segments</b> - the main type, used for
    storing tables and clusters.<br>
    - <b>Index segments</b> - used for storing indexes.<br>
    - <b>Rollback segments</b> - special segments that store
    information for undoing performed actions.<br>
    - <b>Temporary segments</b> - used for storing
    temporary data.</p>
</blockquote>
<p>Tablespaces are by default available for both reading
  and writing, but can be changed to read-only state.
  In many situations, read-only tablespaces can be
  indispensable.</p>

  <h3>Creating Tablespaces</h3>

<p>Creating tablespaces consists of specifying one or more data
  files, as well as storage parameters. Storage parameters
  specify how the tablespaces will be used.</p>
<p>Like most other operations, tablespaces can be created
  either using Oracle Enterprise Manager (graphically) or using
  sqlplus console commands.</p>

<h4>Creating a tablespace with the CREATE TABLESPACE command</h4>

<p>You can create a tablespace in the sqlplus console using the
  CREATE TABLESPACE command. The command can be entered
  interactively or executed from a prepared script file. In my opinion, it is preferable to use an SQL script
  as it can be re-executed. In addition, you can create a template and
  make changes as needed. A saved SQL script can be very
  handy after a disaster. So, to create a tablespace,
  the following command is used:</p>
<h5><font color="#0000FF">CREATE TABLESPACE</font><br>
  <font color="#0000FF">DATAFILE</font><font color="#666666"> <font color="#000099">file_specification</font><br>
  [AUTOEXTEND OFF]<br>
  <font color="#000099">or</font> [AUTOEXTEND ON [NEXT <font color="#000099">number</font>
  K <font color="#000099">or</font> M] <br>
  [MAXSIZE UNLIMITED <font color="#000099">or</font> MAXSIZE <font color="#000099">number</font>
  K <font color="#000099">or</font> M]<br>
  [NOLOGGING <font color="#000099">or</font> LOGGING]<br>
  [,<font color="#000099"> file_specification</font><br>
  [AUTOEXTEND OFF]<br>
  <font color="#000099">or</font> [AUTOEXTEND ON [NEXT <font color="#000099">number</font>
  K <font color="#000099">or</font> M] <br>
  [MAXSIZE UNLIMITED <font color="#000099">or</font> MAXSIZE <font color="#000099">number</font>
  K <font color="#000099">or</font> M]<br>
  [NOLOGGING <font color="#000099">or</font> LOGGING]]<br>
  [MINIMUM EXTENT <font color="#000099">number</font> K <font color="#000099">or</font>
  M]<br>
  [DEFAULT STORAGE <font color="#000099">storage_clause</font>]<br>
  [ONLINE <font color="#000099">or</font> OFFLINE]<br>
  [PERMANENT <font color="#000099">or</font> TEMPORARY]</font></h5>
<p><b><font color="#0000FF">DATAFILE</font></b></p>
<blockquote>
  <p>- <b>DATAFILE file_specification</b> - defines the names (or name) of data
    files that make up the tablespace. File_specification is 'filename'
    SIZE number (K or M) [REUSE]. The file specification is used to specify
    the name and initial size in (K)ilobytes or (M)egabytes of the data file.
    The [REUSE] parameter allows you to reuse an existing file in the system.</p>
</blockquote>

<p>Clarifications for the DATAFILE parameter:</p>
<blockquote>
  <p>- <b>AUTOEXTEND OFF</b> - the parameter indicates that automatic file size
    increase will not be used.</p>
  <p>- <b>AUTOEXTEND ON</b> - automatic file size increase will be used.
    Additionally, you can specify:</p>
  <p> - <b>NEXT number K or M</b> - when the data file auto-extends, it grows
    by the specified amount.</p>
  <p> - <b>MAXSIZE UNLIMITED</b> - the file size will be limited only by the physical
    disk and operating system features.</p>
  <p> - <b>MAXSIZE number K or M</b> - the data file cannot be larger than the specified
    size.</p>
</blockquote>
<p>Here are the remaining parameters of the CREATE TABLESPACE command:</p>
<blockquote>
  <p>- <b>LOGGING</b> - indicates that information about tables, indexes, and
    partitions will be written to the operation log. Default parameter.
    Logging can be disabled for these operations with the NOLOGGING option.</p>
  <p>- <b>NOLOGGING</b> - logging will not be performed for operations that support
    this option.</p>
  <p>- <b>MINIMUM EXTENT number K or M</b> - specifies the minimum extent size
    for the tablespace.</p>
  <p>- <b>DEFAULT STORAGE storage_clause</b> - specifies default
    storage parameters for the tablespace.</p>
  <p>- <b>ONLINE</b> - the tablespace becomes online immediately after
    its creation.</p>
  <p>- <b>OFFLINE</b> - the tablespace is unavailable immediately after
    its creation (until it is brought back online).</p>
  <p>- <b>TEMPORARY</b> - the tablespace will be used for storing
    temporary objects.</p>
  <p>- <b>PERMANENT </b>- indicates the tablespace will store permanent
    objects. (Default option).</p>
</blockquote>
<p>As you can see, when creating a tablespace, you can specify many different
  parameters and options. Among them are storage parameters, which we will look at
  a little later in this issue. Storage parameters determine the characteristics of the tablespace
  and the general parameters of its "growth".</p>

<h3>Modifying Tablespaces</h3>

<p>Quite often you have to modify an already created tablespace.</p>

<h4><b>Taking a tablespace offline</b></h4>

<p>There are several options for performing this operation: normal, temporary,
  and immediate taking offline.</p>

<h4><b>Tablespace in normal offline mode</b></h4>

<p>Taking a tablespace offline involves performing
  a checkpoint for all data files (belonging to this tablespace),
  and then, actually, disabling access. Normal taking offline
  requires the presence and normal functioning of all included tablespaces.
  Transition from normal offline state to online can
  be performed without recovery.</p>

<h4><b>Tablespace in temporary offline mode</b></h4>

<p>Taking a tablespace offline with the Temporary option
  is possible even if some of the data files are unavailable. That is,
  if you have any problems with a data file, you can take the tablespace
  offline with the "temporary" option. A checkpoint will be performed
  for all available data files. However, transitioning back
  to online mode may require recovery.</p>

<h4><b>Immediate taking a tablespace offline</b></h4>

<p>The Immediate option for taking a tablespace
  offline does exactly what is required: immediately takes the tablespace
  offline. But a checkpoint will not be performed, so returning
  to online mode will require a recovery procedure.</p>

<h4>Bringing a tablespace online</h4>

<p>Any tablespace that has been taken offline for
  any reason can be brought back online through
  Enterprise Manager or Server Manager (using SQL commands).
  Bringing a tablespace online changes its state so
  that the tablespace becomes available to users.
  A recovery procedure may be required, depending on how the
  tablespace was taken offline.</p>

<h4>Tablespace defragmentation</h4>

<p>Since space is allocated in a tablespace for schema objects in extents
  of various sizes, a situation becomes possible where disk space
  becomes fragmented. After allocating extents, Oracle looks for a free piece of memory
  close in size to what is needed for a new extent. From time to time in a
  tablespace, extents are added and freed, so you can find
  many small free extents clustered together (the process resembles file
  fragmentation on a hard disk).</p>
<p>By defragmenting a tablespace, you merge small free extents
  into larger ones, thereby creating more space for allocating new extents.<br>
  The background server process SMON automatically performs the merging
  of small free extents, i.e., defragmentation. Naturally, defragmentation
  occurs constantly, except when the SMON process is disabled.
  Very rarely there is a need to perform defragmentation manually, however
  you need to know why and how to do it.</p>

<h4>Adding data files</h4>

<p>The need for new data files arises quite often. New data
  files are needed either to increase free space or to distribute
  I/O load among multiple physical disk drives.
  Adding a file to a tablespace is much faster than creating it
  during database creation. The CREATE TABLESPACE command works sequentially,
  i.e., it creates one data file at a time. The operation of adding data files can
  be parallelized (multiple data files can be added at once).</p>

  <h3>Modifying Tablespace Properties</h3>

<p>A tablespace can be modified in Storage Manager or using the
  ALTER TABLESPACE command (which can be executed in Server Manager).</p>

<p>You can use the following possible options:</p>
<blockquote>
  <p>- <b>Online</b> - brings the tablespace online<br>
    - <b>Offline</b> - takes the tablespace offline<br>
    - <b>Read Only</b> - switches the tablespace to read-only mode<br>
    - <b>Permanent</b> - changes a temporary tablespace to permanent<br>
    - <b>Temporary</b> - changes a permanent tablespace to temporary</p>
</blockquote>

<h4>Modifying a tablespace with the ALTER TABLESPACE command</h4>

<p>As you can see, the Enterprise Manager tablespace editing dialog
  has a limited number of options. When using the ALTER TABLESPACE command, absolutely
  all capabilities are available. This command can be used to change
  the parameters of a tablespace specified during its creation, to change
  the state of the tablespace, or to add data files.</p>

<h4>ALTER TABLESPACE command syntax</h4>

<h5><font color="#0000FF">ALTER TABLESPACE tablespace</font><br>
  <font color="#666666">[LOGGING <font color="#000099">or</font> NOLOGGING]<br>
  [ADD DATAFILE <font color="#000099">file_specification</font><br>
  [AUTOEXTEND OFF]<br>
  <font color="#000099">or</font> [AUTOEXTEND ON [NEXT <font color="#000099">number</font>
  K <font color="#000099">or</font> M] <br>
  [MAXSIZE UNLIMITED <font color="#000099">or</font> MAXSIZE <font color="#000099">number</font>
  K <font color="#000099">or</font> M]]<br>
  [, <font color="#000099">file_specification</font><br>
  [AUTOEXTEND OFF]<br>
  <font color="#000099">or</font> [AUTOEXTEND ON [NEXT <font color="#000099">number</font>
  K <font color="#000099">or</font> M] <br>
  [MAXSIZE UNLIMITED <font color="#000099">or</font> MAXSIZE <font color="#000099">number</font>
  K <font color="#000099">or</font> M]]<br>
  [RENAME DATAFILE '<font color="#000099">filename</font>' [, '<font color="#000099">filename</font>']...
  <br>
  TO '<font color="#000099">filename</font>' [, '<font color="#000099">filename</font>']...]<br>
  [COALESCE]<br>
  [DEFAULT STORAGE <font color="#000099">storage_clause</font>]<br>
  [MINIMUM EXTENT <font color="#000099">number</font> [K <font color="#000099">or</font>
  M]]<br>
  [ONLINE]<br>
  [OFFLINE NORMAL <font color="#000099">or</font> OFFLINE TEMPORARY <font color="#000099">or</font>
  OFFLINE IMMEDIATE]<br>
  [BEGIN BACKUP <font color="#000099">or</font> END BACKUP]<br>
  [READ ONLY <font color="#000099">or</font> READ WRITE]<br>
  [PERMANENT <font color="#000099">or</font> TEMPORARY]</font></h5>
<p>Many of the parameters of this command are already familiar to us. For example, LOGGING and NOLOGGING
  are analogous to the corresponding parameters of the CREATE TABLESPACE command. Also, I think
  the keywords AUTOEXTEND, NEXT, MAXSIZE, MINIMUM
  EXTENT, PERMANENT and TEMPORARY need no comment.</p>
<blockquote>
  <p>- <b>ADD DATAFILE file_specification</b> - this parameter specifies one
    or more data files to add to the tablespace. (What
    file_specification is, we have already discussed above)</p>
  <p>- <b>RENAME DATAFILE 'filename' [, 'filename']... TO 'filename' [, 'filename']
    </b>- the command parameter is used to rename one or more data
    files.</p>
  <p>- <b>COALESCE</b> - the parameter is used to force
    tablespace defragmentation, as described earlier.</p>
  <p>- <b>DEFAULT STORAGE storage_clause </b>- specifies the default
    storage parameters for the tablespace. These parameters are used when creating
    new schema objects (if, of course, they are not explicitly specified when creating
    a specific object).</p>
  <p>- <b>ONLINE</b> - the parameter is used to bring the tablespace
    online.</p>
  <p>- <b>OFFLINE NORMAL</b> - takes the tablespace offline in normal
    mode.</p>
  <p>- <b>OFFLINE TEMPORARY</b> - takes the tablespace offline in temporary
    mode.</p>
  <p>- <b>OFFLINE IMMEDIATE</b> - immediately takes the tablespace
    offline.</p>
  <p>-<b> BEGIN BACKUP</b> - Places the tablespace in backup mode
    and suspends any changes to data files during backup
    creation.</p>
  <p>- <b>END BACKUP</b> - Takes the tablespace back
    online and writes all changes to data files that occurred during
    backup creation.</p>
  <p>- <b>READ ONLY</b> - Switches the tablespace to read-only mode.</p>
  <p>- <b>READ WRITE</b> - Switches the tablespace from read-only
    mode to normal, allowing both reading and writing of data files.</p>
</blockquote>
<p>As you can see, with the ALTER TABLESPACE command, a tablespace can be changed
  radically. Therefore, it is useful to keep a log of tablespace changes.</p>

<h4>STORAGE clause</h4>

<p>In the CREATE TABLESPACE and ALTER TABLESPACE commands, there is a "DEFAULT
  STORAGE storage_clause" parameter. Here we will discuss the storage_clause parameters in detail.
  These are quite important parameters, as they determine the initial size
  and characteristics of the tablespace, as well as its further growth.</p>

<p>Remember that the DEFAULT STORAGE clause is used to create extents.
  And extents are used to store schema objects. The storage parameters specified
  in DEFAULT STORAGE are applied when creating and growing schema objects. Schema
  objects that are created with specific storage parameters do not use
  the default storage parameters.</p>

<p>The STORAGE clause has the following syntax:</p>
<h5><font color="#0000FF">STORAGE</font><br>
  <font color="#666666">(<br>
  [INITIAL <font color="#000099">number</font> K <font color="#000099">or</font>
  M]<br>
  [NEXT <font color="#000099">number</font> K <font color="#000099">or</font>
  M]<br>
  [MINEXTENTS <font color="#000099">number</font>]<br>
  [MAXEXTENTS <font color="#000099">number or</font> MAXEXTENTS UNLIMITED]<br>
  [PCTINCREASE <font color="#000099">number</font>]<br>
  [FREELISTS <font color="#000099">number</font>]<br>
  [FREELIST GROUPS <font color="#000099">number</font>]<br>
  [OPTIMAL [<font color="#000099">number</font> K <font color="#000099">or</font>
  M] <font color="#000099">or</font> [NULL]]<br>
  )</font></h5>
<p>Here is what the individual parts of the clause mean:</p>
<blockquote>
  <p>-<b> INITIAL number K or M</b> - specifies the initial size of extents
    that are created for new schema objects. Default is 5
    data blocks. When specifying a specific size (in kilobytes or megabytes),
    it is rounded to a multiple of 5 data blocks.</p>
  <p>- <b>NEXT number K or M</b> - specifies the size of subsequent extents. Also
    rounded to a multiple of 5 data blocks.</p>
  <p>- <b>MINEXTENTS number</b> - specifies the minimum number of extents allocated
    for a schema object at the time of its creation. Each of these extents
    is equal in size to INITIAL, and for subsequent ones, the size is calculated based on the
    NEXT and PCTINCREASE parameters. Default MINEXTENTS = 1, except for rollback
    segments (default MINEXTENTS = 2).</p>
  <p>- <b>MAXEXTENTS number</b> - maximum number of extents (including the first)
    for schema objects.</p>
  <p>-<b> MAXEXTENTS UNLIMITED</b> - the maximum number of extents is unlimited.
    Not recommended for any objects (except rollback segments).</p>
  <p>- <b>PCTINCREASE number</b> - determines the size of extents after the second (i.e.,
    starting from the third extent). The size of the initial extent is INITIAL.
    The size of the second extent is NEXT. If PCTINCREASE is not zero, then all
    subsequent extents will be determined as the previous extent size increased
    by the percentage PCTINCREASE. If PCTINCREASE is zero, then all subsequent extents
    will be equal in size to NEXT. Default PCTINCREASE = 50 (for rollback
    segments it defaults to zero).</p>
  <p>- <b>FREELISTS number</b> - specifies the number of free lists for each
    free list group. A free list is a linked list of available data
    blocks in an extent that has more free space than PCTFREE. Essentially,
    it is a list of blocks ready to accept information. When using more than one
    free list, you reduce insert conflicts.</p>
  <p>- <b>FREELIST GROUPS number</b> - specifies the number of free list
    groups in a parallel server environment. Using multiple groups
    allows each instance to have its own set of free lists.
    The parameter is used only in a parallel server environment.</p>
  <p>- <b>OPTIMAL number K or M</b> - the parameter is applicable only to rollback
    segments. It specifies the ideal segment size. As we will see in one of the following
    issues, a rollback segment constantly grows in size. This parameter specifies
    the size that Oracle should try to maintain.</p>
  <p>- <b>OPTIMAL NULL</b> - this parameter tells the rollback segment to never
    try to reduce its size (and bring it closer to the desired one, as in the previous
    parameter).</p>
</blockquote>
<p>Storage parameters can be applied not only during tablespace
  creation, but also during the creation of various schema objects. The size and characteristics
  of the tablespace have a significant impact on system
  performance.</p>
<p>Note: for tablespaces you specify DEFAULT STORAGE options (i.e.,
  default). These options will be applied when creating schema objects, unless
  you override them with new specific values.</p>

<h3>Read-Only Tablespaces</h3>

<p>As mentioned earlier, there is the ability to switch a tablespace
  to read-only mode. A read-only tablespace
  differs from a normal one only in that changes to schema
  objects are not saved. In this case, there is no need to back up such a
  tablespace.</p>
<p>Since read-only tablespaces are not modified
  by the Oracle server, it is possible to place them, for example, on a CD-ROM.
  If the data is archival in nature but periodically
  needed, using CD-ROM may be an ideal solution.</p>

<h4>Creating read-only tablespaces</h4>

<p>Any tablespace must initially be created in read-write mode
  and filled with the necessary data. After adding data and creating indexes
  according to your specifications, the tablespace can be switched
  to read-only mode. This can be achieved in several
  ways.</p>
<p>For Enterprise Manager or Storage Manager, simply open the tablespace
  editing form and check the Read Only checkbox.</p>
<p>If you then click the SHOW SQL button, you will be able to see
  the DDL command for this operation. I recommend using this button whenever
  convenient, as you will understand the essence of the operations being performed.</p>
<p>You can also use the ALTER TABLESPACE command like this:</p>
<h5>ALTER TABLESPACE CARS READONLY;</h5>
<p>There are many reasons for using read-only
  tablespaces, but they are very specific. Whether you need them or not is up to you.</p>

<h3>Temporary Tablespaces</h3>

<p>Temporary tablespaces are used to perform sort
  operations that do not fit into RAM. If you allocate a tablespace
  specifically for sorts, there will be no need to allocate memory
  in other tablespaces (which leads to fragmentation).</p>
<p>When a sort operation does not fit in memory, it must create and use
  a temporary segment. In this temporary segment, extents are allocated for the
  operation until there is enough space. When using large DSS queries
  (Decision Support System), these temporary segments can
  become truly gigantic. Using tablespaces specifically
  designed for such operations not only makes sorting more efficient,
  but also fewer temporary segments will be used in tablespaces
  with data.</p>

<h4>Creating temporary tablespaces</h4>

<p>A tablespace can become temporary either during creation (CREATE)
  or during modification (ALTER). When using Enterprise Manager, you
  simply need to check the Temporary checkbox in the create/modify tablespace
  dialog. The SQL command for performing this operation is:</p>

<h5>ALTER TABLESPACE CARS TEMPORARY;</h5>

<p>It's unlikely that you will ever need to switch permanent tablespaces
  to temporary and back. A temporary tablespace is usually
  created as such immediately, and it remains that way for its entire existence.</p>

<pre>

Locally vs. Dictionary Managed Tablespaces
http://www.orafaq.com/node/3

</pre>

<br/>

    CREATE TABLESPACE ts2 DATAFILE '/u02/oradata/ora112/myts2.dbf' SIZE 50M
          EXTENT MANAGEMENT LOCAL
          SEGMENT SPACE MANAGEMENT AUTO;
