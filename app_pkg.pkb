create or replace package body ced_test.app_pkg
as
/*******************************************************************************
<pre>
artisan       date         comments
============ ============ ========================================================
r.capancioni   2013-10-17   initial creation
</pre>

<i>
    __________________________  lgpl license  ____________________________
    copyright (c) 1997-2008 bill coulam

    this library is free software; you can redistribute it and/or
    modify it under the terms of the gnu lesser general public
    license as published by the free software foundation; either
    version 2.1 of the license, or (at your option) any later version.

    this library is distributed in the hope that it will be useful,
    but without any warranty; without even the implied warranty of
    merchantability or fitness for a particular purpose. see the gnu
    lesser general public license for more details.

    you should have received a copy of the gnu lesser general public
    license along with this library; if not, write to the free software
    foundation, inc., 59 temple place, suite 330, boston, ma 02111-1307 usa
*******************************************************************************/


--------------------------------------------------------------------------------
--                 package constants, variables, types, exceptions
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
--                        private functions and procedures
--------------------------------------------------------------------------------

/*
procedure print_crosstable (p_ppl_cod in varchar2)
is
   cursor my_head is
        select '<tr><th>-</th><th>'||(listagg(o.tab_cod,'</th><th>') within group (order by o.tab_order))||'</th></tr>' tables  from ced_test.app_tables_vw o where o.ppl_cod=p_ppl_cod and o.env_cod=p_env_cod;
   
   cursor my_body is 
    select distinct m_tab_order, rel_one_tab_cod,'<tr><td>'||m_tab_cod||' - '||m_tab_des||'</td><td>'||(listagg(case when m_tab_order >= o_tab_order then apex_item.hidden(1,m_tab_cod)||apex_item.hidden(2,o_tab_cod,null,'')||apex_item.text(3,tre_cod,1) else ' 'end,'</td><td>') within group (order by o_tab_order) over(partition by m_tab_cod))||'</td></tr>' tables  
    from 
    (
    select a0.*,
    tre_cod, rel_one_tab_cod from(
    select m.tab_id m_tab_id,m.tab_cod m_tab_cod,m.tab_des m_tab_des,m.tab_order m_tab_order,
           o.tab_id o_tab_id,o.tab_cod o_tab_cod,o.tab_des o_tab_des,o.tab_order o_tab_order,
           m.ins_cod,
           m.ins_id,
           m.ppl_cod,
           m.env_cod
      from ced_test.app_tables_vw m,
           ced_test.app_tables_vw o 
     where m.ins_id=o.ins_id 
    )a0,
    ced_test.app_relations_vw r
     where  ppl_cod=p_ppl_cod and env_cod=p_env_cod
       and  a0.m_tab_id = r.m_tab_id(+)
       and  a0.o_tab_id = r.o_tab_id(+)
     )
     order by m_tab_order;
    
begin
   htp.prn('<table>');
   for h in my_head
   loop
        htp.prn (h.tables);
   end loop;
   
   for b in my_body
   loop
        htp.prn (b.tables);
   end loop;
   
   htp.prn ('</table>');
end print_crosstable;
*/

procedure relations_create (p_m_tab_cod in varchar2,p_o_tab_cod in varchar2,p_tre_cod in varchar2,p_ins_cod in varchar2,p_rel_one_tab_cod in varchar2 default null)
is
l_o_tab_id number;
l_m_tab_id number;
l_tre_id   number;
l_num number;
begin

        select tab_id into l_o_tab_id from ced_test.app_tables_vw where tab_cod = p_o_tab_cod and ins_cod = p_ins_cod;
        select tab_id into l_m_tab_id from ced_test.app_tables_vw where tab_cod = p_m_tab_cod and ins_cod = p_ins_cod;
        select tre_id into l_tre_id from  ced_test.app_trelations where tre_cod = p_tre_cod;


    
    --insert into ced_test.app_relations (rel_many_tab_id, rel_one_tab_id, rel_one_tab_cod, rel_tre_id) values (l_m_tab_id,l_o_tab_id,p_rel_one_tab_cod,l_tre_id);
    
    merge into   ced_test.app_relations d
     using  (select l_m_tab_id rel_many_tab_id,
                    l_o_tab_id rel_one_tab_id,
                    p_rel_one_tab_cod rel_one_tab_cod,
                    l_tre_id rel_tre_id
               from dual ) s
        on   (    s.rel_many_tab_id = d.rel_many_tab_id
              and s.rel_one_tab_id = d.rel_one_tab_id
              and nvl(s.rel_one_tab_cod,'-') = nvl(d.rel_one_tab_cod,'-')
             )
