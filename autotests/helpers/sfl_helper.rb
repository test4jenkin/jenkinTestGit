 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved. 
module SFL
extend Capybara::DSL

###################################################
# Parameter Substitution Symbol
###################################################
$sfl_param_substitute='?'

############################################
#  salesforce lightening objects
############################################
$sfl_application_search_textbox = "input[title='Search Salesforce']"
$sfl_setup_icon = "span[class$='icon-settings-bolt']"
$sfl_setup_icon_link = "a[title='Setup']"
$sfl_setup_menu_pattern = "//li/a//span[text()='"+$sfl_param_substitute+"']"
$sfl_setup_search_textbox = "input[class='searchBox input']"
$sfl_setup_child_user_link = "(//li[contains(@class,'leaf onesetupTreeNode')]/a/mark[text()='Users'])[1]"
$sfl_app_launcher_icon = "div[class='slds-icon-waffle']"
$sfl_profile_icon = "img[class*='profileTrigger']"
$sfl_new_button = "div[title='New']"
$sfl_edit_button = "a[title='Edit']"
$sfl_select_view = "span[class*='selectedListView']"
$sfl_select_view_list_option_pattern = "//li/a/span[text()='"+$sfl_param_substitute+"']"
$sfl_document_result_table = "div[class$='listViewContent']"
$sfl_tab_list = "div[class='list']"
$sfl_other_item_locator = "img[alt='Other Items']"
$sfl_tab_name_pattern = "//mark[text() ='"+$sfl_param_substitute+"']"
$sfl_page_layout_page_lines_up = "window.scrollByLines(-5)"
$sfl_object_page_layout_assignment_button = "div[class*='testOnlyPageLayoutList']  section div[class='bRight'] button:nth-of-type(2) span"
$sfl_object_button_rows = "div[class$='testOnlyButtonsLinksActionList'] section table tbody tr"
$sfl_object_buttons_name_pattern = $sfl_object_button_rows +":nth-of-type("+$sfl_param_substitute+") td:nth-of-type(1) span"
$sfl_object_button_edit_button_pattern = $sfl_object_button_rows +":nth-of-type("+$sfl_param_substitute+") td:nth-of-type(7) a span"
$sfl_object_button_edit_link_pattern = $sfl_object_button_rows +":nth-of-type("+$sfl_param_substitute+") td:nth-of-type(7) li a"
$sfl_std_object_buttons_next_page_icon = "div[class$='testOnlyButtonsLinksActionList'] div[class*='uiPagerNextPrevious'] a[class='pagerControl next'][aria-disabled='false']"
$sfl_show_more_action_link = "a[title='Show more actions for this record']"
$sfl_app_search_box = "div[class='modal-container slds-modal__container'] input[class='slds-input input']"
$sfl_more_action_value_pattern = "a[title='"+$sfl_param_substitute+"']"
$sfl_lookup_list_values_pattern = "div[title = '"+$sfl_param_substitute+"']"
$sfl_picklist_values_pattern = "li a[title='"+$sfl_param_substitute +"']"
$sfl_picklist_pattern = "a[aria-label='"+$sfl_param_substitute+"']"
$sfl_detail_list_link = "a[title='Details']"
$sfl_std_object_next_page_locator = "a[class='pagerControl next'][aria-disabled='false']"
$sfl_setup_object_and_fields_link = "Objects and Fields"
$sfl_setup_object_manager_link = "Object Manager"
$sfl_setup_home = "Setup Home"
$sfl_other_items_text = "Other Items"
$sfl_logout_text = "Log Out"
$sfl_setup_email = "Email"
$sfl_setup_users = "Users"
$sfl_object_fill_in_box_clear_pattern = "//div[contains(@class,'slds-p-around--medium')]//span[text()='"+$sfl_param_substitute+"']/ancestor::div[1]//span[@class='deleteIcon']"
$sfl_lookup_list_search_pattern = "//div[contains(@class,'forceSearchInputLookupDesktopActionItem lookup__header')]//span[contains(@class,'itemLabel slds-truncate') and contains(text(),'"+$sfl_param_substitute+"')]"
$sfl_lookup_list_search_values_pattern = "//div[@data-aura-class='forceSearchLookupAdvanced']//a[@title = '#{$sf_param_substitute}']"
$sfl_selected_view = "//span[text()='"+$sfl_param_substitute+"']"
$sfl_switch_to_classic_label = "Switch to Salesforce Classic"
$sfl_setup_edit_page = "Edit Page"
$sfl_home_current_company = "a[title*='Current Company']"
$sfl_home_profitability_reporting = "a[title*='Profitability Reporting']"
# Methods

