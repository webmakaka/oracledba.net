---
layout: page
title: Deleting RMAN (Recovery Manager) objects
description: Deleting RMAN (Recovery Manager) objects
keywords: Oracle Database, RMAN, Delete
permalink: /database/backup-and-restore/rman/oracle-rman-delete/
---

# Deleting RMAN (Recovery Manager) objects

// Delete obsolete backups with confirmation

    RMAN> delete obsolete;

// Delete obsolete backups without confirmation

    RMAN> delete noprompt obsolete;

<br/>

    RMAN> DELETE EXPIRED BACKUP;
    RMAN> DELETE EXPIRED COPY;

// Delete copy

    RMAN> delete copy;

// Delete backupset with a specific ID

    RMAN> delete backupset 20;

// Delete all archive logs.

    RMAN> delete archivelog all;
