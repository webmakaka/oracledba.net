---
layout: page
title: Basic RMAN views
description: Basic RMAN views
keywords: Oracle Database, RMAN
permalink: /database/backup-and-restore/rman/rman-view/
---

# Basic RMAN views

    select * from v$database; --
    select * from v$recovery_file_dest; -- FRA location.
    select * from v$flash_recovery_area_usage; -- used space
    select * from v$rman_backup_job_details; -- backup information
    select * from v$rman_backup_subjob_details;
    select * from v$rman_configuration;
    select * from v$rman_status;
    select * from v$rman_backup_type;

    select * from v$rman_configuration;

    select * from v$archived_log;

    select * from v$backup_corruption;
    select * from v$copy_corruption;

    select * from v$backup_files;
    select * from v$backup_device;
    select * from v$backup_set;
    select * from v$backup_piece;
    select * from v$backup_redolog;
    select * from v$backup_spfile;
