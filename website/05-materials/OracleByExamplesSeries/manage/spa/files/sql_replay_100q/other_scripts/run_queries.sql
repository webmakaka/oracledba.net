SET ECHO ON
SET FEEDBACK 1
SET NUMWIDTH 10
SET LINESIZE 80
SET TRIMSPOOL ON
SET TAB OFF
SET PAGESIZE 100
SET LONG 2000000000


SET SERVEROUTPUT ON
set linesize 150
-- set autotrace traceonly statistics; 
-- set autotrace traceonly; 
set timing on;

--
-- set module to sql_replay demo
--
exec dbms_application_info.set_module('GFK_DEMO', 'GFK_DEMO');

--
-- set module to sql_replay demo
--
/* my_query_1_scott */
SELECT /* my_query_1_scott */ DISTINCT
    'B' || t1.pg_featurevalue_15_id pg_featurevalue_15_id
FROM
    scott.lu_pg_featurevalue_15 t1,
    scott.lu_elementrange_rel t2
WHERE
/* Attribute Joins */
      ((t1.pg_featurevalue_15_num BETWEEN t2.lbound AND t2.ubound)
      )
/* Attribute Filters */
  AND ((t1.pg_featurevalue_15_id = 1485)
  AND  (t2.elementrange_id = 3091)
      );




/* my_query_2_scott */ 
SELECT /* my_query_2_scott */  DISTINCT
    'B' || t1.pg_featurevalue_15_id pg_featurevalue_15_id
FROM
    scott.lu_pg_featurevalue_15 t1,
    scott.lu_elementrange_rel t2
WHERE
/* Attribute Joins */
      ((t1.pg_featurevalue_15_num BETWEEN t2.lbound AND t2.ubound)
      )
/* Attribute Filters */
  AND ((t1.pg_featurevalue_15_id = 12425)
  AND  (t2.elementrange_id = 3091)
      );




/* my_query_3_bis */
SELECT /* my_query_3_bis */ DISTINCT
    'B' || t1.pg_featurevalue_15_id pg_featurevalue_15_id
FROM
    gfk.lu_pg_featurevalue_15_q2 t1,
    gfk.lu_elementrange_rel_q2 t2
WHERE
/* Attribute Joins */
      ((t1.pg_featurevalue_15_num BETWEEN t2.lbound AND t2.ubound)
      )
/* Attribute Filters */
  AND ((t1.pg_featurevalue_15_id = 49620)
  AND  (t2.elementrange_id = 3091)
      );



/* my_query_4_scott */
SELECT /* my_query_4_scott */ DISTINCT
    'B' || t1.pg_featurevalue_47_id pg_featurevalue_47_id
FROM
    scott.lu_pg_featurevalue_47 t1,
    scott.lu_elementgroup_rel t2
WHERE
/* Attribute Joins */
      ((t1.pg_featurevalue_47_id = t2.value_id)
      )
/* Attribute Filters */
  AND ((t1.pg_featurevalue_47_id = 5454)
  AND  (t2.elementgroup_id = 6624)
      );




/* my_query_5 */
SELECT /* my_query_5 */ DISTINCT
    'B' || t1.pg_featurevalue_47_id pg_featurevalue_47_id
FROM
    gfk.lu_pg_featurevalue_47 t1,
    gfk.lu_elementgroup_rel t2
WHERE
/* Attribute Joins */
      ((t1.pg_featurevalue_47_id = t2.value_id)
      )
/* Attribute Filters */
  AND ((t1.pg_featurevalue_47_id = 16003)
  AND  (t2.elementgroup_id = 6624)
      );




/* my_query_8_scott */
SELECT /* my_query_8_scott */ /*+ ORDERED INDEX(t1) USE_HASH(t1) */
    'B' || t2.pg_featurevalue_05_id pg_featurevalue_05_id,
    'B' || t2.pg_featurevalue_08_id pg_featurevalue_08_id,
    'r' || t3.elementrange_id price_eur_id,
    'B' || t2.productgroup_id productgroup_id,
    'G' || t4.elementgroup_id period_id,
    SUM(t1.pd_sales_units*t1.pd_projection_factor*t1.pd_price_units_eur) salesvalueeur
