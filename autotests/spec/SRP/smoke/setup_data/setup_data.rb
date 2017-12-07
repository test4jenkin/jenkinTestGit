#--------------------------------------------------------------------#
#	TID :  
# 	Pre-Requisit: Org with basedata deployed.
#   Packages : FFA ,PSA, Clicklink, Journal Extension, Payable Extension
#  	Product Area: FFA SRP Integration smoke test data set up.
#--------------------------------------------------------------------#

describe "SRP-Smoke Test - Setup", :type => :request do
	include_context "login"	
	
	_vendor_invoice_fields_to_add = [$vin_eligible_for_pin_label,$vin_eligible_for_pcr_label]
	_milestone_layout_fields_to_add = [$ms_gla_code_label]
	_misc_adjustment_layout_fields_to_add = [$madjust_gla_code_label]
	_project_layout_fields_to_add = [$project_services_product_label]
	_region_layout_fields_to_add = [$region_company_label]
	_contacts_layout_field_to_add = [$contacts_work_calendar_label,$contacts_salesforce_user_label,$contacts_is_resource_checkbox_label, $contacts_is_resource_active_checkbox_label]
	_time_period_file_name_2015 = "TimePeriodsP-Y-Q-M-2015-3-1.csv"
	_time_period_file_name_2016 = "TimePeriodsP-Y-Q-M-2016-17.csv"
	_time_period_2015_success_msg = "120 successes"
	_time_period_2016_success_msg = "34 successes"
	 
	it "Enabling user Interface settings before running scripts" do
		puts "Enabling user Interface settings before running scripts"
		SF.retry_script_block do
			begin
				SF.user_interface_option [$user_interface_enable_related_list_hover_link_option , $user_interface_enable_separated_loading_of_related_list_option],false
				SF.click_button $ffa_save_button
				SF.wait_for_search_button
			end
		end
	end

	it	"set remote site setting to execute apex command from UI." do
		SF.retry_script_block do
			login_user
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
	
	it "Add fields/Button layout for SRP Smoke test. " do
		SF.retry_script_block do
			login_user
			SF.edit_layout_add_field $ffa_object_milestone, $label_milestone_layout, $sf_layout_panel_fields, _milestone_layout_fields_to_add, $sf_edit_page_layout_target_position
			SF.edit_layout_add_field $ffa_object_misc_adjustment, $label_misc_adjustment_layout, $sf_layout_panel_fields, _misc_adjustment_layout_fields_to_add, $sf_edit_page_layout_target_position
			SF.edit_layout_add_field $ffa_object_regions, $label_region_layout, $sf_layout_panel_fields, _region_layout_fields_to_add, $sf_edit_page_layout_target_position
			SF.edit_layout_add_field $ffa_object_project, $label_project_layout, $sf_layout_panel_fields, _project_layout_fields_to_add, $sf_edit_page_layout_target_position
			SF.stdobj_edit_layout_add_field $ffa_object_contact, $label_contact_layout, $sf_layout_panel_fields, _contacts_layout_field_to_add, $sf_edit_page_layout_target_position
			SF.edit_layout_add_field $ffa_object_vendor_invoices, $ffa_financialforce_vendor_invoice_layout, $sf_layout_panel_fields, _vendor_invoice_fields_to_add, $sf_edit_page_layout_target_position
			SF.edit_layout_add_field $ffa_object_vendor_invoices, $ffa_financialforce_vendor_invoice_layout, $sf_layout_panel_button, [$ffa_vendor_inv_create_pin_pcr_button], $sf_edit_page_layout_target_position_button		
			SF.edit_layout_add_field $ffa_object_billing_event, $ffa_financialforce_billing_event_layout, $sf_layout_panel_button, [$ffa_billing_event_create_sin_scr_button], $sf_edit_page_layout_target_position_button		
			# Add button on list view
			SF.add_buttons_to_list_view_layout  $ffa_object_integration_rule, $ffa_financialforce_integration_rule_list_view_layout , [$ffa_integration_rule_generate_refresh_integration_rules_srp_button]
			SF.add_buttons_to_list_view_layout  $ffa_object_vendor_invoices, $ffa_financialforce_vendor_invoice_list_view_layout , [$ffa_vendor_inv_create_pin_pcr_button_list_view]
		end
	end
	
	# Will upload the data on data loader site
	it "Upload Time period files in dataloader site." do
		SF.retry_script_block do
			login_user
			# login to dataloader
			DL.login_dataloader
			# import period sheet 1
			DL.import_time_period_files _time_period_file_name_2015
			page.has_text?(_time_period_2015_success_msg)
			# import period sheet 2
			DL.import_time_period_files _time_period_file_name_2016
			page.has_text?(_time_period_2016_success_msg)
		end	
	end
end
