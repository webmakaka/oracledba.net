---
layout: page
title: Everyone messes up sooner or later
description: Everyone messes up sooner or later
keywords: Oracle Database, Everyone messes up sooner or later
permalink: /database/humor/
---

# Everyone messes up sooner or later

---

Employees from the region call on the phone for consultation. They are responsible for the servers. We should advise if anything, since they don't really understand.

They ask.

-   We're running out of space on the server. Can we delete **trace files**?

Answer:

-   No one is going to read your trace files without a special need. If you don't need them, you can delete them. It won't affect the server's operation.

As a result, they deleted the archive logs.

Then it turned out that they had a datafile failure and needed to restore it from backup and apply precisely those archive logs.

===========================

A guy wrote a bash script with the following logic.

Go to a directory and delete all its contents.

The script worked as follows:

It tried to go to the directory. The directory didn't exist. It deleted everything that was in the current directory, and it was not a tmp directory.

===========================

I was given a server to configure RAC. This RAC didn't want to work and didn't start the first time. In short, I had to use Oracle tools to deinstall this RAC.

Deinstallation is done with scripts. Well, nothing to do. I run these scripts. And I get a message approximately like this: - "Deinstallation completed successfully, all instances on the server have been deleted."

I check. There is not a single instance.

That was cool. Servers usually have several instances. Several developer groups may work with the server. How to justify to them? What if they don't have any backups? And all the work of the week just disappeared.

But in this case, it turned out that the server I was given was brand new without a single instance.

===========================

A friend worked as a programmer for a mobile operator.

He wrote a query to delete all rows where a certain condition is met (e.g., a row with a certain identifier).

He selected just delete with the cursor, immediately pressed F8 and instantly and automatically executed a commit.

After that, he was not very popular in the company. The entire department lost their bonus.

The admins couldn't restore anything.

===========================

I worked with many Windows servers. Several RDP windows. All the same color. One tab closed with an error. I rebooted the wrong server. There was one non-working server. There became 2.

===========================

An employee pressed F8 in the PL/SQL Developer panel and recompiled a package from the test server on production. Who knows how old it was.

<br/><br/>

**If you have something to share, write. But only real stories**.