FROM
    scott.lu_item_293 t2,
    scott.fact_pd_out_itm_293 t1,
    scott.lu_elementgroup_rel t4,
    scott.lu_elementrange_rel t3
WHERE
/* Attribute Joins */
      ((t1.item_id = t2.item_id
/* Customizing  */
  AND   t1.productgroup_id = t2.productgroup_id)
/* Customizing End */
  AND  (t1.pd_price_units_eur BETWEEN t3.lbound AND t3.ubound)
  AND  (t1.period_id = t4.value_id)
      )
/* Attribute Filters */
  AND ((t2.productgroup_id = 15520)
  AND  (t1.productgroup_id = 15520) /* Push Down Filters */
  AND  NOT ((t2.pg_featurevalue_01_id IN (103,104,107,110,113,134,148,167,171,186,192,216,2259,236,241,2477,24958,27445,297,3891,71,76,89,92,95)))
  AND  (t2.pg_featurevalue_08_id = 717)
  AND  (t2.pg_featurevalue_05_id IN (5446,5447))
  AND  (t3.elementrange_id IN (8656,8657,8658,8659,8660,8661,8662,8663,8664,8665,8666,8667,8668,8669,8670,8671,8672,8673,8674,8675,8676,8679,8680,8681,8682,8683,8684,8685,8686,8687,8688,8689,8690,8691,8692,8693,8694,8695,8696,8697,8698,8699))
  AND  (t4.elementgroup_id = 14659)
  AND  (t1.period_id IN (20030699999060,20030799999030,20030799999060,20030799999120)) /* Resolved ElementGroup Filters */
      )
/* Fact Filters */
  AND (t1.project_type_id = '1'
      )
GROUP BY
    t2.pg_featurevalue_05_id,
    t2.pg_featurevalue_08_id,
    t3.elementrange_id,
    t2.productgroup_id,
    t4.elementgroup_id;

/* my_query_10 */
SELECT /* my_query_10 */ /*+ ORDERED INDEX(t1) USE_HASH(t1) */
    'G' || t3.elementgroup_id pg_featurevalue_18_id,
    'r' || t4.elementrange_id price_eur_id,
    'B' || t2.productgroup_id productgroup_id,
    'G' || t5.elementgroup_id period_id,
    SUM(t1.pd_sales_units*t1.pd_projection_factor*t1.pd_price_units_eur) salesvalueeur
FROM
    gfk.lu_item_293 t2,
    gfk.lu_elementgroup_rel t3,
    gfk.fact_pd_out_itm_293 t1,
    gfk.lu_elementgroup_rel t5,
    gfk.lu_elementrange_rel t4
WHERE
/* Attribute Joins */
      ((t1.item_id = t2.item_id
/* Customizing  */
  AND   t1.productgroup_id = t2.productgroup_id)
/* Customizing End */
  AND  (t2.pg_featurevalue_18_id = t3.value_id)
  AND  (t1.pd_price_units_eur BETWEEN t4.lbound AND t4.ubound)
  AND  (t1.period_id = t5.value_id)
      )
/* Attribute Filters */
  AND ((t2.productgroup_id = 15520)
  AND  (t1.productgroup_id = 15520) /* Push Down Filters */
  AND  NOT ((t2.pg_featurevalue_01_id IN (103,104,107,110,113,134,148,167,171,186,192,216,2259,236,241,2477,24958,27445,297,3891,71,76,89,92,95)))
  AND  (t3.elementgroup_id IN (8902,8903))
  AND  (t4.elementrange_id IN (8656,8657,8658,8659,8660,8661,8662,8663,8664,8665,8666,8667,8668,8669,8670,8671,8672,8673,8674,8675,8676,8679,8680,8681,8682,8683,8684,8685,8686,8687,8688,8689,8690,8691,8692,8693,8694,8695,8696,8697,8698,8699))
  AND  (t5.elementgroup_id = 14659)
  AND  (t1.period_id IN (20030699999060,20030799999030,20030799999060,20030799999120)) /* Resolved ElementGroup Filters */
      )
