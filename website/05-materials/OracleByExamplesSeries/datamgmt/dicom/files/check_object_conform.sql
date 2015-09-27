-- Set Data Model Repository
execute ordsys.ord_dicom.setDataModel();
select id, t.dicom.isconformanceValid('OracleOrdObject') as conformant 
from medical_image_table t;

