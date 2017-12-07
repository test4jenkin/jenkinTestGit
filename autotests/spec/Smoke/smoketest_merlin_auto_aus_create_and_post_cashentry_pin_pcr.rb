#--------------------------------------------------------------------#
#	TID : TID013419,TID013415
# 	Pre-Requisite : smoketest_data_setup.rb
#  	Product Area: Merlin Auto AUS- Create and Post cash entry,payable invoice and payable credit note with currency dual rates.
# 	Story:  24322
#--------------------------------------------------------------------#

describe "Smoke Test:Merlin Auto AUS- Create Cash entry , payable Invoice and Payable credit note and post them", :type => :request do
include_context "login"
include_context "logout_after_each"
	before :all do
		#Hold Base Data
		gen_start_test "TID013419 and TID013415"
		FFA.hold_base_data_and_wait
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_aus] ,true
	end
	
	current_date = Date.today
	it "TID013419 : Create a cash entry and post it. " do
		_cashentry_value = "220.00" 
		_cashentry_description = "TST017170 Cash Entry"
		_currency_dual_rate = "0.56"
		gen_start_test "TID013419"
		gen_start_test "TST017170: Create a Cash Entry with currency dual rate and post it."
		begin
			# Step 1.1
			begin
				SF.tab $tab_cash_entries
				SF.click_button_new
				CE.set_bank_account $bd_bank_account_commonwealth_current_account
				CE.set_payment_method $bd_payment_method_cash
				CE.set_cash_entry_description _cashentry_description
				CE.set_currency_dual_rate _currency_dual_rate
				CE.line_set_account_name $bd_account_jboag_and_sons
				FFA.click_new_line
				CE.line_set_payment_method_value 1 ,$bd_payment_method_cash
				CE.line_set_cashentryvalue 1,_cashentry_value
				CE.click_update
				gen_compare _cashentry_value , CE.get_cashentry_bankaccount_value , "TST017170: Expected Cash Entry Bank Account value to be " + _cashentry_value
				gen_compare _cashentry_value , CE.get_cashentry_value , "TST017170: Expected Cash Entry value at header to be " + _cashentry_value
				gen_compare _cashentry_value , CE.get_cashentry_total_netvalue , "TST017170: Expected Cash Entry Net Value  to be " + _cashentry_value
				FFA.click_save_post
				gen_compare $bd_document_status_complete , CE.get_cash_entry_status , "TST017170: Expected cash entry status to be complete"
			end	
		end
		gen_end_test "TID013419"
	end
	
	it "TID013415: Create a Payable Invoice , payable credit note and Post it. " do
		login_user
		_vendor_inv_number = "ABC1001"
		_vendor_inv_total = "436.00"
		_currency_dual_rate = "0.56"
		_vendor_credit_note_number = "VCN1"
		_vendor_credit_note_total = "218.00"
		_dim1 = 1
		gen_start_test "TID013415"
		gen_start_test "TST017168: Create a payable Invoice with currency dual rate and post it. "
		# Step 1.1
		begin
			SF.tab $tab_payable_invoices
			SF.click_button_new
			PIN.set_account $bd_account_jboag_and_sons
			FFA.click_account_toggle_icon
			PIN.set_account_dimension _dim1 , $bd_dimension_queensland
			FFA.click_account_toggle_icon
			PIN.set_invoice_date current_date.strftime("%d/%m/%Y")
			PIN.set_currency_dual_rate _currency_dual_rate
			PIN.set_vendor_invoice_number _vendor_inv_number
			PIN.set_vendor_invoice_total _vendor_inv_total
			
			#Add expense line - GLA
			PIN.set_expense_line_gla $bd_gla_account_payable_control_aud
			PIN.click_new_expense_line
			PIN.set_expense_line_net_value 1, "200.00"
			PIN.set_expense_line_tax_code 1 , $bd_tax_code_gst_purchase
			# Add Product Line 
			PIN.set_product_name $bd_product_auto_com_clutch_kit_1989_dodge_raider
			PIN.click_product_new_line
			PIN.set_product_line_quantity 1, 1
			PIN.set_product_line_unit_price 1, "200.00"
			PIN.set_product_line_tax_code 1, $bd_tax_code_gst_purchase
			# Post the Payable Invoice
			FFA.click_save_post
			gen_compare $bd_document_status_complete , PIN.get_invoice_status , "TST017168: Expected Payable Invoice status to be complete. "
			gen_include _vendor_inv_total , PIN.get_invoice_total , "TST017168: Expected Invoice total to be: " + _vendor_inv_total
			PIN.click_transaction_link_and_wait
			gen_compare "-436.00" , TRANX.get_account_total , "TST017168: Expected account total to be -436.00"
			gen_compare "-436.00" , TRANX.get_account_outstanding_total , "TST017168: Expected account outstanding total to be -436.00"
		end
		
		gen_start_test "TST017169: Create a payable credit note  with currency dual rate and post it."
		# Step 1.1
		begin
			SF.tab $tab_payable_credit_notes
			SF.click_button_new
			PCR.set_account $bd_account_jboag_and_sons
			FFA.click_account_toggle_icon
			PCR.set_account_dimension _dim1 , $bd_dimension_queensland
			FFA.click_account_toggle_icon
			PCR.set_payable_credit_note_date current_date.strftime("%d/%m/%Y")
			PCR.set_currency_dual_rate _currency_dual_rate
			PCR.set_vendor_credit_note_number _vendor_credit_note_number
			PCR.select_credit_note_reason $bd_credit_note_reason_incorrect_shipment
			PCR.set_vendor_credit_note_total _vendor_credit_note_total
			
			# Add Expense line GLA
			PCR.set_expense_line_gla $bd_gla_account_payable_control_aud
			PCR.click_new_expense_line
			PCR.set_expense_line_net_value 1, "100.00"
			PCR.set_expense_line_tax_code 1, $bd_tax_code_gst_purchase
			# Add Product Line
			PCR.set_product_name $bd_product_auto_com_clutch_kit_1989_dodge_raider
			PCR.click_product_new_line
			PCR.set_product_line_quantity 1, 1
			PCR.set_product_line_unit_price 1, "100.00"
			PCR.set_product_line_tax_code 1, $bd_tax_code_gst_purchase
			# Post the Payable credit note
			FFA.click_save_post
			gen_compare $bd_document_status_complete , PCR.get_credit_note_status , "TST017169: Expected Payable credit note status to be complete. "
			gen_include _vendor_credit_note_total , PCR.get_credit_note_total , "TST017169: Expected credit note  total to be: " + _vendor_credit_note_total
			PCR.click_transaction_number
			gen_compare "218.00" , TRANX.get_account_total , "TST017169: Expected account total for PCR to be 218.00"
			gen_compare "218.00" , TRANX.get_account_outstanding_total , "TST017169: Expected account outstanding total for PCR to be 218.00"
		end
		gen_end_test "TID013415"
	end
	
	after :all do
		login_user
		# Delete Test Data
		FFA.delete_new_data_and_wait
		gen_end_test "TID013419 and TID013415"
		SF.logout 
	end
end	