delete from robertocapancioni.app_relations where rel_id in (select rel_id from robertocapancioni.app_relations_vw where m_ins_cod = 'APP-TST'); 
/

delete from robertocapancioni.app_tabtpl where ttl_id in (select ttl_id from robertocapancioni.app_tabtpl_vw where ins_cod='APP-TST');
/

delete from robertocapancioni.app_tabcols where tcl_id in (select tcl_id from robertocapancioni.app_tabcols_vw where ins_cod='APP-TST');
/

delete from robertocapancioni.app_tabcols where tcl_id in (select tcl_id from robertocapancioni.app_tabcols_vw where ins_cod='APP-TST');
/

delete from robertocapancioni.app_tables where tab_id in (select tab_id from robertocapancioni.app_tables_vw where ins_cod='APP-TST');
/

delete from robertocapancioni.app_instances where ins_id in (select ins_id from robertocapancioni.app_instances_vw where ins_cod='APP-TST');
/

delete from robertocapancioni.app_applications where ppl_cod='APP';
/
COMMIT;
/

begin
 robertocapancioni.app_pkg.sql_init_data();
end;
/

insert into robertocapancioni.app_applications (ppl_cod, ppl_des) values ('APP','CREATE APPLICATIONS'); 

/


/*
insert into robertocapancioni.app_instances
procedure instances_create (p_ins_cod in varchar2,
                            p_ins_des in varchar2,
                            p_ins_pref in varchar2, 
                            p_ins_schema in varchar2, 
                            p_app_cod in varchar2,
                            p_env_cod in varchar2,
                            p_ins_isapex in varchar2 default 'N')
*/

begin
 robertocapancioni.app_pkg.instances_create('APP-TST','CREATE APPLICATIONS - TEST'       ,'APP','robertocapancioni','APP','TST','Y');
end;

/

/*
    insert into robertocapancioni.app_tables
    procedure table_create (p_tab_cod in varchar2,
                            p_tab_des in varchar2,
                            p_tab_order in number,
                            p_ins_cod in varchar2,
                            p_tab_islov in varchar2 default 'N',
                            p_tab_ispk in varchar2 default 'Y'
                            );
*/

begin
 robertocapancioni.app_pkg.table_create ('PPL','APPLICATIONS',501,'APP-TST','Y');
 robertocapancioni.app_pkg.table_create ('ENV','ENVIRONMENT',502,'APP-TST','Y');
 robertocapancioni.app_pkg.table_create ('INS','INSTANCES',503,'APP-TST','Y');
 robertocapancioni.app_pkg.table_create ('TRE','TRELATIONS',504,'APP-TST','Y');
 robertocapancioni.app_pkg.table_create ('TAB','TABLES',505,'APP-TST','Y');
 robertocapancioni.app_pkg.table_create ('TPL','TEMPLATES',506,'APP-TST','Y');
 robertocapancioni.app_pkg.table_create ('TPC','TPLCOLS',507,'APP-TST','N');
 robertocapancioni.app_pkg.table_create ('TCL','TABCOLS',508,'APP-TST','N');
 robertocapancioni.app_pkg.table_create ('TTL','TABTPL',509,'APP-TST','N');
 robertocapancioni.app_pkg.table_create ('REL','RELATIONS',510,'APP-TST','N');
end;
/
  
insert into robertocapancioni.app_tabtpl (ttl_tpl_id, ttl_tab_id, ttl_order) (select tpl_id,tab_id,rank() over(partition by tab_id order by tpl_id)ord from robertocapancioni.app_templates,robertocapancioni.app_tables_vw where ins_cod='APP-TST' and tpl_cod in('PK','COD','META'));

/*
   procedure robertocapancioni.app_pkg.tabtpl_delete (p_tpl_cod in varchar2,
                             p_tab_cod in varchar2,
                             p_ins_cod in varchar2);*/

begin                                 
 robertocapancioni.app_pkg.tabtpl_delete ('COD','REL','APP-TST');
end;

/



