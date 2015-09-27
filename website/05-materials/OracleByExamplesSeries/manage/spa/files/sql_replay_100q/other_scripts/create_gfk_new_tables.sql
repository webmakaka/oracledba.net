-- for query_2_bis and query_3_bis
DROP TABLE  gfk.lu_pg_featurevalue_15_q2;
CREATE TABLE  gfk.lu_pg_featurevalue_15_q2 as select * from 
gfk.lu_pg_featurevalue_15;

DROP TABLE  gfk.lu_elementrange_rel_q2;
CREATE TABLE  gfk.lu_elementrange_rel_q2 as select * from 
gfk.lu_elementrange_rel;
