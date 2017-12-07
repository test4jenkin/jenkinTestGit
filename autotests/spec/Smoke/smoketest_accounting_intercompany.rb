#--------------------------------------------------------------------#
#	TID : TID012955,TID012972 , TID012989 ,TID013641
# 	Pre-Requisite : smoketest_data_setup.rb
#  	Product Area: InterCompany Account (Smoke Test)
# 	Story: 23168 
#--------------------------------------------------------------------#


describe "Smoke Test - Intercompany Account", :type => :request do
include_context "login"
include_context "logout_after_each"
	_column_line_type = "Line Type"
	_column_home_value = "Home Value"
	_report_name = "testReport1"+DateTime.now.strftime('%s')
	_current_company = "Current Company"
	_profitability_report = "Profitability Report"
	_expected_profitability_report_total_0 = "0.00"
	_bolinger_record = "Bolinger (2 records)"
	_account_value_83_33 = "Account 83.33"
	_account_value_N83_33 = "Account -83.33"
	
	before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait
		gen_start_test "Intercompany Smoke Test"
			#1.1
			begin
				SF.tab $tab_select_company
				FFA.select_company [$company_merlin_auto_usa] ,true
				SF.tab $tab_intercompany_definitions
				SF.click_button_new
				ICD.createInterCompanyDefnition $company_merlin_auto_spain , $bd_gla_bank_account_deposit_us, nil , nil , $bd_dim3_usd,$bd_dim4_usd ,$bd_gla_revaluation_reserve_bs_usd ,nil , nil , $bd_dim3_usd , $bd_dim4_usd
				SF.click_button_save
				page.has_css?($icd_intercompany_definition_number)
				expect(page).to have_css($icd_intercompany_definition_number)
				gen_report_test "Expected Intercompany definition for merlin auto usa  to be created successfully."
			end
			#1.2
			begin
				SF.tab $tab_select_company
				FFA.select_company [$company_merlin_auto_spain] ,true
				SF.tab $tab_intercompany_definitions
				SF.click_button_new
				ICD.createInterCompanyDefnition $company_merlin_auto_usa , $bd_gla_revaluation_reserve_bs_usd, $bd_dim1_eur , $bd_dim2_eur , $bd_dim3_eur,$bd_dim4_eur ,$bd_gla_bank_account_deposit_us ,$bd_dim1_eur , $bd_dim2_eur , $bd_dim3_eur , $bd_dim4_eur
				SF.click_button_save
				page.has_css?($icd_intercompany_definition_number)
				expect(page).to have_css($icd_intercompany_definition_number)
				gen_report_test "Expected Intercompany definition for merlin auto spain  to be created successfully."
			end			
	end
	
	it "TID012955:Journal- Create intercompany definition and process posted journal to create ICT journal" do
		_jnl_description = "TST016595 JOURNAL"
		_jnl_line1 = 1
		_jnl_line2 = 2
		_jnl_line3 = 3
		_jnl_line4 = 4
		_jnl_line1_amount_260 = "260.00"  
		_jnl_line2_amount_n160 = "-160.00" # n160 = negative amount 160
		_jnl_line3_amount_n50 = "-50.00"
		_jnl_line4_amount_n50 = "-50.00"
		_cancelling_journal_description = "Canceling journal number "
		_journal_created_message = "Destination document created."
		
		SF.app $accounting
		gen_start_test "TID012955-Create InterCompany Journal."
		begin			
			#1.3
			begin
				SF.tab $tab_journals
				SF.click_button_new
				JNL.set_journal_description _jnl_description
				
				JNL.select_journal_line_type $bd_jnl_line_type_gla
				JNL.select_journal_line_value $bd_gla_sales_parts			
				JNL.click_journal_new_line
				JNL.line_set_journal_amount _jnl_line1 , _jnl_line1_amount_260
				
				JNL.select_journal_line_type $bd_jnl_line_type_intercompany
				JNL.select_journal_line_value $company_merlin_auto_usa
				JNL.select_destination_line_type $label_jnl_destination_line_type_gla
				JNL.set_destination_line_type_value $label_jnl_destination_line_type_gla , $bd_gla_sales_parts
				JNL.click_journal_new_line
				JNL.line_set_journal_gla _jnl_line2 , $bd_gla_sales_parts
				JNL.line_set_journal_amount _jnl_line2 , _jnl_line2_amount_n160
				
				JNL.select_journal_line_type $bd_jnl_line_type_intercompany
				JNL.select_journal_line_value $company_merlin_auto_usa
				JNL.select_destination_line_type $label_jnl_destination_line_type_account_customer
				JNL.set_destination_line_type_value $label_jnl_destination_line_type_account_customer , $bd_account_bolinger
				gen_wait_until_object $jnl_validate_button_locator
				JNL.click_journal_new_line
				JNL.line_set_journal_gla _jnl_line3 , $bd_gla_sales_parts
				JNL.line_set_journal_amount _jnl_line3 , _jnl_line3_amount_n50
				
				JNL.select_journal_line_type $bd_jnl_line_type_intercompany
				JNL.select_journal_line_value $company_merlin_auto_usa
				JNL.select_destination_line_type $label_jnl_destination_line_type_bank_account
				JNL.set_destination_line_type_value $label_jnl_destination_line_type_bank_account , $bd_bank_account_bristol_euros_account
				gen_wait_until_object $jnl_validate_button_locator
				JNL.click_journal_new_line
				JNL.line_set_journal_gla _jnl_line4 , $bd_gla_sales_parts
				JNL.line_set_journal_amount _jnl_line4 , _jnl_line4_amount_n50
				gen_wait_until_object $jnl_validate_button_locator
				FFA.click_save_post
				gen_wait_until_object $jnl_journal_number
				#Assert Journal details
				journal_num = JNL.get_journal_number
				journal_total=JNL.get_journal_total
				journal_transaction_number = JNL.get_journal_transaction_number
				journal_status = JNL.get_journal_status
				journal_type= JNL.get_journal_type
				
				gen_compare "0.00" , journal_total , "TST016595-Expect journal total amount to be 0.00."		
				gen_include "TRN" ,  journal_transaction_number , "TST016595: Expected transaction number generated to have prefix TRN."
				gen_include "JNL" , journal_num , "TST016595: Expected journal number generated to have prefix JNL."
				gen_compare $bd_document_status_complete , journal_status , "TST016595: Expected journal status to be complete"
				gen_compare $bd_jnl_type_manual_journal , journal_type , "TST016595: Expected journal type to be Manual Journal."

			end
			# 1.4
			begin
				SF.tab $tab_select_company
				FFA.select_company [$company_merlin_auto_usa] ,true
				SF.tab $tab_intercompany_transfers
				SF.select_view $bd_select_view_available
				SF.click_button_go
				SF.edit_list_view $bd_select_view_available, $label_ict_source_document_description, 6 
				ict_number = FFA.get_column_value_in_grid $label_ict_source_document_description , _jnl_description , $label_ict_intercompany_transfer_number
				ICT.open_ICT_detail_page ict_number
				source_journal_number = ICT.get_source_journal_number
				#Assert source journal number
				gen_compare source_journal_number ,journal_num , "TST016595:Expected source journal number in ICT as same as journal created in this TID"	
			end
			# 1.5
			begin
				SF.tab $tab_intercompany_transfers
				SF.select_view $bd_select_view_available
				SF.click_button_go
				FFA.select_row_in_list_gird $label_ict_source_document_description , _jnl_description
				ICT.click_button_process
				ict_processing_message = FFA.ffa_get_info_message
				gen_include $ffa_msg_ict_process_confirmation , ict_processing_message , "Expected a confirmation message for processing ICT record"
				ICT.click_confirm_ict_process
				SF.wait_for_apex_job
				SF.tab $tab_intercompany_transfers
				SF.select_view $bd_select_view_complete_ict_journals
				SF.click_button_go
				ICT.open_ICT_detail_page ict_number
				destination_journal = ICT.get_destination_journal_number
				SF.tab $tab_journals
				SF.select_view $bd_select_view_all
				SF.click_button_go
				JNL.open_journal_detail_page destination_journal

				#Assert journal details
				journal_status = JNL.get_journal_status
				gen_compare $bd_document_status_in_progress , journal_status , "TST016595: Expected journal status to be In Progress."
				journal_reference = JNL.get_journal_reference
				gen_compare journal_num , journal_reference , "TST016595: Expected Journal reference value to be same as journal created in step 1.3." 
				journal_type= JNL.get_journal_type
				gen_compare $bd_jnl_type_manual_journal , journal_type , "TST016595: Expected journal type to be manual journal."
				
				#Assert dimensions for Sales - Part
				jnl_line_number1 = JNL.line_get_journal_line_item_number $bd_gla_sales_parts , "-160.00"
				journal_line_dimensions1 = JNL.line_get_journal_dimension1  jnl_line_number1
				gen_compare "" , journal_line_dimensions1 , "TST016595: Expected dimension-1 of line 1 to be nil."
				journal_line_dimensions2 = JNL.line_get_journal_dimension2  jnl_line_number1
				gen_compare "" , journal_line_dimensions2 , "TST016595: Expected dimension-2 of line 1 to be nil."
				journal_line_dimensions3 = JNL.line_get_journal_dimension3  jnl_line_number1
				gen_compare "" , journal_line_dimensions3 , "TST016595: Expected dimension-3 of line 1 to be nil."
				journal_line_dimensions4 = JNL.line_get_journal_dimension4  jnl_line_number1
				gen_compare "" , journal_line_dimensions4 , "TST016595: Expected dimension-4 of line 1 to be nil."
				
				#Assert dimensions for GLA Revaluation Reserve BS USD
				jnl_line_number2 = JNL.line_get_journal_line_item_number $bd_gla_revaluation_reserve_bs_usd , "260.00"
				journal_line_dimensions1 = JNL.line_get_journal_dimension1  jnl_line_number2
				gen_compare "" , journal_line_dimensions1 , "TST016595: Expected dimension-1 of line 2 to be nil."
				journal_line_dimensions2 = JNL.line_get_journal_dimension2  jnl_line_number2
				gen_compare "" , journal_line_dimensions2 , "TST016595: Expected dimension-2 of line 2 to be nil."
				journal_line_dimensions3 = JNL.line_get_journal_dimension3  jnl_line_number2
				gen_compare $bd_dim3_usd, journal_line_dimensions3 , "TST016595-: Expected dimension-3 of line 2 to be Dim 3 USD."
				journal_line_dimensions4 = JNL.line_get_journal_dimension4  jnl_line_number2
				gen_compare $bd_dim4_usd , journal_line_dimensions4 , "TST016595: Expected dimension-4 of line 2 to be Dim 4 USD."
			end	
			# 1.6
			begin
				FFA.click_post
				SF.wait_for_search_button
				journal_status = JNL.get_journal_status
				#Assert journal status as complete
				gen_compare $bd_document_status_complete , journal_status , "TST016595: Expected journal status to be Complete. "
				# keep line values in variables to compare with cancelled journal
				journal2_line1 = JNL.line_get_journal_line_value  1
				journal2_line2 = JNL.line_get_journal_line_value  2
				journal2_line3 = JNL.line_get_journal_line_value  3
				journal2_line4 = JNL.line_get_journal_line_value  4
			end
			# 1.7
			begin
			    SF.tab $tab_select_company
				FFA.select_company [$company_merlin_auto_spain] ,true
				SF.tab $tab_journals	
				SF.select_view $bd_select_view_all
				SF.click_button_go
				JNL.open_journal_detail_page  journal_num
				SF.click_button $jnl_cancel_journal
				FFA.click_save_post
				gen_compare $bd_jnl_type_cancelling_journal , JNL.get_journal_type , "Expected Journal type to be Cancelling Journal"
				gen_compare $bd_document_status_complete , JNL.get_journal_status , "Expected Journal Status to be Complete"
				gen_include _cancelling_journal_description+journal_num, JNL.get_journal_description , 	"Expected description to be "+_cancelling_journal_description+journal_num
				cancelled_journal_num = JNL.get_journal_number
				
				journal3_line1 = JNL.line_get_journal_line_value  1
				journal3_line2 = JNL.line_get_journal_line_value  2
				journal3_line3 = JNL.line_get_journal_line_value  3
				journal3_line4 = JNL.line_get_journal_line_value  4
				# Assert line values
				gen_compare "-260.00" , journal3_line1 ,"Expected cancelled journal line 1 to be reversed of original journal. "
				gen_compare "160.00" , journal3_line2 ,"Expected cancelled journal line 2 to be reversed of original journal. "
				gen_compare "50.00" , journal3_line3 ,"Expected cancelled journal line 3 to be reversed of original journal. "
				gen_compare "50.00" , journal3_line4 ,"Expected cancelled journal line 3 to be reversed of original journal. "
				SF.tab $tab_select_company
				FFA.select_company [$company_merlin_auto_usa] ,true
				SF.tab $tab_intercompany_transfers
				SF.select_view $bd_select_view_available
				SF.click_button_go
				new_ict_number = FFA.get_column_value_in_grid $label_ict_source_journal_number , cancelled_journal_num , $label_ict_intercompany_transfer_number
				ICT.open_ICT_detail_page new_ict_number
				#Assert source journal number of cancelled journal
				gen_compare cancelled_journal_num ,ICT.get_source_journal_number , "TST016595:Expected source journal number in ICT as same as journal cancelled  in this TID " + cancelled_journal_num
				gen_compare $bd_ict_record_type_intercompany_cancelling_journal, ICT.get_record_type , "TST016595:Expected ICT record type to be " +$bd_ict_record_type_intercompany_cancelling_journal	
			 end
			# 1.8
			begin
				SF.tab $tab_intercompany_transfers
				SF.select_view $bd_select_view_available
				SF.click_button_go
				FFA.select_row_in_list_gird $label_ict_source_journal_number , cancelled_journal_num
				ICT.click_button_process
				ict_processing_message = FFA.ffa_get_info_message
				gen_include $ffa_msg_ict_process_confirmation , ict_processing_message , "TST016595: Expected a confirmation message for processing ICT record"
				ICT.click_confirm_ict_process
				SF.wait_for_apex_job
				SF.tab $tab_intercompany_transfers
				SF.select_view $bd_select_view_complete_ict_journals
				SF.click_button_go
				ICT.open_ICT_detail_page new_ict_number
				cancelled_destination_journal = ICT.get_destination_journal_number
				SF.tab $tab_journals
				SF.select_view $bd_select_view_all
				SF.click_button_go
				JNL.open_journal_detail_page cancelled_destination_journal
				gen_compare $bd_document_status_in_progress , JNL.get_journal_status , "TST016595:Expected Journal Status to be In Progress."
			end
			# 1.9
			begin
				FFA.click_post
				gen_compare $bd_jnl_type_cancelling_journal , JNL.get_journal_type , "Expected Journal type to be Cancelling Journal"
				gen_include _cancelling_journal_description+destination_journal, JNL.get_journal_description , 	"Expected description to be "+_cancelling_journal_description+destination_journal
				gen_compare cancelled_journal_num, JNL.get_journal_reference , "Expected journal reference value to be " + cancelled_journal_num
				gen_compare $bd_document_status_complete , JNL.get_journal_status , "TST016595:Expected Journal Status to be Complete."
				journal4_line1 = JNL.line_get_journal_line_value  1
				journal4_line2 = JNL.line_get_journal_line_value  2
				journal4_line3 = JNL.line_get_journal_line_value  3
				journal4_line4 = JNL.line_get_journal_line_value  4

				# Assert line values of cancelled journal are reversed of original journal
				gen_compare (journal2_line1.to_f).round(2), (journal4_line1.to_f * -1).round(2) ,"Expected cancelled journal line 1 to be reversed of original journal. "
				gen_compare (journal2_line2.to_f).round(2), (journal4_line2.to_f * -1).round(2) ,"Expected cancelled journal line 2 to be reversed of original journal. "
				gen_compare (journal2_line3.to_f).round(2), (journal4_line3.to_f * -1).round(2) ,"Expected cancelled journal line 3 to be reversed of original journal. "
				gen_compare (journal2_line4.to_f).round(2), (journal4_line4.to_f * -1).round(2) ,"Expected cancelled journal line 4 to be reversed of original journal. "
			end
			#1.10
			begin
				SF.tab $tab_select_company
				FFA.select_company [$company_merlin_auto_usa] ,true
				SF.tab $tab_intercompany_transfers
				SF.select_view $bd_select_view_complete_ict_journals
				SF.click_button_go
				ICT.open_ICT_detail_page new_ict_number
				gen_compare _journal_created_message, ICT.get_processing_message , "Expected processing message to be Journals created in Destination Company."
			end
			gen_end_test "TID012955-Create InterCompany Journal."
		end
		
		#TID021614 Setup "TST038136 Setup for running the report"
		gen_start_test "TID021614-setup and validate report in both lightening and classic"
		new_tab = nil
		begin			
			SF.tab $tab_reports
			# 2.Create a new SalesForce from Report tab.
			REPORTS.click_new_report_button
			REPORTS.select_report_type $reports_report_type_transaction_line_items
			REPORTS.click_create_report_button

			REPORTS.select_show_option $reports_show_option_all_transaction
			SF.click_button $reports_remove_all_columns
			SF.click_button "OK"
			REPORTS.add_column_to_report $ffa_object_transaction_line_item, [$tranx_account_label, _column_line_type, _column_home_value]
			REPORTS.select_column_options _column_home_value, $reports_column_option_summarize_this_field
			REPORTS.check_summarize_column_sum_checkbox 
			SF.click_button $ffa_apply_button
			
			REPORTS.select_column_options $tranx_account_label, $reports_column_option_group_by_this_field
			REPORTS.add_filter
			REPORTS.select_filter_column _column_line_type
			#by default, it should check for equal operator in the filter.
			REPORTS.set_filter_condition_value $tranx_account_label
			SF.click_button $reports_filter_button_ok
			gen_wait_until_object $reports_add_filter_button

			#3. Save and run the report.
			SF.click_button_save
			REPORTS.set_report_name _report_name
			SF.click_button $reports_filter_button_save_and_run_report
			gen_wait_until_object_disappear $reports_save_and_run_button
			page.has_text?(_report_name)
			#Take the report id from the URL.
			report_id = REPORTS.get_report_id_from_url
			if(report_id != nil)
				gen_report_test "Report saved successfully."
				SF.new_custom_setting $ffa_custom_setting_accounting_settings
				SF.set_custom_setting_property $ffa_accounting_settings_profitability_report_id, report_id
				SF.click_button_save
			else
				gen_report_test "Report failed."
				raise "report Id not found"
			end
			
			#5. Switch to Lightening Experience.
			SF.switch_to_lightning
			SFL.tab $tab_home
			SFL.admin $sfl_setup_edit_page
			#Save the Hope Page as default page
			SF.click_button_save
			SF.click_button $home_page_report_activate
			gen_wait_until_object_disappear $home_page_loading_icon	
			SF.click_button $sf_next_button
			gen_wait_until_object_disappear $home_page_loading_icon	
			SF.click_button $home_page_report_activate
			gen_wait_until_object_disappear $home_page_loading_icon	
			
			SF.click_link $home_page_edit_back
			SFL.tab $tab_home
			SFL.admin $sfl_setup_edit_page
			gen_wait_until_object $sfl_home_current_company
			SF.click_link _current_company
			gen_wait_until_object_disappear $home_page_loading_icon	
			page.has_text?($company_merlin_auto_spain)
			SF.click_link _profitability_report
			gen_wait_until_object_disappear $home_page_loading_icon
			HOME_PAGE.profitability_report_set_api_name "#{ORG_PREFIX}codaTransactionLineItem__c.#{ORG_PREFIX}LineType__c"
			HOME_PAGE.profitability_report_set_field_value $tranx_account_label
			#Save and Activate the page with Current company and the porfitability report component.
			SF.click_button_save
			HOME_PAGE.activate_home_page_widget
			SF.click_button_save
			HOME_PAGE.click_refresh_button
			page.has_css?($home_page_profitability_reporting_widget)
			# Checking to make sure that activation is successfull.
			if page.has_no_css?($home_page_current_company_widget)
				puts "Activate the custom widget again."
				HOME_PAGE.activate_home_page_widget
				SF.click_button_save
			end
			SF.click_link $home_page_edit_back
			# check for custom configuration of company and profitability reporting.
			if page.has_text?(_current_company)
				gen_report_test "#{_current_company} configured correctly."
			else
				gen_report_test "#{_current_company} configuration failed."
				raise "#{_current_company} configuration failed."
			end
			
			if page.has_text?(_profitability_report)
				gen_report_test "#{_profitability_report} configured correctly."
			else
				gen_report_test "#{_profitability_report} configuration failed."
				raise "#{_profitability_report} configuration failed."
			end
			#tab 1 select a current company
			new_tab = gen_open_link_in_new_tab $tab_home
			HOME_PAGE.select_company [$company_merlin_auto_gb], true
			is_company_selected = false
			# #2. On 2nd tab refresh page and confirm they are the same.
			within_window new_tab do
				SFL.switch_to_classic
				FFA.select_company_tab
				is_company_selected = FFA.is_company_selected $company_merlin_auto_gb				
			end
			gen_compare true , is_company_selected , $company_merlin_auto_gb + " company is selected in both windows"				
			
			#3. On 2nd tab change company & save.  On 1st tab refresh page and confirm they are the same.
			within_window new_tab do
				FFA.select_company [$company_merlin_auto_spain], true				
			end
			SFL.tab $tab_home
			is_company_selected = HOME_PAGE.is_company_selected $company_merlin_auto_spain
			gen_compare true , is_company_selected , $company_merlin_auto_spain + " company is selected in both windows"				
			
			#4. On 1st tab select Deselect all and save.  On 2nd tab refresh page and confirm they are the same.
			HOME_PAGE.deselect_all_companies
			#refresh and verify on tab 2
			within_window new_tab do
				SF.tab $tab_select_company
				is_company_selected = FFA.is_company_selected $company_apex_comp_eur				
				gen_compare false , is_company_selected , $company_apex_comp_eur + " company is deselected in both windows"				
				is_company_selected = FFA.is_company_selected $company_merlin_auto_aus				
				gen_compare false , is_company_selected , $company_merlin_auto_aus + " company is deselected in both windows"				
				is_company_selected = FFA.is_company_selected $company_merlin_auto_gb				
				gen_compare false , is_company_selected , $company_merlin_auto_gb + " company is deselected in both windows"				
				is_company_selected = FFA.is_company_selected $company_merlin_auto_spain				
				gen_compare false , is_company_selected , $company_merlin_auto_spain + " company is deselected in both windows"				
				is_company_selected = FFA.is_company_selected $company_merlin_auto_usa				
				gen_compare false , is_company_selected , $company_merlin_auto_usa + " company is deselected in both windows"								
			end
			
			#5. On 1st tab select Select all and save.  On 2nd tab refresh page and confirm they are the same.
			HOME_PAGE.select_all_companies
			#refresh and verify on tab 2
			within_window new_tab do
				SF.tab $tab_select_company
				is_company_selected = FFA.is_company_selected $company_apex_comp_eur				
				gen_compare true , is_company_selected , $company_apex_comp_eur + " company is selected in both windows"				
				is_company_selected = FFA.is_company_selected $company_merlin_auto_aus				
				gen_compare true , is_company_selected , $company_merlin_auto_aus + " company is selected in both windows"				
				is_company_selected = FFA.is_company_selected $company_merlin_auto_gb				
				gen_compare true , is_company_selected , $company_merlin_auto_gb + " company is selected in both windows"				
				is_company_selected = FFA.is_company_selected $company_merlin_auto_spain				
				gen_compare true , is_company_selected , $company_merlin_auto_spain + " company is selected in both windows"				
				is_company_selected = FFA.is_company_selected $company_merlin_auto_usa				
				gen_compare true , is_company_selected , $company_merlin_auto_usa + " company is selected in both windows"				
			end
			
			#"TST038137-Profitability Reporting on home page of lightning" do
			begin 
				SFL.tab $tab_home
				profitability_total = HOME_PAGE.get_profitability_report_total
				gen_compare(profitability_total, _expected_profitability_report_total_0, "Profitability Report total in lightening is 0")
				
				#2.  Open a 2nd tab and run the SF report
				within_window new_tab do
					SFL.switch_to_classic
					SF.tab $tab_reports
					SF.click_link _report_name
					profitability_total = REPORTS.get_profitability_report_total
					gen_compare(profitability_total, _expected_profitability_report_total_0, "Profitability Report total in classic view is 0")
					report_content = REPORTS.get_report_content
					gen_include(_bolinger_record, report_content, "2 Bollinger account records present")
					gen_include(_account_value_83_33 , report_content, "#{_account_value_83_33} is present ")
					gen_include(_account_value_N83_33, report_content,"#{_account_value_N83_33} is present ")
					page.current_window.close
				end	
				SFL.switch_to_classic
			end	
		end	
		gen_end_test "TID021614-setup and validate report in both lightening and classic"
	end

	it "TID012972:Sales Invoice- Create Sales Invoice using Inter Company Account" do
		login_user
	    _line1=1
		_line2=2
		_invoice_ref = "SIN_REF1"
		_invoice_description = "TID012972-Intercompany Invoice_1"
		_line1_quantity_1="1.00"
		_line1_amount_100 ="100.00"
		_line2_quantity_2="2.00"
		_line2_amount_650 ="650.00"
		_line1_value_100="100.00"
		_line2_value_1300="1,300.00"
		_doc_total_amount_1400 ="1,400.00"
		_ict_line_quantity_column_num = ICT_LINE_ITEM_QUANTITY_COLUMN
		_ict_line_unit_price_column_num = ICT_LINE_ITEM_UNIT_PRICE_COLUMN
		_ict_line_value_column_num = ICT_LINE_ITEM_VALUE_COLUMN
		_search_column_gla ="General Ledger Account"
		_dim1 = 1
		_dim2 = 2
		_dim3 = 3
		_dim4 = 4
		_ict_reject_reason = "TID012972 ICT Rejecting"
		_ict_reject_message = "has been rejected by"
		_ict_accept_message = "has been accepted by"
		_ict_accept_message2 = "This intercompany transfer is now available for processing"
		SF.disable_lightning_component
		SF.app $accounting
		gen_start_test "TID012972: Create an intercompany sales Invoice."
		begin
			# Pre-requisite - Enable chatter feed for Intercompany Transfer
				SF.set_feed_tracking $ict_feed_tracking_object , "true"
			# 1.1
			begin 
				SF.tab $tab_select_company
				FFA.select_company [$company_merlin_auto_usa] ,true
				SF.tab $tab_sales_invoices
				SF.click_button_new
				SIN.set_account $bd_intercompany_spain_account
				SIN.set_invoice_date DateTime.now.strftime('%d/%m/%Y')
				SIN.set_customer_reference _invoice_ref	
				SIN.set_description _invoice_description
				SIN.add_line _line1 , $bd_product_a4_paper , _line1_quantity_1, _line1_amount_100 , nil , nil , nil	
				SIN.add_line _line2 , $bd_product_dell_pc , _line2_quantity_2 , _line2_amount_650 , nil , nil , nil
				FFA.click_save_post
				inv_status = SIN.get_status
				#Assert invoice status
				gen_compare $bd_document_status_complete , inv_status ,"TST016636:Expected sales invoice status to be Complete."
				invoice_number = SIN.get_invoice_number
				gen_include _doc_total_amount_1400 , SIN.get_invoice_total , " Expected that no tax should be calculated for any lines and total should be " + _doc_total_amount_1400
				FFA.click_account_toggle_icon
				dim1_value = SIN.get_invoice_account_dimension _dim1
				dim2_value = SIN.get_invoice_account_dimension _dim2
				dim3_value = SIN.get_invoice_account_dimension _dim3
				dim4_value = SIN.get_invoice_account_dimension _dim4
				gen_compare  "" , dim1_value , "TST016636:Expected  Dim-1 for SIN Intercompany spain Account to be  blank" 
				gen_compare  "" , dim2_value , "TST016636:Expected  Dim-1 for SIN Intercompany spain Account to be  blank" 
				gen_compare  $bd_dim3_usd , dim3_value , "TST016636:Expected  Dim-1 for SIN Intercompany spain Account to be  " + $bd_dim3_usd
				gen_compare  $bd_dim4_usd , dim4_value , "TST016636:Expected  Dim-1 for SIN Intercompany spain Account to be  " + $bd_dim4_usd
				FFA.click_account_toggle_icon
			end
			#1.2
			begin
				FFA.click_amend_document
				sin_amend_document_warning_message = FFA.ffa_get_info_message	
				#Assert warning message for amending completed invoice.
				gen_include $ffa_msg_sin_amend_document_warning , sin_amend_document_warning_message , "TST016636:Expected a warning message for amending posted invoice."
				SF.click_button_cancel
				page.has_no_text?($ffa_msg_sin_amend_document_warning)
				
				SIN.click_transaction_number
				page.has_text?($bd_gla_bank_account_deposit_us)
				# Assert Account type transaction line item
				
				gla_value = TRANX.get_line_item_data $label_trx_line_type_account , _search_column_gla
				trax_line_data_present = TRANX.assert_transaction_line_item $label_trx_line_type_account ,$bd_gla_bank_account_deposit_us
				gen_compare true , trax_line_data_present , "TST016636:Expected GLA value as Bank Account - Deposit US for account type transaction line item."
				
				SF.tab $tab_intercompany_transfers
				SF.select_view $bd_select_view_available
				SF.click_button_go
				ict_number = FFA.get_column_value_in_grid $label_ict_source_document_description , _invoice_description , $label_ict_intercompany_transfer_number
				ICT.open_ICT_detail_page ict_number
				ict_record_type = ICT.get_record_type	
				ict_processing_status = ICT.get_processing_status
				ict_source_company_name = ICT.get_source_company
				ict_source_sin_number = ICT.get_source_sales_invoice_number
				ict_source_doc_currency = ICT.get_source_document_currency
				ict_source_doc_total = ICT.get_source_document_total
				ict_source_doc_date = ICT.get_source_document_date
				ict_source_doc_ref = ICT.get_source_document_reference
				ict_source_doc_description = ICT.get_source_document_description
				#Assert ICT source details
				gen_compare $bd_ict_record_type_intercompany_sales ,ict_record_type , "TST016636:Expected  ICT record type to be  Intercompany Sales."
				gen_compare $bd_ict_status_available ,ict_processing_status , "TST016636:Expected  Processing Status as available."
				gen_compare $company_merlin_auto_usa , ict_source_company_name , "TST016636:Expected  source company as merlin auto usa"
				gen_compare invoice_number ,ict_source_sin_number , "TST016636:Expected  source invoice number to ve updated with invoice created abobe."
				gen_compare $bd_currency_eur ,ict_source_doc_currency , "TST016636:Expected  source document currency as EUR."
				gen_compare _doc_total_amount_1400 ,ict_source_doc_total , "TST016636:Expected  source document total as 1,400.00."
				gen_compare DateTime.now.strftime('%d/%m/%Y') , ict_source_doc_date , "TST016636:Expected  ict record date to be of today."
				gen_compare _invoice_ref ,ict_source_doc_ref , "TST016636:Expected  ICT Source Document reference to be SIN_REF1."
				gen_compare _invoice_description ,ict_source_doc_description , "TST016636:Expected  ICT Source Document description to be intercompany invoice 1."

				# Assert ICT line Items- A4 Paper
				ict_line_unit_price = ICT.get_ICT_line_item_details $bd_product_a4_paper , _ict_line_unit_price_column_num
				ict_line_value = ICT.get_ICT_line_item_details $bd_product_a4_paper, _ict_line_value_column_num
				ict_line_quantity = ICT.get_ICT_line_item_details $bd_product_a4_paper , _ict_line_quantity_column_num
				
				gen_compare _line1_quantity_1 ,ict_line_quantity , "TST016636:Expected  Line quantity for A4 Paper line to be 1.00."
				gen_include _line1_amount_100 ,ict_line_unit_price , "TST016636:Expected  Unit price for A4 Paper line item to be 100.00."
				gen_compare _line1_value_100 ,ict_line_value , "TST016636:Expected  line Value for line item A4 paper to be 100.00 ."
				
				# Assert ICT line Items- Dell PC
				ict_line_quantity = ICT.get_ICT_line_item_details $bd_product_dell_pc , _ict_line_quantity_column_num
				ict_line_unit_price = ICT.get_ICT_line_item_details $bd_product_dell_pc , _ict_line_unit_price_column_num
				ict_line_value = ICT.get_ICT_line_item_details $bd_product_dell_pc , _ict_line_value_column_num
				
				gen_compare _line2_quantity_2 ,ict_line_quantity , "TST016636:Expected  Line quantity for Dell PC line item to be 2."
				gen_include _line2_amount_650 ,ict_line_unit_price ,  "TST016636:Expected  Unit price for Dell PC line item to be 650.00."
				gen_compare _line2_value_1300 ,ict_line_value , "TST016636:Expected  Value for line item Dell PC to be 1,300.00 ."
			end	
			#1.3 and 1.4
			begin
				SF.tab $tab_select_company
				FFA.select_company [$company_merlin_auto_spain] ,true
				SF.tab $tab_intercompany_transfers
				SF.select_view $bd_select_view_available
				SF.click_button_go
				
				ICT.open_ICT_detail_page ict_number
				page.has_text?(ict_number)
				SF.click_action $ict_reject_ict_button
				gen_wait_until_object $ict_reject_reason_textarea
				ICT.set_ict_reject_reason _ict_reject_reason 
				#Confirm the ICT reject process.
				SF.click_action $ict_reject_ict_button
				page.has_text?(ict_number)
				chatter_feed_reject_message = ict_number + " "+_ict_reject_message + " " + $company_merlin_auto_spain
				gen_compare $bd_ict_status_rejected , ICT.get_processing_status, "Expected ICT processing status to be Rejected"
				# if feeds are not shown on page, it will click on show feed to display feed on page.
				SF.click_show_feed
				expect(page).to have_content(chatter_feed_reject_message)
				gen_report_test "Expected chatter feed reject message to be displayed for rejecting ICT. "
				expect(page).to have_content(_ict_reject_reason)
				gen_report_test "Expected chatter feed reject reason to be displayed for rejecting ICT. "
				#Accpet the ICT to process it.
				ICT.click_accept_button
				# confirm the accept process.
				SF.click_button $ict_accept_ict_button
				page.has_text?(ict_number)
				chatter_feed_accept_message = ict_number + " "+_ict_accept_message+" " + $company_merlin_auto_spain
				gen_compare $bd_ict_status_available , ICT.get_processing_status, "Expected ICT processing status to be Available"
				ict_accept_message_present = ICT.is_chatter_content_available chatter_feed_accept_message 
				ict_accept_message2_present = ICT.is_chatter_content_available _ict_accept_message2 
				gen_compare ict_accept_message_present ,true , "Expected chatter feed message to be present: #{chatter_feed_accept_message}."
				gen_compare ict_accept_message2_present ,true , "Expected chatter feed message to be present: #{_ict_accept_message2}."
			end
			
			#1.5
			begin
				SF.tab $tab_intercompany_transfers
				SF.select_view $bd_select_view_available
				SF.click_button_go
				FFA.select_row_in_list_gird $label_ict_source_document_description , _invoice_description
				ICT.click_button_process
				ict_processing_message = FFA.ffa_get_info_message
				gen_include $ffa_msg_ict_process_confirmation , ict_processing_message , "TST016636:Expected  a confirmation message for processing ICT record"
				ICT.click_confirm_ict_process
				SF.wait_for_apex_job
			end
			
			# 1.6
			begin
				SF.tab $tab_intercompany_transfers
				SF.select_view $bd_select_view_complete_ict_sales_invoice	 
				SF.click_button_go
				ICT.open_ICT_detail_page ict_number
				ict_status = ICT.get_processing_status
				ict_destination_pin = ICT.get_destination_payable_invoice_number
				gen_compare $bd_ict_status_complete ,ict_status , "TST016636:Expected  ICT Processing Status to be complete."
				
				SF.tab $tab_payable_invoices
				SF.select_view $bd_select_view_all
				SF.click_button_go
				PIN.open_invoice_detail_page ict_destination_pin

				inv_status = PIN.get_invoice_status	
				pin_num = PIN.get_invoice_number
				acc_name = PIN.get_account
				pin_description = PIN.get_description
				pin_ref1 = PIN.get_reference1
				vendor_invoice = PIN.get_vendor_invoice_number
				inv_total = PIN.get_invoice_total
				inv_currency = PIN.get_invoice_currency
				inv_date = PIN.get_invoice_date
				# Assert Payable Invoice- PIN details
				gen_compare $bd_document_status_in_progress ,inv_status , "TST016636:Expected  invoice status to be In Progress."
				gen_compare $bd_intercompany_usa_account ,acc_name , "TST016636:Expected  invoice Account name to be intercompany usa account."
				gen_compare _invoice_description ,pin_description , "TST016636:Expected  PIN description to be same as sales invoice description."
				gen_compare _invoice_ref , pin_ref1 , "TST016636:Expected  PIN reference1 value to be same as SIN reference."
				gen_compare invoice_number ,vendor_invoice , "TST016636:Expected  PIN vendor invoice number to be same as SIN number."  
				gen_compare $bd_currency_eur ,inv_currency , "TST016636:Expected  invoice currency to be EUR."
				gen_include _doc_total_amount_1400 ,inv_total , "TST016636:Expected  PIN total as 1,400.00"
				gen_compare DateTime.now.strftime('%d/%m/%Y') , inv_date , "TST016636:Expected  PIN sate to be of today."
				# click on triangle icon to open the analysis window displaying dimensions of PIN Account
				FFA.click_account_toggle_icon
				#Assert dimensions of Account.
				dimension1 = PIN.get_invoice_account_dimension _dim1
				gen_compare  $bd_dim1_eur , dimension1 , "TST016636:Expected  Dim-1 for PIN Account to be Dim 1 EUR"
				dimension2 = PIN.get_invoice_account_dimension _dim2
				gen_compare  $bd_dim2_eur , dimension2 , "TST016636:Expected  Dim-2 for PIN Account to be Dim 2 EUR"
				dimension3 = PIN.get_invoice_account_dimension _dim3
				gen_compare  $bd_dim3_eur , dimension3 , "TST016636:Expected  Dim-3 for PIN Account to be Dim 3 EUR"
				dimension4 = PIN.get_invoice_account_dimension _dim4
				gen_compare  $bd_dim4_eur , dimension4 , "TST016636:Expected  Dim-4 for PIN Account to be Dim 4 EUR"
				FFA.click_account_toggle_icon

				#Assert line Item Data- A4 Paper
				qunatity = PIN.get_product_line_data $bd_product_a4_paper , $label_product_line_quantity 
				unit_price = PIN.get_product_line_data $bd_product_a4_paper , $label_product_line_unit_price 
				net_value = PIN.get_product_line_data $bd_product_a4_paper , $label_product_line_net_value 
				gen_compare _line1_quantity_1.to_i,qunatity.to_i ,"TST016636:Expected  Quantity for line Item A4 Paper to be 1.00 "
				gen_compare _line1_amount_100.to_f,unit_price.to_f ,"TST016636:Expected  Unit Price for line Item A4 Paper to be 100.00"
				gen_include _line1_value_100,net_value ,"TST016636:Expected  Net Value for line Item A4 Paper to be 100.00"
				
				#Assert line Item Data- Dell PC
				qunatity = PIN.get_product_line_data $bd_product_dell_pc , $label_product_line_quantity 
				unit_price = PIN.get_product_line_data $bd_product_dell_pc , $label_product_line_unit_price
				net_value = PIN.get_product_line_data $bd_product_dell_pc , $label_product_line_net_value
				gen_compare _line2_quantity_2.to_i,qunatity.to_i ,"TST016636:Expected  Quantity for line Item Dell PC to be 2"
				gen_compare _line2_amount_650.to_f,unit_price.to_f ,"TST016636:Expected  Unit Price for line Item Dell PC to be 650.00"
				gen_include _line2_value_1300,net_value ,"TST016636:Expected  Net Value for line Item Dell PC to be 1,300.00"	
			end
			
			#1.7
			begin
				FFA.click_post
				inv_status = PIN.get_invoice_status	
				#Assert PIN status as complete
				gen_compare $bd_document_status_complete ,inv_status , "TST016636:Expected  PIN status to be complete."
			end
			#1.8
			begin
				PIN.click_transaction_link_and_wait
				#Assert transaction line item account detail
				gla_value_present = TRANX.assert_transaction_line_item $label_trx_line_type_account , $bd_gla_bank_account_deposit_us
				gen_compare true , gla_value_present , "TST016636:Expected  GLA value to be Bank Account Depost US"
				SF.tab $tab_intercompany_transfers
				SF.select_view $bd_select_view_complete_ict_sales_invoice
				SF.click_button_go
				ICT.open_ICT_detail_page ict_number
				ict_record_type = ICT.get_record_type	
				ict_processing_status = ICT.get_processing_status
				ict_source_company_name = ICT.get_source_company
				ict_source_sin_number = ICT.get_source_sales_invoice_number
				ict_source_doc_currency = ICT.get_source_document_currency
				ict_source_doc_total = ICT.get_source_document_total
				ict_source_doc_date = ICT.get_source_document_date
				ict_source_doc_ref = ICT.get_source_document_reference
				ict_source_doc_description = ICT.get_source_document_description
				ict_destination_company = ICT.get_destination_company_name
				ict_destination_pin = ICT.get_destination_payable_invoice_number
					
				#Assert ICT destination details
				gen_compare $company_merlin_auto_spain ,ict_destination_company , "TST016636:Expected  ICT destination company to be Merlin Auto Spain."
				gen_compare pin_num ,ict_destination_pin , "TST016636:Expected  ICT destination PIN to be updated with new PIN created."
				#Assert ICT source details
				gen_compare $bd_ict_record_type_intercompany_sales ,ict_record_type , "TST016636:Expected  ICT Record type to be  Intercompany Sales."
				gen_compare $bd_ict_status_complete ,ict_processing_status , "TST016636:Expected  ICT Processing Status to be complete."
				gen_compare $company_merlin_auto_usa , ict_source_company_name , "TST016636:Expected  ICT Source Company name to be Merlin Auto USA"
				gen_compare invoice_number ,ict_source_sin_number , "TST016636:Expected  Source SIN to be updated with SIN created above."
				gen_compare $bd_currency_eur ,ict_source_doc_currency , "TST016636:Expected  Source Document currency to be EUR."
				gen_compare "1,400.00" ,ict_source_doc_total , "TST016636:Expected  Source Document total to be 1,400."
				gen_compare DateTime.now.strftime('%d/%m/%Y') , ict_source_doc_date , "TST016636:Expected Source Document date to be today."
				gen_compare _invoice_ref ,ict_source_doc_ref , "TST016636:Expected Source Document reference to be same as SIN reference."
				gen_compare _invoice_description ,ict_source_doc_description , "TST016636:Expected Source Document description to be same as of SIN description."
			end
			gen_end_test "TID012972: Create an intercompany sales Invoice."
		end
	end
	
	it "TID012989:Sales Credit Note: Create Sales credit note using Inter Company Account" do
		login_user
		_line1=1
		_line2=2
		_dim1 = 1
		_dim2 = 2
		_dim3 = 3
		_dim4 = 4
		_line1_quantity_1="1.00"
		_line1_amount_100 ="100.00"
		_line1_value_100="100.00"
		_line2_quantity_2="2.00"
		_line2_amount_650 ="650.00"
		_line2_value_1300="1,300.00"
		_doc_total_amount_1400 ="1,400.00"
		_ict_line_quantity_column_num = ICT_LINE_ITEM_QUANTITY_COLUMN
		_ict_line_unit_price_column_num = ICT_LINE_ITEM_UNIT_PRICE_COLUMN
		_ict_line_value_column_num = ICT_LINE_ITEM_VALUE_COLUMN
		_creditnote_ref = "#TID012989 SCR_REF1"
		_creditnote_description = "#TID012989 InterCompany credit Note_1"
		_search_column_gla ="General Ledger Account"

		SF.app $accounting
		gen_start_test "TID012989: Create an intercompany sales credit note."
		begin
			# Pre-requisite - Disable chatter feed for Intercompany Transfer
				SF.set_feed_tracking $ict_feed_tracking_object , "false"
			#1.1
			begin
				SF.tab $tab_select_company
				FFA.select_company [$company_merlin_auto_usa] ,true
				SF.tab $tab_sales_credit_notes
				SF.click_button_new
				SCR.set_account $bd_intercompany_spain_account
				SCR.set_creditnote_date DateTime.now.strftime('%d/%m/%Y')
				SCR.set_description _creditnote_description
				SCR.set_customer_reference _creditnote_ref
				SCR.add_line _line1 , $bd_product_a4_paper , _line1_quantity_1 , _line1_amount_100 , nil , nil 	
				SCR.add_line _line2 , $bd_product_dell_pc , _line2_quantity_2 , _line2_amount_650 , nil , nil 
				FFA.click_save_post
				creditnote_status = SCR.get_credit_note_status
				creditnote_number = SCR.get_credit_note_number
				#Assert credit note status
				gen_compare $bd_document_status_complete , creditnote_status ,"TST016637:Expected SIN status to be complete."
				gen_include _doc_total_amount_1400, SCR.get_credit_note_total , "Expected credit note total to be 1,400 as no tax should be applicable on SCR lines. "
				# Assert account dimensions
				FFA.click_account_toggle_icon
				dim1_value = SCR.get_credit_note_account_dimension _dim1
				dim2_value = SCR.get_credit_note_account_dimension _dim2
				dim3_value = SCR.get_credit_note_account_dimension _dim3
				dim4_value = SCR.get_credit_note_account_dimension _dim4
				gen_compare  "" , dim1_value , "TST016636:Expected  Dim-1 for SCR Account to be  blank" 
				gen_compare  "" , dim2_value , "TST016636:Expected  Dim-1 for SCR Account to be  blank" 
				gen_compare  $bd_dim3_usd , dim3_value , "TST016636:Expected  Dim-1 for SCR  Account to be  " + $bd_dim3_usd
				gen_compare  $bd_dim4_usd , dim4_value , "TST016636:Expected  Dim-1 for SCR  Account to be  " + $bd_dim4_usd
				FFA.click_account_toggle_icon
			end
			#1.2
			begin
				FFA.click_amend_document
				scr_amend_document_warning_message = FFA.ffa_get_info_message
				gen_include $ffa_msg_scr_amend_document_warning , scr_amend_document_warning_message , "TST016637:Expected a warning message for amending posted credit note."
				SF.click_button_cancel
				page.has_no_text?($ffa_msg_scr_amend_document_warning)
				SCR.click_transaction_number
				page.has_text?($bd_gla_bank_account_deposit_us)
				#Assert Account type transaction line item
				gla_value_present = TRANX.assert_transaction_line_item $label_trx_line_type_account , $bd_gla_bank_account_deposit_us
				gen_compare true , gla_value_present , "TST016637:Expected  GLA value as Bank Account - Deposit US for account type transaction line item."
				
				SF.tab $tab_intercompany_transfers
				SF.select_view $bd_select_view_available
				SF.click_button_go
				ict_number = FFA.get_column_value_in_grid $label_ict_source_document_description , _creditnote_description , $label_ict_intercompany_transfer_number
				ICT.open_ICT_detail_page ict_number
				ict_record_type = ICT.get_record_type	
				ict_processing_status = ICT.get_processing_status
				ict_source_company_name = ICT.get_source_company
				ict_source_scr_number = ICT.get_source_sales_credit_note_number
				ict_source_doc_currency = ICT.get_source_document_currency
				ict_source_doc_total = ICT.get_source_document_total
				ict_source_doc_date = ICT.get_source_document_date
				ict_source_doc_ref = ICT.get_source_document_reference
				ict_source_doc_description = ICT.get_source_document_description
				#Assert source details
				gen_compare $bd_ict_record_type_intercompany_sales_credit ,ict_record_type , "TST016637:Expected  ICT Record type to be of  Intercompany Sales Credit."
				gen_compare $bd_ict_status_available ,ict_processing_status , "TST016637:Expected  Processing Status as available."
				gen_compare $company_merlin_auto_usa , ict_source_company_name , "TST016637:Expected  source company as merlin auto usa"
				gen_compare creditnote_number ,ict_source_scr_number , "TST016637:Expected  source credit note number to be updated with credit note created above."
				gen_compare $bd_currency_eur ,ict_source_doc_currency , "TST016637:Expected  source document currency as EUR."
				gen_compare _doc_total_amount_1400 ,ict_source_doc_total , "TST016637:Expected  source document total as 1,400.00."
				gen_compare DateTime.now.strftime('%d/%m/%Y') , ict_source_doc_date , "TST016637:Expected  ict record date to be of today."
				gen_compare _creditnote_ref ,ict_source_doc_ref , "TST016637:Expected  ICT Source Document reference to be #TID012989 SCR_REF1."
				gen_compare _creditnote_description ,ict_source_doc_description , "TST016637:Expected  ICT Source Document description to be #TID012989 intercompany credit 1."

				# Assert ICT line Items- A4 Paper
				ict_line_unit_price = ICT.get_ICT_line_item_details $bd_product_a4_paper , _ict_line_unit_price_column_num
				ict_line_value = ICT.get_ICT_line_item_details $bd_product_a4_paper, _ict_line_value_column_num
				ict_line_quantity = ICT.get_ICT_line_item_details $bd_product_a4_paper , _ict_line_quantity_column_num
				
				gen_compare _line1_quantity_1 ,ict_line_quantity , "TST016637:Expected  Line quantity for A4 Paper line to be 1.00."
				gen_include _line1_amount_100 ,ict_line_unit_price , "TST016637:Expected  Unit price for A4 Paper line item to be 100.00."
				gen_compare _line1_value_100 ,ict_line_value , "TST016637:Expected  line Value for line item A4 paper to be 100.00 ."
				
				# Assert ICT line Items- Dell PC
				ict_line_quantity = ICT.get_ICT_line_item_details $bd_product_dell_pc , _ict_line_quantity_column_num
				ict_line_unit_price = ICT.get_ICT_line_item_details $bd_product_dell_pc , _ict_line_unit_price_column_num
				ict_line_value = ICT.get_ICT_line_item_details $bd_product_dell_pc , _ict_line_value_column_num
				
				gen_compare _line2_quantity_2 ,ict_line_quantity , "TST016637:Expected  Line quantity for Dell PC line item to be 2."
				gen_include _line2_amount_650 ,ict_line_unit_price ,  "TST016637:Expected  Unit price for Dell PC line item to be 650.00."
				gen_compare _line2_value_1300 ,ict_line_value , "TST016637:Expected  Value for line item Dell PC to be 1,300.00 ."
			end	
			
			#1.3
			begin
				SF.tab $tab_select_company
				FFA.select_company [$company_merlin_auto_spain] ,true
				SF.tab $tab_intercompany_transfers
				SF.select_view $bd_select_view_available
				SF.click_button_go
				FFA.select_row_in_list_gird  $label_ict_source_document_description , _creditnote_description 
				ICT.click_button_process
				ict_processing_message = FFA.ffa_get_info_message
				gen_include $ffa_msg_ict_process_confirmation , ict_processing_message , "TST016637:Expected  a confirmation message for processing ICT record"
				ICT.click_confirm_ict_process
				SF.wait_for_apex_job
			end
			
			#1.4
			begin
				SF.tab $tab_intercompany_transfers
				SF.select_view $bd_select_view_complete_ict_sales_credit_note	
				SF.click_button_go
				ICT.open_ICT_detail_page ict_number
				ict_status = ICT.get_processing_status
				ict_destination_pcr = ICT.get_destination_payable_credit_note_number
				#Assert ICT status as complete
				gen_compare $bd_ict_status_complete ,ict_status , "TST016637:Expected  ICT Processing Status to be complete."
				
				SF.tab $tab_payable_credit_notes
				SF.select_view $bd_select_view_all 
				SF.click_button_go
				PCR.open_credit_note_detail_page ict_destination_pcr

				acc_name = PCR.get_account
				pcr_description = PCR.get_description
				ref1 = PCR.get_reference1
				vendor_credit_number = PCR.get_vendor_credit_note_number
				pcr_total = PCR.get_credit_note_total
				pcr_curr = PCR.get_credit_note_currency
				pcr_date = PCR.get_credit_note_date
				pcr_status = PCR.get_credit_note_status
				pcr_number = PCR.get_credit_note_number
				#Assert Payable credit note details
				gen_compare $bd_document_status_in_progress ,pcr_status , "TST016637:Expected  payable Credit Note Status to be In progress."
				gen_compare $bd_intercompany_usa_account ,acc_name , "TST016637:Expected  PCR Account to be Intercompany USA Account"
				gen_compare _creditnote_description ,pcr_description , "TST016637:Expected  PCR Description value to be #TID012989 InterCompany credit Note 1."
				gen_compare _creditnote_ref , ref1 , "TST016637:Expected  PCR Reference1 value to be #TID012989 SCR_REF1"
				gen_compare creditnote_number ,vendor_credit_number , "vendor invoice number  is correct."
				gen_compare $bd_currency_eur ,pcr_curr , "TST016637:Expected  Payable Credit note  currency to be EUR."
				gen_include _doc_total_amount_1400 ,pcr_total , " TST016637:Expected  credit note  total to be 1,400."
				gen_compare DateTime.now.strftime('%d/%m/%Y') , pcr_date , "TST016637:Expected  Credit note  date to be of today."
				
				# click on triangle icon to open the analysis window displaying dimensions of PCR Account
				FFA.click_account_toggle_icon
				#Assert Account dimensions.
				dimension1 = PCR.get_creditnote_account_dimension _dim1
				gen_compare  $bd_dim1_eur , dimension1 , "TST016637:Expected  Dim-1 for PCR Account to be Dim 1 EUR"
				dimension2 = PCR.get_creditnote_account_dimension _dim2
				gen_compare  $bd_dim2_eur , dimension2 , "TST016637:Expected  Dim-2 for PCR Account to be Dim 2 EUR"
				dimension3 = PCR.get_creditnote_account_dimension _dim3
				gen_compare  $bd_dim3_eur , dimension3 , "TST016637:Expected  Dim-3 for PCR Account to be Dim 3 EUR"
				dimension4 = PCR.get_creditnote_account_dimension _dim4
				gen_compare  $bd_dim4_eur , dimension4 , "TST016637:Expected  Dim-4 for PCR Account to be Dim 4 EUR"
				FFA.click_account_toggle_icon
				
				#Assert line Item Data- A4 Paper
				qunatity = PCR.get_product_line_data $bd_product_a4_paper , $label_product_line_quantity 
				unit_price = PCR.get_product_line_data $bd_product_a4_paper , $label_product_line_unit_price 
				net_value = PCR.get_product_line_data $bd_product_a4_paper , $label_product_line_net_value 
				gen_compare _line1_quantity_1.to_i,qunatity.to_i ,"TST016637:Expected  Quantity for line Item A4 Paper to be 1.00 "
				gen_compare _line1_amount_100.to_f,unit_price.to_f ,"TST016637:Expected  Unit Price for line Item A4 Paper to be 100.00"
				gen_include _line1_value_100,net_value ,"TST016637:Expected  Net Value for line Item A4 Paper to be 100.00"
				
				#Assert line Item Data- Dell PC
				qunatity = PCR.get_product_line_data $bd_product_dell_pc , $label_product_line_quantity 
				unit_price = PCR.get_product_line_data $bd_product_dell_pc , $label_product_line_unit_price
				net_value = PCR.get_product_line_data $bd_product_dell_pc , $label_product_line_net_value
				gen_compare _line2_quantity_2.to_i,qunatity.to_i ,"TST016637:Expected  Quantity for line Item Dell PC to be 2"
				gen_compare _line2_amount_650.to_f,unit_price.to_f ,"TST016637:Expected  Unit Price for line Item Dell PC to be 650.00"
				gen_include _line2_value_1300,net_value ,"TST016637:Expected  Net Value for line Item Dell PC to be 1,300.00"
			end
			
			#1.5
			begin
				FFA.click_post
				pcr_status = PCR.get_credit_note_status
				#Assert Payable credit note status
				gen_compare $bd_document_status_complete ,pcr_status , "TST016637:Expected  payable Credit Note Status to be complete."
			end
			
			#1.6
			begin
				PCR.click_transaction_number
				page.has_text?($bd_gla_bank_account_deposit_us)
				#Assert Account type transaction line item
				gla_value_present = TRANX.assert_transaction_line_item $label_trx_line_type_account , $bd_gla_bank_account_deposit_us
				gen_compare true , gla_value_present , "TST016637:Expected  GLA value as Bank Account - Deposit US for account type transaction line item."
				SF.tab $tab_intercompany_transfers
				SF.select_view $bd_select_view_complete_ict_sales_credit_note
				SF.click_button_go
				ICT.open_ICT_detail_page ict_number
				ict_record_type = ICT.get_record_type	
				ict_processing_status = ICT.get_processing_status
				ict_source_company_name = ICT.get_source_company
				ict_source_scr_number = ICT.get_source_sales_credit_note_number
				ict_source_doc_currency = ICT.get_source_document_currency
				ict_source_doc_total = ICT.get_source_document_total
				ict_source_doc_date = ICT.get_source_document_date
				ict_source_doc_ref = ICT.get_source_document_reference
				ict_source_doc_description = ICT.get_source_document_description
				ict_destination_company = ICT.get_destination_company_name
				ict_destination_pcr = ICT.get_destination_payable_credit_note_number
					
				#Assert ICT destination  details
				gen_compare $company_merlin_auto_spain ,ict_destination_company , "TST016637:Expected  ICT destination company to be merlin Auto Spain."
				gen_compare pcr_number ,ict_destination_pcr , "TST016637:Expected  ICT destination PCR to be updated with Credit note created after successful ICT processing."
				#Assert ICT source details
				gen_compare $bd_ict_record_type_intercompany_sales_credit ,ict_record_type , "TST016637:Expected  ICT Record type to be of  Intercompany Sales Credit."
				gen_compare $bd_ict_status_complete ,ict_processing_status , "TST016637:Expected  Processing Status as available."
				gen_compare $company_merlin_auto_usa , ict_source_company_name , "TST016637:Expected  source company as merlin auto usa"
				gen_compare creditnote_number ,ict_source_scr_number , "TST016637:Expected  source SCR number to be updated with SCR created in above steps."
				gen_compare $bd_currency_eur ,ict_source_doc_currency , "TST016637:Expected  source document currency as EUR."
				gen_compare _doc_total_amount_1400 ,ict_source_doc_total , "TST016637:Expected  source document total as 1,400.00."
				gen_compare DateTime.now.strftime('%d/%m/%Y') , ict_source_doc_date , "TST016637:Expected  ict record date to be of today."
				gen_compare _creditnote_ref ,ict_source_doc_ref , "TST016637:Expected  ICT Source Document reference to be #TID012989 SCR_REF1."
				gen_compare _creditnote_description ,ict_source_doc_description , "TST016637:Expected  ICT Source Document description to be #TID012989 intercompany credit 1."
			end
			gen_end_test "TID012989: Create an intercompany sales credit note."
		end
	end

	it "TID013641 : InterCompany Cash Entry Smoke Test. " do
		login_user
		_cashentry_value_100 = "100.00"
		_cashentry_description = "TID013641 Cash Entry"
		_ict_cashentry_message = "Destination document created."
		SF.app $accounting
		gen_start_test "TID013641: Create a Intercompany Cash Entry and process ICT record."
		begin
			#1.1 and 1.2
			begin
				SF.tab $tab_select_company
				FFA.select_company [$company_merlin_auto_spain] ,true
				SF.tab $tab_cash_entries
				SF.click_button_new
				SF.wait_for_search_button
				bank_account = CE.get_bank_account_name
				gen_compare $bd_bank_account_santander_current_account,bank_account , "TST017652: Expected default bank Account for cash entry to be Santander Current Account. "
				FFA.select_currency_from_lookup $cashentry_currency_lookup, $bd_currency_eur, $company_merlin_auto_spain			
				CE.set_payment_method $bd_payment_method_check
				CE.set_cash_entry_description _cashentry_description
				CE.line_set_account_name $bd_intercompany_usa_account
				FFA.click_new_line
				CE.line_set_payment_method_value 1 ,$bd_payment_method_cash
				CE.line_set_cashentryvalue 1,_cashentry_value_100
				CE.line_set_account_name $bd_intercompany_usa_account
				FFA.click_new_line
				CE.line_set_payment_method_value 2, $bd_payment_method_cash
				CE.line_set_cashentryvalue 2,_cashentry_value_100
				CE.line_set_account_name $bd_intercompany_usa_account
				FFA.click_new_line
				CE.line_set_payment_method_value 3 , $bd_payment_method_electronic
				CE.line_set_cashentryvalue 3,_cashentry_value_100
				FFA.click_save_post
				cashentry_number = CE.get_cash_entry_number
				cashentry_status = CE.get_cash_entry_status
				gen_compare $bd_document_status_complete , cashentry_status , "TST017652: Expected cash entry status to be complete"
				
				CE.click_transaction_link
				# Assert cash entry transaction details
				gen_compare "-450.00", TRANX.get_account_total , "TST017652: Expected Account total to be -450.00"
				gen_compare "-450.00", TRANX.get_account_outstanding_total , "TST017652: Expected Account Outstanding total to be -450.00"
				gen_compare "300.00", TRANX.get_home_debits , "TST017652: Expected Home debit  to be 300.00"
				gen_compare "450.00", TRANX.get_dual_debits , "TST017652: Expected dual debit to be 450.00"
			end	
			#1.3
			begin
				SF.tab $tab_select_company
				FFA.select_company [$company_merlin_auto_usa] ,true
				SF.tab $tab_intercompany_transfers
				SF.select_view $bd_select_view_available
				SF.click_button_go
				FFA.click_edit_link_on_list_gird $label_ict_source_document_description , _cashentry_description
				ICT.set_destination_document_bank_account $bd_bank_account_bristol_checking_account , $company_merlin_auto_usa
				SF.click_button_save
				SF.select_view $bd_select_view_available
				SF.click_button_go
				ict_number = FFA.get_column_value_in_grid $label_ict_source_document_description , _cashentry_description , $label_ict_intercompany_transfer_number
				ICT.open_ICT_detail_page ict_number

				gen_compare  $bd_ict_status_available, ICT.get_processing_status , "TST017652: Expected ICT Processing status to be Available. "
				gen_compare cashentry_number ,ICT.get_source_cash_entry_number , "TST017652:Expected source cash entry in ICT as same as cash entry created in this TID" 
				gen_compare $bd_ict_record_type_intercompany_cash_entry ,ICT.get_record_type , "TST017652:Expected ICT record type to be InterCompany Cash Entries. " 
				gen_compare $bd_cash_entry_receipt_type, ICT.get_source_document_type , "TST017652:Expected ICT document source type as Receipt. "
			end	
			#1.4
			begin
				SF.tab $tab_intercompany_transfers
				SF.select_view $bd_select_view_available
				SF.click_button_go
				FFA.select_row_in_list_gird $label_ict_source_document_description ,  _cashentry_description
				ICT.click_button_process
				ict_processing_message = FFA.ffa_get_info_message
				gen_include $ffa_msg_ict_process_confirmation , ict_processing_message , "Expected a confirmation message for processing ICT record"
				ICT.click_confirm_ict_process
				SF.wait_for_apex_job

				SF.tab $tab_intercompany_transfers
				SF.select_view $bd_select_view_complete_ict_cash_entry
				SF.click_button_go
				ICT.open_ICT_detail_page ict_number
				destination_cash_entry = ICT.get_destination_cash_entry_number
				
				SF.tab $tab_cash_entries
				SF.select_view $bd_select_view_all
				SF.click_button_go
				SF.edit_list_view $bd_select_view_all, $label_bank_account, 5
				destination_cashentry_bank_account = FFA.get_column_value_in_grid $label_cashentry_number , destination_cash_entry , $label_bank_account
				gen_compare $bd_bank_account_bristol_checking_account , destination_cashentry_bank_account , "TST017652: Expected Bank Account name to be Bristol Checking Account for cash entry. "

				CE.open_cash_entry_detail_page destination_cash_entry
				cashentry_status = CE.get_cash_entry_status
				gen_compare $bd_document_status_in_progress , cashentry_status , "TST017652: Expected destination cash entry status to be In Progress"
				gen_compare $bd_cash_entry_payment_type , CE.get_cashentry_type_value , "TST017652: Expected Cash Entry type to be Payment"
				line1_account = CE.get_line_cashentry_account 1
				line1_paymentmethod =  CE.get_line_cashentry_payment_method 1
				line1_cashentryvalue = CE.get_line_cashentry_value 1
				# Assert Line data-1
				gen_compare $bd_intercompany_spain_account ,  line1_account , "TST017652: Expected Account name as Intercompany Spain Account for Line 1. "
				gen_compare $bd_cash_entry_payment_method_cash ,line1_paymentmethod , "TST017652: Expected payment method as cash for Line 1. "
				gen_compare _cashentry_value_100 ,line1_cashentryvalue  , "TST017652: Expected cash entry value to be 100.00 for Line 1. "
				
				## Assert Line data-2
				line2_account = CE.get_line_cashentry_account 2
				line2_paymentmethod =  CE.get_line_cashentry_payment_method 2
				line2_cashentryvalue = CE.get_line_cashentry_value 2
				gen_compare $bd_intercompany_spain_account ,line2_account , "TST017652: Expected Account name as Intercompany Spain Account for Line 2. "
				gen_compare $bd_cash_entry_payment_method_cash , line2_paymentmethod , "TST017652: Expected payment method as cash for Line 2. "
				gen_compare _cashentry_value_100 , line2_cashentryvalue , "TST017652: Expected cash entry value to be 100.00 for Line 2. "
			
				## Assert Line data-3
				line3_account = CE.get_line_cashentry_account 3
				line3_paymentmethod =  CE.get_line_cashentry_payment_method 3
				line3_cashentryvalue = CE.get_line_cashentry_value 3
				gen_compare $bd_intercompany_spain_account , line3_account , "TST017652: Expected Account name as Intercompany Spain Account for Line 3. "
				gen_compare $bd_payment_method_electronic , line3_paymentmethod  , "TST017652: Expected payment method as Electronic for Line 3. "
				gen_compare _cashentry_value_100, line3_cashentryvalue , "TST017652: Expected cash entry value to be 100.00 for Line 3. "
			end
			# 1.5
			begin
				FFA.click_post
				gen_compare $bd_document_status_complete , CE.get_cash_entry_status , "TST017652: Expected cash entry status to be complete"
				CE.click_transaction_link
				
				# Assert cash entry transaction details
				gen_compare "300.00", TRANX.get_account_total , "TST017652: Expected Account total to be 300.00"
				gen_compare "300.00", TRANX.get_account_outstanding_total , "TST017652: Expected Account Outstanding total to be 300.00"
				gen_include "500.0", TRANX.get_home_debits , "TST017652: Expected Home debit  to be 500.00"
				gen_include "500.0", TRANX.get_dual_debits , "TST017652: Expected dual debit to be 500.00"
			
				SF.tab $tab_cash_entries
				SF.select_view $bd_select_view_all
				SF.click_button_go
				destination_cashentry_reference = FFA.get_column_value_in_grid $label_cashentry_number , destination_cash_entry , $label_cash_entry_reference
				gen_compare cashentry_number , destination_cashentry_reference , "TST017652: Expected Cash entry reference to be source cash entry number for destination cash entry. "
				
				SF.tab $tab_intercompany_transfers
				SF.select_view $bd_select_view_complete_ict_cash_entry
				SF.click_button_go
				ICT.open_ICT_detail_page ict_number
				gen_compare  $bd_ict_status_complete, ICT.get_processing_status , "TST017652: Expected ICT Processing status to be Available. " 
				gen_include  _ict_cashentry_message, ICT.get_processing_message , "TST017652: Expected processing message Cash entries created in Destination Company."
				gen_compare destination_cash_entry, ICT.get_destination_cash_entry_number , "TST017652: Expected destination cash entry number on ICT page as: " +destination_cash_entry 
				gen_compare $bd_cash_entry_payment_type, ICT.get_destination_document_type , "TST017652: Expected destination document type to be Payment"
			end
			gen_end_test "TID013641: Create a Intercompany Cash Entry and process ICT record."
		end
	end

	after :all do
		login_user
		SFL.switch_to_classic
		#Delete Test Data
		FFA.delete_new_data_and_wait
		gen_end_test "Intercompany Smoke Test"
		SF.logout
	end
end