when matched
then
   update set  d.rel_tre_id = s.rel_tre_id
when not matched
then
   insert         (rel_many_tab_id, 
                   rel_one_tab_id, 
                   rel_one_tab_cod, 
                   rel_tre_id)
       values   (s.rel_many_tab_id, 
                 s.rel_one_tab_id, 
                 s.rel_one_tab_cod, 
                 s.rel_tre_id);

    --exception when no_data_found then null;
end relations_create;

procedure table_create (p_tab_cod in varchar2,p_tab_des in varchar2,p_tab_order in number,p_ins_cod in varchar2,p_tab_islov in varchar2 default 'N',p_tab_ispk in varchar2 default 'Y')
is
l_ins_id number;

begin
    select ins_id into l_ins_id   from ced_test.app_instances where ins_cod=p_ins_cod;
    

    merge into   ced_test.app_tables d
     using  (select upper(p_tab_cod) tab_cod,
                    upper(p_tab_des) tab_des,
                    p_tab_ispk tab_ispk,
                    p_tab_islov tab_islov,
                    p_tab_order tab_order,
                    l_ins_id tab_ins_id
               from dual ) s
        on   (    s.tab_cod = d.tab_cod
              and s.tab_ins_id = d.tab_ins_id
             )
when matched
then
   update set  d.tab_des = s.tab_des,
               d.tab_order = s.tab_order,
               d.tab_ispk = s.tab_ispk,
               d.tab_islov = s.tab_islov
when not matched
then
   insert              (tab_cod, 
                        tab_des, 
                        tab_ispk,
                        tab_islov,
                        tab_order, 
                        tab_ins_id)
       values   (     s.tab_cod, 
                      s.tab_des, 
                      s.tab_ispk,
                      s.tab_islov,
                      s.tab_order, 
                      s.tab_ins_id);

    --exception when no_data_found then null;
end table_create;

procedure tabcols_create (p_tcl_cod in varchar2,p_tcl_des in varchar2,p_tcl_order in number,p_tab_cod in varchar2,p_ins_cod in varchar2,p_tcl_type in varchar2 default 'VARCHAR2(100)',p_tcl_ispk in varchar2 default 'N',p_tcl_isnull in varchar2 default 'Y',p_tcl_default in varchar2 default null,p_tcl_isfk in varchar2 default 'N',p_tcl_fk_tab_cod in varchar2 default null)
is
l_ins_id number;
l_tab_id number;
l_fk_tab_id number;

begin
        
        select ins_id into l_ins_id   from ced_test.app_instances where ins_cod=p_ins_cod;
        select tab_id into l_tab_id   from ced_test.app_tables where tab_cod=p_tab_cod and tab_ins_id = l_ins_id;
        begin
            select tab_id into l_fk_tab_id   from ced_test.app_tables where tab_cod=p_tcl_fk_tab_cod and tab_ins_id = l_ins_id;
            exception when no_data_found then null;
        end;
    merge into   ced_test.app_tabcols d
     using  (select upper(p_tcl_cod) tcl_cod,
                    upper(p_tcl_des) tcl_des,
                    p_tcl_order tcl_order,
                    l_tab_id tcl_tab_id,
                    p_tcl_type tcl_type, 
                    p_tcl_ispk tcl_ispk, 
                    p_tcl_isnull tcl_isnull, 
                    p_tcl_default tcl_default,  
                    p_tcl_isfk tcl_isfk, 
                    l_fk_tab_id tcl_fk_tab_id
               from dual ) s
        on   (    s.tcl_cod = d.tcl_cod
              and s.tcl_tab_id = d.tcl_tab_id
             )
