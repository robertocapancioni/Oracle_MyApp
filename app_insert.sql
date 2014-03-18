insert into ced_test.app_applications (app_cod, app_des) values ('AP1','APP 1');
/

insert into ced_test.app_environment (env_cod, env_des) values ('DEV','DEVELOPMENT');
insert into ced_test.app_environment (env_cod, env_des) values ('TST','TEST');
insert into ced_test.app_environment (env_cod, env_des) values ('PRD','PRODUCTION');
/

insert into ced_test.app_trelations (tre_cod, tre_des) values ('1','1 FK ID MANDATORY');
insert into ced_test.app_trelations (tre_cod, tre_des) values ('-1','1 FK ID NOT MANDATORY');
insert into ced_test.app_trelations (tre_cod, tre_des) values ('2','2 FK ID MANDATORY');
insert into ced_test.app_trelations (tre_cod, tre_des) values ('-2','2 FK ID NOT MANDATORY');
--insert into ced_test.app_trelations (tre_cod, tre_des) values ('0','NO ID FIELD');
/

/*
insert into ced_test.app_instances
procedure instances_create (p_ins_cod in varchar2,
                            p_ins_des in varchar2,
                            p_ins_pref in varchar2, 
                            p_ins_schema in varchar2, 
                            p_app_cod in varchar2,
                            p_env_cod in varchar2)
*/

call ced_test.app_pkg.instances_create('AP1-DEV','APPLICATION 01 - DEVELOPMENT','APD','CED','AP1','DEV');
call ced_test.app_pkg.instances_create('AP1-TST','APPLICATION 01 - TEST'       ,'APP','CED','AP1','TST');
call ced_test.app_pkg.instances_create('AP1-PRD','APPLICATION 01 - PRODUCTION' ,'APP','CED','AP1','PRD');

/

/*
    insert into ced_test.app_tables
    procedure table_create (p_tab_cod in varchar2,
                            p_tab_des in varchar2,
                            p_tab_order in number,
                            p_app_cod in varchar2,
                            p_env_cod in varchar2,
                            p_tab_ispk in varchar2 default 'Y');
*/

call ced_test.app_pkg.table_create ('APP','Application',101,'AP1','DEV');
call ced_test.app_pkg.table_create ('ENV','Environment',102,'AP1','DEV');
call ced_test.app_pkg.table_create ('TRE','TRelations' ,103,'AP1','DEV');
call ced_test.app_pkg.table_create ('INS','Instances'  ,104,'AP1','DEV');
call ced_test.app_pkg.table_create ('TAB','Tables'     ,105,'AP1','DEV');
call ced_test.app_pkg.table_create ('TPL','Templates'  ,106,'AP1','DEV');
call ced_test.app_pkg.table_create ('TPC','TplCols'    ,107,'AP1','DEV');
call ced_test.app_pkg.table_create ('TCL','TabCols'    ,108,'AP1','DEV');
call ced_test.app_pkg.table_create ('TTL','TabTpl'     ,109,'AP1','DEV');
call ced_test.app_pkg.table_create ('REL','Relations'  ,110,'AP1','DEV');

call ced_test.app_pkg.table_create ('APP','Application',101,'AP1','TST');
call ced_test.app_pkg.table_create ('ENV','Environment',102,'AP1','TST');
call ced_test.app_pkg.table_create ('TRE','TRelations' ,103,'AP1','TST');
call ced_test.app_pkg.table_create ('INS','Instances'  ,104,'AP1','TST');
call ced_test.app_pkg.table_create ('TAB','Tables'     ,105,'AP1','TST');
call ced_test.app_pkg.table_create ('TPL','Templates'  ,106,'AP1','TST');
call ced_test.app_pkg.table_create ('TPC','TplCols'    ,107,'AP1','TST');
call ced_test.app_pkg.table_create ('TCL','TabCols'    ,108,'AP1','TST');
call ced_test.app_pkg.table_create ('TTL','TabTpl'     ,109,'AP1','TST');
call ced_test.app_pkg.table_create ('REL','Relations'  ,110,'AP1','TST');

insert into ced_test.app_templates (tpl_cod, tpl_des, tpl_order) values ('EMPTY','NO EXTRA COLS', 0);
insert into ced_test.app_templates (tpl_cod, tpl_des, tpl_order) values ('PK','PRIMARY KEY', 10);
insert into ced_test.app_templates (tpl_cod, tpl_des, tpl_order) values ('COD','COD AND DESCRIPTION', 20);
insert into ced_test.app_templates (tpl_cod, tpl_des, tpl_order) values ('HIST','HISTORY', 30);
insert into ced_test.app_templates (tpl_cod, tpl_des, tpl_order) values ('META','METADATA', 40);
/
                          
                          p_tpc_type in varchar2 default 'VARCHAR2(100)', 
                          p_tpc_ispk in varchar2 default 'N', 
                          p_tpc_isnull in varchar2 default 'Y', 
                          p_tpc_default in varchar2 default '-',  
                          p_tpc_isfk in varchar2 default 'N', 
                          
                          
