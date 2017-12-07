 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module RCP
extend Capybara::DSL

# objects
$rcp_list_view = "table[id$='sectionItems:theTable']"
$rcp_search_input = "[id$='sectionItems:searchText']"
$rcp_name = "[data-ffid=Name] input"
$rcp_driving_entity_table = "[data-ffid=DrivingEntity]"
$rcp_driving_entity = "[data-ffid=DrivingEntity] input"
$rcp_driving_entity_question = $rcp_driving_entity_table + " + div"
$rcp_radio_small = "[data-ffid=rcpSizeBtnGroup] a:nth-of-type(1)"
$rcp_radio_medium = "[data-ffid=rcpSizeBtnGroup] a:nth-of-type(2)"
$rcp_radio_large = "[data-ffid=rcpSizeBtnGroup] a:nth-of-type(3)"
$rcp_radio_pressed = "f-btn-pressed"
$rcp_apptitle = "div[data-ffid='appTitle']"
$rcp_tab_new =  "[data-ffid=addTab]"
$rcp_tab_new_name =  "a[data-ffxtype=tab]:last-of-type span[class='f-tab-inner f-tab-inner-center']"
$rcp_tab_close = "a[data-ffxtype=tab]:nth-of-type(nnn) > span[class=f-tab-close-btn]"
$rcp_tabs = "a[data-ffxtype=tab]"
$rcp_current_tab = "div[data-ffxtype=rcp-tab]:not([style*=none])"
$rcp_current_tab_name = "a[data-ffxtype=tab]:nth-of-type(nnn) span[class='f-tab-inner f-tab-inner-default']"
$rcp_current_tab_table = $rcp_current_tab + " table " # tr:nth-of-type(1) td:nth-of-type(3) div[data-ffxtype=rcp-component]

$rcp_tab_panel = "div[data-ffid=tabpanel]"
$rcp_component = "div[data-ffxtype=rcp-component]"
$rcp_current_tab_components	 = $rcp_current_tab + " " + $rcp_component
$rcp_component_invalid_config =  $rcp_current_tab_components + "[class*='RCP-invalid-config']"
$rcp_component_valid_config = $rcp_current_tab_components + "[class*='RCP-valid-config']"

$rcp_component_edit = "div[class=RCP-component-edit]"
$rcp_component_delete = "div[class=RCP-component-delete]"
$rcp_component_warning_icon = "div[class*=RCP-ghost-icon][data-ffid=contentIcon]"
$rcp_component_description = "div[class=RCP-component-config-description]"
$rcp_component_content_container = "div[class=RCP-content-container]"
$rcp_component_ghost = "div[class*='RCP-ghost-config']"

$rcp_component_north_class ="RCP-resizable-handle-north"
$rcp_component_south_class = "RCP-resizable-handle-south"
$rcp_component_east_class = "RCP-resizable-handle-east"
$rcp_component_west_class  = "RCP-resizable-handle-west"
$rcp_component_resize_north = "div[class*='#{$rcp_component_north_class}']"
$rcp_component_resize_south = "div[class*='#{$rcp_component_south_class}']"
$rcp_component_resize_east = "div[class*='#{$rcp_component_east_class}']"
$rcp_component_resize_west = "div[class*='#{$rcp_component_west_class}']"

# RCP Palette Section 
$rcp_palette_master = "div[data-ffid=editPaletteButton] img"
$rcp_palette = "div[data-ffid=palette]"
$rcp_palette_header = "div[data-ffxtype=header]"
$rcp_palette_docker  = "div[data-ffid=paletteDocker]"
$rcp_palette_button = "a[data-ffid=addPaletteButton]"
$rcp_palette_groups = "div[data-ffxtype=rcp-group]"
$rcp_palette_items  = "div[data-ffxtype=rcp-palette-item]"
$rcp_palette_section = "div[data-ffid=paletteSections]"

# rcp component config editor 
$rcp_component_config_label = "[data-ffid=labelText] input"
$rcp_component_config_field = "[data-ffid=fieldPicker] input"
$rcp_component_config_ok_button = "a[data-ffid=okButton]"
$rcp_component_config_cancel_button = "a[data-ffid=cancelButton]"
$rcp_component_config_title = "div[data-ffxtype=window] div[data-ffxtype=header]"
$rcp_component_config_tree_node = "/preceding-sibling::img[2]"
$rcp_component_config_tree_following_nodes  = "/ancestor::table/following-sibling::table"
$rcp_component_config_tree_leaf_label = "//span[text()='nnn']"
$rcp_component_config_tree_leaf = "/ancestor::table"
$rcp_component_config_tree_path = "div[data-ffid=pathDisplay]"