/* Fact Filters */
  AND (t1.project_type_id = '1'
      )
GROUP BY
    t3.elementgroup_id,
    t4.elementrange_id,
    t2.productgroup_id,
    t5.elementgroup_id;





/* my_query_14 */
SELECT /* my_query_14 */ /*+ ORDERED INDEX(t1) USE_HASH(t1) */
    'B' || t2.pg_featurevalue_05_id pg_featurevalue_05_id,
    'r' || t4.elementrange_id pg_featurevalue_15_id,
    'G' || t5.elementgroup_id pg_featurevalue_01_id,
    'r' || t6.elementrange_id price_eur_id,
    'B' || t2.productgroup_id productgroup_id,
    'G' || t7.elementgroup_id period_id,
    SUM(t1.pd_sales_units*t1.pd_projection_factor*t1.pd_price_units_eur) salesvalueeur
FROM
    gfk.lu_item_293 t2,
    gfk.lu_pg_featurevalue_15 t3,
    gfk.lu_elementgroup_rel t5,
    gfk.lu_elementrange_rel t4,
    gfk.fact_pd_out_itm_293 t1,
    gfk.lu_elementgroup_rel t7,
    gfk.lu_elementrange_rel t6
WHERE
/* Attribute Joins */
      ((t1.item_id = t2.item_id
/* Customizing  */
  AND   t1.productgroup_id = t2.productgroup_id)
/* Customizing End */
  AND  (t2.pg_featurevalue_15_id = t3.pg_featurevalue_15_id)
  AND  (t3.pg_featurevalue_15_num BETWEEN t4.lbound AND t4.ubound)
  AND  (t2.pg_featurevalue_01_id = t5.value_id)
  AND  (t1.pd_price_units_eur BETWEEN t6.lbound AND t6.ubound)
  AND  (t1.period_id = t7.value_id)
      )
/* Attribute Filters */
  AND ((t2.productgroup_id = 15520)
  AND  (t1.productgroup_id = 15520) /* Push Down Filters */
  AND  (t2.pg_featurevalue_05_id IN (5446,5447))
  AND  (t4.elementrange_id = 3091)
  AND  (t5.elementgroup_id IN (1959,1960,1961,1962,8574))
  AND  (t6.elementrange_id IN (8656,8657,8658,8659,8660,8661,8662,8663,8664,8665,8666,8667,8668,8669,8670,8671,8672,8673,8674,8675,8676,8679,8680,8681,8682,8683,8684,8685,8686,8687,8688,8689,8690,8691,8692,8693,8694,8695,8696,8697,8698,8699))
  AND  (t7.elementgroup_id = 14659)
  AND  (t1.period_id IN (20030699999060,20030799999030,20030799999060,20030799999120)) /* Resolved ElementGroup Filters */
      )
/* Fact Filters */
  AND (t1.project_type_id = '1'
      )
GROUP BY
    t2.pg_featurevalue_05_id,
    t4.elementrange_id,
    t5.elementgroup_id,
    t6.elementrange_id,
    t2.productgroup_id,
    t7.elementgroup_id;


/* my_query_14_bis_0 */
SELECT /* my_query_14_bis_0 */ /*+ ORDERED INDEX(t1) USE_HASH(t1) */
    'B' || t2.pg_featurevalue_05_id pg_featurevalue_05_id,
    'r' || t4.elementrange_id pg_featurevalue_15_id,
    'G' || t5.elementgroup_id pg_featurevalue_01_id,
    'r' || t6.elementrange_id price_eur_id,
    'B' || t2.productgroup_id productgroup_id,
    'G' || t7.elementgroup_id period_id,
    SUM(t1.pd_sales_units*t1.pd_projection_factor*t1.pd_price_units_eur) salesvalueeur
FROM
    gfk.lu_item_293 t2,
    gfk.lu_pg_featurevalue_15 t3,
    gfk.lu_elementgroup_rel t5,
    gfk.lu_elementrange_rel t4,
    gfk.fact_pd_out_itm_293 t1,
    gfk.lu_elementgroup_rel t7,
    gfk.lu_elementrange_rel t6
