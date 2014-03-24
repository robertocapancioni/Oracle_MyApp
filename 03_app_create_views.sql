create or replace view robertocapancioni.app_instances_vw as
select ins_id, ins_cod, ins_des, ins_pref, ins_ppl_id, ins_env_id, ins_schema, ins_ispreschema, ins_isprefld, ins_ispretab, ins_isstanamfk, ins_prefchar, ins_idchar, ins_pkchar, ins_fkchar, ins_isapex, ins_isuseseq, 
       decode(upper(ins_ispreschema),'Y',upper(ins_schema||'.'),'') pref_schema,
       decode(upper(ins_ispretab),'Y',upper(ins_pref||ins_prefchar),'') pref_tab,
       upper(ins_prefchar||ins_idchar) suff_idchar,
       upper (ppl_cod) ppl_cod, upper (ppl_des) ppl_des,
       upper (env_cod) env_cod, upper (env_des) env_des
  from robertocapancioni.app_instances i,
       robertocapancioni.app_applications a,
       app_environment e
 where ins_ppl_id = ppl_id
   and ins_env_id = env_id;


create or replace view robertocapancioni.app_tables_vw as
select tab_id, upper (tab_cod) tab_cod, upper (tab_des) tab_des, tab_ispk, tab_islov, tab_order,
       decode(upper(ins_isprefld),'Y',upper(tab_cod||ins_prefchar),'') pref_col,i.*  
  from robertocapancioni.app_tables t,
       robertocapancioni.app_instances_vw i
 where tab_ins_id = ins_id;

create or replace view robertocapancioni.app_relations_vw as
select rel_id,  rel_one_tab_cod, decode(rel_one_tab_cod,null,o.pref_col,rel_one_tab_cod||o.ins_prefchar) o_real_pref_col ,tre_id, tre_cod, tre_des,
       m.tab_id m_tab_id,m.tab_cod m_tab_cod,m.tab_des m_tab_des,m.tab_ispk m_tab_ispk,m.tab_islov m_tab_islov,m.tab_order m_tab_order,m.ins_id m_ins_id,m.ins_cod m_ins_cod,m.ins_des m_ins_des,m.ins_pref m_ins_pref,m.ins_ppl_id m_ins_ppl_id,m.ppl_cod m_ppl_cod,m.ppl_des m_ppl_des,m.ins_env_id m_ins_env_id,m.env_cod m_env_cod,m.env_des m_env_des,m.ins_schema m_ins_schema,m.ins_ispreschema m_ins_ispreschema,m.ins_isprefld m_ins_isprefld,m.ins_ispretab m_ins_ispretab,m.ins_isstanamfk m_ins_isstanamfk,m.ins_prefchar m_ins_prefchar,m.ins_idchar m_ins_idchar,m.ins_pkchar m_ins_pkchar,m.ins_fkchar m_ins_fkchar,m.ins_isapex m_ins_isapex,m.ins_isuseseq m_ins_isuseseq,m.pref_schema m_pref_schema,m.pref_tab m_pref_tab,m.pref_col m_pref_col,m.suff_idchar m_suff_idchar,
       o.tab_id o_tab_id,o.tab_cod o_tab_cod,o.tab_des o_tab_des,o.tab_ispk o_tab_ispk,o.tab_islov o_tab_islov,o.tab_order o_tab_order,o.ins_id o_ins_id,o.ins_cod o_ins_cod,o.ins_des o_ins_des,o.ins_pref o_ins_pref,o.ins_ppl_id o_ins_ppl_id,o.ppl_cod o_ppl_cod,o.ppl_des o_ppl_des,o.ins_env_id o_ins_env_id,o.env_cod o_env_cod,o.env_des o_env_des,o.ins_schema o_ins_schema,o.ins_ispreschema o_ins_ispreschema,o.ins_isprefld o_ins_isprefld,o.ins_ispretab o_ins_ispretab,o.ins_isstanamfk o_ins_isstanamfk,o.ins_prefchar o_ins_prefchar,o.ins_idchar o_ins_idchar,o.ins_pkchar o_ins_pkchar,o.ins_fkchar o_ins_fkchar,o.ins_isapex o_ins_isapex,o.ins_isuseseq o_ins_isuseseq,o.pref_schema o_pref_schema,o.pref_tab o_pref_tab,o.pref_col o_pref_col,o.suff_idchar o_suff_idchar,
       n
  from robertocapancioni.app_relations tr,
       robertocapancioni.app_trelations r, 
       robertocapancioni.app_tables_vw m, 
       robertocapancioni.app_tables_vw o,
       (select rownum n from dual connect by level <= 10)n
 where tr.rel_many_tab_id = m.tab_id
   and tr.rel_one_tab_id = o.tab_id
   and tr.rel_tre_id = r.tre_id
   and abs(to_number(tre_cod))>=n;

