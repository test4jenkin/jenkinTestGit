##
# TID : TID020785
# Product Area: Accounting - Payments Collections & Cash Entries
# Story: AC-6831
##
describe "New Payment as of v16 - Select vendors / transactions to pay and add to proposal", :type => :request do
	include_context "login"
	include_context "logout_after_each"
	before :all do
		gen_start_test  "TID020785"
		#Hold Base Data
		FFA.hold_base_data_and_wait
		_create_data = ["CODATID020785Data.selectCompany();","CODATID020785Data.createData();","CODATID020785Data.createDataExt1();"]
		_create_data+= ["CODATID020785Data.createDataExt2();","CODATID020785Data.createDataExt3();","CODATID020785Data.createDataExt4();"]
		# Execute Commands
		APEX.execute_commands _create_data
	end

	it "New Payment as of v16 - Select vendors / transactions to pay and add to proposal", :unmanaged => true  do
	_PPLUS_PAYMENT1 = 'PPLUS-PAYMENT1'
	$locale = gen_get_current_user_locale
	_date = gen_get_current_date
	current_date = gen_locale_format_date _date, $locale
	current_date_10_days = FFA.add_days_to_date Time.now , "10"


	gen_start_test "1. TST034863 - On Hold"
	begin
		puts "- Opening a payment"

		NEWPAY.open_payment_by_description _PPLUS_PAYMENT1
		gen_wait_until_object $newpay_selecttrans_Toduedate_dataffid_access

		puts "- Retrieving transaction according to the provided details and filters."

		expected_transactions=[
		['Account: Audi'],
		['PIN','PIN3','TRN',current_date.to_s,gen_locale_format_number(0.00),gen_locale_format_number(149.00),gen_locale_format_number(0.00)],
		['PIN','PIN4','TRN',current_date.to_s,gen_locale_format_number(0.00),gen_locale_format_number(149.00), gen_locale_format_number(0.00)],
		['','','','',gen_locale_format_number(0.00),gen_locale_format_number(298.00), gen_locale_format_number(0.00)],
		['Account: BMW Automobiles'],
		['PIN','PIN2','TRN',current_date.to_s,gen_locale_format_number(7.45),gen_locale_format_number(149.00), gen_locale_format_number(0.00)],
		['PIN','PIN1','TRN',current_date_10_days.to_s,gen_locale_format_number(7.45),gen_locale_format_number(149.00), gen_locale_format_number(0.00)],
		['','','','',gen_locale_format_number(14.90),gen_locale_format_number(298.00), gen_locale_format_number(0.00)]]

		page.has_css?($newpay_selecttrans_Toduedate_dataffid_access)
		NEWPAY.set_filter_options_to_contains $newpay_selecttrans_vendor_invoice_number_options_button
		gen_wait_until_object $newpay_selecttrans_vendor_invoice_number_options_button
		NEWPAY.set_vendor_invoice_number 'PIN'

		# remove check value from payment method
		NEWPAY.set_filter_options_to_equals $newpay_selecttrans_payment_method_options_button
		NEWPAY.click_retrieve_trans_button
		expect(NEWPAY.assert_retrieved_rows? expected_transactions).to eq(true)

		NEWPAY.select_lines ['PIN3']

		gen_assert_enabled $newpay_selecttrans_add_to_proposal_button
		text_transactions_selected = '1 transactions selected, from 1 vendors'

		NEWPAY.click_add_to_proposal_button
		#Check C)
		payment_name = NEWPAY.get_payment_name
		toast_message = 'You have added 1 transactions to payment proposal ' + payment_name + '.'
		expect(NEWPAY.get_toast_message).to eq(toast_message)
		payment_value_str = 'EUR ' + gen_locale_format_number(149.00)
		gen_compare(payment_value_str, NEWPAY.get_proposal_total_value, $newpay_assert_output_text)
		gen_compare_object_visible $newpay_proposal_discount_total, false, 'TST034863'
		gen_compare('1', NEWPAY.get_proposal_document_proposed_value, $newpay_assert_output_text)
		gen_compare('1', NEWPAY.get_proposal_vendors_proposed_value, $newpay_assert_output_text)
		gen_compare('PROPOSED', NEWPAY.get_proposal_status_value, $newpay_assert_output_text)

		expected_transactions=[
		['Account: Audi'],
		['PIN','PIN4','TRN',current_date.to_s,gen_locale_format_number(0.00),gen_locale_format_number(149.00), gen_locale_format_number(0.00)],
		['','','','',gen_locale_format_number(0.00),gen_locale_format_number(149.00), gen_locale_format_number(0.00)],
		['Account: BMW Automobiles'],
		['PIN','PIN2','TRN',current_date.to_s,gen_locale_format_number(7.45),gen_locale_format_number(149.00), gen_locale_format_number(0.00)],
		['PIN','PIN1','TRN',current_date_10_days.to_s,gen_locale_format_number(7.45),gen_locale_format_number(149.00), gen_locale_format_number(0.00)],
		['','','','',gen_locale_format_number(14.90),gen_locale_format_number(298.00), gen_locale_format_number(0.00)]]
		expected_summary_values = [gen_locale_format_number(14.90),gen_locale_format_number(447.00),gen_locale_format_number(0.00)]

		expect(NEWPAY.assert_retrieved_rows? expected_transactions).to eq(true)
		gen_assert_disabled $newpay_selecttrans_add_to_proposal_button
		text_No_transactions = 'No transactions selected'
		expect(NEWPAY.assert_text_beside_addtoproposal_no_trans_selectd text_No_transactions).to eq(true)
		gen_assert_enabled $newpay_detail_button_next

		all_tabs = gen_open_link_in_new_tab "All Tabs"
		within_window all_tabs do
			expected_payment_accounts =['Name~||~Audi']
			puts "Verify that payment account line items have been created successfully"
			_payment_account_name = NEWPAY.get_account_from_paymentaccountlineitem payment_name
			_payment_account_name.eql? expected_payment_accounts

			expected_payment_lines =['Name~||~Audi,TransactionValue__c149.0']
			puts "Verify that payment line items have been created successfully"
			_field_values = NEWPAY.get_line_from_paymentlineitem payment_name
			expected_payment_lines.eql? _field_values

			expected_matchingstatus_tlis =['MatchingStatus__c~||~Proposed']
			puts "Verify that transaction line items matching status have updated to Proposed"
			_field_values = NEWPAY.get_matchingStatus_from_transactionlineitem payment_name
			expect(_field_values).to eq(expected_matchingstatus_tlis)
		end
	end
	gen_end_test "TST034863 - On Hold"

	gen_start_test "2. TST034889 - Validation - All of the transactions you add for a single account must have the same GLA as the Accounts Payable Control GLA on that account"
	begin
		_create_data= ["CODATID020785Data.createDataExt5();"]
		APEX.execute_commands _create_data

		puts "- Opening a payment"

		NEWPAY.open_payment_by_description _PPLUS_PAYMENT1
		gen_wait_until_object $newpay_selecttrans_Toduedate_dataffid_access

		puts "- Filtering by Vendor Invoice Number: PIN"
		NEWPAY.set_filter_options_to_contains $newpay_selecttrans_vendor_invoice_number_options_button
		gen_wait_until_object $newpay_selecttrans_vendor_invoice_number_options_button
		NEWPAY.set_vendor_invoice_number 'PIN'

		# remove check value from payment method
		NEWPAY.set_filter_options_to_equals $newpay_selecttrans_payment_method_options_button
		NEWPAY.click_retrieve_trans_button

		all_tabs = gen_open_link_in_new_tab "All Tabs"
		within_window all_tabs do
			_update_Audi_Account = "Account accAudi = [select Id, CODAAccountsPayableControl__c from Account where MirrorName__c=:CODABaseDataExt.NAMEACCOUNT_AUDI][0];";
			_update_Audi_Account = _update_Audi_Account + "codaGeneralLedgerAccount__c glaAPCUSD = [select id from codaGeneralLedgerAccount__c where Name =:CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLUSD][0];";
			_update_Audi_Account = _update_Audi_Account + "accAudi.CODAAccountsPayableControl__c =glaAPCUSD.Id;";
			_update_Audi_Account = _update_Audi_Account + "update accAudi;";

			puts "Change APC GLA for Audi"
			APEX.execute_commands [_update_Audi_Account]
		end

		# Check A)
		NEWPAY.select_lines ['PIN3']
		NEWPAY.click_add_to_proposal_button
		error_message = FFA.fetch_label 'PayPlusErrorLogsAddToProposal'
		NEWPAY.get_message_box_text.include? error_message
		NEWPAY.click_message_box
		all_tabs = gen_open_link_in_new_tab "All Tabs"
		within_window all_tabs do

			_update_Audi_Account = "Account accAudi = [select Id, CODAAccountsPayableControl__c from Account where MirrorName__c=:CODABaseDataExt.NAMEACCOUNT_AUDI][0];";
			_update_Audi_Account = _update_Audi_Account + "codaGeneralLedgerAccount__c glaAPCEUR = [select id from codaGeneralLedgerAccount__c where Name =:CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLEUR][0];";
			_update_Audi_Account = _update_Audi_Account + "accAudi.CODAAccountsPayableControl__c =glaAPCEUR.Id;";
			_update_Audi_Account = _update_Audi_Account + "update accAudi;";

			puts "Restore APC GLA for Audi"
			APEX.execute_commands [_update_Audi_Account]
		end
	end
	gen_end_test "2. TST034889 - Validation - All of the transactions you add for a single account must have the same GLA as the Accounts Payable Control GLA on that account"

	gen_start_test "3. TST034890 - Positive Case"
	begin
		text_No_transactions = 'No transactions selected'
		text_transactions_selected = '2 transactions selected, from 2 vendors'


		puts "- Opening a payment"
		NEWPAY.open_payment_by_description _PPLUS_PAYMENT1
		gen_wait_until_object $newpay_selecttrans_Toduedate_dataffid_access

		page.has_css?($newpay_selecttrans_Toduedate_dataffid_access)
		NEWPAY.set_filter_options_to_contains $newpay_selecttrans_vendor_invoice_number_options_button
		gen_wait_until_object $newpay_selecttrans_vendor_invoice_number_options_button
		NEWPAY.set_vendor_invoice_number 'PIN'

		# remove check value from payment method
		NEWPAY.set_filter_options_to_equals $newpay_selecttrans_payment_method_options_button
		NEWPAY.click_retrieve_trans_button
		payment_name = NEWPAY.get_payment_name
		# result A)
		expect(NEWPAY.assert_text_beside_addtoproposal_no_trans_selectd text_No_transactions).to eq(true)
		gen_assert_disabled $newpay_selecttrans_add_to_proposal_button
		gen_assert_disabled $newpay_detail_button_next

		# result B)

		expected_transactions=[
		['Account: Audi'],
		['PIN','PIN3','TRN',current_date.to_s,gen_locale_format_number(0.00),gen_locale_format_number(149.00),gen_locale_format_number(0.00)],
		['PIN','PIN4','TRN',current_date.to_s,gen_locale_format_number(0.00),gen_locale_format_number(149.00), gen_locale_format_number(0.00)],
		['','','','','',gen_locale_format_number(0.00),gen_locale_format_number(298.00), gen_locale_format_number(0.00)],
		['Account: BMW Automobiles'],
		['PIN','PIN2','TRN',current_date.to_s,gen_locale_format_number(7.45),gen_locale_format_number(149.00), gen_locale_format_number(0)],
		['PIN','PIN1','TRN',current_date_10_days.to_s,gen_locale_format_number(7.45),gen_locale_format_number(149.00), gen_locale_format_number(0.00)],
		['','','','','',gen_locale_format_number(14.90),gen_locale_format_number(298.00), gen_locale_format_number(0)]]
		expected_summary_values = [gen_locale_format_number(14.90),gen_locale_format_number(596.00),gen_locale_format_number(0.0)]

		expect(NEWPAY.assert_retrieved_rows? expected_transactions).to eq(true)
		expect(NEWPAY.summaryTotals expected_summary_values).to eq(true)

		NEWPAY.select_lines ['PIN2', 'PIN3']
		gen_assert_enabled $newpay_selecttrans_add_to_proposal_button

		NEWPAY.click_add_to_proposal_button
		# result C)
		toast_message = 'You have added 2 transactions to payment proposal ' + payment_name + '.'
		expect(NEWPAY.get_toast_message).to eq(toast_message)
		payment_value_str = 'EUR ' + gen_locale_format_number(290.55)
		gen_compare(payment_value_str, NEWPAY.get_proposal_total_value, $newpay_assert_output_text)
		gen_compare('2', NEWPAY.get_proposal_document_proposed_value, $newpay_assert_output_text)
		gen_compare('2', NEWPAY.get_proposal_vendors_proposed_value, $newpay_assert_output_text)
		gen_compare('PROPOSED', NEWPAY.get_proposal_status_value, $newpay_assert_output_text)

		puts "Check C"
		expected_transactions=[
		['Account: Audi'],
		['PIN','PIN4','TRN',current_date.to_s,gen_locale_format_number(0.00),gen_locale_format_number(149.00), gen_locale_format_number(0.00)],
		['','','','','',gen_locale_format_number(149.00), gen_locale_format_number(0.00)],
		['Account: BMW Automobiles'],
		['PIN','PIN1','TRN',current_date_10_days.to_s,gen_locale_format_number(7.45),gen_locale_format_number(149.00), gen_locale_format_number(0.00)],
		['','','','','',gen_locale_format_number(149.00), gen_locale_format_number(0.00)]]
		expect(NEWPAY.assert_retrieved_rows? expected_transactions).to eq(true)

		gen_assert_disabled $newpay_selecttrans_add_to_proposal_button
		expect(NEWPAY.assert_text_beside_addtoproposal_no_trans_selectd text_No_transactions).to eq(true)
		gen_assert_enabled $newpay_detail_button_next
	end
	gen_end_test "3. TST034890 - Positive Case"

	gen_start_test "4. TST034911 - Navigation"
	begin
		puts "- Opening a payment"
		NEWPAY.open_payment_by_description _PPLUS_PAYMENT1
 		gen_wait_until_object $newpay_review_edit_proposal_slider_dataffid

		NEWPAY.click_back_button
		NEWPAY.click_back_button
		gen_get_element_style_property $newpay_detail_payment_date , "enabled"
		gen_get_element_style_property $newpay_detail_payment_currency , "enabled"
		NEWPAY.set_bank_account $bd_bank_account_bristol_checking_account
		gen_compare($bd_currency_eur, NEWPAY.get_proposal_payment_currency_value, $newpay_assert_output_text)
		toast_message = 'The currency of the selected bank account is USD. The payment will be made in EUR. If you want to change the payment currency, you must remove all items from the payment proposal first.'
		expect(NEWPAY.get_toast_message).to include(toast_message)
	end
	gen_end_test "4. TST034911  Navigation"

	gen_start_test "5. TST035225 - Validation- Only 'Available' transactions can be added to the payment proposal."
	begin
		text_No_transactions = 'No transactions selected'
		text_transactions_selected = '2 transactions selected, from 2 vendors'
		expected_summary_values = [gen_locale_format_number(14.90),gen_locale_format_number(596.00),gen_locale_format_number(0.00)]

		_create_data= ["CODATID020785Data.createDataExt5();"]
		APEX.execute_commands _create_data

		puts "- Opening a payment"
		NEWPAY.open_payment_by_description _PPLUS_PAYMENT1
		gen_wait_until_object $newpay_selecttrans_Toduedate_dataffid_access


		NEWPAY.set_filter_options_to_contains $newpay_selecttrans_vendor_invoice_number_options_button
		payment_name = NEWPAY.get_payment_name
		gen_wait_until_object $newpay_selecttrans_vendor_invoice_number_options_button
		NEWPAY.set_vendor_invoice_number 'PIN'
		# remove check value from payment method
		NEWPAY.set_filter_options_to_equals $newpay_selecttrans_payment_method_options_button
		NEWPAY.click_retrieve_trans_button
		##Check A)
		expect(NEWPAY.assert_text_beside_addtoproposal_no_trans_selectd text_No_transactions).to eq(true)
		gen_assert_disabled $newpay_selecttrans_add_to_proposal_button
		expect(NEWPAY.summaryTotals expected_summary_values).to eq(true)
		gen_assert_disabled $newpay_detail_button_next

		NEWPAY.select_lines ['PIN2']
		NEWPAY.click_add_to_proposal_button
		##Check B)
		expected_transactions=[
		['Account: Audi'],
		['PIN','PIN3','TRN',current_date.to_s,gen_locale_format_number(0.00),gen_locale_format_number(149.00),gen_locale_format_number(0.00)],
		['PIN','PIN4','TRN',current_date.to_s,gen_locale_format_number(0.00),gen_locale_format_number(149.00), gen_locale_format_number(0.00)],
		['','','','','',gen_locale_format_number(0.00),gen_locale_format_number(298.00), gen_locale_format_number(0.00)],
		['Account: BMW Automobiles'],
		['PIN','PIN1','TRN',current_date_10_days.to_s,gen_locale_format_number(7.45),gen_locale_format_number(149.00), gen_locale_format_number(0.00)],
		['','','','','',gen_locale_format_number(7.45),gen_locale_format_number(149.00), gen_locale_format_number(0.00)]]
		expected_summary_values = [gen_locale_format_number(7.45),gen_locale_format_number(447.00),gen_locale_format_number(0.00)]

		expect(NEWPAY.assert_retrieved_rows? expected_transactions).to eq(true)
		expect(NEWPAY.summaryTotals expected_summary_values).to eq(true)
		expect(NEWPAY.assert_text_beside_addtoproposal_no_trans_selectd text_No_transactions).to eq(true)
		gen_assert_disabled $newpay_selecttrans_add_to_proposal_button
		all_tabs = gen_open_link_in_new_tab "All Tabs"
		within_window all_tabs do
			SF.tab $tab_payable_invoices
			invoice_number = PIN.get_invoice_number_by_vendor_invoice_number 'PIN1'
			PIN.open_invoice_detail_page invoice_number
			PIN.click_on_hold
		end

		puts "Do another payment for PIN3"
		within_window all_tabs do

			_create_data= ["CODATID020785Data.createDataExt5();"]
			APEX.execute_commands _create_data

			puts "- Opening a payment"
			NEWPAY.open_payment_by_description _PPLUS_PAYMENT1
			gen_wait_until_object $newpay_selecttrans_Toduedate_dataffid_access


			NEWPAY.set_filter_options_to_equals $newpay_selecttrans_payment_method_options_button
			NEWPAY.click_retrieve_trans_button

			payment_name1 = NEWPAY.get_payment_name
			NEWPAY.select_lines ['PIN3']
			NEWPAY.click_add_to_proposal_button

			expected_matchingstatus_tlis =['MatchingStatus__c~||~Proposed']
			puts "Verify that transaction line items matching status have updated to Proposed"
			_field_values = NEWPAY.get_matchingStatus_from_transactionlineitem payment_name1
			expect(_field_values).to eq(expected_matchingstatus_tlis)
		end

		puts "Do Cash Matching"
		within_window all_tabs do
			SF.tab $tab_cash_entries
			CE_NUM = CE.get_cash_entry_name_by_reference 'CSH1'
			SF.tab $tab_payable_invoices
			SF.click_button_go
			PIN_NUM = PIN.get_invoice_number_by_vendor_invoice_number 'PIV3'
			SF.tab $tab_cash_matching
			CM.set_cash_matching_account $bd_account_bmw_automobiles
			CM.set_matching_date current_date
			CM.click_retrieve
			page.has_text?(CE_NUM)
			page.has_text?(PIN_NUM)
			CM.select_cashentry_doc_for_matching CE_NUM, 1
			CM.select_trans_doc_for_matching PIN_NUM , 1
			CM.click_commit_data
			SF.wait_for_search_button
		end

		NEWPAY.select_lines ['PIN1', 'PIN3']
		NEWPAY.click_add_to_proposal_button
		expected_transactions=[['Account: Audi'],
		['PIN','PIN4','TRN',current_date.to_s,gen_locale_format_number(0.00),gen_locale_format_number(149.00), gen_locale_format_number(0.00)],
		['','','','','',gen_locale_format_number(0.00),gen_locale_format_number(149.00), gen_locale_format_number(0.00)]]
		expected_summary_values = [gen_locale_format_number(0.00),gen_locale_format_number(149.00),gen_locale_format_number(0.00)]

		error_message1 = FFA.fetch_label 'PayPlusTLIIsNotAvailable'
		error_message2 = FFA.fetch_label 'PayPlusOnHoldCannotModifyOnProposedStatus'
		NEWPAY.get_message_box_text.include? error_message1
		NEWPAY.get_message_box_text.include? error_message2
		NEWPAY.click_message_box

		expect(NEWPAY.assert_retrieved_rows? expected_transactions).to eq(true)
		expect(NEWPAY.summaryTotals expected_summary_values).to eq(true)
		puts "Verify that payment line items have been created successfully"
		expected_payment_lines =['Name~||~BMW Automobiles,TransactionValue__c141.55']
		_field_values = NEWPAY.get_line_from_paymentlineitem payment_name
		expected_payment_lines.eql? _field_values

	end
	gen_end_test "5. TST035225 - Validation- Only 'Available' transactions can be added to the payment proposal."

	end
	after :all do
		login_user
		all_tabs = gen_open_link_in_new_tab "All Tabs"
		within_window all_tabs do
			_update_Audi_Account = "Account accAudi = [select Id, CODAAccountsPayableControl__c from Account where MirrorName__c=:CODABaseDataExt.NAMEACCOUNT_AUDI][0];";
			_update_Audi_Account = _update_Audi_Account + "codaGeneralLedgerAccount__c glaAPCEUR = [select id from codaGeneralLedgerAccount__c where Name =:CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLEUR][0];";
			_update_Audi_Account = _update_Audi_Account + "accAudi.CODAAccountsPayableControl__c =glaAPCEUR.Id;";
			_update_Audi_Account = _update_Audi_Account + "update accAudi;";

			puts "Restore APC GLA for Audi"
			APEX.execute_commands [_update_Audi_Account]
		end
		# Delete Test Data
		_delete_data = ["CODATID020785Data.destroyData();"]
		APEX.execute_commands _delete_data
		FFA.delete_new_data_and_wait
		gen_end_test "TID020785"
		SF.logout
	end
end