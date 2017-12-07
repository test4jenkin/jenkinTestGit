#--------------------------------------------------------------------#
#   TID : TID019833 
#   Pre-Requisite : Base data should exist on the org.
#   Product Area: CIF
#   How to run : rspec spec/UI/cif_tests/cif_discard_TID019833.rb -fh -o cif_discard.html
#--------------------------------------------------------------------#

describe "TID019833:This TID verifies the 'Discard' functionality on all CIF documents", :type => :request do
    include_context "login"
	include_context "logout_after_each"
    before :all do
        gen_start_test "TID019833: Verify 'Discard' functionality on all CIF documents"
        SF.app $accounting
        begin
			#delete data if exists on org due to some failure of previous execution
			_destroy_data_TID019833 = ["CODATID019833Data.destroyData();"]
			APEX.execute_commands _destroy_data_TID019833
		
            _create_data = ["CODATID019833Data.selectCompany();", "CODATID019833Data.createData();","CODATID019833Data.createDataExt1();","CODATID019833Data.createDataExt2();","CODATID019833Data.createDataExt3();","CODATID019833Data.createDataExt4();", "CODATID019833Data.createDataExt5();"]
            APEX.execute_commands _create_data
        end
    end
    
    it "TID019833 : Clicking Discard button for all the documents", :unmanaged => true  do
        _SUFFIX = 'TID019833'
        begin
            gen_start_test "TST032363: Verify 'Discard' functionality on SINV"
            _discard_description = 'Discard Sales invoice'

            SF.tab $tab_sales_invoices
            SF.select_view $bd_select_view_all
            SF.click_button_go
			SF.edit_list_view $bd_select_view_all, $label_invoice_total, 5
            _sales_invoice_number = FFA.get_column_value_in_grid "Invoice Total","116.63", $label_invoice_number
            SIN.open_invoice_detail_page _sales_invoice_number
            gen_compare $bd_document_status_in_progress, CIF_SINV.get_invoice_status, "Expected SINV should be with In Progress status"

            #Discard Sales Invoice
            CIF.click_discard_button
            CIF.set_discard_reason _discard_description
            CIF.click_popup_discard_button
            gen_compare $bd_document_status_discarded, CIF_SINV.get_invoice_status, "Expected SINV should be with Discarded status"
            gen_end_test "TST032363: Verify 'Discard' functionality on SINV"
        end

        begin
            gen_start_test "TST032364: Verify 'Discard' functionality on SCRN"
            _discard_description = 'Discard Sales Credit Note'
            _credit_note_total  = '126.08'

            SF.tab $tab_sales_credit_notes
            SF.select_view $bd_select_view_all
            SF.click_button_go
           
            _credit_note_number = FFA.get_column_value_in_grid $label_credit_note_total, _credit_note_total, $label_credit_note_number
            SCR.open_credit_note_detail_page _credit_note_number
            gen_compare $bd_document_status_in_progress, CIF_SCN.get_crn_document_status, "Expected SCRN should be with In Progress status"

            #Discard Sales Credit Note
            CIF.click_discard_button
            CIF.set_discard_reason _discard_description
            CIF.click_popup_discard_button
            gen_compare $bd_document_status_discarded, CIF_SCN.get_crn_document_status, "Expected SCRN should be with Discarded status"
            gen_end_test "TST032364: Verify 'Discard' functionality on SCRN"
        end

        begin
            gen_start_test "TST032365: Verify 'Discard' functionality on PINV"
            _discard_description = 'Discard Payable invoice'
            _PINV_REFERENCE = 'PINV'+_SUFFIX
            _vendor_invoice_number_column_name = 'Vendor Invoice Number'
            _payable_invoice_number_column = 'Payable Invoice Number'

            SF.tab $tab_payable_invoices
            SF.select_view $bd_select_view_all
            SF.click_button_go
            _payable_invoice_number = FFA.get_column_value_in_grid _vendor_invoice_number_column_name, _PINV_REFERENCE, _payable_invoice_number_column
            PIN.open_invoice_detail_page _payable_invoice_number
            gen_compare $bd_document_status_in_progress,  CIF_PINV.get_payable_invoice_status, "Expected PIN should be with In Progress status"

            #Discard Payable Invoice
            CIF.click_discard_button
            CIF.set_discard_reason _discard_description
            CIF.click_popup_discard_button
            gen_compare $bd_document_status_discarded,  CIF_PINV.get_payable_invoice_status, "Expected PIN should be with Discarded status"
            gen_end_test "TST032365: Verify 'Discard' functionality on PINV"
        end

        begin
            gen_start_test "TST032366: Verify 'Discard' functionality on PCRN"
            _discard_description = 'Discard Payable Credit Note'
            _PCRN_REFERENCE = 'PCRN'+_SUFFIX
            _vendor_credit_note_number_column_name = 'Vendor Credit Note Number'

            SF.tab $tab_payable_credit_notes
            SF.select_view $bd_select_view_all
            SF.click_button_go
            _payable_credit_note_number = FFA.get_column_value_in_grid _vendor_credit_note_number_column_name, _PCRN_REFERENCE, $label_credit_note_number
            PCR.open_credit_note_detail_page _payable_credit_note_number
            gen_compare $bd_document_status_in_progress,  CIF_PCN.get_payable_credit_note_status, "Expected PCN should be with In Progress status"

            #Discard Payable Credit Note
            CIF.click_discard_button
            CIF.set_discard_reason _discard_description
            CIF.click_popup_discard_button
            gen_compare $bd_document_status_discarded,  CIF_PCN.get_payable_credit_note_status, "Expected PCN should be with Discarded status"
            gen_end_test "TST032366: Verify 'Discard' functionality on PCRN"
        end

        begin
            gen_start_test "TST032367: Verify 'Discard' functionality on Cash Entry"
            _discard_description = 'Discard Cash Entry'
            _CE_REFERENCE = 'CE'+_SUFFIX

            SF.tab $tab_cash_entries
            SF.select_view $bd_select_view_all
            SF.click_button_go
            _cash_entry_number = FFA.get_column_value_in_grid $label_cash_entry_reference, _CE_REFERENCE, $label_cashentry_number
            CE.open_cash_entry_detail_page _cash_entry_number
            gen_compare $bd_document_status_in_progress,  CIF_CE.get_ce_document_status, "Expected CE should be with In Progress status"

            #Discard Payable Cash Entry
            CIF.click_discard_button
            CIF.set_discard_reason _discard_description
            CIF.click_popup_discard_button
            gen_compare $bd_document_status_discarded, CIF_CE.get_ce_document_status, "Expected CE should be with Discarded status"
            gen_end_test "TST032367: Verify 'Discard' functionality on Cash Entry"
        end

        begin
            gen_start_test "TST032368: Verify 'Discard' functionality on Journal"
            _discard_description = 'Discard Journal'
            _JOURNAL_REFERENCE = 'JNL'+_SUFFIX
            _reference_column_name = 'Reference'
            _journal_number_column = 'Journal Number'

            SF.tab $tab_journals
            SF.select_view $bd_select_view_all
            SF.click_button_go
            _journal_number = FFA.get_column_value_in_grid _reference_column_name, _JOURNAL_REFERENCE, _journal_number_column
            JNL.open_journal_detail_page _journal_number
            gen_compare $bd_document_status_in_progress,  CIF_JNL.get_journal_document_status, "Expected JRNL should be with In Progress status"

            #Discard Journal
            CIF.click_discard_button
            CIF.set_discard_reason _discard_description
            CIF.click_popup_discard_button
            gen_compare $bd_document_status_discarded, CIF_JNL.get_journal_document_status, "Expected JRNL should be with Discarded status"
            gen_end_test "TST032368: Verify 'Discard' functionality on Journal"
        end
    end
    
    after :all do
        login_user
        _destroy_data_TID019833 = ["CODATID019833Data.destroyData();"]
        APEX.execute_commands _destroy_data_TID019833
        SF.logout

        gen_end_test "TID019833: Verify 'Discard' functionality on all CIF documents"    
    end
end