# Address 
$rcp_component_config_allow_edit = "[data-ffid=allowCheckBox] input"
$rcp_component_config_relationship = "[data-ffid=relationshipPicker] input"
$rcp_component_config_contacts_allow_edit = "[data-ffid=allowEditCheckbox] input"

# Task Management
$rcp_component_config_task_team_structure = "[data-ffid=teamCombo] input"
$rcp_component_config_task_completed_tasks = "[data-ffid=showCompletedTasks] input"
$rcp_component_config_task_subject = "[data-ffid=showSubject] input"
$rcp_component_config_task_type = "[data-ffid=showType] input"
$rcp_component_config_task_status = "[data-ffid=showStatus] input"

Small = "Small"
Medium = "Medium"
Large = "Large"
Edit = "Edit"
North = "North"
South = "South"
East = "East"
West  = "West"
Delete = "Delete"
Label = "Label"
Text = "Text"
SingleField = "Single Field"
AddressField = "Address"
ContactsField = "Contacts"
TaskManagementField = "Task Management"
Chatter = "Chatter Feed"
MatchedPayments = "Matched Payments"


	Capybara.add_selector(:component_by_label) do
		xpath {|component_name| "//div[@data-ffid='paletteSections']//div[text()='#{component_name}']"}
	end
	Capybara.add_selector(:ffid) do
		css { |type| "[data-ffid='Id#{type}']" }
	end
