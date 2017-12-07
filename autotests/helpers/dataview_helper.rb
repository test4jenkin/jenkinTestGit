 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.

DATAVIEW_COLUMN_FIELD_SELECTION = 1
DATAVIEW_COLUMN_OBJECT_SOURCE = 2
DATAVIEW_COLUMN_OBJECT_TRANSPOSE = 3
DATAVIEW_COLUMN_OBJECT_FIELD = 4
DATAVIEW_COLUMN_FIELD_NAME = 5
DATAVIEW_COLUMN_COMMON_NAME = 6
DATAVIEW_COLUMN_SELECTABLE = 7
DATAVIEW_COLUMN_PRESENTABLE = 8
DATAVIEW_COLUMN_AGGREGATABLE = 9
DATAVIEW_COLUMN_REVERSABLE = 10
DATAVIEW_COLUMN_KEY = 12
DATAVIEW_TRANSPOSE_SOURCE = 3
DATAVIEW_TRANSPOSE_OBJECT_FIELD = 4
module DataView
extend Capybara::DSL
###################################################
# Data View  
###################################################
# aliases 
$dataview_tab_fields= "Fields"
$dataview_tab_joins = "Joins"
$dataview_tab_actions = "Actions"
$dataview_column_checked = "f-grid-checkcolumn f-grid-checkcolumn-checked"
$dataview_column_not_checked = "f-grid-checkcolumn"

# buttons 
$dataview_add = "a[data-ffid=addNewLineButton]"
$dataview_add_all = "a[data-ffid=addAllFieldsButton]"
$dataview_add_all_ids = "a[data-ffid=addAllIdsButton]"
$dataview_delete = "a[data-ffid=deleteFieldsButton]"
$dataview_show_ids = "[data-ffid='showIds'] input"
$dataview_radio_relationship = "div[data-ffid='relationshipRadio'] [id*='radio'] input"
$dataview_radio_relationship_span = "div[data-ffid='relationshipRadio'] [id*='radio'] span"
$dataview_radio_lookup = "[data-ffid=lookupRadio] input"
$dataview_lookup_relationship_button = "a[data-ffid=addJoinButton]"
$dataview_add_action = "a[data-ffid=addActionButton]"
# objects 
$dataview_name = "[data-ffid=Name] input"
$dataview_primary_object  = "[data-ffid=StartingObject] input"
$dataview_action_name = "div[data-ffid=tabPanel] [data-ffid=Name] input"
$dataview_action_description = "[data-ffid=Description] input"
$dataview_action_parameter = "[data-ffid=Parameter] input"
$dataview_action_class = "[data-ffid=ApexClass] input"
$dataview_node_object = "div[data-qtip='"+$sf_param_substitute+"']"
$dataview_radio_lookup = "[data-ffid=lookupRadio] input"
$dataview_join_to	= "[data-ffid=postboxJoinEditor] input"
$dataview_join_name	= "[data-ffid=joinNameField] input"
$dataview_select_all_fields = "div[data-ffid=fieldSelectionColumn] [class=f-column-header-text]"
$dataview_grid = "div[data-ffxtype=tableview]" # tr:nth-of-type(1) td:nth-of-type(1)"
$dataview_grid_all_rows = $dataview_grid+" table tr"


$dataview_column_input_source = "div[data-ffid=fieldGrid] [data-ffid=sourceColumnEditor] input"
$dataview_column_input_object_field = "div[data-ffid=fieldGrid] [data-ffid=fieldColumnEditor] input"
$dataview_column_input_field_name = "div[data-ffid=fieldGrid] [data-ffid=Name] input[name=Name]"
$dataview_column_input_common_name = "div[data-ffid=fieldGrid] [data-ffid=CommonName] input[name=CommonName]"

$dataview_field_common_name_picklist= "Common Name"
$dataview_field_common_name_delete_pattern = "//th[text()='"+$sf_param_substitute+"']/ancestor::tr[1]/td[1]/a[2]"
$dataview_field_common_name_textarea = "textarea[title='Common Name']"
$dataview_field_new_picklist_value_button = "input[title='New Values']"

