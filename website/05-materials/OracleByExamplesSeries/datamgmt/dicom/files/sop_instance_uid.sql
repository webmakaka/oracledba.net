select id, 
       t.dicom.getSOPInstanceUID() as SOP_Instance_UID 
from medical_image_table t;