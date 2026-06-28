---
layout: page
title: Choosing between performance and reliability in Oracle
description: Choosing between performance and reliability in Oracle
keywords: Oracle Database, Choosing between performance and reliability in Oracle
permalink: /database/performance/performance-or-reliability/
---

# Choosing between performance and reliability in Oracle

<br/>

To ensure performance, you always have to make trade-offs. To improve performance, something else must be adversely affected. Often this increases recovery time. The higher the reliability that the administrator builds into the database, the slower it runs.

You need to make a decision about how much reliability should be ensured and what level of performance is required.

This involves taking into account such metrics as: number of users with concurrent access to the database, number of transactions per second that should be executed simultaneously, etc.

<br/><br/>

**Factors affecting performance:**

• Mirrored control files  
• Mirrored log group members  
• Checkpoint frequency  
• Data file redundancy  
• Archiving  
• Number of blocks checked  
• Number of concurrent users and parallel transactions
