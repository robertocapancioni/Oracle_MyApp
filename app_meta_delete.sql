delete from ced_test.app_relations where rel_id in (select rel_id from ced_test.app_relations_vw where m_ins_cod = 'APP-TST'); 
/

delete from ced_test.app_tabtpl where ttl_id in (select ttl_id from ced_test.app_tabtpl_vw where ins_cod='APP-TST');
/

delete from ced_test.app_tabcols where tcl_id in (select tcl_id from ced_test.app_tabcols_vw where ins_cod='APP-TST');
/

delete from ced_test.app_tabcols where tcl_id in (select tcl_id from ced_test.app_tabcols_vw where ins_cod='APP-TST');
/

delete from ced_test.app_tables where tab_id in (select tab_id from ced_test.app_tables_vw where ins_cod='APP-TST');
/

delete from ced_test.app_instances where ins_id in (select ins_id from ced_test.app_instances_vw where ins_cod='APP-TST');
/

delete from ced_test.app_applications where ppl_cod='APP';
/
COMMIT;

