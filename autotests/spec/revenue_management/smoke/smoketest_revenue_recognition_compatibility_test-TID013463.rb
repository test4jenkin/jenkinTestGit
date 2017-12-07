#--------------------------------------------------------------------#
#	TID : TID013463
# 	Pre-Requisite : spec/revenue_management/setup/setup_data.rb
#  	Product Area:  Accounting - Other - Revenue Management
#--------------------------------------------------------------------#

describe "TID013463 Smoke Test: Compatibility of Revenue Management", :type => :request do
	include_context "login"		
	_custom_start_date_invoice = "Custom Start Date Invoice"
	_custom_end_date_invoice = "Custom End Date Invoice"
	_rev_rec_template = "Rev Rec Template"
	_ffrrtemplate = "ffrrtemplate"
	_name = "FFA Sales Invoice Header"
	_object_name = "#{ORG_PREFIX}codaInvoice__c"
	_sales_invoice = "Sales_Invoice__c"
	_account = "#{ORG_PREFIX}Account__c"
	_description = "Name"
	_contract_start_date_name = "Custom_Start_Date_Invoice__c"
	_contract_end_date_name = "Custom_End_Date_Invoice__c"
	_net_total = "#{ORG_PREFIX}NetTotal__c"
	_invoice_status =  "#{ORG_PREFIX}InvoiceStatus__c"
	_complete = "Complete"
	_include = "Include"
	_currency = "#{ORG_PREFIX}InvoiceCurrency__c"
	_completed_field = "#{ORG_PREFIX}InvoiceStatus__c"
	_completed_value= "Complete"
	_include_completed_value= "Include"
	_income_statement_account = "#{ORG_PREFIX}GeneralLedgerAccount__c"
	_invoice_date = "19/04/2017"
	_contract_start_date = _invoice_date
	_contract_end_date = "17/09/2017"
	_rev_rec_template_name = "FFA Actual"
	_header_name = "FFA Sales Invoice Header"
	_year = (Time.now).year
	_period_start_date = "01/01/"+_year.to_s
	_total_revenue = "5,000.00"
	_previously_recognised = "0.00"
	_to_recognize_this_period = "32.89"
	_total = "32.89"
	_line1 = 1
	_expected_row_result = _total_revenue + " "+ _previously_recognised + " "+ _to_recognize_this_period + " " + _total
	before :all do
		#Hold Base Data
		gen_start_test "TID013463"	
		FFA.hold_base_data_and_wait
	end

	it "TID013463-TST036562: Setup-Add new custom fields to objects" do
		gen_start_test "TST036562: Setup "
		begin
			##create new custom fields
			SF.create_new_field $sf_data_type_lookup_relationship , $ffa_object_revenue_recognition_transaction_line , $ffa_object_sales_invoice , $ffa_object_sales_invoice, "",""
			SF.create_new_field $sf_data_type_date ,  $ffa_object_sales_invoice , "" , _custom_start_date_invoice , "", ""
			SF.create_new_field $sf_data_type_date ,  $ffa_object_sales_invoice , "" , _custom_end_date_invoice , "", ""
			SF.create_new_field $sf_data_type_lookup_relationship , $ffa_object_sales_invoice , $ffa_object_template , _rev_rec_template, _ffrrtemplate, ""

			SF.tab $tab_settings
			SF.click_button_new
			SETTING.set_name _header_name
			SETTING.set_level $setting_level_primary
			SETTING.set_object _object_name
			SETTING.set_actual_transaction_line_relationship _sales_invoice
			SETTING.set_account_name _account
			SETTING.set_description _description
			SETTING.set_startdate _contract_start_date_name
			SETTING.set_enddate _contract_end_date_name
			SETTING.set_total_revenue _net_total
			SETTING.set_active_field _invoice_status
			SETTING.set_active_value _complete
			SETTING.select_include_active_value _include
			SETTING.set_currency _currency
			SETTING.set_completed_field _completed_field
			SETTING.set_completed_value _completed_value
			SETTING.set_include_completed_value _include_completed_value
			SETTING.set_income_statement_account _income_statement_account
			SETTING.set_balance_sheet_account $bd_gla_account_receivable_control_usd
			SETTING.check_fixed_bs_account_code
			SETTING.select_setting_type $setting_type_actual
			SF.click_button_save
			SF.wait_for_search_button
			
			#create new Template
			SF.click_button $template_new_template
			SF.wait_for_search_button
			TEMP.set_name _rev_rec_template_name
			TEMP.select_type $template_type_equal_split
			TEMP.set_revenue_source _object_name
			TEMP.select_calculation_type $template_calculation_type_days
			SF.click_button_save		
			
			##Generate Periods
			SF.tab $tab_recognition_years
			SF.click_button_new
			RECY.set_custom_field_text_value $recy_name, _year
			RECY.select_dropdown_value $recy_period_calculation_basis, $recy_period_calculation_basis_month
			RECY.set_custom_field_text_value $recy_number_of_months, "12"
			RECY.set_custom_field_text_value $recy_start_date , _period_start_date
			SF.click_button_save
			SF.wait_for_search_button
			SF.click_button $recy_calculate_periods
			SF.wait_for_search_button
			SF.click_button $recy_create_period
			SF.wait_for_search_button
		end
		gen_end_test "TST036562: Setup "
	
		gen_start_test "TST036563: Post sales invoice "
		begin
			#Setup > Create > Objects > Sales Invoice > Buttons change Edit, New & View to ‘Standard Salesforce.com Page’
			SF.edit_extended_layout $ffa_object_sales_invoice, $ffa_profile_system_administrator, $ffa_sales_invoice_extended_layout
			SF.object_button_edit $ffa_object_sales_invoice, $sf_new_button
			SF.set_button_property_for_extended_layout
			SF.object_button_edit $ffa_object_sales_invoice, $sf_edit_button
			SF.set_button_property_for_extended_layout
			SF.object_button_edit $ffa_object_sales_invoice, $sf_view_button
			SF.set_button_property_for_extended_layout
			
			#Ensure you have selected company Merlin Auto USA
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_usa] ,true
			
			#Create a new Sales Invoice and Post
			SF.tab $tab_sales_invoices
			SF.click_button_new
			SF.wait_for_search_button
			SINX.set_account $bd_account_algernon_partners_co
			SINX.set_invoice_date _invoice_date
			#SINX.set_invoice_currency 
			SINX.set_custom_field_text_value _custom_start_date_invoice, _contract_start_date
			SINX.set_custom_field_text_value _custom_end_date_invoice, _contract_end_date
			SINX.set_custom_field_text_value _rev_rec_template , _rev_rec_template_name
			SF.click_button_save
			SF.wait_for_search_button
			FFA.click_manage_line
			SINX.add_line_items "1" , $bd_product_auto_com_clutch_kit_1989_dodge_raider , "100" , "50.00" , nil
			SF.click_button_save
			gen_wait_until_object_disappear $ffa_manage_lines_saving_locator
			page.has_button?($ffa_post_button)
			FFA.click_post
			SINX.click_post_invoice
			_invoice_status = SINX.get_invoice_status
			gen_include _invoice_status , $bd_document_status_complete , "TST036563: Expected Invoice status : Complete."
		end
		gen_end_test "TST036563: Post sales invoice "
		
		gen_start_test "TST036564: Run Recognise Revenue "
		begin
				SF.tab $tab_recognize_revenue
				RECREV.select_object $ffa_object_sales_invoice
				RECREV.set_recognition_date _invoice_date
				RECREV.set_currency $bd_currency_usd
				RECREV.generate_data 								
				actual_row_text = RECREV.get_data_row_text _line1
				gen_include($bd_account_algernon_partners_co, actual_row_text, "Account info is correct.")
				gen_include(_expected_row_result, actual_row_text, "data generated successfully.")
				
		end
		gen_end_test "TST036564: Run Recognise Revenue "
	end
	after :all do
		login_user
		# Delete Test Data
		FFA.delete_new_data_and_wait
		# Changing the layout of invoice,credit note and line items again to normal layout
		SF.edit_extended_layout $ffa_object_sales_invoice, $ffa_profile_system_administrator, $ffa_sales_invoice_normal_layout
		# changing button properties to normal
		SF.object_button_edit $ffa_object_sales_invoice, $sf_new_button
		SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_invoice_new
		
		SF.object_button_edit $ffa_object_sales_invoice, $sf_edit_button
		SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_invoice_edit
		
		SF.object_button_edit $ffa_object_sales_invoice, $sf_view_button
		SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_invoice_view
		SF.logout 
	end
end