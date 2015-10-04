---
layout: page
title: Oracle DataBase Server 12.1 installation on Oracle Linux 6.7 with ASM and GRID - Creating folder structure for Oracle
permalink: /database/installation/single/asm/linux/6.7/oracle/12.1/create-folder-structure-and-user-permissions/
---


# <a href="/database/installation/single/asm/linux/6.7/oracle/12.1/">[Oracle DataBase Server 12.1 installation on Oracle Linux 6.7 with ASM and GRID]</a>: Creating folder structure for Oracle


	# mkdir -p /u01/oracle/database/12.1
	# mkdir -p /u01/oracle/grid/12.1

	# chown -R oracle12:oinstall /u01/oracle
	# chmod -R 775 /u01/oracle

	# mkdir -p /u01/oraInventory
	# chown -R oracle12:oinstall /u01/oraInventory
	# chmod -R 775 /u01/oraInventory
