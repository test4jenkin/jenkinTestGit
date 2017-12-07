#--------------------------------------------------------------------#
# TID : TID020934
# Pre-Requisite: org with base data and deploy CODATID020934Data.cls on org
# Product Area: Accounting - Document Volume - Payable Invoices/Credit Notes
# Story: 38147 
#--------------------------------------------------------------------#

describe "TID020934 : PIN / PCR document limits - VAT company(CIF)", :type => :request do
	_pin1_number = "PIN000001"
	_pin2_number = "PIN000002"
	_pcn1_number = "PCR000001"
	_pcn2_number = "PCR000002"
	_gla_vat = "VAT_GLA_"
	_product_vat = "PROD_VAT_"
	_dim_1 = "Dim 1-EUR-"
	_dim_2 = "Dim 2-EUR-"
	_dim_3 = "Dim 3-EUR-"
	_dim_4 = "Dim 4-EUR-"
	_input_tax_code = "VO-EC Purchase"
	_vendor_invoice_number_column_name = 'Vendor Invoice Number'
	_payable_invoice_number_column = 'Payable Invoice Number'
	_vendor_credit_note_number_column_name = 'Vendor Credit Note Number'
	
	include_context "login"
	before :all do
		#Hold Base Data
		gen_start_test  "TID020934-PIN / PCR document limits - VAT company(CIF)"
		FFA.hold_base_data_and_wait
		
	    #Data Setup 1
		# "Execute Script as Anonymous user" 
		create_pin_pcn = [ "CODATID020934Data.selectCompany();",
				"CODATID020934Data.createData();",
				"CODATID020934Data.createDataExt1();",
				"CODATID020934Data.createDataExt2();",
				"CODATID020934Data.createDataExt3();",
				"CODATID020934Data.createDataExt4();",
				"CODATID020934Data.createDataExt5();",
				"CODATID020934Data.createDataExt6();",
				"CODATID020934Data.createDataExt7();",
				"CODATID020934Data.createDataExt8();",
				"CODATID020934Data.createDataExt9();",
				"CODATID020934Data.createDataExt10();",
				"CODATID020934Data.createDataExt11();",
				"CODATID020934Data.createDataExt12();",
				"CODATID020934Data.createDataExt13();",
				"CODATID020934Data.createDataExt14();",
				"CODATID020934Data.createDataExt15();",
				"CODATID020934Data.createDataExt16();",
				"CODATID020934Data.createDataExt17();",
				"CODATID020934Data.createDataExt18();",
				"CODATID020934Data.createDataExt19();",
				"CODATID020934Data.createDataExt20();",
				"CODATID020934Data.createDataExt21();",
				"CODATID020934Data.createDataExt22();",
				"CODATID020934Data.createDataExt23();",
				"CODATID020934Data.createDataExt24();",
				"CODATID020934Data.createDataExt25();",
				"CODATID020934Data.createDataExt26();"]
		APEX.execute_commands create_pin_pcn

		#Data Setup 2
		SF.app $accounting
		#Setting page layout to custom Payable Invoice and Payable Credit Note layout
		SF.object_button_edit $ffa_object_payable_credit_note, $sf_edit_button
		CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_purchase_credit_note_edit
		SF.object_button_edit $ffa_object_payable_credit_note, $sf_new_button
		CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_purchase_credit_note_new
		SF.object_button_edit $ffa_object_payable_credit_note, $sf_view_button
		CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_purchase_credit_note_view

		SF.object_button_edit $ffa_object_payable_invoice, $sf_edit_button
		CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_payable_invoice_edit
		SF.object_button_edit $ffa_object_payable_invoice, $sf_new_button
		CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_payable_invoice_new
		SF.object_button_edit $ffa_object_payable_invoice, $sf_view_button
		CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_payable_invoice_view
	end
	
	it "TST035514 | TST035515 : Verify EDIT and SAVE | POST functionality on PINV with 1000 lines" do 
		login_user
		begin
			gen_start_test "TST035514: Verify Edit and Save functionality on PINV with 1000 lines"
			SF.tab $tab_payable_invoices
            SF.select_view $bd_select_view_all
            SF.click_button_go
            _payable_invoice_number = FFA.get_column_value_in_grid _vendor_invoice_number_column_name, _pin1_number, _payable_invoice_number_column
            PIN.open_invoice_detail_page _payable_invoice_number
			gen_wait_until_object $cif_edit_record_button
			
			CIF.click_edit_button
			CIF_PINV.click_payable_invoice_line_items_tab
			CIF_PINV.set_pinv_line_quantity 1000
			CIF_PINV.click_pinv_save_button
			gen_wait_until_object $cif_edit_record_button
			
			gen_compare $bd_document_status_in_progress,  CIF_PINV.get_payable_invoice_status, "Expected PIN status should be In Progress"
			gen_end_test "TST035514: Verify Edit and Save functionality on PINV with 1000 lines"
			
			gen_start_test "TST035515: Verify Post functionality on PINV with 1000 lines"
			CIF.click_post_button
			gen_wait_until_object $cif_amend_button
			gen_compare $bd_document_status_complete,  CIF_PINV.get_payable_invoice_status, "Expected PIN status should be Complete"
			gen_end_test "TST035515: Verify Post functionality on PINV with 1000 lines"
		end
		SF.logout
	end

	it "TST035516 : Verify SAVE & POST functionality on PINV" do
        login_user
		begin
			gen_start_test "TST035516: Verify Save & Postfunctionality on PINV with 1000 lines"
			SF.tab $tab_payable_invoices
            SF.select_view $bd_select_view_all
            SF.click_button_go
            _payable_invoice_number = FFA.get_column_value_in_grid _vendor_invoice_number_column_name, _pin2_number, _payable_invoice_number_column
            PIN.open_invoice_detail_page _payable_invoice_number
			gen_wait_until_object $cif_edit_record_button

			CIF.click_edit_button
			CIF_PINV.click_payable_invoice_line_items_tab
			CIF_PINV.set_pinv_line_quantity 1000
			CIF_PINV.click_pinv_save_post_button
			gen_wait_until_object $cif_amend_button

			gen_compare $bd_document_status_complete,  CIF_PINV.get_payable_invoice_status, "Expected PIN status should be Complete"
			gen_end_test "TST035516: Verify Save & Post functionality on PINV with 1000 lines"
		end
		SF.logout
	end
	
	it "TST035536 | TST035537 : Verify EDIT and SAVE | POST functionality on PCRN with 1000 lines" do 
		login_user
		begin
			gen_start_test "TST035536: Verify Edit and Save functionality on PCRN with 1000 lines"
			SF.tab $tab_payable_credit_notes
            SF.select_view $bd_select_view_all
            SF.click_button_go
            _payable_credit_note_number = FFA.get_column_value_in_grid _vendor_credit_note_number_column_name, _pcn1_number, $label_credit_note_number
            PCR.open_credit_note_detail_page _payable_credit_note_number
			gen_wait_until_object $cif_edit_record_button
			
			CIF.click_edit_button
			CIF_PCN.click_payable_credit_note_line_items_tab
			CIF_PCN.set_pcn_line_quantity 1000
			CIF_PCN.click_pcrn_save_button
			gen_wait_until_object $cif_edit_record_button
			
			gen_compare $bd_document_status_in_progress, CIF_PCN.get_payable_credit_note_status, "Expected PCN should be with In Progress status"
			gen_end_test "TST035536: Verify Edit and Save functionality on PCRN with 1000 lines"
			
			gen_start_test "TST035537: Verify Post functionality on PCRN with 1000 lines"
			CIF.click_post_button
			gen_wait_until_object $cif_amend_button
			gen_compare $bd_document_status_complete, CIF_PCN.get_payable_credit_note_status, "Expected PCN should be with Complete status"
			gen_end_test "TST035537: Verify Post functionality on PCRN with 1000 lines"
		end
		SF.logout
	end
	
	it "TST035538 : Verify SAVE & POST functionality on PCRN with 1000 lines" do
        login_user
		begin
			gen_start_test "TST035538: Verify Save & Post functionality on PCRN with 1000 lines"
			SF.tab $tab_payable_credit_notes
            SF.select_view $bd_select_view_all
            SF.click_button_go
            _payable_credit_note_number = FFA.get_column_value_in_grid _vendor_credit_note_number_column_name, _pcn2_number, $label_credit_note_number
            PCR.open_credit_note_detail_page _payable_credit_note_number
			gen_wait_until_object $cif_edit_record_button
			
			CIF.click_edit_button
			CIF_PCN.click_payable_credit_note_line_items_tab
			CIF_PCN.set_pcn_line_quantity 1000
			CIF_PCN.click_pcn_save_post_button
			gen_wait_until_object $cif_amend_button

			gen_compare $bd_document_status_complete, CIF_PCN.get_payable_credit_note_status, "Expected PCN should be with Complete status"
			gen_end_test "TST035538: Verify Save & Post functionality on PCRN with 1000 lines"
		end
		SF.logout
	end
	
	after :all do
		login_user
		#Delete Test Data
		delete_data = ["CODATID020934Data.destroyData();"]
		APEX.execute_commands delete_data

		FFA.delete_new_data_and_wait
		SF.object_button_edit $ffa_object_payable_credit_note, $sf_edit_button
		CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_payable_credit_note_edit
		SF.object_button_edit $ffa_object_payable_credit_note, $sf_new_button
		CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_payable_credit_note_new
		SF.object_button_edit $ffa_object_payable_credit_note, $sf_view_button
		CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_payable_credit_note_view

		SF.object_button_edit $ffa_object_payable_invoice, $sf_edit_button
		CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_purchase_invoice_edit
		SF.object_button_edit $ffa_object_payable_invoice, $sf_new_button
		CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_purchase_invoice_new
		SF.object_button_edit $ffa_object_payable_invoice, $sf_view_button
		CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_purchase_invoice_view
		gen_end_test "TID020934 : PIN / PCR document limits - VAT company(CIF)"
		SF.logout
	end
end
