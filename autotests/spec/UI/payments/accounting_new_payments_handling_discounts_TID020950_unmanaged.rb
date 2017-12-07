
# TID : TID020950
# Product Area: Accounting - Payments Collections & Cash Entries
# Story: AC-7723
##
describe "Payment Plus- Handling Discounts", :type => :request do
	include_context "login"
	include_context "logout_after_each"
	before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait
		_create_data = ["CODATID020950Data.selectCompany();", "CODATID020950Data.createData();", "CODATID020950Data.createDataExt1();",
		"CODATID020950Data.createDataExt2();", "CODATID020950Data.createDataExt3();",
		"CODATID020950Data.createDataExt4();", "CODATID020950Data.createDataExt5();"]
		# Execute Commands
		APEX.execute_commands _create_data
	end

	it "TID020950 - New Payment as of v16 - Handling Discounts", :unmanaged => true  do
	_PPLUS_PAYMENT = 'PPLUS-PAYMENT';
	_PPLUS_PAYMENT50 = 'PPLUS-PAYMENT50'
	$locale = gen_get_current_user_locale
	_date = gen_get_current_date
	current_date = gen_locale_format_date _date, $locale
	current_date_10_days = FFA.add_days_to_date Time.now , "10"
	current_date_50_days = FFA.add_days_to_date Time.now , "50"

	gen_start_test "1. TST035428 - Discounts for an account with 1 discount - discount date is greater than TLI discount date"
	begin
		expected_transactions=[['Account: BMW Automobiles'],
		['PIN','PIN1','TRN',current_date_10_days.to_s,gen_locale_format_number(0.00),gen_locale_format_number(149.00), gen_locale_format_number(0.00)],
		['PIN','PIN2','TRN',current_date_10_days.to_s,gen_locale_format_number(0.00),gen_locale_format_number(300.00), gen_locale_format_number(0.00)],
		['','','','',gen_locale_format_number(0.00),gen_locale_format_number(449.00), gen_locale_format_number(0.00)]]
		expected_summary_values = [gen_locale_format_number(0.00),gen_locale_format_number(449.00),gen_locale_format_number(0.00)]

		puts "- Opening a payment"
		NEWPAY.open_payment_by_description _PPLUS_PAYMENT50
		gen_wait_until_object $newpay_selecttrans_Toduedate_dataffid_access

		puts "- Retrieving transaction according to the provided details and filters."

		NEWPAY.set_filter_options_to_contains $newpay_selecttrans_vendor_invoice_number_options_button
		gen_wait_until_object $newpay_selecttrans_vendor_invoice_number_options_button
		NEWPAY.set_vendor_invoice_number 'PIN'
		#### Temporary remove Electronic Payment Media 
		# remove check value from payment method
		NEWPAY.set_filter_options_to_equals $newpay_selecttrans_payment_method_options_button
		NEWPAY.set_vendor_name 'BMW Automobiles'
		NEWPAY.click_retrieve_trans_button

		expect(NEWPAY.assert_retrieved_rows? expected_transactions).to eq(true)
	end
	gen_end_test "TST035428"

	gen_start_test "2. TST035430 - Discounts for an account with 1 discount - discount date is less than TLI discount date"
	begin
		expected_transactions=[['Account: BMW Automobiles'],
		['PIN','PIN1','TRN',current_date_10_days.to_s,gen_locale_format_number(7.45),gen_locale_format_number(149.00), gen_locale_format_number(0.00)],
		['PIN','PIN2','TRN',current_date_10_days.to_s,gen_locale_format_number(15.00),gen_locale_format_number(300.00), gen_locale_format_number(0.00)],
		['','','','',gen_locale_format_number(22.45),gen_locale_format_number(449.00), gen_locale_format_number(0.00)]]
		expected_summary_values = [gen_locale_format_number(0.00),gen_locale_format_number(0.00),gen_locale_format_number(0.00)]

		puts "- Opening a payment"

		NEWPAY.open_payment_by_description _PPLUS_PAYMENT
		gen_wait_until_object $newpay_selecttrans_Toduedate_dataffid_access

		puts "- Retrieving transaction according to the provided details and filters."

		NEWPAY.set_filter_options_to_contains $newpay_selecttrans_vendor_invoice_number_options_button
		gen_wait_until_object $newpay_selecttrans_vendor_invoice_number_options_button
		NEWPAY.set_vendor_invoice_number 'PIN'

		# remove check value from payment method
		NEWPAY.set_filter_options_to_equals $newpay_selecttrans_payment_method_options_button
		NEWPAY.set_vendor_name 'BMW Automobiles'
		NEWPAY.click_retrieve_trans_button
		expect(NEWPAY.assert_retrieved_rows? expected_transactions).to eq(true)

		NEWPAY.select_lines ['PIN1','PIN2']
		NEWPAY.click_add_to_proposal_button
		payment_value_str = 'EUR ' + gen_locale_format_number(426.55)
		#B) Check following changes in the proposal panel:
		gen_compare(payment_value_str, NEWPAY.get_proposal_total_value, $newpay_assert_output_text)
		expect(NEWPAY.summaryTotals expected_summary_values).to eq(true)
		payment_discount_total_str = 'Discount Total: EUR ' + gen_locale_format_number(22.45)
		gen_compare(payment_discount_total_str, NEWPAY.get_proposal_discount_total_value, $newpay_assert_output_text)
	end
	gen_end_test "TST035430"

	gen_start_test "3. TST035433 - Discounts for an account with 4 discounts - discount date is less than all TLI discount dates"
	begin
		_date = gen_get_current_date
		_date_10 = _date + 10
		_days_to_finish_month = 30 - (Time.now).day
		_middle_next_month = _date + (_days_to_finish_month + 15)
		_middle_next_month_5 = _date + (_days_to_finish_month + 20)
		middle_next_month_locale = gen_locale_format_date _middle_next_month, $locale
		middle_next_month_5_locale = gen_locale_format_date _middle_next_month_5, $locale

		expected_transactions=[['Account: Audi'],
		['PIN','PIN3','TRN',current_date_10_days.to_s,gen_locale_format_number(7.45),gen_locale_format_number(149.00), gen_locale_format_number(0.00)],
		['PIN','PIN4','TRN',current_date_10_days.to_s,gen_locale_format_number(0.00),gen_locale_format_number(440.00), gen_locale_format_number(0.00)],
		['','','','',gen_locale_format_number(7.45),gen_locale_format_number(589.00), gen_locale_format_number(0.00)]]

		_create_data= ["CODATID020950Data.createDataExt6();"]
		APEX.execute_commands _create_data
		puts "- Opening a payment"

		NEWPAY.open_payment_by_description _PPLUS_PAYMENT
		gen_wait_until_object $newpay_selecttrans_Toduedate_dataffid_access

		puts "- Retrieving transaction according to the provided details and filters."

		NEWPAY.set_filter_options_to_contains $newpay_selecttrans_vendor_invoice_number_options_button
		gen_wait_until_object $newpay_selecttrans_vendor_invoice_number_options_button
		NEWPAY.set_vendor_invoice_number 'PIN'
		NEWPAY.set_vendor_name 'Audi'

		# remove check value from payment method
		NEWPAY.set_filter_options_to_equals $newpay_selecttrans_payment_method_options_button
		NEWPAY.click_retrieve_trans_button
		expect(NEWPAY.assert_retrieved_rows? expected_transactions).to eq(true)

		expected_transactions=[['Account: Audi'],
		['PIN','PIN3','TRN',current_date_10_days.to_s,gen_locale_format_number(7.45),gen_locale_format_number(149.00), gen_locale_format_number(0.00)],
		['PIN','PIN4','TRN',current_date_10_days.to_s,gen_locale_format_number(0.00),gen_locale_format_number(440.00), gen_locale_format_number(0.00)],
		['','','','',gen_locale_format_number(7.45),gen_locale_format_number(589.00), gen_locale_format_number(0.00)]]

		NEWPAY.click_back_button
		page.has_css?($newpay_detail_discount_date)
		NEWPAY.set_discount_date current_date_10_days
		NEWPAY.click_next_button
		page.has_css?($newpay_selecttrans_Toduedate_dataffid_access)

		NEWPAY.set_filter_options_to_contains $newpay_selecttrans_vendor_invoice_number_options_button
		gen_wait_until_object $newpay_selecttrans_vendor_invoice_number_options_button
		NEWPAY.set_vendor_invoice_number 'PIN'
		NEWPAY.set_vendor_name 'Audi'
		NEWPAY.click_retrieve_trans_button
		expect(NEWPAY.assert_retrieved_rows? expected_transactions).to eq(true)

		expected_transactions=[['Account: Audi'],
		['PIN','PIN3','TRN',current_date_10_days.to_s,gen_locale_format_number(2.98),gen_locale_format_number(149.00), gen_locale_format_number(0.00)],
		['PIN','PIN4','TRN',current_date_10_days.to_s,gen_locale_format_number(0.00),gen_locale_format_number(440.00), gen_locale_format_number(0.00)],
		['','','','',gen_locale_format_number(2.98),gen_locale_format_number(589.00), gen_locale_format_number(0.00)]]

		NEWPAY.click_back_button
		page.has_css?($newpay_detail_discount_date)
		NEWPAY.set_discount_date middle_next_month_locale
		NEWPAY.click_next_button
		page.has_css?($newpay_selecttrans_Toduedate_dataffid_access)

		NEWPAY.set_filter_options_to_contains $newpay_selecttrans_vendor_invoice_number_options_button
		gen_wait_until_object $newpay_selecttrans_vendor_invoice_number_options_button
		NEWPAY.set_vendor_invoice_number 'PIN'
		NEWPAY.set_vendor_name 'Audi'
		NEWPAY.click_retrieve_trans_button
		expect(NEWPAY.assert_retrieved_rows? expected_transactions).to eq(true)

		expected_transactions=[['Account: Audi'],
		['PIN','PIN3','TRN',current_date_10_days.to_s,gen_locale_format_number(1.49),gen_locale_format_number(149.00), gen_locale_format_number(0.00)],
		['PIN','PIN4','TRN',current_date_10_days.to_s,gen_locale_format_number(0.00),gen_locale_format_number(440.00), gen_locale_format_number(0.00)],
		['','','','',gen_locale_format_number(1.49),gen_locale_format_number(589.00), gen_locale_format_number(0.00)]]

		NEWPAY.click_back_button
		page.has_css?($newpay_detail_discount_date)
		NEWPAY.set_discount_date middle_next_month_5_locale
		NEWPAY.click_next_button
		page.has_css?($newpay_selecttrans_Toduedate_dataffid_access)

		NEWPAY.set_filter_options_to_contains $newpay_selecttrans_vendor_invoice_number_options_button
		gen_wait_until_object $newpay_selecttrans_vendor_invoice_number_options_button
		NEWPAY.set_vendor_invoice_number 'PIN'
		NEWPAY.set_vendor_name 'Audi'
		NEWPAY.click_retrieve_trans_button
		expect(NEWPAY.assert_retrieved_rows? expected_transactions).to eq(true)
	end
	gen_end_test "TST035433"

	gen_start_test "4. TST035436 - No discount apply in case a document is not being paid in full"
	begin

		expected_transactions=[['Account: Audi'],
		['PIN','PIN3','TRN',current_date_10_days.to_s,gen_locale_format_number(7.45),gen_locale_format_number(149.00), gen_locale_format_number(0.00)],
		['PIN','PIN4','TRN',current_date_10_days.to_s,gen_locale_format_number(0.00),gen_locale_format_number(440.00), gen_locale_format_number(0.00)],
		['','','','',gen_locale_format_number(7.45),gen_locale_format_number(589.00), gen_locale_format_number(0.00)]]
		expected_summary_values = [gen_locale_format_number(7.45),gen_locale_format_number(589.00),gen_locale_format_number(0.00)]

		puts "- Opening a payment"

		NEWPAY.open_payment_by_description _PPLUS_PAYMENT
		gen_wait_until_object $newpay_selecttrans_Toduedate_dataffid_access

		NEWPAY.click_back_button
		page.has_css?($newpay_detail_discount_date)
		NEWPAY.set_discount_date current_date_10_days
		NEWPAY.click_next_button
		page.has_css?($newpay_selecttrans_Toduedate_dataffid_access)

		puts "- Retrieving transaction according to the provided details and filters."

		NEWPAY.set_filter_options_to_contains $newpay_selecttrans_vendor_invoice_number_options_button
		gen_wait_until_object $newpay_selecttrans_vendor_invoice_number_options_button
		NEWPAY.set_vendor_invoice_number 'PIN'
		NEWPAY.set_vendor_name 'Audi'

		# remove check value from payment method
		NEWPAY.set_filter_options_to_equals $newpay_selecttrans_payment_method_options_button
		NEWPAY.click_retrieve_trans_button
		expect(NEWPAY.assert_retrieved_rows? expected_transactions).to eq(true)

		NEWPAY.select_lines ['PIN4']
		NEWPAY.click_add_to_proposal_button
		page.has_css?($newpay_proposal_discount_total)
	end
	gen_end_test "TST035436"
	end

	after :all do
		login_user
		# Delete Test Data
		_delete_data = ["CODATID020950Data.destroyData();"]
		APEX.execute_commands _delete_data
		#Delete Test Data
		FFA.delete_new_data_and_wait
		gen_end_test "TID020950"
		SF.logout
	end
end