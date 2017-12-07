#--------------------------------------------------------------------#
#	TID : TID016916
# 	Pre-Requisite : Org with basedata deployed, need to add custom profile in uitest.run.properties,
#					Deploy CODATID016916Data.cls on org.
#  	Product Area: Accounting - Currency Revaluation (UI Test)
#--------------------------------------------------------------------#


describe "UI Test:Functionality of the button to export the transactions from Currency Revalaution pop up.", :type => :request do
include_context "login"
include_context "logout_after_each"	
	before :all do
		#Hold Base Data
		gen_start_test "Functionality of the button to export the transactions from Currency Revalaution pop up"
		FFA.hold_base_data_and_wait
	end
	
	_currency_link = 'EUR to EUR'
	CSV_TYPE_FILES = ".csv"
	XLS_TYPE_FILES = ".xls"
	it "TID016916 : Functionality of the button to export the transactions from Currency Revalaution pop up", :unmanaged => true do
		gen_start_test "TID016916 : Functionality of the button to export the transactions from Currency Revalaution pop up"
	
		begin
			create_sales_invoices = [ "CODATID016916Data.selectcompany();",
			"CODATID016916Data.switchprofile();",
			"CODATID016916Data.createdata();"]
			APEX.execute_commands create_sales_invoices	
		end
		
		#TST024550 
		gen_start_test "TST024550 : Verify the 'Export As' button on popup."
		begin
			SF.logout
			gen_switch_to_driver $driver_firefox , FIREFOX_PROFILE1
			gen_wait_less
			login_user
			SF.tab $tab_currency_revaluations
			SF.click_button_new
			CRV.check_balance_sheet_checkbox
			CRV.choose_automatically_select_all_gla
			CRV.choose_exclude_from_selection_action
			CRV.click_retrieve_data_button
			gen_wait_for_text _currency_link
			CRV.click_document_currency _currency_link
			# main window handle
			_main_window = page.driver.browser.window_handles.first
			# pop window handle
			_popwindow = page.driver.browser.window_handles.last
			# switch to pop up window
			page.driver.browser.switch_to.window(_popwindow)
			# assert that the button Export As exist in the window.
			gen_compare_has_button $crv_export_as_button_label, true, "Expected : "+$crv_export_as_button_label+" should be displayed on UI."
			# click on close button
			CRV.click_tli_pop_up_close_button
		end
		
		#TST024551
		gen_start_test "TST024551 : Verify the functionality of 'CSV' option available on popup by clicking on Export As button."
		begin
			SF.tab $tab_currency_revaluations
			SF.click_button_new
			CRV.check_balance_sheet_checkbox
			CRV.choose_automatically_select_all_gla
			CRV.choose_exclude_from_selection_action
			CRV.click_retrieve_data_button
			gen_wait_for_text _currency_link
			CRV.click_document_currency _currency_link
			# main window handle
			_main_window = page.driver.browser.window_handles.first
			# pop window handle
			_popwindow = page.driver.browser.window_handles.last
			# switch to pop up window
			page.driver.browser.switch_to.window(_popwindow)
			_number_of_csv_files_before = (gen_downloaded_files_names CSV_TYPE_FILES).count
			# click on Export As button
			CRV.click_export_as_button
			# Now click CSV File (.csv) option
			CRV.click_csv_file_export_as_button
			_number_of_csv_files_after = (gen_downloaded_files_names CSV_TYPE_FILES).count
			# Compare the number of csv files created
			gen_compare _number_of_csv_files_before+1, _number_of_csv_files_after, "Comparing number of csv files before and after"
			# cick on close button
			CRV.click_tli_pop_up_close_button
		end
		
		#TST024553
		gen_start_test "TST024553 : Verify the functionality of 'Excel' option available on popup by clicking on Export As button."
		begin
			SF.tab $tab_currency_revaluations
			SF.click_button_new
			CRV.check_balance_sheet_checkbox
			CRV.choose_automatically_select_all_gla
			CRV.choose_exclude_from_selection_action
			CRV.click_retrieve_data_button
			gen_wait_for_text _currency_link
			CRV.click_document_currency _currency_link
			# main window handle
			_main_window = page.driver.browser.window_handles.first
			# pop window handle
			_popwindow = page.driver.browser.window_handles.last
			# switch to pop up window
			page.driver.browser.switch_to.window(_popwindow)
			_number_of_excel_files_before = (gen_downloaded_files_names XLS_TYPE_FILES).count
			# click on Export As button
			CRV.click_export_as_button
			# Now click Microsoft Excel (.xls) option
			CRV.click_microsoft_excel_export_as_button
			_number_of_excel_files_after = (gen_downloaded_files_names XLS_TYPE_FILES).count
			# Compare the number of xls files created
			gen_compare _number_of_excel_files_before+1, _number_of_excel_files_after, "Comparing number of xls files before and after "
			# cick on close button
			CRV.click_tli_pop_up_close_button
		end
		
		#TST024552
		gen_start_test "TST024552 : Verify the functionality of 'PDF' option available on popup by clicking on Export As button."
		begin
			SF.tab $tab_currency_revaluations
			SF.click_button_new
			CRV.check_balance_sheet_checkbox
			CRV.choose_automatically_select_all_gla
			CRV.choose_exclude_from_selection_action
			CRV.click_retrieve_data_button
			gen_wait_for_text _currency_link
			CRV.click_document_currency _currency_link
			# main window handle
			_main_window = page.driver.browser.window_handles.first
			# pop window handle
			_popwindow = page.driver.browser.window_handles.last
			# switch to pop up window
			page.driver.browser.switch_to.window(_popwindow)
			# click on Export As button
			CRV.click_export_as_button
			# Now click Adobe PDF (.pdf) option
			CRV.click_adobe_pdf_export_as_button
			# cick on close button
			CRV.click_tli_pop_up_close_button
			# go to pdf window
			SF.retry_script_block do
				page.driver.browser.switch_to.window(page.driver.browser.window_handles.last)
				page.should have_content("Number of Transaction Line Items :")
				expect(page).to have_content("Number of Transaction Line Items :")
				gen_report_test "Find string on pdf - Number of Transaction Line Items : - Passed"
				expect(page).to have_content("EUR to EUR")
			end	
			gen_report_test "Find string on pdf - EUR to EUR - Passed"
			page.current_window.close
			page.driver.browser.switch_to.window(page.driver.browser.window_handles.first)
		end
	end
	after :all do
		gen_switch_to_driver DRIVER , BROWSER_PROFILE
		login_user
		# Delete Test Data
		delete_data = ["CODATID016916Data.selectcompany();", "CODATID016916Data.destroyData();"]				
		APEX.execute_commands delete_data
		FFA.delete_new_data_and_wait
		# delete all newly downloaded files in TST024551 and TST024553
		root_path = Dir.pwd
		if OS_TYPE == OS_WINDOWS
			file_path = root_path+$upload_file_path
			filepath = file_path.gsub("/", "\\")
		else
			filepath = root_path+$upload_file_path
		end	
		Dir.chdir(filepath)
		Dir.foreach(filepath) do |file_name|
			if file_name.include? "crv"
				File.delete(file_name)
				puts 'Deleting '+file_name
			end	
		end
		Dir.chdir(root_path)
		#wait for apex jobs to complete
		SF.wait_for_apex_job
		SF.logout
		gen_end_test "TID016916 : Functionality of the button to export the transactions from Currency Revalaution pop up"
	end
end