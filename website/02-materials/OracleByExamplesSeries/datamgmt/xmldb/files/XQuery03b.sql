-- Same query on a binary storage table
SELECT XMLQuery('/PurchaseOrder/ShippingInstructions/name' passing object_value returning content).getStringVal() 
FROM PO_SL_BIX_TABLE 
WHERE XMLEXISTS('/PurchaseOrder[Reference="SBELL-2002100912333601PDT"]' passing object_value)
/


