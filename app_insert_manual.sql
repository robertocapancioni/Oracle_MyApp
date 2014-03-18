create or replace view ced_test.mez_data_vw as select 1 dat_tipodata, trunc(sysdate) dat_datasit from dual;

create or replace view ced_test.app_p10_tables_vw as
select TAB_ID,TAB_COD ||' - '|| TAB_DES TAB_DES,TAB_ORDER, PPL_ID, PPL_COD||' - '||PPL_DES PPL_DES, ENV_ID, ENV_COD||' - '||ENV_DES ENV_DES,INS_ID, INS_COD||' - '||INS_DES INS_DES from ced_test.app_tables_vw


/*
select distinct ppl_des,ppl_id from ced_test.app_p10_tables_vw order by 1

select ppl_id from ced_test.app_p10_tables_vw where tab_id = :P10_TPC_FK_TAB_ID

select distinct env_des,env_id from ced_test.app_p10_tables_vw order by 1

select env_id from ced_test.app_p10_tables_vw where tab_id = :P10_TPC_FK_TAB_ID

select tab_des,tab_id from ced_test.app_p10_tables_vw where ppl_id = :P10_TPC_APPLICATION and env_id = :P10_TPC_ENVIRONMENT
*/

create or replace view ced_test.app_p20_tables_vw as select * from ced_test.app_p10_tables_vw;


select * from #OWNER#.app_p20_tables_vw order by tab_des,app_des,env_des,ins_des