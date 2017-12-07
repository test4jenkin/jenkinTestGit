#--------------------------------------------------------------------#
# TID : TID021803
# Product Area: Accounting - Payments Collections & Cash Entries
# Story: AC-8105
#--------------------------------------------------------------------#
describe "New Payment as of V16 - Print Checks", :type => :request do
	include_context "login"
	include_context "logout_after_each"
	
	def setup_locale_and_dates
		_date = gen_get_current_date
		_date_10 = _date + 10
		$locale = gen_get_current_user_locale
		current_date =  gen_locale_format_date _date, $locale
		current_date_10 = gen_locale_format_date _date_10, $locale

		return current_date, current_date_10
	end

	def get_expected_values_extended (current_date, current_date_10)
		return [
			['Audi', '000002', gen_locale_format_number(0.00), gen_locale_format_number(300.00)],
			['PIN', 'PIN2', 'TRN', current_date_10.to_s, gen_locale_format_number(0.00), gen_locale_format_number(300.00)],
			['BMW Automobiles', '000003', gen_locale_format_number(7.45), gen_locale_format_number(141.55)],
			['PIN', 'PIN1', 'TRN', current_date_10.to_s, gen_locale_format_number(7.45), gen_locale_format_number(141.55)],
			['Chrysler Motors LLC', '000001', gen_locale_format_number(14.90), gen_locale_format_number(134.10)],
			['PIN', 'PIN3', 'TRN', current_date_10.to_s, gen_locale_format_number(14.90), gen_locale_format_number(134.10)],
			['Mercedes-Benz Inc', '000004', gen_locale_format_number(0.00), gen_locale_format_number(149.00)],
			['PIN', 'PIN4', 'TRN', current_date.to_s, gen_locale_format_number(0.00), gen_locale_format_number(149.00)]
		]
	end

	before :all do
		gen_start_test  "TID021803"
		# Hold Base Data
		FFA.hold_base_data_and_wait
		_create_data = ["CODATID021803Data.selectCompany();", "CODATID021803Data.createData();", "CODATID021803Data.createDataExt1();",
						"CODATID021803Data.createDataExt2();", "CODATID021803Data.createDataExt3();","CODATID021803Data.createDataExt4();",
						"CODATID021803Data.createDataExt5();", "CODATID021803Data.createDataExt6();","CODATID021803Data.createDataExt7();",
						"CODATID021803Data.createDataExt8();"]
		# Execute Commands
		APEX.execute_commands _create_data
	end

	it "New Payment as of V16 - Print Checks", :unmanaged => true  do
		gen_start_test "1. ****** - Positive case - Discard Errors with some successful accounts"
		begin

			current_date, current_date_10 = setup_locale_and_dates()

			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_usa] ,true
			puts "- Opening PPLUS-MEDIAPREPARED."
			_payment_name = NEWPAY.open_payment_by_description 'PPLUS-MEDIAPREPARED'

			gen_wait_until_object $newpay_tab_navigation
			puts "Verify that Status at this stage is READY TO POST."
			gen_compare($newpay_status_ready_to_post, NEWPAY.get_proposal_status_value, $newpay_assert_output_text)

			puts "Launch Post and Match"
			NEWPAY.click_next_button

			gen_wait_until_object_disappear $page_loadmask_message
			gen_wait_until_object_disappear $newpay_progress_window
			gen_wait_until_object_disappear $page_loadmask_message

			puts " Verify that Status at this stage is ERROR."
			gen_compare($newpay_status_error, NEWPAY.get_proposal_status_value, $newpay_assert_output_text)

			puts " Verify Payment Media Summary Lines."
			all_tabs = gen_open_link_in_new_tab "All Tabs"
			within_window all_tabs do
				expected_payment_media_summary_lines =['Name~||~Chrysler Motors LLC,PaymentValue__c~||~-134.1,PaymentReference__c~||~000001', 'Name~||~BMW Automobiles,PaymentValue__c~||~-141.55,PaymentReference__c~||~000003', 'Name~||~Audi,PaymentValue__c~||~-300.0,PaymentReference__c~||~000002', 'Name~||~Mercedes-Benz Inc,PaymentValue__c~||~-49.0,PaymentReference__c~||~000004']
				_field_values = NEWPAY.get_line_from_paymentmediasummary _payment_name
				expected_payment_media_summary_lines.eql? _field_values
			end

			#Verify the lines
			expected_values_extended = get_expected_values_extended(current_date, current_date_10)
			expect(NEWPAY.assert_summary_lines_extended expected_values_extended).to eq(true)

			puts "Launch Discard Errors"
			NEWPAY.discard_errors

			gen_wait_until_object_disappear $page_loadmask_message
			gen_wait_until_object_disappear $newpay_progress_window
			gen_wait_until_object_disappear $page_loadmask_message

			puts " Verify that Status at this stage is MATCHED."
			gen_compare($newpay_status_matched, NEWPAY.get_proposal_status_value, $newpay_assert_output_text)

			#Verify discard tooltip in rows:
			expected_tooltip = "Discarded"
			discarded_tooltip = NEWPAY.get_discarded_tooltip 3
			gen_compare(expected_tooltip, discarded_tooltip, $newpay_assert_output_text)
			discarded_tooltip = NEWPAY.get_discarded_tooltip 4
			gen_compare(expected_tooltip, discarded_tooltip, $newpay_assert_output_text)

		end
		gen_end_test "****** - Positive case - Discard Errors with some successful accounts."
		
		gen_start_test "2. ****** - Positive case - Discard Errors with all accounts with error"
		begin

			all_tabs = gen_open_link_in_new_tab "All Tabs"
			within_window all_tabs do
				_create_data= ["CODATID021803Data.createDataExt9();"]
				puts "Post&Match PPLUS-ERROR"
				APEX.execute_commands _create_data
			end

			current_date, current_date_10 = setup_locale_and_dates()

			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_usa] ,true

			puts "- Opening PPLUS-ERROR."
			_payment_name = NEWPAY.open_payment_by_description 'PPLUS-ERROR'

			gen_wait_until_object $newpay_tab_navigation
			puts "Verify that Status at this stage is ERROR."
			gen_compare($newpay_status_error, NEWPAY.get_proposal_status_value, $newpay_assert_output_text)

			gen_wait_until_object_disappear $page_loadmask_message
			gen_wait_until_object_disappear $newpay_progress_window
			gen_wait_until_object_disappear $page_loadmask_message

			puts " Verify that Status at this stage is ERROR."
			gen_compare($newpay_status_error, NEWPAY.get_proposal_status_value, $newpay_assert_output_text)

			puts "Launch Discard Errors"
			NEWPAY.discard_errors

			gen_wait_until_object_disappear $page_loadmask_message
			gen_wait_until_object_disappear $newpay_progress_window
			gen_wait_until_object_disappear $page_loadmask_message

			puts " Verify that Status at this stage is DISCARDED."
			gen_compare($newpay_status_discarded, NEWPAY.get_proposal_status_value, $newpay_assert_output_text)

			#Verify discard tooltip in rows:
			expected_tooltip = "Discarded"
			discarded_tooltip = NEWPAY.get_discarded_tooltip 1
			gen_compare(expected_tooltip, discarded_tooltip, $newpay_assert_output_text)

		end
		gen_end_test "****** - Positive case - Discard Errors with all accounts with error."

	end

	after :all do
		login_user

		# Restore to initial GLA
		_restore_data = ["CODATID021803Data.createDataExt10();"]
		APEX.execute_commands _restore_data

		# Delete Test Data
		_delete_data = ["CODATID021803Data.destroyData();"]
		APEX.execute_commands _delete_data
		FFA.delete_new_data_and_wait
		gen_end_test "TID021803"
		SF.logout
	end
end