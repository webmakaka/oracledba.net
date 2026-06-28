---
layout: page
title: Oracle DataBase 12.2 Installation on Oracle Linux 7.4 - Configuring Time Synchronization Services
description: Oracle DataBase 12.2 Installation on Oracle Linux 7.4 - Configuring Time Synchronization Services
keywords: Oracle DataBase 12.2, Oracle Linux 7.4, Time Synchronization
permalink: /database/installation/single-instance/simple/linux/7.4/oracle/12.2/setup-actual-time/
---

<br/>

# <a href="/database/installation/single-instance/simple/linux/7.4/oracle/12.2/">[Oracle DataBase Server 12.2 Installation on Oracle Linux 7.4]</a>: Configuring Time Synchronization Services

<br/>

    # systemctl start ntpd
    # systemctl enable ntpd
    # systemctl status ntpd

<br/>

If necessary, allow on the firewall

    # firewall-cmd --add-service=ntp --permanent
    # firewall-cmd --reload

<br/>

Verification

    # ntpq -p
    # date -R