/*
insert into ced_test.app_tplcols
procedure tplcols_create (p_tpc_cod in varchar2,
                          p_tpc_des in varchar2,
                          p_tpc_order in number,
                          p_tpl_cod in varchar2,
                          p_tpc_type in varchar2 default 'VARCHAR2(100)',
                          p_tpc_ispk in varchar2 default 'N',
                          p_tpc_isnull in varchar2 default 'Y',
                          p_tpc_default in varchar2 default '-')

*/

call ced_test.app_pkg.tplcols_create('ID'                ,'ID'                ,  1,'PK'  ,'NUMBER'       ,'Y','N','TRIGGER'); 
call ced_test.app_pkg.tplcols_create('COD'               ,'COD'               , 10,'COD' ,'VARCHAR2(32)' ,'N','N','-');
call ced_test.app_pkg.tplcols_create('DES'               ,'DESCRIPTION'       , 11,'COD' ,'VARCHAR2(100)','N','N','-');
call ced_test.app_pkg.tplcols_create('DATE_START'        ,'DATE_START'        ,980,'HIST','DATE'         ,'N','N','TO_DATE(''01/01/1900'',''dd/mm/yyyy'')');
call ced_test.app_pkg.tplcols_create('DATE_END'          ,'DATE_END'          ,981,'HIST','DATE'         ,'N','N','TO_DATE(''31/12/2099'',''dd/mm/yyyy'')');
call ced_test.app_pkg.tplcols_create('CREATED'           ,'CREATED'           ,990,'META','DATE'         ,'N','N','TRIGGER');
call ced_test.app_pkg.tplcols_create('CREATED_BY'        ,'CREATED_BY'        ,991,'META','VARCHAR2(100)','N','N','TRIGGER');
call ced_test.app_pkg.tplcols_create('UPDATED'           ,'UPDATED'           ,992,'META','DATE'         ,'N','N','TRIGGER');
call ced_test.app_pkg.tplcols_create('UPDATED_BY'        ,'UPDATED_BY'        ,993,'META','VARCHAR2(100)','N','N','TRIGGER');
call ced_test.app_pkg.tplcols_create('ROW_VERSION_NUMBER','ROW_VERSION_NUMBER',994,'META','NUMBER'       ,'N','N','TRIGGER');

insert into ced_test.app_tplcols (tpc_cod, tpc_des, tpc_tpl_id, tpc_order, tpc_isnull, tpc_type, tpc_default, tpc_ispk) values ('ID' ,'ID',    (select tpl_id from ced_test.app_templates where tpl_cod='PK'),'1','N','NUMBER','TRIGGER','Y');

insert into ced_test.app_tplcols (tpc_cod, tpc_des, tpc_tpl_id, tpc_order, tpc_isnull, tpc_type             ) values ('COD' ,'COD',    (select tpl_id from ced_test.app_templates where tpl_cod='COD'),'10','N','VARCHAR(32)');
insert into ced_test.app_tplcols (tpc_cod, tpc_des, tpc_tpl_id, tpc_order, tpc_isnull, tpc_type             ) values ('DES','DESCRIPTION',(select tpl_id from ced_test.app_templates where tpl_cod='COD'),'11','N','VARCHAR(100)');

insert into ced_test.app_tplcols (tpc_cod, tpc_des, tpc_tpl_id, tpc_order, tpc_isnull, tpc_type, tpc_default) values ('DATE_START' ,'DATE_START',(select tpl_id from ced_test.app_templates where tpl_cod='HIST'),'980','N','DATE','TO_DATE(''01/01/1900'',''dd/mm/yyyy'')');
insert into ced_test.app_tplcols (tpc_cod, tpc_des, tpc_tpl_id, tpc_order, tpc_isnull, tpc_type, tpc_default) values ('DATE_END'   ,'DATE_END'  ,(select tpl_id from ced_test.app_templates where tpl_cod='HIST'),'981','N','DATE','TO_DATE(''31/12/2099'',''dd/mm/yyyy'')');

