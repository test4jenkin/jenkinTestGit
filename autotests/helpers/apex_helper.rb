 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module APEX
extend Capybara::DSL
#############################
# Base Data Page 
#############################
#selectors
$apex_hold_base_data_button = "input[id$='holdBaseData']"
$apex_delete_new_data_button = "input[id$='deleteNewData']"
$apex_command_textarea = "textarea[name*='baseDataRestoreForm']"
$apex_execute_button = "input[title*='Execute Script']"
$apex_command_executed_successfully_message_selector= "label[id*='scriptExecutionStatus']";
$apex_execute_soql_button = "input[title*='Execute SOQL Script']"
$apex_script_executed_successfully_message_value = "Script executed successfully."
$apex_no_apex_job_running_message = "No records to display."
$apex_script_add_system_test_to_queue = "ApexClass[] testClasses = [SELECT Id, Name  FROM ApexClass WHERE Name IN ('"+$sf_param_substitute+"')];if(testClasses.size() > 0){ApexTestQueueItem[] queueItems = new List<ApexTestQueueItem>();for (ApexClass cls : testClasses){queueItems.add(new ApexTestQueueItem(ApexClassId=cls.Id));}insert queueItems;}" 
$apex_system_test_status_completed = "\"Status\":\"Completed\""
$apex_system_test_status_processing = "\"Status\":\"Processing\""
$apex_system_test_status_preparing = "\"Status\":\"Preparing\""
$apex_system_test_status_queued = "\"Status\":\"Queued\""
$apex_system_test_status_holding = "\"Status\":\"Holding\""
$apex_system_test_status_query = "SELECT Status, ApexClassId, ParentJobId FROM ApexTestQueueItem ORDER BY SystemModstamp DESC LIMIT 1"
$apex_system_test_method_status_query = "SELECT MethodName,Outcome FROM ApexTestResult WHERE ApexClassId='{0}' AND  AsyncApexJobId='{1}'"
$apex_keyword_attributes = "attributes"
$apex_test_status_fail = "Fail"
$run_with_enable_support_access = true
#############################
# Base Data Page Methods
#############################
	def APEX.visit_base_date_page 
		gen_wait_until_object $tab_all_tabs_locator
		url_prefix = page.current_url.split('/')[0]
		url_host = page.current_url.split('/')[2]
		data_url = url_prefix +"//"+url_host+"/apex/BaseDataJob"
		data_url = data_url.sub("//ffa","//c")
		visit data_url
		gen_wait_until_object $apex_hold_base_data_button
	end 
#########################################
# Methods to execute anonymous commands 
#########################################
	def APEX.execute_script command
		page.has_css?($tab_all_tabs_locator)
		SF.tab $tab_basedatajob		
		SF.execute_script do
			gen_wait_until_object $apex_hold_base_data_button
			find($apex_command_textarea).set command
			find($apex_execute_button).click	
		end
		gen_wait_until_object $apex_execute_button
	 end 	 
	 
#########################################
# Methods to execute anonymous commands , command will contain array of apex scripts 
# @command_list - list of commands to execute on basedatajob page.
# @waitForSeconds - Wait for N seconds before retrying to execute the script again when failed. default, it will wait for 0 seconds.
#########################################
	def APEX.execute_commands command_list, waitForSeconds = 0
		begin 
			page.has_css?($tab_all_tabs_locator)
			SF.tab $tab_basedatajob
			SF.execute_script do
				gen_wait_until_object $apex_hold_base_data_button
				if command_list.length > 0 then
					command_list.each do |item|
						SF.retry_script_block do
							puts "Executing script: #{item}"
							find($apex_command_textarea).set item
							find($apex_execute_button).click
							gen_wait_until_object $apex_execute_button
							query_result = APEX.get_execution_status_message
							SF.log_info query_result
							if(query_result != $apex_script_executed_successfully_message_value)					
								raise "Error in execution -" + query_result
							end
							if waitForSeconds > 0
								sleep waitForSeconds
							end
						end
					end
				end
			end
		end
	 end 

