#--------------------------------------------------------------------#
#   TID : TID018369
#   Pre-Requisite: Org with basedata deployed.Deploy CODATID018369Data.cls on org.
#   Product Area: Accounting - Chart of Accounts
#   driver=firefox rspec -fd -c spec/UI/chart_of_accounts_mappings_TID018369.rb -fh -o pin_ext.html
#   profile = firefox_profile1
#   OS_TYPE = windows
#--------------------------------------------------------------------#

describe "Verify that user is able to successfully, export chart of account mappings.", :type => :request do
  include_context "login"
  include_context "logout_after_each"
	before :all do
		#Hold Base Data
		gen_start_test "TID018369: Verify that user is able to successfully, export chart of account mappings."
		FFA.hold_base_data_and_wait
	end
  
  it "Creates Chart Of Account Mappings through Sencha UI", :unmanaged => true  do

    #login and select merlin auto spain company.
    SF.app $accounting
    SF.tab $tab_select_company
    FFA.select_company [$company_merlin_auto_spain],true
	
	CSV_TYPE_FILES = ".csv"
	XLS_TYPE_FILES = ".xls"
	begin
		_create_data = ["CODATID018369Data.selectCompany();", "CODATID018369Data.createData();", "CODATID018369Data.createDataExt1();"]
		APEX.execute_commands _create_data
	end
	SF.logout
	gen_switch_to_driver $driver_firefox , FIREFOX_PROFILE1
	gen_wait_less
	login_user
    # #TST028650  - Verify that user is able to successfully export mapping in XLS format.
    gen_start_test "TST028650 - Verify that user is able to successfully export mapping in XLS format."
    begin
		SF.tab $tab_chart_of_accounts_mappings
		# click on export mapping button 
		_number_of_excel_files_before = (gen_downloaded_files_names XLS_TYPE_FILES).count
			
		COAM.click_on_export_mappings_button
		COAM.click_microsoft_excel_export_mappings_button
		
		_number_of_excel_files_after = (gen_downloaded_files_names XLS_TYPE_FILES).count
		# Compare the number of xls files created
		gen_compare _number_of_excel_files_before+1, _number_of_excel_files_after, "Comparing number of xls files before and after "
		gen_end_test "TST028650 - Verify that user is able to successfully export mapping in XLS format."
	end	
	
	gen_start_test "TST028651 - Verify that user is able to successfully export mappings in PDF format."
    begin
		SF.tab $tab_chart_of_accounts_mappings
		
		COAM.click_on_export_mappings_button
		COAM.click_adobe_pdf_export_mappings_button
		SF.retry_script_block do
			within_window(page.driver.browser.window_handles.last)do
				page.should have_content("Chart of Accounts Mappings")
				expect(page).to have_content("Chart of Accounts Mappings")
				gen_report_test "Find string on pdf - Chart of Accounts Mappings : - Passed"
				page.current_window.close
			end
		end
		gen_end_test "TST028651 - Verify that user is able to successfully export mappings in PDF format."
	end
	
	gen_start_test "TST028703 - Verify that user is able to successfully export mapping in CSV format."
    begin
		SF.tab $tab_chart_of_accounts_mappings
		_number_of_csv_files_before = (gen_downloaded_files_names CSV_TYPE_FILES).count
		# click on Export As button
		COAM.click_on_export_mappings_button
		# Now click CSV File (.csv) option
		COAM.click_csv_file_export_mappings_button
		_number_of_csv_files_after = (gen_downloaded_files_names CSV_TYPE_FILES).count
		# Compare the number of csv files created
		gen_compare _number_of_csv_files_before+1, _number_of_csv_files_after, "Comparing number of csv files before and after"
		gen_end_test "TST028703 - Verify that user is able to successfully export mapping in CSV format."
	end
		
  end
  
	after :all do
		gen_switch_to_driver DRIVER , BROWSER_PROFILE
		login_user
		# Delete Test Data
		_delete_data = ["CODATID018369Data.destroyData();"]
		APEX.execute_commands _delete_data
		FFA.delete_new_data_and_wait
		# delete all newly downloaded files
		root_path = Dir.pwd
		if OS_TYPE == OS_WINDOWS
			file_path = root_path+$upload_file_path
			filepath = file_path.gsub("/", "\\")
		else
			filepath = root_path+$upload_file_path
		end	
		Dir.chdir(filepath)
		Dir.foreach(filepath) do |file_name|
			if file_name.include? "GLA_Mappings"
				File.delete(file_name)
				puts 'Deleting '+file_name
			end	
		end
		Dir.chdir(root_path)
		SF.wait_for_apex_job
		SF.logout
		gen_end_test "TID018369 : Verify that user is able to successfully, export chart of account mappings."
	end
end