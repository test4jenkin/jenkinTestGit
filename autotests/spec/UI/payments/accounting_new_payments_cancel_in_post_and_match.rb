#--------------------------------------------------------------------#
# TID : 
# Product Area: Accounting - Payments Collections & Cash Entries
# Story: AC-8079
#--------------------------------------------------------------------#
describe "New Payment as of V16 - Cancel in Post and Match", :type => :request do
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

	before :all do
		gen_start_test  "TID021803"
		# Hold Base Data
		FFA.hold_base_data_and_wait
		_create_data = ["CODATID021803Data.selectCompany();", "CODATID021803Data.createData();", "CODATID021803Data.createDataExt1();",
						"CODATID021803Data.createDataExt2();", "CODATID021803Data.createDataExt3();","CODATID021803Data.createDataExt4();",
						"CODATID021803Data.createDataExt5();", "CODATID021803Data.createDataExt6();", "CODATID021803Data.createDataExt7();",
						"CODATID021803Data.createDataExt11();"]
		# Execute Commands
		APEX.execute_commands _create_data
	end

	it "New Payment as of V16 - Review", :unmanaged => true  do
		gen_start_test "1. Positive case - Part Cancel"
		begin
			current_date, current_date_10 = setup_locale_and_dates()

			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_usa] ,true
			puts "- Opening PPLUS-MATCHED."
			_payment_name = NEWPAY.open_payment_by_description 'PPLUS-MATCHED'

			gen_wait_until_object_disappear $page_loadmask_message
			find($newpay_main).click
			gen_wait_until_object $newpay_tab_navigation
			puts "Verify that Status at this stage is MATCHED."
			NEWPAY.wait_for_status $newpay_status_matched

			puts "Select an account and launch cancel selected"
			NEWPAY.select_newpay_summary_account $bd_account_bmw_automobiles
			expect(NEWPAY.assert_cancel_selected_text_button).to eq(true)

			NEWPAY.launch_cancel_selected
			_cancel_reason = 'Partial Cancel'
			NEWPAY.fill_cancel_popup _cancel_reason

			gen_wait_until_object_disappear $page_loadmask_message
			gen_wait_until_object_disappear $newpay_progress_window
			gen_wait_until_object_disappear $page_loadmask_message

			puts "Verify that Status at this stage is PART CANCELED."
			NEWPAY.wait_for_status $newpay_status_part_canceled

			puts "Cancelled Account with lock icon and assert status icon"
		  expect(NEWPAY.is_account_lock_selected($bd_account_bmw_automobiles)).to eq(true)

		expect(NEWPAY.include_account_cancel_reason($bd_account_bmw_automobiles, _cancel_reason)).to eq(true)

		end
		gen_end_test "Positive case - Part Cancel"

		gen_start_test "2. Positive case - Cancel All"
		begin
			current_date, current_date_10 = setup_locale_and_dates()

			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_usa] ,true
			puts "- Opening PPLUS-MATCHED."
			_payment_name = NEWPAY.open_payment_by_description 'PPLUS-MATCHED'

			gen_wait_until_object_disappear $page_loadmask_message
			find($newpay_main).click
			gen_wait_until_object $newpay_tab_navigation
			puts "Verify that Status at this stage is PART CANCELED."
			NEWPAY.wait_for_status $newpay_status_part_canceled

			NEWPAY.launch_cancel_all
			_cancel_reason = 'Cancel All'
			NEWPAY.fill_cancel_popup _cancel_reason

			gen_wait_until_object_disappear $page_loadmask_message
			gen_wait_until_object_disappear $newpay_progress_window
			gen_wait_until_object_disappear $page_loadmask_message

			puts "Verify that Status at this stage is CANCELED."
			NEWPAY.wait_for_status $newpay_status_canceled

			puts "Cancelled Account with lock icon and assert status icon"
			expect(page).to have_selector($newpay_summary_toolbar, :visible => false)
			expect(page).to have_selector($newpay_summary_grid_checkbox_column_header, :visible => false)

			expect(NEWPAY.include_account_cancel_reason($bd_account_audi, _cancel_reason)).to eq(true)
			expect(NEWPAY.include_account_cancel_reason($bd_account_chrysler_motors, _cancel_reason)).to eq(true)
			expect(NEWPAY.include_account_cancel_reason($bd_account_mercedes_benz_inc, _cancel_reason)).to eq(true)
		end
		gen_end_test "Positive case - Cancel All"
		
	end

	after :all do
		login_user
		# Delete Test Data
		_delete_data = ["CODATID021803Data.destroyData();"]
		APEX.execute_commands _delete_data
		FFA.delete_new_data_and_wait
		gen_end_test "TID021803"
		SF.logout
	end
end