when matched
then
   update set  d.tcl_des = s.tcl_des,
               d.tcl_order = s.tcl_order,
               d.tcl_type = s.tcl_type, 
               d.tcl_ispk = s.tcl_ispk, 
               d.tcl_isnull = s.tcl_isnull, 
               d.tcl_default = s.tcl_default,  
               d.tcl_isfk = s.tcl_isfk, 
               d.tcl_fk_tab_id = s.tcl_fk_tab_id
when not matched
then
   insert              (tcl_cod,
                        tcl_des,
                        tcl_order,
                        tcl_tab_id,
                        tcl_type, 
                        tcl_ispk, 
                        tcl_isnull, 
                        tcl_default,  
                        tcl_isfk, 
                        tcl_fk_tab_id)
       values   (     s.tcl_cod,
                      s.tcl_des,
                      s.tcl_order,
                      s.tcl_tab_id,
                      s.tcl_type, 
                      s.tcl_ispk, 
                      s.tcl_isnull, 
                      s.tcl_default,  
                      s.tcl_isfk, 
                      s.tcl_fk_tab_id);

    --exception when no_data_found then null;
end tabcols_create;

procedure tabcols_delete (p_tcl_cod in varchar2,p_tab_cod in varchar2,p_ins_cod in varchar2)
is
l_ins_id number;
l_tab_id number;


begin
        
        select ins_id into l_ins_id   from ced_test.app_instances where ins_cod=p_ins_cod;
        select tab_id into l_tab_id   from ced_test.app_tables where tab_cod=p_tab_cod and tab_ins_id = l_ins_id;
        delete from  ced_test.app_tabcols d where tcl_tab_id = l_tab_id and tcl_cod = p_tcl_cod;
end tabcols_delete;

procedure tabtpl_delete (p_tpl_cod in varchar2,p_tab_cod in varchar2,p_ins_cod in varchar2)
is
l_ins_id number;
l_tab_id number;
l_tpl_id number;

begin
        
        select ins_id into l_ins_id   from ced_test.app_instances where ins_cod = p_ins_cod;
        select tab_id into l_tab_id   from ced_test.app_tables where tab_cod=p_tab_cod and tab_ins_id = l_ins_id;
        select tpl_id into l_tpl_id from ced_test.app_templates where tpl_cod=p_tpl_cod;
        delete from  ced_test.app_tabtpl d where ttl_tab_id = l_tab_id and ttl_tpl_id = l_tpl_id;
end tabtpl_delete;

procedure tplcols_create (p_tpc_cod in varchar2,p_tpc_des in varchar2,p_tpc_order in number,p_tpl_cod in varchar2,p_tpc_type in varchar2 default 'VARCHAR2(100)',p_tpc_ispk in varchar2 default 'N',p_tpc_isnull in varchar2 default 'Y',p_tpc_default in varchar2 default null)
is
l_tpl_id number;


begin

    select tpl_id into l_tpl_id from ced_test.app_templates where tpl_cod=p_tpl_cod;

     merge into   ced_test.app_tplcols d
     using  (select upper(p_tpc_cod) tpc_cod,
                    upper(p_tpc_des) tpc_des,
                    p_tpc_order tpc_order,
                    l_tpl_id tpc_tpl_id,
                    p_tpc_type tpc_type,
                    p_tpc_ispk tpc_ispk,
                    p_tpc_isnull tpc_isnull,
                    p_tpc_default tpc_default
               from dual ) s
        on   (    s.tpc_cod = d.tpc_cod
              and s.tpc_tpl_id = d.tpc_tpl_id
             )
when matched
then
   update set        d.tpc_des=s.tpc_des,
                     d.tpc_order=s.tpc_order,
                     d.tpc_type=s.tpc_type,
                     d.tpc_ispk=s.tpc_ispk,
                     d.tpc_isnull=s.tpc_isnull,
                     d.tpc_default=s.tpc_default
when not matched
then
   insert                (tpc_cod,
                          tpc_des,
                          tpc_order,
                          tpc_tpl_id,
                          tpc_type,
                          tpc_ispk,
                          tpc_isnull,
                          tpc_default)
       values   (       s.tpc_cod,
                        s.tpc_des,
                        s.tpc_order,
                        s.tpc_tpl_id,
                        s.tpc_type,
                        s.tpc_ispk,
                        s.tpc_isnull,
                        s.tpc_default);

    --exception when no_data_found then null;
