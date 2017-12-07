#--------------------------------------------------------------------#
#   TID : TID019984 
#   Pre-Requisite : Base data should exist on the org.
#   Product Area: CIF
#   How to run : rspec spec/UI/cif_tests/cif_amend_TID019984.rb -fh -o cif_amend.html
#--------------------------------------------------------------------#

describe "TID019984:This TID verifies the 'Amend' functionality on all CIF documents", :type => :request do
	include_context "login"
	include_context "logout_after_each"
	_SUFFIX = 'TID019984'
	_amend_line_description = $bd_product_auto_com_clutch_kit_1989_dodge_raider + ' amended'
	before :all do
		gen_start_test "TID019984: Verify 'Amend' functionality on all CIF documents"
		SF.app $accounting
		begin
			_create_data = ["CODATID019984Data.selectCompany();", "CODATID019984Data.createData();","CODATID019984Data.createDataExt1();","CODATID019984Data.createDataExt2();","CODATID019984Data.createDataExt3();","CODATID019984Data.createDataExt4();", "CODATID019984Data.createDataExt5();","CODATID019984Data.createDataExt6();"]
			APEX.execute_commands _create_data
		end
	end

    it "TID019984 : Clicking Amend button for SINV" , :unmanaged => true  do
		gen_start_test "TST032570: Verify 'Amend' functionality on SINV"
		_amend_description = 'Amend Sales Invoice Description'
		_amend_customer_reference = "Amend SIN#{_SUFFIX}"
        begin
            SF.tab $tab_sales_invoices
            SF.select_view $bd_select_view_all
            SF.click_button_go
			SF.edit_list_view $bd_select_view_all , $label_invoice_status ,4
            _sales_invoice_number = FFA.get_column_value_in_grid $label_invoice_status, $bd_document_status_complete, $label_invoice_number
            SIN.open_invoice_detail_page _sales_invoice_number
			CIF.wait_for_actions_to_complete $cif_buttons_loading_wait_message
			#Compare existing values
			CIF.click_toggle_button
            gen_compare $bd_document_status_complete, CIF_SINV.get_invoice_status, "Expected SINV status is Complete"
			gen_compare 'SINTID019984', CIF_SINV.get_customer_reference, "Expected SINV Customer Reference is SINTID019984"
			gen_compare 'Sales Invoice Description', CIF_SINV.get_invoice_description, "Expected Description is Sales Invoice Description"
			gen_compare $bd_product_auto_com_clutch_kit_1989_dodge_raider, CIF_SINV.get_column_value_from_grid_data_row_on_view_page(1, CIF_SINV::SALES_INVOICE_COLUMN_LINE_DESCRIPTION), "SINV line description is #{$bd_product_auto_com_clutch_kit_1989_dodge_raider}"
			gen_compare $bd_dim1_eur, CIF_SINV.get_column_value_from_grid_data_row_on_view_page(1, CIF_SINV::SALES_INVOICE_COLUMN_UNIT_DIMENSION_1), "SINV line dimension 1 is #{$bd_dim1_eur}"
						
			#Amend Sales Invoice
            CIF.click_amend_button
            CIF_SINV.set_sinv_invoice_description _amend_description
			CIF_SINV.set_sinv_customer_reference _amend_customer_reference
			CIF_SINV.click_column_grid_data_row_amend_page 1, CIF_SINV::SALES_INVOICE_COLUMN_UNIT_DIMENSION_1
			CIF_SINV.set_sinv_line_dimesion_1 $bd_apex_eur_001
			CIF_SINV.click_column_grid_data_row_amend_page 1, CIF_SINV::SALES_INVOICE_COLUMN_LINE_DESCRIPTION
			CIF_SINV.set_sinv_line_line_description _amend_line_description
			CIF.click_toggle_button
			CIF_SINV.click_sinv_save_button
			gen_wait_until_object_disappear $cif_save_button
			CIF.click_toggle_button
			#Comparing Result for Amended Invoice
			gen_compare _amend_customer_reference, CIF_SINV.get_customer_reference, "Expected customer reference is #{_amend_customer_reference}"
			gen_compare _amend_description, CIF_SINV.get_invoice_description, "Expected description is #{_amend_description}"
			gen_compare _amend_line_description, CIF_SINV.get_column_value_from_grid_data_row_on_view_page(1, CIF_SINV::SALES_INVOICE_COLUMN_LINE_DESCRIPTION), "SINV line description is #{_amend_line_description}"
			gen_compare $bd_apex_eur_001, CIF_SINV.get_column_value_from_grid_data_row_on_view_page(1, CIF_SINV::SALES_INVOICE_COLUMN_UNIT_DIMENSION_1), "SINV line dimension 1 is #{$bd_apex_eur_001}"
		
			#Verify Transaction
			CIF.click_transaction_link
			_document_description = TRANX.get_transaction_document_description
			_document_reference = TRANX.get_transaction_document_reference
			gen_compare _amend_description, _document_description, "Expected Document Description on Transaction is #{_amend_description}"
			gen_compare _amend_customer_reference, _document_reference, "Expected Document Reference on Transaction is #{_amend_customer_reference}"
			TRANX.assert_transaction_line_item $tranx_analysis_label, _amend_line_description
			TRANX.click_on_analysis_line_item
			_dimension1_value = TRANX.get_analysis_line_item_dimension1_value
			gen_compare $bd_apex_eur_001, _dimension1_value, "Expected Dimension 1 value of analysis line type is #{$bd_apex_eur_001}"
        end
		gen_end_test "TST032570: Verify 'Amend' functionality on SINV"
	end
	
	it "TID019984 : Clicking Amend button for SCRN" , :unmanaged => true  do
		gen_start_test "TST032571: Verify 'Amend' functionality on SCRN"
		login_user
		_amend_description = 'Amend Sales Credit Note Description'
		_amend_customer_reference = "Amend SCN#{_SUFFIX}"
		_credit_note_total  = '115.65'
        begin
            SF.tab $tab_sales_credit_notes
            SF.select_view $bd_select_view_all
            SF.click_button_go
            _credit_note_number = FFA.get_column_value_in_grid $label_credit_note_total, _credit_note_total, $label_credit_note_number
            SCR.open_credit_note_detail_page _credit_note_number
            CIF.wait_for_actions_to_complete $cif_buttons_loading_wait_message
            #Compare Existing Values
            gen_compare $bd_document_status_complete, CIF_SCN.get_crn_document_status, "Expected SCRN document status is Complete"
            gen_compare 'SCNTID019984', CIF_SCN.get_crn_customer_reference, "Expected SCRN Customer Reference is SCNTID019984"
            gen_compare 'Sales Credit Note Description', CIF_SCN.get_crn_description, "Expected Description is Sales Credit Note Description"
            gen_compare $bd_product_auto_com_clutch_kit_1989_dodge_raider, CIF_SCN.get_column_value_from_grid_data_row_on_view_page(1, CIF_SCN::SALES_CREDIT_NOTE_COLUMN_LINE_DESCRIPTION), "Line description is #{$bd_product_auto_com_clutch_kit_1989_dodge_raider}"
            gen_compare $bd_dim1_eur, CIF_SCN.get_column_value_from_grid_data_row_on_view_page(1, CIF_SCN::SALES_CREDIT_NOTE_COLUMN_UNIT_DIMENSION_1), "Dimension 1 on Line is #{$bd_dim1_eur}"

            #Amend Sales Credit Note
            CIF.click_amend_button
            CIF_SCN.set_description _amend_description
            CIF_SCN.set_customer_reference _amend_customer_reference
            CIF_SCN.set_scn_line_item_dimesion_1 $bd_apex_eur_001
            CIF_SCN.set_scn_line_item_dimesion_2 nil
            CIF_SCN.set_scn_line_item_line_description _amend_line_description
            CIF.click_toggle_button
            CIF_SCN.click_save_button

            #Comparing Amended Values
            gen_compare _amend_customer_reference, CIF_SCN.get_crn_customer_reference, "Expected Customer Reference is #{_amend_customer_reference}"
            gen_compare _amend_description, CIF_SCN.get_crn_description, "Expected description is #{_amend_description}"
            gen_compare _amend_line_description, CIF_SCN.get_column_value_from_grid_data_row_on_view_page(1, CIF_SCN::SALES_CREDIT_NOTE_COLUMN_LINE_DESCRIPTION), "Line description is #{$_amend_line_description}"
            gen_compare $bd_apex_eur_001, CIF_SCN.get_column_value_from_grid_data_row_on_view_page(1, CIF_SCN::SALES_CREDIT_NOTE_COLUMN_UNIT_DIMENSION_1), "Dimension 1 on Line is #{$bd_apex_eur_001}"

            #Verify Transaction
            CIF.click_transaction_link
            _document_description = TRANX.get_transaction_document_description
            _document_reference = TRANX.get_transaction_document_reference
            gen_compare _amend_description, _document_description, "Expected Document Description on Transaction is #{_amend_description}"
            gen_compare _amend_customer_reference, _document_reference, "Expected Document Reference on Transaction is #{_amend_customer_reference}"
            TRANX.assert_transaction_line_item $tranx_analysis_label, _amend_line_description
            TRANX.click_on_analysis_line_item
            _dimension1_value = TRANX.get_analysis_line_item_dimension1_value
            gen_compare $bd_apex_eur_001, _dimension1_value, "Expected Dimension 1 value of analysis line type is #{$bd_apex_eur_001}"

            gen_end_test "TST032571: Verify 'Amend' functionality on SCRN"
        end
		gen_end_test "TST032571: Verify 'Amend' functionality on SCRN"
	end
	
	it "TID019984 : Clicking Amend button for PINV" , :unmanaged => true  do	
		gen_start_test "TST032573: Verify 'Amend' functionality on PINV"
		login_user
		_amend_description = 'Amend Payable Invoice Description'
		_PINV_REFERENCE = 'PINV'+_SUFFIX
		_vendor_invoice_number_column_name = 'Vendor Invoice Number'
		_payable_invoice_number_column = 'Payable Invoice Number'
		_due_date = Date.today + 1
		_amend_date = _due_date + 1
        begin
            SF.tab $tab_payable_invoices
            SF.select_view $bd_select_view_all
            SF.click_button_go
            _payable_invoice_number = FFA.get_column_value_in_grid _vendor_invoice_number_column_name, _PINV_REFERENCE, _payable_invoice_number_column
            PIN.open_invoice_detail_page _payable_invoice_number

            #Comparing Existing values
            gen_compare $bd_document_status_complete,  CIF_PINV.get_payable_invoice_status, "Expected PIN should be with Complete status"
            gen_compare _due_date.strftime("%d/%m/%Y"), CIF_PINV.get_payable_invoice_due_date, "Expected Payable Invoice Due Date is #{_due_date.strftime("%d/%m/%Y")}"
            gen_compare 'Payable Invoice Description', CIF_PINV.get_payable_invoice_description, "Expected Description is Payable Invoice Description"
            
            CIF_PINV.click_payable_invoice_line_items_tab
            CIF.click_toggle_button
            gen_compare $bd_product_auto_com_clutch_kit_1989_dodge_raider, CIF_PINV.get_column_value_from_grid_data_row_on_view_page(1, $cif_payable_invoice_line_item_line_description_column_number), "Line description is #{$bd_product_auto_com_clutch_kit_1989_dodge_raider}"
            gen_compare $bd_dim1_eur, CIF_PINV.get_column_value_from_grid_data_row_on_view_page(1, $cif_payable_invoice_line_item_dimension1_column_number), "Dimension 1 on Line is #{$bd_dim1_eur}"
            
            #Amend Payable Invoice
            CIF.click_amend_button
            CIF_PINV.set_pinv_invoice_description _amend_description
            CIF_PINV.set_pinv_invoice_due_date _amend_date.strftime("%d/%m/%Y")
            CIF_PINV.click_payable_invoice_line_items_tab
            CIF.click_toggle_button
            CIF_PINV.click_column_grid_data_row_on_amend_page 1, $cif_payable_invoice_line_item_dimension1_column_number
            CIF_PINV.set_pinv_line_dimesion_1 $bd_apex_eur_001
            CIF_PINV.click_column_grid_data_row_on_amend_page 1, $cif_payable_invoice_line_item_line_description_column_number
			CIF_PINV.set_pinv_line_line_description _amend_line_description
			CIF_PINV.click_column_grid_data_row_on_amend_page 1, $cif_payable_invoice_line_item_dimension1_column_number
            CIF_PINV.click_pinv_save_button
            gen_wait_until_object_disappear $cif_save_button
			CIF.click_toggle_button
            #Comparing Amended values
            gen_compare _amend_date.strftime("%d/%m/%Y"), CIF_PINV.get_payable_invoice_due_date, "Expected Payable Invoice Due Date is #{_amend_date.strftime("%d/%m/%Y")}"
            gen_compare _amend_description, CIF_PINV.get_payable_invoice_description, "Expected Payable Invoice Description is #{_amend_description}"
            
            CIF_PINV.click_payable_invoice_line_items_tab
            CIF.click_toggle_button
            gen_compare _amend_line_description, CIF_PINV.get_column_value_from_grid_data_row_on_view_page(1, $cif_payable_invoice_line_item_line_description_column_number), "Line description is #{_amend_line_description}"
            gen_compare $bd_apex_eur_001, CIF_PINV.get_column_value_from_grid_data_row_on_view_page(1, $cif_payable_invoice_line_item_dimension1_column_number), "Dimension 1 on Line is #{$bd_apex_eur_001}"
                        
            #Verify Transaction
            CIF.click_transaction_link
            _document_description = TRANX.get_transaction_document_description
            gen_compare _amend_description, _document_description, "Expected Document Description on Transaction is #{_amend_description}"
    
            TRANX.assert_transaction_line_item $tranx_analysis_label, _amend_line_description
            TRANX.click_on_analysis_line_item
            _dimension1_value = TRANX.get_analysis_line_item_dimension1_value
            _due_date_value = TRANX.get_analysis_line_item_due_date_value
            gen_compare $bd_apex_eur_001, _dimension1_value, "Expected Dimension 1 value of analysis line type is #{$bd_apex_eur_001}"
            gen_compare _amend_date.strftime("%d/%m/%Y"), _due_date_value, "Expected Dimension 1 value of analysis line type is #{_amend_date.strftime("%d/%m/%Y")}"
        end
		gen_end_test "TST032573: Verify 'Amend' functionality on PINV"
	end
	
	it "TID019984 : Clicking Amend button for PCRN" , :unmanaged => true  do
		gen_start_test "TST032573: Verify 'Amend' functionality on PCRN"
		login_user
		_PCRN_REFERENCE = 'PCRN'+_SUFFIX
		_vendor_credit_note_number_column_name = 'Vendor Credit Note Number'
		_due_date = Date.today + 1
		_amend_date = _due_date + 1
		_amend_description = 'Amend Payable Credit Note Description'
        begin
            SF.tab $tab_payable_credit_notes
            SF.select_view $bd_select_view_all
            SF.click_button_go
            _payable_credit_note_number = FFA.get_column_value_in_grid _vendor_credit_note_number_column_name, _PCRN_REFERENCE, $label_credit_note_number
            PCR.open_credit_note_detail_page _payable_credit_note_number
            
            #Comparing Existing values
            gen_compare $bd_document_status_complete,  CIF_PCN.get_payable_credit_note_status, "Expected PCN should be with Complete status"
            gen_compare 'Payable Credit Note Description', CIF_PCN.get_payable_credit_note_description, "Expected Description is Payable Credit Note Description"
            gen_compare _due_date.strftime("%d/%m/%Y"), CIF_PCN.get_payable_credit_note_due_date, "Expected Payable Credit Note Due Date is #{_due_date.strftime("%d/%m/%Y")}"
            CIF_PCN.click_payable_credit_note_line_items_tab
            CIF.click_toggle_button
            gen_compare $bd_product_auto_com_clutch_kit_1989_dodge_raider, CIF_PCN.get_column_value_from_grid_data_row_on_view_page(1, CIF_PCN::PAYABLE_CREDIT_NOTE_PRODUCT_LINE_COLUMN_LINE_DESCRIPTION), "Line description is #{$bd_product_auto_com_clutch_kit_1989_dodge_raider}"
            gen_compare $bd_dim1_eur, CIF_PCN.get_column_value_from_grid_data_row_on_view_page(1, CIF_PCN::PAYABLE_CREDIT_NOTE_PRODUCT_LINE_COLUMN_DIMENSION_1), "Dimension 1 on Line is #{$bd_dim1_eur}"
            
            #Amend Payable Credit Note
            CIF.click_amend_button
            CIF_PCN.set_pcn_description _amend_description
            CIF_PCN.set_pcn_due_date _amend_date.strftime("%d/%m/%Y")
            
            CIF_PCN.click_payable_credit_note_line_items_tab
            CIF.click_toggle_button
            CIF_PCN.click_column_grid_data_row_on_amend_page 1, CIF_PCN::PAYABLE_CREDIT_NOTE_PRODUCT_LINE_COLUMN_DIMENSION_1
            CIF_PCN.set_pcn_line_dimesion_1 $bd_apex_eur_001
            CIF_PCN.click_column_grid_data_row_on_amend_page 1, CIF_PCN::PAYABLE_CREDIT_NOTE_PRODUCT_LINE_COLUMN_LINE_DESCRIPTION
            CIF_PCN.set_pcn_line_description _amend_line_description
            CIF_PCN.click_pcrn_save_button
            
            #Comparing Amended values
            gen_compare _amend_description, CIF_PCN.get_payable_credit_note_description, "Expected Payable Credit Note Description is #{_amend_description}"
            gen_compare _amend_date.strftime("%d/%m/%Y"), CIF_PCN.get_payable_credit_note_due_date, "Expected Payable Credit Note Due Date is #{_amend_date.strftime("%d/%m/%Y")}"
            CIF_PCN.click_payable_credit_note_line_items_tab
            CIF.click_toggle_button
            gen_compare _amend_line_description, CIF_PCN.get_column_value_from_grid_data_row_on_view_page(1, CIF_PCN::PAYABLE_CREDIT_NOTE_PRODUCT_LINE_COLUMN_LINE_DESCRIPTION), "Line description is #{_amend_line_description}"
            gen_compare $bd_apex_eur_001, CIF_PCN.get_column_value_from_grid_data_row_on_view_page(1, CIF_PCN::PAYABLE_CREDIT_NOTE_PRODUCT_LINE_COLUMN_DIMENSION_1), "Dimension 1 on Line is #{$bd_apex_eur_001}"
            
            #Verify Transaction
            CIF.click_transaction_link
            _document_description = TRANX.get_transaction_document_description
            gen_compare _amend_description, _document_description, "Expected Document Description on Transaction is #{_amend_description}"
    
            TRANX.assert_transaction_line_item $tranx_analysis_label, _amend_line_description
            TRANX.click_on_analysis_line_item
            _dimension1_value = TRANX.get_analysis_line_item_dimension1_value
            _due_date_value = TRANX.get_analysis_line_item_due_date_value
            gen_compare $bd_apex_eur_001, _dimension1_value, "Expected dimension 1 value of analysis line type is #{$bd_apex_eur_001}"
            gen_compare _amend_date.strftime("%d/%m/%Y"), _due_date_value, "Expected dimension 1 value of analysis line type is #{_amend_date.strftime("%d/%m/%Y")}"
        end
		gen_end_test "TST032573: Verify 'Amend' functionality on PCRN"
	end
	
	it "TID019984 : Clicking Amend button for Journal" , :unmanaged => true  do
		gen_start_test "TST032574: Verify 'Amend' functionality on Journal"
		login_user
		_JOURNAL_REFERENCE = 'JNL'+_SUFFIX
		_reference_column_name = 'Reference'
		_journal_number_column = 'Journal Number'
		_amend_reference = 'Amend' + _JOURNAL_REFERENCE
		_amend_description = 'Amend Journal Description'
        begin
            SF.tab $tab_journals
            SF.select_view $bd_select_view_all
            SF.click_button_go
            _journal_number = FFA.get_column_value_in_grid _reference_column_name, _JOURNAL_REFERENCE, _journal_number_column
            JNL.open_journal_detail_page _journal_number

            #Comparing Existing values
            gen_compare $bd_document_status_complete,  CIF_JNL.get_journal_document_status, "Expected JRNL should be with In Progress status"
            gen_compare _JOURNAL_REFERENCE, CIF_JNL.get_journal_reference, "Journal Reference is #{_JOURNAL_REFERENCE}"
            gen_compare 'Journal Description', CIF_JNL.get_journal_document_description, "Description is Journal Description"
            gen_compare $bd_product_auto_com_clutch_kit_1989_dodge_raider, CIF_JNL.get_column_value_from_grid_data_row_on_view_page(2, CIF_JNL::CIF_JOURNAL_COLUMN_LINE_DESCRIPTION), "Line Description is #{$bd_product_auto_com_clutch_kit_1989_dodge_raider}"
            gen_compare $bd_dim1_eur, CIF_JNL.get_column_value_from_grid_data_row_on_view_page(2, CIF_JNL::CIF_JOURNAL_COLUMN_DIMENSION_1), "Dimension 1 value is #{$bd_dim1_eur}"

            #Amend Journal
            CIF.click_amend_button
            CIF_JNL.set_journal_reference _amend_reference
            CIF_JNL.set_journal_description _amend_description
            CIF_JNL.set_line_description _amend_line_description, 2
            CIF_JNL.set_dimesion_1 $bd_apex_eur_001, 2
            CIF_JNL.click_toggle_button
            CIF_JNL.click_journal_save_button

            #Comparing Amended values
            gen_compare _amend_reference, CIF_JNL.get_journal_reference, "Journal Reference is #{_amend_reference}"
            gen_compare _amend_description, CIF_JNL.get_journal_document_description, "Journal Description is #{_amend_description}"
            gen_compare _amend_line_description, CIF_JNL.get_column_value_from_grid_data_row_on_view_page(2, CIF_JNL::CIF_JOURNAL_COLUMN_LINE_DESCRIPTION), "Expected Line Description is #{_amend_line_description}"
            gen_compare $bd_apex_eur_001, CIF_JNL.get_column_value_from_grid_data_row_on_view_page(2, CIF_JNL::CIF_JOURNAL_COLUMN_DIMENSION_1), "Expected Dimension 1 value is #{$bd_apex_eur_001}"

            #Verify Transaction
            CIF.click_transaction_link
            _document_description = TRANX.get_transaction_document_description
            _document_reference = TRANX.get_transaction_document_reference
            gen_compare _amend_description, _document_description, "Expected Document Description on Transaction is #{_amend_description}"
            gen_compare _amend_reference, _document_reference, "Expected Document Reference on Transaction is #{_amend_reference}"
    
            TRANX.assert_transaction_line_item $tranx_analysis_label, _amend_line_description
            TRANX.click_on_analysis_line_item
            _dimension1_value = TRANX.get_analysis_line_item_dimension1_value
            gen_compare $bd_apex_eur_001, _dimension1_value, "Expected dimension 1 value of analysis line type is #{$bd_apex_eur_001}"
        end
		gen_end_test "TST032574: Verify 'Amend' functionality on Journal"
	end
	
	it "TID019984 : Clicking Amend button for Cash Entry" , :unmanaged => true  do
		gen_start_test "TST032575: Verify 'Amend' functionality on Cash Entry"
		login_user
		_CE_REFERENCE = 'CE'+_SUFFIX
		_amend_reference = 'Amend ' + _CE_REFERENCE
		_amend_description = 'Amend Cash Entry Description'
        begin
            SF.tab $tab_cash_entries
            SF.select_view $bd_select_view_all
            SF.click_button_go
            _cash_entry_number = FFA.get_column_value_in_grid $label_cash_entry_reference, _CE_REFERENCE, $label_cashentry_number
            CE.open_cash_entry_detail_page _cash_entry_number

            #Comparing Existing values
            gen_compare $bd_document_status_complete,  CIF_CE.get_ce_document_status, "Expected CE should be with Complete status"
            gen_compare _CE_REFERENCE, CIF_CE.get_ce_reference, "Expected Cash Entry Reference is #{_CE_REFERENCE}"
            gen_compare 'Cash Entry Description', CIF_CE.get_ce_description, "Expected Description is Cash Entry Description"
            gen_compare _CE_REFERENCE, CIF_CE.get_column_value_from_grid_data_row_on_view_page(1, CIF_CE::CASH_ENTRY_ACCOUNT_REFERENCE_VALUE), "Expected Account Reference value is #{_CE_REFERENCE}"

            #Amend Payable Cash Entry
            CIF.click_amend_button
            CIF_CE.set_ce_reference _amend_reference
            CIF_CE.set_description _amend_description
            CIF_CE.click_column_grid_data_row_amend_page 1, CIF_CE::CASH_ENTRY_ACCOUNT_REFERENCE_VALUE
            CIF_CE.set_ce_line_item_account_ref _amend_reference
            CIF_CE.click_ce_save_button

            #Comparing Amended values
            gen_compare _amend_reference, CIF_CE.get_ce_reference, "Expected Cash Entry Reference is #{_amend_reference}"
            gen_compare _amend_description, CIF_CE.get_ce_description, "Expected Cash Entry Description is #{_amend_description}"
            gen_compare _amend_reference, CIF_CE.get_column_value_from_grid_data_row_on_view_page(1, CIF_CE::CASH_ENTRY_ACCOUNT_REFERENCE_VALUE), "Expected Account Reference value is #{_amend_reference}"

            #Verify Transaction
            CIF.click_transaction_link
            _document_description = TRANX.get_transaction_document_description
            _document_reference = TRANX.get_transaction_document_reference
            gen_compare _amend_description, _document_description, "Expected Document Description on Transaction is #{_amend_description}"
            gen_compare _amend_reference, _document_reference, "Expected Document Reference on Transaction is #{_amend_reference}"
    
            TRANX.click_on_account_line_item
            _account_reference_value = TRANX.get_account_line_item_account_line_reference_value
            gen_compare _amend_reference, _account_reference_value, "Expected Account Reference value of Account line type is #{_amend_reference}"
        end
		gen_end_test "TST032575: Verify 'Amend' functionality on Cash Entry"
    end
    
    after :all do
        login_user
        _destroy_data_TID019984 = ["CODATID019984Data.destroyData();"]
        APEX.execute_commands _destroy_data_TID019984
        gen_end_test "TID019984: Verify 'Amend' functionality on all CIF documents"    
    end
end