#########################################
# Methods to enable support access on org 
#########################################	 
	# Enable support access to delete data without any dependency error.
	def APEX.enable_support_access
		enable_support_access_on_org = ""
		if(ORG_TYPE == UNMANAGED) 
			enable_support_access_on_org += "CODAContext.enableSupportAccess();"
		end
		return enable_support_access_on_org
	end

#########################################
# Methods to diable support access on org 
#########################################		
	# Disable support access on org.
	# This method need to be called mandatory if any of the script is enabling support access on org using APEX.enable_support_access method.
	def APEX.disable_support_access
		disable_support_access_on_org = ""
		if(ORG_TYPE == UNMANAGED) 
			disable_support_access_on_org += "CODAContext.disableSupportAccess();"
		end
		return disable_support_access_on_org
	end
	
#########################################
# Methods to purge data of object  
# @obj_list = list of object which data need to be purged/delete.
#########################################	
	def APEX.purge_object obj_list
		FFA.delete_data_with_sda_access do
			purge_query = ""
			purge_query+= APEX.enable_support_access
			object_purge_query = "delete [SELECT Id FROM #{ORG_PREFIX}#{$sf_param_substitute}];"
			if obj_list.length > 0 then
				obj_list.each do |item|
					purge_query+=object_purge_query.sub($sf_param_substitute , item)
				end
			end
			purge_query+= APEX.disable_support_access
			APEX.execute_commands [purge_query] 
		end
	end
#########################################
# Methods to execute SOQL query 
#########################################
    def APEX.execute_soql soql_query
        page.has_css?($tab_all_tabs_locator)
        SF.tab $tab_basedatajob
        SF.execute_script do
			gen_wait_until_object $apex_hold_base_data_button
			find($apex_command_textarea).set soql_query
			find($apex_execute_soql_button).click
			gen_wait_until_object $apex_execute_soql_button
		end
    end    
#########################################
# Method to get execution status message
#########################################	 
	def APEX.get_execution_status_message
		SF.execute_script do
			return find($apex_command_executed_successfully_message_selector).text
		end
	end
	
#########################################
# Method to call a system test class and waits till it completes the execution
#########################################	 
	def APEX.call_system_test_class  system_test_class_name
	    add_test_to_queue = $apex_script_add_system_test_to_queue.sub($sf_param_substitute, system_test_class_name)
		SF.execute_script do
			APEX.execute_script add_test_to_queue
			query_result = APEX.get_execution_status_message
			SF.log_info query_result
			if(query_result != $apex_script_executed_successfully_message_value)					
				raise "Error in execution -" + query_result
			end
			#wait for system test to complete
			APEX.wait_for_system_test_to_complete			
		end
		#read test result
		test_result = APEX.get_test_result
		puts "System Test methods Passed-" + test_result[0].size().to_s
		puts "System Test methods Failed-" + test_result[1].size().to_s
		
		if(test_result[1].size() > 0)
			puts "Following System Test methods failed-" +  test_result[1].size().to_s + " " + 	test_result[1].to_s	
			raise "Error in System Test methods execution "	
		end
		
		return test_result			
	end
	