end tplcols_create;

procedure instances_create (p_ins_cod in varchar2,p_ins_des in varchar2,p_ins_pref in varchar2, p_ins_schema in varchar2, p_ppl_cod in varchar2,p_env_cod in varchar2, p_ins_isapex in varchar2 default 'N')
is
l_ppl_id number;
l_env_id number;

begin

    select ppl_id into l_ppl_id from ced_test.app_applications where ppl_cod=p_ppl_cod;
    select env_id into l_env_id from ced_test.app_environment where env_cod=p_env_cod;

     merge into   ced_test.app_instances d
     using  (select upper(p_ins_cod) ins_cod, 
                    upper(p_ins_des) ins_des, 
                    p_ins_pref ins_pref, 
                    l_ppl_id ins_ppl_id, 
                    l_env_id ins_env_id, 
                    p_ins_schema ins_schema,
                    p_ins_isapex ins_isapex
               from dual ) s
        on   (    s.ins_cod = d.ins_cod
              and s.ins_ppl_id = d.ins_ppl_id
              and s.ins_env_id = d.ins_env_id
             )
when matched
then
   update set         d.ins_des=s.ins_des, 
                      d.ins_pref=s.ins_pref, 
                      d.ins_schema=s.ins_schema,
                      d.ins_isapex=s.ins_isapex
when not matched
then
   insert              (ins_cod, 
                        ins_des, 
                        ins_pref, 
                        ins_ppl_id, 
                        ins_env_id, 
                        ins_schema,
                        ins_isapex)
       values   (     s.ins_cod, 
                      s.ins_des, 
                      s.ins_pref, 
                      s.ins_ppl_id, 
                      s.ins_env_id, 
                      s.ins_schema,
                      s.ins_isapex);

    --exception when no_data_found then null;
end instances_create;

/* Formatted on 31/01/2014 11.25.09 (QP5 v5.126.903.23003) */

