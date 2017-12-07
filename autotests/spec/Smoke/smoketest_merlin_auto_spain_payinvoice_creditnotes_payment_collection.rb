#--------------------------------------------------------------------------------------------#
#	TID :  TID012227 and TID013436
# 	Pre-Requisit: Org with basedata deployed. smoketest_data_setup.rb
#  	Product Area: Accounting - Payables Invoices & Credit Notes, Payments Collections & Cash Entries- Smoke Test
# 	Story: 24119
#--------------------------------------------------------------------------------------------#

describe "Smoke Test for Payable Invoices & Payable Credit Notes and Payments Collections & Cash Entries", :type => :request do
	include_context "login"
	include_context "logout_after_each"
	before :all do
		#Hold Base Data
		gen_start_test "TID012227 and TID013436"
		FFA.hold_base_data_and_wait
	end
	
	_invoice_number1 = nil
	_invoice_number2 = nil
	_credit_note_number = nil
		
	it "TID012227 : Create payable invoices and payable credit notes for merlin auto Spain." do
		gen_start_test "TID012227 : Create payable invoices and payable credit notes for merlin auto Spain."
		_line = 1
		_line_quantity = 1
		_discard_reason = "Discarded"
		_pin_expense_line_net_value_200 = "200.00"
		_pcr_expense_line_net_value_100 = "100.00"
		_account_page_layout = "Account Layout"
		
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_spain] ,true
		
		gen_start_test "Additional data for TID012227 and TID013436"
		begin
			SF.tab $tab_accounts
			SF.select_view $bd_select_view_all_accounts
			SF.click_button_go
			Account.view_account $bd_account_algernon_partners_co
			SF.click_button_edit
			Account.set_accounts_payable_control $bd_gla_accounts_payable_control_eur
			SF.click_button_save
		end
		
		gen_start_test "TST015705 : Create a new Payable Invoice and post it."
		begin
			SF.tab $tab_payable_invoices
			SF.click_button_new
			PIN.set_account $bd_account_algernon_partners_co
			PIN.change_invoice_currency $bd_currency_eur
			PIN.set_vendor_invoice_number "ABC1001"
			PIN.set_vendor_invoice_total "470.00"
			PIN.set_expense_line_gla $bd_gla_accounts_payable_control_eur
			PIN.click_new_expense_line
			PIN.set_expense_line_net_value _line, _pin_expense_line_net_value_200
			PIN.set_expense_line_tax_code _line, $bd_tax_code_vo_std_purchase
			PIN.set_product_name $bd_product_auto_com_clutch_kit_1989_dodge_raider
			PIN.click_product_new_line
			PIN.set_product_line_quantity _line, _line_quantity
			PIN.set_product_line_unit_price _line, "200.00"
			PIN.set_product_line_tax_code _line, $bd_tax_code_vo_std_purchase
			FFA.click_save_post
			gen_compare $bd_document_status_complete, PIN.get_invoice_status, "Expected payable invoice status should be updated as Complete."
			_invoice_number1 = PIN.get_invoice_number
			PIN.click_transaction_link_and_wait
			gen_compare "-376.00" , TRANX.get_account_total , "Expected Account Total to be -376.00"
			gen_compare "-376.00" , TRANX.get_account_outstanding_total , "Expected Account Outstanding Total to be -376.00"
			gen_compare "470.00" , TRANX.get_home_debits , "Expected Home Value (debit) to be 470.00"
			gen_compare "705.00" , TRANX.get_dual_debits , "Expected Dual Value (Debit) to be 705.00"
		end
		
		gen_start_test "TST015706 : Create a new payable Invoice with default date and periods."
		begin
			SF.tab $tab_payable_invoices
			SF.click_button_new
			PIN.set_account $bd_account_algernon_partners_co
			PIN.change_invoice_currency $bd_currency_eur
			PIN.set_vendor_invoice_number "ABC1002"
			PIN.set_vendor_invoice_total "470.00"
			PIN.set_expense_line_gla $bd_gla_accounts_payable_control_eur
			PIN.click_new_expense_line
			PIN.set_expense_line_net_value _line, _pin_expense_line_net_value_200
			PIN.set_expense_line_tax_code _line, $bd_tax_code_vo_std_purchase
			PIN.set_product_name $bd_product_auto_com_clutch_kit_1989_dodge_raider
			PIN.click_product_new_line
			PIN.set_product_line_quantity _line, _line_quantity
			PIN.set_product_line_unit_price _line, "200.00"
			PIN.set_product_line_tax_code _line, $bd_tax_code_vo_std_purchase
			FFA.click_save_post
			gen_compare $bd_document_status_complete, PIN.get_invoice_status, "Expected payable invoice status should be updated as Complete."
			_invoice_number2 = PIN.get_invoice_number
			PIN.click_transaction_link_and_wait
			gen_compare "-376.00" , TRANX.get_account_total , "Expected Account Total to be -376.00"
			gen_compare "-376.00" , TRANX.get_account_outstanding_total , "Expected Account Outstanding Total to be -376.00"
			gen_compare "470.00" , TRANX.get_home_debits , "Expected Home Value (debit) to be 470.00"
			gen_compare "705.00" , TRANX.get_dual_debits , "Expected Dual Value (Debit) to be 705.00"
		end
		
		gen_start_test "TST015732 : Create a new Payable Invoice and discard it."
		begin
			SF.tab $tab_payable_invoices
			SF.click_button_new
			PIN.set_account $bd_account_algernon_partners_co
			PIN.change_invoice_currency $bd_currency_eur
			PIN.set_vendor_invoice_number "ABC1003"
			PIN.set_vendor_invoice_total "235.00"
			PIN.set_expense_line_gla $bd_gla_accounts_payable_control_eur
			PIN.click_new_expense_line
			PIN.set_expense_line_net_value _line, _pin_expense_line_net_value_200
			PIN.set_expense_line_tax_code _line, $bd_tax_code_vo_std_purchase
			SF.click_button_save
			gen_compare $bd_document_status_in_progress, PIN.get_invoice_status, "Expected payable invoice status should be updated as In Progress."
			FFA.click_discard
			PIN.set_invoice_discard_reason _discard_reason
			FFA.click_discard # confirm discard
			gen_compare $bd_document_status_discarded, PIN.get_invoice_status, "Expected payable invoice status should be updated as Discarded."
			_invoice_tranx_number = PIN.get_invoice_transaction_number 
			gen_compare_objval_not_null _invoice_tranx_number, false, "Expected No transaction should be generated"
		end
		
		gen_start_test "TST015733 : Create a new Payable Invoice , Amend it and place on hold."
		begin
			# TST015733 : 1.1 : Create a new payable invoice and save and post it
			begin
				SF.tab $tab_payable_invoices
				SF.click_button_new
				PIN.set_account $bd_account_algernon_partners_co
				PIN.change_invoice_currency $bd_currency_eur
				PIN.set_vendor_invoice_number "ABC1004"
				PIN.set_vendor_invoice_total "235.00"
				PIN.set_expense_line_gla $bd_gla_accounts_payable_control_eur
				PIN.click_new_expense_line
				PIN.set_expense_line_net_value _line, _pin_expense_line_net_value_200
				PIN.set_expense_line_tax_code _line, $bd_tax_code_vo_std_purchase
				FFA.click_save_post
				gen_compare $bd_document_status_complete, PIN.get_invoice_status, "Expected payable invoice status should be updated as Complete."
				_invoice_number3 = PIN.get_invoice_number
				PIN.click_transaction_link_and_wait
				gen_compare "-188.00" , TRANX.get_account_total , "Expected Account Total to be -188.00"
				gen_compare "-188.00" , TRANX.get_account_outstanding_total , "Expected Account Outstanding Total to be -188.00"
				gen_compare "235.00" , TRANX.get_home_debits , "Expected Home Value (debit) to be 235.00"
				gen_compare "352.50" , TRANX.get_dual_debits , "Expected Dual Value (Debit) to be 352.50"
			end
			
			# TST015733 : 1.2 : Click on Ammend document button and add reference field text on payable invoice
			begin
				SF.tab $tab_payable_invoices
				SF.select_view $bd_select_view_all
				SF.click_button_go
				PIN.open_invoice_detail_page _invoice_number3
				SF.click_button $ffa_amend_document_button
				_line_net_value = _line-1
				_expense_line_net_value = $pin_expense_line_net_value_pattern.gsub($sf_param_substitute, _line_net_value.to_s)
				gen_compare_object_editable _expense_line_net_value, false, "Expected Net value field should be non-editable"
				PIN.set_reference1 "Sprint "+Date.today.to_s
				SF.click_button_save
				_expected_ref_no = "Sprint "+Date.today.to_s
				gen_compare _expected_ref_no , PIN.get_reference1 , "Expected payable invoice reference to be updated with value "+_expected_ref_no
			end
			
			# TST015733 : 1.3 : Click on Place on Hold button on Payable invoice
			begin
				SF.click_button $ffa_place_on_hold_button
				gen_compare_has_button $pin_release_for_payment, true, "Expected Release for payment button should be displayed on payable invoice detail page"
			end
		end
		
		gen_start_test "TST015753 : Create a new Payable credit note and amend it."
		begin
			# TST015753 : 1.1 : Create a new Payable credit note and save and post it.
			begin
				SF.tab $tab_payable_credit_notes
				SF.click_button_new
				PCR.set_account $bd_account_algernon_partners_co
				PCR.select_credit_note_reason $bd_credit_note_reason_incorrect_shipment
				PCR.change_credit_note_currency $bd_currency_eur
				PCR.set_vendor_credit_note_number "VCN1"
				PCR.set_vendor_credit_note_total "235.00"
				PCR.set_expense_line_gla $bd_gla_accounts_payable_control_eur
				PCR.click_new_expense_line
				PCR.set_expense_line_net_value _line, _pcr_expense_line_net_value_100
				PCR.set_expense_line_tax_code _line, $bd_tax_code_vo_std_purchase
				PCR.set_product_name $bd_product_auto_com_clutch_kit_1989_dodge_raider
				PCR.click_product_new_line
				PCR.set_product_line_quantity _line, _line_quantity
				PCR.set_product_line_unit_price _line, "100.00"
				PCR.set_product_line_tax_code _line, $bd_tax_code_vo_std_purchase
				FFA.click_save_post
				page.has_xpath?($pcr_credit_note_status)
				gen_compare $bd_document_status_complete, PCR.get_credit_note_status, "Expected payable credit note status should be updated as Complete."
				_credit_note_number = PCR.get_credit_note_number
				PCR.click_transaction_number
				gen_compare "188.00" , TRANX.get_account_total , "Expected Account Total to be 188.00"
				gen_compare "188.00" , TRANX.get_account_outstanding_total , "Expected Account Outstanding Total to be 188.00"
				gen_compare "235.00" , TRANX.get_home_debits , "Expected Home Value (debit) to be 235.00"
				gen_compare "352.50" , TRANX.get_dual_debits , "Expected Dual Value (Debit) to be 352.50"
			end
			
			# TST015753 : 1.2 : Click on Ammend document button and add reference field text on payable credit note
			begin
				SF.tab $tab_payable_credit_notes
				SF.select_view $bd_select_view_all
				SF.click_button_go
				PIN.open_invoice_detail_page _credit_note_number
				SF.click_button $ffa_amend_document_button
				_line_net_value = _line-1
				_expense_line_net_value = $pcr_expense_line_net_value_pattern.gsub($sf_param_substitute, _line_net_value.to_s)
				gen_compare_object_editable _expense_line_net_value, false, "Expected Net value field should be non-editable"
				PCR.set_reference1 "Sprint "+Date.today.to_s
				SF.click_button_save
				_expected_ref_no = "Sprint "+Date.today.to_s
				gen_compare _expected_ref_no , PCR.get_reference1 , "Expected payable credit note reference to be updated with value "+_expected_ref_no
			end
		end
		
		gen_start_test "TST015754 : Create a new Payable credit note and discard it."
		begin
			# TST015754 : 1.1 : Create a new Payable credit note and save it.
			begin
				SF.tab $tab_payable_credit_notes
				SF.click_button_new
				PCR.set_account $bd_account_algernon_partners_co
				PCR.select_credit_note_reason $bd_credit_note_reason_incorrect_shipment
				PCR.change_credit_note_currency $bd_currency_eur
				PCR.set_vendor_credit_note_number "VCN2"
				PCR.set_vendor_credit_note_total "117.50"
				PCR.set_expense_line_gla $bd_gla_accounts_payable_control_eur
				PCR.click_new_expense_line
				PCR.set_expense_line_net_value _line, _pcr_expense_line_net_value_100
				PCR.set_expense_line_tax_code _line, $bd_tax_code_vo_std_purchase
				SF.click_button_save
				gen_compare $bd_document_status_in_progress, PCR.get_credit_note_status, "Expected payable credit note status should be updated as In Progress."
			end
			
			# TST015754 : 1.2 : Discard saved payable credit note
			begin
				FFA.click_discard
				PCR.set_credit_note_discard_reason _discard_reason
				FFA.click_discard # confirm discard
				gen_compare $bd_document_status_discarded, PCR.get_credit_note_status, "Expected payable credit note status should be updated as Discarded."
				_credit_note_tranx_number = PCR.get_credit_note_transaction_number 
				gen_compare_objval_not_null _credit_note_tranx_number, false, "Expected No transaction should be generated"
			end
		end
		gen_end_test "TID012227 : Create payable invoices and payable credit notes for merlin auto Spain."

		gen_start_test "TID013436 : Payment via payment selection"
		
		gen_start_test "TST017181 : Complete payment process via payment selection"
		begin	
			# TST017181 : 1.1 : Create payment through payment selection
			begin
				SF.tab $tab_payment_selection
				SF.wait_for_search_button				
				gen_wait_until_object_disappear $page_loadmask_message 
				page.has_text?("Due Date")
				PAYSEL.set_due_date_filter false
				PAYSEL.click_retrieve_documents
				gen_wait_until_object_disappear $page_loadmask_message
				PAYSEL.select_all_transactions
				PAYSEL.click_create_payment
				PAYSEL.set_create_payment_bank_account $bd_bank_account_santander_current_account
				PAYSEL.set_create_payment_settlement_discount $bd_gla_settlement_discount_allowed_uk
				PAYSEL.set_create_payment_currency_write_off $bd_gla_exchange_gain_loss_uk
				PAYSEL.choose_create_payment_payment_media $label_payment_media_check
				PAYSEL.click_create_button
				PAYSEL.click_go_to_payments_home_button
				gen_has_page_title $page_title_payments_home, "Expected user is redirected to Payment home page"
			end
		
		
			# TST017181 : 1.2 : Open payment and verify details
			begin				
				SF.select_view $bd_select_view_all
				SF.click_button_go
				SF.wait_for_search_button
				SF.edit_list_view $bd_select_view_all, $label_payment_status, 2
				_payment_number = FFA.get_column_value_in_grid $label_payment_status, $bd_payment_retrieved_status, $label_payment_number
				PAY.open_payment_detail_page _payment_number
				_outstanding_value = PAY.get_outstanding_value $bd_account_algernon_partners_co
				gen_compare "-705.00", _outstanding_value, "Expected outstanding value to be -705.00"
				_gross_value = PAY.get_gross_value $bd_account_algernon_partners_co
				gen_compare "-705.00", _gross_value, "Expected gross value to be -705.00"
				_discount_value = PAY.get_discount $bd_account_algernon_partners_co
				gen_compare "-35.25", _discount_value, "Expected discount to be -35.25" 								
				_payment_value = PAY.get_payment_value $bd_account_algernon_partners_co
				gen_compare "-669.75", _payment_value, "Expected payment value to be -669.75"				
			end
			
			# TST017181 : 1.3 : Click show transaction on payment and change payment value
			begin
				PAY.click_show_transactions $bd_account_algernon_partners_co
				PAY.set_transactions_payment_value _invoice_number2, "-100.00"
				_outstanding_value = PAY.get_outstanding_value $bd_account_algernon_partners_co
				gen_compare "-705.00", _outstanding_value, "Expected outstanding value to be -705.00"
				_gross_value = PAY.get_gross_value $bd_account_algernon_partners_co
				gen_compare "-705.00", _gross_value, "Expected gross value to be -705.00"
				_discount_value = PAY.get_discount $bd_account_algernon_partners_co
				gen_compare "-11.75", _discount_value, "Expected discount to be -11.75"
				_payment_value = PAY.get_payment_value $bd_account_algernon_partners_co
				gen_compare "-323.25", _payment_value, "Expected payment value to be -323.25"
			end

			# TST017181 : 1.4 : Click pay button on payment and verify status
			begin
				SF.click_button $pay_payment_pay_button
				PAY.click_dialog_box_ok_button
				SF.wait_for_apex_job
				SF.tab $tab_payments
				SF.select_view $bd_select_view_all
				SF.click_button_go
				SF.wait_for_search_button
				_payment_status = FFA.get_column_value_in_grid $label_payment_number, _payment_number, $label_payment_status
				gen_compare $bd_payment_selected_status , _payment_status , "Expected Status of Payment should be updated as Selected"
			end
	
			# TST017181 : 1.5 : Click confirm & pay button on payment and verify details
			begin
				PAY.open_payment_detail_page _payment_number
				SF.click_button $pay_payment_confirm_pay_button
				SF.wait_for_apex_job
				SF.tab $tab_payments
				SF.select_view $bd_select_view_all
				SF.click_button_go
				_payment_status = FFA.get_column_value_in_grid $label_payment_number, _payment_number, $label_payment_status
				gen_compare $bd_payment_matched_status , _payment_status , "Expected Status of Payment should be updated as Matched"
				SF.tab $tab_payable_credit_notes
				SF.select_view $bd_select_view_all
				SF.click_button_go
				PCR.open_credit_note_detail_page _credit_note_number
				PCR.click_transaction_number
				gen_compare "188.00" , TRANX.get_account_total , "Expected Account Total to be 188.00"
				gen_compare "0.00" , TRANX.get_account_outstanding_total , "Expected Account Outstanding Total to be 0.00"
				SF.tab $tab_payable_invoices
				SF.select_view $bd_select_view_all
				SF.click_button_go
				PIN.open_invoice_detail_page _invoice_number1
				PIN.click_transaction_link_and_wait
				gen_compare "-376.00" , TRANX.get_account_total , "Expected Account Total to be -376.00"
				gen_compare "0.00" , TRANX.get_account_outstanding_total , "Expected Account Outstanding Total to be 0.00"
				SF.tab $tab_payable_invoices
				SF.select_view $bd_select_view_all
				SF.click_button_go
				PIN.open_invoice_detail_page _invoice_number2
				PIN.click_transaction_link_and_wait
				gen_compare "-376.00" , TRANX.get_account_total , "Expected Account Total to be -376.00"
				gen_compare "-296.00" , TRANX.get_account_outstanding_total , "Expected Account Outstanding Total to be -296.00"
			end
		end
		
		gen_start_test  "TST017182 : Void the payment"
		begin
			SF.tab $tab_payments
			SF.select_view $bd_select_view_all
			SF.click_button_go
			PAY.open_payment_detail_page _payment_number
			PAY.select_payment_line $bd_account_algernon_partners_co
			SF.click_button $pay_payment_cancel_selected_button
			PAY.set_payment_cancel_reason "Cancel Payment"
			PAY.click_payment_cancel_continue_button
			gen_wait_until_object $pay_dialog_box_locator
			SF.click_button $pay_cancel_payment_button
			gen_wait_until_object_disappear $pay_dialog_box_locator
			SF.wait_for_apex_job
			SF.tab $tab_payments
			SF.select_view $bd_select_view_all
			SF.click_button_go
			_payment_status = FFA.get_column_value_in_grid $label_payment_number, _payment_number, $label_payment_status
			gen_compare $bd_payment_cancelled_status , _payment_status , "Expected Status of Payment should be updated as Cancelled"
			SF.tab $tab_payable_credit_notes
			SF.select_view $bd_select_view_all
			SF.click_button_go
			PCR.open_credit_note_detail_page _credit_note_number
			PCR.click_transaction_number
			gen_compare "188.00" , TRANX.get_account_total , "Expected Account Total to be 188.00"
			gen_compare "188.00" , TRANX.get_account_outstanding_total , "Expected Account Outstanding Total to be 188.00"
			SF.tab $tab_payable_invoices
			SF.select_view $bd_select_view_all
			SF.click_button_go
			PIN.open_invoice_detail_page _invoice_number1
			PIN.click_transaction_link_and_wait
			gen_compare "-376.00" , TRANX.get_account_total , "Expected Account Total to be -376.00"
			gen_compare "-376.00" , TRANX.get_account_outstanding_total , "Expected Account Outstanding Total to be -376.00"
			SF.tab $tab_payable_invoices
			SF.select_view $bd_select_view_all
			SF.click_button_go
			PIN.open_invoice_detail_page _invoice_number2
			PIN.click_transaction_link_and_wait
			gen_compare "-376.00" , TRANX.get_account_total , "Expected Account Total to be -376.00"
			gen_compare "-376.00" , TRANX.get_account_outstanding_total , "Expected Account Outstanding Total to be -376.00"
		end
		
		gen_start_test "TST017183 : Discard payment"
		begin
			# TST017183 : 1.1 : Create payment through payment selection
			begin
				SF.tab $tab_payment_selection
				SF.wait_for_search_button
				gen_wait_until_object_disappear $page_loadmask_message
				page.has_xpath?($paysel_filter_list_due_date)
				PAYSEL.set_due_date_filter false
				PAYSEL.click_retrieve_documents
				gen_wait_until_object_disappear $page_loadmask_message
				PAYSEL.select_all_transactions
				PAYSEL.click_create_payment
				PAYSEL.set_create_payment_bank_account $bd_bank_account_santander_current_account
				PAYSEL.set_create_payment_settlement_discount $bd_gla_settlement_discount_allowed_uk
				PAYSEL.set_create_payment_currency_write_off $bd_gla_exchange_gain_loss_uk
				PAYSEL.choose_create_payment_payment_media $label_payment_media_check
				PAYSEL.click_create_button
				PAYSEL.click_go_to_payments_home_button
				gen_has_page_title $page_title_payments_home, "Expected user is redirected to Payment home page"
			end
			
			# TST017183 : 1.2 : Click confirm & pay button on payment and verify details
			begin
				SF.select_view $bd_select_view_all
				SF.click_button_go
				_payment_number2 = FFA.get_column_value_in_grid $label_payment_status, $bd_payment_retrieved_status, $label_payment_number
				PAY.open_payment_detail_page _payment_number2
				page.has_text?(_payment_number2)
				SF.click_button $ffa_discard_button
				SF.wait_for_search_button
				PAY.set_payment_discard_reason "Discard Test Proposal"
				SF.click_button $ffa_discard_button #confirm discard
				SF.wait_for_apex_job
				SF.tab $tab_payments
				SF.select_view $bd_select_view_all
				SF.click_button_go
				_payment_status = FFA.get_column_value_in_grid $label_payment_number, _payment_number2, $label_payment_status
				gen_compare $bd_document_status_discarded , _payment_status , "Expected Status of the payment should be updated as Discarded"
				PAY.open_payment_detail_page _payment_number2
				_gross_value = PAY.get_gross_value $bd_account_algernon_partners_co
				gen_compare "0.00", _gross_value, "Expected gross value to be 0.00"
				_discount_value = PAY.get_discount $bd_account_algernon_partners_co
				gen_compare "0.00", _discount_value, "Expected discount to be 0.00"
				_payment_value = PAY.get_payment_value $bd_account_algernon_partners_co
				gen_compare "0.00", _payment_value, "Expected payment value to be 0.00"
				SF.tab $tab_payable_credit_notes
				SF.select_view $bd_select_view_all
				SF.click_button_go
				PCR.open_credit_note_detail_page _credit_note_number
				PCR.click_transaction_number
				gen_compare "188.00" , TRANX.get_account_total , "Expected Account Total to be 188.00"
				gen_compare "188.00" , TRANX.get_account_outstanding_total , "Expected Account Outstanding Total to be 188.00"
				SF.tab $tab_payable_invoices
				SF.select_view $bd_select_view_all
				SF.click_button_go
				PIN.open_invoice_detail_page _invoice_number1
				PIN.click_transaction_link_and_wait
				gen_compare "-376.00" , TRANX.get_account_total , "Expected Account Total to be -376.00"
				gen_compare "-376.00" , TRANX.get_account_outstanding_total , "Expected Account Outstanding Total to be -376.00"
				SF.tab $tab_payable_invoices
				SF.select_view $bd_select_view_all
				SF.click_button_go
				PIN.open_invoice_detail_page _invoice_number2
				PIN.click_transaction_link_and_wait
				gen_compare "-376.00" , TRANX.get_account_total , "Expected Account Total to be -376.00"
				gen_compare "-376.00" , TRANX.get_account_outstanding_total , "Expected Account Outstanding Total to be -376.00"
			end
		end
		gen_end_test "TID013436 : Payment via payment selection"
	end
	after :all do
		login_user
		# Delete Test Data
		FFA.delete_new_data_and_wait
		SF.tab $tab_accounts
		SF.select_view $bd_select_view_all_accounts
		SF.click_button_go
		Account.view_account $bd_account_algernon_partners_co
		SF.click_button_edit
		Account.set_accounts_payable_control nil
		SF.click_button_save
		gen_end_test "TID012227 and TID013436"
		SF.logout 
	end
end
