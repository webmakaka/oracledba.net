create or replace view PO_MASTER_DETAIL_VIEW
as
select m.REFERENCE,m.REQUESTOR,m.USERID,m.COSTCENTER,item.*
  from PO_SL_BIX_TABLE, 
       xmltable
       ('/PurchaseOrder' passing object_value
         COLUMNS
           REFERENCE       varchar2(30)   path 'Reference',
           REQUESTOR       varchar2(128)  path 'Requestor',
           USERID          varchar(10)    path 'User',
           COSTCENTER      varchar2(4)    path 'CostCenter',
           ITEMS	   	   xmltype		path 'LineItems'
       ) m,
       xmltable
       ('/LineItems/LineItem' passing m.items
        COLUMNS
           ITEMNO            number(38)     path '@ItemNumber',
           DESCRIPTION       varchar2(1024) path 'Description',
           PARTNO            varchar2(56)   path 'Part/@Id',
           QUANTITY          number(38)     path 'Part/@Quantity',
           UNITPRICE         number(12,2)   path 'Part/@UnitPrice'
       ) item
/ 


