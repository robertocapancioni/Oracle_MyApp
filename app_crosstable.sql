delete from ced_test.app_tables 
 where tab_ins_id=( select ins_id from ced_test.app_instances_vw where  app_cod='HR' and  env_cod='DEV');

insert into ced_test.app_tables (tab_cod,tab_desc,tab_order,tab_ins_id) values('AZN','Azienda','101',( select ins_id from ced_test.app_instances_vw where  app_cod='HR' and  env_cod='DEV'));
insert into ced_test.app_tables (tab_cod,tab_desc,tab_order,tab_ins_id) values('COR','Corso',  '102',( select ins_id from ced_test.app_instances_vw where  app_cod='HR' and  env_cod='DEV'));
insert into ced_test.app_tables (tab_cod,tab_desc,tab_order,tab_ins_id) values('PRS','Persona','103',( select ins_id from ced_test.app_instances_vw where  app_cod='HR' and  env_cod='DEV'));
insert into ced_test.app_tables (tab_cod,tab_desc,tab_order,tab_ins_id) values('UOR','UnitaOrg','104',( select ins_id from ced_test.app_instances_vw where  app_cod='HR' and  env_cod='DEV'));
insert into ced_test.app_tables (tab_cod,tab_desc,tab_order,tab_ins_id) values('TCO','TipoCorso','105',( select ins_id from ced_test.app_instances_vw where  app_cod='HR' and  env_cod='DEV'));
insert into ced_test.app_tables (tab_cod,tab_desc,tab_order,tab_ins_id) values('DOC','Docente','106',( select ins_id from ced_test.app_instances_vw where  app_cod='HR' and  env_cod='DEV'));
insert into ced_test.app_tables (tab_cod,tab_desc,tab_order,tab_ins_id) values('DIP','Dipendente','107',( select ins_id from ced_test.app_instances_vw where  app_cod='HR' and  env_cod='DEV'));
insert into ced_test.app_tables (tab_cod,tab_desc,tab_order,tab_ins_id) values('DCO','DateCorso','108',( select ins_id from ced_test.app_instances_vw where  app_cod='HR' and  env_cod='DEV'));
insert into ced_test.app_tables (tab_cod,tab_desc,tab_order,tab_ins_id) values('CST','CostoOrario','109',( select ins_id from ced_test.app_instances_vw where  app_cod='HR' and  env_cod='DEV'));
insert into ced_test.app_tables (tab_cod,tab_desc,tab_order,tab_ins_id) values('CDO','CorsoDocente','110',( select ins_id from ced_test.app_instances_vw where  app_cod='HR' and  env_cod='DEV'));
insert into ced_test.app_tables (tab_cod,tab_desc,tab_order,tab_ins_id) values('CDI','CorsoDipendente','111',( select ins_id from ced_test.app_instances_vw where  app_cod='HR' and  env_cod='DEV'));



select m_tab_cod,m_tab_desc,m_tab_order, o_tab_cod,o_tab_desc,o_tab_order, rel_one_tab_cod, tre_cod,tre_desc from ced_test.app_relations_vw where m_ins_cod='HR-DEV' order by m_tab_order,o_tab_order



select tables_m,tables_o from (
select ' 'tables_m, 0 tab_order,listagg(o.tab_desc,';') within group (order by o.tab_order) tables_o  from ced_test.app_tables_vw o where o.ins_cod='HR-DEV' and o.ins_cod='HR-DEV'
union all
select distinct m.tab_desc, m.tab_order,listagg(m.tab_cod||' - '||o.tab_cod,';') within group (order by o.tab_order) over(partition by m.tab_cod) tables  from ced_test.app_tables_vw m,ced_test.app_tables_vw o where m.ins_cod='HR-DEV' and o.ins_cod='HR-DEV' 
)a0
order by tab_order


select 
  empno, 
  apex_item.hidden(1,empno)||apex_item.text(2,ename) ename, 
  apex_item.text(3,job) job, 
  mgr, 
  apex_item.date_popup(4,rownum,hiredate,'dd-mon-yyyy') hiredate,
  apex_item.text(5,sal) sal, 
  apex_item.text(6,comm) comm,
  deptno
