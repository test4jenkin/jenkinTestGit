#--------------------------------------------------------------------#
#	TID : TID012133
# 	Pre-Requisite : Org with basedata deployed
#  	Product Area: Accounting - Cash entry and Matching (UI Test)
# 	Story: 26949 
#--------------------------------------------------------------------#


describe "UI Test - Accounting - Cash entry and Matching", :type => :request do
include_context "login"
include_context "logout_after_each"
	before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait
		gen_start_test "TID012133 : Accounting - Cash entry and Matching UI Test"
	end
	
	it "TID012133 :  Cash entry with 'In Progress' Status can be updated successfully from List view on classic UI." do
		gen_start_test "TID012133 : Cash entry with 'In Progress' Status can be updated successfully from List view on classic UI."
		
		_column_cash_entry_number = "Cash Entry Number"
		_line = 1
		_line_2 = 2
		_account_reference_ce1234 = "CE1234"
		_account_reference_acc_ref_123 = "Acc Ref 123"
		_charge_20 ="20.00"
		_cashentry_value_200 = "200.00"
		_cashentry_value_100 = "100.00"
		_text_tid012133 = "TID012133"
		_title_cash_entry_edit = "Cash Entry Edit"
		_cashentry_period = "2015/008"
		
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_spain] ,true
		
		gen_start_test "Additional data required for TID012133"
		begin
			SF.new_custom_setting $ffa_custom_setting_accounting_settings
			SF.set_custom_setting_property $ffa_accounting_settings_enable_edit_dimensions_after_posting, true
			SF.click_button_save
			SF.tab $tab_cash_entries
			SF.click_button_new
			CE.set_bank_account $bdu_bank_account_santander_current_account
			CE.line_set_account_name $bdu_account_algernon_partners_co
			FFA.click_new_line
			CE.line_set_cashentryvalue _line , _cashentry_value_100
			CE.line_set_account_reference _line, "CE123"
			SF.click_button_save
			_cash_entry_number = CE.get_cash_entry_number
			gen_compare	$bdu_document_status_in_progress, CE.get_cash_entry_status, "Expected cash entry status to be in progress"
			SF.object_button_edit $ffa_object_cash_entry, $sf_edit_button
			SF.choose_visualforce_page $ffa_vf_page_coda_cashentry_edit
			#get user locale
			_user_locale = gen_get_current_user_locale
		end
		
		gen_start_test "TST015544"
		begin
			SF.tab $tab_cash_entries
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			
			#Updating cash entry period
			FFA.click_edit_link_on_list_gird _column_cash_entry_number , _cash_entry_number
			gen_compare _title_cash_entry_edit, SF.get_page_title, "Expected Edit page codacashentryedit to get opened."
			FFA.select_period_from_lookup $cashentry_period_lookup_icon, _cashentry_period, $company_merlin_auto_spain
			SF.click_button_save
			expect(page).to have_content(_cashentry_period)
			gen_report_test "Expected period to get updated successfully"
			
			# Updating other values of cashentry
			SF.tab $tab_cash_entries
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird _column_cash_entry_number , _cash_entry_number
			page.has_text?(_cash_entry_number)
			CE.select_bank_account_from_lookup $cashentry_bank_account_lookup_icon, $bdu_bank_account_apex_eur_b_account, $company_merlin_auto_spain
			_date = gen_get_current_date
			_date_after_5_days = _date + 5           # increasing date to 5 days from today
			_date_uk_locale = gen_locale_format_date _date_after_5_days, _user_locale
			CE.set_date _date_uk_locale
			CE.set_reference _text_tid012133
			CE.set_payment_method $bdu_payment_method_check
			CE.set_bank_charges_gla $bdu_gla_account_payable_control_eur
			CE.set_cash_entry_description _text_tid012133
			CE.set_bank_charge _charge_20
			CE.line_set_account_reference _line, _account_reference_acc_ref_123
			CE.line_set_payment_method_value _line , $bdu_payment_method_check
			CE.line_set_cashentryvalue _line , _cashentry_value_200
			CE.line_set_line_charges _line, _charge_20
			page.has_button?($sf_save_button)
			SF.click_button_save
			_cash_entry_value = CE.get_line_cashentry_value _line
			gen_compare _cashentry_value_200, _cash_entry_value, "Expected cash entry to be saved successfully with new values"
			_payment_method = CE.get_line_cashentry_payment_method _line
			gen_compare $bdu_payment_method_check, _payment_method, "Expected payment method to be #{$bdu_payment_method_check}"
			gen_compare _text_tid012133, CE.get_description, "Expected account name to be #{_text_tid012133}"
			
			# Adding account line item
			SF.tab $tab_cash_entries
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird _column_cash_entry_number , _cash_entry_number
			page.has_text?(_cash_entry_number)
			CE.line_set_account_name $bdu_account_algernon_partners_co
			FFA.click_new_line
			CE.line_set_cashentryvalue _line_2 , _cashentry_value_100
			CE.line_set_account_reference _line_2, _account_reference_ce1234
			SF.click_button_save
			expect(page).to have_content(_account_reference_ce1234)
			gen_report_test "Expected account line item to be added to cash entry"
			
			# Delete line item
			SF.tab $tab_cash_entries
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird _column_cash_entry_number , _cash_entry_number
			page.has_text?(_cash_entry_number)
			FFA.click_cross_link_to_delete_line_item _line
			SF.click_button_save
			expect(page).to have_no_content(_account_reference_acc_ref_123)
			gen_report_test "Expected first account line item to be deleted from cash entry"
		end
		gen_end_test "TID012133 : Cash entry with 'In Progress' Status can be updated successfully from List view on classic UI."
	end
	after :all do
		login_user
		FFA.delete_new_data_and_wait
		SF.new_custom_setting $ffa_custom_setting_accounting_settings
		SF.set_custom_setting_property $ffa_accounting_settings_enable_edit_dimensions_after_posting, false
		SF.click_button_save
		gen_end_test "TID012133 : Accounting - Cash entry and Matching UI Test"
	end
end