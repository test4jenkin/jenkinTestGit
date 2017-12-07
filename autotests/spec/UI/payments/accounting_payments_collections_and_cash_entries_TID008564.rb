#--------------------------------------------------------------------#
#	TID : TID008564
# 	Pre-Requisite : Org with basedata deployed
#  	Product Area: Accounting - Payments Collections & Cash Entries (UI Test)
# 	Story: 26279
#--------------------------------------------------------------------#


describe "UI Test - Accounting - Payments Collections & Cash Entries", :type => :request do
include_context "login"
include_context "logout_after_each"
	before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait
		gen_start_test "Accounting - Payments Collections & Cash Entries (UI Test) : TID008564"
	end
	
	_col_acc_name = "Account Name"
	
	it "TID008564 : Check the different validation on select Payment Selection" do
		gen_start_test "TID008564 : Check the different validation on select Payment Selection"
		
		_line_1 = 1
		_line_2 = 2
		_quantity_10 =10
		_payment_total_n6000 = "-6,000.00"
		_account_total_n6000 ="-6,000.00"
		
		gen_start_test "Additional data required"
		begin
			SF.tab $tab_accounts
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird _col_acc_name, $bdu_account_hogan_repairs
			Account.set_accounts_payable_control $bdu_gla_account_payable_control_eur
			SF.click_button_save
		end
		
		gen_start_test "TST009076 : MultiCompany validation"
		begin
			SF.app $accounting
			SF.tab $tab_select_company
			
			# verify payment selection tab in multi company mode
			FFA.select_company [$company_merlin_auto_spain, $company_merlin_auto_usa] ,true
			SF.tab $tab_payment_selection
			gen_wait_until_object_disappear $page_loadmask_message
			expect(page).to have_content($ffa_msg_multi_company_mode_error)
			gen_report_test "Expected error message #{$ffa_msg_multi_company_mode_error} to be displayed on payment selection page"
			SF.tab $tab_select_company
			
			# verify payment selection tab when no company is set
			FFA.select_company [] ,true
			SF.tab $tab_payment_selection
			gen_wait_until_object_disappear $page_loadmask_message
			expect(page).to have_content($ffa_msg_company_not_set_error)
			gen_report_test "Expected error message #{$ffa_msg_company_not_set_error} to be displayed on payment selection page"
			
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_spain] ,true
			find($tab_all_tabs_locator).click
			select_company_tab = gen_open_link_in_new_tab $tab_select_company
			SF.click_link $tab_payment_selection
			gen_wait_until_object $paysel_retrieve_documents
			within_window select_company_tab do
				FFA.select_company [$company_merlin_auto_spain, $company_merlin_auto_usa] ,true
			end
			SF.retry_script_block do
				PAYSEL.click_retrieve_documents
				gen_wait_less #it take 1 or 2 sec to show error message on UI
				expect(page).to have_content($ffa_msg_multi_company_mode_error)
				gen_report_test "Expected error message #{$ffa_msg_multi_company_mode_error} to be displayed on payment selection popup"
				PAYSEL.click_continue_button
			end
		end
		
		gen_start_test "TST009231 : Validation in Retrieve Document"
		begin
			#get user locale
			_user_locale = gen_get_current_user_locale
			#select company
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_usa] ,true
			#create payable invoice
			SF.tab $tab_payable_invoices
			SF.click_button_new
			PIN.set_account $bdu_account_hogan_repairs
			PIN.change_invoice_currency $bdu_currency_usd
			_date = gen_get_current_date
			_date_user_locale = gen_locale_format_date _date, _user_locale
			PIN.set_invoice_date _date_user_locale
			PIN.set_vendor_invoice_number "HR1001"
			PIN.set_vendor_invoice_total 6000
			PIN.set_product_name $bdu_product_auto_com_clutch_kit_1989_dodge_raider
			PIN.click_product_new_line
			PIN.set_product_line_quantity _line_1, _quantity_10
			PIN.set_product_line_unit_price _line_1, 500
			PIN.set_product_name $bdu_product_bbk_fuel_pump_power_plus_series_universal
			PIN.click_product_new_line
			PIN.set_product_line_quantity _line_2, _quantity_10
			PIN.set_product_line_unit_price _line_2, 100
			FFA.click_save_post
			SF.tab $tab_payment_selection
			gen_wait_until_object_disappear $page_loadmask_message
			gen_wait_less #taking some time to load page
			
			#Verify that vendor account name gear icon with multi-select, contains and from-to option not available with platform encryption ON
			if(SF.org_is_enableencryption)
				gen_compare_object_visible $paysel_vendor_account_name_gear_icon, false, "Expected vendor account name gear icon should not be present with PE enabled org"
			end
			PAYSEL.set_due_date_filter false
			PAYSEL.set_vendor_account_name_filter false
            	
			# verify Retrieve documents in multi company mode
			within_window select_company_tab do
				SF.tab $tab_select_company
				FFA.select_company [$company_merlin_auto_spain, $company_merlin_auto_usa] ,true
			end
			PAYSEL.click_retrieve_documents
			expect(page).to have_content($ffa_msg_multi_company_mode_error)
			gen_report_test "Expected error message #{$ffa_msg_multi_company_mode_error} to be displayed on payment selection popup"
			PAYSEL.click_continue_button
			
			# verify Retrieve documents when company is changed
			within_window select_company_tab do
				SF.tab $tab_select_company
				FFA.select_company [$company_merlin_auto_spain] ,true
			end
			PAYSEL.click_retrieve_documents
			expect(page).to have_content($ffa_msg_company_changed_error)
			gen_report_test "Expected error message #{$ffa_msg_company_changed_error} to be displayed on payment selection popup"
			PAYSEL.click_continue_button
			
			# verify Retrieve documents when original company is set
			within_window select_company_tab do
				SF.tab $tab_select_company
				FFA.select_company [$company_merlin_auto_usa] ,true
			end
			SF.retry_script_block do
				PAYSEL.click_retrieve_documents
				gen_wait_less #it take 1 or 2 sec to show error message on UI
				expect(page).to have_content($bdu_account_hogan_repairs)
				gen_report_test "Expected account #{$bdu_account_hogan_repairs} to be displayed on payment selection page for which PIN is created"
			end
		end

		gen_start_test "TST009233 : Validation in Create button in popup"
		begin
			PAYSEL.select_all_transactions			
			_payment_total_value =PAYSEL.get_payment_selection_total
			gen_compare _payment_total_n6000, _payment_total_value , "Payment total should be #{_payment_total_n6000}"
			_account_total_value =PAYSEL.get_payment_account_total
			gen_compare _account_total_n6000, _account_total_value , "Account total should be #{_account_total_n6000}"
			PAYSEL.click_create_payment
			PAYSEL.set_create_payment_bank_account $bdu_bank_account_apex_usd_b_account
			PAYSEL.set_create_payment_settlement_discount $bdu_gla_account_payable_control_usd
			PAYSEL.set_create_payment_currency_write_off $bdu_gla_account_payable_control_usd
			PAYSEL.choose_create_payment_payment_media $bdu_payment_method_check
			
			# verify final create (payment) in multi company mode
			within_window select_company_tab do
				SF.tab $tab_select_company
				FFA.select_company [$company_merlin_auto_spain, $company_merlin_auto_usa] ,true
			end
			PAYSEL.click_create_button
			expect(page).to have_content($ffa_msg_multi_company_mode_error)
			gen_report_test "Expected error message #{$ffa_msg_multi_company_mode_error} to be displayed on payment selection popup"
			PAYSEL.choose_create_payment_payment_media $bdu_payment_method_electronic
			PAYSEL.choose_create_payment_payment_media $bdu_payment_method_check
			
			# verify final create (payment) when company is changed
			within_window select_company_tab do
				SF.tab $tab_select_company
				FFA.select_company [$company_merlin_auto_spain] ,true
			end
			PAYSEL.click_create_button
			expect(page).to have_content($ffa_msg_company_changed_error)
			gen_report_test "Expected error message #{$ffa_msg_company_changed_error} to be displayed on payment selection popup"
			PAYSEL.choose_create_payment_payment_media $bdu_payment_method_electronic
			PAYSEL.choose_create_payment_payment_media $bdu_payment_method_check
			
			# verify final create (payment) when original company is set
			within_window select_company_tab do
				SF.tab $tab_select_company
				FFA.select_company [$company_merlin_auto_usa] ,true
				page.current_window.close
			end
			PAYSEL.click_create_button
			expect(page).to have_css($paysel_go_to_payments_home_button)
			gen_report_test "Expected payment is created and button #{$paysel_go_to_payments_home_button} to be displayed on payment selection popup"
			PAYSEL.click_go_to_payments_home_button
		end	
		gen_end_test "TID008564 : Check the different validation on select Payment Selection"
	end
	after :all do
		login_user
		FFA.delete_new_data_and_wait
		SF.tab $tab_accounts
		SF.select_view $bdu_select_view_all
		SF.click_button_go
		FFA.click_edit_link_on_list_gird _col_acc_name, $bdu_account_hogan_repairs
		Account.set_accounts_payable_control nil
		SF.click_button_save
		SF.logout
		gen_end_test "Accounting - Payments Collections & Cash Entries (UI Test) : TID008564"
	end
end