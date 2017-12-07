 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module SELDEF  
extend Capybara::DSL
#############################
# Selection Definition Helper
#############################
#selector
$seldef_selection_definition_name = "input[id$='selectionName']"
$seldef_master_object_picklist = "select[id$='HeaderObjectField']"
$seldef_detail_object_picklist = "select[id$='LineItemObjectField']"
$seldef_selection_definition_name_value = "span[id*='selectionName']"
#Labels
$seldef_msg_updating_fields = "Updating Fields"
#Methods
	# set selection definition name
	def SELDEF.set_selection_definition_name selection_name
		SF.execute_script do
			find($seldef_selection_definition_name).set selection_name
		end
	end
	# select value from master object piclist
	def SELDEF.select_master_object value
		SF.retry_script_block do 
			SF.execute_script do
				master_obj_picklist_name = find($seldef_master_object_picklist)[:name]
				select(value, :from => master_obj_picklist_name)
				gen_tab_out $seldef_master_object_picklist
				gen_wait_less
				FFA.wait_page_message $seldef_msg_updating_fields
			end
		end
	end
	# select value from detail object piclist
	def SELDEF.select_detail_object value
		SF.retry_script_block do 
			SF.execute_script do
				detail_obj_picklist_name = find($seldef_detail_object_picklist)[:name]
				select(value, :from => detail_obj_picklist_name)
				gen_tab_out $seldef_detail_object_picklist
				FFA.wait_page_message $seldef_msg_updating_fields
			end
		end
	end
	
#Get Methods
	# get selection definition name
	def SELDEF.get_selection_definition_name
		SF.execute_script do
			find($seldef_selection_definition_name_value).text
		end
	end
end 
