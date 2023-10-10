prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_210200 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2016.08.24'
,p_release=>'5.1.3.00.05'
,p_default_workspace_id=>3968791089177855
,p_default_application_id=>100
,p_default_id_offset=>0
,p_default_owner=>'PLUGINS'
);
end;
/
 
prompt APPLICATION 100 - Plugin
--
-- Application Export:
--   Application:     100
--   Name:            Plugin
--   Date and Time:   19:44 Tuesday October 10, 2023
--   Exported By:     CHRISTOPHERBERG
--   Flashback:       0
--   Export Type:     Component Export
--   Manifest
--     PLUGIN: 7869587760561505
--   Manifest End
--   Version:         21.2.10
--   Instance ID:     2300121023096285
--

begin
  -- replace components
  wwv_flow_api.g_mode := 'REPLACE';
end;
/
prompt --application/shared_components/plugins/dynamic_action/cb_dev_shuttle_sorting_filter
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(7869587760561505)
,p_plugin_type=>'DYNAMIC ACTION'
,p_name=>'CB.DEV.SHUTTLE.SORTING.FILTER'
,p_display_name=>'APEX Shuttle Sorting/Filter'
,p_category=>'COMPONENT'
,p_supported_ui_types=>'DESKTOP'
,p_javascript_file_urls=>'#PLUGIN_FILES#shuttle.pkgd.min.js'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'function F_RENDER(',
'    P_DYNAMIC_ACTION in APEX_PLUGIN.T_DYNAMIC_ACTION,',
'    P_PLUGIN         in APEX_PLUGIN.T_PLUGIN',
') return APEX_PLUGIN.T_DYNAMIC_ACTION_RENDER_RESULT is',
'    L_RESULT APEX_PLUGIN.T_DYNAMIC_ACTION_RENDER_RESULT;',
'begin',
'    L_RESULT.JAVASCRIPT_FUNCTION := ''function() { ',
'        shuttleSorting(apex, $).initialize({'' ||',
'        APEX_JAVASCRIPT.ADD_ATTRIBUTE(''affectedElements'', APEX_PLUGIN_UTIL.PAGE_ITEM_NAMES_TO_JQUERY(P_DYNAMIC_ACTION.ATTRIBUTE_01), true, true) ||',
'        APEX_JAVASCRIPT.ADD_ATTRIBUTE(''mode'', P_DYNAMIC_ACTION.ATTRIBUTE_02, true, true) ||',
'        APEX_JAVASCRIPT.ADD_ATTRIBUTE(''sortOrder'', P_DYNAMIC_ACTION.ATTRIBUTE_03, true, true) ||',
'        APEX_JAVASCRIPT.ADD_ATTRIBUTE(''filterPlaceholder'', P_DYNAMIC_ACTION.ATTRIBUTE_04, true, true) ||',
'        APEX_JAVASCRIPT.ADD_ATTRIBUTE(''resetBtnTitle'', P_DYNAMIC_ACTION.ATTRIBUTE_05, true, false) ||',
'    ''});}'';',
'',
'    return L_RESULT;',
'end;'))
,p_api_version=>2
,p_render_function=>'F_RENDER'
,p_standard_attributes=>'ONLOAD'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'This plugin is used to keep shuttles sorted and can add a filter to them as well.',
'',
'Create a dynamic action that reacts on change of your shuttle(s) to always keep the order identical. Turn on "Fire on Initialization" to also have it sorted on page load.'))
,p_version_identifier=>'23.10.10'
,p_about_url=>'https://github.com/choque88/APEX-Shuttle-Sorting-Filter'
,p_files_version=>71
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(7871629347578245)
,p_plugin_id=>wwv_flow_api.id(7869587760561505)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Affected Elements'
,p_attribute_type=>'PAGE ITEMS'
,p_is_required=>true
,p_is_translatable=>false
,p_examples=>wwv_flow_string.join(wwv_flow_t_varchar2(
'P2_MY_SHUTTLE',
'<br/>',
'P2_MY_SHUTTLE,P2_MY_OTHER_SHUTTLE'))
,p_help_text=>'A list of the shuttle page items that should be sorted and/or have a filter added to them.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(19583907495886795)
,p_plugin_id=>wwv_flow_api.id(7869587760561505)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Mode'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'0'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>'Operation mode of the plugin. Sort the shuttle(s) and add a filter to the shuttle(s), only sort the shuttle(s) or only add a filter to the shuttle(s).'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(19584667432889696)
,p_plugin_attribute_id=>wwv_flow_api.id(19583907495886795)
,p_display_sequence=>10
,p_display_value=>'Sorting and Filter'
,p_return_value=>'0'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(19585004363890468)
,p_plugin_attribute_id=>wwv_flow_api.id(19583907495886795)
,p_display_sequence=>20
,p_display_value=>'Only Sorting'
,p_return_value=>'1'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(19585415728890930)
,p_plugin_attribute_id=>wwv_flow_api.id(19583907495886795)
,p_display_sequence=>30
,p_display_value=>'Only Filter'
,p_return_value=>'2'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(7872130674588215)
,p_plugin_id=>wwv_flow_api.id(7869587760561505)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'Sorting Order'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'0'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(19583907495886795)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'IN_LIST'
,p_depending_on_expression=>'0,1'
,p_lov_type=>'STATIC'
,p_examples=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<h3>Ascending</h3>',
'11, 23, 34, 74',
'<br/>',
'C, F, K, Q',
'<br/>',
'<br/>',
'<h3>Descending</h3>',
'74, 34, 23, 11',
'<br/>',
'Q, K, F, C'))
,p_help_text=>'Sorting order of the shuttles. Ascending means smallest to largest, 0 to 9, and/or A to Z and Descending means largest to smallest, 9 to 0, and/or Z to A.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7872418185589452)
,p_plugin_attribute_id=>wwv_flow_api.id(7872130674588215)
,p_display_sequence=>10
,p_display_value=>'Ascending'
,p_return_value=>'0'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(7872872723590038)
,p_plugin_attribute_id=>wwv_flow_api.id(7872130674588215)
,p_display_sequence=>20
,p_display_value=>'Descending'
,p_return_value=>'1'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(19608595773664660)
,p_plugin_id=>wwv_flow_api.id(7869587760561505)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_prompt=>'Filter Placeholder'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_default_value=>'Filter'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(19583907495886795)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'IN_LIST'
,p_depending_on_expression=>'0,2'
,p_help_text=>'Placeholder text that''s displayed in the filter box before entering anything.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(19609260250669155)
,p_plugin_id=>wwv_flow_api.id(7869587760561505)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>50
,p_prompt=>'Filter Reset Button Title'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_default_value=>'Reset filter'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(19583907495886795)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'IN_LIST'
,p_depending_on_expression=>'0,2'
,p_help_text=>'Title of the button used to reset the filter input field.'
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '636F6E73742073687574746C65536F7274696E673D66756E6374696F6E28692C64297B2275736520737472696374223B636F6E7374206E3D7B6E616D653A2243422E4445562E53485554544C452E534F5254494E472E46494C544552222C736372697074';
wwv_flow_api.g_varchar2_table(2) := '56657273696F6E3A2232332E31302E3130227D3B72657475726E7B696E697469616C697A653A66756E6374696F6E2874297B692E64656275672E696E666F287B6663743A6E2E6E616D652B22202D20696E697469616C697A65222C617267756D656E7473';
wwv_flow_api.g_varchar2_table(3) := '3A7B70436F6E6669673A747D2C6665617475726544657461696C733A6E7D293B6C657420753D642E657874656E64287B7D2C74293B752E64656661756C74726573657442746E5469746C653D2252657365742066696C746572222C692E64656275672E69';
wwv_flow_api.g_varchar2_table(4) := '6E666F2822436865636B696E67207468652070617373656420656C656D656E7428732922293B743D752E6166666563746564456C656D656E74732E7265706C616365282F232F672C2222293B66756E6374696F6E20652874297B76617220653D64282223';
wwv_flow_api.g_varchar2_table(5) := '222B74292C6E3D652E6368696C6472656E28226F7074696F6E22293B303C6E2E6C656E6774683F28692E64656275672E696E666F28742B2220636F6E7461696E73206F7074696F6E732E20536F7274696E672E22292C6E2E64657461636828292C6E2E73';
wwv_flow_api.g_varchar2_table(6) := '6F72742866756E6374696F6E28742C65297B72657475726E28743D742E66697273744368696C642E6E6F646556616C7565293D3D28653D652E66697273744368696C642E6E6F646556616C7565293F303A303D3D752E736F72744F726465723F653C743F';
wwv_flow_api.g_varchar2_table(7) := '313A2D313A743C653F313A2D317D292C652E617070656E64286E29293A692E64656275672E696E666F28742B2220697320656D7074792E204E6F20736F7274696E67206E65656465642E22297D28743D742E73706C697428222C2229292E666F72456163';
wwv_flow_api.g_varchar2_table(8) := '682866756E6374696F6E286C297B696628303C64286023247B6C7D5F4C45465460292E6C656E6774682626303C64286023247B6C7D5F524947485460292E6C656E677468297B696628692E64656275672E696E666F286C2B222069732061207368757474';
wwv_flow_api.g_varchar2_table(9) := '6C652E22292C303D3D752E6D6F64657C7C313D3D752E6D6F6465297472797B65286C2B225F4C45465422292C65286C2B225F524947485422297D63617463682874297B692E64656275672E6572726F7228224572726F72207768696C6520747279696E67';
wwv_flow_api.g_varchar2_table(10) := '20746F20736F7274207468652073687574746C6520222B6C292C692E64656275672E6572726F722874297D696628303D3D752E6D6F6465262621646F63756D656E742E676574456C656D656E7442794964286C2B225F46494C54455222297C7C323D3D75';
wwv_flow_api.g_varchar2_table(11) := '2E6D6F6465262621646F63756D656E742E676574456C656D656E7442794964286C2B225F46494C5445522229297472797B7B76617220733D6C3B6C657420743D64282223222B73292C653D742E617474722822696422292B225F46494C544552222C6E3D';
wwv_flow_api.g_varchar2_table(12) := '742E617474722822696422292B225F5245534554222C6F3D742E66696E64282273656C65637422292C723D6F2E6368696C6472656E28226F7074696F6E22292E6D61702866756E6374696F6E28297B72657475726E7B746578743A642874686973292E74';
wwv_flow_api.g_varchar2_table(13) := '65787428292C76616C75653A642874686973292E76616C28292C6F7074696F6E3A746869737D7D292C693D6428223C696E7075742F3E222C7B747970653A2274657874222C76616C75653A22222C636C6173733A22746578745F6669656C642061706578';
wwv_flow_api.g_varchar2_table(14) := '2D6974656D2D74657874222C73697A653A22323535222C6175746F636F6D706C6574653A226F6666222C69643A652C706C616365686F6C6465723A752E66696C746572506C616365686F6C6465722C6373733A7B77696474683A2231303025227D7D292E';
wwv_flow_api.g_varchar2_table(15) := '6B657975702866756E6374696F6E28297B6C6574206E3D6E65772052656745787028222E2A222B642874686973292E76616C28292B222E2A222C226922292C693D6F2E65712831292E6368696C6472656E28226F7074696F6E22292E6D61702866756E63';
wwv_flow_api.g_varchar2_table(16) := '74696F6E28297B72657475726E20642874686973292E76616C28297D293B6F2E65712830292E656D70747928292C642E6561636828722C66756E6374696F6E28742C65297B652E746578742E6D61746368286E292626642E696E417272617928652E7661';
wwv_flow_api.g_varchar2_table(17) := '6C75652C69293C3026266F2E65712830292E617070656E6428652E6F7074696F6E297D297D292C613D6428223C627574746F6E2F3E222C7B747970653A22627574746F6E222C7469746C653A752E726573657442746E5469746C652C22617269612D6C61';
wwv_flow_api.g_varchar2_table(18) := '62656C223A752E726573657442746E5469746C657C7C752E64656661756C74726573657442746E5469746C652C636C6173733A22612D427574746F6E20612D427574746F6E2D2D6E6F4C6162656C20612D427574746F6E2D2D7769746849636F6E20612D';
wwv_flow_api.g_varchar2_table(19) := '427574746F6E2D2D736D616C6C20612D427574746F6E2D2D73687574746C65222C6373733A7B70616464696E673A22347078222C6865696768743A2231303025227D7D292E617070656E64286428223C7370616E2F3E222C7B22617269612D6869646465';
wwv_flow_api.g_varchar2_table(20) := '6E223A2274727565222C636C6173733A22612D49636F6E2066612066612D74696D6573227D29292E636C69636B2866756E6374696F6E28297B692E76616C282222292E6B6579757028297D293B642874292E70726570656E64286428223C6469762F3E22';
wwv_flow_api.g_varchar2_table(21) := '2C7B636C6173733A22742D466F726D2D6974656D57726170706572227D292E617070656E642869292E617070656E64286428223C7370616E2F3E222C7B636C6173733A22742D466F726D2D6974656D5465787420742D466F726D2D6974656D546578742D';
wwv_flow_api.g_varchar2_table(22) := '2D706F7374227D292E617070656E6428612929292E6F6E282261706578616674657272656672657368222C66756E6374696F6E28297B692E76616C282222292C723D67657453687574746C6556616C756573286F297D292C64282223222B6E292E636C69';
wwv_flow_api.g_varchar2_table(23) := '636B2866756E6374696F6E28297B692E76616C282222297D293B72657475726E7D7D63617463682874297B692E64656275672E6572726F7228224572726F72207768696C6520747279696E6720746F20616464207468652073687574746C652066696C74';
wwv_flow_api.g_varchar2_table(24) := '657220746F20222B6C292C692E64656275672E6572726F722874297D7D7D297D7D7D3B';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(19614377554726022)
,p_plugin_id=>wwv_flow_api.id(7869587760561505)
,p_file_name=>'shuttle.pkgd.min.js'
,p_mime_type=>'text/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
prompt --application/end_environment
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false));
commit;
end;
/
set verify on feedback on define on
prompt  ...done
