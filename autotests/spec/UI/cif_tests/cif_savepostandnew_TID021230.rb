#--------------------------------------------------------------------#
#   TID : TID021230 
#   Pre-Requisite : Base data should exist on the org.
#   Product Area: CIF
#   How to run : rspec spec/UI/cif_tests/cif_savepostandnew_TID021230.rb -fh -o cif_savepostandnew_TID021230.html
#--------------------------------------------------------------------#

describe "TID021230: This TID verifies the functionality of Save, Post & New button on CIF documents", :type => :request do
	include_context "login"
	include_context "logout_after_each"
	_SUFFIX = 'TID021230'
	_save_new_url_string = 'save_new'
	before :all do
		gen_start_test "TID021230: Verify the functionality of Save, Post & New button on CIF documents"
		FFA.hold_base_data_and_wait
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_spain],true
	end

	it "TID021230 : Verify the Save,Post & New button on Sales Invoice" do
		invoice_total = '50.00'
		gen_start_test "TST036736: Verify the Save,Post & New button on Sales Invoice"
		begin
			#Create SIN
            SF.tab $tab_sales_invoices
			SF.click_button_new
			gen_wait_until_object $cif_sales_invoice_account
			CIF.click_toggle_button
			CIF_SINV.set_sinv_account $bd_account_bolinger
			#add line items 
			CIF_SINV.click_new_row
			CIF_SINV.set_sinv_line_product $bd_product_champagne		
			CIF_SINV.set_sinv_line_quantity 1
			CIF_SINV.set_sinv_line_unit_price 50
			CIF.click_toggle_button
			CIF.click_save_post_new_button
			CIF.wait_for_buttons_to_load

			CIF_SINV.compare_sinv_header_details(nil, nil, nil, '0.00', '0.00', '0.00', nil)
			current_page_url = page.current_url
			gen_include _save_new_url_string , current_page_url , 'Expected New Sales Invoice page to be opened'

			SF.tab $tab_sales_invoices
            SF.select_view $bd_select_view_all
            SF.click_button_go
            _sales_invoice_number = FFA.get_column_value_in_grid $label_invoice_total, invoice_total, $label_invoice_number
            SIN.open_invoice_detail_page _sales_invoice_number

			#Compare Posted Sales Invoice Values
			CIF_SINV.compare_sinv_header_details(nil, nil, $bd_currency_eur, '50.00', '0.00', '50.00', $bd_document_status_complete)
        end
		gen_end_test "TST036736: Verify the Save,Post & New button on Sales Invoice"
	end
	
	it "TID021230 : Verify the Save,Post & New button on Sales Credit Note" do
		gen_start_test "TST036737: Verify the Save,Post & New button on Sales Credit Note"
		_credit_note_total = '100.00'
		login_user
        begin
			#Create SCN
            SF.tab $tab_sales_credit_notes
            SF.click_button_new
			CIF_SCN.set_account $bd_account_bolinger
			
			#add line items
			CIF_SCN.click_new_row 
			CIF_SCN.set_scn_line_item_product $bd_product_a4_paper
			CIF_SCN.set_line_item_quantity 1, 1
			CIF_SCN.set_scn_line_item_unit_price 100.00
			CIF.click_save_post_new_button
			CIF.wait_for_buttons_to_load
			CIF_SCN.compare_scn_header_details(nil, nil, nil, '0.00', '0.00', '0.00', nil)
			current_page_url = page.current_url
			gen_include _save_new_url_string, current_page_url , 'Expected New Sales Credit Note page to be opened'

			SF.tab $tab_sales_credit_notes
            SF.select_view $bd_select_view_all
            SF.click_button_go
            _credit_note_number = FFA.get_column_value_in_grid $label_credit_note_total, _credit_note_total, $label_credit_note_number
            SCR.open_credit_note_detail_page _credit_note_number

            #Compare Posted Sales Credit Note Values
            CIF_SCN.compare_scn_header_details(nil, nil, $bd_currency_eur, '100.00', '0.00', '100.00', $bd_document_status_complete)
        end
		gen_end_test "TST036737: Verify the Save,Post & New button on Sales Credit Note"
	end
	
	it "TID021230 : Verify the Save,Post & New button on Payable Invoice" do	
		gen_start_test "TST036738: Verify the Save,Post & New button on Payable Invoice"
		login_user
		_invoice_number = 'PINV' + _SUFFIX
		_vendor_invoice_number_column_name = 'Vendor Invoice Number'
		_payable_invoice_number_column = 'Payable Invoice Number'
        begin
			#Create PIN			
			SF.tab $tab_payable_invoices
			SF.click_button_new
			CIF.wait_for_buttons_to_load
			CIF_PINV.set_pinv_account $bd_account_bmw_automobiles
			CIF_PINV.set_pinv_vendor_invoice_number _invoice_number
		
			#add line items
			CIF_PINV.click_payable_invoice_expense_line_items_tab
			CIF_PINV.click_new_row
			CIF_PINV.set_pinv_expense_line_gla $bd_gla_postage_and_stationery
			CIF_PINV.click_column_grid_data_row 1, $cif_payable_invoice_expense_line_net_value_column_number
			CIF.wait_for_totals_to_calculate
			CIF_PINV.set_pinv_expense_line_net_value "50"
			
			CIF_PINV.click_payable_invoice_line_items_tab
			CIF_PINV.click_new_row
			CIF_PINV.set_pinv_line_product $bd_product_a4_paper
			CIF_PINV.click_column_grid_data_row 1, $cif_payable_invoice_line_item_quantity_column_number
			CIF_PINV.set_pinv_line_quantity 1
			CIF_PINV.set_pinv_line_unit_price "50"		

			CIF.click_save_post_new_button
			CIF.wait_for_buttons_to_load
			CIF_PINV.compare_pinv_header_details(nil, nil, nil, '0.00', '0.00', '0.00', nil)
			current_page_url = page.current_url
			gen_include _save_new_url_string, current_page_url , 'Expected New Payable Invoice page to be opened'

			SF.tab $tab_payable_invoices
			SF.select_view $bd_select_view_all
            SF.click_button_go
            _payable_invoice_number = FFA.get_column_value_in_grid $label_vendor_invoice_number, _invoice_number, $label_payable_invoice_number
            PIN.open_invoice_detail_page _payable_invoice_number
			
            #Comparing Posted Payable Invoice values
            CIF_PINV.compare_pinv_header_details(nil, nil, $bd_currency_eur, '100.00', '2.50', '102.50', $bd_document_status_complete)
        end
		gen_end_test "TST036738: Verify the Save,Post & New button on Payable Invoice"
	end
	
	it "TID021230 : Verify the Save,Post & New button on Payable Credit Note" do
		gen_start_test "TST036739: Verify the Save,Post & New button on Payable Credit Note"
		login_user
		vendor_credit_note_number = 'PCRN' + _SUFFIX
        begin
			#Create PCN
            SF.tab $tab_payable_credit_notes
            SF.click_button_new
			CIF.wait_for_buttons_to_load
			CIF_PCN.set_pcn_account $bd_account_bmw_automobiles
			CIF_PCN.set_pcn_credit_note_currency $bd_currency_eur
			CIF_PCN.set_pcn_vendor_credit_note_number vendor_credit_note_number
			CIF_PCN.click_payable_credit_note_expense_line_items_tab
			CIF_PCN.click_new_row
			CIF_PCN.set_pcn_expense_line_gla $bd_gla_postage_and_stationery
			CIF_PCN.set_pcn_expense_line_net_value 50, 1
			CIF.wait_for_totals_to_calculate
			
			#add line items
			CIF_PCN.click_payable_credit_note_line_items_tab
			CIF_PCN.click_new_row
			CIF_PCN.set_pcn_line_product $bd_product_auto1_com_clutch_kit_1989_dodge_raider
			CIF_PCN.set_pcn_line_quantity 1, 1
			CIF_PCN.set_pcn_line_unit_price 50
			CIF.click_save_post_new_button
			
			CIF.wait_for_buttons_to_load
			CIF_PCN.compare_pcn_header_details(nil, nil, nil, '0.00', '0.00', '0.00', nil)
			current_page_url = page.current_url
			gen_include _save_new_url_string, current_page_url , 'Expected New Payable Credit Note page to be opened'

			SF.tab $tab_payable_credit_notes
			SF.select_view $bd_select_view_all
            SF.click_button_go

            _payable_credit_note_number = FFA.get_column_value_in_grid $label_vendor_credit_note_number, vendor_credit_note_number, $label_credit_note_number
            PCR.open_credit_note_detail_page _payable_credit_note_number
            
            #Comparing Posted Payable Credit Note values
            CIF_PCN.compare_pcn_header_details(nil, nil, $bd_currency_eur, '100.00', '10.00', '110.00', $bd_document_status_complete)
        end
		gen_end_test "TST036739: Verify the Save,Post & New button on Payable Credit Note"
	end
	
	it "TID021230 : Verify the Save,Post & New button on Journal" do
		gen_start_test "TST036740: Verify the Save,Post & New button on Journal"
		login_user
		_JOURNAL_REFERENCE = 'JNL' + _SUFFIX
		_reference_column_name = 'Reference'
		_net_value_1 = '100.00'
		_net_value_negative_2 = '-100.00'
        begin
			#Create Journal
			SF.tab $tab_journals
			SF.click_button_new
			CIF.wait_for_buttons_to_load
			CIF_JNL.set_journal_reference _JOURNAL_REFERENCE

			#add line items
			CIF.click_new_row
			CIF_JNL.set_line_type $bd_jnl_line_type_account_customer
			CIF_JNL.set_gla $bd_gla_sales_parts
			CIF_JNL.set_account $bd_account_cambridge_auto
			CIF_JNL.set_value _net_value_1,1

			CIF_JNL.set_line_type $bd_jnl_line_type_account_vendor, 2
			CIF_JNL.click_toggle_button
			CIF_JNL.set_gla $bd_gla_sales_hardware, 2
			CIF_JNL.set_account $bd_account_bmw_automobiles, 2
			CIF_JNL.set_value _net_value_negative_2, 2
			CIF_JNL.click_toggle_button
			CIF.click_save_post_new_button

			CIF.wait_for_buttons_to_load
			CIF_JNL.compare_journal_header_details(nil,nil,nil,nil,nil,nil,nil,'0.00','0.00','0.00')
			current_page_url = page.current_url
			gen_include _save_new_url_string, current_page_url , 'Expected New Journal page to be opened'
			
            SF.tab $tab_journals
            SF.select_view $bd_select_view_all
            SF.click_button_go
            _journal_number = FFA.get_column_value_in_grid _reference_column_name, _JOURNAL_REFERENCE, $label_journal_number
            JNL.open_journal_detail_page _journal_number

            #Comparing Posted Journal values
            CIF_JNL.compare_journal_header_details(nil,nil,$bd_currency_eur,_JOURNAL_REFERENCE,nil,$bd_jnl_type_manual_journal, $bd_document_status_complete,'100.00','-100.00','0.00')
        end
		gen_end_test "TST036740: Verify the Save,Post & New button on Journal"
	end
	
	it "TID021230 : Verify the Save,Post & New button on Cash Entry" do
		gen_start_test "TST036741: Verify the Save,Post & New button on Cash Entry"
		login_user
		_reference = 'CE' + _SUFFIX
		_description = "Test Save Post New"
        begin
			#Create Cash Entry
            SF.tab $tab_cash_entries
			SF.click_button_new
			CIF.wait_for_buttons_to_load
			#Header
			CIF_CE.set_ce_type $bd_cash_entry_receipt_type
			CIF_CE.set_ce_bank_account $bd_bank_account_santander_current_account
			CIF_CE.set_description _description
			CIF_CE.set_ce_reference _reference

			#Line item
			CIF_CE.click_new_row
			CIF_CE.set_ce_account $bd_account_apex_eur_account
			CIF_CE.set_ce_cash_entry_value 1000.00
			
			CIF.click_save_post_new_button
			CIF_CE.compare_ce_header_details(nil, nil, nil, '0.00','','','0.00', nil)
			current_page_url = page.current_url
			gen_include _save_new_url_string, current_page_url , 'Expected New Cash Entry page to be opened'
			
			SF.tab $tab_cash_entries
			SF.select_view $bd_select_view_all
            SF.click_button_go
            _cash_entry_number = FFA.get_column_value_in_grid $label_cash_entry_reference, _reference, $label_cashentry_number
            CE.open_cash_entry_detail_page _cash_entry_number

            #Comparing Posted Cash Entry values
            gen_compare _description, CIF_CE.get_ce_description, "Expected Description is Test Save Post New"
			CIF_CE.compare_ce_header_details(nil, nil, nil, '1,000.00', '1,000.00', '1,000.00', '1,000.00', $bd_document_status_complete)
        end
		gen_end_test "TST036741: Verify the Save,Post & New button on Cash Entry"
    end
    
    after :all do
        login_user
		FFA.delete_new_data_and_wait
        SF.logout

        gen_end_test "TID021230: Verify the functionality of Save, Post & New button on CIF documents"    
    end
end