# click on menu of step	and select the option as passed
	def SFL.admin menu 
		puts "opening #{menu} from admin profile."
		SF.retry_script_block do
			if (menu == $sf_logout)
				SFL.logout
			else if(menu == $sf_setup)
				# Setup page is now opened in a new tab on lightning org. 
				# To avoid explicit switch to perform the action on the new window. Used below method to visit the setup url on same page.
				# which will open the setup page on same window and does not require any switch operation.
				page.has_css?($sfl_setup_icon)
				find($sfl_setup_icon).click
				sleep 1 # wait for list options to get display.
				url = find($sfl_setup_icon_link)[:href]
				visit url	
				gen_wait_until_object $sfl_setup_search_textbox
				find($sfl_setup_search_textbox).set ""
				else
					page.has_css?($sfl_setup_icon)
					find($sfl_setup_icon).click
					sleep 1 # wait for list options to get display.
					find(:xpath , $sfl_setup_menu_pattern.sub($sfl_param_substitute,menu)).click
					page.has_css?($sfl_setup_search_textbox)	
				end
			end
		end
	end 

# view apex job page
	def SFL.view_apex_job
		SF.retry_script_block do
			SFL.admin $sf_setup
			apex_job = "Apex Jobs"
			find($sfl_setup_search_textbox).set apex_job
			click_link apex_job
			page.has_text?(apex_job)
			# set blank in search text box to clear set search criteria
			find($sfl_setup_search_textbox).set ""
		end
	end

# Navigate to specific tab on lightening org
	def SFL.tab tabname
		SF.retry_script_block do
			find($sfl_app_launcher_icon).click
			page.has_css?($sfl_app_search_box)
			find($sfl_app_search_box).set tabname
			page.has_text?(tabname)
			find(:xpath, $sfl_tab_name_pattern.sub($sfl_param_substitute ,tabname )).click
		end
		page.has_text?(tabname)
	end 

# Logout
	def SFL.logout
		find($sfl_profile_icon).click
		sleep 1 # wait for logout link option to appear
		click_link $sfl_logout_text
	end