create or replace force view robertocapancioni.app_tabtpl_vw as
select ttl_id,ttl_order,tpl_id,tpl_cod, tpl_des, tpl_order, tab_id, tab_cod, tab_des, tab_ispk, tab_islov, tab_order, pref_col, ins_id, ins_cod, ins_des, ins_pref, ins_ppl_id, ins_env_id, ins_schema, ins_ispreschema, ins_isprefld, ins_ispretab, ins_isstanamfk, ins_prefchar, ins_idchar, ins_pkchar, ins_fkchar, ins_isapex, ins_isuseseq, pref_schema, pref_tab, suff_idchar, ppl_cod, ppl_des, env_cod, env_des
  from robertocapancioni.app_tabtpl l,
       robertocapancioni.app_templates s,
       robertocapancioni.app_tables_vw t
where ttl_tpl_id = tpl_id and ttl_tab_id = tab_id;


/*inizio viste gemelle*/

create or replace force view robertocapancioni.app_tabcols_vw as
select 'TABCOLS' tcl_src, tcl_id, tcl_cod, tcl_des, tcl_order, tcl_type, tcl_ispk, tcl_isfk, tcl_isnull, tcl_default,
 t.tab_id, t.tab_cod, t.tab_des, t.tab_ispk, t.tab_islov, t.tab_order, t.pref_col, t.ins_id, t.ins_cod, t.ins_des, t.ins_pref, t.ins_ppl_id, t.ins_env_id, t.ins_schema, t.ins_ispreschema, t.ins_isprefld, t.ins_ispretab, t.ins_isstanamfk, t.ins_prefchar, t.ins_idchar, t.ins_pkchar, t.ins_fkchar, t.ins_isapex, t.ins_isuseseq, t.pref_schema, t.pref_tab, t.suff_idchar, t.ppl_cod, t.ppl_des, t.env_cod, t.env_des,
 f.tab_id fk_tab_id, f.tab_cod fk_tab_cod, f.tab_des fk_tab_des, f.tab_ispk fk_tab_ispk, f.tab_islov fk_tab_islov, f.tab_order fk_tab_order, f.pref_col fk_pref_col, f.ins_id fk_ins_id, f.ins_cod fk_ins_cod, f.ins_des fk_ins_des, f.ins_pref fk_ins_pref, f.ins_ppl_id fk_ins_ppl_id, f.ins_env_id fk_ins_env_id, f.ins_schema fk_ins_schema, f.ins_ispreschema fk_ins_ispreschema, f.ins_isprefld fk_ins_isprefld, f.ins_ispretab fk_ins_ispretab, f.ins_isstanamfk fk_ins_isstanamfk, f.ins_prefchar fk_ins_prefchar, f.ins_idchar fk_ins_idchar, f.ins_pkchar fk_ins_pkchar, f.ins_fkchar fk_ins_fkchar, f.ins_isapex fk_ins_isapex, f.ins_isuseseq fk_ins_isuseseq, f.pref_schema fk_pref_schema, f.pref_tab fk_pref_tab, f.suff_idchar fk_suff_idchar, f.ppl_cod fk_ppl_cod, f.ppl_des fk_ppl_des, f.env_cod fk_env_cod, f.env_des fk_env_des
 from robertocapancioni.app_tabcols c,robertocapancioni.app_tables_vw t,
            robertocapancioni.app_tables_vw f
    where   tcl_tab_id = t.tab_id
      and   tcl_fk_tab_id = f.tab_id(+);
      
              