# Methods 
	# set the name of rcp
	def RCP.set_name rcp_name
		find($rcp_name).set rcp_name
		gen_tab_out $rcp_name
	end
	# set the driving entity 
	def RCP.set_driving_entity  driving_entity 
		driving_entity = FFA.prefix_custom_object driving_entity
		find($rcp_driving_entity).set driving_entity
		find($gen_f_list_plain).find("li",:text => driving_entity).click
		FFA.wait_for_popup_msg_sync $ffa_msg_loading
		gen_tab_out $rcp_driving_entity
		
	end
	# save the rcp 
	def RCP.save
		FFA.toolbar_save
		FFA.wait_for_popup_msg_sync $ffa_msg_saving
	end
	# open a rcp once saved 
	def RCP.open rcp_name 
		rc = page.has_css?($rcp_search_input)
		row = search_list_view rcp_name
		find($rcp_list_view+" "+"tr[class*=dataRow]:nth-of-type(#{row}) td:nth-of-type(1) a:nth-of-type(1)").click # Click Edit 
		sleep 1
		rc = page.has_css?($rcp_name)
	end
	# search list view 
	def RCP.search_list_view search_text , col = 2 
		_name_cell = $rcp_list_view+" "+ "tr td:nth-of-type(#{col})"
		allrows  = all(_name_cell)
		row = 0 
		while  row < allrows.count
			cellvalue = allrows[row].text 
			row += 1
			if search_text == cellvalue
				break
			end
		end 
		return row 
	end
	# set the size of rcp
	def RCP.set_rcp_size rcp_size 
		if rcp_size == RCP::Small 
			find($rcp_radio_small).click 
		elsif rcp_size == RCP::Medium
			find($rcp_radio_medium).click 
		elsif rcp_size == RCP::Large	
			find($rcp_radio_large).click 
		end 
	end
	# open new tab
	def RCP.new_tab 
		find($rcp_tab_new).click
	end
	# close a tab by index
	def RCP.close_tab tab_number
		find($rcp_tab_close.sub "nnn",tab_number.to_s).click 
	end 
	# set the name of the tab (need to improve this method)
	def RCP.set_tab_name tab_number , tab_name 
		tab_element = $rcp_current_tab_name .sub("nnn",tab_number)
		ele = page.driver.browser.find_element(:css , tab_element)
		page.driver.browser.action.double_click(ele).perform
		page.driver.browser.action.key_down(:command)
								  .send_keys("a")
								  .key_up(:command)
								  .send_keys(:backspace)
								  .send_keys(:backspace)
								  .send_keys(:backspace)
								  .send_keys(:backspace)
								  .send_keys(:backspace)
								  .send_keys(:backspace)
								  .send_keys(:backspace)
								  .perform
		page.driver.browser.action.send_keys(tab_name).send_keys(:tab).perform
		gen_wait_less
	end 
	# get all tab names 
	def RCP.get_tabs
		return find($rcp_tab_panel).text 
	end 

	def RCP.palette_new 
		find($rcp_palette_button).click 
	end 
	# return the selector of component when its dragged on the tab from the palette section 	
	def RCP.get_component_selector component_name  , index 
		within $rcp_current_tab do
			index = index.to_i + 1 #ignore the div in palette section 
			return find(:xpath , "(//div[text()='#{component_name}'])[#{index.to_s}]/ancestor::div[@data-ffxtype='rcp-component']")
		end 
	end
	# add component by dragging 
	def RCP.drag_component  component_name , row , col 
		if (row == 1 and col == 1)
			drag_to_element = find($rcp_current_tab)
		else 
			drag_to_element = find($rcp_current_tab_table + "tr:nth-of-type(#{row}) td:nth-of-type(#{col})")
		end 
		drag_source = find(:component_by_label,component_name)
		drag_source.drag_to(drag_to_element)
		sleep 0.5
	end 
	# add/ append component by double clicking on it 
	def RCP.append_component component_name
		element = find(:component_by_label,component_name)
		# Equivalent to double click (element.double_click() not working correctly)
		element.click()
		element.click()
		sleep 1
	end 
	# drag source component to the destination component 
	def RCP.drag_component_on_another drag_component , drop_component 
		drag_component_selector   = RCP.get_component_selector drag_component  , 0 
		drop_component_selector  = RCP.get_component_selector drop_component  , 0 
		gen_drag_drop drag_component_selector , drop_component_selector
	end 
	
	def RCP.hover_on_component component_name , index 
			component_selector = RCP.get_component_selector component_name,index
			component_selector.hover 
	end 
	# Various Actions on individual componet 
	# compponent_name name of the component as string
	# index - index of the component as string 
	def RCP.component_actions compponent_name , index , action 
		component_selector = RCP.get_component_selector compponent_name,index
		# hover on the component to activate the various buttons on it.
		component_selector.hover 
		within $rcp_current_tab do 
			case action 
			when  RCP::Edit
				component_selector.find($rcp_component_edit).click 
			when RCP::Delete
				component_selector.find($rcp_component_delete).click 
			when  RCP::Label
				return component_selector.find($rcp_component_description).text
			when  RCP::Text
				return component_selector.find($rcp_component_content_container).text
			else
				raise "Not a valid action on Component"
			end 
		end 
	end 
	# set the component config lable 
	def RCP.set_component_config_label label
		find($rcp_component_config_label).set label
	end 
	# set the component config field 
	# field_list field to be selected from the tree separated by ; 
	# e.g "CODACreditManager__c;AccountId;CODAAccountsPayableControl__c;CreatedById;ContactId;CreatedById;AboutMe"
	# in the aobve case it will expand the tree until its gets to the AboutMe under the CreatedById Trees node
	def RCP.set_component_config_field field_list 
		fields  = field_list.split(';')
		last_index =  fields.count - 1
		node_path = ""
		leaf_path = ""
		# Expand the tree 
		if fields.count > 1 
			i = 0
			while i < fields.count
				node = fields[i]
				node = FFA.prefix_custom_object node
				node_selector = $rcp_component_config_tree_leaf_label.sub "nnn",node
				node_path = node_path + node_selector 
				find(:xpath, node_path.to_s + $rcp_component_config_tree_node).click 
				node_path = node_path.to_s + $rcp_component_config_tree_following_nodes
					if  i < fields.count - 1 
						leaf_path = leaf_path + node_selector + $rcp_component_config_tree_following_nodes
					end 
				gen_wait_less
				i+=1
			end 
		end 
		# Select the leaf
		field_label = fields[last_index]
		field_label = FFA.prefix_custom_object field_label
		select_field = $rcp_component_config_tree_leaf_label.sub "nnn",field_label
		field_selector = select_field + $rcp_component_config_tree_leaf
		selector = leaf_path + field_selector
		find(:xpath,selector).click 
		sleep 1
	end 

	# resize the component by the dragging from the the drag handle from each side
	def RCP.resize_component  component_name ,component_index, row , col , drag_side , grid_size 
		if grid_size == RCP::Small
			RCP.drag_component_by_grid_size  component_name ,component_index, row , col , drag_side, 2,  6
		elsif grid_size ==RCP::Medium
			RCP.drag_component_by_grid_size  component_name ,component_index, row , col , drag_side, 4,  6
		elsif grid_size == RCP::Large
			RCP.drag_component_by_grid_size  component_name ,component_index, row , col , drag_side, 6,  6
		end 
	end 
	# drag the componet depending up the grid size and drag directoion 
	def RCP.drag_component_by_grid_size component_name ,component_index, row , col , drag_side, grid_width,  grid_height
		# work out the target tab width and height 
		element = find($rcp_current_tab)
		style =  element[:style]
		attributes  = style.split(';')
		width = ""
		height = ""
		attributes.each do |prop|
			if prop.include? 'width'
				width = prop
			end 
			if 	 prop.include? 'height'
				height = prop
			end 
		end
		width = width.split(':')
		height = height.split(':')
		w =  width[1].sub('px','')
		h =  height[1].sub('px','')
		tab_width = w.to_i 
		tab_height = h.to_i
		# get the width and hieght of individula cell
		cell_width =  tab_width / grid_width
		cell_height = tab_height / grid_height
		# get the center of cell
		vertical_center  = grid_height / 2 
		horizental_center =  grid_width / 2 
		# work out the vertical offset (60 %)
		vertical_offset = row - vertical_center - 0.4
		move_vertical = cell_height * vertical_offset
		# workout the horizental offset (60 %)
		horizental_offset = col - horizental_center - 0.4
		move_horizental = cell_width * horizental_offset
		# pick up the componet resize handle to drag 
		if drag_side  == RCP::North 
			drag_side_path  = $rcp_component_north_class 
		elsif  drag_side  == RCP::South 
			drag_side_path  = $rcp_component_south_class 
		elsif  drag_side  == RCP::East 
			drag_side_path  = $rcp_component_east_class 
		elsif  drag_side  == RCP::West
			drag_side_path  = $rcp_component_west_class 
		end 
		index = component_index.to_i + 1 #ignore the div in palette section 
		drag_handle_path = "(//div[text()='#{component_name}'])[#{index.to_s}]/ancestor::div[@data-ffxtype='rcp-component']//div[contains(@class,'#{drag_side_path}')]"
		source_selenium_ele = page.driver.browser.find_element(:xpath,drag_handle_path)
		# move it to the center of the current tab
		target_selenium_ele = page.driver.browser.find_element(:css , $rcp_current_tab)
		page.driver.browser.action.click_and_hold(source_selenium_ele).perform
		# move it to the rght cell
		page.driver.browser.action.move_to(target_selenium_ele).perform
		page.driver.browser.action.move_by(move_horizental, move_vertical).perform
		# Drop the component to the cell 
		page.driver.browser.action.release().perform
		gen_wait_less 
	end 
	# set the component config allow edit 
	def RCP.set_component_config_allow_edit 
		find($rcp_component_config_allow_edit).click
	end 

	# click ok button 
	def RCP.config_click_button_ok
		find($rcp_component_config_ok_button).click 
	end 

	# click cancel button 
	def RCP.config_click_button_cancel
		find($rcp_component_config_cancel_button).click 
	end 

	def RCP.set_component_config compponent_name,index ,label , config_field , okflag=true
		RCP.component_actions compponent_name , index , RCP::Edit 
		RCP.set_component_config_label label
		if config_field != nil
			RCP.set_component_config_field config_field 
		end 
		if okflag == true
			RCP.config_click_button_ok
		end
	end 
	# return the field path on the single filed component 
	def RCP.get_component_field_path 
		return find($rcp_component_config_tree_path).text 
	end 

	# Drag the component back to palette section to remove it 
	def RCP.drag_to_palette_section row,col  
		drag_selector = find($rcp_current_tab_table + " tr:nth-of-type(#{row}) td:nth-of-type(#{col}) " + $rcp_component)
		drop_selector = find($rcp_palette_section)
		gen_drag_drop  drag_selector, drop_selector
	end 
	
	def RCP.move_tab_to   move_tab , move_to 
		drag_selector = find(:span_by_label,move_tab)
		drop_selector = find(:span_by_label,move_to)
		gen_drag_drop  drag_selector, drop_selector
		sleep 0.5
	end 
	# return the status of radio button 
	def RCP.get_size_radio_status radio_button_selector
		radio_button =  find(radio_button_selector)
		radio_button_class = radio_button[:class]
		return  radio_button_class.include? $rcp_radio_pressed
	end 
	# move palette from default docking location 
	def RCP.move_palette 
		palette_section  = find($rcp_palette_header)
		rcp_tab  = find($rcp_current_tab)
		gen_drag_drop palette_section , rcp_tab
	end 
	# Re dock the Paleter
	def RCP.dock_palette 
		palette_section  = find($rcp_palette_header)
		docking_locatin = find($rcp_palette_docker)
		gen_drag_drop palette_section , docking_locatin
	end 
	# get the title of component 
	def RCP.get_config_title
		title =  find($rcp_component_config_title).text
		return  title
	end 
	# Delete specific rcp in the list view 
	def RCP.delete rcp_name 
		rc = page.has_css?($rcp_search_input)
		row = search_list_view rcp_name
		find($rcp_list_view+" "+"tr[class*=dataRow]:nth-of-type(#{row}) td:nth-of-type(1) a:nth-of-type(2)").click # Click Delete
		sleep 1
		gen_alert_ok
	end
	# Delete all rcp in the list view 
	def RCP.delete_all
		counter = 0
		while(page.has_css?($rcp_list_view+" tr[class*='dataRow']")) and counter < DEFAULT_TIME_OUT
			click_link 'Del'
			sleep 1
			gen_alert_ok
			counter += 1
		end
	end
