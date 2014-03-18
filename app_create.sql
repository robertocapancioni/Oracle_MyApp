/* formatted on 20/02/2014 13.41.39 (qp5 v5.126.903.23003) */
create table ced_test.app_applications (
   ppl_id                   number not null,
   ppl_cod                  varchar2 (32) default '-' not null,
   ppl_des                  varchar2 (100) default '-' not null,
   ppl_created              date not null,
   ppl_created_by           varchar2 (100) not null,
   ppl_updated              date not null,
   ppl_updated_by           varchar2 (100) not null,
   ppl_row_version_number   number not null,
   constraint app_applications_pk primary key (ppl_id)
);

/

create sequence ced_test.app_applications_seq
   minvalue 1
   maxvalue 999999999999999999999999999
   increment by 1
   start with 1
   cache 10
   noorder
   nocycle;

/

create or replace trigger ced_test.app_applications_trg
   before insert or update
   on ced_test.app_applications
   for each row
declare
   v_username   varchar2 (100);
   v_sysdate    date;
begin
   select   nvl (v ('APP_USER'), user) into v_username from dual;

   select   sysdate into v_sysdate from dual;

   :new.ppl_updated_by := v_username;
   :new.ppl_updated := v_sysdate;
   :new.ppl_row_version_number := nvl (:old.ppl_row_version_number, 0) + 1;

   if inserting
   then
      if :new.ppl_id is null or :new.ppl_id < 0
      then
         select   ced_test.app_applications_seq.nextval
           into   :new.ppl_id
           from   dual;
      end if;

      :new.ppl_created_by := v_username;
      :new.ppl_created := v_sysdate;
   end if;
end;
/

create or replace view ced_test.app_applications_lov
as
     select   ppl_cod || ' - ' || ppl_des d, ppl_id r
       from   ced_test.app_applications t
   order by   1;

/

create table ced_test.app_environment (
   env_id                   number not null,
   env_cod                  varchar2 (32) default '-' not null,
   env_des                  varchar2 (100) default '-' not null,
   env_created              date not null,
   env_created_by           varchar2 (100) not null,
   env_updated              date not null,
   env_updated_by           varchar2 (100) not null,
   env_row_version_number   number not null,
   constraint app_environment_pk primary key (env_id)
);

/

create sequence ced_test.app_environment_seq
   minvalue 1
   maxvalue 999999999999999999999999999
   increment by 1
   start with 1
   cache 10
   noorder
   nocycle;

/

create or replace trigger ced_test.app_environment_trg
   before insert or update
   on ced_test.app_environment
   for each row
declare
   v_username   varchar2 (100);
   v_sysdate    date;
begin
   select   nvl (v ('APP_USER'), user) into v_username from dual;

   select   sysdate into v_sysdate from dual;

   :new.env_updated_by := v_username;
   :new.env_updated := v_sysdate;
   :new.env_row_version_number := nvl (:old.env_row_version_number, 0) + 1;

   if inserting
   then
      if :new.env_id is null or :new.env_id < 0
      then
         select   ced_test.app_environment_seq.nextval
           into   :new.env_id
           from   dual;
      end if;

      :new.env_created_by := v_username;
      :new.env_created := v_sysdate;
   end if;
end;
/

create or replace view ced_test.app_environment_lov
as
     select   env_cod || ' - ' || env_des d, env_id r
       from   ced_test.app_environment t
   order by   1;

/

