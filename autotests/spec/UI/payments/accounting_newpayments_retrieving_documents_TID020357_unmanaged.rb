##
# TID : TID020357
# Product Area: Accounting - Payments Collections & Cash Entries
# Story: AC-6697
##
describe "Retrieving transactions", :type => :request do
include_context "login"
include_context "logout_after_each"
	before :all do
	gen_start_test  "TID020357"
	#Hold Base Data
	FFA.hold_base_data_and_wait
	_create_data = ["CODATID020357Data.selectCompany();", "CODATID020357Data.createData();", "CODATID020357Data.createDataExt1();"]
	_create_data+= ["CODATID020357Data.createDataExt2();", "CODATID020357Data.createDataExt3();", "CODATID020357Data.createDataExt4();"]
	_create_data+= ["CODATID020357Data.createDataExt5();", "CODATID020357Data.createDataExt6();"]
	# Execute Commands
	APEX.execute_commands _create_data
	end

	it "Execute Script as Admin user. Create a Payment", :unmanaged => true  do
	_PPLUS_TST033507 = 'PPLUS-TST033507'
	_PPLUS_10_DAYS_AGO = 'PPLUS 10 DAYS AGO'
	$locale = gen_get_current_user_locale
	current_date = FFA.get_current_formatted_date
	
	current_date_10_days = FFA.add_days_to_date Time.now , "10"
	current_date_20_days = FFA.add_days_to_date Time.now , "20"
	current_date_19_days= FFA.add_days_to_date Time.now , "19"
	yesterday = FFA.add_days_to_date Time.now , "-1"
	yesterday_1 = FFA.add_days_to_date Time.now , "-2"

	gen_start_test "1. TST033507 - Positive case - retrieve some documents"
	begin
		NEWPAY.open_payment_by_description _PPLUS_TST033507

		puts "- Retrieving transaction according to the pƒΩrovided details and filters."
		expected_transactions=[['Account: Audi'],
		['PIN','PIN3','TRN',current_date.to_s,gen_locale_format_number(0.00),gen_locale_format_number(500.00),gen_locale_format_number(0.00)],
		['PCR','PCN2','TRN',current_date_20_days.to_s,gen_locale_format_number(0.00),gen_locale_format_number(-600.00), gen_locale_format_number(0.00)],
		['','','','','',gen_locale_format_number(0.00),gen_locale_format_number(-100.00), gen_locale_format_number(0.00)],
		['Account: Chrysler Motors LLC'],
		['CSH','','TRN',yesterday_1.to_s,gen_locale_format_number(0.00),gen_locale_format_number(-100.00), gen_locale_format_number(0.00)],
		['JNL','','TRN',yesterday.to_s,gen_locale_format_number(0.00),gen_locale_format_number(-300.00), gen_locale_format_number(0.00)],
		['PIN','PIN1','TRN',current_date_10_days.to_s,gen_locale_format_number(200.00),gen_locale_format_number(2000.00), gen_locale_format_number(0.00)],
		['PCR','PCN1','TRN',current_date_20_days.to_s,gen_locale_format_number(-50.00),gen_locale_format_number(-500.00), gen_locale_format_number(0.00)],
		['','','','','',gen_locale_format_number(150.00),gen_locale_format_number(1100.00), gen_locale_format_number(0.00)]]

		NEWPAY.set_filter_options_to_equals $newpay_selecttrans_payment_method_options_button
		NEWPAY.click_retrieve_trans_button
		expect(NEWPAY.assert_retrieved_rows? expected_transactions).to eq(true)
	end
	gen_end_test "TST033507 - Positive case - retrieve some documents"

	gen_start_test "2. TST033508 - Available columns / User can add and remove columns"
	begin
		puts "- Opening a payment."
		NEWPAY.open_payment_by_description _PPLUS_TST033507
		gen_wait_until_object $newpay_selecttrans_Toduedate_dataffid_access

		NEWPAY.set_filter_options_to_equals $newpay_selecttrans_payment_method_options_button
		NEWPAY.click_retrieve_trans_button
		expected_table_header = ["", "DOCUMENT NUMBER", "VENDOR DOCUMENT NUMBER", "TRANSACTION NUMBER", "DUE DATE", "DISCOUNT", "OUTSTANDING VALUE", "PAYMENT VALUE"]
		expect(NEWPAY.assert_retrieved_table_header expected_table_header).to eq(true)
		puts "- The columns displayed are the expected."
	end
	gen_end_test "TST033508 - Available columns / User can add and remove columns"

	gen_start_test "3. TST033509 - User can sort by any column header"
	begin
		puts "- opening a payment"
		NEWPAY.open_payment_by_description _PPLUS_TST033507
		gen_wait_until_object $newpay_selecttrans_Toduedate_dataffid_access

		NEWPAY.set_filter_options_to_equals $newpay_selecttrans_payment_method_options_button
		NEWPAY.click_retrieve_trans_button

		puts "- Clicking on document number column header."
		NEWPAY.click_document_column_header $newpay_selecttrans_document_number

		expected_transactions=[
		['Account: Audi'],
		['PCR','PCN2','TRN',current_date_20_days.to_s,gen_locale_format_number(0.00),gen_locale_format_number(-600.00), gen_locale_format_number(0.00)],
		['PIN','PIN3','TRN',current_date.to_s,gen_locale_format_number(0.00),gen_locale_format_number(500.00),gen_locale_format_number(0.00)],
		['','','','','',gen_locale_format_number(0.00),gen_locale_format_number(-100.00), gen_locale_format_number(0.00)],
		['Account: Chrysler Motors LLC'],
		['CSH','','TRN',yesterday_1.to_s,gen_locale_format_number(0.00),gen_locale_format_number(-100.00), gen_locale_format_number(0.00)],
		['JNL','','TRN',yesterday.to_s,gen_locale_format_number(0.00),gen_locale_format_number(-300.00), gen_locale_format_number(0.00)],
		['PCR','PCN1','TRN',current_date_20_days.to_s,gen_locale_format_number(-50.00),gen_locale_format_number(-500.00), gen_locale_format_number(0.00)],
		['PIN','PIN1','TRN',current_date_10_days.to_s,gen_locale_format_number(200.00),gen_locale_format_number(2000.00), gen_locale_format_number(0.00)],
		['','','','','',gen_locale_format_number(150.00),gen_locale_format_number(1100.00), gen_locale_format_number(0.00)]]

		puts "- Checking that documents are have been sorted in a descendant way."
		expect(NEWPAY.assert_retrieved_rows? expected_transactions).to eq(true)

		puts "- Clicking on document number column header."
		NEWPAY.click_document_column_header $newpay_selecttrans_document_number

		expected_transactions=[
		['Account: Audi'],
		['PIN','PIN3','TRN',current_date.to_s,gen_locale_format_number(0.00),gen_locale_format_number(500.00),gen_locale_format_number(0.00)],
		['PCR','PCN2','TRN',current_date_20_days.to_s,gen_locale_format_number(0.00),gen_locale_format_number(-600.00), gen_locale_format_number(0.00)],
		['','','','','',gen_locale_format_number(0.00),gen_locale_format_number(-100.00), gen_locale_format_number(0.00)],
		['Account: Chrysler Motors LLC'],
		['PIN','PIN1','TRN',current_date_10_days.to_s,gen_locale_format_number(200.00),gen_locale_format_number(2000.00), gen_locale_format_number(0.00)],
		['PCR','PCN1','TRN',current_date_20_days.to_s,gen_locale_format_number(-50.00),gen_locale_format_number(-500.00), gen_locale_format_number(0.00)],
		['JNL','','TRN',yesterday.to_s,gen_locale_format_number(0.00),gen_locale_format_number(-300.00), gen_locale_format_number(0.00)],
		['CSH','','TRN',yesterday_1.to_s,gen_locale_format_number(0.00),gen_locale_format_number(-100.00), gen_locale_format_number(0.00)],
		['','','','','',gen_locale_format_number(150.00),gen_locale_format_number(1100.00), gen_locale_format_number(0.00)]]
	
		puts "- Checking that documents are have been sorted ina a ascendant way."
		expect(NEWPAY.assert_retrieved_rows? expected_transactions).to eq(true)
	end
	gen_end_test "TST033509 - User can sort by any column heading"


	gen_start_test "5. TST033518 - FILTER by Due Date"
	begin
		puts "- opening a payment"

		NEWPAY.open_payment_by_description _PPLUS_TST033507
		gen_wait_until_object $newpay_selecttrans_Toduedate_dataffid_access

		NEWPAY.set_due_date current_date_10_days
		NEWPAY.set_filter_options_to_equals $newpay_selecttrans_payment_method_options_button

		puts "- Retrieving transaction according to the provided details and filters."
		NEWPAY.click_retrieve_trans_button
		expected_transactions=[['Account: Audi'],['PIN','PIN3','TRN',current_date.to_s,gen_locale_format_number(0.00),gen_locale_format_number(500.00),gen_locale_format_number(0.00)],
		['','','','','',gen_locale_format_number(0.00),gen_locale_format_number(500.00), gen_locale_format_number(0.00)],
		['Account: Chrysler Motors LLC'],
		['CSH','','TRN',yesterday_1.to_s,gen_locale_format_number(0.00),gen_locale_format_number(-100.00), gen_locale_format_number(0.00)],
		['JNL','','TRN',yesterday.to_s,gen_locale_format_number(0.00),gen_locale_format_number(-300.00), gen_locale_format_number(0.00)],
		['PIN','PIN1','TRN',current_date_10_days.to_s,gen_locale_format_number(200.00),gen_locale_format_number(2000.00), gen_locale_format_number(0.00)],
		['','','','','',gen_locale_format_number(200.00),gen_locale_format_number(1600.00), gen_locale_format_number(0.00)]]

		puts "- Checking that documents are retrieved according to the provided filters"
		expect(NEWPAY.assert_retrieved_rows? expected_transactions).to eq(true)
	end
	gen_end_test "5. TST033518 - FILTER by Due Date"


	gen_start_test "6. TST033519 - FILTER by Due Date + Payment method"
	begin
		puts "- opening a payment"

		NEWPAY.open_payment_by_description _PPLUS_TST033507
		gen_wait_until_object $newpay_selecttrans_Toduedate_dataffid_access

		puts "- Setting filters"
		NEWPAY.set_due_date current_date_10_days
		NEWPAY.set_filter_options_to_multiselect $newpay_selecttrans_payment_method_options_button
		NEWPAY.set_payment_method $bd_payment_method_check
		NEWPAY.set_filter_options_to_equals $newpay_selecttrans_payment_method_options_button


		puts "- Retrieving transaction according to the provided details and filters."
		NEWPAY.click_retrieve_trans_button

		expected_transactions=[['Account: Audi'],['PIN','PIN3','TRN',current_date.to_s,gen_locale_format_number(0.00),gen_locale_format_number(500.00),gen_locale_format_number(0.00)],
		['','','','','',gen_locale_format_number(0.00),gen_locale_format_number(500.00), gen_locale_format_number(0.00)],
		['Account: Chrysler Motors LLC'],
		['CSH','','TRN',yesterday_1.to_s,gen_locale_format_number(0.00),gen_locale_format_number(-100.00), gen_locale_format_number(0.00)],
		['JNL','','TRN',yesterday.to_s,gen_locale_format_number(0.00),gen_locale_format_number(-300.00), gen_locale_format_number(0.00)],
		['PIN','PIN1','TRN',current_date_10_days.to_s,gen_locale_format_number(200.00),gen_locale_format_number(2000.00), gen_locale_format_number(0.00)],
		['','','','','',gen_locale_format_number(200.00),gen_locale_format_number(1600.00), gen_locale_format_number(0.00)]]

		puts "- Checking that documents are retrieved and they are grouped and sorted by account name."
		expect(NEWPAY.assert_retrieved_rows? expected_transactions).to eq(true)

		puts "- Clicking on Show filters."
		NEWPAY.click_show_hide_filters_button

		NEWPAY.set_due_date current_date_10_days
		NEWPAY.set_filter_options_to_equals $newpay_selecttrans_payment_method_options_button

		NEWPAY.click_retrieve_trans_button
		expected_transactions=[['Account: Audi'],['PIN','PIN3','TRN',current_date.to_s,gen_locale_format_number(0.00),gen_locale_format_number(500.00),gen_locale_format_number(0.00)],
		['','','','','',gen_locale_format_number(0.00),gen_locale_format_number(500.00), gen_locale_format_number(0.00)],
		['Account: Chrysler Motors LLC'],
		['CSH','','TRN',yesterday_1.to_s,gen_locale_format_number(0.00),gen_locale_format_number(-100.00), gen_locale_format_number(0.00)],
		['JNL','','TRN',yesterday.to_s,gen_locale_format_number(0.00),gen_locale_format_number(-300.00), gen_locale_format_number(0.00)],
		['PIN','PIN1','TRN',current_date_10_days.to_s,gen_locale_format_number(200.00),gen_locale_format_number(2000.00), gen_locale_format_number(0.00)],
		['','','','','',gen_locale_format_number(200.00),gen_locale_format_number(1600.00), gen_locale_format_number(0.00)]]

		puts "- Checking the documents retrieved."
		expect(NEWPAY.assert_retrieved_rows? expected_transactions).to eq(true)

		puts "- Clicking on Show filters."
		NEWPAY.click_show_hide_filters_button

		NEWPAY.set_due_date current_date_10_days
		NEWPAY.set_filter_options_to_equals $newpay_selecttrans_payment_method_options_button
		NEWPAY.set_payment_method $bd_newpayment_method_none

		NEWPAY.click_retrieve_trans_button
		expected_transactions=[['There are no items to pay.']]

		puts "- Checking that no documents have been retrieved."
		gen_compare_has_content "There are no items to pay.", true, "No documents were expected."
	end
	gen_end_test "6. TST033519 - FILTER by Due Date + Payment method"


	gen_start_test "7. TST033520 - FILTER by Due Date + Payment method + APC GLA"
	begin
		puts "- opening a payment"
		NEWPAY.open_payment_by_description _PPLUS_TST033507
		gen_wait_until_object $newpay_selecttrans_Toduedate_dataffid_access

		puts "- Setting filters"
		NEWPAY.set_due_date current_date_10_days
		NEWPAY.set_filter_options_to_equals $newpay_selecttrans_payment_method_options_button
		NEWPAY.set_APC_GLA $bd_gla_account_payable_control_usd
		NEWPAY.set_APC_GLA $bd_gla_account_payable_control_eur

		puts "- Retrieving transaction according to the provided details and filters."
		NEWPAY.click_retrieve_trans_button

		expected_transactions=[['Account: Audi'],['PIN','PIN3','TRN',current_date.to_s,gen_locale_format_number(0.00),gen_locale_format_number(500.00),gen_locale_format_number(0.00)],
		['','','','','',gen_locale_format_number(0.00),gen_locale_format_number(500.00), gen_locale_format_number(0.00)],
		['Account: Chrysler Motors LLC'],
		['CSH','','TRN',yesterday_1.to_s,gen_locale_format_number(0.00),gen_locale_format_number(-100.00), gen_locale_format_number(0.00)],
		['JNL','','TRN',yesterday.to_s,gen_locale_format_number(0.00),gen_locale_format_number(-300.00), gen_locale_format_number(0.00)],
		['PIN','PIN1','TRN',current_date_10_days.to_s,gen_locale_format_number(200.00),gen_locale_format_number(2000.00), gen_locale_format_number(0.00)],
		['','','','','',gen_locale_format_number(200.00),gen_locale_format_number(1600.00), gen_locale_format_number(0.00)]]

		puts "- Verify the documents retrieved "
		expect(NEWPAY.assert_retrieved_rows? expected_transactions).to eq(true)

		puts "- Clicking on Show filters."
		NEWPAY.click_show_hide_filters_button

		NEWPAY.set_due_date current_date_10_days
		NEWPAY.set_filter_options_to_contains $newpay_selecttrans_acc_pay_cont_GLAs_options_button
		NEWPAY.set_APC_GLA $bd_gla_account_payable_control_usd
		NEWPAY.set_filter_options_to_equals $newpay_selecttrans_payment_method_options_button

		NEWPAY.click_retrieve_trans_button

		expected_transactions=[['Account: Chrysler Motors LLC'],
		['CSH','','TRN',yesterday_1.to_s,gen_locale_format_number(0.00),gen_locale_format_number(-100.00), gen_locale_format_number(0.00)],
		['JNL','','TRN',yesterday.to_s,gen_locale_format_number(0.00),gen_locale_format_number(-300.00), gen_locale_format_number(0.00)],
		['PIN','PIN1','TRN',current_date_10_days.to_s,gen_locale_format_number(200.00),gen_locale_format_number(2000.00), gen_locale_format_number(0.00)],
		['','','','','',gen_locale_format_number(200.00),gen_locale_format_number(1600.00), gen_locale_format_number(0.00)]]

		puts "- Checking the documents that have been retrieved."
		expect(NEWPAY.assert_retrieved_rows? expected_transactions).to eq(true)
	end
	gen_end_test "7. TST033520 - FILTER by Due Date + Payment method + APC GLA"

	gen_start_test "8. TST033521 - FILTER by Due Date + Payment method + APC GLA + Vendor Invoice Number"
	begin
		_vendor_invoice_number = 'PIN'

		puts "- opening a payment"

		NEWPAY.open_payment_by_description _PPLUS_TST033507
		gen_wait_until_object $newpay_selecttrans_Toduedate_dataffid_access

		puts "- Setting filters"
		NEWPAY.set_due_date current_date_10_days
		NEWPAY.set_APC_GLA $bd_gla_account_payable_control_usd
		NEWPAY.set_APC_GLA $bd_gla_account_payable_control_eur
		NEWPAY.set_filter_options_to_contains $newpay_selecttrans_vendor_invoice_number_options_button
		NEWPAY.set_vendor_invoice_number _vendor_invoice_number
		NEWPAY.set_filter_options_to_equals $newpay_selecttrans_payment_method_options_button

		puts "- Retrieving transaction according to the provided details and filters."
		NEWPAY.click_retrieve_trans_button
		expected_transactions=[['Account: Audi'],['PIN','PIN3','TRN',current_date.to_s,gen_locale_format_number(0.00),gen_locale_format_number(500.00),gen_locale_format_number(0.00)],
		['','','','','',gen_locale_format_number(0.00),gen_locale_format_number(500.00), gen_locale_format_number(0.00)],
		['Account: Chrysler Motors LLC'],
		['PIN','PIN1','TRN',current_date_10_days.to_s,gen_locale_format_number(200.00),gen_locale_format_number(2000.00), gen_locale_format_number(0.00)],
		['','','','','',gen_locale_format_number(200.00),gen_locale_format_number(2000.00), gen_locale_format_number(0.00)]]

		puts "- Checking that documents are retrieved and they are grouped and sorted by account name."
		expect(NEWPAY.assert_retrieved_rows? expected_transactions).to eq(true)

		NEWPAY.click_show_hide_filters_button

		NEWPAY.set_due_date current_date_10_days
		NEWPAY.set_APC_GLA $bd_gla_account_payable_control_usd
		NEWPAY.set_APC_GLA $bd_gla_account_payable_control_eur
		NEWPAY.set_filter_options_to_contains $newpay_selecttrans_vendor_invoice_number_options_button
		_vendor_invoice_number = "PIN1"
		NEWPAY.set_vendor_invoice_number _vendor_invoice_number

		NEWPAY.click_retrieve_trans_button
		expected_transactions=[['Account: Chrysler Motors LLC'],
		['PIN','PIN1','TRN',current_date_10_days.to_s,gen_locale_format_number(200.00),gen_locale_format_number(2000.00), gen_locale_format_number(0.00)],
		['','','','','',gen_locale_format_number(200.00),gen_locale_format_number(2000.00), gen_locale_format_number(0.00)]]

		puts "- Checking that documents are retrieved and only those with vendor invoice number PIN1 appear"
		expect(NEWPAY.assert_retrieved_rows? expected_transactions).to eq(true)
	end
	gen_end_test "8. TST033521 - FILTER by Due Date + Payment method + APC GLA + Vendor Invoice Number"

	gen_start_test "9. TST033522 - FILTER by Due Date + Payment method + APC GLA + Payable Invoice Number"
	begin
		_payable_invoice_number = 'PIN'

		puts "- opening a payment"
		NEWPAY.open_payment_by_description _PPLUS_TST033507
		gen_wait_until_object $newpay_selecttrans_Toduedate_dataffid_access

		NEWPAY.set_due_date current_date_10_days
		NEWPAY.set_filter_options_to_equals $newpay_selecttrans_payment_method_options_button
		NEWPAY.set_APC_GLA $bd_gla_account_payable_control_usd
		NEWPAY.set_APC_GLA $bd_gla_account_payable_control_eur
		NEWPAY.set_filter_options_to_contains $newpay_selecttrans_payable_invoice_number_options_button
		NEWPAY.set_payable_invoice_number _payable_invoice_number

		NEWPAY.click_retrieve_trans_button
		expected_transactions=[['Account: Audi'],['PIN','PIN3','TRN',current_date.to_s,gen_locale_format_number(0.00),gen_locale_format_number(500.00),gen_locale_format_number(0.00)],
		['','','','','',gen_locale_format_number(0.00),gen_locale_format_number(500.00), gen_locale_format_number(0.00)],
		['Account: Chrysler Motors LLC'],
		['PIN','PIN1','TRN',current_date_10_days.to_s,gen_locale_format_number(200.00),gen_locale_format_number(2000.00), gen_locale_format_number(0.00)],
		['','','','','',gen_locale_format_number(200.00),gen_locale_format_number(2000.00), gen_locale_format_number(0.00)]]

		puts "- Checking that documents are retrieved and they are grouped and sorted by account name."
		expect(NEWPAY.assert_retrieved_rows? expected_transactions).to eq(true)
	end
	gen_end_test "9. TST033522 - FILTER by Due Date + Payment method + APC GLA + Payable Invoice Number"

	gen_start_test "10. TST033523 - FILTER by Due Date + Payment method + APC GLA + Vendor Name"
	begin

		puts "- opening a payment"
		NEWPAY.open_payment_by_description _PPLUS_TST033507
		gen_wait_until_object $newpay_selecttrans_Toduedate_dataffid_access


		NEWPAY.set_due_date current_date_10_days
		NEWPAY.set_filter_options_to_equals $newpay_selecttrans_payment_method_options_button
		NEWPAY.set_APC_GLA $bd_gla_account_payable_control_usd
		NEWPAY.set_APC_GLA $bd_gla_account_payable_control_eur
		NEWPAY.set_filter_options_to_fromTo $newpay_selecttrans_vendor_name_options_button
		NEWPAY.set_vendor_name $bd_account_audi

		NEWPAY.click_retrieve_trans_button
		expected_transactions=[['Account: Audi'],['PIN','PIN3','TRN',current_date.to_s,gen_locale_format_number(0.00),gen_locale_format_number(500.00),gen_locale_format_number(0.00)],
		['','','','','',gen_locale_format_number(0.00),gen_locale_format_number(500.00), gen_locale_format_number(0.00)],
		['Account: Chrysler Motors LLC'],
		['CSH','','TRN',yesterday_1.to_s,gen_locale_format_number(0.00),gen_locale_format_number(-100.00), gen_locale_format_number(0.00)],
		['JNL','','TRN',yesterday.to_s,gen_locale_format_number(0.00),gen_locale_format_number(-300.00), gen_locale_format_number(0.00)],
		['PIN','PIN1','TRN',current_date_10_days.to_s,gen_locale_format_number(200.00),gen_locale_format_number(2000.00), gen_locale_format_number(0.00)],
		['','','','','',gen_locale_format_number(200.00),gen_locale_format_number(1600.00), gen_locale_format_number(0.00)]]

		puts "- Checking that documents are retrieved and they are grouped and sorted by account name."
		expect(NEWPAY.assert_retrieved_rows? expected_transactions).to eq(true)

	end
	gen_end_test "10. TST033523 - FILTER by Due Date + Payment method + APC GLA + Vendor Name"

	gen_start_test "11. TST033524 - FILTER by Due Date + Payment method + APC GLA+ Document Currency."
	begin
		puts "- opening a payment"
		NEWPAY.open_payment_by_description _PPLUS_10_DAYS_AGO
		gen_wait_until_object $newpay_selecttrans_Toduedate_dataffid_access

		puts "- Retrieving transaction according to the provided details and filters."
		NEWPAY.set_due_date current_date_10_days
		NEWPAY.set_filter_options_to_equals $newpay_selecttrans_payment_method_options_button
		NEWPAY.set_APC_GLA $bd_gla_account_payable_control_usd
		NEWPAY.set_APC_GLA $bd_gla_account_payable_control_eur

		NEWPAY.click_retrieve_trans_button

		expected_transactions=[['Account: BMW Automobiles'],
		['PIN','PIN4','TRN',current_date.to_s,gen_locale_format_number(40.00),gen_locale_format_number(800.00), gen_locale_format_number(0.00)],
		['','','','','',gen_locale_format_number(40.00),gen_locale_format_number(800.00), gen_locale_format_number(0.00)]]

		puts "- Checking that documents are retrieved and they are grouped and sorted by account name."
		expect(NEWPAY.assert_retrieved_rows? expected_transactions).to eq(true)

	end
	gen_end_test "11. TST033524 - FILTER by Due Date + Payment method + APC GLA+ Document Currency"

	gen_start_test "13. TST033557 - Hide / Show filter"
	begin
		puts "- opening a payment"
		NEWPAY.open_payment_by_description _PPLUS_TST033507
		gen_wait_until_object $newpay_selecttrans_Toduedate_dataffid_access

		puts "- Retrieving transactions"
		NEWPAY.assert_filters_visibility true
		NEWPAY.set_due_date current_date_20_days
		NEWPAY.click_retrieve_trans_button
		NEWPAY.assert_filters_visibility false

		puts "- Checking that filters are hidden"
		gen_compare_object_visible $newpay_selecttrans_Toduedate, false, "Due date should be hidden"

		NEWPAY.click_show_hide_filters_button
		puts "- Checking that filters are visible"
		NEWPAY.assert_filters_visibility true
		gen_compare_object_visible $newpay_selecttrans_Toduedate, true, "Due date should be visible"
	end
	gen_end_test "13. TST033557 - Hide / Show filter"

	gen_start_test "14. TST033558 - TLIs which their Transaction Date > Payment Date will be retrieved"
	begin
		puts "- opening a payment"
		NEWPAY.open_payment_by_description _PPLUS_TST033507
		gen_wait_until_object $newpay_selecttrans_Toduedate_dataffid_access
		
		puts "- Retrieving transactions"
		NEWPAY.set_due_date current_date_19_days
		NEWPAY.set_filter_options_to_equals $newpay_selecttrans_payment_method_options_button

		NEWPAY.click_retrieve_trans_button

		expected_transactions=[['Account: Audi'],
		['PIN','PIN3','TRN',current_date.to_s,gen_locale_format_number(0.00),gen_locale_format_number(500.00),gen_locale_format_number(0.00)],
		['','','','','',gen_locale_format_number(0.00),gen_locale_format_number(500.00), gen_locale_format_number(0.00)],
		['Account: Chrysler Motors LLC'],
		['CSH','','TRN',yesterday_1.to_s,gen_locale_format_number(0.00),gen_locale_format_number(-100.00), gen_locale_format_number(0.00)],
		['JNL','','TRN',yesterday.to_s,gen_locale_format_number(0.00),gen_locale_format_number(-300.00), gen_locale_format_number(0.00)],
		['PIN','PIN1','TRN',current_date_10_days.to_s,gen_locale_format_number(200.00),gen_locale_format_number(2000.00), gen_locale_format_number(0.00)],
		['','','','','',gen_locale_format_number(200.00),gen_locale_format_number(1600.00), gen_locale_format_number(0.00)]]

		puts "- Checking that documents are retrieved and they are grouped and sorted by account name."
		expect(NEWPAY.assert_retrieved_rows? expected_transactions).to eq(true)

	end
	gen_end_test "14. TST033558 - TLIs which their Transaction Date > Payment Date will be retrieved"

	gen_start_test "15. TST033559 - TLIs which documents are On Hold will be retrieved"
	begin
		puts "- opening a payment"
		NEWPAY.open_payment_by_description _PPLUS_10_DAYS_AGO
		gen_wait_until_object $newpay_selecttrans_Toduedate_dataffid_access

		puts "- Retrieving transaction according to the provided details and filters."
		NEWPAY.set_due_date current_date_20_days
		NEWPAY.set_filter_options_to_equals $newpay_selecttrans_payment_method_options_button
		NEWPAY.click_retrieve_trans_button

		expected_transactions=[['Account: BMW Automobiles'],
		['PIN','PIN4','TRN',current_date.to_s,gen_locale_format_number(40.00),gen_locale_format_number(800.00), gen_locale_format_number(0.00)],
		['','','','','',gen_locale_format_number(40.00),gen_locale_format_number(800.00), gen_locale_format_number(0.00)]]

		puts "- Checking that documents are retrieved and they are grouped and sorted by account name."
		expect(NEWPAY.assert_retrieved_rows? expected_transactions).to eq(true)
	end
	gen_end_test "15. TST033559 - TLIs which documents are On Hold will be retrieved"

	gen_start_test "16. TST033560 - Accounts with Debit Balance will be retrieved"
	begin
		puts "- opening a payment"
		NEWPAY.open_payment_by_description _PPLUS_TST033507
		gen_wait_until_object $newpay_selecttrans_Toduedate_dataffid_access

		puts "- Retrieving transaction according to the provided details and filters."
		NEWPAY.set_vendor_name $bd_account_audi

		NEWPAY.set_filter_options_to_equals $newpay_selecttrans_payment_method_options_button
		NEWPAY.click_retrieve_trans_button
		expected_transactions=[['Account: Audi'],
		['PIN','PIN3','TRN',current_date.to_s,gen_locale_format_number(0.00),gen_locale_format_number(500.00), gen_locale_format_number(0.00)],
		['PCR','PCN2','TRN',current_date_20_days.to_s,gen_locale_format_number(0.00),gen_locale_format_number(-600.00), gen_locale_format_number(0.00)],
		['','','','','',gen_locale_format_number(0.00),gen_locale_format_number(-100.00), gen_locale_format_number(0.00)]]

		puts "- Checking that documents are retrieved and they are grouped and sorted by account name."
		expect(NEWPAY.assert_retrieved_rows? expected_transactions).to eq(true)
	end
	gen_end_test "16. TST033560 - Accounts with Debit Balance will be retrieved"

	gen_start_test "17. TST033560 - Accounts with missing bank account information will be retrieved"
	begin
		puts "- opening a payment"
		NEWPAY.open_payment_by_description _PPLUS_10_DAYS_AGO
		gen_wait_until_object $newpay_selecttrans_Toduedate_dataffid_access

		puts "- Retrieving transaction according to the provided details and filters."

		NEWPAY.set_filter_options_to_equals $newpay_selecttrans_payment_method_options_button
		NEWPAY.set_vendor_name 'BMW Automobiles'

		NEWPAY.click_retrieve_trans_button

		expected_transactions=[['Account: BMW Automobiles'],
		['PIN','PIN4','TRN',current_date.to_s,gen_locale_format_number(40.00),gen_locale_format_number(800.00), gen_locale_format_number(0.00)],
		['','','','','',gen_locale_format_number(40.00),gen_locale_format_number(800.00), gen_locale_format_number(0.00)]]

		puts "- Checking that documents are retrieved and they are grouped and sorted by account name."
		expect(NEWPAY.assert_retrieved_rows? expected_transactions).to eq(true)
	end
	gen_end_test "17. TST033560 - Accounts with missing bank account information will be retrieved"
end
	after :all do
		login_user
		#Delete Test Data
		FFA.delete_new_data_and_wait
		 #Delete Test Data
		_delete_data = ["CODATID020357Data.destroyData();"]
		APEX.execute_commands _delete_data
		gen_end_test "TID020357"
		SF.logout
	end
end
