drop table ced_test.app_relations cascade constraints; 
/
drop sequence ced_test.app_relations_seq;
/

drop table ced_test.app_tabtpl cascade constraints; 
/
 drop sequence ced_test.app_tabtpl_seq;  
/
   
drop table ced_test.app_tabcols cascade constraints; 
/
 drop sequence ced_test.app_tabcols_seq;  
/
   
drop table ced_test.app_tplcols cascade constraints; 
/
 drop sequence ced_test.app_tplcols_seq;  
/
   
drop table ced_test.app_templates cascade constraints; 
/
 drop sequence ced_test.app_templates_seq;  
/

drop table ced_test.app_tables cascade constraints; 
/
 drop sequence ced_test.app_tables_seq;  
/
     
drop table ced_test.app_instances cascade constraints; 
/
 drop sequence ced_test.app_instances_seq;  
/
   
drop table ced_test.app_trelations cascade constraints; 
/
 drop sequence ced_test.app_trelations_seq;  
/
   
drop table ced_test.app_environment cascade constraints; 
/
 drop sequence ced_test.app_environment_seq;  
/
   
drop table ced_test.app_applications cascade constraints; 
/
 drop sequence ced_test.app_applications_seq;  
/
   
purge recyclebin;

commit;