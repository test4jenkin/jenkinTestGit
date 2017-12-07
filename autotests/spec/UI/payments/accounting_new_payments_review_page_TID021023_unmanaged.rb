##
# TID : TID021023
# Product Area: Accounting - Payments Collections & Cash Entries
# Story: AC-6844
##
describe "Payment plus- Review a proposal", :type => :request do
include_context "login"
include_context "logout_after_each"
	before :all do
		gen_start_test  "TID021023"
		#Hold Base Data
		FFA.hold_base_data_and_wait
		_create_data = ["CODATID021023Data.selectCompany();", "CODATID021023Data.createData();", "CODATID021023Data.createDataExt1();"]
		_create_data+= ["CODATID021023Data.createDataExt2();", "CODATID021023Data.createDataExt3();", "CODATID021023Data.createDataExt4();"]
		# Execute Commands
		APEX.execute_commands _create_data
	end

	it "New Payment as of v16 - Review a proposal", :unmanaged => true  do
		_PPLUS_TID021023 = 'PPLUS-TID021023'
		$locale = gen_get_current_user_locale
		_date = gen_get_current_date
		current_date = gen_locale_format_date _date, $locale

		gen_start_test "1. TST035753 - Editing a Payment Proposal"
		begin
			text_No_transactions = 'No transactions selected'

			puts "- Opening a payment"
			NEWPAY.open_payment_by_description _PPLUS_TID021023
 			gen_wait_until_object $newpay_review_edit_proposal_slider_dataffid

			# check A)
			NEWPAY.expand_account_docs
			expect(page).not_to have_selector(:xpath, $newpay_review_edit_proposal_checked_on)
			gen_compare_object_visible "//div[contains(@class, 'ff-grid-row-checker')]", false, "Expected checkboxes are not visible"
			gen_compare_object_visible $newpay_review_bottom_panel_remove_from_proposal, false, "Expected bottom panel (Remove from proposal) is not visible"
			gen_assert_enabled $newpay_detail_button_next

			NEWPAY.click_edit_proposal

			# check B)
			expect(page).to have_selector(:xpath, $newpay_review_edit_proposal_checked_on)
			gen_compare_object_visible "//div[contains(@class, 'ff-grid-row-checker')]", true, "Expected checkboxes are displayed"
			gen_compare_object_visible $newpay_review_bottom_panel_remove_from_proposal, true, "Expected bottom panel (Remove from proposal) is displayed"
			gen_assert_disabled $newpay_review_remove_from_proposal_button
			expect(NEWPAY.assert_text_beside_addtoproposal_no_trans_selectd text_No_transactions).to eq(true)
			gen_assert_enabled $newpay_detail_button_next

		end
		gen_end_test "1. TST035753 - Editing a Payment Proposal"

		gen_start_test "2. TST035756 - Positive case - "
		begin
			text_transactions_selected = '3 transactions selected, from 1 vendors (Total Value ' + gen_locale_format_number(96.90) + ')'

			puts "- Opening a payment"
			NEWPAY.open_payment_by_description _PPLUS_TID021023
 			gen_wait_until_object $newpay_review_edit_proposal_slider_dataffid

			expected_transactions=[
			['Account: Audi'],
			['PIN','PIN3','TRN',current_date.to_s,gen_locale_format_number(0.00),gen_locale_format_number(149.00),gen_locale_format_number(149.00)],
			['PCR','PCR2','TRN',current_date.to_s,gen_locale_format_number(0.00),gen_locale_format_number(-149.00), gen_locale_format_number(-149.00)],
			['','','','','',gen_locale_format_number(0.00),gen_locale_format_number(0.00), gen_locale_format_number(0.00)],
			['Account: BMW Automobiles'],
			['PIN','PIN1','TRN',current_date.to_s,gen_locale_format_number(7.45),gen_locale_format_number(149.00), gen_locale_format_number(141.55)],
			['PIN','PIN2','TRN',current_date.to_s,gen_locale_format_number(7.45),gen_locale_format_number(149.00), gen_locale_format_number(141.55)],
			['PCR','PCR1','TRN',current_date.to_s,gen_locale_format_number(-20.00),gen_locale_format_number(-400.00), gen_locale_format_number(-380.00)],
			['','','','','',gen_locale_format_number(-5.10),gen_locale_format_number(-102.00), gen_locale_format_number(-96.90)],
			['Account: Chrysler Motors LLC'],
			['PIN','PIN4','TRN',current_date.to_s,gen_locale_format_number(14.90),gen_locale_format_number(149.00), gen_locale_format_number(134.10)],
			['','','','','',gen_locale_format_number(14.90),gen_locale_format_number(149.00), gen_locale_format_number(134.10)]]
			expected_summary_values = [gen_locale_format_number(9.80),gen_locale_format_number(47.00),gen_locale_format_number(0.00)]

			expect(NEWPAY.assert_rows_review? expected_transactions).to eq(true)

			NEWPAY.click_edit_proposal
			NEWPAY.select_lines_review_grid ['PIN1', 'PIN2', 'PCR1']

			# check A)
			gen_assert_enabled $newpay_review_remove_from_proposal_button
			gen_assert_enabled $newpay_detail_button_next

			expected_transactions=[
			['Account: Audi'],
			['PIN','PIN3','TRN',current_date.to_s,gen_locale_format_number(0.00),gen_locale_format_number(149.00),gen_locale_format_number(149.00)],
			['PCR','PCR2','TRN',current_date.to_s,gen_locale_format_number(0.00),gen_locale_format_number(-149.00), gen_locale_format_number(-149.00)],
			['','','','','',gen_locale_format_number(0.00),gen_locale_format_number(0.00), gen_locale_format_number(0.00)],
			['Account: BMW Automobiles'],
			['PIN','PIN1','TRN',current_date.to_s,gen_locale_format_number(7.45),gen_locale_format_number(149.00), gen_locale_format_number(0.00)],
			['PIN','PIN2','TRN',current_date.to_s,gen_locale_format_number(7.45),gen_locale_format_number(149.00), gen_locale_format_number(0.00)],
			['PCR','PCR1','TRN',current_date.to_s,gen_locale_format_number(-20.00),gen_locale_format_number(-400.00), gen_locale_format_number(0.00)],
			['','','','','',gen_locale_format_number(-5.10),gen_locale_format_number(-102.00), gen_locale_format_number(0.00)],
			['Account: Chrysler Motors LLC'],
			['PIN','PIN4','TRN',current_date.to_s,gen_locale_format_number(14.90),gen_locale_format_number(149.00), gen_locale_format_number(134.10)],
			['','','','','',gen_locale_format_number(14.90),gen_locale_format_number(149.00), gen_locale_format_number(134.10)]]
			expected_summary_values = [gen_locale_format_number(9.80),gen_locale_format_number(47.00),gen_locale_format_number(0.00)]

			expect(NEWPAY.assert_rows_review? expected_transactions).to eq(true)
			NEWPAY.click_remove_from_proposal_button

			# check B)
			expected_transactions=[
			['Account: Audi'],
			['PIN','PIN3','TRN',current_date.to_s,gen_locale_format_number(0.00),gen_locale_format_number(149.00),gen_locale_format_number(149.00)],
			['PCR','PCR2','TRN',current_date.to_s,gen_locale_format_number(0.00),gen_locale_format_number(-149.00), gen_locale_format_number(-149.00)],
			['','','','','',gen_locale_format_number(0.00),gen_locale_format_number(0.00), gen_locale_format_number(0.00)],
			['Account: Chrysler Motors LLC'],
			['PIN','PIN4','TRN',current_date.to_s,gen_locale_format_number(14.90),gen_locale_format_number(149.00), gen_locale_format_number(134.10)],
			['','','','','',gen_locale_format_number(14.90),gen_locale_format_number(149.00), gen_locale_format_number(134.10)]]
			expected_summary_values = [gen_locale_format_number(9.80),gen_locale_format_number(47.00),gen_locale_format_number(0.00)]

			expect(NEWPAY.assert_rows_review? expected_transactions).to eq(true)
			payment_value_str = 'EUR ' + gen_locale_format_number(134.10)
			gen_compare(payment_value_str, NEWPAY.get_proposal_total_value, $newpay_assert_output_text)
			gen_compare('3', NEWPAY.get_proposal_document_proposed_value, $newpay_assert_output_text)
			gen_compare('2', NEWPAY.get_proposal_vendors_proposed_value, $newpay_assert_output_text)
			gen_compare('PROPOSED', NEWPAY.get_proposal_status_value, $newpay_assert_output_text)
			expect(page).to have_selector(:xpath, $newpay_review_edit_proposal_checked_on)
			gen_assert_enabled $newpay_detail_button_next
		end
		gen_end_test "2. TST035756 - Positive case"

		gen_start_test "3. TST035759 - Remove all documents"
		begin
			message_grid_empty = FFA.fetch_label 'PaySelectTransGridNoResultsFound'

			_add_all_docs_to_proposal= ["CODATID021023Data.createDataext4();"]
			APEX.execute_commands _add_all_docs_to_proposal

			puts "- Opening a payment"
			NEWPAY.open_payment_by_description _PPLUS_TID021023
 			gen_wait_until_object $newpay_review_edit_proposal_slider_dataffid

			payment_name = NEWPAY.get_payment_name
			NEWPAY.click_edit_proposal
			NEWPAY.select_lines_review_grid ['PIN1', 'PIN2', 'PIN3', 'PIN4', 'PCR1', 'PCR2']
			NEWPAY.click_remove_from_proposal_button

			# check A)
			expect(NEWPAY.get_message_grid_empty).to eq(message_grid_empty)

			payment_value_str = 'EUR ' + gen_locale_format_number(0.00)
			gen_compare(payment_value_str, NEWPAY.get_proposal_total_value, $newpay_assert_output_text)
			gen_compare('0', NEWPAY.get_proposal_document_proposed_value, $newpay_assert_output_text)
			gen_compare('0', NEWPAY.get_proposal_vendors_proposed_value, $newpay_assert_output_text)
			gen_compare('NEW', NEWPAY.get_proposal_status_value, $newpay_assert_output_text)
			gen_assert_disabled $newpay_detail_button_next

			all_tabs = gen_open_link_in_new_tab "All Tabs"
			within_window all_tabs do
				expected_payment_accounts =[]
				puts "Verify that payment account line items have been created successfully"
				_payment_account_name = NEWPAY.get_account_from_paymentaccountlineitem payment_name
				puts "Account Name = " + _payment_account_name.to_s
				_payment_account_name.eql? expected_payment_accounts

				expected_payment_lines =[]
				puts "Verify that payment line items have been created successfully"
				_field_values = NEWPAY.get_line_from_paymentlineitem payment_name
				puts "Account Name = " + _field_values.to_s
				expected_payment_lines.eql? _field_values

				expected_matchingstatus_tlis =['MatchingStatus__c~||~Available', 'MatchingStatus__c~||~Available', 'MatchingStatus__c~||~Available', 'MatchingStatus__c~||~Available', 'MatchingStatus__c~||~Available', 'MatchingStatus__c~||~Available']
				puts "Verify that transaction line items matching status have updated to Proposed"
				_field_values = NEWPAY.get_matchingStatus_from_transaction_reference 'PAY'
				puts "Matching Status = " + _field_values.to_s
				expect(_field_values).to eq(expected_matchingstatus_tlis)
			end
		end
		gen_end_test "3. TST035759 - Remove all documents"

		gen_start_test "4. TST035760 - Validation - click Next when some documents are selected and not removed / 7. TST035763 - Validation - Back to Payments (Home)"
		begin
			_add_all_docs_to_proposal= ["CODATID021023Data.createDataext4();"]
			APEX.execute_commands _add_all_docs_to_proposal

			puts "- Opening a payment"
			NEWPAY.open_payment_by_description _PPLUS_TID021023
 			gen_wait_until_object $newpay_review_edit_proposal_slider_dataffid

			NEWPAY.click_edit_proposal
			NEWPAY.select_lines_review_grid ['PIN1']
			NEWPAY.click_next_button

			# check A)
			error_message1 = FFA.fetch_label 'PayPlusReviewLeaveWhileEditingError'
			NEWPAY.get_message_box_text.include? error_message1

			NEWPAY.click_message_box_go_back
			# check B)
			expect(NEWPAY.is_checked_line 'PIN1').to eq(true)
			gen_assert_enabled $newpay_detail_button_next
			gen_assert_enabled $newpay_detail_button_back

			puts "- Validation - Back to Payments (Home)"

			NEWPAY.click_back_to_payments_home
		end
		gen_end_test "4. TST035760 - Validation - click Next when some documents are selected and not removed / 7. TST035763 - Validation - Back to Payments (Home)"
	end
	after :all do
		login_user
		#Delete Test Data
		FFA.delete_new_data_and_wait
		# Delete Test Data
		_delete_data = ["CODATID021023Data.destroyData();"]
		APEX.execute_commands _delete_data
		gen_end_test "TID021023"
		SF.logout
	end
end