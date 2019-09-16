---
layout: page
title: Oracle DataBase Server 12.1 installation on Oracle Linux 6.7 with ASM and GRID - Oracle instance creation
permalink: /database/installation/single/asm/linux/6.7/oracle/12.1/oracle-instance-creation/
---

# <a href="/database/installation/single/asm/linux/6.7/oracle/12.1/">[Oracle DataBase Server 12.1 installation on Oracle Linux 6.7 with ASM and GRID]</a>: Oracle instance creation


	$ export DISPLAY=192.168.1.5:0.0

<br/>

	$ dbca


<img src="https://img.oracledba.net/oracle-database-installation/asm/linux/6.7/oracle/12.1/04-oracle-instance-creation/oracle-instance-creation_01.png" border="0" alt="oracle database software installation"><br/><br/>


<img src="https://img.oracledba.net/oracle-database-installation/asm/linux/6.7/oracle/12.1/04-oracle-instance-creation/oracle-instance-creation_02.png" border="0" alt="oracle database software installation"><br/><br/>


<img src="https://img.oracledba.net/oracle-database-installation/asm/linux/6.7/oracle/12.1/04-oracle-instance-creation/oracle-instance-creation_03.png" border="0" alt="oracle database software installation"><br/><br/>


<img src="https://img.oracledba.net/oracle-database-installation/asm/linux/6.7/oracle/12.1/04-oracle-instance-creation/oracle-instance-creation_04.png" border="0" alt="oracle database software installation"><br/><br/>

<img src="https://img.oracledba.net/oracle-database-installation/asm/linux/6.7/oracle/12.1/04-oracle-instance-creation/oracle-instance-creation_05.png" border="0" alt="oracle database software installation"><br/><br/>


<img src="https://img.oracledba.net/oracle-database-installation/asm/linux/6.7/oracle/12.1/04-oracle-instance-creation/oracle-instance-creation_06.png" border="0" alt="oracle database software installation"><br/><br/>


<br/>
<br/>

To get EM connection port:

	SQL> select dbms_xdb_config.gethttpsport() from dual;

	DBMS_XDB_CONFIG.GETHTTPSPORT()
	------------------------------
				  5500



For connect to EM:  
https://192.168.1.11:5500/em/


<br/>

### Steps after installation

	$ vi /etc/oratab

<br/>

	+ASM:/u01/oracle/grid/12.1:N
	orcl12:/u01/oracle/database/12.1:N

replace on:

	+ASM:/u01/oracle/grid/12.1:Y
	orcl12:/u01/oracle/database/12.1:Y



<br/>

	SQL> select name, total_mb, free_mb from v$asm_diskgroup;

	NAME				 TOTAL_MB    FREE_MB
	------------------------------ ---------- ----------
	DATA				   163836     159704
	ARCH				    81918      81452
