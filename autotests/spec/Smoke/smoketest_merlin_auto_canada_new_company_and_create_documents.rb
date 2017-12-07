#--------------------------------------------------------------------#
#	TID : TID013645
# 	Pre-Requisite : smoketest_data_setup.rb , smoketest_data_setup_ext.rb
#  	Product Area: Create new company Merlin auto Canada (Smoke Test)
# 	Story: 20485
#--------------------------------------------------------------------#

describe "Smoke Test:- Create New COmpany Merlin Auto Canada of combination tax codes.", :type => :request do
include_context "login"
include_context "logout_after_each"
	before :all do
		gen_start_test "TID013645"
		# Hold Base Data
        FFA.hold_base_data_and_wait
	end
	it "TID013645:Create new company merlin auto Canada with combined tax codes and create and post documents on extended layout. " do
		_canada_gla_account_receivable_control_cad = "Accounts Receivable Control - CAD"
		_canada_gla_account_payable_control_cad = "Accounts Payable Control - CAD"
		_gla_reporting_code = "ARCAD"
		_gla_reporting_code2 = "APCAD"
		_company_name_merlin_auto_can= "Merlin Auto CAN"
		_company_street_address = "1 The High Street"
		_company_city = "Toronto"
		_company_state_province = "ON"
		_company_country_canada = "Canada"
		_company_zip_postal_code = "T3N 4WX"
		_company_phone = "+1 555-8676-4444"
		_company_contact_email = "merlin@merlinautocan.can"
		_company_tax_reg_number = "192837465"
		_company_description_term = "Standard"
		_company_days_offset = "30"
		_canada_currency = "CAD"
		_canada_currency_value = "CAD - Canadian Dollar"
		_US_currency_value = "USD - U.S. Dollar"
		_acc_name = "Canadian Testing"
		_prod_standard_price_currency_canada = "CAD - Canadian Dollar"
		_standard_price_1001 = "1001"
		_tax_code_pst = "PST"
		_tax_code_gstcan = "GSTCAN"
		_tax_code_combo = "COMBO"
		_total_amount_115 = "115.00"
		_line_1 = 1
		_net_value_100_00 = "100.00"
		_vendor_credit_note_number = "VC12"
		_net_total_1101_00 = "1,101.00"
		_tax_total_165_15 = "165.15"
		_invoice_total_1266_15  = "1,266.15"

		SF.app $accounting
		begin		
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_spain] ,true
		end
		
		#Prerequisite 
		begin
			gen_start_test "TID013645: Pre-Requisite to update layouts and create base data for new company. "
			# Edit layout for invoice,credit notes and line items.
			SF.edit_extended_layout $ffa_object_sales_invoice, $ffa_profile_standard_user, $ffa_sales_invoice_extended_layout
			SF.edit_extended_layout $ffa_object_sales_credit_note, $ffa_profile_standard_user, $ffa_sales_credit_note_extended_layout
			SF.edit_extended_layout $ffa_object_sales_invoice_line_item, $ffa_profile_standard_user, $ffa_invoice_line_item_extended_layout
			SF.edit_extended_layout $ffa_object_sales_credit_note_line_item, $ffa_profile_standard_user, $ffa_credit_note_line_item_extended_layout
			SF.edit_extended_layout $ffa_object_payable_invoice, $ffa_profile_standard_user, $ffa_purchase_invoice_extended_layout
			SF.edit_extended_layout $ffa_object_payable_credit_note, $ffa_profile_standard_user, $ffa_purchase_credit_note_extended_layout
			SF.edit_extended_layout $ffa_object_payable_invoice_line_item, $ffa_profile_standard_user, $ffa_purchase_invoice_line_item_extended_layout
			SF.edit_extended_layout $ffa_object_payable_credit_note_line_item, $ffa_profile_standard_user, $ffa_purchase_credit_note_line_item_extended_layout
			
			# Edit properties for New , Edit and View button in Sales invoice and credit notes
			SF.object_button_edit $ffa_object_sales_invoice, $sf_new_button
			SF.set_button_property_for_extended_layout
			SF.object_button_edit $ffa_object_sales_invoice, $sf_edit_button
			SF.set_button_property_for_extended_layout
			SF.object_button_edit $ffa_object_sales_invoice, $sf_view_button
			SF.set_button_property_for_extended_layout
			SF.object_button_edit $ffa_object_sales_credit_note, $sf_new_button
			SF.set_button_property_for_extended_layout
			SF.object_button_edit $ffa_object_sales_credit_note, $sf_edit_button
			SF.set_button_property_for_extended_layout 
			SF.object_button_edit $ffa_object_sales_credit_note, $sf_view_button
			SF.set_button_property_for_extended_layout
			SF.object_button_edit $ffa_object_payable_invoice, $sf_new_button
			SF.set_button_property_for_extended_layout
			SF.object_button_edit $ffa_object_payable_invoice, $sf_edit_button
			SF.set_button_property_for_extended_layout
			SF.object_button_edit $ffa_object_payable_invoice, $sf_view_button
			SF.set_button_property_for_extended_layout
			SF.object_button_edit $ffa_object_payable_credit_note, $sf_new_button
			SF.set_button_property_for_extended_layout
			SF.object_button_edit $ffa_object_payable_credit_note, $sf_edit_button
			SF.set_button_property_for_extended_layout 
			SF.object_button_edit $ffa_object_payable_credit_note, $sf_view_button
			SF.set_button_property_for_extended_layout
			
			# Create new GLA
			SF.tab $tab_general_ledger_accounts
			SF.click_button_new
			GLA.create _canada_gla_account_receivable_control_cad ,_gla_reporting_code ,$bd_gla_type_balance_sheet,true
			SF.click_button_save
			gen_end_test "TID013645: Pre-Requisite to update layouts and create base data for new company. "
			
			# Create new Payable control GLA
			SF.tab $tab_general_ledger_accounts
			SF.click_button_new
			GLA.create _canada_gla_account_payable_control_cad ,_gla_reporting_code2 ,$bd_gla_type_balance_sheet,true
			SF.click_button_save
						
		end
		
		gen_start_test "TST017670: Create a new Combined type company- Merlin Auto CAN"	
		begin
			#Step 1.1
			gen_start_test "TST017670,Step-1  Create a new company and activate it."
			begin
				SF.tab $tab_companies
				SF.click_button_new
				Company.select_record_type $bd_company_record_type_combined
				Company.click_continue_button
				#Set company address details
				Company.set_company_name _company_name_merlin_auto_can
				Company.set_company_street_address _company_street_address
				Company.set_company_city _company_city
				Company.set_company_state_province _company_state_province
				Company.set_company_country _company_country_canada
				Company.set_company_zip_postal_code	_company_zip_postal_code
				Company.set_company_phone _company_phone
				Company.set_company_contact_email _company_contact_email
				#set GST information
				Company.select_tax_country_code $bd_tax_country_code_ca
				Company.set_company_tax_registeration_number _company_tax_reg_number
				#set credit terms
				Company.set_credit_term_description1 _company_description_term
				Company.set_credit_term_days_offset1 "30"
				Company.set_credit_term_discount1 "0.00"
				Company.select_credit_term_base_date1 $bd_company_credit_term_base_date1_invoice_date
				Company.click_save_button
				gen_compare  _company_name_merlin_auto_can, Company.get_company_name ,"TST017670: Expected new company to be created successfully with name  "+ _company_name_merlin_auto_can
				Company.click_activate_button
				#Confirm the company activate process and provide a unique name to  queue.
				t = Time.now
				Company.set_company_queue_name _company_name_merlin_auto_can + t.nsec.to_s
				Company.click_activate_company_button
				gen_compare $ffa_msg_company_activated_successfully, FFA.ffa_get_info_message , "TST017670:Expected successful message for activating company. "
			end
			#Step 1.2
			gen_start_test "TST017670- Step 2: Create user company for new company. "		
			begin
				SF.tab $tab_user_companies
				SF.click_button_new
				USERCOMPANY.set_user_name $bd_user_accountant_profile
				USERCOMPANY.set_company_name _company_name_merlin_auto_can					
				SF.click_button_save
					
				SF.tab $tab_user_companies
				SF.click_button_new 
				USERCOMPANY.set_user_name $bd_user_admin_user
				USERCOMPANY.set_company_name _company_name_merlin_auto_can					
				SF.click_button_save
					
				SF.tab $tab_user_companies
				SF.click_button_new
				USERCOMPANY.set_user_name $bd_user_invoicing_clerk
				USERCOMPANY.set_company_name _company_name_merlin_auto_can					
				SF.click_button_save
				
				SF.tab $tab_user_companies
				SF.click_button_new
				USERCOMPANY.set_user_name $bd_user_payables_clerk_user
				USERCOMPANY.set_company_name _company_name_merlin_auto_can					
				SF.click_button_save
				
				SF.tab $tab_select_company
				gen_compare_has_content _company_name_merlin_auto_can , true , "Expected newly created company to be displayed on Select COmpany Page."
				FFA.select_company [_company_name_merlin_auto_can] ,true
			end
			
			# step 1.3
			begin
				gen_start_test "TST017670- Step 3: Create accounting currency for new company."
				current_year = (Time.now).year
				last_year= current_year - 1
				#create CAD currency as home
				SF.tab $tab_accounting_currencies
				SF.click_button_new
				AccountingCurrency.create _canada_currency ,_canada_currency_value ,"2", true , false
				SF.click_button_save
				gen_compare _canada_currency, AccountingCurrency.get_currency_name , "TST017670: Expected currency to be created successfully with name " +_canada_currency
				# create USD currency as dual
				SF.tab $tab_accounting_currencies
				SF.click_button_new
				AccountingCurrency.create $bd_currency_usd ,_US_currency_value, "2", false , true
				SF.click_button_save
				SF.wait_for_search_button
				gen_compare $bd_currency_usd, AccountingCurrency.get_currency_name , "TST017670: Expected currency to be created successfully with name " +$bd_currency_usd
				AccountingCurrency.click_manage_rates_button
				AccountingCurrency.set_exchange_rate_effective_date "01/01/"+last_year.to_s
				AccountingCurrency.set_exchange_rate "1.23" ,$bd_currency_cad , $bd_currency_usd 
				SF.click_button_save
				SF.wait_for_search_button
			end
			
			# step 1.4
			begin
				gen_start_test "TST017670- Step 4: Create a new account for merlin auto canada."
				SF.tab $tab_accounts
				SF.click_button_new
				# set account info
				Account.set_account_name  _acc_name
				Account.select_account_type $bd_account_type_others
					
				# set account address info
				Account.set_billing_street "500 Muskrat Street"
				Account.set_billing_city "Banff"
				Account.set_billing_state_province "AB"
				Account.set_billing_zip_postal_code "AB T9Z"
				Account.set_billing_country "Canada"
				###
				#  TODO: once Defect AC-6076 resolved will un comment this line
				#  Commenting below line will not cause any issue on script execution and assertions.
				###
				# Account.copy_billing_address_to_shipping_address
				# set Accounting Information
				Account.set_account_reporting_code "CANTEST"
				Account.set_account_trading_currency _canada_currency
				Account.select_account_currency _canada_currency_value
				Account.set_accounts_receivable_control _canada_gla_account_receivable_control_cad
				Account.set_accounts_payable_control _canada_gla_account_payable_control_cad
				# set VAT/GST information
				Account.select_tax_status $bd_account_tax_status_home
				Account.select_tax_county_code $bd_tax_country_code_ca
				Account.select_tax_calculation_method $bd_account_tax_calculation_method_gross
				# credit terms
				Account.set_description_1 "Standard"
				Account.select_base_date_1 $bd_company_credit_term_base_date1_invoice_date
				Account.set_days_offset_1 "30.00"
				Account.set_discount_1 "0.00"
					
				SF.click_button_save
				gen_include _acc_name,Account.get_account_name, "TST017670: Expected account to be created successfully with name as " +_acc_name
			end
				
			# step 1.5
			begin
				gen_start_test "TST017670- Step 5: Create new year and periods for merlin auto canada"
				SF.tab $tab_years
				SF.click_button_new
				# Create current year
				YEAR.set_year_name current_year.to_s
				YEAR.set_start_date  "01/01/"+current_year.to_s
				YEAR.set_year_end_date  "31/12/"+current_year.to_s
				YEAR.set_number_of_periods "12"
				YEAR.select_period_calculation_basis $bd_period_calculation_basis_month_end
				SF.click_button_save
				gen_compare current_year.to_s,YEAR.get_year_name , "TST017670: Expected current year to be created successfully. "
				#calculate periods
				YEAR.click_calculate_periods_button
				gen_include $ffa_msg_calculate_period_confirmation, FFA.ffa_get_info_message , "TST017670: Expected a confirmation message for calculating periods."
				#confirm the process
				YEAR.click_calculate_periods_button
				gen_compare current_year.to_s , YEAR.get_year_name , "TST017670: Expected  periods  to be created successfully for current year. "
			end
			
			# step 1.6
			begin
				gen_start_test "TST017680- Step 6:update GLA of A4 Paper "
				SF.tab $tab_products
				Product.search_product $bd_product_a4_paper
				SF.click_link $bd_product_a4_paper
				SF.wait_for_search_button
				SF.click_button_edit
				
				Product.set_sales_revenue_account _canada_gla_account_receivable_control_cad
				Product.set_purchase_analysis_account _canada_gla_account_payable_control_cad
				SF.click_button_save
				gen_compare_has_content _canada_gla_account_receivable_control_cad , true , "Expected account receivable GLA to be added on product page."
				gen_compare_has_content _canada_gla_account_payable_control_cad , true , "Expected account payable GLA to be added on product page."

				#Add Product standard price
				SF.tab $tab_products
				Product.search_product $bd_product_a4_paper
				SF.click_link $bd_product_a4_paper
				Product.click_add_standard_price_button
				Product.set_standard_price_to_product _prod_standard_price_currency_canada, _standard_price_1001 
				SF.click_button_save
			end
			gen_end_test "TST017670: Create a new Combined type company- Merlin Auto CAN"
		end
		
		begin
			gen_start_test "TST017682: Create Combined/Canadian Tax Codes with Rates for Merlin Auto CAN."
			# step 1.1
			begin
				gen_start_test "TST017682: Create tax codes for new company merlin auto CAN with tax rates. "
				SF.tab $tab_tax_codes
				SF.click_button_new
				# create tax code PST
				Taxcode.set_taxcode_name _tax_code_pst
				Taxcode.set_tax_code_description "Canadian PST"
				Taxcode.set_general_ledger_account _canada_gla_account_receivable_control_cad
				Taxcode.select_tax_model $bd_tax_model_pst_gst
				SF.click_button_save
				gen_compare _tax_code_pst,Taxcode.get_taxcode_name , "TST017682: Expected tax code to be created successfully with name " + _tax_code_pst
				Taxcode.click_new_tax_rate_button
				current_year_first_day_date= "01/01/"+current_year.to_s
				Taxcode.create_new_tax_rate current_year_first_day_date , "5.00" , _tax_code_pst
				SF.click_button_save
				gen_compare _tax_code_pst, Taxcode.get_tax_code_of_tax_rate , "TST017682: Expected tax code for tax rate created to be " +_tax_code_pst
				# create tax code GSTCAN
				SF.tab $tab_tax_codes
				SF.click_button_new
				Taxcode.set_taxcode_name _tax_code_gstcan
				Taxcode.set_tax_code_description "Canadian GST"
				Taxcode.set_general_ledger_account _canada_gla_account_receivable_control_cad
				Taxcode.select_tax_model $bd_tax_model_pst_gst
				SF.click_button_save
				gen_compare _tax_code_gstcan,Taxcode.get_taxcode_name , "TST017682: Expected tax code to be created successfully with name " + _tax_code_gstcan
				Taxcode.click_new_tax_rate_button
				Taxcode.create_new_tax_rate current_year_first_day_date , "10.00" , _tax_code_gstcan
				SF.click_button_save
				gen_compare _tax_code_gstcan, Taxcode.get_tax_code_of_tax_rate , "TST017682: Expected tax code for tax rate created to be " +_tax_code_gstcan
				# create tax code COMBO
				SF.tab $tab_tax_codes
				SF.click_button_new
				Taxcode.set_taxcode_name _tax_code_combo
				Taxcode.set_tax_code_description "Canadian Tax"
				Taxcode.set_general_ledger_account _canada_gla_account_receivable_control_cad
				Taxcode.check_parent_checkbox true
				Taxcode.set_gst_tax_value _tax_code_gstcan
				Taxcode.set_pst_qst_tax_value _tax_code_pst
				Taxcode.select_tax_model $bd_tax_model_pst_gst
				SF.click_button_save
				gen_compare _tax_code_combo,Taxcode.get_taxcode_name , "TST017682: Expected tax code to be created successfully with name " + _tax_code_combo
			end
			gen_end_test "TST017682: Create Combined/Canadian Tax Codes with Rates for Merlin Auto CAN."
		end
		
		begin
			gen_start_test "TST017683: Login as invoicing clerk and Create a new Sales invoice on extended layout and post it."
			# step 1.1			
			begin
				gen_start_test "TST017683:Step 1.1 -Log out and Login as invoicing clerk."
				SF.login_as_user $bd_user_inv_clerk_alias
				#set company for invoicing clerk
				SF.tab $tab_select_company
				FFA.select_company [_company_name_merlin_auto_can] ,true
			end
			# step 1.2
			begin
				gen_start_test "TST017683:Step 1.2 - Create new sales invoice with one line item and post it."
				SF.tab $tab_sales_invoices
				SF.click_button_new
				SINX.set_account _acc_name
				SINX.set_invoice_date current_year_first_day_date
				SF.click_button_save
				invoice_number = SINX.get_invoice_number
				SINX.click_new_sales_invoice_line_items_button
				SINX.set_product_name $bd_product_a4_paper
				SINX.set_product_quantity "1.00"
				SINX.set_unit_price_for_line "100"
				SINX.check_derive_unti_price_from_product_checkbox false
				SINX.set_combined_tax_code_for_line _tax_code_combo 
				SF.click_button_save
				SF.tab $tab_sales_invoices
				SINX.open_invoice_detail_page invoice_number
				page.has_text?(invoice_number)
				SINX.click_post_button
				SINX.click_post_invoice
				gen_compare _total_amount_115,SINX.get_invoice_total , "TST017683: Expected invoice total to be " + _total_amount_115
				gen_include  $bd_document_status_complete ,SINX.get_invoice_status, "TST017683: Expected Invoice status to be Complete."
				# click Print PDF button
				new_window_pdf = window_opened_by do
					SINX.click_print_pdf_button
				end
				gen_wait_less # It takes some time to launch separate window to display the preview of PDF.
				within_window (new_window_pdf) do
					page.has_text?("$5.00")
					expect(page).to have_content("$5.00")
					gen_report_test "Expected PDF file to have $5.00 "
					expect(page).to have_content("$10.00")
					gen_report_test "Expected PDF file to have $10.00 "
					expect(page).to have_content("5.000%")
					gen_report_test "Expected PDF file to have 5.000%"
					expect(page).to have_content("10.000%")
					gen_report_test "Expected PDF file to have 10.000%"
					expect(page).to have_content("$15.00")
					gen_report_test "Expected PDF file to have $15.00%"
					page.current_window.close
				end
				SF.tab $tab_sales_invoices
				SINX.open_invoice_detail_page invoice_number
				SINX.view_invoice_line_item_detail_page $bd_product_a4_paper
				gen_compare _tax_code_combo, SINX.get_line_combined_tax_code_value, "TST017683: Expected Invoice line item combined tax code to be " + _tax_code_combo
				# assert tax code
				gen_compare _tax_code_gstcan, SINX.get_line_tax_code_value , "TST017683: Expected invoice line item tax code value to be: " +_tax_code_gstcan
				gen_compare _tax_code_pst, SINX.get_line_tax_code2_value , "TST017683: Expected invoice line item tax code 2 value to be: " +_tax_code_pst
				# assert tax value
				gen_compare "10.00" , SINX.get_line_taxvalue_value , "TST017683: Expected invoice line item tax-value  value to be: 100.10"
				gen_compare "5.00" , SINX.get_line_taxvalue2_value , "TST017683: Expected invoice line item tax-value2  value to be: 50.05"
				# assert tax rate
				gen_compare "10.000" ,SINX.get_line_tax_rate_value , "TST017683: Expected invoice line item tax-rate  value to be: 10.000"
				gen_compare "5.000" ,SINX.get_line_tax_rate2_value , "TST017683: Expected invoice line item tax-rate2  value to be: 5.000"
			end
		end	
			
		begin
			gen_start_test " TST017685: Convert invoice into credit note and assert credit note details."
			# step 1.1 
			SF.click_link invoice_number
			page.has_text?(invoice_number)
			SINX.convert_to_credit_note
			# confirm the action
			SINX.convert_to_credit_note_confirm
			# Asset Credit note details
			gen_compare invoice_number, SCRX.get_invoice_number , "TST017685: Expected invoice number on credit note page to be " +invoice_number
			gen_compare $bd_document_status_in_progress, SCRX.get_credit_note_status , "TST017685: Expected invoice number on credit note page to be "+ $bd_document_status_in_progress
			gen_compare _acc_name, SCRX.get_account_name , "TST017685: Expected invoice number on credit note page to be "+ _acc_name
			gen_compare _canada_currency, SCRX.get_credit_note_currency , "TST017685: Expected credit note currency to be "+ _canada_currency
			gen_compare _total_amount_115, SCRX.get_credit_note_total , "TST017685: Expected credit note currency to be "+ _total_amount_115
			# Assert line items
			SCRX.click_credit_note_line_item_id $bd_product_a4_paper
			gen_compare $bd_product_a4_paper,SCRX.line_get_product_name , "TST017685: Expected product name of line to be " + $bd_product_a4_paper
			gen_compare "100.00",  SCRX.line_get_net_value ,"TST017685: Expected line net value to be 100.00"
			line_quantity = SCRX.line_get_quantity
			gen_compare 1, line_quantity.to_i, "TST017685: Expected Quantity of line to be 1."
			SF.logout
		end
		
		begin
			gen_start_test " TST028227: Create a new payable invoice on extended layout and convert it into payable credit note as payable clerk user."
			SF.login_as_user $bd_user_payable_clerk_alias
			SF.tab $tab_select_company
			FFA.select_company [_company_name_merlin_auto_can] ,true

			SF.tab $tab_payable_invoices
			SF.click_button_new			
			PINEXT.set_account _acc_name
			PINEXT.set_vendor_invoice_number "Vend12345"
			SF.click_button_save
			
			payable_invoice_number = PINEXT.get_invoice_number	
			PINEXT.click_manage_product_lines_button
			PINEXT.manage_product_line_set_product _line_1, $bd_product_a4_paper
			PINEXT.manage_line_set_combined_tax_code _line_1, _tax_code_combo
			SF.click_button_save
			gen_wait_until_object_disappear $ffa_manage_lines_saving_locator
			PINEXT.click_payable_inv_number_link payable_invoice_number
			PINEXT.click_manage_expense_lines_button
			PINEXT.manage_expense_line_set_gla _line_1, _canada_gla_account_payable_control_cad
			PINEXT.manage_line_set_combined_tax_code _line_1, _tax_code_combo
			PINEXT.manage_expense_line_set_net_value _line_1, _net_value_100_00
			SF.click_button_save		
			gen_wait_until_object_disappear $ffa_manage_lines_saving_locator
			PINEXT.click_payable_inv_number_link payable_invoice_number
			page.has_text?(payable_invoice_number)
			FFA.click_post
			FFA.click_post # confirm post operation
			PINEXT.click_payable_inv_number_link payable_invoice_number
			#Assert invoice details Expected result-6.01 
			gen_compare _net_total_1101_00, PINEXT.get_net_total , "TST028227: net total value Expected " +_net_total_1101_00
			gen_compare _tax_total_165_15, PINEXT.get_tax_total , "TST028227: tax total value Expected " +_tax_total_165_15
			gen_compare _invoice_total_1266_15, PINEXT.get_invoice_total , "TST028227: invoice total Expected " +_invoice_total_1266_15
			
			#convert to credit note		
			PINEXT.click_payable_inv_number_link payable_invoice_number
			PINEXT.convert_to_credit_note
			PCR.set_vendor_credit_note_number_convert _vendor_credit_note_number
			# confirm the action
			PINEXT.convert_to_credit_note_confirm
			# Assert Credit note details
			gen_compare _net_total_1101_00, PCREXT.get_net_total , "TST017685: Expected net total on credit note page to be "+ _net_total_1101_00
			gen_compare _tax_total_165_15, PCREXT.get_tax_total , "TST017685: Expected tax total on credit note page to be "+ _tax_total_165_15
		end		
	end
	after :all do
		login_user
		#Delete Test Data
		FFA.delete_new_data_and_wait
		# Change the GLA of A4 paper to original one.
		SF.tab $tab_products
		Product.search_product $bd_product_a4_paper
		SF.click_link $bd_product_a4_paper
		SF.click_button $sf_edit_button
		Product.set_sales_revenue_account $bd_gla_sales_parts
		Product.set_purchase_analysis_account $bd_gla_postage_and_stationery
		SF.click_button_save
		# Changing the layout of invoice,credit note and line items again to normal layout
		SF.edit_extended_layout $ffa_object_sales_invoice, $ffa_profile_standard_user, $ffa_sales_invoice_normal_layout
		SF.edit_extended_layout $ffa_object_sales_credit_note, $ffa_profile_standard_user, $ffa_sales_credit_note_normal_layout
		SF.edit_extended_layout $ffa_object_sales_invoice_line_item, $ffa_profile_standard_user, $ffa_sales_invoice_line_item_normal_layout
		SF.edit_extended_layout $ffa_object_sales_credit_note_line_item, $ffa_profile_standard_user, $ffa_sales_credit_note_line_items_normal_layout
		SF.edit_extended_layout $ffa_object_payable_invoice, $ffa_profile_standard_user, $ffa_purchase_invoice_layout
		SF.edit_extended_layout $ffa_object_payable_credit_note, $ffa_profile_standard_user, $ffa_purchase_credit_note_layout
		SF.edit_extended_layout $ffa_object_payable_invoice_line_item, $ffa_profile_standard_user, $ffa_purchase_invoice_line_item_layout
		SF.edit_extended_layout $ffa_object_payable_credit_note_line_item, $ffa_profile_standard_user, $ffa_purchase_credit_note_line_item_layout
		
		# changing button properties to normal
		SF.object_button_edit $ffa_object_sales_invoice, $sf_new_button
		SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_invoice_new
		
		SF.object_button_edit $ffa_object_sales_invoice, $sf_edit_button
		SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_invoice_edit
		
		SF.object_button_edit $ffa_object_sales_invoice, $sf_view_button
		SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_invoice_view
		
		SF.object_button_edit $ffa_object_sales_credit_note, $sf_new_button
		SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_creditnote_new
		
		SF.object_button_edit $ffa_object_sales_credit_note, $sf_edit_button
		SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_creditnote_edit
		
		SF.object_button_edit $ffa_object_sales_credit_note, $sf_view_button
		SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_creditnote_view
	
		SF.object_button_edit $ffa_object_payable_invoice, $sf_new_button
		SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_purchase_invoice_new
		
		SF.object_button_edit $ffa_object_payable_invoice, $sf_edit_button
		SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_purchase_invoice_edit
		
		SF.object_button_edit $ffa_object_payable_invoice, $sf_view_button
		SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_purchase_invoice_view
		
		SF.object_button_edit $ffa_object_payable_credit_note, $sf_new_button
		SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_payable_credit_note_new
		
		SF.object_button_edit $ffa_object_payable_credit_note, $sf_edit_button
		SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_payable_credit_note_edit
		
		SF.object_button_edit $ffa_object_payable_credit_note, $sf_view_button
		SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_payable_credit_note_view
		
		gen_end_test "TID013645"
		SF.logout 
	end
end	
	