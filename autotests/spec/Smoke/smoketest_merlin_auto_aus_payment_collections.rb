#--------------------------------------------------------------------------------------------#
#	TID :  TID013420
# 	Pre-Requisit: Org with basedata deployed, smoketest_data_setup, smoketest_data_setup_ext.rb
#  	Product Area: Accounting - Payments Collections & Cash Entries
# 	Story: 24498
#--------------------------------------------------------------------------------------------#

describe "Smoke test: Payment collections", :type => :request do
	include_context "login"
	include_context "logout_after_each"
	before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait
		gen_start_test "TID013420 - Smoke test: Payment collections"
	end
	
	it "TID013420 : verifies the functionality of doing payment of collections" do
		gen_start_test  "TID013420 : verifies the functionality of doing payment of collections"

		_line_1 = 1
		_line_2 = 2
		_currency_dual_rate_56 = "0.56"
		_quantity_20 = 20
		_quantity_1 = 1
		_iban_number_111 = "111"
		_swift_number_111 = "111"
		_sort_code_111 = "111"
		current_date = Date.today
		current_date_plus30_days=current_date+30
		last_year_value = (Time.now).year - 1
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_aus] ,true
		
		 gen_start_test "Additional Date required for TID013420"
		 begin
			puts "# Create sales invoice with 2 product line items and save and post it."
			begin
				SF.tab $tab_sales_invoices
				SF.click_button_new
				SIN.set_account $bd_account_jboag_brewing
				FFA.click_account_toggle_icon
				SIN.set_account_dimension $sin_dimension_1_label, $bd_dim1_tasmania
				FFA.click_account_toggle_icon
				SIN.set_invoice_date "16/01/"+last_year_value.to_s
				SIN.set_currency_dual_rate _currency_dual_rate_56
				FFA.click_new_line
				SIN.line_set_product_name _line_1, $bd_product_auto_com_clutch_kit_1989_dodge_raider
				SIN.line_set_quantity _line_1 , _quantity_20
				SIN.line_set_unit_price _line_1 , "89.40"
				SIN.line_set_tax_code _line_1 , $bd_tax_code_gst_sales
				FFA.click_new_line
				SIN.line_set_product_name _line_2, $bd_product_bbk_fuel_pump_power_plus_series_universal
				SIN.line_set_quantity _line_2 , _quantity_20
				SIN.line_set_unit_price _line_2 , "205.80"
				SIN.line_set_tax_code _line_2 , $bd_tax_code_gst_sales
				FFA.click_save_post
			end
			puts "# Convert Sales Invoice to credit note"
			begin
				SF.click_button $sin_convert_to_credit_note_button
				SF.wait_for_search_button
				SF.click_button_edit
				SF.wait_for_search_button
				SCR.set_creditnote_date "30/01/"+last_year_value.to_s
				SCR.line_set_quantity _line_1 , _quantity_1
				SCR.line_set_quantity _line_2 , _quantity_1
				SF.click_button_save
				SF.wait_for_search_button
				SF.click_button $scn_post_match_button
			end
			puts "# Create Sales Credit Note and save and post it."
			begin
				SF.tab $tab_sales_credit_notes
				SF.click_button_new
				SF.wait_for_search_button
				SCR.set_account $bd_account_jboag_brewing
				FFA.click_account_toggle_icon
				SCR.set_account_dimension $scn_dimension_1_label, $bd_dim1_tasmania
				FFA.click_account_toggle_icon
				SCR.set_creditnote_date "31/01/"+last_year_value.to_s
				SCR.set_currency_dual_rate _currency_dual_rate_56
				FFA.click_new_line
				SCR.line_set_product_name _line_1 , $bd_product_bbk_fuel_pump_power_plus_series_universal
				SCR.line_set_quantity _line_1 , 19
				SCR.line_set_unit_price  _line_1 , "20.00"
				SCR.line_set_tax_code  _line_1 , $bd_tax_code_gst_sales
				FFA.click_save_post
			end
			puts "# Update Account details"
			begin
				SF.tab $tab_accounts
				SF.select_view $bd_select_view_all_accounts
				SF.click_button_go
				SF.select_records_per_page "100"
				gen_click_link_and_wait $bd_account_jboag_brewing
				page.has_text?($bd_account_jboag_brewing)
				SF.click_button_edit
				Account.set_bank_account_name $bd_bank_account_commonwealth_current_account
				Account.set_bank_name $bd_bank_account_commonwealth_current_account
				Account.set_bank_sort_code _sort_code_111
				Account.set_bank_account_number "111"
				Account.set_bank_account_reference "111"
				Account.set_bank_swift_number _swift_number_111
				Account.set_bank_iban_number _iban_number_111
				SF.click_button_save
				SF.wait_for_search_button
			end
			puts "# Update Bank Account details"
			begin
				SF.tab $tab_bank_accounts
				SF.select_view $bd_select_view_company_ff_merlin_auto_aus
				SF.click_button_go
				page.has_text?($bd_bank_account_commonwealth_current_account)
				SF.listview_filter_result_by_alphabet "C"
				page.has_text?($bd_bank_account_commonwealth_current_account)
				BA.click_on_bank_account_from_list_view $bd_bank_account_commonwealth_current_account					
				page.has_button?("Edit")
				SF.click_button_edit
				BA.set_sort_code _sort_code_111
				BA.set_swift_number _swift_number_111
				BA.set_iban _iban_number_111
				BA.set_direct_debit_originator_ref "111"
				SF.click_button_save
			end
		end
		
		gen_start_test  "TST017171 : Collection payment"
		begin
			puts "# 1.1 : Creating payment"
			begin
				SF.tab $tab_payments
				SF.click_button_new
				PAY.set_bank_account $bd_bank_account_commonwealth_current_account
				PAY.set_payment_type $label_payment_type_collections
				PAY.set_payment_media $label_payment_media_electronic
				PAY.set_settlement_discount $bd_gla_settlement_discounts_allowed_aus
				PAY.set_currency_write_off $bd_gla_write_off_aus
				PAY.set_payment_date "10/02/"+last_year_value.to_s
				PAY.set_due_date "10/02/"+last_year_value.to_s
				PAY.click_retrieve_accounts_button
				_payment_number = PAY.get_payment_number
				_outstanding_value = PAY.get_outstanding_value $bd_account_jboag_brewing
				gen_compare "5,699.39" , _outstanding_value , "Expected outstanding value to be 5,699.39"
				_gross_value = PAY.get_gross_value $bd_account_jboag_brewing
				gen_compare "5,699.39" , _gross_value , "Expected gross value to be 5,699.39"
				_discount_value = PAY.get_discount $bd_account_jboag_brewing
				gen_compare "257.20" , _discount_value , "Expected discount to be 257.20"
				_payment_value = PAY.get_payment_value $bd_account_jboag_brewing
				gen_compare "5,442.19" , _payment_value , "Expected payment value to be 5442.19"
			end
			
			puts "# 1.2 : Making payment of collections"
			begin
				SF.click_button $pay_payment_pay_button
				SF.wait_for_apex_job
				SF.tab $tab_payments
				SF.select_view $bd_select_view_all
				SF.click_button_go
				SF.edit_list_view $bd_select_view_all, $label_payment_status, 2
				_payment_status = FFA.get_column_value_in_grid $label_payment_number , _payment_number , $label_payment_status
				gen_compare $bd_payment_matched_status, _payment_status, "Expected payment status to be Matched."
			end
		end
		gen_end_test  "TID013420 : verifies the functionality of doing payment of collections"
	end
	after :all do
		login_user
		# Delete Test Data
		FFA.delete_new_data_and_wait
		puts "Revert changes"
		begin
			SF.tab $tab_accounts
			SF.select_view $bd_select_view_all_accounts
			SF.click_button_go
			SF.select_records_per_page "100"
			gen_click_link_and_wait $bd_account_jboag_brewing
			page.has_text?($bd_account_jboag_brewing)
			SF.click_button_edit
			SF.wait_for_search_button
			Account.set_bank_account_name nil
			Account.set_bank_name nil
			Account.set_bank_sort_code nil
			Account.set_bank_account_number nil
			Account.set_bank_account_reference nil
			Account.set_bank_swift_number nil
			Account.set_bank_iban_number nil
			SF.click_button_save
			SF.wait_for_search_button
			SF.tab $tab_bank_accounts
			SF.select_view $bd_select_view_all
			SF.click_button_go
			gen_click_link_and_wait $bd_bank_account_commonwealth_current_account
			page.has_text?($bd_account_jboag_brewing)
			SF.click_button_edit
			BA.set_sort_code nil
			BA.set_swift_number nil
			BA.set_iban nil
			BA.set_direct_debit_originator_ref nil
			SF.click_button_save
			SF.logout
		end
		gen_end_test "TID013420 - Smoke test: Payment collections"
	end
end
