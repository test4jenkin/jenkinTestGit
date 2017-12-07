#--------------------------------------------------------------------#
# TID : TID021113
# Product Area: Accounting - Payments Collections & Cash Entries
# Story: AC-6831 / AC-6851
#--------------------------------------------------------------------#
describe "New Payment as of V16 - Print Checks", :type => :request do
	include_context "login"
	##include_context "logout_after_each"
	before :all do
		gen_start_test  "TID021113"
		#Hold Base Data
		FFA.hold_base_data_and_wait
		_create_data = [
			"CODATID021113Data.selectCompany();", "CODATID021113Data.createData();", "CODATID021113Data.createDataExt1();",
			"CODATID021113Data.createDataExt2();", "CODATID021113Data.createDataExt3();", "CODATID021113Data.createDataExt4();",
			"CODATID021113Data.createDataExt5();", "CODATID021113Data.createDataExt8();", "CODATID021113Data.createDataExt9();",
			"CODATID021113Data.createDataExt10();", "CODATID021113Data.createDataExt11();", "CODATID021113Data.createDataExt12();", "CODATID021113Data.createDataExt13();",
			"CODATID021113Data.createDataExt14();", "CODATID021113Data.createDataExt15();", "CODATID021113Data.createDataExt16();", "CODATID021113Data.createDataExt17();",
			"CODATID021113Data.createDataExt18();", "CODATID021113Data.createDataExt19();", "CODATID021113Data.createDataExt20();", "CODATID021113Data.createDataExt21();",
			"CODATID021113Data.createDataExt22();", "CODATID021113Data.createDataExt23();", "CODATID021113Data.createDataExt24();",
			"CODATID021113Data.createDataExt25();"
		]
		# Execute Commands
		APEX.execute_commands _create_data
	end

	it "New Payment as of V16 - Print Checks", :unmanaged => true  do
		_date = gen_get_current_date
		$locale = gen_get_current_user_locale
		current_date = gen_locale_format_date _date, $locale
		current_date_10 = FFA.add_days_to_date Time.now , "10"
		current_date_20 =  FFA.add_days_to_date Time.now , "20"
		checkrange_enoughchecks = 'CHR001'
		checkrange_onecheck = 'CHR002'

		gen_start_test "1. TST036150 - Positive case - Generating media files including accounts with 0 balance"
		begin
			payment_name = NEWPAY.open_payment_by_description 'PPLUS-PROPOSED_1'
			NEWPAY.wait_for_status $newpay_status_proposed

			puts " Go to Prepare Media tab."
			NEWPAY.click_next_button
			NEWPAY.no_show_again_and_prepare_checks
			gen_wait_until_object_disappear $page_loadmask_message
			gen_wait_until_object $newpay_check_numbering_detail_text
			#Check that Proposal Status changes to Media Prepared
			puts " Verify that Status at this stage is MEDIA PREPARED."
			NEWPAY.wait_for_status $newpay_status_media_prepared

			#Check that Back Button is disabled.
			gen_compare_object_visible $newpay_detail_button_back, false, "Back button should be disabled after media tables are generated"
		end
		gen_end_test "1. TST036150 - Positive case - including zero account balance"

		gen_start_test "2. TST036462 - Post&Match - Positive case, including zero account balance"
		begin
			checkrange_name = '?'
			all_tabs = gen_open_link_in_new_tab "All Tabs"
			within_window all_tabs do
				checkrange_name = NEWPAY.get_checkrange_name checkrange_enoughchecks
				checkrange_name = checkrange_name[0].match(/CHR\d{5}/).to_s
			end
			payment_name = NEWPAY.open_payment_by_description 'PPLUS-PROPOSED_1'
			gen_wait_until_object $newpay_check_numbering_detail_text
			gen_assert_enabled $newpay_detail_button_next
			gen_compare($newpay_status_media_prepared, NEWPAY.get_proposal_status_value, $newpay_assert_output_text)
			header_text1 = FFA.fetch_label 'PayPlusPrintedDescMain'
			header_text2 = FFA.fetch_label 'PayPlusPrintedDescBody'
			header_text2 =  header_text2.sub("{0}", checkrange_name)
			header_text = header_text1 + " " + header_text2
			expected_check_numbers_proposal=[
				['Audi',gen_locale_format_number(151.00),'000001'],
				['Chrysler Motors LLC',gen_locale_format_number(134.10),'000002'],
				['BMW Automobiles',gen_locale_format_number(0.00),'']
			]
			expect(NEWPAY.assert_retrieved_check_numbers? expected_check_numbers_proposal).to eq(true)
			NEWPAY.click_next_button
			gen_wait_until_object_disappear $newpay_progress_window

			puts " Verify that Status at this stage is MATCHED."
			gen_compare($newpay_status_matched, NEWPAY.get_proposal_status_value, $newpay_assert_output_text)

			expected_values_extended=[
				['Audi', '000001', gen_locale_format_number(0.00), gen_locale_format_number(151.00)],
				['PIN', 'PIN2', 'TRN', current_date_10.to_s, gen_locale_format_number(0.0), gen_locale_format_number(300)],
				['PCR', 'PCR2', 'TRN', current_date_20.to_s, gen_locale_format_number(0.0), gen_locale_format_number(-149.00)],
				['Chrysler Motors LLC', '000002', gen_locale_format_number(14.90), gen_locale_format_number(134.10)],
				['PIN', 'PIN3', 'TRN', current_date_10.to_s, gen_locale_format_number(14.90), gen_locale_format_number(134.10)],
				['BMW Automobiles', '', gen_locale_format_number(0.00), gen_locale_format_number(0.00)],
				['PIN', 'PIN1', 'TRN', current_date_10.to_s, gen_locale_format_number(7.45), gen_locale_format_number(141.55)],
				['PCR', 'PCR1', 'TRN', current_date_20.to_s, gen_locale_format_number(-7.45), gen_locale_format_number(-141.55)]
			]
			expect(NEWPAY.assert_summary_lines_extended expected_values_extended).to eq(true)
		end
		gen_end_test "2. TST036462 - Post&Match - Positive case, including zero account balance"

		gen_start_test "3. TST036151 - Validation - All of the transactions you add for a single account must have the same GLA as the Accounts Payable Control GLA on that account"
		begin
			#Change the GLA to Chrysler account.
			NEWPAY.execute_commands ['CODATID021113Data.changeChryslerGLA();']

			payment_name = NEWPAY.open_payment_by_description 'PPLUS-PROPOSED_2'
 			gen_wait_until_object $newpay_review_edit_proposal_slider_dataffid

			puts " Go to Print Checks tab."
			NEWPAY.click_next_button
			error_message = FFA.fetch_label 'PayPlusTLIGlaMustBeEqualToAccountGla'
			NEWPAY.get_message_box_text.include? error_message
			NEWPAY.click_message_box
		end
		gen_end_test "3. TST036151 - Validation - All of the transactions you add for a single account must have the same GLA as the Accounts Payable Control GLA on that account"

		gen_start_test "4. TST036463 - Post&Match - Validation - There isn't an active check range"
		begin
			NEWPAY.execute_commands ['CODATID021113Data.restoreChryslerGLA();']
			NEWPAY.execute_commands ["CODATID021113Data.deactivateCheckRange('#{checkrange_enoughchecks}');"];

			payment_name = NEWPAY.open_payment_by_description 'PPLUS-PROPOSED_2'
			NEWPAY.click_next_button

			error_message = FFA.fetch_label 'PayPlusChecksCheckRangeNotActive'
			NEWPAY.get_message_box_text.include? error_message
			NEWPAY.click_message_box
		end
		gen_end_test "4. TST036463 - Post&Match - Validation - There isn't an active check range"

		gen_start_test "5. TST036464 - Post&Match - Validation - There isn't enough available checks"
		begin
			puts "Set check range CHR002 activated"
			NEWPAY.execute_commands ["CODATID021113Data.activateCheckRange('#{checkrange_onecheck}');"];
			NEWPAY.click_next_button
			error_message = FFA.fetch_label 'PayPlusCheckRangeTooShort'
			error_message = error_message.sub("{0}", checkrange_enoughchecks)
			NEWPAY.get_message_box_text.include? error_message
			NEWPAY.click_message_box
		end
		gen_end_test "5. TST036464 - Post&Match - Validation - There isn't enough available checks"

		gen_start_test "6. TST036486 - Renumber down - a specific check was spoiled"
		begin
			puts "Set check range CHR002 deactivated and set check range CHR001 activated"
			NEWPAY.execute_commands ["CODATID021113Data.deactivateCheckRange('#{checkrange_onecheck}');"];
			NEWPAY.execute_commands ["CODATID021113Data.activateCheckRange('#{checkrange_enoughchecks}');"];

			payment_name = NEWPAY.open_payment_by_description 'PPLUS-PROPOSED_3'

			puts " Go to Review tab ."
			NEWPAY.click_next_button
			gen_wait_until_object $newpay_check_numbering_detail_text

			NEWPAY.overwrite_check_number $bd_account_audi, '5'
			# Check A)
			puts "Checks check number grid"
			gen_assert_enabled $newpay_detail_button_next
			NEWPAY.assert_present_void_checks [3]
			expected_check_numbers_proposal=[
				['Audi',gen_locale_format_number(151.00),'000005'],
				['Chrysler Motors LLC',gen_locale_format_number(134.10),'000004'],
				['BMW Automobiles',gen_locale_format_number(0.00),'']
			]
			expect(NEWPAY.assert_retrieved_check_numbers? expected_check_numbers_proposal).to eq(true)
			puts "Renumber Down"
			NEWPAY.click_renumber_down $bd_account_audi
			NEWPAY.assert_present_void_checks [3, 4]
			expected_check_numbers_proposal=[
				['Audi',gen_locale_format_number(151.00),'000005'],
				['Chrysler Motors LLC',gen_locale_format_number(134.10),'000006'],
				['BMW Automobiles',gen_locale_format_number(0.00),'']
			]
			expect(NEWPAY.assert_retrieved_check_numbers? expected_check_numbers_proposal).to eq(true)
			NEWPAY.click_next_button
			gen_wait_until_object_disappear $page_loadmask_message
			gen_wait_until_object_disappear $newpay_progress_window
			gen_wait_until_object_disappear $page_loadmask_message

			puts " Verify that Status at this stage is MATCHED."
			gen_compare($newpay_status_matched, NEWPAY.get_proposal_status_value, $newpay_assert_output_text)
		end
		gen_end_test "6. TST036486 - Renumber down - a specific check was spoiled"

		gen_start_test "7. TST036511 - Renumber down - all checks after a specific one were spoiled"
		begin
			payment_name = NEWPAY.open_payment_by_description 'PPLUS-PROPOSED_4'
			puts " Go to Prepare Media tab."
			NEWPAY.click_next_button
			gen_wait_until_object $newpay_check_numbering_detail_text
			NEWPAY.overwrite_check_number_from_row_index 1, '9'
			sleep 2
			NEWPAY.click_renumber_down $bd_account_audi
			## Check A)
			puts "Checks check number grid"
			gen_assert_enabled $newpay_detail_button_next
			NEWPAY.assert_present_void_checks [6,7,8]
			expected_check_numbers_proposal=[
				['Audi',gen_locale_format_number(151.00),'000009'],
				['Chrysler Motors LLC',gen_locale_format_number(134.10),'000010'],
				['Mercedes-Benz Inc',gen_locale_format_number(141.55),'000011'],
				['BMW Automobiles',gen_locale_format_number(0.00),'']
			]
		end
		gen_end_test "7. TST036511 - Renumber down - all checks after a specific one were spoiled"

		gen_start_test "8. TST036512 - Renumber down - The first check shown in the list was used for a manual payment"
		begin
		payment_name = NEWPAY.open_payment_by_description 'PPLUS-PROPOSED_5'
		puts " Go to Prepare Media tab."
		NEWPAY.click_next_button
		gen_wait_until_object $newpay_check_numbering_detail_text
		NEWPAY.overwrite_check_number_from_row_index 1, 15
		NEWPAY.click_renumber_down_from_row_index 1
		## Check A)
		puts "Checks check number grid"
		gen_assert_enabled $newpay_detail_button_next
		NEWPAY.assert_present_void_checks [12,13,14]
		NEWPAY.click_manual_check 12
		## Check B)
		gen_assert_enabled $newpay_detail_button_next
		expected_check_numbers_proposal=[
			['Audi',gen_locale_format_number(151.00),'000015'],
			['Chrysler Motors LLC',gen_locale_format_number(134.10),'000016'],
			['Mercedes-Benz Inc',gen_locale_format_number(149.00),'000017'],
			['BMW Automobiles',gen_locale_format_number(0.00),'']
		]
		payment_name = NEWPAY.get_payment_name
		NEWPAY.collapse_void_checks
		expect(NEWPAY.assert_retrieved_check_numbers? expected_check_numbers_proposal).to eq(true)
	end
	gen_end_test "8. TST036512 - Renumber down - The first check shown in the list was used for a manual payment"

	end
	after :all do
		login_user
		NEWPAY.execute_commands ['CODATID021113Data.restoreChryslerGLA();']
		# Delete Test Data
		_delete_data = ["CODATID021113Data.destroyData();"]
		APEX.execute_commands _delete_data
		FFA.delete_new_data_and_wait
		gen_end_test "TID021113"
		SF.logout
	end
end