#--------------------------------------------------------------------#
#   TID : TID022087
#   Pre-Requisit: Org with basedata deployed.
#   Product Area: Journals & CIF
#   Story: All Bank Accounts are displayed instead of Company's Bank Account[AC-13649]
#   driver=firefox rspec -fd -c spec/UI/cif_tests/cif_journals_check_bank_account_filter_TID022087.rb -fh -o journal_ext.html
#--------------------------------------------------------------------#
describe "TID022087-Journals Bank Account Filtering.", :type => :request do
  include_context "login"
  include_context "logout_after_each"
  before :all do
	#Hold Base Data
	FFA.hold_base_data_and_wait
  end

  it "TID022087-Check bank account filter" do
    gen_start_test "TST039699   - Verify the bank account lookup is filtered by either current company or destination company."

    # login and select merlin auto gbp company.
    SF.app $accounting
    SF.tab $tab_select_company
    FFA.select_company [$company_merlin_auto_gb],true	
	
    SF.tab $tab_journals
    SF.click_button_new
    CIF.set_value $cif_journal_reference, "Sample Journal Reference"
    CIF.set_value $cif_journal_description, "Sample Journal Description"
    CIF.click_toggle_button

    CIF.click_new_row
    CIF.set_value_tab_out $cif_journal_line_type, $bd_jnl_line_type_bank_account

    CIF_JNL.set_bank_account 'a'
    _gb_ba_present = CIF_JNL.is_bankaccount_values_present  [$bdu_bank_account_barclays_current_account]
    gen_compare true, _gb_ba_present, "GB Bank account should be present"
    _spa_ba_present = CIF_JNL.is_bankaccount_values_present  [$bdu_bank_account_santander_current_account]
    gen_compare false, _spa_ba_present, "Spain Bank account should not be present"

    CIF.delete_row 1
    CIF.click_new_row
    CIF.set_value_tab_out $cif_journal_line_type, $bd_jnl_line_type_intercompany 

    CIF_JNL.set_gla 'a'
    CIF_JNL.set_account_analysis_value 'a'
    CIF_JNL.set_product_analysis_value 'b'
    CIF_JNL.set_line_field_destination_company $company_merlin_auto_spain
    CIF_JNL.set_line_field_destination_type $bd_jnl_line_type_bank_account
    CIF_JNL.set_bank_account 'a'
    _gb_ba_present = CIF_JNL.is_bankaccount_values_present  [$bdu_bank_account_barclays_current_account]
    gen_compare false, _gb_ba_present, "GB Bank account should not be present"
    _spa_ba_present = CIF_JNL.is_bankaccount_values_present  [$bdu_bank_account_santander_current_account]
    gen_compare true, _spa_ba_present, "Spain Bank account should be present"

    gen_report_test "Bank account lookup verified"
	CIF.click_toggle_button
    gen_end_test "TST039699   - Verified the bank account lookup is filtered by either current company or destination company."
  end
  
  after :all do
	#Delete Test Data
	login_user
	FFA.delete_new_data_and_wait
	SF.logout
  end
end
