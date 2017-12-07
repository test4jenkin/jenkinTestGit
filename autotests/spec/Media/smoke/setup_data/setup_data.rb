#--------------------------------------------------------------------#
#	TID : TID005984 Media Setup Prerequistic
# 	Pre-Requisite :Install latest versions of following packages on Org in same order
#				  # ERP , FFR, C2G, FFCM, FFM and deploy basedata
#  	Product Area: Media - Overview
#--------------------------------------------------------------------#
describe "Smoke Test - Media - Overview", :type => :request do
include_context "login"
	
	less_wait = 2	
	_user_layout_fields_to_add =[$user_dsm_user_id_label]
	_consolidate_invoice_field_to_add = ["Convert to Consolidated Credit Note"]
	_opp_list_view_buttons = [$opp_push_to_dsm, $opp_generate_sales_agreements_button, $opp_dsm_sync ]
	
	it	"set remote site setting to execute apex command from UI." do
		SF.retry_script_block do
			#get page URL for salesforce API Usage 
			url_prefix = page.current_url.split('/')[0]
			url_host = page.current_url.split('/')[2]
			run_anonymous_url = url_prefix +"//"+url_host+"/apex/BaseDataJob"
			visit run_anonymous_url
			gen_wait_until_object $apex_delete_new_data_button      
			api_url = page.current_url
			SF.remote_site_settings_create_new
			SF.remote_site_settings_set_site_name "SALESFORCE_API"
			SF.remote_site_settings_set_site_url api_url
			SF.remote_site_settings_set_disable_protocol_security "true"  
			SF.click_button_save
		end
	end
	
	it "Contract Billing & Media Setup -Adding fields to layout" do
		login_user
		gen_start_test "Contract Billing & Media Setup -Adding fields to layout"
		#Assign Media Account Layout on Account.
		SF.set_page_layout_for_standard_objects $ffa_object_accounts, $ffa_profile_system_administrator, $ffa_financialforce_account_media_layout
		#Add "Generate Sales Agreement" button on Opportunity list view. 
		SF.add_buttons_to_standard_object_list_view_layout $ffa_object_opportunities, $opp_opportunity_list_view_layout, _opp_list_view_buttons
		#Go to Integration Rule tab on SF org and create Integration rules by clicking on 'Generate Integration Rules' button.
		SF.add_buttons_to_list_view_layout $ffa_object_integration_rule, $ffa_financialforce_integration_rule_list_view_layout , [$ffa_integration_rule_generate_integration_rules_button]
		
		#Change Layouts
		SF.set_page_layout_for_standard_objects $ffa_object_opportunities, $ffa_profile_system_administrator, $ffa_financialforce_opportunity_media_layout
		SF.edit_extended_layout $ffa_object_sales_agreement, $ffa_profile_system_administrator, $ffa_financialforce_sales_agreement_media_layout
		SF.edit_extended_layout $ffa_object_sales_agreement_line_item, $ffa_profile_system_administrator, $ffa_financialforce_sales_agreement_line_item_media_layout
		SF.edit_extended_layout $ffa_object_sales_invoice, $ffa_profile_system_administrator, $ffa_financialforce_sales_invoice_media_layout
		SF.edit_extended_layout $ffa_object_sales_invoice_line_item, $ffa_profile_system_administrator, $ffa_financialforce_sales_invoice_line_item_media_layout
		SF.edit_extended_layout $ffa_object_sales_credit_note, $ffa_profile_system_administrator, $ffa_financialforce_sales_credit_note_media_layout
		SF.edit_extended_layout $ffa_object_sales_credit_note_line_item, $ffa_profile_system_administrator, $ffa_financialforce_sales_credit_note_line_item_media_layout
		
		SF.object_button_edit $ffa_object_sales_invoice, $sf_edit_button
		SF.set_button_property_for_extended_layout
		SF.object_button_edit $ffa_object_sales_invoice, $sf_view_button
		SF.set_button_property_for_extended_layout
		#Add  Convert to Credit Note to Media Layout
		SF.edit_layout_add_field $ffa_object_sales_invoice, $ffa_financialforce_sales_invoice_media_layout, $sf_layout_panel_button, [$sinx_convert_to_credit_note, $ffa_post_button], $sf_edit_page_layout_target_position_button
		
		#7 a. Consolidated Invoice-	Edit the page layout and add 'Convert to Consolidated Credit Note' button to the detail page.	
		SF.edit_layout_add_field $ffa_object_consolidated_invoice, $ffa_financialforce_consolidated_invoice_layout,  $sf_layout_panel_button, _consolidate_invoice_field_to_add, $sf_edit_page_layout_target_position_button
		#7. b. Consolidated Invoice- Add the 'Convert to Consolidated Credit Note' button to the List view
		SF.add_buttons_to_list_view_layout $ffa_object_consolidated_invoice, $ffa_financialforce_consolidated_invoice_list_view_layout, [$consolidated_invoice_convert_to_consolidated_credit_note_button]
		
		# Add field 'Sales revenue account' in Product Layout
		SF.stdobj_edit_layout_add_field $ffa_objects_products, $ffa_product_layout, $sf_layout_panel_fields, [$product_sales_revenue_account_label], $sf_edit_page_layout_target_position
		SF.retry_script_block do
			SF.stdobj_edit_layout_add_field $ffa_object_users, $ffa_financialforce_user_layout, $sf_layout_panel_fields, _user_layout_fields_to_add, $sf_edit_page_layout_target_position
		end
	end
	
	it "Contract Billing & Media Setup-Provide User id from DFP in DSM User Id field on User. " do
		login_user
		SF.admin $sf_setup
		SF.click_link $sf_setup_manage_users
		SF.wait_for_search_button
		SF.click_link $sf_setup_manage_users_users
		SF.wait_for_search_button
		# click on user name to view detail page
		page.has_text?(SFUSER,:wait => DEFAULT_LESS_WAIT)
		SF.click_link SFUSER
		SF.click_button_edit
		USER.set_dsm_user_id $dfp_user_id
		SF.click_button_save
		page.has_text?(SFUSER,:wait => DEFAULT_LESS_WAIT)
	end
			
	it "Contract Billing & Media Setup- set dsm_account_id from DFP in account. " do
		login_user
		SF.tab $tab_accounts
		SF.select_view $bd_select_view_all_accounts
		SF.click_button_go
		SF.select_records_per_page "100"
		gen_click_link_and_wait $bd_account_apex_eur_account
		page.has_text?($bd_account_apex_eur_account)
		SF.click_button_edit
		Account.set_dsm_account_id $dfp_company_id
		SF.click_button_save
		SF.wait_for_search_button
	end
	
	it "Contract Billing & Media Setup- Go to 'Google Connector' tab and authorize with your gmail account which is connected with DFP."  do
		login_user
		SF.tab $tab_google_connector
		SF.wait_for_search_button
		DFP.click_button_authorise_with_google
		gen_wait_less
		DFP.set_google_signin_email $dfp_google_email_id
		DFP.click_button_google_signin_next
		gen_wait_less
		DFP.set_google_signin_password $dfp_google_password
		DFP.click_button_google_signin
		gen_wait_less
		page.has_css?($dfp_submit_approve_access_button)
		DFP.click_button_submit_approve_access
		SF.wait_for_search_button
		SF.click_button_save
		SF.wait_for_search_button
	end
end