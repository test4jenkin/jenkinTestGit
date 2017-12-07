#--------------------------------------------------------------------------------------------#
#	TID : TID013894, TID013895 and TID013899
# 	Pre-Requisit: Org with basedata deployed, smoketest_data_setup
#  	Product Area: Verify edit, save and post operations with different levels of permission set assignment
# 	Story: 25003
#--------------------------------------------------------------------------------------------#

describe "Smoke Test - Permission Set Assignment level ", :type => :request do
	include_context "login"
	include_context "logout_after_each"
	before :all do
		FFA.hold_base_data_and_wait
		SF.tab $tab_user_companies
		SF.click_button_new
		USERCOMPANY.set_user_name $bd_user_fullname_StandardUser
		USERCOMPANY.set_company_name $company_merlin_auto_aus
		SF.click_button_save
		gen_start_test "Permission Set Assignment level Smoke Test."
	end
	
	_line_1 = 1
	_current_date = Time.now.strftime("%d/%m/%Y")
	_date_5_days_back = (Time.now-5*24*60*60).strftime("%d/%m/%Y")
	_quantity_2 = 2
	_unit_price_89_4 = "89.40"
	_sin_prefix = "SIN"
	
	it "TID013894 Implemented : Sales Invoice operation for a standard user with level-2 permission set" do
		gen_start_test "TID013894 : Sales Invoice operation for a standard user with level-2 permission set"
		_invoice_description_permission_set_2 = "permission set 2"
		
		puts "Additional data setup for TID013894"
		begin
			_permission_set_list = [$ffa_permission_set_acc_billing_sales_invoice, $ffa_permission_set_acc_billing_select_company]
			SF.set_user_permission_set_assignment _permission_set_list, $bd_user_fullname_StandardUser, true
		end
		gen_start_test "TST018330 : Sales Invoice Permission set level 2 operations."
		puts "1.1 : Create Sales Invoice"
		begin
			SF.login_as_user $bd_user_std_user_alias
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_aus] ,true
			SF.tab $tab_sales_invoices
			SF.click_button_new
			SIN.set_account $bd_account_jboag_brewing
			SIN.set_invoice_date _current_date
			FFA.click_new_line
			SIN.line_set_product_name _line_1 , $bd_product_auto_com_clutch_kit_1989_dodge_raider
			SIN.line_set_quantity _line_1 , _quantity_2
			SIN.line_set_unit_price _line_1 , _unit_price_89_4
			SIN.line_set_tax_code _line_1 , $bd_tax_code_gst_sales
			SF.click_button_save
			gen_compare $bd_document_status_in_progress, SIN.get_status, "Expected sales invoice to be saved successfully"
			gen_include _sin_prefix, SIN.get_invoice_number, "Expected A SIN number to be generated for saved invoice"
		end
		
		puts "1.2 : Edit sales invoice created in 1.1"
		begin
			SF.click_button_edit
			SIN.set_invoice_date _date_5_days_back
			SIN.set_description _invoice_description_permission_set_2
			SF.click_button_save
			gen_compare _date_5_days_back, SIN.get_invoice_date, "Expected invoice date to be #{_date_5_days_back}"
			gen_compare _invoice_description_permission_set_2, SIN.get_invoice_description, "Expected invoice description to be"+_invoice_description_permission_set_2
		end
		
		puts "1.3 : Post sales invoice created in 1.1"
		begin
			SF.click_button $ffa_post_button
			gen_compare $bd_document_status_complete, SIN.get_status, "Expected sales invoice status to be complete"
			gen_compare_objval_not_null SIN.get_transaction_number, true, "Expected transaction number has been generated"
		end
		gen_end_test "TID013894 : Sales Invoice Permission set level 2 operations."
	end
	
	it "TID013895 Implemented : Sales Invoice operation for a standard user with level-3 permission set " do
		gen_start_test "TID013895 : Sales Invoice operation for a standard user with level-3 permission set"
		_invoice_description_permission_set_3 = "permission set 3"
		
		login_user
		if (!(DRIVER == "SAUCE") and (ORG_TYPE == MANAGED))
		puts "Additional data setup for TID013895"
		begin
			SF.set_user_permission_set_assignment [$ffa_permission_set_acc_billing_select_company], $bd_user_fullname_StandardUser, true
		end
		gen_start_test "TST018331 : Sales Invoice Permission set level 3 operations."
		puts "1.1 : Select company merlin auto AUS from standard user profile"
		begin
			SF.login_as_user $bd_user_std_user_alias
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_aus] ,true
			gen_report_test "Newly created standard user is able to select Merlin Auto AUS company successfully"
		end
	
		puts "1.2 : Set sales invoice save permission for standard user from admin profile"
		begin
			SF.logout
			login_user
			SF.set_user_permission_set_assignment [$ffa_permission_set_acc_billing_sales_invoice_save], $bd_user_fullname_StandardUser, false
			gen_compare_has_link $ffa_permission_set_acc_billing_sales_invoice_save , true , "Expected #{$ffa_permission_set_acc_billing_sales_invoice_save} is assigned successfully"
		end
	
		puts "1.3 : Create sales invoice from standard user profile"
		begin
			SF.login_as_user $bd_user_std_user_alias
			SF.tab $tab_sales_invoices
			SF.click_button_new
			SIN.set_account $bd_account_jboag_brewing
			SIN.set_invoice_date _current_date
			FFA.click_new_line
			SIN.line_set_product_name _line_1 , $bd_product_auto_com_clutch_kit_1989_dodge_raider
			SIN.line_set_quantity _line_1 , _quantity_2
			SIN.line_set_unit_price _line_1 , _unit_price_89_4
			SIN.line_set_tax_code _line_1 , $bd_tax_code_gst_sales
			SF.click_button_save
			_invoice_number = SIN.get_invoice_number
			gen_compare $bd_document_status_in_progress, SIN.get_status, "Expected sales invoice to be saved successfully"
			gen_include _sin_prefix, _invoice_number, "Expected A SIN number to be generated for saved invoice"
			gen_compare_has_button $sf_edit_button, false, "Expected no edit button to be displayed on the invoice"
			gen_compare_has_button $ffa_post_button, false, "Expected no post button to be displayed on the invoice"
		end
		
		puts "1.4 : Set sales invoice edit permission for standard user from admin profile"
		begin
			SF.logout
			login_user
			SF.set_user_permission_set_assignment [$ffa_permission_set_acc_billing_sales_invoice_edit], $bd_user_fullname_StandardUser, false
			gen_compare_has_link $ffa_permission_set_acc_billing_sales_invoice_edit , true , "Expected #{$ffa_permission_set_acc_billing_sales_invoice_edit} is assigned successfully"
		end
		
		puts "1.5 : Edit sales invoice from standard user profile"
		begin
			SF.login_as_user $bd_user_std_user_alias 
			SF.tab $tab_sales_invoices
			SF.select_view $bd_select_view_all
			SF.click_button_go
			SIN.open_invoice_detail_page _invoice_number
			SF.click_button_edit
			_invoice_date = (Time.now-7*24*60*60).strftime("%d/%m/%Y")
			SIN.set_invoice_date _invoice_date
			SIN.set_description _invoice_description_permission_set_3
			SF.click_button_save
			gen_compare _invoice_date, SIN.get_invoice_date, "Expected invoice date to be #{_invoice_date}"
			gen_compare _invoice_description_permission_set_3, SIN.get_invoice_description, "Expected invoice description to be"+_invoice_description_permission_set_3
			gen_compare_has_button $sf_edit_button, true, "Expected Edit button to be displayed on the invoice"
			gen_compare_has_button $ffa_post_button, false, "Expected no post button to be displayed on the invoice"
		end
		
		puts "1.6 : Set sales invoice post permission for standard user from admin profile"
		begin
			SF.logout
			login_user
			SF.set_user_permission_set_assignment [$ffa_permission_set_acc_billing_sales_invoice_post], $bd_user_fullname_StandardUser, false
			gen_compare_has_link $ffa_permission_set_acc_billing_sales_invoice_post , true , "Expected #{$ffa_permission_set_acc_billing_sales_invoice_post} is assigned successfully"
		end
		
		puts "1.7 : Post sales invoice from standard user profile"
		begin
			SF.login_as_user $bd_user_std_user_alias 
			SF.tab $tab_sales_invoices
			SF.select_view $bd_select_view_all
			SF.click_button_go
			SIN.open_invoice_detail_page _invoice_number
			SF.click_button $ffa_post_button
			gen_compare $bd_document_status_complete, SIN.get_status, "Expected sales invoice status to be complete"
			gen_compare_objval_not_null SIN.get_transaction_number, true, "Expected transaction number has been generated"
		end
		end
		gen_end_test "TID013895 : Sales Invoice Permission set level 3 operations."
	end
	
	it "TID013899 Implemented :  Various documents operation for a standard user with level-3 permission set" do
		gen_start_test "TID013899 : Various documents operation for a standard user with level-3 permission set"
		_permission_set_list = [$ffa_permission_set_accounting, $ffa_permission_set_billing]
	
		_invoice_description_sin_permission_set = "SIN-permission set"
		_credit_note_description = "SCR permission set"
		_payable_invoice_description = "PIN-permission set"
		_payable_creditnote_description = "PCR-permission set"
		_cashentry_description = "CSH-permission set"
		
		puts "Additional data setup for TID013899"
		begin
			login_user
			SF.set_user_permission_set_assignment _permission_set_list, $bd_user_fullname_StandardUser, true
		end
		
		gen_start_test "TST018334 : Create and Post sales Invoice"
		begin
			puts "1.1 : Create sales invoice from standard user profile"
			begin
				SF.login_as_user $bd_user_std_user_alias 
				SF.tab $tab_select_company
				FFA.select_company [$company_merlin_auto_aus] ,true
				SF.tab $tab_sales_invoices
				SF.click_button_new
				SIN.set_account $bd_account_jboag_brewing
				SIN.set_invoice_date _current_date
				FFA.click_new_line
				SIN.line_set_product_name _line_1 , $bd_product_auto_com_clutch_kit_1989_dodge_raider
				SIN.line_set_quantity _line_1 , _quantity_2
				SIN.line_set_unit_price _line_1 , _unit_price_89_4
				SIN.line_set_tax_code _line_1 , $bd_tax_code_gst_sales
				SF.click_button_save
				gen_compare $bd_document_status_in_progress, SIN.get_status, "Expected sales invoice to be saved successfully"
				gen_include _sin_prefix, SIN.get_invoice_number, "Expected A SIN number to be generated for saved invoice"
			end
			
			puts "1.2 : Edit sales invoice"
			begin
				SF.click_button_edit
				SIN.set_invoice_date _date_5_days_back
				SIN.set_description _invoice_description_sin_permission_set
				SF.click_button_save
				gen_compare _date_5_days_back, SIN.get_invoice_date, "Expected invoice date to be #{_date_5_days_back}"
				gen_compare _invoice_description_sin_permission_set, SIN.get_invoice_description, "Expected invoice description to be "+_invoice_description_sin_permission_set
			end
			
			puts "1.3 : Post sales invoice"
			begin
				SF.click_button $ffa_post_button
				gen_compare $bd_document_status_complete, SIN.get_status, "Expected sales invoice status to be complete"
				gen_compare_objval_not_null SIN.get_transaction_number, true, "Expected transaction number has been generated"
			end
		end
		
		gen_start_test "TST018335 : Create and Post sales credit note"
		begin
			puts "1.1 : Create sales credit note from standard user profile"
			begin
				SF.tab $tab_sales_credit_notes
				SF.click_button_new
				SCR.set_account $bd_account_jboag_brewing
				SCR.set_creditnote_date _current_date
				FFA.click_new_line
				SCR.line_set_product_name _line_1 , $bd_product_auto_com_clutch_kit_1989_dodge_raider
				SCR.line_set_quantity _line_1 , _quantity_2
				SCR.line_set_unit_price _line_1 , _unit_price_89_4
				SCR.line_set_tax_code _line_1 , $bd_tax_code_gst_sales
				SF.click_button_save
				gen_compare $bd_document_status_in_progress, SCR.get_credit_note_status, "Expected sales credit note to be saved successfully"
				gen_include "SCR", SCR.get_credit_note_number, "Expected A SCR number to be generated for saved credit note"
			end
			
			puts "1.2 : Edit sales credit note"
			begin
				SF.click_button_edit
				SCR.set_creditnote_date _date_5_days_back
				SCR.set_description _credit_note_description
				SF.click_button_save
				gen_compare _date_5_days_back, SCR.get_credit_note_date, "Expected credit note date to be #{_date_5_days_back}"
				gen_compare _credit_note_description, SCR.get_credit_note_description, "Expected credit note description to be "+_credit_note_description
			end
			
			puts "1.3 : Post sales credit note"
			begin
				SF.click_button $ffa_post_button
				gen_compare $bd_document_status_complete, SCR.get_credit_note_status, "Expected sales credit note status to be complete"
				gen_compare_objval_not_null SCR.get_transaction_number, true, "Expected transaction number has been generated"
			end
		end
		
		gen_start_test "TST018336 : Create and Post payable Invoice"
		begin
			puts "1.1 : Create payable invoice from standard user profile"
			begin
				SF.tab $tab_payable_invoices
				SF.click_button_new
				PIN.set_account $bd_account_jboag_and_sons
				PIN.set_vendor_invoice_number "SCR001"
				PIN.set_vendor_invoice_total "400.00"
				PIN.set_expense_line_gla $bd_gla_account_payable_control_aud
				PIN.click_new_expense_line
				PIN.set_expense_line_net_value _line_1, "200.00"
				PIN.set_expense_line_tax_code _line_1, nil
				PIN.set_product_name $bd_product_auto_com_clutch_kit_1989_dodge_raider
				PIN.click_product_new_line
				PIN.set_product_line_unit_price _line_1, "200.00"
				PIN.set_product_line_tax_code _line_1, nil
				SF.click_button_save
				gen_compare $bd_document_status_in_progress, PIN.get_invoice_status, "Expected payable invoice to be saved successfully"
				gen_include "PIN", PIN.get_invoice_number, "Expected A PIN number to be generated for saved payable invoice"
			end
			
			puts "1.2 : Edit payable invoice"
			begin
				SF.click_button_edit
				PIN.set_invoice_date _date_5_days_back
				PIN.set_invoice_description _payable_invoice_description
				SF.click_button_save
				gen_compare _date_5_days_back, PIN.get_invoice_date, "Expected payable invoice date to be #{_date_5_days_back}"
				gen_compare _payable_invoice_description, PIN.get_description, "Expected payable invoice description to be "+_payable_invoice_description
			end
			
			puts "1.3 : Post payable invoice"
			begin
				SF.click_button $ffa_post_button
				SF.wait_for_search_button
				gen_compare $bd_document_status_complete, PIN.get_invoice_status, "Expected payable invoice status to be complete" 
				gen_include "TRN", PIN.get_invoice_transaction_number, "Expected transaction number has been generated"
			end
		end
		
		gen_start_test "TST018337 : Create and Post payable credit note"
		begin
			puts "1.1 : Create payable credit note from standard user profile"
			begin
				SF.tab $tab_payable_credit_notes
				SF.click_button_new
				PCR.set_account $bd_account_jboag_and_sons
				PCR.select_credit_note_reason $bd_credit_note_reason_incorrect_shipment
				PCR.set_vendor_credit_note_number "PCN01"
				PCR.set_vendor_credit_note_total "200.00"
				PCR.set_expense_line_gla $bd_gla_account_payable_control_aud
				PCR.click_new_expense_line
				PCR.set_expense_line_net_value _line_1, "100.00"
				PCR.set_expense_line_tax_code _line_1, nil
				PCR.set_product_name $bd_product_auto_com_clutch_kit_1989_dodge_raider
				PCR.click_product_new_line
				PCR.set_product_line_unit_price _line_1, "100.00"
				PCR.set_product_line_tax_code _line_1, nil
				SF.click_button_save
				gen_compare $bd_document_status_in_progress, PCR.get_credit_note_status, "Expected payable credit note to be saved successfully"
				gen_include "PCR", PCR.get_credit_note_number, "Expected A PCR number to be generated for saved payable credit note"
			end
			
			puts "1.2 : Edit payable credit note"
			begin
				SF.click_button_edit
				PCR.set_payable_credit_note_date _date_5_days_back
				PCR.set_credit_note_description _payable_creditnote_description
				SF.click_button_save
				gen_compare _date_5_days_back, PCR.get_credit_note_date, "Expected payable credit note date to be #{_date_5_days_back}"
				gen_compare _payable_creditnote_description, PCR.get_description, "Expected payable credit note description to be "+_payable_creditnote_description
			end
			
			puts "1.3 : Post payable credit note"
			begin
				SF.click_button $ffa_post_button
				gen_compare $bd_document_status_complete, PCR.get_credit_note_status, "Expected payable credit note status to be complete"
				gen_include "TRN", PCR.get_credit_note_transaction_number, "Expected transaction number has been generated"
			end
		end
		
		gen_start_test "TST018338 : Create and Post cash entry"
		begin
			puts "1.1 : Create cash entry from standard user profile"
			begin
				SF.tab $tab_cash_entries
				SF.click_button_new
				CE.set_bank_account $bd_bank_account_commonwealth_current_account
				CE.line_set_account_name $bd_account_jboag_and_sons
				FFA.click_new_line
				CE.line_set_cashentryvalue _line_1 , "200"
				SF.click_button_save
				gen_compare $bd_document_status_in_progress, CE.get_cash_entry_status, "Expected cash entry status to be in progress"
			end
			
			puts "1.2 : Edit cash entry"
			begin
				SF.click_button_edit
				CE.set_date _date_5_days_back
				CE.set_cash_entry_description _cashentry_description
				SF.click_button_save
				gen_compare _date_5_days_back, CE.get_cash_entry_date, "Expected cash entry date to be #{_date_5_days_back}"
				gen_compare _cashentry_description, CE.get_description, "Expected cash entry description to be "+_cashentry_description
			end
			
			puts "1.3 : Post cash entry"
			begin
				SF.click_button $ffa_post_button
				gen_compare $bd_document_status_complete, CE.get_cash_entry_status, "Expected cash entry status to be complete"
				gen_include "TRN" , CE.get_transaction_number,  "Expected transaction number has been generated"
			end
		end
		gen_end_test "TID013899 : Various documents operation for a standard user with level-3 permission set"
	end
	after :all do
		login_user
		FFA.delete_new_data_and_wait
		gen_end_test "Permission Set Assignment level Smoke Test"
		SF.logout 
	end
end