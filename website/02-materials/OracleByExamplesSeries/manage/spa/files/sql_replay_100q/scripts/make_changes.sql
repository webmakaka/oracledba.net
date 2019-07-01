
-- ---------------------------------------------------------------------------
-- 1. setup the enviornment before we start the demo
-- ---------------------------------------------------------------------------
--
-- a. drop indexes created 
--    when making the changes.
--DROP INDEX "SCOTT"."ADM_PG_FEATUREVALUE_IDX2";
--DROP INDEX "SCOTT"."LU_ELEMENTRANGE_REL_IDX";
--DROP INDEX "SCOTT"."LU_ELEMENTGROUP_REL_IDX1";

-- a. create evil profiles on SCOTTs queries
create or replace procedure create_evil_profile(
  sql_text in clob, 
  hints in sqlprof_attr)
is
begin
 dbms_sqltune.import_sql_profile(sql_text => sql_text,
                                 profile => hints,
                                 replace => TRUE);
end;
/

show errors
/

declare
  txt CLOB;
begin
  txt := 'SELECT /* my_query_14_scott */ /*+ ORDERED INDEX(t1) USE_HASH(t1) */
''B'' || t2.pg_featurevalue_05_id pg_featurevalue_05_id,
''r'' || t4.elementrange_id pg_featurevalue_15_id,
''G'' || t5.elementgroup_id pg_featurevalue_01_id,
''r'' || t6.elementrange_id price_eur_id,
''B'' || t2.productgroup_id productgroup_id,
''G'' || t7.elementgroup_id period_id,
SUM(t1.pd_sales_units*t1.pd_projection_factor*t1.pd_price_units_eur) salesvalueeur
FROM
scott.lu_item_293 t2,
scott.lu_pg_featurevalue_15 t3,
scott.lu_elementgroup_rel t5,
scott.lu_elementrange_rel t4,
scott.fact_pd_out_itm_293 t1,
scott.lu_elementgroup_rel t7,
scott.lu_elementrange_rel t6
WHERE
/* Attribute Joins */
((t1.item_id = t2.item_id
/* Customizing  */
AND t1.productgroup_id = t2.productgroup_id)
/* Customizing End */
AND (t2.pg_featurevalue_15_id = t3.pg_featurevalue_15_id)
AND (t3.pg_featurevalue_15_num BETWEEN t4.lbound AND t4.ubound)
AND (t2.pg_featurevalue_01_id = t5.value_id)
AND (t1.pd_price_units_eur BETWEEN t6.lbound AND t6.ubound)
AND (t1.period_id = t7.value_id)
)
/* Attribute Filters */
AND ((t2.productgroup_id = 15520)
AND (t1.productgroup_id = 15520) /* Push Down Filters */
AND (t2.pg_featurevalue_05_id IN (5446,5447))
AND (t4.elementrange_id = 3091)
AND (t5.elementgroup_id IN (1959,1960,1961,1962,8574))
AND (t6.elementrange_id IN (8656,8657,8658,8659,8660,8661,8662,8663,8664,8665,8666,8667,8668,8669,8670,8671,8672,8673,8674,8675,8676,8679,8680,8681,8682,8683,8684,8685,8686,8687,8688,8689,8690,8691,8692,8693,8694,8695,8696,8697,8698,8699))
AND (t7.elementgroup_id = 14659)
AND (t1.period_id IN (20030699999060,20030799999030,20030799999060,20030799999120)) /* Resolved ElementGroup Filters */
)
/* Fact Filters */
AND (t1.project_type_id = ''1''
)
GROUP BY
t2.pg_featurevalue_05_id,
t4.elementrange_id,
t5.elementgroup_id,
t6.elementrange_id,
t2.productgroup_id,
t7.elementgroup_id';

  create_evil_profile(txt, sqlprof_attr('IGNORE_OPTIM_EMBEDDED_HINTS'));
 
  txt := 'SELECT /* my_query_4_scott */ DISTINCT
''B'' || t1.pg_featurevalue_47_id pg_featurevalue_47_id
FROM
scott.lu_pg_featurevalue_47 t1,
scott.lu_elementgroup_rel t2
WHERE
/* Attribute Joins */
((t1.pg_featurevalue_47_id = t2.value_id)
)
/* Attribute Filters */
AND ((t1.pg_featurevalue_47_id = 5454)
AND (t2.elementgroup_id = 6624)
)';
  create_evil_profile(txt, sqlprof_attr('FULL(@"SEL$F5BB74E1" "T2"@"SEL$1")',
					'FULL(@"SEL$F5BB74E1" "ADM_PG_FEATUREVALUE"@"SEL$2")'));

  txt := 'SELECT /* my_query_2_scott */ DISTINCT
''B'' || t1.pg_featurevalue_15_id pg_featurevalue_15_id
FROM
scott.lu_pg_featurevalue_15 t1,
scott.lu_elementrange_rel t2
WHERE
/* Attribute Joins */
((t1.pg_featurevalue_15_num BETWEEN t2.lbound AND t2.ubound)
)
/* Attribute Filters */
AND ((t1.pg_featurevalue_15_id = 12425)
AND (t2.elementrange_id = 3091)
)';

  create_evil_profile(txt, sqlprof_attr('FULL(@"SEL$F5BB74E1" "T2"@"SEL$1")',
					'FULL(@"SEL$F5BB74E1" "ADM_PG_FEATUREVALUE"@"SEL$2")'));

  txt := 'SELECT /* my_query_1_scott */ DISTINCT
''B'' || t1.pg_featurevalue_15_id pg_featurevalue_15_id
FROM
scott.lu_pg_featurevalue_15 t1,
scott.lu_elementrange_rel t2
WHERE
/* Attribute Joins */
((t1.pg_featurevalue_15_num BETWEEN t2.lbound AND t2.ubound)
)
/* Attribute Filters */
AND ((t1.pg_featurevalue_15_id = 1485)
AND (t2.elementrange_id = 3091)
)';

  create_evil_profile(txt, sqlprof_attr('FULL(@"SEL$F5BB74E1" "T2"@"SEL$1")',
					'FULL(@"SEL$F5BB74E1" "ADM_PG_FEATUREVALUE"@"SEL$2")'));

end;
/

--
-- b. rebuild indices on query1 affetct almost all queries.
-- ALTER INDEX "ADM_PG_FEATUREVALUE_PK" REBUILD NOLOGGING;

CREATE INDEX "LU_ELEMENTRANGE_REL_IDX" ON "LU_ELEMENTRANGE_REL" ("ELEMENTRANGE_ID" )  
PCTFREE 10 INITRANS 2 MAXTRANS 255 
STORAGE(INITIAL 65536 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT) 
TABLESPACE "SYSTEM" NOLOGGING;

CREATE INDEX "LU_ELEMENTGROUP_REL_IDX1" ON "LU_ELEMENTGROUP_REL" ("ELEMENTGROUP_ID" )  
PCTFREE 10 INITRANS 2 MAXTRANS 255 
STORAGE(INITIAL 131072 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT) 
TABLESPACE "SYSTEM" NOLOGGING;