WHERE
/* Attribute Joins */
      ((t1.item_id = t2.item_id
/* Customizing  */
  AND   t1.productgroup_id = t2.productgroup_id)
/* Customizing End */
  AND  (t2.pg_featurevalue_15_id = t3.pg_featurevalue_15_id)
  AND  (t3.pg_featurevalue_15_num BETWEEN t4.lbound AND t4.ubound)
  AND  (t2.pg_featurevalue_01_id = t5.value_id)
  AND  (t1.pd_price_units_eur BETWEEN t6.lbound AND t6.ubound)
  AND  (t1.period_id = t7.value_id)
      )
/* Attribute Filters */
  AND ((t2.productgroup_id = 15520)
  AND  (t1.productgroup_id = 15520) /* Push Down Filters */
  AND  (t2.pg_featurevalue_05_id IN (5446, 5447))
  AND  (t4.elementrange_id = 3091)
  AND  (t5.elementgroup_id IN (1959, 1960, 1961, 1962, 8574))
  AND  (t6.elementrange_id IN (8656,8657,8658,8659,8660,8661,8662,8663,8664,8665,8666,8667,8668,8669,8670,8671,8672,8673,8674,8675,8676,8679,8680,8681,8682,8683,8684,8685,8686,8687,8688,8689,8690,8691,8692,8693,8694,8695,8696,8697,8698,8699))
  AND  (t7.elementgroup_id = 14659)
  AND  (t1.period_id IN (20030699999060,20030799999030,20030799999060,20030799999120)) /* Resolved ElementGroup Filters */
      )
/* Fact Filters */
  AND (t1.project_type_id = '1'
      )
GROUP BY
    t2.pg_featurevalue_05_id,
    t4.elementrange_id,
    t5.elementgroup_id,
    t6.elementrange_id,
    t2.productgroup_id,
    t7.elementgroup_id;


/* my_query_14_scott*/
SELECT /* my_query_14_scott */ /*+ ORDERED INDEX(t1) USE_HASH(t1) */
    'B' || t2.pg_featurevalue_05_id pg_featurevalue_05_id,
    'r' || t4.elementrange_id pg_featurevalue_15_id,
    'G' || t5.elementgroup_id pg_featurevalue_01_id,
    'r' || t6.elementrange_id price_eur_id,
    'B' || t2.productgroup_id productgroup_id,
    'G' || t7.elementgroup_id period_id,
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
  AND   t1.productgroup_id = t2.productgroup_id)
/* Customizing End */
  AND  (t2.pg_featurevalue_15_id = t3.pg_featurevalue_15_id)
  AND  (t3.pg_featurevalue_15_num BETWEEN t4.lbound AND t4.ubound)
  AND  (t2.pg_featurevalue_01_id = t5.value_id)
  AND  (t1.pd_price_units_eur BETWEEN t6.lbound AND t6.ubound)
  AND  (t1.period_id = t7.value_id)
      )
/* Attribute Filters */
  AND ((t2.productgroup_id = 15520)
  AND  (t1.productgroup_id = 15520) /* Push Down Filters */
  AND  (t2.pg_featurevalue_05_id IN (5446,5447))
  AND  (t4.elementrange_id = 3091)
  AND  (t5.elementgroup_id IN (1959,1960,1961,1962,8574))
  AND  (t6.elementrange_id IN (8656,8657,8658,8659,8660,8661,8662,8663,8664,8665,8666,8667,8668,8669,8670,8671,8672,8673,8674,8675,8676,8679,8680,8681,8682,8683,8684,8685,8686,8687,8688,8689,8690,8691,8692,8693,8694,8695,8696,8697,8698,8699))
  AND  (t7.elementgroup_id = 14659)
  AND  (t1.period_id IN (20030699999060,20030799999030,20030799999060,20030799999120)) /* Resolved ElementGroup Filters */
      )
/* Fact Filters */
  AND (t1.project_type_id = '1'
      )
GROUP BY
    t2.pg_featurevalue_05_id,
    t4.elementrange_id,
    t5.elementgroup_id,
    t6.elementrange_id,
    t2.productgroup_id,
    t7.elementgroup_id;

