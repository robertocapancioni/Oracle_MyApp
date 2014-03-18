 
delete from  apex_040200.wwv_flow_lists_of_values$ where flow_id=112;
  
insert into apex_040200.wwv_flow_lists_of_values$ (flow_id,security_group_id,lov_name,lov_query)
      (  select id flow_id, 
                security_group_id ,
                upper(tab_des||'_LOV') lov_name, 
                upper('select d,r from '||pref_tab||tab_des||'_LOV ') lov_query 
           from apex_040200.wwv_flows f,
                ced_test.app_tables_vw v  
          where tab_islov='Y' 
            and id=112
       );
       
insert into apex_040200.wwv_flow_lists_of_values$ (flow_id,security_group_id,lov_name,lov_query)
      (  select id flow_id, 
                security_group_id ,
                upper('SINO_LOV') lov_name, 
                upper('select ''NO''d,''N'' r from DUAL union all select ''SI''d,''S'' r from DUAL order by 1') lov_query 
           from apex_040200.wwv_flows f
          where id=112
       )
 
update  apex_040200.wwv_flow_step_items set
item_default_type = 'STATIC_TEXT_WITH_SUBSTITUTIONS',
display_as = 'NATIVE_SELECT_LIST',
named_lov =   ( select upper(o_tab_des||'_LOV')                                named_lov from ced_test.app_relations_vw r where m_ins_cod = 'MEZ-TST' and m_tab_cod='AUT' and name = 'P'||flow_step_id||'_'||upper(m_pref_col||o_real_pref_col||m_ins_idchar)),
lov =         ( select upper('select * from '||m_pref_tab||upper(o_tab_des)||'_LOV') lov from ced_test.app_relations_vw r where m_ins_cod = 'MEZ-TST' and m_tab_cod='AUT' and name = 'P'||flow_step_id||'_'||upper(m_pref_col||o_real_pref_col||m_ins_idchar)),
lov_display_extra = 'NO',
lov_display_null = 'YES',
protection_level = 'N',
escape_on_http_output = 'Y',
show_quick_picks = 'N',
attribute_01 = 'NONE',
attribute_02 = 'N'
 where 
 flow_id = 112
 --and flow_step_id = 24
 and name in ( select 'P'||flow_step_id||'_'||upper(m_pref_col||o_pref_col||m_ins_idchar)         
                 from ced_test.app_relations_vw r 
                where m_ins_cod = 'MEZ-TST' 
                  and m_tab_cod in ('ASS','AUT')
             )       
 
 
    update apex_040200.wwv_flow_step_items i 
      set /*
          is_required='y',
          item_field_template = (
                select t.id 
                      from apex_040200.wwv_flow_field_templates t, 
                           apex_040200.wwv_flows f,
                           apex_040200.wwv_flow_themes h
                     where t.security_group_id = f.security_group_id
                       and t.flow_id = f.id
                       and t.flow_id = h.flow_id
                       and t.theme_id = h.theme_id
                       and f.owner ='ced_test'
                       and f.name='mez gestione automezzi'
                       and t.template_name like 'required (horizontal - right aligned)%'
                       --and t.template_name like 'optional (horizontal - right aligned)'
                       and t.theme_id=25
            ),
            */
            item_default=decode(substr(upper(i.name),-5,5),'START','01/01/1900','E_END','31/12/2099','')
   where i.flow_id=112
   and (i.name like '%DATE_START' or i.name like '%DATE_END')
   --and i.is_required='y'
   
   
 select * from apex_040200.wwv_flow_step_items 
  where flow_id = 112
    --and flow_step_id = 22
    and name  in ( select 'P'||flow_step_id||'_'||upper(m_pref_col||o_real_pref_col||m_ins_idchar)         
  --
  --  select upper(m_pref_col||o_pref_col||m_ins_idchar)name ,
  --      upper(o_tab_des||'_lov') named_lov, 
  --      upper('select * from '||m_pref_tab||upper(o_tab_des)||'_lov') lov
   from ced_test.app_relations_vw r 
  where m_ins_cod = 'MEZ-TST' 
    and m_tab_cod='ASS'
   --
    )      
    
    
update apex_040200.wwv_flow_step_items i 
      set 
          item_field_template = (
                select t.id 
                      from apex_040200.wwv_flow_field_templates t, 
                           apex_040200.wwv_flows f,
                           apex_040200.wwv_flow_themes h
                     where t.security_group_id = f.security_group_id
                       and t.flow_id = f.id
                       and t.flow_id = h.flow_id
                       and t.theme_id = h.theme_id
                       and f.owner ='CED_TEST'
                       and f.name='MEZ GESTIONE AUTOMEZZI'
                       and t.template_name like 'Optional (Label Above)'
                       --and t.template_name like 'required (horizontal - right aligned)'
                       and t.theme_id=25
            )
   where i.flow_id=112
   --and (i.name like '%date_start' or i.name like '%date_end')
   and item_field_template = (select t.id 
      from apex_040200.wwv_flow_field_templates t, 
           apex_040200.wwv_flows f,
           apex_040200.wwv_flow_themes h
     where t.security_group_id = f.security_group_id
       and t.flow_id = f.id
       and t.flow_id = h.flow_id
       and t.theme_id = h.theme_id
       and f.owner ='CED_TEST'
       and f.name='MEZ GESTIONE AUTOMEZZI'
       and t.template_name like 'Optional (Horizontal - Right Aligned)%'
       --and t.template_name like 'optional (horizontal - right aligned)'
       and t.theme_id=25)
