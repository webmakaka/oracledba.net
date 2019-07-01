
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
-- cooked-up queries that will regress and have profiles
--

/* my_query_14a_scott*/
SELECT /* my_query_14a_scott */ /*+ LEADING(t2 t3 t5 t4 t1 t7 t6) INDEX(t1) USE_HASH(t1) */
    'C' || t2.pg_featurevalue_05_id pg_featurevalue_05_id,
    's' || t4.elementrange_id pg_featurevalue_15_id,
    'H' || t5.elementgroup_id pg_featurevalue_01_id,
    'l' || t6.elementrange_id price_eur_id,
    'A' || t2.productgroup_id productgroup_id,
    'Z' || t7.elementgroup_id period_id,
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

/* my_query_14b_scott*/
SELECT /* my_query_14b_scott */ /*+ INDEX(t99) USE_HASH(t99) ORDERED */
    'X' || t2.pg_featurevalue_05_id pg_featurevalue_05_id,
    'u' || t4.elementrange_id pg_featurevalue_15_id,
    'V' || t5.elementgroup_id pg_featurevalue_01_id,
    'z' || t6.elementrange_id price_eur_id,
    'Q' || t2.productgroup_id productgroup_id,
    'U' || t7.elementgroup_id period_id,
    SUM(t99.pd_sales_units*t99.pd_projection_factor*t99.pd_price_units_eur) salesvalueeur
FROM
    scott.lu_item_293 t2,
    scott.lu_pg_featurevalue_15 t3,
    scott.lu_elementgroup_rel t5,
    scott.lu_elementrange_rel t4,
    scott.fact_pd_out_itm_293 t99,
    scott.lu_elementgroup_rel t7,
    scott.lu_elementrange_rel t6
WHERE
/* Attribute Joins */
      ((t99.item_id = t2.item_id
/* Customizing  */
  AND   t99.productgroup_id = t2.productgroup_id)
/* Customizing End */
  AND  (t2.pg_featurevalue_15_id = t3.pg_featurevalue_15_id)
  AND  (t3.pg_featurevalue_15_num BETWEEN t4.lbound AND t4.ubound)
  AND  (t2.pg_featurevalue_01_id = t5.value_id)
  AND  (t99.pd_price_units_eur BETWEEN t6.lbound AND t6.ubound)
  AND  (t99.period_id = t7.value_id)
      )
/* Attribute Filters */
  AND ((t2.productgroup_id = 15520)
  AND  (t99.productgroup_id = 15520) /* Push Down Filters */
  AND  (t2.pg_featurevalue_05_id IN (5446,5447))
  AND  (t4.elementrange_id = 3091)
  AND  (t5.elementgroup_id IN (1959,1960,1961,1962,8574))
  AND  (t6.elementrange_id IN (8656,8657,8658,8659,8660,8661,8662,8663,8664,8665,8666,8667,8668,8669,8670,8671,8672,8673,8674,8675,8676,8679,8680,8681,8682,8683,8684,8685,8686,8687,8688,8689,8690,8691,8692,8693,8694,8695,8696,8697,8698,8699))
  AND  (t7.elementgroup_id = 14659)
  AND  (t99.period_id IN (20030699999060,20030799999030,20030799999060,20030799999120)) /* Resolved ElementGroup Filters */
      )
/* Fact Filters */
  AND (t99.project_type_id = '1'
      )
GROUP BY
    t2.pg_featurevalue_05_id,
    t4.elementrange_id,
    t5.elementgroup_id,
    t6.elementrange_id,
    t2.productgroup_id,
    t7.elementgroup_id;

/* my_query_14c_scott*/
SELECT /* my_query_14c_scott */ /*+ LEADING(t97 t41 t63 t11 t52 t77 t31) INDEX(t52) USE_HASH(t52) */
    'Q' || t97.pg_featurevalue_05_id pg_featurevalue_05_id,
    'l' || t11.elementrange_id pg_featurevalue_15_id,
    'M' || t63.elementgroup_id pg_featurevalue_01_id,
    'n' || t31.elementrange_id price_eur_id,
    'Y' || t97.productgroup_id productgroup_id,
    'b' || t77.elementgroup_id period_id,
    SUM(t52.pd_sales_units*t52.pd_projection_factor*t52.pd_price_units_eur) salesvalueeur
FROM
    scott.lu_item_293 t97,
    scott.lu_pg_featurevalue_15 t41,
    scott.lu_elementgroup_rel t63,
    scott.lu_elementrange_rel t11,
    scott.fact_pd_out_itm_293 t52,
    scott.lu_elementgroup_rel t77,
    scott.lu_elementrange_rel t31
WHERE
/* Attribute Joins */
      ((t52.item_id = t97.item_id
/* Customizing  */
  AND   t52.productgroup_id = t97.productgroup_id)
/* Customizing End */
  AND  (t97.pg_featurevalue_15_id = t41.pg_featurevalue_15_id)
  AND  (t41.pg_featurevalue_15_num BETWEEN t11.lbound AND t11.ubound)
  AND  (t97.pg_featurevalue_01_id = t63.value_id)
  AND  (t52.pd_price_units_eur BETWEEN t31.lbound AND t31.ubound)
  AND  (t52.period_id = t77.value_id)
      )
/* Attribute Filters */
  AND ((t97.productgroup_id = 15520)
  AND  (t52.productgroup_id = 15520) /* Push Down Filters */
  AND  (t97.pg_featurevalue_05_id IN (5446,5447))
  AND  (t11.elementrange_id = 3091)
  AND  (t63.elementgroup_id IN (1959,1960,1961,1962,8574))
  AND  (t31.elementrange_id IN (8656,8657,8658,8659,8660,8661,8662,8663,8664,8665,8666,8667,8668,8669,8670,8671,8672,8673,8674,8675,8676,8679,8680,8681,8682,8683,8684,8685,8686,8687,8688,8689,8690,8691,8692,8693,8694,8695,8696,8697,8698,8699))
  AND  (t77.elementgroup_id = 14659)
  AND  (t52.period_id IN (20030699999060,20030799999030,20030799999060,20030799999120)) /* Resolved ElementGroup Filters */
      )
/* Fact Filters */
  AND (t52.project_type_id = '1'
      )
GROUP BY
    t97.pg_featurevalue_05_id,
    t11.elementrange_id,
    t63.elementgroup_id,
    t31.elementrange_id,
    t97.productgroup_id,
    t77.elementgroup_id;
