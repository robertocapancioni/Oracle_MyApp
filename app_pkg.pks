create or replace package ced_test.app_pkg as
   -- procedure print_crosstable (p_ppl_cod in varchar2,p_env_cod in varchar2);
    procedure instances_create (p_ins_cod in varchar2,p_ins_des in varchar2,p_ins_pref in varchar2, p_ins_schema in varchar2, p_ppl_cod in varchar2,p_env_cod in varchar2,p_ins_isapex in varchar2 default 'N');
    procedure table_create (p_tab_cod in varchar2,p_tab_des in varchar2,p_tab_order in number,p_ppl_cod in varchar2,p_env_cod in varchar2,p_tab_islov in varchar2 default 'N',p_tab_ispk in varchar2 default 'Y');
    procedure tplcols_create (p_tpc_cod in varchar2,p_tpc_des in varchar2,p_tpc_order in number,p_tpl_cod in varchar2,                                            p_tpc_type in varchar2 default 'VARCHAR2(100)',p_tpc_ispk in varchar2 default 'N',p_tpc_isnull in varchar2 default 'Y',p_tpc_default in varchar2 default null);
    procedure tabcols_create (p_tcl_cod in varchar2,p_tcl_des in varchar2,p_tcl_order in number,p_tab_cod in varchar2,p_ppl_cod in varchar2,p_env_cod in varchar2,p_tcl_type in varchar2 default 'VARCHAR2(100)',p_tcl_ispk in varchar2 default 'N',p_tcl_isnull in varchar2 default 'Y',p_tcl_default in varchar2 default null,p_tcl_isfk in varchar2 default 'N',p_tcl_fk_tab_cod in varchar2 default null);
    procedure tabcols_delete (p_tcl_cod in varchar2,p_tab_cod in varchar2,p_ppl_cod in varchar2,p_env_cod in varchar2);
    procedure tabtpl_delete (p_tpl_cod in varchar2,p_tab_cod in varchar2,p_ppl_cod in varchar2,p_env_cod in varchar2);
    procedure relations_create (p_m_tab_cod in varchar2,p_o_tab_cod in varchar2,p_tre_cod in varchar2,p_ppl_cod in varchar2,p_env_cod in varchar2,p_rel_one_tab_cod in varchar2 default null);
    procedure sql_create(p_ppl_cod in varchar2,p_env_cod in varchar2);
    procedure sql_drop(p_ppl_cod in varchar2,p_env_cod in varchar2);
end app_pkg;
/
