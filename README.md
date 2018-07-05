# [ORACLEDBA.NET] (https://oracledba.net) SOURCE CODES

[![Build Status](https://travis-ci.org/plsql/oracledba.net.svg?branch=gh-pages)](https://travis-ci.org/plsql/oracledba.net)
[![Join the chat at https://gitter.im/oracle-dba-ru/Lobby](https://badges.gitter.im/oracle-dba-ru/Lobby.svg)](https://gitter.im/oracle-dba-ru/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

<br/>

### TO RUN OracleDBA.net on local computer (May be deprecated. If it will not work, you can ask sulution in the chat)

Install Docker, then:

    $ docker pull marley/centos6-for-dev
    $ docker run -i -t -p 80:8080 marley/centos6-for-dev /bin/bash

RUN Oracle DBA application:

    $ source ~/.bash_profile
    $ cd /projects
    $ git clone --depth=1 https://bitbucket.org/oracle-dba/oracledba.net
    $ cd oracledba.net/
    $ gem install jekyll
    $ jekyll serve --watch  --host 0.0.0.0 --port 8080
