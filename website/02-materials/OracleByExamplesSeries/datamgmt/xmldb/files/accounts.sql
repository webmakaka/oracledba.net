ALTER USER HR ACCOUNT UNLOCK IDENTIFIED BY HR;
ALTER USER OE ACCOUNT UNLOCK INDENTIFIED BY OE;
GRANT DBA to OE, HR;
GRANT SELECT_CATALOG_ROLE TO OE;