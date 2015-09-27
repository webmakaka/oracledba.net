set echo on
-- B-tree indexes for O-R storage
drop index iPurchaseOrderUser;
drop index iPurchaseOrderRef;
drop index iLineItemPartNumber;
drop index iPartNumber;
drop index iDESCRIPTION_FULL_TEXT;

-- XMLIndex indexes for binary XML storage
drop index po_sl_xmlindex_bix_ix force;
drop index po_sl_bix_text_ix;

create index iPurchaseOrderUser on PurchaseOrder
(extractValue(object_value,'/PurchaseOrder/User'))
/
create index iPurchaseOrderRef on PurchaseOrder
(extractValue(object_value,'/PurchaseOrder/Reference'))
/

create index iLineItemPartNumber on LINEITEM_TABLE
(ITEMNUMBER, PART.PART_NUMBER, NESTED_TABLE_ID) compute statistics
/
create index iPartNumber on LINEITEM_TABLE 
(PART.PART_NUMBER, NESTED_TABLE_ID) compute statistics
/

-- Create XML index on the binary XML table
create index po_sl_xmlindex_bix_ix on po_sl_bix_table(object_value) indextype is xdb.xmlindex
             parameters ('PATH TABLE      po_sl_bix_path_table
                          PATH ID INDEX   po_sl_bix_path_id_ix
                          ORDER KEY INDEX po_sl_bix_order_key_ix
                          VALUE INDEX     po_sl_bix_value_ix')
/

-- Create a secondary text index on the VALUE column of the path table
CREATE INDEX po_sl_bix_text_ix ON po_sl_bix_path_table (VALUE) INDEXTYPE IS CTXSYS.CONTEXT
       parameters ('transactional')
/

call dbms_stats.gather_table_stats(USER,'PURCHASEORDER')
/
call dbms_stats.gather_table_stats(USER,'LINEITEM_TABLE')
/
call dbms_stats.gather_table_stats(USER,'po_sl_bix_table')
/
call dbms_stats.gather_index_stats(USER,'iPurchaseOrderUser')
/
call dbms_stats.gather_index_stats(USER,'iPurchaseOrderRef')
/
call dbms_stats.gather_index_stats(USER,'iLineItemPartNumber')
/
call dbms_stats.gather_index_stats(USER,'iPartNumber')
/
call dbms_stats.gather_index_stats(USER,'po_sl_xmlindex_bix_ix')
/
call dbms_stats.gather_index_stats(USER,'po_sl_bix_text_ix')
/