# --------------------#
# Address Component 
# --------------------#
	def RCP.set_address_config compponent_name, index , label, config_field , allowEdit
		RCP.component_actions compponent_name , index , RCP::Edit 
		RCP.set_component_config_label label
		RCP.set_address_config_field config_field
		if allowEdit == true
			RCP.set_address_config_allow_edit 
		end
		RCP.config_click_button_ok
	end
	# Set Field on Address config 
	def RCP.set_address_config_field config_field 
		config_field = FFA.prefix_custom_object config_field
		find($rcp_component_config_field).set config_field
		find($gen_f_list_plain).find("li",:text => config_field).click
	end 
	def RCP.set_address_config_allow_edit 
		RCP.set_component_config_allow_edit 
	end 
# --------------------#
# Contact Component
# --------------------#
	def RCP.set_contacts_config component_name , index , label, config_relatioship , allowEdit
		RCP.component_actions component_name , index , RCP::Edit 
		RCP.set_component_config_label label
		RCP.set_contacts_config_relationship config_relatioship
		if allowEdit == true 
			RCP.set_contacts_config_allow_edit 
		end 
		RCP.config_click_button_ok
	end
	# select the contact component relationship 
	def RCP.set_contacts_config_relationship config_relatioship 
		config_relatioship = FFA.prefix_custom_object config_relatioship
		find($rcp_component_config_relationship).set config_relatioship
		find($gen_f_list_plain).find("li",:text => config_relatioship).click
	end  
	# Click edit on contact config
	def RCP.set_contacts_config_allow_edit 
		find($rcp_component_config_contacts_allow_edit).click
	end