############################################
#  method wait for system test to complete.
############################################
	def APEX.wait_for_system_test_to_complete
		is_status_complete = false
		while(!is_status_complete) do
			SF.wait_less
			# View apex job page as per lightening org type.
			SF.execute_script do
				APEX.execute_soql $apex_system_test_status_query
				query_result = APEX.get_execution_status_message
				SF.log_info  query_result

				if ((query_result.include? $apex_system_test_status_processing) || (query_result.include? $apex_system_test_status_holding) || (query_result.include? $apex_system_test_status_queued) || (query_result.include? $apex_system_test_status_preparing))
					SF.log_info "waiting for system test to complete."									
				elsif(query_result.include? $apex_system_test_status_completed)	
					SF.log_info "system test class executed successfully."
					is_status_complete = true
				else 
					raise "Error in test case execution " + query_result
				end
			end
		end
		return true
	end
	
	#########################################
	# read field and values from query result , Can return multiple field values from single/multiple rows 
	# fields_to_get - Array of field Name 
	#########################################
	def APEX.get_field_values_from_result fields_to_get
		#read query result
		soql_query_result = APEX.get_execution_status_message
		return_values = Array.new
		row_index = 1
		#split by rows and store it in array
		soql_output_rows = soql_query_result.split($apex_keyword_attributes)
		
		#Iterate all rows from query result
		soql_output_rows.each do |soql_output_row|
			#split each row into its fields and vaues 
			field_values = soql_output_row.split(",")
			all_field_values = ""
			#Iterate each field to read from a row
			fields_to_get.each do |field_to_get|		
				#Iterate each field of a row				
				field_values.each do |field_val|
					#check for field_to_get in each field retrieved
					if(field_val.include? field_to_get )
						#if found remove/replace all special chars from value
						val = field_val.sub(field_to_get, "").gsub(":","").gsub(",","").gsub("\"","")
						val = val.gsub("[","").gsub("]","").gsub("{","").gsub("}","")
						if(all_field_values != "")
							all_field_values += ","
						end							
						all_field_values += field_to_get + "~||~" + val						
					end 
				end				
			end
			#add field - value in a array
			if(all_field_values != "")
				return_values.push(all_field_values)
			end 
		end
		return return_values
	end
	
	#########################################
	# get ApexClassId from query result 
	#########################################	
	def APEX.get_apex_class_id		
		fields_to_get = [ $ffa_field_apex_class_id ]
		field_values = APEX.get_field_values_from_result fields_to_get
		SF.log_info "apex class Id-" +field_values[0]
		apex_class_id = field_values[0].split("~||~")[-1]
		return apex_class_id			
	end
	
	#########################################
	# get ParentJobId from query result 
	#########################################
	def APEX.get_parent_job_Id
		fields_to_get = [ $ffa_field_parent_job_Id ]
		field_values = APEX.get_field_values_from_result fields_to_get
		SF.log_info "parent_job_Id-" +field_values[0]
		parent_job_Id = field_values[0].split("~||~")[-1]
		return parent_job_Id			
	end
	
	#########################################
	# Get test result 
	# returns list of arrays on position 0- list of Passed test , on Position 1 list of failed test methods
	#########################################
	def APEX.get_test_result	
		#read query result
		#soql_query_result = APEX.get_execution_status_message
		apex_class_id = APEX.get_apex_class_id
		parent_job_Id = APEX.get_parent_job_Id
		test_result_array = [ Array.new, Array.new ]
				
		#get Test methods result using apex_class_id and parent_job_Id
		APEX.execute_soql $apex_system_test_method_status_query.sub("{0}", apex_class_id).sub("{1}", parent_job_Id)
				
		#read Test methods status from query result
		fields_to_get = [ $ffa_field_method_name, $ffa_field_outcome ]
		all_test_result = APEX.get_field_values_from_result fields_to_get
		#get all test methods status and keep it in arrays
		all_test_result.each do |test_result|
			SF.log_info test_result						
			#if any test method status is Fail , add it to failed array , else add it in pass array
			if (test_result.include? $apex_test_status_fail)
				test_result_array[1].push(test_result);
			else
				test_result_array[0].push(test_result);
			end			
		end		
		return test_result_array
	end	
	
	#########################################
	# get single  value from query result 
	#########################################	
	def APEX.get_field_value_from_soql_result field_name		
		fields_to_get = [field_name]
		field_values = APEX.get_field_values_from_result fields_to_get
		SF.log_info " "+field_name+"~||~" +field_values[0]
		field_value = field_values[0].split("~||~")[-1]
		return field_value			
	end
	
	
end