from emp
order by 1

listagg(last_name, '; ')
         within group (order by hire_date, last_name) "Emp_list",
         
         
apex_item.hidden(1,empno)||apex_item.text(2,ename) ename


select distinct m.tab_desc, m.tab_order,listagg(apex_item.hidden(1,m.tab_cod||'-'||o.tab_cod)||apex_item.text(2,''),'') within group (order by o.tab_order) over(partition by m.tab_cod) tables  from ced_test.app_tables_vw m,ced_test.app_tables_vw o where m.ins_cod='HR-DEV' and o.ins_cod='HR-DEV' 


)a0
order by tab_order



declare
   v_print   varchar2 (4000);
   cursor my_form is 
   
   select distinct 
   listagg(
     apex_item.hidden(1,m.tab_cod
   ||'-'
   ||o.tab_cod)
   ||apex_item.text(2,'')
   ||'<br/>'
   ,'') 
   within group (order by o.tab_order) over(partition by m.tab_cod) tables  from ced_test.app_tables_vw m,ced_test.app_tables_vw o where m.ins_cod='HR-DEV' and o.ins_cod='HR-DEV';

begin
   for x in my_form
   loop
        htp.prn (x.tables);
   end loop;
end;





declare
   cursor my_head is
      select '<tr><th>-</th><th>'||(listagg(o.tab_cod,'</th><th>') within group (order by o.tab_order))||'</th></tr>' tables  from ced_test.app_tables_vw o where o.ins_cod='HR-DEV' and o.ins_cod='HR-DEV';
   
   cursor my_body is 
    select distinct m_tab_order,'<tr><td>'||m_tab_cod||' - '||m_tab_desc||'</td><td>'||(listagg(case when m_tab_order >= o_tab_order then apex_item.hidden(1,m_tab_cod)||apex_item.hidden(2,o_tab_cod,null,'')||apex_item.text(3,tre_cod,1) else ' 'end,'</td><td>') within group (order by o_tab_order) over(partition by m_tab_cod))||'</td></tr>' tables  
    from 
    (
    select a0.*,
    tre_cod from(
    select m.tab_id m_tab_id,m.tab_cod m_tab_cod,m.tab_desc m_tab_desc,m.tab_order m_tab_order,
           o.tab_id o_tab_id,o.tab_cod o_tab_cod,o.tab_desc o_tab_desc,o.tab_order o_tab_order,
           m.ins_cod,
           m.ins_id
      from ced_test.app_tables_vw m,
           ced_test.app_tables_vw o 
     where m.ins_id=o.ins_id 
    )a0,
    ced_test.app_relations_vw r
     where  ins_cod='HR-DEV'
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
end;


select a0.*,
tre_cod from(
select m.tab_id m_tab_id,m.tab_cod m_tab_cod,m.tab_desc m_tab_desc,m.tab_order m_tab_order,
       o.tab_id o_tab_id,o.tab_cod o_tab_cod,o.tab_desc o_tab_desc,o.tab_order o_tab_order,
       m.ins_cod,
       m.ins_id
  from ced_test.app_tables_vw m,
       ced_test.app_tables_vw o 
 where m.ins_id=o.ins_id 
)a0,
ced_test.app_relations_vw r
 where  ins_cod='HR-DEV'
   and  a0.m_tab_id = r.m_tab_id(+)
   and  a0.o_tab_id = r.o_tab_id(+)




select distinct m.tab_order m_tab_order,'<tr><td>'||m.tab_cod||' - '||m.tab_desc||'</td><td>'||(listagg(case when m.tab_order >= o.tab_order then apex_item.hidden(1,m.tab_cod||'-'||o.tab_cod)||apex_item.text(2,'',1) else ' 'end,'</td><td>') within group (order by o.tab_order) over(partition by m.tab_cod))||'</td></tr>' tables  from ced_test.app_tables_vw m,ced_test.app_tables_vw o 
    where m.ins_cod='HR-DEV' and o.ins_cod='HR-DEV'
    order by m.tab_order;
   
select sysdate_yyyymmdd from dual