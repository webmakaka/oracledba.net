column t.imageThumb.getfileformat() format A20;
select id, t.imageThumb.getWidth(), t.imageThumb.getHeight(), 
       t.imageThumb.getFileFormat() 
from medical_image_table t;