create or replace force view robertocapancioni.app_tplcols_vw as
select 'TPLCOLS' tpc_src,tpc_id,tpc_cod,tpc_des,tpc_order,tpc_type,tpc_ispk,tpc_isfk,tpc_isnull,tpc_default,
       t.tab_id, t.tab_cod, t.tab_des, t.tab_ispk, t.tab_islov, t.tab_order, t.pref_col, t.ins_id, t.ins_cod, t.ins_des, t.ins_pref, t.ins_ppl_id, t.ins_env_id, t.ins_schema, t.ins_ispreschema, t.ins_isprefld, t.ins_ispretab,  t.ins_isstanamfk, t.ins_prefchar, t.ins_idchar, t.ins_pkchar, t.ins_fkchar, t.ins_isapex, t.ins_isuseseq, t.pref_schema, t.pref_tab, t.suff_idchar, t.ppl_cod, t.ppl_des, t.env_cod, t.env_des,
       f.tab_id fk_tab_id, f.tab_cod fk_tab_cod, f.tab_des fk_tab_des, f.tab_ispk fk_tab_ispk, f.tab_islov fk_tab_islov, f.tab_order fk_tab_order, f.pref_col fk_pref_col, f.ins_id fk_ins_id, f.ins_cod fk_ins_cod, f.ins_des fk_ins_des, f.ins_pref fk_ins_pref, f.ins_ppl_id fk_ins_ppl_id, f.ins_env_id fk_ins_env_id, f.ins_schema fk_ins_schema, f.ins_ispreschema fk_ins_ispreschema, f.ins_isprefld fk_ins_isprefld, f.ins_ispretab fk_ins_ispretab, f.ins_isstanamfk fk_ins_isstanamfk, f.ins_prefchar fk_ins_prefchar, f.ins_idchar fk_ins_idchar, f.ins_pkchar fk_ins_pkchar, f.ins_fkchar fk_ins_fkchar, f.ins_isapex fk_ins_isapex, f.ins_isuseseq fk_ins_isuseseq, f.pref_schema fk_pref_schema, f.pref_tab fk_pref_tab, f.suff_idchar fk_suff_idchar, f.ppl_cod fk_ppl_cod, f.ppl_des fk_ppl_des, f.env_cod fk_env_cod, f.env_des fk_env_des
       --tpl_cod, tpl_des, tpl_order,
       from robertocapancioni.app_tabtpl_vw t,
       robertocapancioni.app_tplcols p, 
       robertocapancioni.app_tables_vw f
 where tpc_tpl_id = tpl_id
   and tpc_fk_tab_id = f.tab_id(+);
      
create or replace force view robertocapancioni.app_relcols_vw as
select 'RELCOLS' rel_src,rel_id,
                      decode (rel_one_tab_cod,null,o_tab_cod|| case when abs (to_number (tre_cod)) > 1 then to_char (n) else '' end || o_suff_idchar, rel_one_tab_cod || o_suff_idchar) rel_cod,
                      decode (rel_one_tab_cod,null,o_tab_cod|| case when abs (to_number (tre_cod)) > 1 then to_char (n) else '' end || o_suff_idchar, rel_one_tab_cod || o_suff_idchar) rel_des,
                      o_tab_order rel_order,
                      'NUMBER' rel_type,
                      decode (tre_cod, 0, 'Y', 'N') rel_ispk,
                      'Y' rel_isfk,
                      decode (sign(tre_cod), 1, 'N', 'Y') rel_isnull,
                      null rel_default,
 t.tab_id, t.tab_cod, t.tab_des, t.tab_ispk, t.tab_islov, t.tab_order, t.pref_col, t.ins_id, t.ins_cod, t.ins_des, t.ins_pref, t.ins_ppl_id, t.ins_env_id, t.ins_schema, t.ins_ispreschema, t.ins_isprefld, t.ins_ispretab, t.ins_isstanamfk, t.ins_prefchar, t.ins_idchar, t.ins_pkchar, t.ins_fkchar, t.ins_isapex, t.ins_isuseseq, t.pref_schema, t.pref_tab, t.suff_idchar, t.ppl_cod, t.ppl_des, t.env_cod, t.env_des,
 f.tab_id fk_tab_id, f.tab_cod fk_tab_cod, f.tab_des fk_tab_des, f.tab_ispk fk_tab_ispk, f.tab_islov fk_tab_islov, f.tab_order fk_tab_order, f.pref_col fk_pref_col, f.ins_id fk_ins_id, f.ins_cod fk_ins_cod, f.ins_des fk_ins_des, f.ins_pref fk_ins_pref, f.ins_ppl_id fk_ins_ppl_id, f.ins_env_id fk_ins_env_id, f.ins_schema fk_ins_schema, f.ins_ispreschema fk_ins_ispreschema, f.ins_isprefld fk_ins_isprefld, f.ins_ispretab fk_ins_ispretab, f.ins_isstanamfk fk_ins_isstanamfk, f.ins_prefchar fk_ins_prefchar, f.ins_idchar fk_ins_idchar, f.ins_pkchar fk_ins_pkchar, f.ins_fkchar fk_ins_fkchar, f.ins_isapex fk_ins_isapex, f.ins_isuseseq fk_ins_isuseseq, f.pref_schema fk_pref_schema, f.pref_tab fk_pref_tab, f.suff_idchar fk_suff_idchar, f.ppl_cod fk_ppl_cod, f.ppl_des fk_ppl_des, f.env_cod fk_env_cod, f.env_des fk_env_des
 from robertocapancioni.app_relations_vw r,robertocapancioni.app_tables_vw t,
            robertocapancioni.app_tables_vw f
    where   m_tab_id = t.tab_id
      and   o_tab_id = f.tab_id(+);