insert into ced_test.app_tplcols (tpc_cod, tpc_des, tpc_tpl_id, tpc_order, tpc_isnull, tpc_type, tpc_default) values ('CREATED' ,'CREATED',    (select tpl_id from ced_test.app_templates where tpl_cod='META'),'990','N','DATE','TRIGGER');
insert into ced_test.app_tplcols (tpc_cod, tpc_des, tpc_tpl_id, tpc_order, tpc_isnull, tpc_type, tpc_default) values ('CREATED_BY','CREATED_BY',(select tpl_id from ced_test.app_templates where tpl_cod='META'),'991','N','VARCHAR2(100)','TRIGGER');
insert into ced_test.app_tplcols (tpc_cod, tpc_des, tpc_tpl_id, tpc_order, tpc_isnull, tpc_type, tpc_default) values ('UPDATED' ,'UPDATED',    (select tpl_id from ced_test.app_templates where tpl_cod='META'),'992','N','DATE','TRIGGER');
insert into ced_test.app_tplcols (tpc_cod, tpc_des, tpc_tpl_id, tpc_order, tpc_isnull, tpc_type, tpc_default) values ('UPDATED_BY','UPDATED_BY',(select tpl_id from ced_test.app_templates where tpl_cod='META'),'993','N','VARCHAR2(100)','TRIGGER');
insert into ced_test.app_tplcols (tpc_cod, tpc_des, tpc_tpl_id, tpc_order, tpc_isnull, tpc_type, tpc_default) values ('ROW_VERSION_NUMBER','ROW_VERSION_NUMBER',(select tpl_id from ced_test.app_templates where tpl_cod='META'),'994','N','NUMBER','TRIGGER');

/

/*
insert into ced_test.app_tabcols
procedure tabcols_create (
                          p_tcl_cod in varchar2,
                          p_tcl_des in varchar2,
                          p_tcl_order in number,
                          p_tab_cod in varchar2, 
                          p_app_cod in varchar2,
                          p_env_cod in varchar2,
                          p_tcl_type in varchar2 default 'VARCHAR2(100)', 
                          p_tcl_ispk in varchar2 default 'N', 
                          p_tcl_isnull in varchar2 default 'Y', 
                          p_tcl_default in varchar2 default '-',  
                          p_tcl_isfk in varchar2 default 'N', 
                          p_tcl_fk_tab_cod in varchar2 default null)

*/

call ced_test.app_pkg.tabcols_create ('COL1','COLUMN1','501','APP','AP1','DEV');
call ced_test.app_pkg.tabcols_create ('COL2','COLUMN2','502','APP','AP1','DEV');
call ced_test.app_pkg.tabcols_create ('COL3','COLUMN3','503','APP','AP1','DEV');

call ced_test.app_pkg.tabcols_create ('COL1','COLUMN1','501','ENV','AP1','DEV');
call ced_test.app_pkg.tabcols_create ('COL2','COLUMN2','502','ENV','AP1','DEV');
call ced_test.app_pkg.tabcols_create ('COL3','COLUMN3','503','ENV','AP1','DEV');
call ced_test.app_pkg.tabcols_create ('COL3','COLUMN4','504','ENV','AP1','DEV');

call ced_test.app_pkg.tabcols_create ('COL1','COLUMN1','501','TRE','AP1','DEV');
call ced_test.app_pkg.tabcols_create ('COL2','COLUMN2','502','TRE','AP1','DEV');
call ced_test.app_pkg.tabcols_create ('COL3','COLUMN3','503','TRE','AP1','DEV');
call ced_test.app_pkg.tabcols_create ('COL3','COLUMN4','504','TRE','AP1','DEV');

/

insert into ced_test.app_tabtpl (ttl_tpl_id, ttl_tab_id, ttl_order) (select tpl_id,tab_id,rank() over(partition by tab_id order by tpl_id)ord from ced_test.app_templates,ced_test.app_tables where tpl_cod in('PK','COD','HIST','META'));
/

/*
-- insert into ced_test.app_relations
procedure ced_test.app_pkg.relations_create (
                p_m_tab_cod in varchar2,
                p_o_tab_cod in varchar2,
                p_tre_cod in varchar2,
                p_app_cod in varchar2,
                p_env_cod in varchar2,
                p_rel_one_tab_cod in varchar2 DEFAULT null);
*/

call ced_test.app_pkg.relations_create ('INS', 'APP','1' ,'AP1','DEV');
call ced_test.app_pkg.relations_create ('INS', 'ENV','1' ,'AP1','DEV');
call ced_test.app_pkg.relations_create ('TPC', 'TPL','1' ,'AP1','DEV');
call ced_test.app_pkg.relations_create ('TAB', 'INS','1' ,'AP1','DEV');
call ced_test.app_pkg.relations_create ('TPC', 'TAB','-1','AP1','DEV','FK_TAB');
call ced_test.app_pkg.relations_create ('TCL', 'TAB','1' ,'AP1','DEV');
call ced_test.app_pkg.relations_create ('TCL', 'TAB','-1','AP1','DEV','FK_TAB');
call ced_test.app_pkg.relations_create ('REL', 'TRE','1' ,'AP1','DEV');
call ced_test.app_pkg.relations_create ('REL', 'TAB','1' ,'AP1','DEV' ,'MANY_TAB');
call ced_test.app_pkg.relations_create ('REL', 'TAB','1' ,'AP1','DEV' ,'ONE_TAB');
call ced_test.app_pkg.relations_create ('TTL', 'TPL','1' ,'AP1','DEV');
call ced_test.app_pkg.relations_create ('TTL', 'TAB','1' ,'AP1','DEV');


/    
