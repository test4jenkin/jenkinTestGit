#--------------------------------------------------------------------#
#	TID : TID013532
# 	Pre-Requisite : Org with basedata deployed and Media_setup.rb
#   setup data - 
#  	Product Area: Accounting Bank Formats - Other
#--------------------------------------------------------------------#


describe "Smoke Test:TID013532 - Accounting Bank Formats - Other - COMPATIBILITY TEST -Bank Format", :type => :request do
include_context "login"
	
	_bank_defination_name = "Std Pay"
	_external_id = "10"
	_csv_output = true
	_uppercase = true
	_double_quotes = true
	_record_type_name = "Std Pay Number 1"
	_format_mapping_name= "Std Pay Mapping"
	_mapping_record_type = "Std Pay Mapping Record"
	_import_bank_format_definition = "ACH bank format definition"
	_import_bank_format_mapping = "ACH Mapping"
	_vendor_inv_number = "PIN_BANK"
	_vendor_inv_total_21_75 = "21.75"
	_current_date = Date.today.strftime("%d/%m/%Y")
	_current_date_plus_30 = (Date.today+30).strftime("%d/%m/%Y")
	_mail_subject = "The process to generate the Bank File has succeed."
	_expected_mail_content = "The Bank File ACH Mapping has been created successfuly."
	_view_file_link = "View file"
	before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait
		SF.set_bcc_email $bd_mail_id_ffa_autotest_user, true
	end
		
	it "TID013532 :  COMPATIBILITY TEST - Bank Format" do	
		begin
			bankformat_tool_setting ="list<ffbf__BankFormatTool__c> bankformatToolList = [Select Id from ffbf__BankFormatTool__c];"
			bankformat_tool_setting +="ffbf__BankFormatTool__c bankformatSetting;"
			bankformat_tool_setting +="if(bankformatToolList.size() == 0)"
			bankformat_tool_setting +="{"
			bankformat_tool_setting +="bankformatSetting = new ffbf__BankFormatTool__c();"
			bankformat_tool_setting +="}"
			bankformat_tool_setting +="else"
			bankformat_tool_setting +="{"
			bankformat_tool_setting +="bankformatSetting = bankformatToolList[0];"
			bankformat_tool_setting +="}"
			bankformat_tool_setting +="bankformatSetting.ffbf__DescriptionOfEntries__c = '1004231633';"
			bankformat_tool_setting +="bankformatSetting.ffbf__Indicator__c = 'N';"
			bankformat_tool_setting +="bankformatSetting.ffbf__LodgementReference__c= 5550033890123456.00;"
			bankformat_tool_setting +="bankformatSetting.ffbf__TraceRecord__c = '062-000';"
			bankformat_tool_setting +="bankformatSetting.ffbf__TransactionCode__c = 53;"
			bankformat_tool_setting +="bankformatSetting.ffbf__DatetoArrive__c = system.Today();"
			bankformat_tool_setting +="UPSERT bankformatSetting;"
			APEX.execute_commands [bankformat_tool_setting]
			
			# Select Company
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_spain] ,true
			#New Bank format defination
			SF.tab $tab_bank_format_definitions
			SF.click_button_new
			BFD.set_name _bank_defination_name
			BFD.set_external_id _external_id
			BFD.set_csv_output _csv_output
			BFD.set_uppercase _uppercase
			BFD.set_double_quotes _double_quotes
			SF.click_button_save
			
			#Select 'New Bank Format Definition Record Type' button.
			SF.click_button $bfd_new_bank_format_definition_record_type
			BFD.set_record_type_name _record_type_name
			BFD.set_record_type_option $bfd_record_type_detail
			BFD.set_record_type_output_type_sequence "1"
			BFD.set_record_type_output_sequence "1"
			BFD.set_record_type_external_id "1"
			SF.click_button_save
			
			SF.tab $tab_bank_format_mappings
			SF.click_button_new
			BFM.set_name _format_mapping_name
			BFM.set_bank_format_definition _bank_defination_name
			BFM.set_root_source_object "ffbf__PaymentTest__c"
			BFM.set_date_format "ddMMyy"
			BFM.select_decimal_separator "."
			SF.click_button_save
			
			SF.click_button $bfd_new_bank_format_mapping_record_type
			BFM.set_record_type_name _mapping_record_type
			BFM.set_format_definition_record_type  _record_type_name
			BFM.set_record_type_bank_format_mapping _format_mapping_name
			BFM.set_record_type_root_source_object "ffbf__PaymentMediaSummaryTest__c"
			BFM.set_record_type_output_type_sequence "1"
			SF.click_button_save	

			SF.tab $tab_bank_format_mappings
			SF.click_button_go
			SF.click_link _format_mapping_name
			SF.click_button $bfm_bank_format_mapping_join_button
			BFM.set_bfm_mapping_join_object_from "ffbf__BankAccountTest__c" 
			BFM.set_bfm_mapping_join_object_from_field "Id"
			
			BFM.set_bfm_mapping_join_object_to "BankFormatPaymentTest__c"
			BFM.set_bfm_mapping_join_object_to_field "BankAccountId__c"
			SF.click_button "Save & New"
			
			BFM.set_bfm_mapping_join_object_from "ffbf__PaymentMediaSummaryTest__c" 
			BFM.set_bfm_mapping_join_object_from_field "PaymentId__c"
			
			BFM.set_bfm_mapping_join_object_to "ffbf__PaymentTest__c"
			BFM.set_bfm_mapping_join_object_to_field "Id"
			
			SF.click_button_save
			
			SF.tab $tab_bank_format_export_import
			BFEI.import_file "bank_format_definition.txt"
			BFEI.click_import_from_button
			page.has_css?($page_vf_message_text)
			gen_include $ffa_msg_import_bank_format_definition_success_message ,FFA.ffa_get_info_message, "Expected successfulle message #{$ffa_msg_import_bank_format_definition_success_message}"
			
			SF.tab $tab_bank_format_definitions
			SF.click_button_go
			expect(page).to have_link(_import_bank_format_definition,:text => _import_bank_format_definition)
			gen_report_test "Bank format definition imported and created successfully. "
			
			
			SF.tab $tab_bank_format_export_import
			BFEI.import_file "bank_format_mapping.txt"
			BFEI.click_import_from_button
			page.has_css?($page_vf_message_text)
			gen_include $ffa_msg_import_bank_format_mapping_success_message ,FFA.ffa_get_info_message, "Expected successfulle message #{$ffa_msg_import_bank_format_mapping_success_message}"
			
			SF.tab $tab_bank_format_mappings
			SF.click_button_go
			expect(page).to have_link(_import_bank_format_mapping,:text => _import_bank_format_mapping)
			gen_report_test "Bank format mapping imported and created successfully. "
			
			# Update bank account and account for payment
			SF.tab $tab_bank_accounts
			SF.select_view $bd_select_view_company_ff_merlin_auto_spain
			SF.click_button_go
			page.has_text?($bd_bank_account_santander_current_account)
			SF.listview_filter_result_by_alphabet "S"
			page.has_text?($bd_bank_account_santander_current_account)
			BA.click_on_bank_account_from_list_view $bd_bank_account_santander_current_account					
			page.has_button?("Edit")
			SF.click_button_edit
			BA.set_sort_code "111"
			BA.set_swift_number "111"
			BA.set_iban "111"
			BA.set_direct_debit_originator_ref "111"
			SF.click_button_save
			
			SF.tab $tab_accounts
			SF.select_view $bd_select_view_all_accounts
			SF.click_button_go
			gen_click_link_and_wait $bd_account_audi
			page.has_text?($bd_account_audi)
			SF.click_button_edit
			Account.set_bank_account_name $bd_bank_account_santander_current_account
			Account.set_bank_name $bd_bank_account_santander_current_account
			Account.set_bank_sort_code "111"
			Account.set_bank_account_number "111"
			Account.set_bank_account_reference "111"
			Account.set_bank_swift_number "111"
			Account.set_bank_iban_number "111"
			SF.click_button_save
			SF.wait_for_search_button
			
			# create a new PIn with Audi Accounting
			SF.tab $tab_payable_invoices
			SF.click_button_new
			PIN.set_account $bd_account_audi
			PIN.set_vendor_invoice_number _vendor_inv_number
			PIN.set_vendor_invoice_total _vendor_inv_total_21_75
			
			#Add expense line - GLA
			PIN.set_expense_line_gla $bd_gla_settlement_discount_allowed_uk
			PIN.click_new_expense_line
			PIN.set_expense_line_net_value 1, "10.00"
			# Add Product Line 
			PIN.set_product_name $bd_product_auto_com_clutch_kit_1989_dodge_raider
			PIN.click_product_new_line
			PIN.set_product_line_quantity 1, 1
			PIN.set_product_line_unit_price 1, "10.00"
			PIN.set_product_line_tax_code 1, $bd_tax_code_vo_std_purchase
			# Post the Payable Invoice
			FFA.click_save_post
			gen_compare $bd_document_status_complete , PIN.get_invoice_status , "TST017168: Expected Payable Invoice status to be complete. "
			
			#Generate Payment
			SF.tab $tab_payments
			SF.click_button_new
			PAY.set_bank_account $bd_bank_account_santander_current_account
			PAY.set_settlement_discount $bd_gla_settlement_discount_allowed_uk
			PAY.set_currency_write_off $bd_gla_write_off_uk
			PAY.set_payment_method $bd_payment_method_electronic
			PAY.set_payment_type $label_payment_type_payments
			PAY.set_payment_media $label_payment_media_check
			PAY.set_payment_date _current_date
			PAY.set_due_date _current_date_plus_30
			PAY.click_retrieve_accounts_button
			page.has_text?($bd_account_audi)
			_payment_number = PAY.get_payment_number
			# Assert that payment is matched after pay
			SF.click_button $pay_payment_pay_button
			PAY.click_dialog_box_ok_button
			SF.wait_for_apex_job
			SF.tab $tab_payments
			SF.select_view $bd_select_view_all
			SF.click_button_go
			SF.wait_for_search_button
			PAY.open_payment_detail_page _payment_number
			PAY.click_confirm_pay_button
			SF.wait_for_apex_job
			SF.tab $tab_payments
			SF.select_view $bd_select_view_all
			SF.click_button_go
			SF.edit_list_view $bd_select_view_all, $label_payment_status, 2
			_payment_status = FFA.get_column_value_in_grid $label_payment_number , _payment_number , $label_payment_status
			gen_compare $bd_payment_matched_status, _payment_status, "Expected payment status to be Matched."
			# Generate Bank File
			FFA.select_row_in_list_gird $label_payment_number , _payment_number
			PAY.click_generate_bank_file_button
			# Confirm the process
			PAY.click_generate_bank_file_confirm_button
			page.has_css?($page_vf_message_text)
			gen_include $ffa_msg_generate_bank_file_succes_message ,FFA.ffa_get_info_message, "Expected successfulle message #{$ffa_msg_generate_bank_file_succes_message}"
			
			# Check mail contnt on mailinator
			_actual_mail_content = Mailinator.get_mail_content $bd_mail_id_ffa_autotest_user, _mail_subject , false
			if _actual_mail_content.include?(_expected_mail_content)
				gen_report_test "Expected mail to contain the necessary information of successfull operation of generate bank file."
				
			else
				gen_report_test "WARNING: MAIL not delivered successfully at mailinator."
			end
			# Open the mailinator in new taband sign in.
			Mailinator.open_mail_content  $bd_mail_id_ffa_autotest_user, _mail_subject
			Mailinator.click_link _import_bank_format_mapping
			# user will be redirected to ACH Mapping document in new window
			FFA.new_window do
				gen_include _import_bank_format_mapping ,BFD.get_document_name, "Expected document name to be displayed successfully #{_import_bank_format_mapping}"
				# click on view link to view the document file in new window.
				SF.click_link _view_file_link
				# click on email link and verify the content.
				FFA.new_window do
					page.has_text?($bd_bank_account_santander_current_account)
					expect(page).to have_content($bd_bank_account_santander_current_account)
					gen_report_test "Expected: text file to display bank account info for #{$bd_bank_account_santander_current_account} and other details."
				end
			end
			Mailinator.sign_out
			SF.logout
		end
	end
	after :all do
		login_user
		FFA.delete_new_data_and_wait
		gen_end_test "TID013532 : COMPATIBILITY TEST -Bank Format"
	end
end