create table ced_test.app_instances (
   ins_id                   number not null,
   ins_cod                  varchar2 (32) default '-' not null,
   ins_des                  varchar2 (100) default '-' not null,
   ins_pref                 varchar2 (32) default '-' not null,
   ins_schema               varchar2 (32) default '-' not null,
   ins_isprefld             varchar2 (1) default 'Y' not null,
   ins_ispreschema          varchar2 (1) default 'Y' not null,
   ins_ispretab             varchar2 (1) default 'Y' not null,
   ins_isstanamfk           varchar2 (1) default 'Y' not null,
   ins_prefchar             varchar2 (1) default '_' not null,
   ins_idchar               varchar2 (10) default 'ID' not null,
   ins_pkchar               varchar2 (10) default 'PK' not null,
   ins_fkchar               varchar2 (10) default 'FK' not null,
   ins_isapex               varchar2 (1) default 'N' not null,
   ins_isuseseq             varchar2 (1) default 'Y' not null,
   ins_ppl_id               number not null,
   ins_env_id               number not null,
   ins_created              date not null,
   ins_created_by           varchar2 (100) not null,
   ins_updated              date not null,
   ins_updated_by           varchar2 (100) not null,
   ins_row_version_number   number not null,
   constraint app_ins_ppl_fk foreign key
      (ins_ppl_id)
       references ced_test.app_applications (ppl_id),
   constraint app_ins_env_fk foreign key
      (ins_env_id)
       references ced_test.app_environment (env_id),
   constraint app_instances_pk primary key (ins_id)
);

/

create sequence ced_test.app_instances_seq
   minvalue 1
   maxvalue 999999999999999999999999999
   increment by 1
   start with 1
   cache 10
   noorder
   nocycle;

/

create or replace trigger ced_test.app_instances_trg
   before insert or update
   on ced_test.app_instances
   for each row
declare
   v_username   varchar2 (100);
   v_sysdate    date;
begin
   select   nvl (v ('APP_USER'), user) into v_username from dual;

   select   sysdate into v_sysdate from dual;

   :new.ins_updated_by := v_username;
   :new.ins_updated := v_sysdate;
   :new.ins_row_version_number := nvl (:old.ins_row_version_number, 0) + 1;

   if inserting
   then
      if :new.ins_id is null or :new.ins_id < 0
      then
         select   ced_test.app_instances_seq.nextval into :new.ins_id from dual;
      end if;

      :new.ins_created_by := v_username;
      :new.ins_created := v_sysdate;
   end if;
end;
/

create or replace view ced_test.app_instances_lov
as
     select   ins_cod || ' - ' || ins_des d, ins_id r
       from   ced_test.app_instances t
   order by   1;

/

create table ced_test.app_trelations (
   tre_id                   number not null,
   tre_cod                  varchar2 (32) default '-' not null,
   tre_des                  varchar2 (100) default '-' not null,
   tre_created              date not null,
   tre_created_by           varchar2 (100) not null,
   tre_updated              date not null,
   tre_updated_by           varchar2 (100) not null,
   tre_row_version_number   number not null,
   constraint app_trelations_pk primary key (tre_id)
);

/

create sequence ced_test.app_trelations_seq
   minvalue 1
   maxvalue 999999999999999999999999999
   increment by 1
   start with 1
   cache 10
   noorder
   nocycle;

/

create or replace trigger ced_test.app_trelations_trg
   before insert or update
   on ced_test.app_trelations
   for each row
declare
   v_username   varchar2 (100);
   v_sysdate    date;
begin
   select   nvl (v ('APP_USER'), user) into v_username from dual;

   select   sysdate into v_sysdate from dual;

   :new.tre_updated_by := v_username;
   :new.tre_updated := v_sysdate;
   :new.tre_row_version_number := nvl (:old.tre_row_version_number, 0) + 1;

   if inserting
   then
      if :new.tre_id is null or :new.tre_id < 0
      then
         select   ced_test.app_trelations_seq.nextval
           into   :new.tre_id
           from   dual;
      end if;

      :new.tre_created_by := v_username;
      :new.tre_created := v_sysdate;
   end if;
end;
/

create or replace view ced_test.app_trelations_lov
as
     select   tre_cod || ' - ' || tre_des d, tre_id r
       from   ced_test.app_trelations t
   order by   1;

/