/* fine viste gemelle*/           

create or replace force view robertocapancioni.app_cols_vw 
(col_src, col_id, col_cod, col_des, col_order, col_type, col_ispk, col_isfk, col_isnull, col_default, 
 tab_id, tab_cod, tab_des, tab_ispk, tab_islov, tab_order, pref_col, ins_id, ins_cod, ins_des, ins_pref, ins_ppl_id, ins_env_id, ins_schema, ins_ispreschema, ins_isprefld, ins_ispretab, ins_isstanamfk, ins_prefchar, ins_idchar, ins_pkchar, ins_fkchar, ins_isapex, ins_isuseseq, pref_schema, pref_tab, suff_idchar, ppl_cod, ppl_des, env_cod, env_des, 
 fk_tab_id, fk_tab_cod, fk_tab_des, fk_tab_ispk, fk_tab_islov, fk_tab_order, fk_pref_col, fk_ins_id, fk_ins_cod, fk_ins_des, fk_ins_pref, fk_ins_ppl_id, fk_ins_env_id, fk_ins_schema, fk_ins_ispreschema, fk_ins_isprefld, fk_ins_ispretab, fk_ins_isstanamfk, fk_ins_prefchar, fk_ins_idchar, fk_ins_pkchar, fk_ins_fkchar, fk_ins_isapex, fk_ins_isuseseq, fk_pref_schema, fk_pref_tab, fk_suff_idchar, fk_ppl_cod, fk_ppl_des, fk_env_cod, fk_env_des)
as
select * from robertocapancioni.app_tabcols_vw union all
select * from robertocapancioni.app_tplcols_vw union all
select * from robertocapancioni.app_relcols_vw; 


--select * from robertocapancioni.app_relations
    