procedure sql_create(p_ins_cod in varchar2)
    is
    r1 app_sql_drop_create_block_vw%ROWTYPE;
    l_sql varchar2(32000);
    CURSOR c1 IS
        --select trim(replace(replace(cod,'',''),'''','''''')) cod from ced_test.app_sql_drop_create_block_vw 
        select cod from ced_test.app_sql_drop_create_block_vw
        where ins_cod=p_ins_cod
          --and tab_id in (1) 
          --and block_order in (3)
          and block_order >0; -- block_order >0 CREA;  block_order >0 ELIMINA;
    e              exception;
    pragma exception_init (e, -904);
    begin
        for r1 in c1 
          LOOP 
             begin
                l_sql := replace(replace(to_char(DBMS_LOB.SUBSTR(r1.cod, 32000,1)),'END; /','END;'),'; /','');
                execute immediate l_sql ;
                --dbms_output.put_line (sqlerrm);
                exception
                when e
                then
                  dbms_output.put_line (sqlerrm);
             end;

          END LOOP; 
    end sql_create;
    
procedure sql_drop(p_ins_cod in varchar2)
    is
    r1 app_sql_drop_create_block_vw%ROWTYPE;
    l_sql varchar2(32000);
    CURSOR c1 IS
        --select trim(replace(replace(cod,'',''),'''','''''')) cod from ced_test.app_sql_drop_create_block_vw 
        select cod from ced_test.app_sql_drop_create_block_vw
        where ins_cod=p_ins_cod
          --and tab_id in (10) 
          --and block_order = -5
          and block_order <0; -- block_order >0 CREA;  block_order >0 ELIMINA;
    begin
        for r1 in c1 
          LOOP 
             begin
                --l_sql := 'q''{'||to_char(DBMS_LOB.SUBSTR(r1.cod, 32000,1))||'}''';
                l_sql := replace(replace(to_char(DBMS_LOB.SUBSTR(r1.cod, 32000,1)),'END; /','END;'),'; /','');
                execute immediate l_sql ;
                --dbms_output.put_line (sqlerrm);
                exception
                when others
                then
                 null;
             end;

          END LOOP; 
    end sql_drop;
    
procedure sql_init_data
is
begin
    delete from ced_test.app_environment;
    insert into ced_test.app_environment (env_cod, env_des) values ('DEV','DEVELOPMENT');
    insert into ced_test.app_environment (env_cod, env_des) values ('TST','TEST');
    insert into ced_test.app_environment (env_cod, env_des) values ('PRD','PRODUCTION');
    
    delete from ced_test.app_trelations;
    insert into ced_test.app_trelations (tre_cod, tre_des) values ('1','1 FK ID MANDATORY');
    insert into ced_test.app_trelations (tre_cod, tre_des) values ('-1','1 FK ID NOT MANDATORY');
    insert into ced_test.app_trelations (tre_cod, tre_des) values ('2','2 FK ID MANDATORY');
    insert into ced_test.app_trelations (tre_cod, tre_des) values ('-2','2 FK ID NOT MANDATORY');
    
    delete from ced_test.app_templates;
    insert into ced_test.app_templates (tpl_cod, tpl_des, tpl_order) values ('EMPTY','NO EXTRA COLS', 0);
    insert into ced_test.app_templates (tpl_cod, tpl_des, tpl_order) values ('PK','PRIMARY KEY', 10);
    insert into ced_test.app_templates (tpl_cod, tpl_des, tpl_order) values ('COD','COD AND DESCRIPTION', 400);
    insert into ced_test.app_templates (tpl_cod, tpl_des, tpl_order) values ('HIST','HISTORY', 800);
    insert into ced_test.app_templates (tpl_cod, tpl_des, tpl_order) values ('META','METADATA', 900);
    
    /*
    insert into ced_test.app_tplcols
    procedure tplcols_create (p_tpc_cod in varchar2,
                              p_tpc_des in varchar2,
                              p_tpc_order in number,
                              p_tpl_cod in varchar2,
                              p_tpc_type in varchar2 default 'VARCHAR2(100)',
                              p_tpc_ispk in varchar2 default 'N',
                              p_tpc_isnull in varchar2 default 'Y',
                              p_tpc_default in varchar2 default null)

    */
    delete from ced_test.app_tplcols;
    ced_test.app_pkg.tplcols_create('ID'                ,'ID'                ,  0,'PK'  ,'NUMBER'       ,'Y','N','TRIGGER'); 
    ced_test.app_pkg.tplcols_create('COD'               ,'COD'               , 98,'COD' ,'VARCHAR2(32)' ,'N','N','''-''');
    ced_test.app_pkg.tplcols_create('DES'               ,'DESCRIPTION'       , 99,'COD' ,'VARCHAR2(100)','N','N','''-''');
    ced_test.app_pkg.tplcols_create('DATE_START'        ,'DATE_START'        ,980,'HIST','DATE'         ,'N','N','TO_DATE(''01/01/1900'',''dd/mm/yyyy'')');
    ced_test.app_pkg.tplcols_create('DATE_END'          ,'DATE_END'          ,981,'HIST','DATE'         ,'N','N','TO_DATE(''31/12/2099'',''dd/mm/yyyy'')');
    ced_test.app_pkg.tplcols_create('CREATED'           ,'CREATED'           ,990,'META','DATE'         ,'N','N','TRIGGER');
    ced_test.app_pkg.tplcols_create('CREATED_BY'        ,'CREATED_BY'        ,991,'META','VARCHAR2(100)','N','N','TRIGGER');
    ced_test.app_pkg.tplcols_create('UPDATED'           ,'UPDATED'           ,992,'META','DATE'         ,'N','N','TRIGGER');
    ced_test.app_pkg.tplcols_create('UPDATED_BY'        ,'UPDATED_BY'        ,993,'META','VARCHAR2(100)','N','N','TRIGGER');
    ced_test.app_pkg.tplcols_create('ROW_VERSION_NUMBER','ROW_VERSION_NUMBER',994,'META','NUMBER'       ,'N','N','TRIGGER');
    commit;
end sql_init_data;
end app_pkg;
/