create table ced_test.app_tables (
   tab_id                   number not null,
   tab_cod                  varchar2 (32) default '-' not null,
   tab_des                  varchar2 (100) default '-' not null,
   tab_ispk                 varchar2 (1) default 'Y' not null,
   tab_islov                varchar2 (1) default 'N' not null,
   tab_order                number default 0 not null,
   tab_ins_id               number not null,
   tab_created              date not null,
   tab_created_by           varchar2 (100) not null,
   tab_updated              date not null,
   tab_updated_by           varchar2 (100) not null,
   tab_row_version_number   number not null,
   constraint app_tab_ins_fk foreign key
      (tab_ins_id)
       references ced_test.app_instances (ins_id),
   constraint app_tables_pk primary key (tab_id)
);

/

create sequence ced_test.app_tables_seq
   minvalue 1
   maxvalue 999999999999999999999999999
   increment by 1
   start with 1
   cache 10
   noorder
   nocycle;

/

create or replace trigger ced_test.app_tables_trg
   before insert or update
   on ced_test.app_tables
   for each row
declare
   v_username   varchar2 (100);
   v_sysdate    date;
begin
   select   nvl (v ('APP_USER'), user) into v_username from dual;

   select   sysdate into v_sysdate from dual;

   :new.tab_updated_by := v_username;
   :new.tab_updated := v_sysdate;
   :new.tab_row_version_number := nvl (:old.tab_row_version_number, 0) + 1;

   if inserting
   then
      if :new.tab_id is null or :new.tab_id < 0
      then
         select   ced_test.app_tables_seq.nextval into :new.tab_id from dual;
      end if;

      :new.tab_created_by := v_username;
      :new.tab_created := v_sysdate;
   end if;
end;
/

create or replace view ced_test.app_tables_lov
as
     select   tab_cod || ' - ' || tab_des d, tab_id r
       from   ced_test.app_tables t
   order by   1;

/

create table ced_test.app_templates (
   tpl_id                   number not null,
   tpl_cod                  varchar2 (32) default '-' not null,
   tpl_des                  varchar2 (100) default '-' not null,
   tpl_order                number default 0 not null,
   tpl_created              date not null,
   tpl_created_by           varchar2 (100) not null,
   tpl_updated              date not null,
   tpl_updated_by           varchar2 (100) not null,
   tpl_row_version_number   number not null,
   constraint app_templates_pk primary key (tpl_id)
);

/

create sequence ced_test.app_templates_seq
   minvalue 1
   maxvalue 999999999999999999999999999
   increment by 1
   start with 1
   cache 10
   noorder
   nocycle;

/

create or replace trigger ced_test.app_templates_trg
   before insert or update
   on ced_test.app_templates
   for each row
declare
   v_username   varchar2 (100);
   v_sysdate    date;
begin
   select   nvl (v ('APP_USER'), user) into v_username from dual;

   select   sysdate into v_sysdate from dual;

   :new.tpl_updated_by := v_username;
   :new.tpl_updated := v_sysdate;
   :new.tpl_row_version_number := nvl (:old.tpl_row_version_number, 0) + 1;

   if inserting
   then
      if :new.tpl_id is null or :new.tpl_id < 0
      then
         select   ced_test.app_templates_seq.nextval into :new.tpl_id from dual;
      end if;

      :new.tpl_created_by := v_username;
      :new.tpl_created := v_sysdate;
   end if;
end;
/

create or replace view ced_test.app_templates_lov
as
     select   tpl_cod || ' - ' || tpl_des d, tpl_id r
       from   ced_test.app_templates t
   order by   1;

/

