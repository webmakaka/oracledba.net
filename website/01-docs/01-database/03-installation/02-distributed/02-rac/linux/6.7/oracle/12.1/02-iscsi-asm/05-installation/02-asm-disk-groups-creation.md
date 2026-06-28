---
layout: page
title: Oracle RAC 12.1 Installation on Oracle Linux 6.7 (ISCSI + ASM) - Creating ASM disk groups
description: Oracle RAC 12.1 Installation on Oracle Linux 6.7 (ISCSI + ASM) - Creating ASM disk groups
keywords: Oracle DataBase 12.1, Oracle Linux 6.7, RAC, (ISCSI + ASM)
permalink: /database/installation/single/asm/linux/6.7/oracle/12.1/asm-disk-groups-creation/
---

# [Oracle RAC 12.1 Installation on Oracle Linux 6.7 (ISCSI + ASM)]: Creating ASM disk groups

To launch the console for working with ASM disks, run the command (if needed)

    $ asmca

<img src="https://img.oracledba.net/images/docs/01-oracle-database/02-installation/03-oracle-database-installation/02-distributed/02-rac/linux/6.7/oracle/12.1/02-iscsi-asm/02-asm-disks-group-creation/asm-disks-group-creation_01.png" border="0" alt="Creating ASM disk groups"><br/><br/>

<img src="https://img.oracledba.net/images/docs/01-oracle-database/02-installation/03-oracle-database-installation/02-distributed/02-rac/linux/6.7/oracle/12.1/02-iscsi-asm/02-asm-disks-group-creation/asm-disks-group-creation_02.png" border="0" alt="Creating ASM disk groups"><br/><br/>

<img src="https://img.oracledba.net/images/docs/01-oracle-database/02-installation/03-oracle-database-installation/02-distributed/02-rac/linux/6.7/oracle/12.1/02-iscsi-asm/02-asm-disks-group-creation/asm-disks-group-creation_03.png" border="0" alt="Creating ASM disk groups"><br/><br/>

<img src="https://img.oracledba.net/images/docs/01-oracle-database/02-installation/03-oracle-database-installation/02-distributed/02-rac/linux/6.7/oracle/12.1/02-iscsi-asm/02-asm-disks-group-creation/asm-disks-group-creation_04.png" border="0" alt="Creating ASM disk groups"><br/><br/>

Yes, I agree that too many resources are allocated for OCR. Really you need approximately 3 x 300 MB.

Just to get some information about disk groups

    $ asmcmd

    ASMCMD> ls
