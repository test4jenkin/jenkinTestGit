#--------------------------------------------------------------------#
#   TID : TID015954 - CIF-FFA UI - test to check fields on Journals are derived correctly.
#   Pre-Requisit: Org with basedata deployed.
#   Product Area: CIF
# Story: 27404 - CIF - Derive triggers implementation
#--------------------------------------------------------------------#
require 'date'

describe "TID015954-Journals Custom Input Forms derive fields.", :type => :request do
  include_context "login"
  include_context "logout_after_each"
 before :all do
	#Hold Base Data
	FFA.hold_base_data_and_wait
	gen_start_test "TID015954"
  end
  
  it "TID015954 -  CIF-FFA UI - Test to check fields on Custom Inpput Form Journals are derived correctly" do

    SF.app $accounting
    SF.tab $tab_select_company
    FFA.select_company [$company_merlin_auto_gb],true
	current_date = Time.now
	_date_next_month = FFA.add_days_to_date current_date , "31"
    gen_start_test "TST022982   - Test that the changes to the JRNL header trigger fields cause their target fields to update accordingly."
    SF.tab $tab_journals
    SF.click_button_new
    
    CIF_JNL.set_journal_date _date_next_month
    _actual_period = find($cif_journal_period, :visible => false).value
    _expected_period = (Date.today + 31).strftime('%Y') + "/" + "0" +  (Date.today + 31).strftime('%m')
    gen_compare _expected_period, _actual_period, "Period value derived as expected."
    _actual_currency = find($cif_journal_currency, :visible => false).value
    _expected_currency = 'GBP'
    gen_compare _expected_currency, _actual_currency, "Currency value derived as expected."
    gen_end_test "TST022982 - JRNL Custom Input form header trigger fields are derived sucessfully."

    gen_start_test "TST022994   - Test that the changes to the JRNL line trigger fields cause their target fields to update accordingly."
    CIF.click_new_row
    CIF_JNL.set_line_type 'Account - Customer'
    CIF_JNL.set_gla 'Sales - Parts'
    CIF_JNL.set_account 'Cambridge Auto'
    CIF_JNL.set_tax_value '21.00'
    CIF_JNL.set_line_description 'Sample Journal line debit description'
    CIF_JNL.set_dimesion_1 'North'
    CIF_JNL.set_dimesion_2 'Dim 2 GBP'
    CIF_JNL.set_value '21.00'
	CIF.wait_for_totals_to_calculate
    gen_compare '21.00',  CIF.get_text_of($cif_journal_debits), "debit value derived as expected."
    gen_compare '0.00',  CIF.get_text_of($cif_journal_credits), "credit value is not derived for debit input as expected."
    gen_compare '21.00',  CIF.get_text_of($cif_journal_total), "total value derived as expected."
    # Enter second row
    CIF_JNL.set_line_type 'Account - Vendor' , 2
    CIF_JNL.set_gla 'Sales - Parts' , 2
    CIF_JNL.set_account 'Cambridge Auto', 2
    CIF_JNL.set_tax_value '-21.00', 2
    CIF_JNL.set_line_description 'Sample Journal line credit description'
    CIF_JNL.set_dimesion_1 'North'
    CIF_JNL.set_dimesion_2 'Dim 2 GBP'
    CIF_JNL.set_value '-21.00', 2
    CIF.wait_for_totals_to_calculate
    gen_compare '21.00',  CIF.get_text_of($cif_journal_debits), "debit value derived as expected."
    gen_compare '-21.00',  CIF.get_text_of($cif_journal_credits), "credit value derived as expected."
    gen_compare '0.00',  CIF.get_text_of($cif_journal_total), "total value derived as expected."
    gen_end_test "TST022994 - JRNL Custom Input form line items trigger fields are derived sucessfully."
  end
  
  after :all do
	#Delete Test Data
	login_user
	FFA.delete_new_data_and_wait
	gen_end_test "TID015954"
	SF.logout
  end
end