create table ced_test.app_tplcols (
   tpc_id                   number not null,
   tpc_cod                  varchar2 (32) default '-' not null,
   tpc_des                  varchar2 (100) default '-' not null,
   tpc_order                number default 0 not null,
   tpc_type                 varchar2 (100) default 'VARCHAR2(100)' not null,
   tpc_ispk                 varchar2 (1) default 'N' not null,
   tpc_isfk                 varchar2 (1) default 'N' not null,
   tpc_isnull               varchar2 (1) default 'Y' not null,
   tpc_default              varchar2 (100),
   tpc_fk_tab_id            number,
   tpc_tpl_id               number not null,
   tpc_created              date not null,
   tpc_created_by           varchar2 (100) not null,
   tpc_updated              date not null,
   tpc_updated_by           varchar2 (100) not null,
   tpc_row_version_number   number not null,
   constraint app_tpc_fk_tab_id foreign key
      (tpc_fk_tab_id)
       references ced_test.app_tables (tab_id),
   constraint app_tpc_tpl_fk foreign key
      (tpc_tpl_id)
       references ced_test.app_templates (tpl_id),
   constraint app_tplcols_pk primary key (tpc_id)
);

/

create sequence ced_test.app_tplcols_seq
   minvalue 1
   maxvalue 999999999999999999999999999
   increment by 1
   start with 1
   cache 10
   noorder
   nocycle;

/

create or replace trigger ced_test.app_tplcols_trg
   before insert or update
   on ced_test.app_tplcols
   for each row
declare
   v_username   varchar2 (100);
   v_sysdate    date;
begin
   select   nvl (v ('APP_USER'), user) into v_username from dual;

   select   sysdate into v_sysdate from dual;

   :new.tpc_updated_by := v_username;
   :new.tpc_updated := v_sysdate;
   :new.tpc_row_version_number := nvl (:old.tpc_row_version_number, 0) + 1;

   if inserting
   then
      if :new.tpc_id is null or :new.tpc_id < 0
      then
         select   ced_test.app_tplcols_seq.nextval into :new.tpc_id from dual;
      end if;

      :new.tpc_created_by := v_username;
      :new.tpc_created := v_sysdate;
   end if;
end;
/

create table ced_test.app_tabcols (
   tcl_id                   number not null,
   tcl_cod                  varchar2 (32) default '-' not null,
   tcl_des                  varchar2 (100) default '-' not null,
   tcl_order                number default 0 not null,
   tcl_type                 varchar2 (100) default 'VARCHAR2(100)' not null,
   tcl_ispk                 varchar2 (1) default 'N' not null,
   tcl_isfk                 varchar2 (1) default 'N' not null,
   tcl_isnull               varchar2 (1) default 'Y' not null,
   tcl_default              varchar2 (100),
   tcl_tab_id               number not null,
   tcl_fk_tab_id            number,
   tcl_created              date not null,
   tcl_created_by           varchar2 (100) not null,
   tcl_updated              date not null,
   tcl_updated_by           varchar2 (100) not null,
   tcl_row_version_number   number not null,
   constraint app_tcl_tab_fk foreign key
      (tcl_tab_id)
       references ced_test.app_tables (tab_id),
   constraint app_tcl_fk_tab_id foreign key
      (tcl_fk_tab_id)
       references ced_test.app_tables (tab_id),
   constraint app_tabcols_pk primary key (tcl_id)
);

/

create sequence ced_test.app_tabcols_seq
   minvalue 1
   maxvalue 999999999999999999999999999
   increment by 1
   start with 1
   cache 10
   noorder
   nocycle;

/

create or replace trigger ced_test.app_tabcols_trg
   before insert or update
   on ced_test.app_tabcols
   for each row
declare
   v_username   varchar2 (100);
   v_sysdate    date;
begin
   select   nvl (v ('APP_USER'), user) into v_username from dual;

   select   sysdate into v_sysdate from dual;

   :new.tcl_updated_by := v_username;
   :new.tcl_updated := v_sysdate;
   :new.tcl_row_version_number := nvl (:old.tcl_row_version_number, 0) + 1;

   if inserting
   then
      if :new.tcl_id is null or :new.tcl_id < 0
      then
         select   ced_test.app_tabcols_seq.nextval into :new.tcl_id from dual;
      end if;

      :new.tcl_created_by := v_username;
      :new.tcl_created := v_sysdate;
   end if;