/*
select * from robertocapancioni.app_tabcols;

procedure robertocapancioni.app_pkg.tabcols_create (
                p_tcl_cod in varchar2,
                p_tcl_des in varchar2,
                p_tcl_order in number,
                p_tab_cod in varchar2, 
                p_ins_cod in varchar2,
                p_tcl_type in varchar2 default 'VARCHAR2(100)', 
                p_tcl_ispk in varchar2 default 'N', 
                p_tcl_isnull in varchar2 default 'Y', 
                p_tcl_default in varchar2 default '''-''',  
                p_tcl_isfk in varchar2 default 'N', 
                p_tcl_fk_tab_cod in varchar2 default null)
*/
begin
 robertocapancioni.app_pkg.tabcols_create ('PREF','APPLICATION PREFIX',101,'INS','APP-TST','VARCHAR2(32)','N','N','''-''');
 robertocapancioni.app_pkg.tabcols_create ('SCHEMA','APPLICATION SCHEMA',102,'INS','APP-TST','VARCHAR2(32)','N','N','''-''');
 robertocapancioni.app_pkg.tabcols_create ('ISPREFLD','ADD PREFIX FIELDS',103,'INS','APP-TST','VARCHAR2(1)','N','N','''Y''');
 robertocapancioni.app_pkg.tabcols_create ('ISPRESCHEMA','ADD PREFIX SCHEMA',104,'INS','APP-TST','VARCHAR2(1)','N','N','''Y''');
 robertocapancioni.app_pkg.tabcols_create ('ISPRETAB','ADD PREFIX TABLES',105,'INS','APP-TST','VARCHAR2(1)','N','N','''Y''');
 robertocapancioni.app_pkg.tabcols_create ('ISSTANAMFK','ADD STANDARDS NAMES FK',107,'INS','APP-TST','VARCHAR2(1)','N','N','''Y''');
 robertocapancioni.app_pkg.tabcols_create ('PREFCHAR','PREFIX CHAR',108,'INS','APP-TST','VARCHAR2(1)','N','N','''_''');
 robertocapancioni.app_pkg.tabcols_create ('IDCHAR','ID CHAR',109,'INS','APP-TST','VARCHAR2(10)','N','N','''ID''');
 robertocapancioni.app_pkg.tabcols_create ('PKCHAR','PK CHAR',110,'INS','APP-TST','VARCHAR2(10)','N','N','''PK''');
 robertocapancioni.app_pkg.tabcols_create ('FKCHAR','FK CHAR',111,'INS','APP-TST','VARCHAR2(10)','N','N','''FK''');
 robertocapancioni.app_pkg.tabcols_create ('ISAPEX','IS AN APEX APPLICATION',112,'INS','APP-TST','VARCHAR2(1)','N','N','''N''');
 robertocapancioni.app_pkg.tabcols_create ('ISUSESEQ','USE SEQUENCES FOR SURROGATE KEY',113,'INS','APP-TST','VARCHAR2(1)','N','N','''Y''');

 robertocapancioni.app_pkg.tabcols_create ('ISPK','CREATE PRIMARY KEY WITH ID',101,'TAB','APP-TST','VARCHAR2(1)','N','N','''Y''');
 robertocapancioni.app_pkg.tabcols_create ('ISLOV','CREATE VIEW LIST OF VALUES',102,'TAB','APP-TST','VARCHAR2(1)','N','N','''N''');
 robertocapancioni.app_pkg.tabcols_create ('ORDER','ORDER',103,'TAB','APP-TST','NUMBER','N','N','0');

 robertocapancioni.app_pkg.tabcols_create ('ORDER','ORDER',101,'TPL','APP-TST','NUMBER','N','N','0');

 robertocapancioni.app_pkg.tabcols_create ('ORDER','ORDER',101,'TPC','APP-TST','NUMBER','N','N','0');
 robertocapancioni.app_pkg.tabcols_create ('TYPE','DATA TYPE',102,'TPC','APP-TST','VARCHAR2(100)','N','N','''VARCHAR2(100)''');
 robertocapancioni.app_pkg.tabcols_create ('ISPK','CREATE PRIMARY KEY WITH ID',103,'TPC','APP-TST','VARCHAR2(1)','N','N','''N''');
 robertocapancioni.app_pkg.tabcols_create ('ISFK','IS FORWIGN KEY',104,'TPC','APP-TST','VARCHAR2(1)','N','N','''N''');
 robertocapancioni.app_pkg.tabcols_create ('ISNULL','IS NULL',105,'TPC','APP-TST','VARCHAR2(1)','N','N','''Y''');
 robertocapancioni.app_pkg.tabcols_create ('DEFAULT','IS DEFAULT',106,'TPC','APP-TST','VARCHAR2(100)','N','Y');

 robertocapancioni.app_pkg.tabcols_create ('ORDER','ORDER',101,'TCL','APP-TST','NUMBER','N','N','0');
 robertocapancioni.app_pkg.tabcols_create ('TYPE','DATA TYPE',102,'TCL','APP-TST','VARCHAR2(100)','N','N','''VARCHAR2(100)''');
 robertocapancioni.app_pkg.tabcols_create ('ISPK','CREATE PRIMARY KEY WITH ID',103,'TCL','APP-TST','VARCHAR2(1)','N','N','''N''');
 robertocapancioni.app_pkg.tabcols_create ('ISFK','IS FOREIGN KEY',104,'TCL','APP-TST','VARCHAR2(1)','N','N','''N''');
 robertocapancioni.app_pkg.tabcols_create ('ISNULL','IS NULL',105,'TCL','APP-TST','VARCHAR2(1)','N','N','''Y''');
 robertocapancioni.app_pkg.tabcols_create ('DEFAULT','IS DEFAULT',106,'TCL','APP-TST','VARCHAR2(100)','N','Y');

 robertocapancioni.app_pkg.tabcols_create ('ORDER','ORDER',101,'TTL','APP-TST','NUMBER','N','N','0');

 robertocapancioni.app_pkg.tabcols_create ('ONE_TAB_COD','RENAME FIELD FK',101,'REL','APP-TST','VARCHAR2(32)','N','Y');
