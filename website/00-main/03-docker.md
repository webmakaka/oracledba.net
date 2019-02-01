---
layout: page
title: Docker Containers and Oracle
permalink: /docker-for-oracle/
---

# Docker Containers and Oracle

<br/>

### Oracle XE 11 inside Docker container

<br/>

**Container with Oracle XE 11:**  
<a href="https://github.com/wnameless/docker-oracle-xe-11g">here</a>

<br/>

    $ docker pull wnameless/oracle-xe-11g
    $ docker run -d --shm-size=2g -p 1521:1521 -p 8080:8080 wnameless/oracle-xe-11g

<br/>

Now you can connect to DB by SQLDeveloper, for example.

<br/>

**Connection parameters:**

    hostname: localhost
    port: 1521
    sid: xe
    username: system
    password: oracle

    username: sys
    password: oracle

<br/>

**Connect to Oracle Application Express web management console**

    url: http://localhost:8080/apex
    workspace: internal
    user: admin
    password: oracle

<br/>

**You can change password by next command**

<br/>

    alter user system identified by NewPassword;

<br/>

### WebLogic 12.2.1 inside Docker Containers

<br/>

<div align="center">

<iframe width="640" height="480" src="https://www.youtube.com/embed/cgf8wzXnmb4" frameborder="0" allowfullscreen></iframe>

</div>

<br/><br/>

Dockerfiles and etc:  
https://bitbucket.org/oracle-dba/docker-for-oracle/src/master/
