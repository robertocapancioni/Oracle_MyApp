drop table robertocapancioni.app_relations cascade constraints; 
/
drop sequence robertocapancioni.app_relations_seq;
/

drop table robertocapancioni.app_tabtpl cascade constraints; 
/
 drop sequence robertocapancioni.app_tabtpl_seq;  
/
   
drop table robertocapancioni.app_tabcols cascade constraints; 
/
 drop sequence robertocapancioni.app_tabcols_seq;  
/
   
drop table robertocapancioni.app_tplcols cascade constraints; 
/
 drop sequence robertocapancioni.app_tplcols_seq;  
/
   
drop table robertocapancioni.app_templates cascade constraints; 
/
 drop sequence robertocapancioni.app_templates_seq;  
/

drop table robertocapancioni.app_tables cascade constraints; 
/
 drop sequence robertocapancioni.app_tables_seq;  
/
     
drop table robertocapancioni.app_instances cascade constraints; 
/
 drop sequence robertocapancioni.app_instances_seq;  
/
   
drop table robertocapancioni.app_trelations cascade constraints; 
/
 drop sequence robertocapancioni.app_trelations_seq;  
/
   
drop table robertocapancioni.app_environment cascade constraints; 
/
 drop sequence robertocapancioni.app_environment_seq;  
/
   
drop table robertocapancioni.app_applications cascade constraints; 
/
 drop sequence robertocapancioni.app_applications_seq;  
/
   
purge recyclebin;

commit;