end;
/

/*
-- insert into robertocapancioni.app_relations
procedure robertocapancioni.app_pkg.relations_create (
                p_m_tab_cod in varchar2,
                p_o_tab_cod in varchar2,
                p_tre_cod in varchar2,
                p_ins_cod in varchar2,
                p_rel_one_tab_cod in varchar2 DEFAULT null);
*/

begin
 robertocapancioni.app_pkg.relations_create ('INS', 'PPL','1' ,'APP-TST');
 robertocapancioni.app_pkg.relations_create ('INS', 'ENV','1' ,'APP-TST');
 robertocapancioni.app_pkg.relations_create ('TAB', 'INS','1' ,'APP-TST');
 robertocapancioni.app_pkg.relations_create ('TPC', 'TPL','1' ,'APP-TST');
 robertocapancioni.app_pkg.relations_create ('TPC', 'TAB','-1' ,'APP-TST','fk_tab');
 robertocapancioni.app_pkg.relations_create ('TCL', 'TAB','-1' ,'APP-TST','fk_tab');
 robertocapancioni.app_pkg.relations_create ('TCL', 'TAB','1' ,'APP-TST');
 robertocapancioni.app_pkg.relations_create ('REL', 'TRE','1' ,'APP-TST');
 robertocapancioni.app_pkg.relations_create ('TTL', 'TPL','1' ,'APP-TST');
 robertocapancioni.app_pkg.relations_create ('TTL', 'TAB','1' ,'APP-TST');
 robertocapancioni.app_pkg.relations_create ('REL', 'TAB','1' ,'APP-TST','many_tab');
 robertocapancioni.app_pkg.relations_create ('REL', 'TAB','1' ,'APP-TST','one_tab');
 robertocapancioni.app_pkg.relations_create ('REL', 'TRE','1' ,'APP-TST');
end;
/    

-- robertocapancioni.app_pkg.sql_drop('APP'-TST');

-- robertocapancioni.app_pkg.sql_create('APP-TST');



COMMIT;
/
?