/* my_query_21 */
SELECT /* my_query_21 */ /*+ ORDERED INDEX(t1) USE_HASH(t1) */
    'B' || t2.pg_featurevalue_02_id pg_featurevalue_02_id,
    'B' || t2.pg_featurevalue_15_id pg_featurevalue_15_id,
    'B' || t2.pg_featurevalue_08_id pg_featurevalue_08_id,
    'r' || t3.elementrange_id price_eur_id,
    'B' || t2.productgroup_id productgroup_id,
    'G' || t4.elementgroup_id period_id,
    SUM(t1.pd_sales_units*t1.pd_projection_factor*t1.pd_price_units_eur) salesvalueeur
FROM
    gfk.lu_item_293 t2,
    gfk.fact_pd_out_itm_293 t1,
    gfk.lu_elementgroup_rel t4,
    gfk.lu_elementrange_rel t3
WHERE
/* Attribute Joins */
      ((t1.item_id = t2.item_id
/* Customizing  */
  AND   t1.productgroup_id = t2.productgroup_id)
/* Customizing End */
  AND  (t1.pd_price_units_eur BETWEEN t3.lbound AND t3.ubound)
  AND  (t1.period_id = t4.value_id)
      )
/* Attribute Filters */
  AND ((t2.productgroup_id = 15520)
  AND  (t1.productgroup_id = 15520) /* Push Down Filters */
  AND  (t2.pg_featurevalue_08_id IN (716,717))
  AND  (t2.pg_featurevalue_15_id IN (12425,1485))
  AND  (t2.pg_featurevalue_02_id IN (4165,4166))
  AND  (t3.elementrange_id IN (8656,8657,8658,8659,8660,8661,8662,8663,8664,8665,8666,8667,8668,8669,8670,8671,8672,8673,8674,8675,8676,8679,8680,8681,8682,8683,8684,8685,8686,8687,8688,8689,8690,8691,8692,8693,8694,8695,8696,8697,8698,8699))
  AND  (t4.elementgroup_id = 14659)
  AND  (t1.period_id IN (20030699999060,20030799999030,20030799999060,20030799999120)) /* Resolved ElementGroup Filters */
      )
/* Fact Filters */
  AND (t1.project_type_id = '1'
      )
GROUP BY
    t2.pg_featurevalue_02_id,
    t2.pg_featurevalue_15_id,
    t2.pg_featurevalue_08_id,
    t3.elementrange_id,
    t2.productgroup_id,
    t4.elementgroup_id;


/* my_query_50 */
SELECT /* my_query_50 */ 'B' || tt1.ch_featurevalue_09_id ch_featurevalue_09_id,
    'G' || tt1.ch_featurevalue_02_elgr_id ch_featurevalue_02_id,
    'B' || tt1.pg_featurevalue_09_id pg_featurevalue_09_id,
    'G' || tt1.countrychannel_elgr_id countrychannel_id,
    'B' || tt1.productgroup_id productgroup_id,
    'G' || tt1.period_elgr_id period_id,
    SUM(tt1.dnfactorsales*tt1.turnoverfactor) salesvalueselloutlets,
    SUM(tt1.dnfactortotal*tt1.turnoverfactor) salesvaluetotaloutlets,
    SUM(tt1.distributionfactor*tt1.dissalesflag) selloutletsavg,
    SUM(tt1.distributionfactor*tt1.distotalflag) carroutletsavg
