# [ORACLEDBA.NET] (https://oracledba.net) SOURCE CODES

### TO RUN OracleDBA.net on local computer

Install Docker, then:

    $ docker pull marley/centos6-for-dev
    $ docker run -i -t -p 80:8080 marley/centos6-for-dev /bin/bash

RUN Oracle DBA application:

    $ source ~/.bash_profile
    $ cd /projects
    $ git clone --depth=1 https://github.com/plsql/oracledba.net
    $ cd oracledba.net/
    $ gem install jekyll
    $ jekyll serve --watch  --host 0.0.0.0 --port 8080

