select id,
       t.dicom.getcontentlength() as content_Length 
from medical_image_table t;