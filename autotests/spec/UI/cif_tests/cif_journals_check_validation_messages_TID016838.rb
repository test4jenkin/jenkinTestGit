#--------------------------------------------------------------------#
#   TID : TID016838
#   Pre-Requisit: Org with basedata deployed.
#   Product Area: Journals & CIF
#   Story: CIF - Handle all exception types and surface in UI[25367]
#   driver=firefox rspec -fd -c spec/UI/cif_tests/cif_journals_check_validation_messages_TID016838.rb -fh -o journal_ext.html
#--------------------------------------------------------------------#
describe "TID016838-Journals Custom Input Forms validation messages.", :type => :request do
  include_context "login"
  include_context "logout_after_each"
  before :all do
	#Hold Base Data
	FFA.hold_base_data_and_wait
  end
  
  it "TID016838-Check the validation messages on Journal Custom Input Form" do
    gen_start_test "TST024391   - Verify the field error and popup error validation message on the CIF Journal screen."
	
    _field_error_message = 'No matches found.'
    _popup_error_message = 'You must complete the highlighted fields correctly.'

    # login and select merlin auto gbp company.
    SF.app $accounting
    SF.tab $tab_select_company
    FFA.select_company [$company_merlin_auto_gb],true	
	
    SF.tab $tab_journals
    SF.click_button_new
    CIF.set_value $cif_journal_reference, "Sample Journal Reference"
    CIF.set_value $cif_journal_description, "Sample Journal Description"
	CIF.click_toggle_button
    CIF.set_value_tab_out $cif_journal_currency, "test"

    CIF.click_new_row
    CIF.set_value_tab_out $cif_journal_line_type, $bd_jnl_line_type_account_customer
    #First time save update the fields.
    CIF_JNL.click_journal_save_button
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
	
    expect(page).to have_selector($page_sencha_popup)
    within(find($page_sencha_popup)) do
      expect(page).to have_content(_popup_error_message)
      FFA.sencha_popup_click_continue
    end
    gen_report_test "Popup validation message verified"
	CIF.click_toggle_button
    gen_end_test "TST024391 - field error and popup error validation message on the CIF Journal screen are verified.    "
  end
  
  after :all do
	#Delete Test Data
	login_user
	FFA.delete_new_data_and_wait
	SF.logout
  end
end
