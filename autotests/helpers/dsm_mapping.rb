 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module DSM
extend Capybara::DSL
# DSM Selectors
###################################################
#DSM Mappings
$dsm_mapping_add_mapping_master_object = "(//*[@value='Add Mapping'])[1]"
$dsm_mapping_source_object_dropdown = "(//option[text()='"+$sf_param_substitute+"'] //..)[1]"
$dsm_mapping_source_object_dropdown_option = "//option[text()='"+$sf_param_substitute+"']"
$dsm_mapping_target_object_dropdown = "(//option[text()='"+$sf_param_substitute+"'] //..)[last()]"
$dsm_mapping_target_object_dropdown_option = "(//option[text()='"+$sf_param_substitute+"'])[last()]"
$dsm_mapping_master_object_table = "//h3[text()='Master Object']/ancestor::div[2]/following::table[1]/tbody/tr"
$dsm_mapping_master_object_table_row = $dsm_mapping_master_object_table + "[last()]"
$dsm_mapping_master_object_source_picklist = "//h3[text()='Master Object']/ancestor::div[2]/following::table[1]/tbody/tr[last()]/td[2]"
$dsm_mapping_master_object_target_picklist = "//h3[text()='Master Object']/ancestor::div[2]/following::table[1]/tbody/tr[last()]/td[3]"
$dsm_mapping_dropdown = "select[name*=':form:']"
	
	# Methods 
	#click button add mapping master object
	def DSM.click_button_add_mapping_master_object
		find(:xpath,$dsm_mapping_add_mapping_master_object).click
		SF.wait_for_search_button
	end
	
	#Add Master object mappings
	#source_option_name - Source option name dropdownlist (left)
	#target_option_name - Target option name in dropdownlist (right)
	def DSM.add_master_object_mapping source_option_name, target_option_name
		DSM.click_button_add_mapping_master_object
		sleep 2 #wait to open drop down list
		SF.retry_script_block do 
			within(find(:xpath, $dsm_mapping_master_object_table_row)) do		
				#select source object
				within(find(:xpath, $dsm_mapping_master_object_source_picklist)) do 
					puts "inside it "
					picklist_name = find($dsm_mapping_dropdown)[:name]
					puts picklist_name
					select(source_option_name , :from => picklist_name)				
				end
				within(find(:xpath, $dsm_mapping_master_object_target_picklist)) do 
					puts "inside it 2"
					picklist_name = find($dsm_mapping_dropdown)[:name]
					puts picklist_name
					select(target_option_name , :from => picklist_name)								
				end			
			end
		end
	end	
	
	#if master object mapping exist return true else false
	def DSM.is_master_object_mapping_exists source_option, target_option
		return (page.has_text?(source_option) && page.has_text?(target_option))		
	end
end