FROM
    --------------------------
    -- TempTable 1
    --------------------------
    (
    SELECT /*+ ORDERED INDEX(t1) USE_HASH(t1) INDEX(t2) */
        t2.ch_featurevalue_09_id ch_featurevalue_09_id,
        t3.elementgroup_id ch_featurevalue_02_elgr_id,
        t5.pg_featurevalue_09_id pg_featurevalue_09_id,
        t4.elementgroup_id countrychannel_elgr_id,
        t5.productgroup_id productgroup_id,
        t6.elementgroup_id period_elgr_id,
        t2.outlet_id outlet_id,
        t1.project_id project_id,
        SIGN(SUM(ABS(DECODE(t1.pd_sales_units,NULL,0,t1.pd_sales_units)))) dnfactorsales,
        MAX(t1.pd_turnover_factor*t1.pd_projection_factor) turnoverfactor,
        SIGN(SUM(ABS(DECODE(t1.pd_sales_units,NULL,0,t1.pd_sales_units)) + ABS(DECODE(t1.pd_purchase_units,NULL,0,t1.pd_purchase_units)) + ABS(DECODE(t1.pd_stock_new_units,NULL,0,t1.pd_stock_new_units)))) dnfactortotal,
        MAX(t1.pd_distribution_factor) distributionfactor,
        SIGN(SUM(ABS(DECODE(t1.pd_sales_units,NULL,0,t1.pd_sales_units)))) dissalesflag,
        SIGN(SUM(ABS(DECODE(t1.pd_sales_units,NULL,0,t1.pd_sales_units)) + ABS(DECODE(t1.pd_purchase_units,NULL,0,t1.pd_purchase_units)) + ABS(DECODE(t1.pd_stock_new_units,NULL,0,t1.pd_stock_new_units)))) distotalflag,
        /* Additional Columns  */
        t1.project_id project_id_d, t1.period_id period_id_d, t1.outlet_id outlet_id_d
        /* Additional Columns End */
    FROM
        gfk.lu_item_293 t5,
        gfk.fact_pd_out_itm_293 t1,
        gfk.lu_elementgroup_rel t6,
        gfk.lu_outlet_293 t2,
        gfk.lu_elementgroup_rel t4,
        gfk.lu_elementgroup_rel t3
    WHERE
    /* Attribute Joins */
          ((t1.outlet_id = t2.outlet_id
    /* Customizing  */
      AND   t1.period_id = t2.period_id
      AND   t1.project_id = t2.project_id)
    /* Customizing End */
      AND  (t2.ch_featurevalue_02_id = t3.value_id)
      AND  (t2.country_channel_id = t4.value_id)
      AND  (t1.item_id = t5.item_id
    /* Customizing  */
      AND   t1.productgroup_id = t5.productgroup_id)
    /* Customizing End */
      AND  (t1.period_id = t6.value_id)
          )
    /* Attribute Filters */
      AND ((t5.productgroup_id = 15520)
      AND  (t1.productgroup_id = 15520) /* Push Down Filters */
      AND  (t5.pg_featurevalue_09_id IN (5484,5485))
      AND  (t2.ch_featurevalue_09_id = 7379)
      AND  (t3.elementgroup_id IN (3481,3482))
      AND  (t4.elementgroup_id = 14786)
      AND  (t2.country_channel_id IN (1873,1882)) /* Resolved ElementGroup Filters */
      AND  (t1.country_channel_id IN (1873,1882)) /* Push Down Filters */
      AND  (t6.elementgroup_id = 14659)
      AND  (t1.period_id IN (20030699999060,20030799999030,20030799999060,20030799999120)) /* Resolved ElementGroup Filters */
          )
    /* Fact Filters */
      AND (t1.project_type_id = '1'
      AND  t1.project_type_id = '1'
      AND  t1.project_type_id = '1'
      AND  t1.project_type_id = '1'
      AND  t1.project_type_id = '1'
      AND  t1.project_type_id = '1'
          )
    GROUP BY
        t2.ch_featurevalue_09_id,
        t3.elementgroup_id,
        t5.pg_featurevalue_09_id,
        t4.elementgroup_id,
        t5.productgroup_id,
        t6.elementgroup_id,
        t2.outlet_id,
        t1.project_id,
        /* Additional GroupBys  */
        t1.project_id, t1.period_id, t1.outlet_id
        /* Additional GroupBys End */
    ) tt1
GROUP BY
    tt1.ch_featurevalue_09_id,
    tt1.ch_featurevalue_02_elgr_id,
    tt1.pg_featurevalue_09_id,
    tt1.countrychannel_elgr_id,
    tt1.productgroup_id,
    tt1.period_elgr_id;

--
-- set module to sql_replay demo
--
exec dbms_application_info.set_module(NULL, NULL);
