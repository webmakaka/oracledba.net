select id, 
       t.dicom.getSeriesInstanceUID() as Series_Instance_UID
from medical_image_table t;