end;
/

create table ced_test.app_tabtpl (
   ttl_id                   number not null,
   ttl_cod                  varchar2 (32) default '-' not null,
   ttl_des                  varchar2 (100) default '-' not null,
   ttl_order                number default 0 not null,
   ttl_tab_id               number not null,
   ttl_tpl_id               number not null,
   ttl_created              date not null,
   ttl_created_by           varchar2 (100) not null,
   ttl_updated              date not null,
   ttl_updated_by           varchar2 (100) not null,
   ttl_row_version_number   number not null,
   constraint app_ttl_tab_fk foreign key
      (ttl_tab_id)
       references ced_test.app_tables (tab_id),
   constraint app_ttl_tpl_fk foreign key
      (ttl_tpl_id)
       references ced_test.app_templates (tpl_id),
   constraint app_tabtpl_pk primary key (ttl_id)
);

/

create sequence ced_test.app_tabtpl_seq
   minvalue 1
   maxvalue 999999999999999999999999999
   increment by 1
   start with 1
   cache 10
   noorder
   nocycle;

/

create or replace trigger ced_test.app_tabtpl_trg
   before insert or update
   on ced_test.app_tabtpl
   for each row
declare
   v_username   varchar2 (100);
   v_sysdate    date;
begin
   select   nvl (v ('APP_USER'), user) into v_username from dual;

   select   sysdate into v_sysdate from dual;

   :new.ttl_updated_by := v_username;
   :new.ttl_updated := v_sysdate;
   :new.ttl_row_version_number := nvl (:old.ttl_row_version_number, 0) + 1;

   if inserting
   then
      if :new.ttl_id is null or :new.ttl_id < 0
      then
         select   ced_test.app_tabtpl_seq.nextval into :new.ttl_id from dual;
      end if;

      :new.ttl_created_by := v_username;
      :new.ttl_created := v_sysdate;
   end if;
end;
/

create table ced_test.app_relations (
   rel_id                   number not null,
   rel_one_tab_cod          varchar2 (32),
   rel_tre_id               number not null,
   rel_many_tab_id          number not null,
   rel_one_tab_id           number not null,
   rel_created              date not null,
   rel_created_by           varchar2 (100) not null,
   rel_updated              date not null,
   rel_updated_by           varchar2 (100) not null,
   rel_row_version_number   number not null,
   constraint app_rel_tre_fk foreign key
      (rel_tre_id)
       references ced_test.app_trelations (tre_id),
   constraint app_rel_many_tab_id foreign key
      (rel_many_tab_id)
       references ced_test.app_tables (tab_id),
   constraint app_rel_one_tab_id foreign key
      (rel_one_tab_id)
       references ced_test.app_tables (tab_id),
   constraint app_relations_pk primary key (rel_id)
);

/

create sequence ced_test.app_relations_seq
   minvalue 1
   maxvalue 999999999999999999999999999
   increment by 1
   start with 1
   cache 10
   noorder
   nocycle;

/

create or replace trigger ced_test.app_relations_trg
   before insert or update
   on ced_test.app_relations
   for each row
declare
   v_username   varchar2 (100);
   v_sysdate    date;
begin
   select   nvl (v ('APP_USER'), user) into v_username from dual;

   select   sysdate into v_sysdate from dual;

   :new.rel_updated_by := v_username;
   :new.rel_updated := v_sysdate;
   :new.rel_row_version_number := nvl (:old.rel_row_version_number, 0) + 1;

   if inserting
   then
      if :new.rel_id is null or :new.rel_id < 0
      then
         select   ced_test.app_relations_seq.nextval into :new.rel_id from dual;
      end if;

      :new.rel_created_by := v_username;
      :new.rel_created := v_sysdate;
   end if;
end;
/

purge recyclebin;
/
commit;
/