create or replace view robertocapancioni.app_sql_create_vw as
select * from (
select distinct 'CREATE TABLE '||pref_schema||pref_tab||tab_des||' ( ' fld, tab_id, tab_order, 1 scr_order, 1 line_order, ins_id, ins_cod, ppl_cod, env_cod, 1 block_order from robertocapancioni.app_cols_vw v
union all        
select pref_col||col_cod||' '||col_type||' '||decode(upper(col_default),'TRIGGER','',null,'','DEFAULT '||col_default)||' '||decode(upper(col_isnull),'N','NOT NULL','')||', ' fld,
tab_id, tab_order,2 scr_order,col_order line_order, ins_id, ins_cod, ppl_cod, env_cod, 1 block_order
--,listagg(tpc_cod,',') within group (order by tab_id,tpc_order) over(partition by tab_id) tpc_la_pk
from robertocapancioni.app_cols_vw v
union all
select  decode(upper(m_ins_isstanamfk),'Y','CONSTRAINT '||m_pref_tab||m_pref_col||                            
decode(rel_one_tab_cod,null,o_tab_cod||case when abs(to_number(tre_cod))>1 then to_char(n)else '' end||m_ins_prefchar||m_ins_fkchar,rel_one_tab_cod||m_suff_idchar),'')||
' FOREIGN KEY ('||m_pref_col||
decode(rel_one_tab_cod,null,o_tab_cod||case when abs(to_number(tre_cod))>1 then to_char(n)else '' end||m_ins_prefchar||m_ins_idchar,rel_one_tab_cod||m_suff_idchar)||
') REFERENCES '||m_pref_schema||o_pref_tab||o_tab_des||' ('||o_pref_col||o_ins_idchar||'),' fld,
m_tab_id, m_tab_order tab_order, 4 scr_order, o_tab_order line_order, m_ins_id, m_ins_cod, m_ppl_cod, m_env_cod, 1 block_order
from robertocapancioni.app_relations_vw 
union all  
select decode(upper(ins_isstanamfk),'Y','CONSTRAINT '||pref_tab||tab_des||ins_prefchar||ins_pkchar,'')||' PRIMARY KEY ('||pref_col||col_la_pk||')' fld,
tab_id,tab_order, 5 scr_order, col_order line_order, ins_id, ins_cod, ppl_cod, env_cod, 1 block_order 
from (
select
v.*, 
listagg(col_cod,',') within group (order by tab_id,col_order) over(partition by tab_id) col_la_pk
from robertocapancioni.app_cols_vw v
where upper(col_ispk)='Y'
)a0
union all
select distinct '); / ' fld, tab_id, tab_order, 6 sec_order, 1 line_order, ins_id, ins_cod, ppl_cod, env_cod, 1 block_order from robertocapancioni.app_cols_vw v
union all
select distinct decode(upper(ins_isuseseq),'Y',upper('create sequence '||pref_schema||pref_tab||tab_des||'_seq minvalue 1 maxvalue 999999999999999999999999999 increment by 1 start with 1 cache 10 noorder nocycle; / '),'') fld, 
tab_id, tab_order, 7 sec_order, 1 line_order, ins_id, ins_cod, ppl_cod, env_cod, 2 block_order from robertocapancioni.app_cols_vw v
union all
select distinct 
upper(
'create or replace trigger '||pref_schema||pref_tab||tab_des||'_trg '||
'   before insert or update '||
'   on '||pref_schema||pref_tab||tab_des||' '||
'   for each row '||
'declare '||
'   v_username   varchar2 (100); '||
'   v_sysdate    date; '||
'begin '||
'   select   '||decode(upper(ins_isapex),'Y','NVL(v(''APP_USER''),USER)','user')||' into v_username from dual; '||
' '||
'   select   sysdate into v_sysdate from dual; '||
' '||
'   :new.'||pref_col||'updated_by := v_username; '||
'   :new.'||pref_col||'updated := v_sysdate; '||
'   :new.'||pref_col||'row_version_number := nvl (:old.'||pref_col||'row_version_number, 0) + 1; '||
' '||
'   if inserting '||
'   then '||
'      if :new.'||pref_col||'id is null or :new.'||pref_col||'id < 0 '||
'      then '||
'         select   '||decode(upper(ins_isuseseq),'Y',pref_schema||pref_tab||tab_des||'_seq.nextval','TO_NUMBER(SYS_GUID(), ''xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'')')||' into :new.'||pref_col||'id from dual; '||
'      end if; '||
' '||
'      :new.'||pref_col||'created_by := v_username; '||
'      :new.'||pref_col||'created := v_sysdate; '||
'   end if; '||
'end; '||
'/ '
)
fld, 
tab_id, tab_order, 8 sec_order, 1 line_order, ins_id, ins_cod, ppl_cod, env_cod, 3 block_order from robertocapancioni.app_cols_vw v
union all
  select distinct upper('CREATE OR REPLACE VIEW '||pref_schema||pref_tab||tab_des||'_LOV AS  '||
                        'SELECT '||pref_col||'COD || '' - '' || '||pref_col||'DES d,'||pref_col||'ID r FROM '||pref_schema||pref_tab||tab_des||' t, robertocapancioni.mez_data_vw d  WHERE   DAT_TIPODATA = 1 AND DAT_DATASIT BETWEEN '||pref_col||'DATE_START and '||pref_col||'DATE_END order by 1; / ') fld, 
  tab_id, tab_order, 1 scr_order, 1 line_order, ins_id, ins_cod, ppl_cod, env_cod, 4 block_order 
    from robertocapancioni.app_tables_vw v  where tab_islov='Y'
union all
select distinct upper('purge recyclebin; / ')fld, 
0 tab_id, 999 tab_order, 1 scr_order, 1 line_order, ins_id, ins_cod, ppl_cod, env_cod, 5 block_order 
from robertocapancioni.app_instances_vw v
union all
select distinct upper('commit; / ')fld, 
0 tab_id, 999 tab_order, 1 scr_order, 1 line_order, ins_id, ins_cod, ppl_cod, env_cod, 6 block_order 
from robertocapancioni.app_instances_vw v)
order by ins_id,tab_order,scr_order, line_order;

     -- block order > 0 are for create instructions
     -- block order < 0 are for drop  instructions