# Transpose window 
# buttons 
$dataview_tranpose_window = "div[data-ffid=transposeItemWindow]"
$dataview_tranpose_window_cancel_button = "a[data-ffid=cancelTransposeItemButton]"
$dataview_tranpose_window_ok_button = "a[data-ffid=okTransposeItemButton]"
$dataview_tranpose_add  = "a[data-ffid=addTransposeItemButton]"
$dataview_tranpose_delete  = "a[data-ffid=deleteTransposeItemButton]"
# Objects 
$dataview_tranpose_field = "[data-ffid=transposeItemField] input"
$dataview_tranpose_value = "[data-ffid=transposeItemValue] input"
$dataview_tranpose_source = "[data-ffid=transposeItemSourceEditor] input"
$dataview_tranpose_object_field = "[data-ffid=transposeItemFieldEditor] input"
$dataview_tranpose_grid = "div[data-ffid=transposeItemGrid] div[data-ffxtype=tableview] table" # tr:nth-of-type(1) td:nth-of-type(1)"

# Methods 

	# click tab fields 
	def DataView.tab_fields 
		FFA.click_grid_tab_by_label $dataview_tab_fields
	end 
	# set the name of data view 
	def DataView.set_name data_view_name
		SF.execute_script do 
			page.has_css?($dataview_name)
			find($dataview_name).set data_view_name
		end
	end
	# set the primary object on data view 
	def DataView.set_primary_object data_view_primary_object
		SF.execute_script do
			data_view_primary_object = FFA.prefix_custom_object data_view_primary_object
			find($dataview_primary_object).set data_view_primary_object
			find($gen_f_list_plain).find("li",:text => data_view_primary_object).click
			gen_tab_out $dataview_primary_object
			FFA.wait_for_popup_msg_sync $ffa_msg_loading_metadata
		end
	end

	# choose the radio button Relationship
	def DataView.choose_relationship
		SF.execute_script do
			begin 
				find($dataview_radio_relationship).click
			rescue
				find($dataview_radio_relationship_span).click
			end
		end
	end 
	# choose the radio button lookup 
	def DataView.choose_lookup
		SF.execute_script do
			find($dataview_radio_lookup).click
		end
	end 
	# set the join to field on data view joins tab
	def DataView.set_join_to data_view_join_to
		data_view_join_to = FFA.prefix_custom_object data_view_join_to 
		SF.execute_script do
			find($dataview_join_to).set data_view_join_to
			gen_wait_less
			gen_tab_out $dataview_join_to
		end
	end
	# set the join name field on data view joins tab
	def DataView.set_join_name data_view_join_name
		SF.execute_script do
			find($dataview_join_name).set data_view_join_name
			gen_tab_out $dataview_join_name
		end
	end
	# Click button Add Look / Add Relationship on data view join tab
	def DataView.click_lookup_relationship_button
		SF.execute_script do
			find($dataview_lookup_relationship_button).click
		end
		gen_wait_more
	end
	# Save a data view
	def DataView.save
		FFA.toolbar_save
		if page.has_no_css?($page_sencha_popup)	# Condition to check if there is no pop up to add with/without IDs, than wait for saving message.
			FFA.wait_for_popup_msg_sync $ffa_msg_saving
		end
		gen_wait_less
	end
	# Save a data view with Add all id or without ids by passing the true or false for warning message 
	
	def DataView.save_with_ids save_with_id 
		FFA.toolbar_save
		SF.execute_script do
			if  save_with_id == false 
				FFA.sencha_popup_click_no # Save without ID's
			elsif save_with_id == true 
				FFA.sencha_popup_click_yes # Add Ids and Save on id warning
			end 
			FFA.wait_for_popup_msg_sync $ffa_msg_saving
		end
		gen_wait_less
	end

	# open a dataview once saved 
	def DataView.open data_view_name 
		gen_click_link_and_wait data_view_name
	end
	# Buttons 
	# select check box for selecting all the rows on the data view Field tab 
	def DataView.select_all_fields_checkbox
		find($dataview_select_all_fields).click
		gen_wait_more 
	end
	# click add button on Field tab
	def DataView.click_add_button 
		SF.execute_script do
			find($dataview_add).click
		end
		gen_wait_less
	end
	# click Add All button on Field tab
	def DataView.click_addall_button 
		find($dataview_add_all).click
		gen_wait_more 
	end
	# click Add All ID's button on Field tab
	def DataView.click_addall_ids_button 
		find($dataview_add_all_ids).click
		gen_wait_more 
	end
	# click Delete button on Field tab
	def DataView.click_delete_button
		find($dataview_delete).click
		gen_wait_less
	end
	# Click on Show Ids Check Box 
	def DataView.click_show_ids
		find($dataview_show_ids).click
		gen_wait_less
	end

	# click add action button on action tab
	def DataView.click_add_action 
		find($dataview_add_action).click
		gen_wait_less
	end
	# sort by column header just by clicking on it 
	def DataView.sort_by_column sort_by_column_header_name
		FFA.click_tab_by_label sort_by_column_header_name
		gen_wait_less
	end 
	
	# set the source
	def DataView.set_source source
		SF.execute_script do
			find($dataview_column_input_source).set source
			gen_tab_out $dataview_column_input_source
		end
	end 
	# set the object field 
	def  DataView.set_object_field row , object_field
		SF.execute_script do
			find("#{$dataview_grid} table:nth-of-type(#{row}) tr td:nth-of-type(#{DATAVIEW_COLUMN_OBJECT_FIELD})").click 
			object_field = FFA.prefix_custom_object object_field
			find($dataview_column_input_object_field).set object_field
			find($gen_f_list_plain).find(:xpath,"//li[text()='#{object_field}']").click
			sleep 1
			gen_send_key  $dataview_column_input_object_field , :tab
		end
	end 
	
	# Field tab methods 
	# select the field / row  
	def DataView.select_field search_text,col_to_search
		search_text = FFA.prefix_custom_object search_text
		row = DataView.find_data_in_col search_text ,col_to_search
		find("#{$dataview_grid} table:nth-of-type(#{row}) tr td:nth-of-type(#{DATAVIEW_COLUMN_FIELD_SELECTION})").click 
	end
	# open the transpose window
	def DataView.open_transpose search_text,col_to_search
		search_text = FFA.prefix_custom_object search_text
		row = DataView.find_data_in_col search_text ,col_to_search
		find("#{$dataview_grid} table:nth-of-type(#{row}) tr td:nth-of-type(#{DATAVIEW_COLUMN_OBJECT_TRANSPOSE}) img:last-of-type").click 
		page.has_css?($dataview_tranpose_window )
	end
	# cancel on transpose 
	def DataView.transpose_cancel_button 
		find($dataview_tranpose_window_cancel_button).click
	end
	# Add button on transpose
	def DataView.transpose_add_button 
		find($dataview_tranpose_add).click
	end
	# Delete button on transpose
	def DataView.transpose_delete_button 
		find($dataview_tranpose_delete).click
	end
	# ok on transpose 
	def DataView.transpose_ok_button 
		find($dataview_tranpose_window_ok_button).click
	end
	# set the field value
	def DataView.transpose_set_field field_name 
			find($dataview_tranpose_field).set field_name
			gen_tab_out $dataview_tranpose_field
	end 
	# set the value field 
	def DataView.transpose_set_value value 
		find($dataview_tranpose_value).set value
		gen_tab_out $dataview_tranpose_value
	end 
	# set the transpose field 
	def DataView.transpose_set_source row_number , source_value
			# check if input field is already displayed.
			input_field_available = gen_is_object_visible $dataview_tranpose_source
			# If input field is not available,click on field to make input field available.
			if(!input_field_available)
				find($dataview_tranpose_grid + ":nth-of-type(#{row_number})"+" tr td:nth-of-type(#{DATAVIEW_TRANSPOSE_SOURCE})").click 
			end
			find($dataview_tranpose_source).set source_value
			gen_tab_out $dataview_tranpose_source
	end 
	# set the object field
	def DataView.transpose_set_object_field row_number , object_field
			# check if input field is already displayed.
			input_field_available = gen_is_object_visible $dataview_tranpose_object_field
			# If input field is not available,click on field to make input field available.
			if(!input_field_available)
				find($dataview_tranpose_grid + ":nth-of-type(#{row_number})"+" tr td:nth-of-type(#{DATAVIEW_TRANSPOSE_OBJECT_FIELD})").click 
			end
			find($dataview_tranpose_object_field).set object_field
			sleep 1
			gen_tab_out $dataview_tranpose_object_field

	end 
	# add transposed field in one go
	def DataView.transpose_add_field row_num , value , source_value ,object_field
			DataView.transpose_add_button 
			DataView.transpose_set_value value
			DataView.transpose_set_source row_num, source_value
			DataView.transpose_set_object_field row_num, object_field
	end 
	# set the selectable and presentable for the given column 
	def DataView.set_selectable_presentable search_text,col_to_search , field_name, selectable,presentable 
		search_text = FFA.prefix_custom_object search_text
		row = DataView.find_data_in_col  search_text ,col_to_search
		# click in the field name and make it editable
		if field_name != nil
			find("#{$dataview_grid} table:nth-of-type(#{row}) tr td:nth-of-type(#{DATAVIEW_COLUMN_FIELD_NAME})").click 
			# set the value for Field name 
			find($dataview_column_input_field_name).set field_name
		end 

		if selectable == true 
			find("#{$dataview_grid} table:nth-of-type(#{row}) tr td:nth-of-type(#{DATAVIEW_COLUMN_SELECTABLE})").click 
		end 
		if presentable  == true 
			find("#{$dataview_grid} table:nth-of-type(#{row}) tr td:nth-of-type(#{DATAVIEW_COLUMN_PRESENTABLE})").click 
		end 
	end