# --------------------#
# Task Management Component 
# --------------------#
	# Save Task Management field component with valid data
	def RCP.set_tm_component_config component_name, index, label, team_structure, completed_tasks, type, status
		RCP.component_actions component_name , index , RCP::Edit 
		RCP.set_component_config_label label
		RCP.set_task_team_structure_config_field team_structure
		if completed_tasks == true
			RCP.set_completed_tasks_config
		end
		if type == true
			RCP.set_type_task_config
		end
		if status == true
			RCP.set_status_task_config 
		end
		find($rcp_component_config_ok_button).click 
	end
	# Set Field on TM config 
	def RCP.set_task_team_structure_config_field team_structure 
		config_field = FFA.prefix_custom_object team_structure
		find($rcp_component_config_task_team_structure).click
		find($gen_f_list_plain).find("li",:text => team_structure).click
	end 
	# Click Show Completed Tasks check box on Task Management config
	def RCP.set_completed_tasks_config
		find($rcp_component_config_task_completed_tasks).click
	end
	# Click Subject check box on Task Management config
	def RCP.set_subject_task_config
		find($rcp_component_config_task_subject).click
	end
	# Click Type check box on Task Management config
	def RCP.set_type_task_config
		find($rcp_component_config_task_type).click
	end
	# Click Status check box on Task Management config
	def RCP.set_status_task_config 
		find($rcp_component_config_task_status).click
	end
end
