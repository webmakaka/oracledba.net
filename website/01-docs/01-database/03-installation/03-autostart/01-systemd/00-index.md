---
layout: page
title: Configuration files for autostarting Oracle using systemd
description: Configuration files for autostarting Oracle using systemd
keywords: Oracle, linux, installation, autostart, systemd
permalink: /database/installation/autostart/systemd/
---

# Configurations for autostarting Oracle using systemd

<br/>

### LISTENER

Create file: **/lib/systemd/system/listener.service**

<br/>

```ini
[Unit]
Description=Oracle Net Listener
After=network.target

[Service]
User=oracle
Group=oinstall
Type=forking
Environment="ORACLE_HOME=/u01/app/oracle/product/11.2.0/dbhome"
ExecStart=/u01/app/oracle/product/11.2.0/dbhome/bin/lsnrctl start
ExecStop=/u01/app/oracle/product/11.2.0/dbhome/bin/lsnrctl stop

[Install]
WantedBy=multi-user.target
```

<br/>

### DATABASE

Create file: **/lib/systemd/system/oracle.service**

<br/>

```ini
[Unit]
Description=The Oracle Database Service
After=syslog.target network.target listener.service

[Service]
LimitMEMLOCK=infinity
LimitNOFILE=65535
RemainAfterExit=yes
User=oracle
Group=oinstall
Restart=no
Environment="ORACLE_HOME=/u01/app/oracle/product/11.2.0/dbhome"
ExecStart=/u01/app/oracle/product/11.2.0/dbhome/bin/dbstart $ORACLE_HOME
ExecStop=/u01/app/oracle/product/11.2.0/dbhome/bin/dbshut $ORACLE_HOME

[Install]
WantedBy=multi-user.target
```

<br/>

### Startup

Enable autostart in **/etc/oratab** file

<br/>

```ini
dbname:/u01/app/oracle/product/11.2.0/dbhome:Y
```

<br/>

**Add to autostart:**

```shell
systemctl daemon-reload
systemctl enable listener.service --now
systemctl enable oracle.service --now
```

<br/>

**Taken from:**  
https://t.me/oracledba_net/9021
