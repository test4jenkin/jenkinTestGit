#--------------------------------------------------------------------#
#   TID : TID022111
#   Pre-Requisite: Org with basedata deployed.
# 	Product Area: 'Accounting - Archiving'
# 	Story:  AC-10822, AC-13231
#   driver=firefox rspec -fd -c spec/UI/archiving_set/archiving_data_filter_selection.rb -fh -o TID022111.html
#	Copyright Year 2017 FinancialForce.com, inc. All rights reserved.
#--------------------------------------------------------------------#

describe "TID022111: Verify the selection criteria for archiving process", :type => :request do
	include_context "login"
	before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait
	end
	it "TID022111 - Verify that user is able to save archive set filter criteria through UI" do
		_help_message_displayed= "Items which meet the criteria below will be marked for deletion."
		_default_company= '' 
		_default_year=''
		_default_from_period=''
		_default_to_period=''
		_default_document_type= 'AR Documents'
		_default_payment_status='Paid'
		_should_have_content ='Archive Set Number'
		_archive_set_number_format='ARCSET-'
		_archive_job_type='Mark for Archiving'
		_archive_status='Pending'
		_archive_payment_status='All'
		_archive_document_type='AR Documents'
		_archive_set_filter_structure_number_format='ARCSETFS-'
		_archive_set_filter_number_format='ARCSETF-'
		_archive_set_filter_criteria='Multi select'
		_archive_set_filter_criteria_period='From-To'
		_archive_set_filter_criteria_from_period='From'
		_archive_set_filter_criteria_to_period='To'
		_archive_filter_structure_type='codaYear__c'
		_archive_filter_structure_type_period='codaPeriod__c'
		_archive_set_year1='2014'
		_archive_set_year2='2015'
		_archive_set_from_period='2015/002'
		_archive_set_to_period='2015/004'
		
		gen_start_test "TST039767 - Verify that user is able to save archive set filter criteria through UI when multiple years are selected."
		begin 
		    #Enable Archiving feature on org 
			FC.enable_archiving_feature
			#Select Data Archiving filter tab
			SF.tab $tab_archive_set
			ARCHIVING.click_on_new_button
			gen_report_test "clicked on new button."
						
			#Verify the help text displayed
			gen_compare _help_message_displayed, ARCHIVING.get_help_message, "Expected message displayed to be "+_help_message_displayed
			
			#Verify the default values displayed for all the filters 
			gen_compare _default_company, ARCHIVING.get_arch_company, "Expected value for Company is displayed"
			gen_compare _default_year, ARCHIVING.get_arch_year, "Expected value for Year is displayed"
			gen_compare _default_from_period, ARCHIVING.get_arch_periods_from, "Expected value is displayed" 
			gen_compare _default_to_period, ARCHIVING.get_arch_periods_to, "Expected value is displayed"
			gen_compare _default_document_type, ARCHIVING.get_archive_documents, "Expected value for AR documents is displayed"
			gen_compare _default_payment_status, ARCHIVING.get_arch_payment_status, "Expected value for Payment Status is displayed"
			gen_assert_enabled $archiving_clear_all_button
			gen_assert_enabled $archiving_run_button
			gen_assert_enabled $archiving_click_on_archive_set_list_button
			gen_report_test "The default values have been checked."
			
			#Verify the functionality of Archive Set List button 
			ARCHIVING.click_on_archive_set_list_button
			gen_compare_has_button $archiving_new_set_button_label, true, "Page has been redirected to Archive Set List View page" 
			ARCHIVING.click_on_new_archive_set_button
			
			#Set filter criteria  
			gen_wait_until_object $archiving_company_picklist
			ARCHIVING.set_arch_company $company_merlin_auto_gb 
			ARCHIVING.set_arch_year _archive_set_year2
			ARCHIVING.set_arch_year _archive_set_year1
			ARCHIVING.set_archive_documents $archiving_documents_label
			ARCHIVING.set_arch_payment_status $archiving_payment_status_all_label
			gen_report_test "The filter criteria has been set."
			
			#Verify that when year is multi-selected, period_to and period_from are disabled
			gen_assert_disabled $archiving_period_from_picklist
			gen_assert_disabled $archiving_period_to_picklist
			gen_report_test "Periods are disabled"
			
			#Verify the default values displayed for all the filters 
			ARCHIVING.click_on_clear_all_button
			gen_compare _default_company, ARCHIVING.get_arch_company, "Expected value for Company is displayed"
			gen_compare _default_year, ARCHIVING.get_arch_year, "Expected value for Year is displayed"
			gen_compare _default_from_period, ARCHIVING.get_arch_periods_from, "Expected value of From Period is displayed" 
			gen_compare _default_to_period, ARCHIVING.get_arch_periods_to, "Expected value of To Period is displayed"
			gen_compare _default_document_type, ARCHIVING.get_archive_documents, "Expected value for AR documents is displayed"
			gen_compare _default_payment_status, ARCHIVING.get_arch_payment_status, "Expected value for Payment Status is displayed"
			gen_report_test "The filters are reset when Clear All is clicked"
			
			#Set filter criteria to verify the functionality of Run button
			ARCHIVING.set_arch_company $company_merlin_auto_gb
			ARCHIVING.set_arch_year _archive_set_year2
			ARCHIVING.set_arch_year _archive_set_year1
			ARCHIVING.set_archive_documents $archiving_documents_label
			ARCHIVING.set_arch_payment_status $archiving_payment_status_all_label
			ARCHIVING.click_on_run_button
			gen_wait_until_object $archiving_set_detail_page_path
			
			#Verify that all the filter critera have been correctly populated on the detail page
			_archive_set_number =ARCHIVING.get_archive_set_detail_page_value $archiving_set_number_label
			gen_include _archive_set_number_format, _archive_set_number, "Page has correct archive set number format"
			_job_type =ARCHIVING.get_archive_set_detail_page_value $archiving_job_type_label
			gen_compare _archive_job_type, _job_type, " Page has correct Job Type Value "
			_archive_set_status=ARCHIVING.get_archive_set_detail_page_value $archiving_set_status_label
			gen_compare _archive_status, _archive_set_status, " Page has correct Status Value "
			_payment_status=ARCHIVING.get_archive_set_detail_page_value $archiving_set_payment_status_label
			gen_compare _archive_payment_status, _payment_status, " Page has correct Payment Status Value "
			_document_type=ARCHIVING.get_archive_set_detail_page_value $archiving_set_document_type_label
			gen_compare _archive_document_type, _document_type, " Page has correct Document Type Value "
			_archive_set_company=ARCHIVING.get_archive_set_detail_page_value $archiving_set_company_label
			gen_compare $company_merlin_auto_gb, _archive_set_company, " Page has correct Company Value "
			
			#Check Archive Set Filter Structures value 
			ARCHIVING.click_on_arcsetf_number $archiving_coda_year_label 
			
			#Verify Archive Set Filter Structure Detail page field values
			_archive_set_number =ARCHIVING.get_archive_set_detail_page_value $archiving_set_label
			gen_include _archive_set_number_format, _archive_set_number, "Page has correct archive set number format"
			_filter_strct_number=ARCHIVING.get_archive_set_detail_page_value  $archiving_set_filter_structure_number_label
			gen_include _archive_set_filter_structure_number_format, _filter_strct_number, "Page has correct archive set filter structure number format"
			_criteria=ARCHIVING.get_archive_set_detail_page_value  $archiving_set_filter_criteria_label
			gen_compare _archive_set_filter_criteria, _criteria, "Page has correct Filter Criteria Value "
			_struct_type=ARCHIVING.get_archive_set_detail_page_value $archiving_filter_structure_type_label
			gen_compare _archive_filter_structure_type, _struct_type, "Page has correct Filter Structure Type Value "
			
			#Check Archive Set Filter value for year 2014
			ARCHIVING.click_on_arcsetf_number_link _archive_set_year1 
			_filter_strct_number=ARCHIVING.get_archive_set_detail_page_value  $archiving_set_filter_structure_label
			gen_include _archive_set_filter_structure_number_format, _filter_strct_number, "Page has correct archive set filter structure number format"
			_archive_set_filter_number=ARCHIVING.get_archive_set_detail_page_value  $archiving_set_filter_number_label
			gen_include _archive_set_filter_number_format, _archive_set_filter_number, "Page has correct archive set filter number format"
			_criteria=ARCHIVING.get_archive_set_detail_page_value  $archiving_set_filter_criteria_label
			gen_compare _archive_set_filter_criteria, _criteria, "Page has correct Filter Criteria Value "
			_archive_set_year=ARCHIVING.get_archive_set_detail_page_value  $archiving_set_year_label
			gen_compare _archive_set_year1, _archive_set_year, "Page has correct Year Value "
			
			#click on Archive Set Filter Structure
			ARCHIVING.click_archive_set_filter_page_link $archiving_set_filter_structure_label
			
			#Check Archive Set Filter value for year 2015
			ARCHIVING.click_on_arcsetf_number_link _archive_set_year2 
			_filter_strct_number=ARCHIVING.get_archive_set_detail_page_value  $archiving_set_filter_structure_label
			gen_include _archive_set_filter_structure_number_format, _filter_strct_number, "Page has correct archive set filter structure number format"
			_archive_set_filter_number=ARCHIVING.get_archive_set_detail_page_value  $archiving_set_filter_number_label
			gen_include _archive_set_filter_number_format, _archive_set_filter_number, "Page has correct archive set filter number format"
			_criteria=ARCHIVING.get_archive_set_detail_page_value  $archiving_set_filter_criteria_label
			gen_compare _archive_set_filter_criteria, _criteria, "Page has correct Filter Criteria Value "
			_archive_set_year=ARCHIVING.get_archive_set_detail_page_value  $archiving_set_year_label
			gen_compare _archive_set_year2, _archive_set_year, "Page has correct Year Value "
			gen_end_test "TST039767 - Verify that user is able to save archive set filter criteria through UI."			
		end 
		
		gen_start_test "TST039768 - Verify that user is able to save archive set filter criteria through UI when single year is selected."
		begin 
		 	# select Data Archiving filter tab
			SF.tab $tab_archive_set
			ARCHIVING.click_on_new_button
			gen_report_test "clicked on new button."
			
			#Set filter criteria 
            gen_wait_until_object $archiving_company_picklist			
			ARCHIVING.set_arch_company $company_apex_comp_eur
			ARCHIVING.set_arch_year _archive_set_year2
			ARCHIVING.set_arch_periods_from _archive_set_from_period
			ARCHIVING.set_arch_periods_to _archive_set_to_period
			ARCHIVING.set_archive_documents $archiving_documents_label
			ARCHIVING.set_arch_payment_status $archiving_payment_status_all_label
			gen_report_test "The filter criteria has been set."
		
			#Verify functionality of Run button
		    ARCHIVING.click_on_run_button
			gen_wait_until_object $archiving_set_detail_page_path
			gen_compare_has_content $archiving_set_detail_page_label, true, "Page has been redirected to Archive Set detail page" 
			
			# Verify that all the filter critera have been correctly populated on the detail page
			_archive_set_number =ARCHIVING.get_archive_set_detail_page_value $archiving_set_number_label
			gen_include _archive_set_number_format, _archive_set_number, "Page has correct archive set number format"
			_job_type =ARCHIVING.get_archive_set_detail_page_value $archiving_job_type_label
			gen_compare _archive_job_type, _job_type, " Page has correct Job Type Value "
			_archive_set_status=ARCHIVING.get_archive_set_detail_page_value $archiving_set_status_label
			gen_compare _archive_status,_archive_set_status , " Page has correct Status Value "
			_payment_status=ARCHIVING.get_archive_set_detail_page_value $archiving_set_payment_status_label
			gen_compare _archive_payment_status, _payment_status, " Page has correct Payment Status Value "
			_document_type=ARCHIVING.get_archive_set_detail_page_value $archiving_set_document_type_label
			gen_compare _archive_document_type, _document_type, " Page has correct Document Type Value "
			_archive_set_company=ARCHIVING.get_archive_set_detail_page_value $archiving_set_company_label
			gen_compare $company_apex_comp_eur, _archive_set_company, " Page has correct Company Value "
			
			#Check Archive Set Filter Structures value for year
			ARCHIVING.click_on_arcsetf_number $archiving_coda_year_label 
			
			#Verify Archive Set Filter Structure Detail page field values
			_set_archive_number =ARCHIVING.get_archive_set_detail_page_value $archiving_set_label
			gen_include _archive_set_number_format, _set_archive_number, "Page has correct archive set number format" 
			_filter_strct_number=ARCHIVING.get_archive_set_detail_page_value  $archiving_set_filter_structure_number_label
			gen_include _archive_set_filter_structure_number_format,_filter_strct_number,  "Page has correct archive set filter structure number format"
			_criteria=ARCHIVING.get_archive_set_detail_page_value  $archiving_set_filter_criteria_label
			gen_compare _archive_set_filter_criteria, _criteria, "Page has correct Filter Criteria Value "
			_struct_type=ARCHIVING.get_archive_set_detail_page_value $archiving_filter_structure_type_label
			gen_compare _archive_filter_structure_type,_struct_type , "Page has correct Filter Structure Type Value "
			
			#Check Archive Set Filter value for year 2015
			ARCHIVING.click_on_arcsetf_number_link _archive_set_year2 
			_filter_strct_number=ARCHIVING.get_archive_set_detail_page_value  $archiving_set_filter_structure_label
			gen_include _archive_set_filter_structure_number_format, _filter_strct_number, "Page has correct archive set filter structure number format"
			_archive_set_filter_number=ARCHIVING.get_archive_set_detail_page_value  $archiving_set_filter_number_label
			gen_include _archive_set_filter_number_format,_archive_set_filter_number , "Page has correct archive set filter number format"
			_archive_set_year=ARCHIVING.get_archive_set_detail_page_value  $archiving_set_year_label
			gen_compare _archive_set_year2,_archive_set_year , "Page has correct Year Value "
			_criteria=ARCHIVING.get_archive_set_detail_page_value  $archiving_set_filter_criteria_label
			gen_compare _archive_set_filter_criteria, _criteria, "Page has correct Filter Criteria Value "				
			puts "Naviagating to filter detail page"	
			
			#click on Archive Set Filter Structure
			ARCHIVING.click_archive_set_filter_page_link $archiving_set_filter_structure_label			
			#click on Archive Set 
			ARCHIVING.click_archive_set_filter_page_link $archiving_set_label			
			#Check Archive Set Filter Structures value for period
			ARCHIVING.click_on_arcsetf_number $archiving_coda_period_label
						
			#Verify Archive Set Filter Structure Detail page field values
			_set_archive_number =ARCHIVING.get_archive_set_detail_page_value $archiving_set_label
			gen_include _archive_set_number_format, _set_archive_number, "Page has correct archive set number format"
			_filter_strct_number=ARCHIVING.get_archive_set_detail_page_value  $archiving_set_filter_structure_number_label
			gen_include _archive_set_filter_structure_number_format,_filter_strct_number,  "Page has correct archive set filter structure number format"
			_criteria=ARCHIVING.get_archive_set_detail_page_value  $archiving_set_filter_criteria_label
			gen_compare _archive_set_filter_criteria_period, _criteria, "Page has correct Filter Criteria Value "
			_struct_type_period=ARCHIVING.get_archive_set_detail_page_value  $archiving_filter_structure_type_label
			gen_compare _archive_filter_structure_type_period,_struct_type_period , "Page has correct Filter Structure Type Value "
			
			#Check Archive Set Filter value 
			ARCHIVING.click_on_arcsetf_number _archive_set_filter_criteria_from_period

			#Verify Archive Set Filter Detail page values 
			_archive_set_filter_number=ARCHIVING.get_archive_set_detail_page_value  $archiving_set_filter_number_label
			gen_include _archive_set_filter_number_format, _archive_set_filter_number, "Page has correct archive set filter number format"
			_filter_strct_number=ARCHIVING.get_archive_set_detail_page_value  $archiving_set_filter_structure_label
			gen_include _archive_set_filter_structure_number_format,_filter_strct_number,  "Page has correct archive set filter structure number format"
			_archive_set_period=ARCHIVING.get_archive_set_detail_page_value $archiving_set_period_label
			gen_compare _archive_set_from_period, _archive_set_period, "Page has correct From Period value"
			_criteria=ARCHIVING.get_archive_set_detail_page_value  $archiving_set_filter_criteria_label
			gen_compare _archive_set_filter_criteria_from_period, _criteria, "Page has correct Filter Criteria Value "
			
			#click on Archive Set Filter Structure
			ARCHIVING.click_archive_set_filter_page_link $archiving_set_filter_structure_label
			
			#Check Archive Set Filter value 
			ARCHIVING.click_on_arcsetf_number _archive_set_filter_criteria_to_period
			
			#Verify Archive Set Filter Detail page values 
			_archive_set_filter_number=ARCHIVING.get_archive_set_detail_page_value  $archiving_set_filter_number_label
			gen_include _archive_set_filter_number_format, _archive_set_filter_number, "Page has correct archive set filter number format"
			_filter_strct_number=ARCHIVING.get_archive_set_detail_page_value  $archiving_set_filter_structure_label
			gen_include _archive_set_filter_structure_number_format,_filter_strct_number,  "Page has correct archive set filter structure number format"
			_archive_set_period=ARCHIVING.get_archive_set_detail_page_value $archiving_set_period_label
			gen_compare _archive_set_to_period, _archive_set_period, "Page has correct To Period value"
			_criteria=ARCHIVING.get_archive_set_detail_page_value  $archiving_set_filter_criteria_label
			gen_compare _archive_set_filter_criteria_to_period, _criteria, "Page has correct Filter Criteria Value "
			
			gen_end_test "TST039768 - Verify that user is able to save archive set filter criteria through UI when single year is selected."
		end
	end 
	after :all do
		login_user
		#delete archive set records
		FFA.delete_new_data_and_wait
		SF.logout
		gen_end_test "TID022111: Verify the selection criteria for archiving process"			
	end 	 
 end



		