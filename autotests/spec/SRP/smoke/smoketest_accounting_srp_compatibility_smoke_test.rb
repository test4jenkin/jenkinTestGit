#--------------------------------------------------------------------#
#	TID : TID005987
# 	Pre-Requisite : Base Data Deployed on Managed org
#	Packages - FFA ,PSA, Clicklink, Journal Extension, Payable Extension
#	Data Set up - smoketest_data_setup.rb
#  	Product Area: Accounting
#--------------------------------------------------------------------#


describe "SRP Smoke Test - FFA and SRP Compatibility Smoke test", :type => :request do
include_context "login"

	_current_date = Date.today
	_past_date = Date.today - 10
	_future_date = Date.today + 60
	_milestone_adjustment_name = "PRJ01-MisAdj01"
	_milestone_adjustment_name2 = "PRJ01-MisAdj02"
	_project_budget = "PRJ01-Budget01"
	_vin_number_pin_001= "PIN-001"
	_vin_po_number_po_001 = "PO-001"
	_vin_number_pin_002= "PIN-002"
	_vin_po_number_po_002 = "PO-002"
	_vin1_line1 = "PRJ01 PRJ01-Budget01 Header PRJ01-MS01"
	_vin1_line2 = "PRJ01 PRJ01-Budget01 Header PRJ01-MisAdj01" 
	_vin2_line1 = "PRJ01 PRJ01-Budget01 Header PRJ01-MS02"
	_vin2_line2 = "PRJ01 PRJ01-Budget01 Header PRJ01-MisAdj02" 
	_pin_row1_data = "1 Accounts Payable Control - USD CRE002 US 100.00 0.00"
	_pin_row2_data = "2 Accounts Payable Control - USD CRE002 US 100.00 0.00"
	_pcr_row1_data = "1 Accounts Payable Control - USD CRE002 US 100.00 0.00"
	_pcr_row2_data = "2 Accounts Payable Control - USD CRE002 US 100.00 0.00"
	_vin_number_for_pcr = ""
	_vin_number_for_pin = ""
	_amount_total_200 = "200.00"
	_misc_adjustment_label = "Miscellaneous Adjustment"
	_milestone_label = "Milestone"
	_billing_event_amount_100 = "USD 100.00"
	_billing_event_amount_n100 = "USD -100.00"
	_amount_200 = "USD 200.00"
	_amount_n200 = "USD -200.00"
	_srp_company_source_value = "pse__Region__r.ffpsai__OwnerCompany__c"
	_work_calendar_us = "US"
	_srp_resource_contact = "SRP Resource"
	_global_region = "Global Region"
	_milestone_amount_100 = "100.00"
	_milestone_amount_n100 = "-100.00"
	_milestone_cost_100 = "100.00"
	_milestone_cost_n100 = "-100.00"
	_budget_amount_1500 = "1500.00"
	_user_sf_adv_multi_currency_link = "Use_Salesforce_Advanced_Multi_Currency"
	_admin_user = "System Administrator"
	_project_name = "PRJ01"
	_milestone_name = "PRJ01-MS01"
	_milestone_name2 = "PRJ01-MS02"
	before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait
		gen_start_test "TID005987-SRP Smoke Test"
		
		# Import PSA Configuration
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_spain],true
		SF.tab $tab_psa_config
		SF.click_link $label_psa_import_configuration
		SF.wait_for_search_button
		PSA.click_import_configuration_button
		gen_report_test "PSA Configuration is exported successfully."
		
		# Enable adv currency management and  parenthetical currency conversion.
		SF.admin $sf_setup
		SF.click_link $sf_setup_company_profile
		SF.click_link $sf_setup_manage_currencies
		if (page.has_css?($sf_enable_button,:wait => DEFAULT_LESS_WAIT))
			#Assert that only one corporate currency is available
			expect(page).to have_css($sf_active_corporate_currency,:count => 1)	
			gen_report_test "Only 1 active currency is present."
		end
		# Enable adv currency management and parenthetical currency conversion.
		SF.enable_adv_currency_management
		SF.enable_parenthetical_currency_conversion	
		gen_report_test "Enabled Adv Currency Management and Parenthetical Currency Conversion."
		
		# Configure currency
		SF.tab $tab_configuration_groups
		SF.click_button_go
		find(:xpath,$acc_curr_config_group_currencies_link).click
		page.has_link?(_user_sf_adv_multi_currency_link)
		SF.click_link _user_sf_adv_multi_currency_link
		find(:xpath,$acc_curr_edit_config_group).click
		#Set the field as null and then update the value
		find($acc_curr_config_group_value).set ""
		find($acc_curr_config_group_value).set "true"
		SF.click_button_save
		SF.wait_for_search_button
		expect(page).to have_xpath($acc_curr_config_group_true,:count => 1)
		gen_report_test "Configuration currency is passes."
		
		# Generate Integration Rules
		SF.tab $tab_integration_rules
		SF.select_view $bd_select_view_all
		SF.click_button_go
		SF.click_button $ffa_integration_rule_generate_refresh_integration_rules_srp_button
		gen_wait_until_object $page_vf_message_text
		gen_include $ffa_msg_psa_ffa_ir_rule_generate , FFA.ffa_get_info_message  , "FFA and PSA IR rule generated successfully"
		
		# create custom setting for SRP
		SF.admin $sf_setup
		find($sf_global_search).set $sf_setup_develop_custom_setting
		SF.click_link $sf_setup_develop_custom_setting
		SF.wait_for_search_button
		# filter result
		SF.listview_filter_result_by_alphabet "S"
		custom_setting_manage_link = $sf_custom_setting_manage.gsub($sf_param_substitute, $ffa_custom_setting_srp_integration_settings)
		page.has_xpath?(custom_setting_manage_link)
		find(:xpath , custom_setting_manage_link).click
		SF.wait_for_search_button
		edit_button_exist = false
		edit_button_exist = page.has_button?($sf_edit_button,:wait => DEFAULT_LESS_WAIT)
		if(edit_button_exist)
			SF.click_button $sf_edit_button
		else
			SF.click_button $sf_new_button
		end
		find($ffa_custom_setting_srp_company_source_input).set _srp_company_source_value
		find($ffa_custom_setting_srp_misc_adjustment_balance_gla_code_input).set $bd_gla_account_payable_control_eur
		SF.click_button_save
		SF.wait_for_search_button
		gen_report_test "Custom setting addedd successfully."
		
		# create work calendar
		SF.tab $tab_work_calendars
		WC.click_new_button
		WC.set_work_calendar_name _work_calendar_us
		WC.click_save_button
		gen_compare WC.get_wc_name ,_work_calendar_us , "Work Calendar US is saved successfully."
		
		# Create Regions
		SF.tab $tab_regions
		REGION.click_new_button
		REGION.set_region_name _global_region
		REGION.set_region_company $company_merlin_auto_spain
		REGION.set_default_work_calendar _work_calendar_us
		REGION.check_include_in_forecasting_checkbox
		#save the region
		REGION.click_save_button
		gen_compare REGION.get_name ,_global_region , "Region is saved successfully."
			
		# Create new contact
		SF.tab $tab_contacts
		Contacts.click_new_contact
		Contacts.set_last_name _srp_resource_contact
		Contacts.set_work_calendar_name _work_calendar_us
		Contacts.check_is_resource_checkbox
		Contacts.check_is_resource_active_checkbox
		Contacts.set_salesforce_user _admin_user
		Contacts.save
		gen_include _srp_resource_contact ,Contacts.get_contact_name ,  "Expected COntact-Smoke Test to be created successfully."
		
		
		# Create Permission Control for resource
		SF.tab $tab_permission_controls
		PC.click_new_button
		PC.set_user _admin_user
		PC.set_resource _srp_resource_contact
		PC.check_checkbox $pc_resource_request_entry_checkbox
		PC.check_checkbox $pc_staffing_checkbox
		PC.check_checkbox $pc_skills_certifications_entry_checkbox
		PC.check_checkbox $pc_skills_certifications_view_checkbox
		PC.check_checkbox $pc_billing_checkbox
		PC.check_checkbox $pc_forecast_edit_checkbox
		PC.check_checkbox $pc_forecast_view_checkbox
		PC.check_checkbox $pc_timecard_entry_checkbox
		PC.check_checkbox $pc_timecard_ops_edit_checkbox
		PC.check_checkbox $pc_expense_entry_checkbox
		PC.check_checkbox $pc_expense_ops_edit_checkbox
		PC.check_checkbox $pc_invoicing_checkbox
		PC.click_save_button
		gen_include "PC" ,PC.get_name ,  "Permission control for SRP resource saved sucessfully."
			
		# Create permission control for region
		SF.tab $tab_permission_controls
		PC.click_new_button
		PC.set_user _admin_user
		PC.set_region _global_region
		PC.check_checkbox $pc_resource_request_entry_checkbox
		PC.check_checkbox $pc_staffing_checkbox
		PC.check_checkbox $pc_skills_certifications_entry_checkbox
		PC.check_checkbox $pc_skills_certifications_view_checkbox
		PC.check_checkbox $pc_billing_checkbox
		PC.check_checkbox $pc_forecast_edit_checkbox
		PC.check_checkbox $pc_forecast_view_checkbox
		PC.check_checkbox $pc_timecard_entry_checkbox
		PC.check_checkbox $pc_timecard_ops_edit_checkbox
		PC.check_checkbox $pc_expense_entry_checkbox
		PC.check_checkbox $pc_expense_ops_edit_checkbox
		PC.check_checkbox $pc_invoicing_checkbox
		PC.click_save_button
		gen_include "PC" ,PC.get_name ,  "Permission control for region saved sucessfully."
		
		# Create Projects
		SF.tab $tab_projects
		PROJECT.click_new_button
		PROJECT.set_name _project_name
		PROJECT.set_region_value _global_region
		PROJECT.set_services_product $bd_product_auto_com_clutch_kit_1989_dodge_raider
		PROJECT.set_start_date _past_date.strftime("%d/%m/%Y")
		PROJECT.set_end_date _future_date.strftime("%d/%m/%Y")
		PROJECT.set_account_value $bd_account_cambridge_auto
		SF.check_checkbox $project_active_label
		SF.check_checkbox $project_billable_label
		SF.check_checkbox $project_include_in_forecasting_label
		SF.click_button_save
		gen_include _project_name ,PROJECT.get_name , "Expected Project to be created sucessfully."
		
		# Create Milestones
		SF.tab $tab_projects
		SF.click_button_go
		SF.click_link _project_name
		SF.wait_for_search_button
		PROJECT.click_new_milestone_button
		MS.set_name _milestone_name
		MS.set_target_date _current_date.strftime("%d/%m/%Y")
		MS.set_actual_date _current_date.strftime("%d/%m/%Y")
		MS.set_milestone_amount _milestone_amount_100
		MS.set_milestone_cost _milestone_cost_100
		MS.select_milestone_status $ms_status_approved
		SF.check_checkbox $ms_approved_checkbox
		SF.check_checkbox $ms_approved_for_billing_checkbox
		SF.check_checkbox $ms_include_in_financial_checkbox
		SF.check_checkbox $ms_approved_for_vendor_payment_checkbox
		MS.set_ms_gla_code $bd_gla_account_payable_control_usd
		MS.set_vendor_account $bd_account_audi
		SF.click_button_save
		
		#create another milestone with negative amount and cost
		SF.tab $tab_projects
		SF.click_button_go
		SF.click_link _project_name
		SF.wait_for_search_button
		PROJECT.click_new_milestone_button
		MS.set_name _milestone_name2
		MS.set_target_date _current_date.strftime("%d/%m/%Y")
		MS.set_actual_date _current_date.strftime("%d/%m/%Y")
		MS.set_milestone_amount _milestone_amount_n100
		MS.set_milestone_cost _milestone_cost_n100
		MS.select_milestone_status $ms_status_approved
		SF.check_checkbox $ms_approved_checkbox
		SF.check_checkbox $ms_approved_for_billing_checkbox
		SF.check_checkbox $ms_include_in_financial_checkbox
		SF.check_checkbox $ms_approved_for_vendor_payment_checkbox
		MS.set_ms_gla_code $bd_gla_account_payable_control_usd
		MS.set_vendor_account $bd_account_audi
		SF.click_button_save
		gen_report_test "Milestones are created successfully."
			
		# Create Miscellaneous adjustment
		SF.tab $tab_projects
		SF.click_button_go
		SF.click_link _project_name
		SF.wait_for_search_button
		PROJECT.click_new_misc_adjustment_button
		MADJUST.set_name _milestone_adjustment_name
		MADJUST.set_effective_date _current_date.strftime("%d/%m/%Y")
		MADJUST.set_amount _milestone_amount_100
		MADJUST.set_madjust_gla_code $bd_gla_account_payable_control_usd
		MADJUST.select_misc_adjust_status $madjust_status_approved
		MADJUST.select_tranx_category $madjust_trx_category_ready_to_bill_revenue
		SF.check_checkbox $ms_approved_checkbox
		SF.check_checkbox $ms_approved_for_billing_checkbox
		SF.check_checkbox $ms_include_in_financial_checkbox
		SF.check_checkbox $ms_approved_for_vendor_payment_checkbox
		MADJUST.set_vendor_account $bd_account_audi
		SF.click_button_save

		# creating another Misc adjustment with negative amount - -100.00
		SF.tab $tab_projects
		SF.click_button_go
		SF.click_link _project_name
		SF.wait_for_search_button
		PROJECT.click_new_misc_adjustment_button
		MADJUST.set_name _milestone_adjustment_name2
		MADJUST.set_effective_date _current_date.strftime("%d/%m/%Y")
		MADJUST.set_amount _milestone_amount_n100
		MADJUST.set_madjust_gla_code $bd_gla_account_payable_control_usd
		MADJUST.select_misc_adjust_status $madjust_status_approved
		MADJUST.select_tranx_category $madjust_trx_category_ready_to_bill_revenue
		SF.check_checkbox $ms_approved_checkbox
		SF.check_checkbox $ms_approved_for_billing_checkbox
		SF.check_checkbox $ms_include_in_financial_checkbox
		SF.check_checkbox $ms_approved_for_vendor_payment_checkbox
		MADJUST.set_vendor_account $bd_account_audi
		SF.click_button_save
		gen_report_test "Milestones are created successfully."
		
		# Create budget for project
		SF.tab $tab_projects
		SF.click_button_go
		SF.click_link _project_name
		SF.wait_for_search_button
		PROJECT.click_new_budget_header_button 
		BUDGET.set_name _project_budget
		BUDGET.set_amount _budget_amount_1500
		BUDGET.set_account $bd_account_audi
		BUDGET.set_effective_date _current_date.strftime("%d/%m/%Y")
		BUDGET.select_budget_type $budget_type_vendor_purchase_order
		SF.click_button_save
		gen_include _project_budget ,BUDGET.get_name , "Expected Project budget to be created sucessfully."
		
		# Generate Billing event
		SF.tab $tab_billing_event_generation
		SF.wait_for_search_button
		BEG.check_include_prior_period_checkbox
		BEG.click_generate_button
		SF.wait_for_apex_job
		SF.tab $tab_billing_event_generation
		gen_compare $bd_account_cambridge_auto , BEG.get_billing_event_account_name , "Expected account name for billing event created to be #{$bd_account_cambridge_auto}"
		
		# Create VIN for PIN
		SF.tab $tab_vendor_invoices
		SF.wait_for_search_button
		VIN.click_new_button
		VIN.set_account $bd_account_audi
		VIN.set_date _current_date.strftime("%d/%m/%Y")
		VIN.set_invoice_number _vin_number_pin_001
		VIN.set_po_wo_number _vin_po_number_po_001
		VIN.click_save_button
		_vin_number_for_pin = VIN.get_name
		# Add line items
		VIN.click_new_item_button
		VIN.set_start_date _past_date.strftime("%d/%m/%Y")
		VIN.set_end_date _future_date.strftime("%d/%m/%Y")
		VIN.check_show_misc_adjustment_checkbox
		VIN.check_show_milestone_checkbox
		VIN.click_search_button
		VIN.select_invoice_item _milestone_name
		VIN.select_invoice_item _milestone_adjustment_name
		VIN.click_line_add_button
		VIN.click_done_button
		
		# Create VIN for PCR
		SF.tab $tab_vendor_invoices
		SF.wait_for_search_button
		VIN.click_new_button
		VIN.set_account $bd_account_audi
		VIN.set_date _current_date.strftime("%d/%m/%Y")
		VIN.set_invoice_number _vin_number_pin_002
		VIN.set_po_wo_number _vin_po_number_po_002
		VIN.click_save_button
		_vin_number_for_pcr = VIN.get_name
		# Add line items
		VIN.click_new_item_button
		VIN.set_start_date _past_date.strftime("%d/%m/%Y")
		VIN.set_end_date _future_date.strftime("%d/%m/%Y")
		VIN.check_show_misc_adjustment_checkbox
		VIN.check_show_milestone_checkbox
		VIN.click_search_button
		VIN.select_invoice_item _milestone_name2
		VIN.select_invoice_item _milestone_adjustment_name2
		VIN.click_line_add_button
		VIN.click_done_button
	end
	
	it "TID005987-TST017308 :Verify that SIN and SCR are craeted successfully from Billing event." do
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_spain] ,true
		SF.tab $tab_billing_event_generation
		SF.wait_for_search_button
		BEG.expand_billing_event_batch_list
		BEG.expand_billing_event_list
		BEG.select_billing_event _misc_adjustment_label , _billing_event_amount_100
		BEG.select_billing_event _milestone_label , _billing_event_amount_100
		BEG.remove_and_accept_alert

		# Create SCR from billing event
		SF.tab $tab_billing_events
		SF.click_button_go
		_billing_event_for_scr = FFA.get_column_value_in_grid $be_summary_amount_label , _amount_n200 , $be_name_label
		SF.click_link _billing_event_for_scr
		
		# Release the billing event to create SCR 
		BE.click_release_button
		
		# click sales invocie/credit note button
		BE.click_create_sin_scn_button
		gen_wait_until_object $scn_credit_note_total_value
		gen_compare "$200.00",SCR.get_scn_net_total ,"Expected Credit note total to be 200.00"
		
		# Generate billing event to create sales invoice
		SF.tab $tab_billing_event_generation
		SF.wait_for_search_button
		BEG.check_include_prior_period_checkbox
		BEG.click_generate_button
		SF.wait_for_apex_job
		SF.tab $tab_billing_event_generation
		gen_compare $bd_account_cambridge_auto , BEG.get_billing_event_account_name , "Expected account name for billing event created to be #{$bd_account_cambridge_auto}"
		
		# Create SIN from billing event
		SF.tab $tab_billing_events
		SF.click_button_go
		_billing_event_for_sin = FFA.get_column_value_in_grid $be_summary_amount_label , _amount_200 , $be_name_label
		SF.click_link _billing_event_for_sin
		
		# Release the billing event to create SCR 
		BE.click_release_button
		
		# click sales invocie/credit note button
		BE.click_create_sin_scn_button
		page.has_css?($sin_post_button_locator)
		gen_compare "$200.00",SIN.get_invoice_net_total ,"Expected Invoice  note total to be 200.00"
	end
	
	it "TID005987-TST033820 :Verify that Payable Invoice are created successfully."  do
		login_user
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_spain] ,true
		SF.tab $tab_vendor_invoices
		SF.click_button_go
		SF.wait_for_search_button
		
		# open Invoice detail page and check submitted and payment checkbox
		SF.click_link _vin_number_for_pin
		SF.wait_for_search_button
		vin_date = VIN.get_invoice_date
		
		# Assert VIN rows
		vin_first_row = VIN.get_vin_line_row_data 1
		gen_include  _vin1_line1 , vin_first_row ,"Expected VIN1 line to be #{_vin1_line1}"
		vin_second_row = VIN.get_vin_line_row_data 2
		gen_include  _vin1_line2 , vin_second_row ,"Expected VIN1 line to be #{_vin1_line2}"
		VIN.click_edit_button
		VIN.check_checkbox $vin_submitted_checkbox_label
		VIN.check_checkbox $vin_approved_for_payment_checkbox_label
		VIN.click_save_button
		
		# Assert value of ellgible for pin 
		gen_compare 1, VIN.get_elligible_pin_value , "Expected value to be 1."
		
		# Create PIN and verify
		VIN.click_create_pin_pcn_button
		page.has_text?($bd_account_audi)
		SF.tab $tab_payable_invoices
		SF.click_button_go
		SF.wait_for_search_button
		_new_pin_number  = FFA.get_column_value_in_grid $pin_vendor_invoice_number_label , _vin_number_pin_001 , $pin_payable_invoice_number_label
		SF.click_link _new_pin_number
		SF.wait_for_search_button
		pin_num = PIN.get_invoice_number
		row1_data = PIN.get_expense_line_row_data 1
		row2_data = PIN.get_expense_line_row_data 2
		
		# Assert PIN Rows
		gen_compare row1_data , _pin_row1_data , "Expected Row 1 of PIN to be #{_pin_row1_data}"
		gen_compare row2_data , _pin_row2_data , "Expected Row 2 of PIN to be #{_pin_row2_data}"

		# Assert PIN Total and Date
		inv_total = PIN.get_invoice_total
		gen_include  _amount_total_200 ,inv_total, "Expected Invoice total to be 200.00"
		gen_compare vin_date, PIN.get_invoice_date , "Invoice Date and Vendor Invoice date should be same- #{vin_date}."
		SF.logout
	end
	
	it "TID005987-TST033821 :Verify that Payable Credit Note are created successfully." do
		login_user
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_spain] ,true
		SF.tab $tab_vendor_invoices
		SF.click_button_go
		SF.wait_for_search_button
		
		# open Invoice detail page and check submitted and payment checkbox
		SF.click_link _vin_number_for_pcr
		SF.wait_for_search_button
		page.has_text?(_vin_number_for_pcr)
		
		# Assert VIN rows
		vin_first_row = VIN.get_vin_line_row_data 1
		gen_include  _vin2_line1 , vin_first_row ,"Expected VIN1 line to be #{_vin2_line1}"
		vin_second_row = VIN.get_vin_line_row_data 2
		gen_include  _vin2_line2 , vin_second_row ,"Expected VIN1 line to be #{_vin2_line2}"
		vin_date = VIN.get_invoice_date
		VIN.click_edit_button
		VIN.check_checkbox $vin_submitted_checkbox_label
		VIN.check_checkbox $vin_approved_for_payment_checkbox_label
		VIN.click_save_button
		
		# Assert value of ellgible for pcr
		gen_compare 1, VIN.get_elligible_pcr_value , "Expected value to be 1."
		
		# Create PCR and verify
		VIN.click_create_pin_pcn_button
		page.has_text?($bd_account_audi)
		SF.tab $tab_payable_credit_notes
		SF.click_button_go
		SF.wait_for_search_button
		_new_pcr_number  = FFA.get_column_value_in_grid $label_vendor_credit_note_number , _vin_number_pin_002 , $label_payable_credit_note_number
		SF.click_link _new_pcr_number
		SF.wait_for_search_button
		pcr_num = PCR.get_credit_note_number
		pcr_row_data1 = PCR.get_expense_line_row_data 1
		pcr_row_data2 = PCR.get_expense_line_row_data 2
		
		# Assert PCR Rows
		gen_compare pcr_row_data1 , _pcr_row1_data , "Expected Row 1 of PIN to be #{_pcr_row1_data}"
		gen_compare pcr_row_data2 , _pcr_row2_data , "Expected Row 2 of PIN to be #{_pcr_row2_data}"
		crn_total = PCR.get_credit_note_total
		# Assert PCR date and total
		gen_include  _amount_total_200 ,crn_total, "Expected credit note total to be 200.00"
		gen_compare vin_date, PCR.get_credit_note_date , "Invoice Date and Vendor Invoice date should be same- #{vin_date}."
		SF.logout
	end
	
	after :all do
		login_user
		# Marking Approved for payment=false for both the invoices before deleting the data.
		# VIN-1
		SF.tab $tab_vendor_invoices
		SF.click_button_go
		SF.click_link _vin_number_for_pin
		SF.wait_for_search_button
		VIN.click_edit_button
		VIN.uncheck_checkbox $vin_approved_for_payment_checkbox_label
		VIN.click_save_button
		# VIN-2
		SF.tab $tab_vendor_invoices
		SF.click_button_go
		# open Invoice detail page and check submitted and payment checkbox
		SF.click_link _vin_number_for_pcr
		SF.wait_for_search_button
		VIN.click_edit_button
		VIN.uncheck_checkbox $vin_approved_for_payment_checkbox_label
		VIN.click_save_button
		
		# Delete Test Data
		FFA.delete_new_data_and_wait
		gen_end_test "TID005987-SRP Smoke Test"
		SF.logout
	end
end