# set the reversable for column
	def DataView.set_reversable search_text,col_to_search , select 
		search_text = FFA.prefix_custom_object search_text
		row = DataView.find_data_in_col search_text ,col_to_search
		if select == true 
			find("#{$dataview_grid} table:nth-of-type(#{row}) tr td:nth-of-type(#{DATAVIEW_COLUMN_REVERSABLE})").click 
		end 
	end
# set the aggregatable for column
	def DataView.set_aggregatable search_text,col_to_search , select 
		search_text = FFA.prefix_custom_object search_text
		row = DataView.find_data_in_col search_text ,col_to_search
		if select == true 
			find("#{$dataview_grid} table:nth-of-type(#{row}) tr td:nth-of-type(#{DATAVIEW_COLUMN_AGGREGATABLE})").click 
		end 
	end
# set the key for column
	def DataView.set_key search_text,col_to_search , select 
		search_text = FFA.prefix_custom_object search_text
		row = DataView.find_data_in_col search_text ,col_to_search
		if select == true 
			find("#{$dataview_grid} table:nth-of-type(#{row}) tr td:nth-of-type(#{DATAVIEW_COLUMN_KEY})").click 
		end 
	end
	# Used this if you have added all the fields a
	# set the whole filed in one go
	def DataView.set_field search_text,col_to_search , field_name,common_name,selectable,presentable,aggregatable,reversible,key 
		search_text = FFA.prefix_custom_object search_text
		row = DataView.find_data_in_col  search_text ,col_to_search
		if field_name != nil
			find("#{$dataview_grid} table:nth-of-type(#{row}) tr td:nth-of-type(#{DATAVIEW_COLUMN_FIELD_NAME})").click 
			find($dataview_column_input_field_name).set field_name
		end 
		if common_name != nil
			find("#{$dataview_grid} table:nth-of-type(#{row}) tr td:nth-of-type(#{DATAVIEW_COLUMN_COMMON_NAME})").click 
			find($dataview_column_input_common_name).set common_name
		end 
		if selectable == true 
			find("#{$dataview_grid} table:nth-of-type(#{row}) tr td:nth-of-type(#{DATAVIEW_COLUMN_SELECTABLE})").click 
		end 
		if presentable  == true 
			find("#{$dataview_grid} table:nth-of-type(#{row}) tr td:nth-of-type(#{DATAVIEW_COLUMN_PRESENTABLE})").click 
		end 
		
		if aggregatable == true 
			find("#{$dataview_grid} table:nth-of-type(#{row}) tr td:nth-of-type(#{DATAVIEW_COLUMN_AGGREGATABLE})").click 
		end 

		if reversible == true 
			find("#{$dataview_grid} table:nth-of-type(#{row}) tr td:nth-of-type(#{DATAVIEW_COLUMN_REVERSABLE})").click 
		end 
		if key == true 
			find("#{$dataview_grid} table:nth-of-type(#{row}) tr td:nth-of-type(#{DATAVIEW_COLUMN_KEY})").click 
		end 
	end
	
	def DataView.add_field row,source,object_field,field_name,common_name,selectable,presentable,aggregatable,reversible,key 
		DataView.click_add_button 
		DataView.set_source source
		DataView.set_object_field row , object_field
		SF.execute_script do
			if field_name != nil
				# check if input field is already available
				input_field_available = gen_is_object_visible $dataview_column_input_field_name
				# click to enable input field
			    if (!input_field_available)
					find("#{$dataview_grid} table:nth-of-type(#{row}) tr td:nth-of-type(#{DATAVIEW_COLUMN_FIELD_NAME})").click 
				end
				find($dataview_column_input_field_name).set field_name
			end 
			if common_name != nil
				# check if input field is already available
				input_field_available = gen_is_object_visible $dataview_column_input_common_name
				# click to enable input field
			    if (!input_field_available)
					find("#{$dataview_grid} table:nth-of-type(#{row}) tr td:nth-of-type(#{DATAVIEW_COLUMN_COMMON_NAME})").click
				end
				find($dataview_column_input_common_name).set common_name
			end 
			if selectable == true 
				find("#{$dataview_grid} table:nth-of-type(#{row}) tr td:nth-of-type(#{DATAVIEW_COLUMN_SELECTABLE})").click 
			end 
			if presentable  == true 
				find("#{$dataview_grid} table:nth-of-type(#{row}) tr td:nth-of-type(#{DATAVIEW_COLUMN_PRESENTABLE})").click 
			end 
			
			if aggregatable == true 
				find("#{$dataview_grid} table:nth-of-type(#{row}) tr td:nth-of-type(#{DATAVIEW_COLUMN_AGGREGATABLE})").click 
			end 

			if reversible == true 
				find("#{$dataview_grid} table:nth-of-type(#{row}) tr td:nth-of-type(#{DATAVIEW_COLUMN_REVERSABLE})").click 
			end 
			if key == true 
				find("#{$dataview_grid} table:nth-of-type(#{row}) tr td:nth-of-type(#{DATAVIEW_COLUMN_KEY})").click 
			end
		end
	end 

	def DataView.add_join_to_node node_join_name , node_obj_name , join_type , join_to , join_name
		DataView.choose_node node_join_name , node_obj_name
		DataView.add_join  join_type , join_to , join_name
	end 

	def DataView.add_join_to_primary primary_object_name , join_type , join_to , join_name
		DataView.choose_primary_node primary_object_name
		DataView.add_join  join_type , join_to , join_name
	end 

	def DataView.add_join  join_type , join_to , join_name
		if join_type != nil 
			if join_type == "lookup"
				DataView.choose_lookup
			elsif join_type == "relationship"
				DataView.choose_relationship
			end 
		end 
		DataView.set_join_to join_to
		if join_name !=nil
			DataView.set_join_name join_name
		end 
		DataView.click_lookup_relationship_button
	end 
	# on the data view grid find and return row with data specified in search_text and col_to_search. 
	def DataView.find_data_in_col search_text, col_to_search 
		allrows  = all("#{$dataview_grid} tr")
		row = 1 
		while  row <= allrows.count
			cellvalue = find("#{$dataview_grid} table:nth-of-type(#{row}) tr td:nth-of-type(#{col_to_search})").text 
			if search_text == cellvalue
				break
			end
			row += 1
		end 
		return row 
	end 

	def DataView.get_column_status row , col , status 
		return page.has_css?("div[data-ffxtype=tableview] table:nth-of-type(#{row}) tr td:nth-of-type(#{col}) img[class='#{status}']")
	end 
		
	# join tab methods 
	def DataView.tab_join
		FFA.click_grid_tab_by_label $dataview_tab_joins 
	end

	def DataView.choose_primary_node node_name
		node_name = FFA.prefix_custom_object node_name
		node_name = "Primary Object (#{node_name})"
		find(:xpath , "//div/label[text()='#{node_name}']").click
	end 

	# On the join tab select the node by giving the join name and the obj name (bit in brackets)
	def DataView.choose_node node_join_name, node_obj_name
		SF.execute_script do
			node_name = FFA.prefix_custom_object node_obj_name
			if node_join_name != nil
				node_name = "#{node_join_name} (#{node_name})"
			end 	
			find($dataview_node_object.sub($sf_param_substitute , node_name)).click
		end
	end 
	
	# set action name
	def DataView.set_action_name action_name
		find($dataview_action_name).set action_name
		gen_tab_out $dataview_action_name
		gen_tab_out $dataview_action_description
		gen_tab_out $dataview_action_parameter
	end 
	def DataView.set_action action
		find($dataview_action_class).set action
		gen_tab_out $dataview_action_class
	end	
	#add actions
	def DataView.add_action action_name , apex_class
		DataView.click_add_action
		if action_name !=nil
			DataView.set_action_name action_name
		end
		DataView.set_action apex_class
	end
	
