set echo on;
drop table medical_image_table;
create table medical_image_table 
             (id          integer primary key, 
              dicom       ordsys.orddicom,
              imageThumb  ordsys.ordimage, 
              anonDicom   ordsys.orddicom);
