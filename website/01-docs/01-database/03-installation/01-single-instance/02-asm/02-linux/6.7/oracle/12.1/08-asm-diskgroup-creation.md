---
layout: page
title: Oracle DataBase Server 12.1 installation on Oracle Linux 6.7 with ASM and GRID - Creating ASM disks groups
permalink: /database/installation/single/asm/linux/6.7/oracle/12.1/asm-diskgroup-creation/
---


# <a href="/database/installation/single/asm/linux/6.7/oracle/12.1/">[Oracle DataBase Server 12.1 installation on Oracle Linux 6.7 with ASM and GRID]</a>: Creating ASM disks groups



	$ asmca


<img src="http://img.oradba.net/oracle-database-installation/asm/linux/6.7/oracle/12.1/02-asm-diskgroup/asm-diskgroup_01.png" border="0" alt="ASM DISKGROUPS"><br/><br/>


<img src="http://img.oradba.net/oracle-database-installation/asm/linux/6.7/oracle/12.1/02-asm-diskgroup/asm-diskgroup_02.png" border="0" alt="ASM DISKGROUPS"><br/><br/>


<img src="http://img.oradba.net/oracle-database-installation/asm/linux/6.7/oracle/12.1/02-asm-diskgroup/asm-diskgroup_03.png" border="0" alt="ASM DISKGROUPS"><br/><br/>


<img src="http://img.oradba.net/oracle-database-installation/asm/linux/6.7/oracle/12.1/02-asm-diskgroup/asm-diskgroup_04.png" border="0" alt="ASM DISKGROUPS"><br/><br/>


<img src="http://img.oradba.net/oracle-database-installation/asm/linux/6.7/oracle/12.1/02-asm-diskgroup/asm-diskgroup_05.png" border="0" alt="ASM DISKGROUPS"><br/><br/>



To get some information about disk groups:

	$ asmcmd

	ASMCMD> ls
	ARCH/
	DATA/


	ASMCMD> lsdg
	State    Type    Rebal  Sector  Block       AU  Total_MB  Free_MB  Req_mir_free_MB  Usable_file_MB  Offline_disks  Voting_files  Name
	MOUNTED  NORMAL  N         512   4096  1048576     81918    81810                0           40905              0             N  ARCH/
	MOUNTED  NORMAL  N         512   4096  1048576    163836   163645            40959           61343              0             N  DATA/


	ASMCMD> exit
