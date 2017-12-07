#--------------------------------------------------------------------#
#	TID : TID018974 
# 	Pre-Requisite : Base data should exist on the org;Deploy CODATID018974Data.cls on org.
#  	Product Area: Merlin Auto Spain- Currency Revaluation Regression
# 	driver=internet_explorer rspec -fd -c spec/UI/accounting_TID018974_unmanaged.rb -fh -o pin_ext.html
#--------------------------------------------------------------------#


describe "This TID verifies the 'amend document' functionality on all documents in Internet Explorer 11.0.96 browser.", :type => :request do
include_context "login"
include_context "logout_after_each"
	before :all do
		#Hold Base Data
		
		FFA.hold_base_data_and_wait
		gen_start_test "TID018974: Verify 'amend document' functionality on all documents in Internet Explorer 11.0.96 browser."
	end
	
	it "TID018974 : Clicking Amend button for all the documents in IE 11.0.6 browser" , :ie=>true, :unmanaged => true  do
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_spain],true
		_SUFFIX = 'TID018974'
		begin
		_create_data = ["CODATID018974Data.selectCompany();", "CODATID018974Data.createData();","CODATID018974Data.createDataExt1();","CODATID018974Data.createDataExt2();","CODATID018974Data.createDataExt3();","CODATID018974Data.createDataExt4();", "CODATID018974Data.createDataExt5();", "CODATID018974Data.switchProfile();"]
		APEX.execute_commands _create_data
		SF.wait_for_apex_job
		end
		begin
			gen_start_test "TST030179: Verify 'amend document' functionality on PINV in Internet Explorer 11.0.96 browser."
			SF.tab $tab_payable_invoices
			SF.select_view $bd_select_view_all
			SF.click_button_go
			_PINV_REFERENCE = 'PINV'+_SUFFIX
			_vendor_invoice_number_column_name = 'Vendor Invoice Number'
			_payable_invoice_number_column = 'Payable Invoice Number'
			_payable_invoice_number = FFA.get_column_value_in_grid _vendor_invoice_number_column_name, _PINV_REFERENCE, _payable_invoice_number_column
			_new_invoice_description = 'amended invoice'
			PIN.open_invoice_detail_page _payable_invoice_number
			SF.click_button $pin_amend_document_button
			PIN.set_invoice_description _new_invoice_description
			SF.click_button_save
			gen_compare_has_button $pin_amend_document_button, true, 'Button found on the page'
			gen_compare _new_invoice_description, PIN.get_description, "TST030179:Assertions Passed"
			gen_end_test "TST030179: Verify that user is able to revalue only home value for a currency."
		end
		begin
			gen_start_test "TST030180: Verify 'amend document' functionality on PCRN in Internet Explorer 11.0.96 browser."
			SF.tab $tab_payable_credit_notes
			SF.select_view $bd_select_view_all
			SF.click_button_go
			_PCRN_REFERENCE = 'PCRN'+_SUFFIX
			_vendor_credit_note_number_column_name = 'Vendor Credit Note Number'
			_credit_note_number_column = 'Credit Note Number'
			_payable_credit_note_number = FFA.get_column_value_in_grid _vendor_credit_note_number_column_name, _PCRN_REFERENCE, _credit_note_number_column
			_new_description = 'amended credit Note'
			PCR.open_credit_note_detail_page _payable_credit_note_number
			SF.click_button $pcr_amend_document_button
			PCR.set_credit_note_description _new_description
			SF.click_button_save
			gen_compare_has_button $pcr_amend_document_button, true, 'Button found on the page'
			gen_compare _new_description, PCR.get_description, "TST030180:Assertions Passed"
			gen_end_test "TST030180: Verify 'amend document' functionality on PCRN in Internet Explorer 11.0.96 browser."
		end
		begin
			gen_start_test "TST030183: Verify 'amend document' functionality on Journal in Internet Explorer 11.0.96 browser."
			SF.tab $tab_journals
			SF.select_view $bd_select_view_all
			SF.click_button_go
			_JOURNAL_REFERENCE = 'JNL'+_SUFFIX
			_reference_column_name = 'Reference'
			_journal_number_column = 'Journal Number'
			_journal_number = FFA.get_column_value_in_grid _reference_column_name, _JOURNAL_REFERENCE, _journal_number_column
			_new_reference = 'amended journal'
			JNL.open_journal_detail_page _journal_number
			SF.click_button $jnl_amend_document_button
			JNL.set_journal_reference _new_reference
			SF.click_button_save
			gen_compare_has_button $jnl_amend_document_button, true, 'Button found on the page'
			gen_compare _new_reference, JNL.get_journal_reference, "TST030183:Assertions Passed"
			gen_end_test "TST030183: Verify 'amend document' functionality on Journal in Internet Explorer 11.0.96 browser."
		end
		begin
			gen_start_test "TST030184: Verify 'amend document' functionality on Cash Entry in Internet Explorer 11.0.96 browser."
			SF.tab $tab_cash_entries
			SF.select_view $bd_select_view_all
			SF.click_button_go
			_CE_REFERENCE = 'CE'+_SUFFIX
			_reference_column_name = 'Reference'
			_cash_entry_number_column = 'Cash Entry Number'
			_cash_entry_number = FFA.get_column_value_in_grid _reference_column_name, _CE_REFERENCE, _cash_entry_number_column
			_new_description = 'amended cash entry'
			CE.open_cash_entry_detail_page _cash_entry_number
			SF.click_button $cashentry_amend_document_button
			CE.set_cash_entry_description_amend_page _new_description
			SF.click_button_save
			gen_compare_has_button $cashentry_amend_document_button, true, 'Button found on the page'
			gen_compare _new_description, CE.get_description, "TST030184:Assertions Passed"
			gen_end_test "TST030184: Verify 'amend document' functionality on Cash Entry in Internet Explorer 11.0.96 browser."
		end
		begin
			gen_start_test "TST030181: Verify 'amend document' functionality on Invoice in Internet Explorer 11.0.96 browser."
			SF.tab $tab_sales_invoices
			SF.select_view $bd_select_view_all
			SF.click_button_go
			_invoice_total = '86.89'
			_invoice_total_column_name = 'Invoice Total'
			_invoice_number_column = 'Invoice Number'
			SF.edit_list_view $bd_select_view_all, _invoice_total_column_name, 6
			_invoice_number = FFA.get_column_value_in_grid _invoice_total_column_name, _invoice_total, _invoice_number_column
			_new_description = 'amended Invoice'
			SIN.open_invoice_detail_page _invoice_number
			SF.click_button $sin_amend_document_button
			SIN.set_customer_reference _new_description
			SF.click_button_save
			gen_compare_has_button $sin_amend_document_button, true, 'Button found on the page'
			gen_compare _new_description, SIN.get_customer_reference, "TST030181:Assertions Passed"
			gen_end_test "TST030181: Verify 'amend document' functionality on Invoice in Internet Explorer 11.0.96 browser."
		end
		begin
			gen_start_test "TST030182: Verify 'amend document' functionality on Credit Note in Internet Explorer 11.0.96 browser."
			SF.tab $tab_sales_credit_notes
			SF.select_view $bd_select_view_all
			SF.click_button_go
			_credit_note_total  = '17.63'
			_credit_note_total_column_name = 'Credit Note Total'
			_credit_note_number_column = 'Credit Note Number'
			_credit_note_number = FFA.get_column_value_in_grid _credit_note_total_column_name, _credit_note_total, _credit_note_number_column
			_new_description = 'amended credit note'
			SCR.open_credit_note_detail_page _credit_note_number
			SF.click_button $scn_amend_document_button
			SCR.edit_customer_reference _new_description
			SF.click_button_save
			gen_compare_has_button $scn_amend_document_button, true, 'Button found on the page'
			gen_compare _new_description, SCR.get_customer_reference, "TST030182:Assertions Passed"
			gen_end_test "TST030182: Verify 'amend document' functionality on Credit Note in Internet Explorer 11.0.96 browser."
		end
	end
	after :all do
		login_user
		_destroy_data_TID018974 = ["CODATID018974Data.destroyData();"]
		APEX.execute_commands _destroy_data_TID018974
		# Delete Test Data
		FFA.delete_new_data_and_wait
		gen_end_test "TID018974: Verify that user is able to revalue Only Home Value/ Dual Value."
		SF.logout
	end
end