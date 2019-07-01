set echo on
-- for query_2_bis and query_3_bis
DROP TABLE  apps.lu_pg_featurevalue_15_q2;
CREATE TABLE  apps.lu_pg_featurevalue_15_q2 as select * from 
apps.lu_pg_featurevalue_15;

DROP TABLE  apps.lu_elementrange_rel_q2;
CREATE TABLE  apps.lu_elementrange_rel_q2 as select * from 
apps.lu_elementrange_rel;
