#--------------------------------------------------------------------#
#	TID : TID014836 
# 	Test Step ID:TST020300 and TST020782 
# 	Pre-Requisite : Org with base data and deploy CODATID014836Data.cls on org
#  	Product Area: Merlin Auto USA- Create and Post SIN with 42 line items and Income schedule.
# 	Story:#26576
#--------------------------------------------------------------------#

describe "Volume Test:Merlin Auto USA- Create and PoCODATID014836Datast SIN with 42 line items and Income schedule.", :type => :request do
	
	include_context "login"
	_column_invoice_description = "Invoice Description"
	_column_company = "Company"
	_column_company_position = 13
	_new_field_position = 2
	_batch_error_count_query = "SELECT SUM(NumberOfErrors) BatchErrorCount FROM AsyncApexJob"
	_batch_error_detail_query = "SELECT ApexClassId,CompletedDate,CreatedById,CreatedDate,ExtendedStatus,Id,JobItemsProcessed,JobType,LastProcessed,LastProcessedOffset,MethodName,NumberOfErrors,ParentJobId,Status,TotalJobItems FROM AsyncApexJob"
	_batch_error_count_before = "0"
	_batch_error_count_after = "0"
	_batch_string_to_replace1 = "\"BatchErrorCount\":"
	_batch_string_to_replace2 = "}]}"
	
	before :all do
		#Hold Base Data
		gen_start_test "TID014836 - TST020300 and TST020782 execution , Create Sales Invoices with 42 line items and Income schedule for Merlin Auto USA."
		FFA.hold_base_data_and_wait
		
		# get Apex batch error count before execution
		APEX.execute_soql _batch_error_count_query
		query_result = APEX.get_execution_status_message
		msg_arr = query_result.split(",")
		error_count_msg = msg_arr[-1].gsub! _batch_string_to_replace1, ""
		error_count_msg = msg_arr[-1].gsub! _batch_string_to_replace2, ""
		error_count_arr = error_count_msg.split(".")
		error_count = error_count_arr[-2]
		if(error_count != "null")
			_batch_error_count_before = error_count
		end			
	end
	it "Create Sales Invoices with 42 line items and Income schedule." do
		#"execute script as anonymous user and create data" 
		begin			
			create_sales_invoices = [ "CODATID014836Data.selectcompany();",
			"CODATID014836Data.createdata();",
			"CODATID014836Data.createdataext1();",
			"CODATID014836Data.createdataext2();",
			"CODATID014836Data.createdataext3();",
			"CODATID014836Data.createdataext4();"]				
			APEX.execute_commands create_sales_invoices				
		end
		#edit 
		begin			
			_account_ACC_EUR_1 = "ACC_EUR_1"	
			_journal_count_324 = "324"
			_invoice_prefix = "SIN_IS_"
			_column_invoice_description = "Invoice Description"
			_income_schedule_monthly_spread = "Monthly Spread 1"
			_income_schedule_income_period_3 = "IncomePeriod_3"
			_income_schedule_income_period_6 = "IncomePeriod_6"
			_income_schedule_income_period_9 = "IncomePeriod_9"
						
			#Add description column to view and remove company column as view cannot have more than 15 column
			SF.tab $tab_sales_invoices
			SF.wait_for_search_button
			SF.select_view $bd_select_view_all
			SF.click_button_go
			SF.wait_for_search_button		
			field_name_to_remove = [_column_company]
			fields_name_to_add = [_column_invoice_description]
			FFA.edit_view_add_remove_fields fields_name_to_add , field_name_to_remove, _new_field_position
					
			count = 1
			while count <= 2			
						
				_invoice_description = _invoice_prefix + count.to_s;
				
				SF.tab $tab_sales_invoices
				SF.wait_for_search_button
				SF.select_view $bd_select_view_all
				SF.click_button_go
				SF.wait_for_search_button
							
				_sinvoice_number = FFA.get_column_value_in_grid _column_invoice_description , _invoice_description , $label_invoice_number
				SF.click_link _sinvoice_number
				SF.wait_for_search_button
				SF.click_button_edit
				SF.wait_for_search_button				
				
				# Edit line item 1-10 with _income_schedule_income_period_3
				line = 1
				while line <= 10
					SIN.line_set_income_schedule  line , _income_schedule_income_period_3 
					line+=1
				end				
				
				SF.click_button_save
				SF.wait_for_search_button
				
				#Edit Next 11 to 20 line item set income Schedule equals to  _income_schedule_income_period_6
				SF.click_button_edit
				SF.wait_for_search_button
				line = 11
				while line <= 20
					SIN.line_set_income_schedule  line , _income_schedule_income_period_6 
					line += 1	
				end
				SF.click_button_save
				SF.wait_for_search_button				
				
				#Edit Next 21 to 30 line item set income Schedule equals to  _income_schedule_income_period_9
				SF.click_button_edit
				SF.wait_for_search_button							
				line=21
				while line<=30
					SIN.line_set_income_schedule  line , _income_schedule_income_period_9 
					line+=1	
				end
				SF.click_button_save
				SF.wait_for_search_button
				
				#Edit Next 31 to 36 line item set income Schedule equals to  _income_schedule_monthly_spread
				SF.click_button_edit
				SF.wait_for_search_button							
				line=31
				while line <=36
					SIN.line_set_income_schedule  line , _income_schedule_monthly_spread
					line+=1	
				end
				SF.click_button_save
				SF.wait_for_search_button				
				
				#Edit Next 37 to 42 line item set income Schedule equals to  _income_schedule_monthly_spread
				SF.click_button_edit
				SF.wait_for_search_button
				line=37
				while line<=42
					SIN.line_set_income_schedule  line , _income_schedule_monthly_spread
					line+=1	
				end
				
				if count == 1 then 	
					puts "#TST020300 - Save 42 line Items and  Post."
					SF.click_button_save
					SF.wait_for_search_button
					FFA.click_post
					SF.wait_for_search_button					
				else
					puts "#TST020782-Save & Post 42 line items."
					FFA.click_save_post
					SF.wait_for_search_button
				end
				
				# "Background Posting Scheduler and click on ‘Run now’ and check status of invoice " 
				SF.tab $tab_background_posting_scheduler
				SF.click_button $ffa_run_now_button
				SF.wait_for_apex_job
				
				#validations
				SF.tab $tab_sales_invoices
				SF.wait_for_search_button
				SF.select_view $bd_select_view_all
				SF.click_button_go
				SF.wait_for_search_button
				
				#get invoice status
				invoice_num = FFA.get_column_value_in_grid _column_invoice_description , _invoice_prefix + count.to_s, $label_invoice_number
				click_link invoice_num
				SF.wait_for_search_button
				invoice_status =  SIN.get_status
				#status should be completed
				gen_include $bd_document_status_complete, invoice_status, "Invoice "+ count.to_s + " status is Complete"
				SF.wait_for_apex_job # waiting for apex job to complete to create and post required num of journals.
				#get total number of journals
				journal_count_script = "SELECT Count() from codaJournal__c WHERE JournalStatus__c = 'Complete'  and Reference__c  = 'Invoice "+invoice_num +"'"
				APEX.execute_soql journal_count_script
				journal_count = APEX.get_execution_status_message
				gen_include ":"+_journal_count_324 +","  ,journal_count, "created "+_journal_count_324+" Journals for invoice "+ count.to_s + "."				

				count +=1	
			end
		end		
		
		#get Apex batch error count after execution
		begin			
			APEX.execute_soql _batch_error_count_query
			query_result = APEX.get_execution_status_message
			msg_arr = query_result.split(",")
			error_count_msg = msg_arr[-1].gsub! _batch_string_to_replace1, ""
			error_count_msg = msg_arr[-1].gsub! _batch_string_to_replace2, ""
			error_count_arr = error_count_msg.split(".")
			error_count = error_count_arr[-2]
			if(error_count != "null")
				 _batch_error_count_after = error_count
			end
			
			if(_batch_error_count_after != _batch_error_count_before)
				#Print  error details
				APEX.execute_soql _batch_error_detail_query
				query_result = APEX.get_execution_status_message
				query_result = "Apex batch job Failed - " + query_result
				puts query_result				
			end
		end 
		
	end	
	after :all do
		#delete Test Data
		login_user
		delete_data = [ "CODATID014836Data.destroyData();"]				
		APEX.execute_commands delete_data	
		
		#remove description column and company column
		SF.tab $tab_sales_invoices
		SF.wait_for_search_button
		SF.select_view $bd_select_view_all
		SF.click_button_go
		SF.wait_for_search_button		
		FFA.edit_view_add_remove_fields [_column_company] , [_column_invoice_description] , _column_company_position
				
		gen_end_test "TID014836 - TST020300 and TST020782 execution , Create Sales Invoices with 42 line items and Income schedule for Merlin Auto USA."
	end
end