# select view on lightening org	
	def SFL.select_view viewname 
		SF.retry_script_block do 
			find($sfl_select_view).click
			sleep 1 # wait for the list to open
			find(:xpath , $sfl_select_view_list_option_pattern.sub($sfl_param_substitute , viewname)).click
			# wait for the view to get selected. If list is not refreshed as per selected view.Try again..
			if (!page.has_xpath?($sfl_selected_view.sub($sfl_param_substitute , viewname)))
				raise "Error on selecting view.Trying Again..."
			end
		end
		page.has_css?($page_grid_columns)
	end 

	# Set search criteria on setup page
	def SFL.set_setup_search search_text 
		find($sfl_setup_search_textbox).set search_text
	end
	
	def SFL.object_button_edit object_name, button_name
		SFL.set_setup_search $sfl_setup_object_manager_link
		click_link $sfl_setup_object_manager_link
		page.has_xpath?($sf_lightning_setup_object_manager_search_textbox)
		# search the object to filter the results
		if (SF.org_is_lightning)
			SF.retry_script_block do
				find(:xpath , $sf_lightning_setup_object_manager_search_textbox).set object_name
				page.has_link?(object_name)
			end
		end
		SF.retry_script_block do
			within($sf_object_list_section) do 
				SF.click_link object_name
			end
		end
		page.has_css?($sfl_object_page_layout_assignment_button)
		# Number of rown in button,action and link section
		_rows_in_action_grid = all($sfl_object_button_rows).count
		_row_num =1
		while _row_num <= _rows_in_action_grid
			button = $sfl_object_buttons_name_pattern.sub($sfl_param_substitute,_row_num.to_s)
			label_text = find(button).text
			if button_name == label_text 
				show_edit_link_icon = $sfl_object_button_edit_button_pattern.sub($sfl_param_substitute,_row_num.to_s)
				# click on icon to show edit link 
				find(show_edit_link_icon).click
				find($sfl_object_button_edit_link_pattern.sub($sfl_param_substitute,_row_num.to_s)).click
				return
			end
			_row_num+=1 
			# In case, the button is not available on current page. 
			# User need to click on next page to view more buttons for object.
			if (_row_num > _rows_in_action_grid)
				find($sfl_std_object_buttons_next_page_icon).click
				page.has_text?(button_name)
				# recalculate the number of rows present under button section on next page.
				_rows_in_action_grid = all($sfl_object_button_rows).count
				# Checking the rows on new page again from row 1.
				_row_num =1
			end
		end
	end
	
	# To perform more actions on standard SF object which are available under down arrow key
	# select_action = Name of the option/button which need to be clicked. 
	def SFL.click_action select_action
		btn_exist = false
		SF.execute_script do
			btn_exist = page.has_button?(select_action)
			puts "button exist - #{btn_exist}"
		end
		# perform operation on button
		if (btn_exist)
			SF.execute_script do
				# Doing a double check as in spring 17, We observed that sometimes a different button(other than expected) also displayed on UI.
				# Due to which it click on that button instead of opening show more option list and clicking on button/link from that options.
				# So just added a check that if show more option link exist, It will make sure that it is lightning org and if this option is displayed.
				# it is a standard UI and VF page. Therefore code should click on option present under that list.
				if (page.has_css?($sfl_show_more_action_link , :wait => DEFAULT_LESS_WAIT))
					find($sfl_show_more_action_link).click
					find($sfl_more_action_value_pattern.sub($sfl_param_substitute,select_action)).click
				else
					first(:button, select_action).click
					gen_wait_until_object_disappear $ffa_processing_button_locator
				end
			end
		# access the action from more action link.
		else 
			SF.retry_script_block do
				page.has_css?($sfl_show_more_action_link)
				find($sfl_show_more_action_link).click
				find($sfl_more_action_value_pattern.sub($sfl_param_substitute,select_action)).click
			end
		end		
	end
	
	# To select the value from standard SF lookup object 
	# object_label = label of the locator
	# value = name of the value which need to be selected
	def SFL.fill_in_lookup object_label , value		
		clear_fill_in_value = $sfl_object_fill_in_box_clear_pattern.sub($sfl_param_substitute,object_label)
		# if a lookup field is already set, user need to first clear that field before setting a new value.
		# clear if any value exist  from lookup field.
		if page.has_xpath?(clear_fill_in_value, :wait => DEFAULT_LESS_WAIT)
			find(:xpath, clear_fill_in_value).click
		end
		fill_in object_label ,:with => ""
		# set the value and select from filtered list only when it is not nil.
		if (value != nil)
			fill_in object_label , :with => value
			# wait for the list to get filter as per set criteria
			if(page.has_css?($sfl_lookup_list_values_pattern.sub($sf_param_substitute,value), :wait => SF::LESS_WAIT))
				find(:css, $sfl_lookup_list_values_pattern.sub($sf_param_substitute,value)).click
			else	
				# if value is not filtered, click on search icon and select from list.
				find(:xpath, $sfl_lookup_list_search_pattern.sub($sf_param_substitute,value)).click
				find(:xpath, $sfl_lookup_list_search_values_pattern.sub($sf_param_substitute,value)).click
			end
		end
	end
	
	# To select the value from standard SF dropdown object 
	# picklist_label = Label of the picklist
	# value = name of the value which need to be selected
	def SFL.select_value picklist_label ,value
		find($sfl_picklist_pattern.sub($sfl_param_substitute , picklist_label )).click
		sleep 1# wait for option to display
		value = $sfl_picklist_values_pattern.sub($sfl_param_substitute , value)
		# wait for the list to get filter as per set criteria
		page.has_css?(value, :wait => DEFAULT_LESS_WAIT)
		find(value).click
	end
	
	# Method to view the users page
	def SFL.view_users 
		find($sfl_setup_search_textbox).set $sfl_setup_users
		find(:xpath, $sfl_setup_child_user_link).click
		find($sfl_setup_search_textbox).set ""
	end
	
# It will switch the org from lightning to non-lightning by selecting the option of "Switch to classic view" from setup options.
	def SFL.switch_to_classic
		# Switch to classic only when org is in lightning state.
		SF.retry_script_block do 
			if (SF.is_lightning_org_active)
				SF.log_info "Lightning component is active on org. Switch to classic and turn OFF lighting"
				page.has_css?($sfl_setup_search_textbox)
				find($sfl_profile_icon).click
				sleep 1 # wait for options to display
				SF.retry_script_block do 
					click_link($sfl_switch_to_classic_label)
				end
			end
		end
		page.has_no_css?($sfl_profile_icon)
	end
end


