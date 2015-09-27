--same query on binary storage table
SELECT XMLQuery('/PurchaseOrder/LineItems/LineItem/Description' passing object_value returning content).getStringVal() 
FROM PO_SL_BIX_TABLE
WHERE XMLExists('/PurchaseOrder[Reference="SBELL-2002100912333601PDT"]' passing object_value)
/
