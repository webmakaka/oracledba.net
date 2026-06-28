---
layout: page
title: A few words about Oracle databases
description: A few words about Oracle databases
keywords: Oracle DataBase, A few words about Oracle databases
permalink: /database/beginning/intro/
---

# A few words about Oracle databases

### Oracle DB (Standard / Enterprise Edition)

Oracle Database is a commercial product that is quite expensive (There is even a book - "Everyone around must go broke: the unvarnished truth about Oracle Corporation and its leader Larry Ellison"). For learning, you can install the server completely free of charge, but to use it in an organization, you will need to purchase a license (for Standard it is licensed per processor (the maximum number of processors that can be installed on the server is also limited by license agreements), and for Enterprise version per core).

Additional advanced database features (for example, the performance analysis package) are paid separately. Remember, Oracle is always watching you. And if you are using / have used any paid option without paying for it (or paid less than required), this bastard will never forget about it and will rat you out at the first opportunity.

Oracle is a rather complex DB. Without deep knowledge and understanding of its mechanisms, it can be very difficult. It very often does not forgive mistakes and negligence in its use. But if you have correctly configured its operation, provided backup and duplication of critically important DB files, processes and services, provided for the possibility of preventing technical failures, denied access to the database to insufficiently competent employees, Oracle will work better than any other DB.

<br/>
<h3>Oracle Database 11g Standard Edition One: </h3>

The cheapest version of the database. Minimum price - $180 per user who will work with the database. License for at least 5 users. There are hardware limitations.

<br/>
<h3>Free version of Oracle DB 11g (XE, Express Edition): </h3>

In turn, Oracle offers a free version of its product (XE, Express Edition), which you can use freely and completely free of charge. Of course, Oracle has imposed restrictions on its free product, so XE version can only work with 1 core, 1 GB of RAM and store no more than 11 GB of data. This is quite enough for simultaneous work with the database by employees of a small enterprise or employees of a department in a large company. Perhaps this version will also suit your needs. (Of course, such severe restrictions make you increasingly lean towards openSource products, such as PostgreSQL).

<br/>
<h3>Which operating system to choose for installing Oracle Database?</h3>

Of course, it all depends on your capabilities, abilities, knowledge and system requirements. <br/>
Here we focus on the operating system from Oracle - Oracle Linux (RedHat). Oracle takes RedHat sources, changes the images, compiles the sources and as a result we get the Oracle Linux distribution, which can be used free of charge for commercial purposes. If necessary, Oracle is ready to provide paid technical support. <br/>

<br/>
<h3>Where to download Oracle distributions</h3>

<ul>
<li>You can get Oracle Linux operating system distributions on the website <a href="http://linux.oracle.com/">linux.oracle.com</a>. After registration, you can download Oracle Linux and use it free of charge as the main platform for your Oracle database installations. Upd. <a href="https://yum.oracle.com/oracle-linux-isos.html">Another link to oracle linux images. Download without registration</a></li>

<li>Database distributions can be obtained on the website <a href="https://www.oracle.com/technetwork/database/enterprise-edition/downloads/index.html">oracle.com</a>. Registration on the site is also required here.</li>

</ul>

<br/>
<h3>Virtual machines for installations</h3>

<ul>
<li>For learning or research purposes, it makes sense to use virtual machines. For example, <a href="http://www.virtualbox.org/wiki/Downloads">Oracle VirtualBox</a></li>
</ul>

You can download a <a href="http://www.oracle.com/technetwork/database/enterprise-edition/databaseappdev-vm-161299.html">pre-built virtual machine</a>. <br/>
The following pages of the site will cover a step-by-step option for installing the database.