###############################################
# Add value in dataview field Object ->Common name picklist
## add_value= value of common name which need to be added
###############################################
	def DataView.add_new_value_in_common_name_picklist add_value
		SF.admin $sf_setup
		# If org is lightning, search the link and click on it.
		if (SF.org_is_lightning)
			SF.set_global_search $sf_setup_create_objects
		else
			SF.click_link $sf_setup_create
		end
		SF.click_link $sf_setup_create_objects
		SF.wait_for_search_button
		if (SF.org_is_lightning)
			SF.retry_script_block do
				page.has_xpath?($sf_lightning_setup_object_manager_search_textbox)
				find(:xpath , $sf_lightning_setup_object_manager_search_textbox).set $ffa_object_dataview_field
				page.has_link?($ffa_object_dataview_field)
			end
		end
		page.has_xpath?($ffa_object_dataview_field_locator)
		find(:xpath,$ffa_object_dataview_field_locator).click
		page.has_link?($dataview_field_common_name_picklist)
		SF.click_link $dataview_field_common_name_picklist
		SF.retry_script_block do
			SF.execute_script do 
				find($dataview_field_new_picklist_value_button).click
			end
		end
		SF.retry_script_block do
			SF.execute_script do 
				find($dataview_field_common_name_textarea).set add_value
			end
		end
		SF.click_button_save
	end	
###############################################
# Delete value added in dataview field Object ->Common name picklist
## delete_value= value of common name which need to be deleted
###############################################	
	def DataView.delete_value_from_common_name_picklist delete_value
		SF.admin $sf_setup
		SF.click_link $sf_setup_create
		SF.click_link $sf_setup_create_objects
		SF.wait_for_search_button
		if (SF.org_is_lightning)
			SF.retry_script_block do
				page.has_xpath?($sf_lightning_setup_object_manager_search_textbox)
				find(:xpath , $sf_lightning_setup_object_manager_search_textbox).set $ffa_object_dataview_field
				page.has_link?($ffa_object_dataview_field)
			end
		end
		page.has_xpath?($ffa_object_dataview_field_locator)
		find(:xpath,$ffa_object_dataview_field_locator).click
		SF.wait_for_search_button
		SF.click_link $dataview_field_common_name_picklist
		SF.execute_script do
			find(:xpath ,$dataview_field_common_name_delete_pattern.sub($sf_param_substitute,delete_value)).click
			SF.alert_ok
		end
	end	
end 

