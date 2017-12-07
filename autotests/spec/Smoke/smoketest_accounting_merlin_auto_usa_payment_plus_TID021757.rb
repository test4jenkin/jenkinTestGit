#--------------------------------------------------------------------#
#	TID : TID021757
# 	Pre-Requisite : Smoke Test Setup
#  	Product Area: Merlin Auto USA- Payment Plus Smoke
# 	Story:  AC-12527
#	ERP Package Installed(Mandatory)
# #--------------------------------------------------------------------#

describe "TID021757-Smoke Test:Merlin Auto USA- Payment Plus", :type => :request do
include_context "login"
include_context "logout_after_each"
	_vendor_inv1_number = "P_PIN1"
	_vendor_credit_note1_number ="P_PCR1"
	_vendor_inv2_number = "P_PIN2"
	_vendor_credit_note2_number ="P_PCR2"
	_vendor_inv3_number = "P_PIN3"
	_vendor_inv4_number ="P_PIN4"
	_pin1_due_date = nil
	_pin2_due_date = nil
	_pin3_due_date = nil
	_pin4_due_date = nil
	_pcr1_due_date = nil
	_pcr2_due_date = nil
	_line_price_149 = "149.00"
	_line_price_300 = "300.00"
	_line_price_200 = "200.00"
	_account_label = "Account"
	_pay_template_name = "Template1"
	on_hold_pin = nil
	payment_name = nil
	_current_date = Date.today.strftime("%d/%m/%Y")
	before :all do
		$locale = gen_get_current_user_locale
		#Delete any existing custom setting
		delete_acc_setting = "delete [select id from #{ORG_PREFIX}codaAccountingSettings__c ];"
		APEX.execute_commands [delete_acc_setting]
		#Add accounting setting
		custom_setting = "#{ORG_PREFIX}codaAccountingSettings__c setting = new #{ORG_PREFIX}codaAccountingSettings__c(#{ORG_PREFIX}GLAFilteringInPaymentSelection__c = 'NO FILTERING');"
		custom_setting += "INSERT setting;"
		APEX.execute_commands [custom_setting]
		#Hold Base Data
		gen_start_test "TID021757"
		FFA.hold_base_data_and_wait
		# select Company
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_usa] ,true

		# Create PIN,PCR Document with BMW autombile account for Payment
		SF.tab $tab_payable_invoices
		SF.click_button_new
		PIN.set_account $bd_account_bmw_automobiles
		PIN.change_invoice_currency $bd_currency_eur
		PIN.set_vendor_invoice_number _vendor_inv1_number
		PIN.set_vendor_invoice_total _line_price_149
		# Add Product Line 
		PIN.set_product_name $bd_product_auto_com_clutch_kit_1989_dodge_raider
		PIN.click_product_new_line
		PIN.set_product_line_quantity 1, 1
		PIN.set_product_line_unit_price 1, _line_price_149
		# Post the Payable Invoice
		FFA.click_save_post
		gen_compare $bd_document_status_complete , PIN.get_invoice_status , "TID021757 Setup: Expected Payable Invoice status to be complete. "
		_pin1_due_date = PIN.get_pin_due_date
		#Payable Credit Note
		SF.tab $tab_payable_credit_notes
		SF.click_button_new
		PCR.set_account $bd_account_bmw_automobiles
		PCR.change_credit_note_currency $bd_currency_eur
		PCR.set_vendor_credit_note_number _vendor_credit_note1_number
		PCR.set_vendor_credit_note_total _line_price_149
		# Add Product Line
		PCR.set_product_name $bd_product_auto_com_clutch_kit_1989_dodge_raider
		PCR.click_product_new_line
		PCR.set_product_line_quantity 1, 1
		PCR.set_product_line_unit_price 1, _line_price_149
		# Post the Payable credit note
		FFA.click_save_post
		gen_compare $bd_document_status_complete , PCR.get_credit_note_status , "TST017169: Expected Payable credit note status to be complete. "
		_pcr1_due_date = PCR.get_pcr_due_date
		# Create PIN,PCR Document with Audi account for Payment
		SF.tab $tab_payable_invoices
		SF.click_button_new
		PIN.set_account $bd_account_audi
		PIN.change_invoice_currency $bd_currency_eur
		PIN.set_vendor_invoice_number _vendor_inv2_number
		PIN.set_vendor_invoice_total _line_price_300
		# Add Product Line 
		PIN.set_product_name $bd_product_auto_com_clutch_kit_1989_dodge_raider
		PIN.click_product_new_line
		PIN.set_product_line_quantity 1, 1
		PIN.set_product_line_unit_price 1, _line_price_300
		# Post the Payable Invoice
		FFA.click_save_post
		gen_compare $bd_document_status_complete , PIN.get_invoice_status , "TID021757 Setup: Expected Payable Invoice status to be complete. "
		_pin2_due_date = PIN.get_pin_due_date
		# Payable Credit Note
		SF.tab $tab_payable_credit_notes
		SF.click_button_new
		PCR.set_account $bd_account_audi
		PCR.change_credit_note_currency $bd_currency_eur
		PCR.set_vendor_credit_note_number _vendor_credit_note2_number
		PCR.set_vendor_credit_note_total _line_price_149
		# Add Product Line
		PCR.set_product_name $bd_product_auto_com_clutch_kit_1989_dodge_raider
		PCR.click_product_new_line
		PCR.set_product_line_quantity 1, 1
		PCR.set_product_line_unit_price 1, _line_price_149
		# Post the Payable credit note
		FFA.click_save_post
		gen_compare $bd_document_status_complete , PCR.get_credit_note_status , "TST017169: Expected Payable credit note status to be complete. "
		_pcr2_due_date = PCR.get_pcr_due_date
		# Create PIN Document with Mercedes-Benz Inc account for Payment
		SF.tab $tab_payable_invoices
		SF.click_button_new
		PIN.set_account $bd_account_mercedes_benz_inc
		PIN.change_invoice_currency $bd_currency_eur
		PIN.set_vendor_invoice_number _vendor_inv3_number
		PIN.set_vendor_invoice_total _line_price_149
		# Add Product Line 
		PIN.set_product_name $bd_product_auto_com_clutch_kit_1989_dodge_raider
		PIN.click_product_new_line
		PIN.set_product_line_quantity 1, 1
		PIN.set_product_line_unit_price 1, _line_price_149
		# Post the Payable Invoice
		FFA.click_save_post
		gen_compare $bd_document_status_complete , PIN.get_invoice_status , "TID021757 Setup: Expected Payable Invoice status to be complete. "
		_pin3_due_date = PIN.get_pin_due_date
		# Create PIN Document with Mercedes-Benz Inc account and place on hold.
		SF.tab $tab_payable_invoices
		SF.click_button_new
		PIN.set_account $bd_account_mercedes_benz_inc
		PIN.change_invoice_currency $bd_currency_eur
		PIN.set_vendor_invoice_number _vendor_inv4_number
		PIN.set_vendor_invoice_total _line_price_200
		# Add Product Line 
		PIN.set_product_name $bd_product_auto_com_clutch_kit_1989_dodge_raider
		PIN.click_product_new_line
		PIN.set_product_line_quantity 1, 1
		PIN.set_product_line_unit_price 1, _line_price_200
		# Post the Payable Invoice
		FFA.click_save_post
		on_hold_pin = PIN.get_invoice_number
		_pin4_due_date = PIN.get_pin_due_date
		gen_compare $bd_document_status_complete , PIN.get_invoice_status , "TID021757 Setup: Expected Payable Invoice status to be complete. "
		SF.click_button $ffa_place_on_hold_button
		
		# Add check range for bank account- Bristol Euros Account.
		_command_to_create_check_range= ""
		_command_to_create_check_range  +="#{ORG_PREFIX}codaBankAccount__c bankId = [ select Id from #{ORG_PREFIX}codaBankAccount__c where Name = '#{$bd_bank_account_bristol_euros_account}'];"
		_command_to_create_check_range  +="#{ORG_PREFIX}codaCheckRange__c chkRange = new #{ORG_PREFIX}codaCheckRange__c();"
		_command_to_create_check_range  +="chkRange.#{ORG_PREFIX}BankAccount__c = bankId.Id;"
		_command_to_create_check_range  +="chkRange.#{ORG_PREFIX}CheckRangeName__c = 'CHR001';"
		_command_to_create_check_range  +="chkRange.#{ORG_PREFIX}Activated__c =  true;"
		_command_to_create_check_range  +="chkRange.#{ORG_PREFIX}StartCheckNumber__c = '1';"
		_command_to_create_check_range  +="chkRange.#{ORG_PREFIX}LastCheckNumber__c ='100';"
		_command_to_create_check_range  +="insert  chkRange;"
		# Execute command
		APEX.execute_script _command_to_create_check_range
		gen_include $apex_script_executed_successfully_message_value ,APEX.get_execution_status_message, "Expected- successful Apex script execution."	
	end

	it "TID021757-TST038632: Create a Payment plus and add transactin to proposal, Review the proposal and create a template for it." do
		gen_start_test "TST038632"
		begin
			SF.tab $tab_new_payment
			gen_wait_until_object_disappear $page_loadmask_message
			page.has_css?($newpay_detail_payment_date)
			NEWPAY.set_payment_date _current_date
			NEWPAY.set_bank_account $bd_bank_account_bristol_euros_account
			NEWPAY.set_payment_media $bd_payment_method_check
			NEWPAY.set_settlement_discount $bd_gla_settlement_discounts_allowed_us
			NEWPAY.click_sett_disc_dim_button
			NEWPAY.set_settlement_discount_dim1 $bd_dim1_eur
			NEWPAY.set_settlement_discount_dim2 $bd_dim2_eur
			NEWPAY.set_settlement_discount_dim3 $bd_dim3_eur
			NEWPAY.set_settlement_discount_dim4 $bd_dim4_eur
			NEWPAY.set_currency_write_off $bd_gla_write_off_us
			NEWPAY.click_writeoff_dim_button
			NEWPAY.set_currency_write_off_dim1 $bd_dim1_usd
			NEWPAY.set_currency_write_off_dim2 $bd_dim2_usd
			NEWPAY.set_currency_write_off_dim3 $bd_dim3_usd
			NEWPAY.set_currency_write_off_dim4 $bd_dim4_usd
			
			NEWPAY.click_next_button
			gen_wait_until_object $newpay_selecttransactions_retrieveTransButton_dataffid_access
			#Assert
			gen_compare(_current_date, NEWPAY.get_proposal_payment_date_value, $newpay_assert_output_text)
			gen_compare($bd_bank_account_bristol_euros_account, NEWPAY.get_proposal_payment_bank_account_value, $newpay_assert_output_text)
			gen_compare($bd_currency_eur, NEWPAY.get_proposal_payment_currency_value, $newpay_assert_output_text)
			gen_compare($bd_payment_method_check, NEWPAY.get_proposal_payment_media_value, $newpay_assert_output_text)
			gen_compare($bd_gla_settlement_discounts_allowed_us, NEWPAY.get_proposal_settlement_discount_value, $newpay_assert_output_text)
			gen_compare($bd_gla_write_off_us , NEWPAY.get_proposal_currency_write_off_value, $newpay_assert_output_text)
			gen_compare($label_newpayment_settlement_discount_dim1 + ": " + $bd_dim1_eur +
						$label_newpayment_settlement_discount_dim2 + ": " + $bd_dim2_eur +
						$label_newpayment_settlement_discount_dim3 + ": " + $bd_dim3_eur +
						$label_newpayment_settlement_discount_dim4 + ": " + $bd_dim4_eur, 
						NEWPAY.get_proposal_settlement_discount_dimensions_value, $newpay_assert_output_text)

			gen_compare($label_newpayment_write_off_dim1 + ": " + $bd_dim1_usd +
						$label_newpayment_write_off_dim2 + ": " + $bd_dim2_usd +
						$label_newpayment_write_off_dim3 + ": " + $bd_dim3_usd +
						$label_newpayment_write_off_dim4 + ": " + $bd_dim4_usd,
						NEWPAY.get_proposal_currency_write_off_dimensions_value, $newpay_assert_output_text)
			_payment_name = NEWPAY.get_payment_name
			#click back and verify that user is at home page
			NEWPAY.click_back_button
			#Verify that date, currency fields are enabled
			gen_get_element_style_property $newpay_detail_payment_date , "enabled"
			gen_get_element_style_property $newpay_detail_payment_currency , "enabled"
		end
		gen_end_test "TST038632"
		begin
			gen_start_test "TST038633"
			SF.tab $tab_payments
			SF.select_view $bd_select_view_all
			SF.click_button_go
			SF.click_link _payment_name
			SF.wait_for_search_button
			page.has_css?($newpay_selecttrans_retrieve_transactions_button)
			gen_compare_object_visible $newpay_selecttrans_retrieve_transactions_button , true , "Expected retrieve transaction button to be enabled."
			gen_report_test "Payment Page is opened successfully on select transactions tab of payment."
			puts "- Retrieving transaction according to the provided details and filters."
			expected_transactions_data1=[	['Account: Audi'],
			['PIN','P_PIN2','TRN',_pin2_due_date.to_s,gen_locale_format_number(0.00),gen_locale_format_number(300.00), gen_locale_format_number(0.00)],
			['PCR','P_PCR2','TRN',_pcr2_due_date.to_s,gen_locale_format_number(0.00),gen_locale_format_number(-149.00), gen_locale_format_number(0.00)],
			['','','','','',gen_locale_format_number(0.00),gen_locale_format_number(151.00), gen_locale_format_number(0.00)],
			['Account: BMW Automobiles'],
			['PIN','P_PIN1','TRN',_pin1_due_date.to_s,gen_locale_format_number(7.45),gen_locale_format_number(149.00),gen_locale_format_number(0.00)],
			['PCR','P_PCR1','TRN',_pcr1_due_date.to_s,gen_locale_format_number(-7.45),gen_locale_format_number(-149.00), gen_locale_format_number(0.00)],
			['','','','','',gen_locale_format_number(0.00),gen_locale_format_number(0.00), gen_locale_format_number(0.00)],
			['Account: Mercedes-Benz Inc'],
			['PIN','P_PIN3','TRN',_pin3_due_date.to_s,gen_locale_format_number(7.45),gen_locale_format_number(149.00), gen_locale_format_number(0.00)],
			['PIN','P_PIN4','TRN',_pin4_due_date.to_s,gen_locale_format_number(10.00),gen_locale_format_number(200.00), gen_locale_format_number(0.00)],
			['','','','','',gen_locale_format_number(0.00),gen_locale_format_number(17.45), gen_locale_format_number(349.00)]]
			
			expected_transactions_data2=[	['Account: Audi'],
			['PIN','P_PIN2','TRN',_pin2_due_date.to_s,gen_locale_format_number(0.00),gen_locale_format_number(300.00), gen_locale_format_number(0.00)],
			['PCR','P_PCR2','TRN',_pcr2_due_date.to_s,gen_locale_format_number(0.00),gen_locale_format_number(-149.00), gen_locale_format_number(0.00)],
			['','','','','',gen_locale_format_number(0.00),gen_locale_format_number(151.00), gen_locale_format_number(0.00)],
			['Account: BMW Automobiles'],
			['PIN','P_PIN1','TRN',_pin1_due_date.to_s,gen_locale_format_number(7.45),gen_locale_format_number(149.00),gen_locale_format_number(0.00)],
			['PCR','P_PCR1','TRN',_pcr1_due_date.to_s,gen_locale_format_number(-7.45),gen_locale_format_number(-149.00), gen_locale_format_number(0.00)],
			['','','','','',gen_locale_format_number(0.00),gen_locale_format_number(0.00), gen_locale_format_number(0.00)],
			['Account: Mercedes-Benz Inc'],
			['PIN','P_PIN4','TRN',_pin4_due_date.to_s,gen_locale_format_number(10.00),gen_locale_format_number(200.00), gen_locale_format_number(0.00)],
			['PIN','P_PIN3','TRN',_pin3_due_date.to_s,gen_locale_format_number(7.45),gen_locale_format_number(149.00), gen_locale_format_number(0.00)],
			['','','','','',gen_locale_format_number(0.00),gen_locale_format_number(17.45), gen_locale_format_number(349.00)]]
			#retrieve transactions
			page.has_text?(_payment_name)
			NEWPAY.click_retrieve_trans_button
			rows_retrieved1 = NEWPAY.assert_retrieved_rows? expected_transactions_data1
			rows_retrieved2 = NEWPAY.assert_retrieved_rows? expected_transactions_data2
			if (rows_retrieved1 or rows_retrieved2)
				gen_report_test "Rows matched successfully."
			else
				raise "Mismatch in Rows retrieved."
			end 
			#expect(NEWPAY.assert_retrieved_rows? expected_transactions).to eq(true)
			gen_report_test "Retrieved Transaction operation is successfull for #{payment_name}."
			gen_compare_object_visible $newpay_selecttransactions_on_hold_document_pattern.sub($sf_param_substitute,on_hold_pin) , true , "#{on_hold_pin} is displayed with a padlock as it is on Hold status."
			
			gen_assert_disabled $newpay_selecttrans_add_to_proposal_button
			NEWPAY.select_header_checkbox
			gen_assert_enabled $newpay_selecttrans_add_to_proposal_button
			NEWPAY.click_add_to_proposal_button
			
			#Assert
			payment_value_str = 'EUR ' + gen_locale_format_number(292.55)
			gen_compare(payment_value_str, NEWPAY.get_proposal_total_value, $newpay_assert_output_text)
			gen_compare('5', NEWPAY.get_proposal_document_proposed_value, $newpay_assert_output_text)
			gen_compare('3', NEWPAY.get_proposal_vendors_proposed_value, $newpay_assert_output_text)
			gen_compare('PROPOSED', NEWPAY.get_proposal_status_value, $newpay_assert_output_text)
			payment_discount_total_str = 'Discount Total: EUR ' + gen_locale_format_number(7.45)
			gen_compare(payment_discount_total_str, NEWPAY.get_proposal_discount_total_value, $newpay_assert_output_text)
			gen_assert_enabled $newpay_detail_button_next
			gen_report_test "Next Button is enabled."
			#click back and verify that user is at home page
			NEWPAY.click_back_button
			#Verify that date, currency fields are enabled
			gen_get_element_style_property $newpay_detail_payment_date , "enabled"
			gen_get_element_style_property $newpay_detail_payment_currency , "enabled"
			gen_end_test "TST038633"
		end
		
		begin
			gen_start_test "TST038634"
			SF.tab $tab_payments
			SF.select_view $bd_select_view_all
			SF.click_link _payment_name
			gen_wait_until_object_disappear $page_loadmask_message
			gen_compare_object_visible $newpay_review_prepare_check_button, true, "Expected Clone button present on UI"
			gen_report_test "Review page of payment is opened."
			# Edit proposal
			NEWPAY.click_edit_proposal
			expect(page).to have_selector(:xpath, $newpay_review_edit_proposal_checked_on)
			gen_compare_object_visible $newpay_selecttransactions_transaction_checkbox, true, "Expected checkboxes are displayed"
			gen_compare_object_visible $newpay_review_bottom_panel_remove_from_proposal, true, "Expected bottom panel (Remove from proposal) is displayed"
			gen_assert_disabled $newpay_review_remove_from_proposal_button
			NEWPAY.select_lines_review_grid [_vendor_credit_note2_number]
			NEWPAY.click_remove_from_proposal_button
			#Assert
			payment_value_str = 'EUR ' + gen_locale_format_number(441.55)
			gen_compare(payment_value_str, NEWPAY.get_proposal_total_value, $newpay_assert_output_text)
			gen_compare('4', NEWPAY.get_proposal_document_proposed_value, $newpay_assert_output_text)
			gen_compare('3', NEWPAY.get_proposal_vendors_proposed_value, $newpay_assert_output_text)
			gen_compare($newpay_status_proposed, NEWPAY.get_proposal_status_value, $newpay_assert_output_text)
			payment_discount_total_str = 'Discount Total: EUR ' + gen_locale_format_number(7.45)
			gen_compare(payment_discount_total_str, NEWPAY.get_proposal_discount_total_value, $newpay_assert_output_text)
			#Prepare check
			NEWPAY.click_prepare_check_button
			NEWPAY.click_confirm_prepare_check_button
			page.has_text?($bd_account_audi)
			gen_compare($newpay_status_media_prepared, NEWPAY.get_proposal_status_value, $newpay_assert_output_text)
			expected_check_numbers_proposal=[[$bd_account_audi,gen_locale_format_number(300.00),'000001'],
			[$bd_account_mercedes_benz_inc,gen_locale_format_number(141.55),'000002'],
			[$bd_account_bmw_automobiles,gen_locale_format_number(0.00),'']]

			expect(NEWPAY.assert_retrieved_check_numbers? expected_check_numbers_proposal).to eq(true)
			gen_report_test "TST038634: Expected check number for accounts to be displayed."
			NEWPAY.overwrite_check_number $bd_account_audi,3
			gen_assert_enabled $newpay_detail_button_next
			gen_report_test "Check overwritten successfully."
			NEWPAY.assert_present_void_checks [1]
			gen_report_test "One checks are voided."
			NEWPAY.click_renumber_down $bd_account_audi
			NEWPAY.assert_present_void_checks [2]
			gen_report_test "Two checks are voided."
			NEWPAY.collapse_void_checks
			#Assert new check ranges
			expected_check_numbers_proposal=[[$bd_account_audi,gen_locale_format_number(300.00),'000003'],
			[$bd_account_mercedes_benz_inc,gen_locale_format_number(141.55),'000004'],
			[$bd_account_bmw_automobiles,gen_locale_format_number(0.00),'']]

			expect(NEWPAY.assert_retrieved_check_numbers? expected_check_numbers_proposal).to eq(true)
			gen_report_test "TST038634: Expected check number for accounts to be displayed as per renumbering."
			# manual check
			NEWPAY.expand_void_checks
			NEWPAY.click_manual_check 2
			NEWPAY.assert_present_void_checks [1]
			gen_report_test "One checks is voided and other is marked as manual."
			NEWPAY.click_post_match_button
			# Sometimes the post and match progress window takes a lot of time to disappear.
			# If window is not disappeared within allotted time, gen_wait_until_object_disappear throws error.
			# So adding the retry script block to allot extra time to wait for an object.
			SF.retry_script_block do 
				gen_wait_until_object_disappear $newpay_progress_window
			end
			gen_wait_until_object $newpay_summary_postandmatch_success_msg
			gen_compare($newpay_status_matched, NEWPAY.get_proposal_status_value, $newpay_assert_output_text)
			NEWPAY.click_document_column_header $newpay_summary_proposed_account_header_column
			 
			##Assert the Account and matched documents summary
			expected_values_extended=[['Audi', '000003', gen_locale_format_number(0.00), gen_locale_format_number(300.00)],
			['PIN', 'P_PIN2', 'TRN', _pin2_due_date.to_s, gen_locale_format_number(0.00), gen_locale_format_number(300)],
			['BMW Automobiles', '', gen_locale_format_number(0.00), gen_locale_format_number(0.00)],
			['PIN', 'P_PIN1', 'TRN', _pin1_due_date.to_s, gen_locale_format_number(7.45), gen_locale_format_number(141.55)],
			['PCR', 'P_PCR1', 'TRN', _pcr1_due_date.to_s, gen_locale_format_number(-7.45), gen_locale_format_number(-141.55)],
			[$bd_account_mercedes_benz_inc, '000004', gen_locale_format_number(7.45), gen_locale_format_number(141.55)],
			['PIN', 'P_PIN3', 'TRN', _pin3_due_date.to_s, gen_locale_format_number(7.45), gen_locale_format_number(141.55)]]
			expect(NEWPAY.assert_summary_lines_extended expected_values_extended).to eq(true)
			gen_report_test "Transaction Extended values are matched."
			expected_check_numbers =['CheckNumber__c~||~000001,Name~||~,PaymentValue__c~||~,Status__c~||~Void', 
			'CheckNumber__c~||~000002,Name~||~,PaymentValue__c~||~,Status__c~||~Void', 
			'CheckNumber__c~||~000003,Name~||~Audi,PaymentValue__c~||~-300.0,Status__c~||~Valid',
			'CheckNumber__c~||~000004,Name~||~Mercedes-Benz Inc,PaymentValue__c~||~-141.55,Status__c~||~Valid']
			_field_values = NEWPAY.get_check_number_from_check_range "CHR001"
			expected_check_numbers.eql? _field_values
			_next_check_num_query = "Select #{ORG_PREFIX}NextCheckNumber__c from #{ORG_PREFIX}codaCheckRange__c where #{ORG_PREFIX}CheckRangeName__c='CHR001'"
			APEX.execute_soql _next_check_num_query
			check_num = APEX.get_field_value_from_soql_result "#{ORG_PREFIX}NextCheckNumber__c"
			gen_compare "000005",check_num,"Expected check number updated as #{check_num}"
			# Expected cash entry to be created for Account Audi and Mercedes-Benz Inc

			SF.tab $tab_cash_entries
			SF.select_view $bd_select_view_all
			SF.click_button_go
			SF.edit_list_view $bd_select_view_all, _account_label, 5
			audi_cash_entry = FFA.get_column_value_in_grid _account_label , $bd_account_audi , $label_cashentry_number
			mercedez_cash_entry = FFA.get_column_value_in_grid _account_label , $bd_account_mercedes_benz_inc , $label_cashentry_number
			gen_include "CSH" , audi_cash_entry , "Cash Entry #{audi_cash_entry} for Audi to be created successfully."
			gen_include "CSH" , mercedez_cash_entry , "Cash Entry #{mercedez_cash_entry} for #{$bd_account_mercedes_benz_inc} to be created successfully."
			expected_matchingstatus_tlis =["MatchingStatus__c~||~#{ORG_PREFIX}Matched", "MatchingStatus__c~||~#{ORG_PREFIX}Matched","MatchingStatus__c~||~#{ORG_PREFIX}Matched", "MatchingStatus__c~||~#{ORG_PREFIX}Matched"]
			puts "Verify that transaction line items matching status have updated to Matched"
			_field_values = NEWPAY.get_matchingStatus_from_transactionlineitem _payment_name
			expect(_field_values).to eq(expected_matchingstatus_tlis)
			gen_report_test "Matching Status for all Trx line items under #{_payment_name} should be Matched."
			gen_end_test "TST038634"
		end
	end
	
	it "TID021757-TST038635: Create a template and assert in payment plus. " do
		begin
			login_user
			SF.tab $tab_payment_detail_templates
			SF.click_button_new
			gen_start_test "TST038635"
			PAYTEMPLATE.set_template_name _pay_template_name
			PAYTEMPLATE.set_bank_acc_name $bd_bank_account_bristol_deposit_account
			PAYTEMPLATE.set_template_currency $bd_currency_eur,$company_merlin_auto_usa
			PAYTEMPLATE.check_default_checkbox
			PAYTEMPLATE.select_payment_media $bd_payment_method_check
			
			PAYTEMPLATE.set_settlement_discount_gla $bd_gla_settlement_discounts_allowed_us
			PAYTEMPLATE.set_settlement_discount_dim1 $bd_dim1_usd
			PAYTEMPLATE.set_settlement_discount_dim2 $bd_dim2_usd
			PAYTEMPLATE.set_settlement_discount_dim3 $bd_dim3_usd
			PAYTEMPLATE.set_settlement_discount_dim4 $bd_dim4_usd
			PAYTEMPLATE.set_curr_write_off_gla $bd_gla_write_off_us
			PAYTEMPLATE.set_curr_write_dim1 $bd_dim1_eur
			PAYTEMPLATE.set_curr_write_dim2 $bd_dim2_eur
			PAYTEMPLATE.set_curr_write_dim3 $bd_dim3_eur
			PAYTEMPLATE.set_curr_write_dim4 $bd_dim4_eur
			PAYTEMPLATE.save_template
			
			# select payment plus tab to load the template
			SF.tab $tab_new_payment
			SF.wait_for_search_button
			gen_wait_until_object_disappear $page_loadmask_message
			page.has_text?(_pay_template_name)
			gen_wait_until_object_disappear $page_loadmask_message
			# assert the default template value template value
			gen_compare($bd_bank_account_bristol_deposit_account, NEWPAY.get_proposal_payment_bank_account_value, $newpay_assert_output_text)
			gen_compare($bd_payment_method_check, NEWPAY.get_proposal_payment_media_value, $newpay_assert_output_text)
			gen_compare($bd_gla_settlement_discounts_allowed_us, NEWPAY.get_proposal_settlement_discount_value, $newpay_assert_output_text)
			gen_compare($bd_gla_write_off_us , NEWPAY.get_proposal_currency_write_off_value, $newpay_assert_output_text)
			gen_compare($label_newpayment_settlement_discount_dim1 + ": " + $bd_dim1_usd +
						$label_newpayment_settlement_discount_dim2 + ": " + $bd_dim2_usd +
						$label_newpayment_settlement_discount_dim3 + ": " + $bd_dim3_usd +
						$label_newpayment_settlement_discount_dim4 + ": " + $bd_dim4_usd, 
						NEWPAY.get_proposal_settlement_discount_dimensions_value, $newpay_assert_output_text)

			gen_compare($label_newpayment_write_off_dim1 + ": " + $bd_dim1_eur +
						$label_newpayment_write_off_dim2 + ": " + $bd_dim2_eur +
						$label_newpayment_write_off_dim3 + ": " + $bd_dim3_eur +
						$label_newpayment_write_off_dim4 + ": " + $bd_dim4_eur,
						NEWPAY.get_proposal_currency_write_off_dimensions_value, $newpay_assert_output_text)
			# reload the payment plus page to retrieve the values after clicking on next button.
			SF.tab $tab_new_payment
			SF.wait_for_search_button
			gen_wait_until_object_disappear $page_loadmask_message
			page.has_text?(_pay_template_name)
			gen_wait_until_object_disappear $page_loadmask_message
			gen_compare($bd_currency_eur, NEWPAY.get_proposal_payment_currency_value, $newpay_assert_output_text)
			# Add payment details and click next button
			NEWPAY.set_payment_date _current_date
			NEWPAY.set_payment_currency $bd_currency_eur
			NEWPAY.click_next_button
			
			gen_wait_until_object $newpay_selecttransactions_retrieveTransButton_dataffid_access
			gen_compare(_current_date, NEWPAY.get_proposal_payment_date_value, $newpay_assert_output_text)
			gen_compare($bd_bank_account_bristol_deposit_account, NEWPAY.get_proposal_payment_bank_account_value, $newpay_assert_output_text)
			gen_compare($bd_currency_eur, NEWPAY.get_proposal_payment_currency_value, $newpay_assert_output_text)
			gen_compare($bd_payment_method_check, NEWPAY.get_proposal_payment_media_value, $newpay_assert_output_text)
			gen_compare($bd_gla_settlement_discounts_allowed_us, NEWPAY.get_proposal_settlement_discount_value, $newpay_assert_output_text)
			gen_compare($bd_gla_write_off_us , NEWPAY.get_proposal_currency_write_off_value, $newpay_assert_output_text)
			gen_compare($label_newpayment_settlement_discount_dim1 + ": " + $bd_dim1_usd +
						$label_newpayment_settlement_discount_dim2 + ": " + $bd_dim2_usd +
						$label_newpayment_settlement_discount_dim3 + ": " + $bd_dim3_usd +
						$label_newpayment_settlement_discount_dim4 + ": " + $bd_dim4_usd, 
						NEWPAY.get_proposal_settlement_discount_dimensions_value, $newpay_assert_output_text)

			gen_compare($label_newpayment_write_off_dim1 + ": " + $bd_dim1_eur +
						$label_newpayment_write_off_dim2 + ": " + $bd_dim2_eur +
						$label_newpayment_write_off_dim3 + ": " + $bd_dim3_eur +
						$label_newpayment_write_off_dim4 + ": " + $bd_dim4_eur,
						NEWPAY.get_proposal_currency_write_off_dimensions_value, $newpay_assert_output_text)
			gen_end_test "TST038635"
		end
	end	
	after :all do
		login_user
		# Delete Test Data
		FFA.delete_new_data_and_wait
		gen_end_test "TID021757"
		SF.logout 
	end
end	