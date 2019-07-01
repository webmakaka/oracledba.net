set timing on
declare

  commit_after integer := 0 ;
  loop_variable integer ;

  cursor c_sales is
  select prod_id
  , cust_id
  , time_id
  , channel_id
  , promo_id
  , quantity_sold
  , amount_sold
  from sales ;

begin

  for r_sales in c_sales
  loop

    if commit_after = 0
    then

      loop_variable := 0 ;

      commit_after := round(dbms_random.value(1,1)) ;

    end if ;

    insert into sales_compress
    (prod_id, cust_id, time_id, channel_id, promo_id, quantity_sold, amount_sold)
    values
    ( r_sales.prod_id
    , r_sales.cust_id
    , r_sales.time_id
    , r_sales.channel_id
    , r_sales.promo_id
    , r_sales.quantity_sold
    , r_sales.amount_sold
    ) ;

    if loop_variable = commit_after
    then
      commit ;
      commit_after := 0 ;
    end if ;

    loop_variable := loop_variable + 1 ;

  end loop ;

end ;
/
set timing off
