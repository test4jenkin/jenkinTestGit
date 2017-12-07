
#--------------------------------------------------------------------#
#   TID : TID015362
#   Pre-Requisite: Org with basedata deployed;
#	Setup Data: cif_journal_test_data.rb
#   Product Area: Journals-CIF
# Story: CIF - All actions for Journals[25377]
#--------------------------------------------------------------------#
describe "TID015362-Journals using Custom Input Forms", :type => :request do
  include_context "login"
  include_context "logout_after_each"
	_journal_description = "Sample Journal Description"
	_journal_reference = "Sample Journal Reference"
	_dimension_2_ford_uk = "Ford UK"
	_line_1_description = "Line one description"
	_line_2_description = "Line two description"
	_net_value_21 = '21.00'
	_net_value_negative_21 = '-21.00'
	
	before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait
	end
  
  it "TID015362-Create,Save,Post and Cancel a journal in Custom Input Form mode" do	
    
	# login and select merlin auto gbp company.
    SF.app $accounting
    SF.tab $tab_select_company
    FFA.select_company [$company_merlin_auto_gb],true

    #TST021359  - Verify that a user should be able to save a journal.
    gen_start_test "TST021359   - Verify that a user should be able to save a journal."
    SF.tab $tab_journals
    SF.click_button_new
    #CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
    CIF_JNL.set_journal_reference _journal_reference
    CIF_JNL.set_journal_description _journal_description
    CIF.click_save_button
	gen_wait_until_object $cif_edit_record_button
    gen_compare $bd_document_status_in_progress,  CIF.get_text_of($cif_journal_status), "Journal created sucessfully."
    gen_end_test "TST021359 -Verify that a user should be able to save a journal."


    # #TST021359  - Verify that a user should be able to save and open a new journal.
    gen_start_test "TST021360   - Verify that a user should be able to save and open a new journal."
    SF.tab $tab_journals
    SF.click_button_new
    CIF_JNL.set_journal_reference _journal_reference
    CIF_JNL.set_journal_description _journal_description
    CIF.click_save_new_button
	gen_wait_until_object $cif_save_button
    gen_end_test "TST021360 -Verify that a user should be able to save the journal and open a new journal."
    #TST021361  - Verify that a user should be able to save and post the journal.
    gen_start_test "TST021361   - Verify that a user should be able to save and post the journal."
    SF.tab $tab_journals
    SF.click_button_new
    CIF_JNL.set_journal_reference _journal_reference
    CIF_JNL.set_journal_description _journal_description

    CIF.click_new_row
    CIF_JNL.set_line_type $bd_jnl_line_type_account_customer
    CIF_JNL.set_gla $bd_gla_sales_parts
    CIF_JNL.set_account $bd_account_cambridge_auto
    CIF_JNL.set_tax_value _net_value_21
    CIF_JNL.set_line_description _line_1_description
    CIF_JNL.set_dimesion_1 $bd_dim1_north
    CIF_JNL.set_dimesion_2 _dimension_2_ford_uk
    CIF_JNL.set_value _net_value_21

    CIF_JNL.set_line_type $bd_jnl_line_type_account_vendor, 2
	CIF_JNL.click_toggle_button
    CIF_JNL.set_gla $bd_gla_sales_hardware, 2
    CIF_JNL.set_account $bd_account_bmw_automobiles, 2
    CIF_JNL.set_tax_value _net_value_negative_21, 2
    CIF_JNL.set_line_description _line_2_description, 2
    CIF_JNL.set_dimesion_1 $bdu_dim1_gbp, 2
    CIF_JNL.set_dimesion_2 $bdu_dim2_gbp, 2
    CIF_JNL.set_value _net_value_negative_21, 2
	CIF_JNL.click_toggle_button
    CIF.click_save_post_button
	gen_wait_until_object $cif_amend_button
    gen_compare $bd_document_status_complete,  CIF.get_text_of($cif_journal_status), "Journal created sucessfully."
	_journal_number = CIF.get_document_number_from_header
    gen_end_test "TST021361 - Verify that a user should be able to save and post the journal."

    #TID015058-TST020755	- Verify that a user should be able to view the CIF version of the journals in CIF view mode.
    gen_start_test "TST020755	- Verify that a user should be able to view the CIF version of the journals in CIF view mode."
    SF.tab $tab_journals
    SF.select_view $bd_select_view_all
    SF.click_button_go    
    JNL.open_journal_detail_page _journal_number
	gen_wait_until_object $cif_amend_button
    _date = FFA.get_current_formatted_date		
	_expected_period = FFA.get_current_period

    CIF_JNL.compare_journal_header_details  _date, _expected_period, $bd_currency_gbp, _journal_reference, nil, $bd_jnl_type_manual_journal, $bd_document_status_complete, nil, nil, nil
    griddata = Array.new
                   .push(CIF_JNL.get_grid_data_row 1)
                   .push(CIF_JNL.get_grid_data_row 2)
    gen_compare "1 Account - Customer Sales - Parts Cambridge Auto 21.00 Cambridge Auto Line one description North Ford UK 21.00",griddata[0],"Journal line items values are verified"
    gen_compare "2 Account - Vendor Sales - Hardware BMW Automobiles -21.00 BMW Automobiles Line two description Dim 1 GBP Dim 2 GBP -21.00",griddata[1],"Journal line items values are verified"
    gen_end_test "TST020755	- Verify that a user should be able to viwq the CIF version of the journals in CIF view mode."

    # #TST021362  - Verify that a user should be abel to cancel the journal when creating a new journal.
    gen_start_test "TST021362   - Verify that a user should be abel to cancel the journal when creating the journal."
    SF.tab $tab_journals
    SF.click_button_new
    CIF_JNL.set_journal_reference _journal_reference
    CIF_JNL.set_journal_description _journal_description
    CIF.click_cancel_button
	CIF.click_leave_button_on_save_changes_popup
	
    gen_has_page_title 'Journals', 'Journal cancelled and navigated back to the previous screen'
	gen_end_test "TST021362 - Verify that a user should be abel to cancel the journal when creating the journal."	
  end
  
  after :all do
	#Delete Test Data
	login_user
	FFA.delete_new_data_and_wait
  end
end