create or replace view robertocapancioni.app_sql_drop_vw as
select distinct upper('drop view '||pref_schema||pref_tab||tab_des||'_lov; / ')fld, 
tab_id, -tab_order tab_order, 0 scr_order, 1 line_order, ins_id, ins_cod, ppl_cod, env_cod, -6 block_order 
from robertocapancioni.app_cols_vw v where tab_islov='Y'
union all
select distinct upper('drop trigger '||pref_schema||pref_tab||tab_des||'_trg; / ')fld, 
tab_id, -tab_order tab_order, 0 scr_order, 1 line_order, ins_id, ins_cod, ppl_cod, env_cod, -5 block_order 
from robertocapancioni.app_cols_vw v
union all
select distinct upper('drop table '||pref_schema||pref_tab||tab_des||' cascade constraints; / ')fld, 
tab_id, -tab_order tab_order, 0 scr_order, 1 line_order, ins_id, ins_cod, ppl_cod, env_cod, -4 block_order 
from robertocapancioni.app_cols_vw v
union all
select distinct upper(decode(upper(ins_isuseseq),'Y','drop sequence '||pref_schema||pref_tab||tab_des||'_seq; / ',''))fld, 
tab_id, -tab_order tab_order, 0 scr_order, 1 line_order, ins_id, ins_cod, ppl_cod, env_cod, -3 block_order 
from robertocapancioni.app_cols_vw v
union all
select distinct upper('purge recyclebin; / ')fld, 
0 tab_id, 0 tab_order, 0 scr_order, 1 line_order, ins_id, ins_cod, ppl_cod, env_cod, -2 block_order 
from robertocapancioni.app_instances_vw v
union all
select distinct upper('commit; / ')fld, 
0 tab_id, 0 tab_order, 0 scr_order, 1 line_order, ins_id, ins_cod, ppl_cod, env_cod, -1 block_order 
from robertocapancioni.app_instances_vw v
order by ins_id,tab_order,scr_order, line_order;

create or replace view robertocapancioni.app_sql_drop_create_vw as
select * from(
select * from robertocapancioni.app_sql_drop_vw
union all
select * from robertocapancioni.app_sql_create_vw
)
--order by ins_id, tab_order,scr_order, line_order
order by ins_id, ins_cod, ppl_cod, env_cod, tab_order,block_order,scr_order, line_order;

create or replace view robertocapancioni.app_sql_drop_create_block_vw as
select ins_id, ins_cod, ppl_cod, env_cod,tab_id,tab_order,block_order,
to_clob(listagg(fld) within group (order by ins_id, ins_cod, ppl_cod, env_cod, tab_order,block_order,scr_order, line_order))cod 
from robertocapancioni.app_sql_drop_create_vw
group by ins_id,ins_cod, ppl_cod, env_cod,tab_id,tab_order,block_order
order by ins_id,tab_order, block_order;

/*
select * from robertocapancioni.app_sql_drop_create_vw where ins_cod='APP-TST'

select * from robertocapancioni.app_sql_drop_create_block_vw where ins_cod='APP-TST'


select * from robertocapancioni.app_relations_vw where m_ins_cod = 'AP1-DEV' and m_tab_cod='REL'

select * from robertocapancioni.app_tables_vw where ins_cod='AP1-DEV'

select * from robertocapancioni.app_cols_vw 
 where 1=1
   --and col_isfk='y'
   --and fk_tab_cod='tab'
   and tab_cod='TAB'
   and ins_cod='APP-TST'
   
*/
/

commit;
/
