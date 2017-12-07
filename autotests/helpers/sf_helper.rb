 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved. 
module SF
extend Capybara::DSL

LESS_WAIT = 2 #in seconds 
MORE_WAIT = 5 #in seconds
MAX_RETRY_COUNT=3
MAX_RETRY_COUNT_APEX_JOB = 50
###################################################
# Parameter Substitution Symbol
###################################################
$sf_param_substitute='?'
############################################
#  salesforce objects
############################################
$sf_application_button = '#tsidButton'
$sf_application_search_button = '#phSearchButton'
$sf_bottom_navigation = "div.bottomNav"
$sf_bottom_navigation_prevnextlinks = "span.prevNextLinks"
$sf_bottom_navigation_prevnextlinks_first_page = "span.prevNext:nth-of-type(1) a"
$sf_bottom_navigation_prevnextlinks_previous_page = "span.prevNext:nth-of-type(2) a"
$sf_bottom_navigation_prevnextlinks_next_page = "span.prevNext:nth-of-type(3) a"
$sf_bottom_navigation_prevnextlinks_last_page = "span.prevNext:nth-of-type(4) a"
$sf_go_button = "div.filterOverview input[name=go]"
$sf_lookup_go_button = "div.lookup  input[name=go]"
$sf_object_search_layouts_available_field_pattern = "//*[text() = '"+$sf_param_substitute+"']"
$sf_refresh_button = "input[title=Refresh]"
$sf_custom_setting_manage = "//a[text()='"+$sf_param_substitute+"']/ancestor::tr[1]/td/a[text()='Manage']" #replace $sf_param_substitute with custom setting names
$sf_custom_setting_property = "//label[text()='"+$sf_param_substitute+"']/ancestor::th/following-sibling::td/*" 
$sf_cancel_button = "Cancel"
$sf_next_button = "Next"
$sf_save_button = "Save"
$sf_add_button = "Add"
$sf_update_button = "Update"
$sf_select_view = "#fcf>option[selected='selected']"
$sf_grid_rows = ".dataRow"
$sf_records_per_page_pattern = "//table[@class='selector rpp']/tbody/tr/td[text()='"+$sf_param_substitute+"']"
$sf_select_records_per_page_icon = "span[id$='paginator_rpp_target'] img.selectArrow"
$sf_edit_view_top_img_icon = "a img[alt='Top']"
$sf_edit_view_down_img_icon = "a img[alt='Down']"
$sf_edit_view_selected_fields_to_display = "select[id='colselector_select_1'] option"
$sf_list_view_edit_link = "div.filterLinks a:nth-of-type(1)"
$sf_edit_view_selected_field_pattern = "//select[@id='colselector_select_1']/option[text()='"+$sf_param_substitute+"']"
$sf_page_title = "div[class=bPageTitle] h1"
$sf_page_header = "div[class=pbHeader] h2"
$sf_custom_setting_property = "//label[text()='"+$sf_param_substitute+"']/ancestor::th/following-sibling::td/*"
$sf_visualforce_page_label = "Visualforce Page"
$sf_edit_button = "Edit"
$sf_new_button = "New"
$sf_view_button = "View"
$sf_confirm_button = "Confirm"
$sf_element_edit_link = "//a[contains(@title, '"+$sf_param_substitute+"')][contains(text(), 'Edit')]"
$sf_std_view_field_content = "//td[@class='labelCol'][text()='#']/following::td[contains(@class, 'dataCol')][1]"
$sf_page_description = "div[class=bPageTitle] h2"
$sf_show_feed = "img[title$='Show Feed']"
$sf_show_feed_link = "//span[text()='Show Feed']"
$sf_page_layout_page_scroll_lines= "window.scrollByLines("+$sf_param_substitute+")"
$sf_page_layout_page_num_lines_up = "window.scrollByLines("+$sf_param_substitute+")"
$sf_page_layout_scroll_page="window.scrollByPages("+$sf_param_substitute+")"
$sf_edit_view_up_img_icon = "a img[alt='Up']"
$sf_search_frame = 'searchFrame'
$sf_results_frame = 'resultsFrame'
$sf_search_frame_input_id = "lksrch"
$sf_lookup_icon_pattern = "//*[@alt='"+$sf_param_substitute+"']"
$sf_search_layout_add_field_section = "select[name*='duel_select_0']"
$sf_search_layout_remove_field_section = "select[name*='duel_select_1']"
$sf_layout_field_added_successfully_on_layout_pattern = "//span[@class='labelText'][text()='"+$sf_param_substitute+"']"
$sf_layout_custom_button_added_successfully_on_layout_pattern= "//div[text()='"+$sf_param_substitute+"']"
$sf_add_layout_reports_chart_popup = "//div[@class='x-shadow']//following::div[1]//span[text()='Add Report Charts']/ancestor::div[1]/a"
$sf_bcc_email_enable_checkbox = "//label[text()='Enable']"
$sf_vf_tabs_new_button = "//h3[text()='Visualforce Tabs']/../following-sibling::td[1]/input"
$sf_vf_page_select = "//label[text()='Visualforce Page']/../following-sibling::td[1]//select"
$sf_vf_tab_lookup_window = "a img[alt='Lookup (New Window)']"
$sf_vf_tab_style_selector = "//div[text()='Hammer']"
$sf_vf_tab_name_pattern = "(//a[text()='"+$sf_param_substitute+"'])"
$sf_object_create_tabs = "//div[@id='DevTools']//a[text()='Tabs']"
$sf_list_create_new_view_link = "//a[text()='Create New View']"
$sf_custom_object_page_table = "div[class='bRelatedList']"
$sf_always_required_radio_button = "input[id*='options_0']"
$sf_field_with_title = "a[title*='"+$sf_param_substitute+"']"
$sf_list_view_layout_edit_link = "a[title*='"+$sf_param_substitute+"']"
$sf_list_view_listbox_option = "//option[text()='"+$sf_param_substitute+"']"
$sf_tab_link = "img[title='"+$sf_param_substitute+"']"
$sf_create_new_vf_tab_label_input= "//label[text()='Tab Label']/ancestor::td[1]/following::td[1]/div/input"
$sf_create_new_vf_tab_name_input= "//label[text()='Tab Name']/ancestor::td[1]/following::td[1]/div/input"
# Apex job
$sf_batch_process_status_in_progress = "Processing"
$sf_batch_process_status_preparing = "Preparing"
$sf_batch_process_status_holding = "Holding"
$sf_batch_process_status_queued = "Queued"
$sf_global_search = "input#setupSearch"
$sf_batch_process_rows = "div[class$='setupBlock'] div tr[class*='dataRow']"
$sf_batch_process_status_column_pattern = "div[class$='setupBlock'] div tr:nth-of-type("+$sf_param_substitute+") td:nth-of-type(3)"
$sf_custom_tabs_new_button = "input[title='New Custom Object Tabs']"
$sf_object_label = "Object"
############################################
#  salesforce aliases 
############################################
$sf_my_profile = "My Profile"
$sf_setup = "Setup"
$sf_developer_console = "Developer Console"
$sf_logout = "Logout"
$sf_tab_all_tabs = "All Tabs"
$sf_setup_create = "Create"
$sf_setup_develop_custom_setting = "Custom Settings"
$sf_setup_create_objects = "Objects"
$sf_setup_create_tabs = "Tabs"
$sf_setup_customize = "Customize"
$sf_setup_manage_users = "Manage Users"
$sf_setup_manage_users_users = "Users"
$sf_setup_collapse_button = "img[class='setupImage'][title*='#']"
$sf_msg_no_records_to_display = "No records to display."
$sf_setup_company_profile = "Company Profile"
$sf_setup_manage_currencies = "Manage Currencies"
$sf_setup_email_administration = "Email Administration"
$sf_setup_email_admin_compliance_bcc_email = "Compliance BCC Email"
$sf_lookup_search_results_text = "Search Results"
$sf_setup_std_object_search_layouts = "a[id*='OpportunitySearchLayouts']"
$sf_list_view_add_button = "img[title*='Add']"
$sf_search_layout = "Search Layouts"
############################################
#  salesforce custom objects - field sets
############################################
$sf_custom_object_field_sets = "Field Sets"
$sf_custom_object_field_sets_default_list = "div[id$='defaultList']"
$sf_custom_object_field_sets_draggables = "div[class$='draggables-bwrap']"

############################################
#  salesforce layout objects 
############################################
$sf_setup_customize_stdobj_layout = "Page Layouts"
$sf_layout_panel_button = "div#troughCategory__Button"
$sf_layout_panel_fields = "div#troughCategory__Field"
$sf_edit_page_layout_target_position_button = "//*[text()='Custom Buttons']/following-sibling::div"
$sf_edit_page_layout_target_position_standard_button = "//*[text()='Standard Buttons']/following-sibling::div"
$sf_body_cell = "#bodyCell"
$sf_edit_page_layout_quick_find_text_box_field = "#quickfind"
$sf_edit_page_layout_source_field_pattern = "//div/span[text()='"+$sf_param_substitute+"']/.."
$sf_edit_page_layout_source_field_position = ".troughItems  td div:nth-of-type(3)"
$sf_page_layout_edit_link_pattern = "//*[text()='"+$sf_param_substitute+"']/../td[1]/a[1]"
$sf_edit_page_layout_target_position = ".entryCell.col2"
$sf_edit_page_layout_target_position2 = "//div[@class='section-header x-unselectable tertiaryPalette']/..//td[ @class='entryCell col2']"
$sf_edit_page_layout_list_window = "#plaBodyTable tbody"
$sf_edit_page_layout_selector = "#pageLayoutSelector"
$sf_edit_page_layout_select_record = "//tr/td[contains(text(), '"+$sf_param_substitute+"')]"
$sf_object_button_standard_salesforce = "input[id$='ContentId1']"
$sf_no_override_radio_button = "input[id$='ContentId0']"
$sf_standard_salesforce_button = "input[id$='ContentId1']"
$sf_edit_page_layout_option_list = "td[class*='profileHeader']"
$sf_object_button_list = "div[id$='ActionButtonLinkList$ActionsList'] tr"
$sf_object_button ="div[id$='ActionButtonLinkList$ActionsList'] tr:nth-of-type("+$sf_param_substitute+") th"
$sf_object_button_edit  ="div[id$='ActionButtonLinkList$ActionsList'] tr:nth-of-type("+$sf_param_substitute+") td:nth-of-type(1) a"
$sf_field_level_security_button= "input[name='fieldAccessEdit']"
$sf_object_namespace_prefix = "//label[text()='Namespace Prefix']/ancestor::td[1]/following::td[1]"
$sf_object_tab_setting_list_pattern = "select[id='tab___"+$sf_param_substitute+"']"
$sf_customize_child_objects_section = "div#Customize_child"
$sf_create_objects_list_section = "table.list"
$sf_object_page_layout_assignment = "input[value = 'Page Layout Assignment']"
$sf_object_edit_assignment = "input[value = 'Edit Assignment']"
$sf_button_property_visualforce_page_dropdown = "#contentId_3"
$sf_button_property_visualforce_page_option = "//option[text()='"+$sf_param_substitute+"']"
$sf_alphabet_filter_on_listview = "//a//span[@class='listItemPad' and text()='"+$sf_param_substitute+"']"
$sf_object_search_layout_pattern = "//th[text()='"+$sf_param_substitute+"']/preceding-sibling::td/a"
$sf_lightening_iframe_locator = "div[class='active oneContent'] iframe"
$sf_object_list_section = "div[class='listRelatedObject setupBlock']"
$sf_edit_layout_element_position_in_editor_section = "//table[@class='troughItems ']//span[text()='"+$sf_param_substitute+"']"
$sf_edit_layout_field_position_detail_section = "//span[@class='labelText' and text()='"+$sf_param_substitute+"']"
$sf_edit_layout_custom_button_position_detail_section = "//*[text()='Custom Buttons']/following-sibling::div[text()='"+$sf_param_substitute+"']"
$sf_edit_layout_standard_button_position_detail_section = "//*[text()='Standard Buttons']/following-sibling::div[text()='"+$sf_param_substitute+"']"
$sf_field_level_security_visible_checkbox= "input[title='Visible']"
$sf_label_standard = "Standard"
$sf_label_custom = "Custom"
###################################################
# setup remote site settings
###################################################
$sf_remote_site_setting_disable_protocol_security = '#ProtocolMismatch'
############################################
#  salesforce create new field
############################################
$sf_custom_field_relationship_section = "[id$='CustomFieldRelatedList']"
$sf_field_label = "Field Label"
$sf_field_length = "Length"
$sf_field_name= "#DeveloperName"
$sf_fls_visible_select_all = "input[title='Visible']"
$sf_data_type_text = "Text"
$sf_data_type_lookup_relationship = "Lookup Relationship"
$sf_data_type_date = "Date"
$sf_add_page_layouts_add_field = "Add Field"
$sf_custom_fields_and_relationships_link = "Custom Fields & Relationships"
$sf_related_to_object_list = "DomainEnumOrId"
# delete field
$sf_custom_field_delete_confirm_label = "Yes, I want to delete the custom field."
$sf_custom_field_confirm_delete_button = "input[value='Delete']"
$sf_custom_field_delete_link_pattern = "//a[text()='"+$sf_param_substitute+"']/../../preceding-sibling::td/a[2]"
$sf_custom_field_delete_confirm_popup_title = 'Confirm Custom Field Delete'

############################################
#  salesforce create new currency
############################################
$sf_new_currency_button = " New "
$sf_new_curr_currency_type = "Currency Type"
$sf_new_curr_conversion_rate = "Conversion Rate"
$sf_new_curr_decimal_places ="Decimal Places"
$sf_currency_name_pattern = ".first.bRelatedList .list tr:nth-of-type("+$sf_param_substitute+") th"
$sf_active_currencies_section = ".first.bRelatedList"
$sf_label_enable = "Enable"
$sf_enable_button = "input[value='Enable']"
$sf_disable_button = "input[value='Disable']"
$sf_confirm_enable_currency_checkbox = "input[id='enable']"
$sf_active_corporate_currency = "img[title='Checked']"
##################################################
# salesforce user 
##################################################
$sf_all_users_view = "View:"
$sf_all_users_view_active_users = "Active Users"
$sf_user_permission_set_assignment_section = "div[id$='RelatedPermsetAssignmentList']"
$sf_user_permission_set_assignment_delete_link = "tr:nth-of-type(2) a.actionLink"
$sf_permission_set_edit_assignment_button = "Edit Assignments"
$sf_multi_select_add_button = "//img[@alt = 'Add']"
$sf_multi_select_remove_button = "img[alt='Remove']"
$sf_user_permission_set_label = "Permission Set Label"
$sf_user_permission_name_pattern= "//option[@title ='"+$sf_param_substitute+"']"
$sf_profiles_in_manage_users="Profiles"
$sf_custom_tab_setting="//label[text()='"+$sf_param_substitute+"']"
$sf_enabled_user_permissions = "//label[text()='Enabled Permission Sets']/ancestor::div[1]/following::select[1]/option"
$sf_assign_license_Section = "//input[@value='Assign Licenses']/ancestor::table[1]/ancestor::div[2]"
$sf_assign_package_button = "input[value='Assign Licenses']"
$sf_license_pattern = "//span[text()='"+$sf_param_substitute+"']/ancestor::tr[1]/td/input"
$sf_assign_licenses_frame = "iframe[id='available']"
$sf_user_profile_custom_app_setting_checkbox_pattern = "input[title*='#{ORG_PREFIX}"+$sf_param_substitute+"'][type='checkbox']"
$sf_user_role_picklist = "select[name='role']"
$sf_user_role_label = "role"
$sf_users_child = "//*[@id='Users_child']"
$sf_login_as_any_user_checkbox = "//*[contains(@id,'0:adminsCanLogInAsAny')]"
$sf_force_relogin_after_login_as_user = "//label[contains(text(),'Force relogin')]/../input"
$sf_users_login_button = "Login"
$sf_users_login_button_input = "input[value=' Login ']"
##################################################
# salesforce FM community 
##################################################
$sf_fm_community_setting_label = "Communities Settings"
$sf_fm_all_community_setting_label = "All Communities"
$sf_fm_enable_community_checkbox = "input[id$=':enableNetworkPrefId']"
$sf_fm_community_domain_name = "input[id$=':inputSubdomain']"
$sf_fm_community_check_availability_button = "input[id$=':checkAvailability']"
$sf_fm_community_domain_availability_message = "span[class='messageTextStyling']"
$sf_fm_new_community_button = "input[value='New Community']"
$sf_community_template_name_pattern = "//header[text()='"+$sf_param_substitute+"']"
$sf_community_get_started_button = "button[title='Get Started']"
$sf_new_community_name_input = "input[data-name='Name']"
$sf_community_create_button = "button[title='Create']"
$sf_fm_community_administration_link = "//div/strong[text()='Administration']"
$sf_fm_community_members_link = "//span[text()='Members']"
$sf_fm_community_tabs_link = "//span[text()='Tabs']"
$sf_fm_community_tab_name_pattern = "//option[text()='"+$sf_param_substitute+"']"
$sf_fm_community_option_list_pattern = "//option[text()='"+$sf_param_substitute+"']"
$sf_fm_community_object_add_button = "//div[@id='objects'] //img[@alt = 'Add']"
$sf_fm_community_permission_set_add_button = "//div[@id='perm_sets'] //img[@alt = 'Add']"
$sf_community_user_link = "span[class*='chatter-avatar']"
$sf_community_setup_link = "a[title='Setup']"
$sf_community_new_sharing_setting_button = "input[name='newLpuSharingSet']"
$sf_community_configure_access_setup_link_pattern = "//th[text()='"+$sf_param_substitute+"']/ancestor::tr[1]/td[1]/a[text()='Set Up']"
$sf_community_configure_access_setup_iframe="iframe[id*='ContentId']"
$sf_community_configure_access_section= "div[id*='LpuAccessMappingRelatedListData_body']"
$sf_community_permission_set_search_input = "input[id$='permSetFilterSelect']"
$sf_community_permission_set_find_button = "(//input[@title='Find'])[2]"
$sf_community_workspace_label = "Workspaces"
######
$sf_list_view_layout_edit_link = "a[title*='"+$sf_param_substitute+"']"
$sf_list_view_listbox_option = "//option[text()='"+$sf_param_substitute+"']"

$sf_community_iframe = "iframe[name*='vfFrameId']"
$sf_user_name_selector = "//span[@id='userNavLabel']"
$sf_setup_option_pattern = "//a[contains(@class,'menuButtonMenuLink') and text()='#{$sf_param_substitute}']"
$sf_setup_option_switch_to_lightning_experience_label = 'Switch to Lightning Experience'
$sf_feed_tracking_diabled_save_button= "input[id$=':save'][class='btnDisabled']"
# locator to enable/disable lightening component
$sf_lightning_get_started_button = "input[value='Get Started']"
$sf_lightning_turn_on_link = "//span[text()='Turn It On']"
$sf_lightning_enable = "//span[text()='Enabled']"
$sf_lightning_disable = "//span[text()='Disabled']"
$sf_lighting_component_toggle = "span[class='slds-checkbox--faux']"
$sf_lighthing_confirmation_button = "//span[text()='Finish Enabling Lightning Experience']"
$sf_lightening_next_button = "//span[text()='Next Step']"
$sf_lightning_ok_button= "button[title='OK']"
# Load below locators also and override few of the existing if required.
if (ORG_IS_LIGHTNING.downcase == "true")
############################################
#  salesforce Lightning Locators
############################################
	$sf_global_search = "input[class='searchBox input']"
	$sf_object_page_layout_assignment = "div[class*='testOnlyPageLayoutList']  section div[class='bRight'] button:nth-of-type(2)"
	$sf_application_search_button = "input[class*='uiInputSearch']"
	$sf_lightning_new_form_window_close_icon = "span[data-key='close']"
	$sf_lightning_message_box = "div[role='alertdoalog']"
	$sf_lightning_related_list_tab = "a[title='Related']"
	$sf_custom_object_page_table = "div[class$=' pagerContainer pagerPageInfo']"
	$sf_show_feed = "a[title='Collaborate']"
	$sf_show_feed_link = "//span[text()='Collaborate']"
	$sf_lightning_grid_row_edit_link = "a[title='Edit']"
	$sf_lightning_successful_save_message = "span[class*='toastMessage']"
	$sf_lightning_setup_object_manager_search_textbox = "//input[contains(@class,'search-box searchText') and @type = 'search']"
	$sf_object_list_section = "div[class$='objectManagerObjectList']"
############################################
#  salesforce Lightning Labels
############################################
	$sf_setup_create = "Objects and Fields"
	$sf_setup_create_objects = "Object Manager"
	$sf_setup_email_administration = "Email"
end
############################################
#  email administration
############################################
$sf_label_enable = "Enable"
############################################
#  general methods 
############################################

	def SF.wait_less 
		sleep LESS_WAIT
	end 

	def SF.wait_more 
		sleep MORE_WAIT
	end 

	# returns true if org is lightning
	def SF.org_is_lightning
		return ORG_IS_LIGHTNING.downcase == "true"
	end
	
	# returns true if org is encryption
	def SF.org_is_enableencryption
		return ORG_IS_ENCRYPTION_ON.downcase == "true"
	end

	def SF.app appname
		if (!SF.org_is_lightning)
			selected_app = find($sf_application_button).find("#tsidLabel").text
			if (appname !=selected_app)
				find($sf_application_button).click
				find("#tsidMenu").find("#tsid-menuItems").find(:link,"#{appname}").click
			end
		end
	end 

	def SF.tab tabname 
		if (SF.org_is_lightning)
			SFL.tab tabname
		else
			find("#tabBar").find(:link,$sf_tab_all_tabs).click
			gen_accept_alert_if_present
			find("table[class='detailList tabs']").find(:link, "#{tabname}").click
		end
	end 
	
	def SF.admin menu
		if (SF.org_is_lightning)
			SFL.admin menu
		else
			find("#userNavButton").click
			find("#userNav-menuItems").find(:link,"#{menu}").click
		end
	end 

	def SF.get_std_view_field field_label
		return find(:xpath, $sf_std_view_field_content.gsub('#', field_label)).text
	end

	def SF.select_view viewname 
		SF.retry_script_block do
			if (SF.org_is_lightning)
				SFL.select_view viewname
			else
				select(viewname, :from => 'fcf')
			end
		end
	end 
	
	def SF.get_current_view 
		selected_view = find($sf_select_view).text
		return selected_view
	end 
	
	def SF.select_product_view prodviewname 
		select(prodviewname, :from => 'fcf_product')
	end 
	
	def SF.login username , password 
		# To Access login page
		visit "https://login.salesforce.com"
		gen_accept_alert_if_present
		page.has_text?("Username")
		fill_in "username", :with => username
		fill_in "password", :with => password
		click_button "Login"
		page.has_css?($sf_application_button)
	end 
	
	def SF.logout 
		puts "Logout from Application.."
		SF.admin $sf_logout
		gen_accept_alert_if_present
		page.has_button?("Login")
	end 

	def SF.next_page
		find($sf_bottom_navigation).find($sf_bottom_navigation_prevnextlinks).find($sf_bottom_navigation_prevnextlinks_next_page).click 
	end 

	def SF.previous_page
		find($sf_bottom_navigation).find($sf_bottom_navigation_prevnextlinks).find($sf_bottom_navigation_prevnextlinks_previous_page).click 
	end

	def SF.first_page
		find($sf_bottom_navigation).find($sf_bottom_navigation_prevnextlinks).find($sf_bottom_navigation_prevnextlinks_first_page).click 
	end

	def SF.last_page
		find($sf_bottom_navigation).find($sf_bottom_navigation_prevnextlinks).find($sf_bottom_navigation_prevnextlinks_last_page).click 
	end

	def SF.wait_for_search_button
		for i in 1..MAX_RETRY_COUNT do
			begin
				page.has_css?($sf_application_search_button)
			rescue Timeout::Error => e
				puts "Time Out Error in SF.wait_for_search_button with exception :#{e}"
				puts "retrying it " + i.to_s
			rescue
				break
				#do Nothing
			else
				break
			end
		end
	end

	def SF.click_edit_link_by_element_title element_title
		edit_link = $sf_element_edit_link.gsub($sf_param_substitute, element_title)
		find(:xpath, edit_link).click
	end
	# set the value for global search in setup
	def SF.set_global_search search_text 
		SF.admin $sf_setup
		find($sf_global_search).set search_text 
	end
############################################	
# Log Info message if DEBUGGING_MESSAGES = true in config_helper
############################################	
	def SF.log_info info_message
		if DEBUGGING_MESSAGES
			puts "Debug:#{info_message}"
		end
	end
############################################	
#process_block
############################################	
#retrying block of code mutiple time if it failed 
#Param @block : block of code to retry

	def SF.retry_script_block (&block)
		success_status=false
		excep=nil
		for i in 1..MAX_RETRY_COUNT do
			begin
				block.call()
			rescue Exception=>e
				SF.log_info "SF.retry_script_block failed in attempt #{i} with message #{e}"
				excep=e
			else
				success_status=true
				break
			end
		end
		if(success_status ==false)
			puts "SF.retry_script_block failed in all try"
			raise excep
		end
	end
	
	def SF.select_records_per_page no_of_records_to_display
		if (!SF.org_is_lightning)
			find($sf_select_records_per_page_icon).click
			find(:xpath, $sf_records_per_page_pattern.sub($sf_param_substitute, no_of_records_to_display)).click
			gen_wait_less # it takes 1-2 seconds for account table to load all account names as per page selected.
		end
	end

	# get the h1 property of page
	def SF.get_page_title 
		return find($sf_page_title).text 
	end 
	# get the h2 property of page
	def SF.get_page_header
		return find($sf_page_header).text 
	end
	# get page description 
	def SF.get_page_description
		return find($sf_page_description).text
	end
############################################
#  Below method will wait for all apex job to get complete.
#  It will wait for jobs to complete for a definite period of time(MAX_RETRY_COUNT_APEX_JOB = 50 i.e approx 18-20 mins).
#  If batch job is not completed in definite period of time, It will skip the check and move to next step of script.
############################################
	def SF.wait_for_apex_job
		is_status_complete = true
		retry_count=1
		# # Wait for Apex Job to complete.
		while(is_status_complete and retry_count <= MAX_RETRY_COUNT_APEX_JOB) do
			is_status_complete = false
			SF.wait_more
			puts "Iteration:#{retry_count} - Waiting for Apex Job to finish"
			SF.view_apex_job
			SF.execute_script do
				if page.has_no_text?($sf_msg_no_records_to_display,:wait => LESS_WAIT)
					apex_job_line_data = all($sf_batch_process_rows).to_a
					for i in 1..apex_job_line_data.length
						current_row = apex_job_line_data.shift
						actual_line_value = current_row.text
						if((actual_line_value.include? $sf_batch_process_status_in_progress) || (actual_line_value.include? $sf_batch_process_status_preparing) || (actual_line_value.include? $sf_batch_process_status_holding) || (actual_line_value.include? $sf_batch_process_status_queued))
							is_status_complete = true
							SF.log_info "Row #{i} : Wait for #{actual_line_value} status to get completed.Exist #{apex_job_line_data.length}"
							break
						end
					end
				end
			end
			retry_count+=1
		end 
	end
 
	def SF.view_apex_job
		if (SF.org_is_lightning)
				SFL.view_apex_job
		else
			SF.retry_script_block do
				SF.admin $sf_setup
				apex_job = "Apex Jobs"
				find(:css, $sf_global_search).set apex_job
				click_link apex_job
				SF.wait_for_search_button
			end
		end
	end

############################################
#  method to enable feed tracking for objects
#  object_locator = locator of object for which feed tracking need to be enabled
#  value_to_set- user want to check or uncheck the settings
#  pass "true" to check and "false" to unset
############################################
	def SF.set_feed_tracking object_locator, value_to_set
		SF.execute_script do
			SF.admin $sf_setup
			find($sf_global_search).set $ffa_label_feed_tracking
			click_link $ffa_label_feed_tracking
			SF.retry_script_block do
				SF.execute_script do
					click_link object_locator
				end
			end
			SF.wait_less # section when checkbox is displayed take 1-2 seconds to load.		
			SF.retry_script_block do
				SF.execute_script do
					if value_to_set == "true"
						find($ffa_enable_feed_tracking_checkbox).set(true)
					elsif value_to_set == "false"
						find($ffa_enable_feed_tracking_checkbox).set(false)
					end
				end
			end
			SF.wait_less
			SF.retry_script_block do
				SF.click_feed_tracking_save_button
			end
		end	
	end

############################################
# click on feed tracking save button
############################################
	def SF.click_feed_tracking_save_button
		if(page.has_css?($sf_feed_tracking_diabled_save_button))
			puts "Cannot click on save button. Button is disabled as checkbox is already in required state."
		else
			SF.click_button 'Save'
			SF.wait_for_search_button
		end
	end
############################################
# standard sales force button
############################################

	def SF.click_button_new
		if (SF.org_is_lightning)
			find($sfl_new_button).click
		else
			click_button('New')
		end
	end 

	def SF.click_button_edit
		SF.execute_script do
			if (page.has_css?($sfl_edit_button))
				find($sfl_edit_button).click
			else
				first(:button, 'Edit').click
			end
		end
	end

	def SF.click_button_save
		SF.execute_script do
			# to click on button with exact label
			first(:button, 'Save' , exact: true).click
		end
		# for standard object, waiting for new/edit form to disappear before next step is executed.
		if (SF.org_is_lightning)
			page.has_css?($sf_lightning_successful_save_message)
		end
	end 

	def SF.click_button_save_new
		first(:button, 'Save & New').click
	end 

	def SF.click_button_delete
		first(:button, 'Delete').click
	end 

	def SF.click_button_cancel
		SF.execute_script do
			first(:button, 'Cancel').click
		end
	end 

	def SF.click_button_clone
		first(:button, 'Clone').click
	end 
	
	def SF.click_button_go
		if page.has_css?($sf_go_button ,:wait => DEFAULT_LESS_WAIT)
			find($sf_go_button).click
			page.has_css?($sf_refresh_button)
		elsif page.has_css?($sf_lookup_go_button,:wait => DEFAULT_LESS_WAIT) # to click on Go button present on look-up
			find($sf_lookup_go_button).click
			page.has_text?($sf_lookup_search_results_text,:wait => DEFAULT_LESS_WAIT)
		end 
		
	end 
	
	def SF.click_button_product_go
		within ("form#filter_element_product") do 
			click_button('Go!')
		end 
	end
	
	def SF.click_button_add_to_price_book 
		click_button ('Add to Price Book')
	end 
	
	def SF.click_button sf_button_name
		SF.retry_script_block do
			SF.execute_script do
				page.has_button?(sf_button_name)
				first(:button, sf_button_name).click
			end
		end
	end

	def SF.click_link sf_link_name
		SF.retry_script_block do
			SF.execute_script do
				super sf_link_name
			end
		end
	end
	
	def SF.select_element_from_lookup sf_lookup_button_alt_name,search_value
		lookup_field = $sf_lookup_icon_pattern.gsub(""+$sf_param_substitute+"", sf_lookup_button_alt_name)
		find(:xpath,lookup_field).click
		SF.wait_less 
		FFA.wait_page_message $ffa_msg_retrieving_account_information
		within_window(windows.last) do
			page.driver.browser.switch_to.frame $sf_search_frame
			fill_in $sf_search_frame_input_id, with: search_value
			page.click_button 'Go!'
			SF.retry_script_block do
				page.driver.browser.switch_to.default_content
				page.driver.browser.switch_to.frame $sf_results_frame
			end
			page.click_link search_value
		end
	end
############################################
# setup remote site settings
############################################
	
	def SF.remote_site_settings_create_new
		SF.admin $sf_setup
		SF.wait_for_search_button
		SF.click_link "Security Controls"
		SF.click_link "Remote Site Settings"
		SF.wait_for_search_button
		SF.click_button "New Remote Site"
	end

	def SF.remote_site_settings_set_site_name site_name
		fill_in "SiteName" , :with => site_name
	end

	def SF.remote_site_settings_set_site_url site_url
		fill_in "EndpointUrl" , :with => site_url
	end

	def SF.remote_site_settings_set_disable_protocol_security is_checked
		if is_checked == "true"
			find($sf_remote_site_setting_disable_protocol_security).set(true)
		else
			find($sf_remote_site_setting_disable_protocol_security).set(false)
		end
	end

###################################
# edit layout to add fields or button on layout of custom objects
# object_name = Name of the object on which fields/button need to be added.
# page_layout_name = name of the layout of object on which field/button need to be added.
# layout_panel = location path of the panel from where field/button need to be added. 
#				 ($sf_layout_panel_fields= for adding field , $sf_layout_panel_button= to add button).
# field_name_list = list of fields or button as array which need to be added on layout.
# target_location = location where field/button need to be added.
#                  ($sf_edit_page_layout_target_position for adding field ,$sf_edit_page_layout_target_position_button for adding button)
###################################
	def SF.edit_layout_add_field object_name, page_layout_name, layout_panel, field_name_list, target_location
		source_path_pattern= $sf_edit_page_layout_source_field_pattern	
		page_layout_edit_link_pattern = $sf_page_layout_edit_link_pattern
		SF.admin $sf_setup 
		SF.click_link $sf_setup_create
		SF.click_link $sf_setup_create_objects
		within($sf_create_objects_list_section) do
			SF.click_link object_name
		end
		page_layout_edit_link = page_layout_edit_link_pattern.gsub(""+$sf_param_substitute+"", page_layout_name)
		find(:xpath, page_layout_edit_link).click
		page.has_css?($sf_edit_page_layout_quick_find_text_box_field) 
		# To close the pop up which comes first time while changing layout.
		if (!page.has_no_xpath?($sf_add_layout_reports_chart_popup))
			find(:xpath,$sf_add_layout_reports_chart_popup).click
			sleep 1 # to ensure the pop-up disappears from screen.
		end
		field_name_list.each do |field|
			button_added = false
			field_added = false
			source_path = source_path_pattern.gsub(""+$sf_param_substitute+"", field)
			within($sf_body_cell) do
				find(layout_panel).click
				find($sf_edit_page_layout_quick_find_text_box_field).set(field)
				field_complete_name= field
				if (field.size > 20)
					field = field[0..16]
					source_path = $sf_edit_page_layout_source_field_pattern.gsub(""+$sf_param_substitute+"", field+"...")
				end    
				if(target_location[0] == '/')
					target = find(:xpath, target_location)
				else 
					target = find(target_location)
				end
				SF.retry_script_block do
					source = first(:xpath, source_path)
					source.drag_to(target)
					SF.wait_less
					# Check if field/button is added on layout or not.
					if (layout_panel == $sf_layout_panel_button)
						button_added = page.has_xpath?($sf_layout_custom_button_added_successfully_on_layout_pattern.sub($sf_param_substitute,field_complete_name),:wait => LESS_WAIT)
						SF.log_info "Added #{field_complete_name} on layout:  #{button_added}"
					end
					if (layout_panel == $sf_layout_panel_fields)
						field_added = page.has_xpath?($sf_layout_field_added_successfully_on_layout_pattern.sub($sf_param_substitute,field_complete_name),:wait => LESS_WAIT)
						SF.log_info "Added #{field_complete_name} on layout:  #{field_added}"	
					end					
					# Check if field or button is added successfully or not.
					if (field_added || button_added)
						puts "field/button  #{field_complete_name} added successfully on layout."
						break
					else
						# try again after scrolling down the page before raising/retrying the operation.
						SF.log_info ": Field/button- #{field_complete_name} not added successfully on layout.Scrolling the page...."
						SF.scroll_line_up 15
						raise "ERROR:Field/button- #{field_complete_name} not added successfully on layout."
					end
				end
				# Scroll page to up before adding next field on layout.
				SF.scroll_page_up 2
			end
		end
		SF.click_button_save
		page.has_xpath?(page_layout_edit_link)
	end

###################################
# edit layout to add fields or button on layout of standard objects
# object_name = Name of the object on which fields/button need to be added.
# page_layout_name = name of the layout of object on which field/button need to be added.
# layout_panel = location path of the panel from where field/button need to be added. 
#				 ($sf_layout_panel_fields= for adding field , $sf_layout_panel_button= to add button).
# field_name_list = list of fields or button as array which need to be added on layout.
# target_location = location where field/button need to be added.
#                  ($sf_edit_page_layout_target_position for adding field ,$sf_edit_page_layout_target_position_button for adding button)
###################################
	def SF.stdobj_edit_layout_add_field object_name, page_layout_name, layout_panel, field_name_list, target_location
		source_path_pattern= $sf_edit_page_layout_source_field_pattern
		page_layout_edit_link_pattern = $sf_page_layout_edit_link_pattern
		SF.admin $sf_setup	
		SF.click_link $sf_setup_customize
		within($sf_customize_child_objects_section) do
			SF.click_link object_name
			SF.click_link $sf_setup_customize_stdobj_layout
		end
		page_layout_edit_link = page_layout_edit_link_pattern.gsub(""+$sf_param_substitute+"", page_layout_name)
		find(:xpath, page_layout_edit_link).click
		page.has_css?($sf_edit_page_layout_quick_find_text_box_field)
		# To close the pop up which comes first time while changing layout.
		if (!page.has_no_xpath?($sf_add_layout_reports_chart_popup)) 
			find(:xpath,$sf_add_layout_reports_chart_popup).click
			sleep 1 # to ensure the pop-up disappears from screen.
		end
		field_name_list.each do |field|	
			button_added = false
			field_added = false
			source_path = source_path_pattern.gsub(""+$sf_param_substitute+"", field)	
			SF.wait_for_search_button
			within($sf_body_cell) do
				find(layout_panel).click
				find($sf_edit_page_layout_quick_find_text_box_field).set(field)
				SF.wait_less # So that values are filtered which need to be add on layout.
				field_complete_name= field
				if (field.size > 20)
					field = field[0..16]
					source_path = $sf_edit_page_layout_source_field_pattern.gsub(""+$sf_param_substitute+"", field+"...")
				end				
				if(target_location[0] == '/')
					target = find(:xpath, target_location)
				else			
					target = find(target_location)
				end
				SF.retry_script_block do
					source = first(:xpath, source_path)
					source.drag_to(target)
					SF.wait_less
					# Check if field/button is added on layout or not.
					if (layout_panel == $sf_layout_panel_button)
						button_added = page.has_xpath?($sf_layout_custom_button_added_successfully_on_layout_pattern.sub($sf_param_substitute,field_complete_name),:wait => LESS_WAIT)
						SF.log_info "Added #{field_complete_name} on layout:  #{button_added}"
					end
					if (layout_panel == $sf_layout_panel_fields)
						field_added = page.has_xpath?($sf_layout_field_added_successfully_on_layout_pattern.sub($sf_param_substitute,field_complete_name),:wait => LESS_WAIT)
						SF.log_info "Added #{field_complete_name} on layout:  #{field_added}"
					end
					# expect field to get added on layout
					if (field_added || button_added)
						puts "field/button  #{field_complete_name} added successfully on layout."	
					else
						# try again after scrolling down the page before raising/retrying the operation.
						SF.log_info " Field/button- #{field_complete_name} not added successfully on layout.Scrolling on page...."
						SF.scroll_line_up 15
						raise "ERROR:Field/button- #{field_complete_name} not added successfully on layout."
					end
				end
				# Scroll page to up before adding next field on layout.
				SF.scroll_page_up 2
			end
		end
		SF.click_button_save
		page.has_xpath?(page_layout_edit_link)
	end
###################################
# edit layout to remove button from page layout
# object_name = Name of the object on which fields/button need to be added.
# page_layout_name = name of the layout of object on which field/button need to be added.
# button_label = button label which needs to be removed from layout.
# button_type = type of button which could be either Custom or Standard, choose from $sf_label_custom and $sf_label_standard
###################################
	def SF.edit_layout_remove_button object_name, page_layout_name, button_label, button_type
		page_layout_edit_link_pattern = $sf_page_layout_edit_link_pattern
		SF.admin $sf_setup 
		SF.click_link $sf_setup_create
		SF.click_link $sf_setup_create_objects
		within($sf_create_objects_list_section) do
			SF.click_link object_name
		end
		page_layout_edit_link = page_layout_edit_link_pattern.gsub(""+$sf_param_substitute+"", page_layout_name)
		find(:xpath, page_layout_edit_link).click
		page.has_css?($sf_edit_page_layout_quick_find_text_box_field) 
		# To close the pop up which comes first time while changing layout.
		if (!page.has_no_xpath?($sf_add_layout_reports_chart_popup))
			find(:xpath,$sf_add_layout_reports_chart_popup).click
			sleep 1 # to ensure the pop-up disappears from screen.
		end
		within($sf_body_cell) do
			find($sf_layout_panel_button).click
			if(button_type == $sf_label_custom)
				source_path = $sf_edit_layout_custom_button_position_detail_section.sub(""+$sf_param_substitute+"", button_label)
			elsif(button_type == $sf_label_standard)
				source_path = $sf_edit_layout_standard_button_position_detail_section.sub(""+$sf_param_substitute+"", button_label)
			end	
			target_location = $sf_edit_layout_element_position_in_editor_section.sub(""+$sf_param_substitute+"", button_label)
			target = find(:xpath, target_location)
			target.click
			source = find(:xpath, source_path)
			SF.wait_less
			SF.retry_script_block do
				source.drag_to(target)
				SF.wait_less
			end	
		end
		SF.click_button_save
		page.has_xpath?(page_layout_edit_link)	
	end

###################################
# Edit Object View	
###################################
	def SF.edit_list_view view_name, field_name, field_position_to_set
		# In lighting org, required columns are already available in view.
		if (!SF.org_is_lightning)
			SF.select_view view_name
			SF.click_button_go
			find($sf_list_view_edit_link).click
			SF.wait_for_search_button
			num_of_displayed_fields = all($sf_edit_view_selected_fields_to_display)
			puts "Number of fields: #{num_of_displayed_fields.count}"
			option_num = 2
			while option_num <= num_of_displayed_fields.count
				option_value = find($sf_edit_view_selected_fields_to_display+":nth-of-type(#{option_num})").text
				if field_name == option_value
					find(:xpath, $sf_edit_view_selected_field_pattern.sub(""+$sf_param_substitute+"", field_name)).click
					find($sf_edit_view_top_img_icon).click
					field_position = 1
					while field_position < field_position_to_set
						find($sf_edit_view_down_img_icon).click
						field_position += 1
					end	
					break
				end
				option_num += 1
			end
			SF.click_button_save
			page.has_text?("Action")
		end
	end

################################################
# Create New custom setting and set its property
################################################
	def SF.new_custom_setting custom_setting_label
		SF.admin $sf_setup
		find($sf_global_search).set $sf_setup_develop_custom_setting
		SF.click_link $sf_setup_develop_custom_setting
		SF.wait_for_search_button
		custom_setting_manage_link = $sf_custom_setting_manage.gsub($sf_param_substitute, custom_setting_label)
		SF.execute_script do
			page.has_xpath?(custom_setting_manage_link)
			find(:xpath , custom_setting_manage_link).click
		end
		SF.wait_for_search_button
		edit_button_exist = false
		SF.execute_script do
			edit_button_exist = page.has_button?($sf_edit_button)
		end
		if(edit_button_exist)
			SF.click_button $sf_edit_button
		else
			SF.click_button $sf_new_button
		end
		page.has_button?('Save')
	end
#set value of custom setting property, provided property is of input type (text/checkbox)
	def SF.set_custom_setting_property property_name, property_value
		custom_setting_property_name = $sf_custom_setting_property.gsub($sf_param_substitute, property_name)
		SF.execute_script do
			find(:xpath, custom_setting_property_name).set property_value
		end
	end 	

############################################
# Create new field
############################################
# Create new text type field
# object_name : object on which field needs to be created
# field_label : label you want to provide in Field Label field
# field_length : Length of text type field which you want to set
############################################
	def SF.create_text_type_field object_name, field_label, field_length
		SF.admin $sf_setup
		SF.click_link $sf_setup_create
		SF.click_link $sf_setup_create_objects
		SF.wait_for_search_button
		SF.click_link object_name
		SF.wait_for_search_button
		SF.click_link $sf_custom_fields_and_relationships_link
		within($sf_custom_field_relationship_section) do
			SF.click_button_new
		end
		choose($sf_data_type_text)
		SF.click_button $sf_next_button
		SF.wait_for_search_button
		page.has_link?("Show Formula Editor")
		fill_in $sf_field_label, :with => field_label
		fill_in $sf_field_length, :with => field_length
		find($sf_field_name).click
		SF.click_button $sf_next_button
		# Create new custom field only when the field is not already created on org.
		if (!page.has_text?($ffa_msg_custom_field_already_present_error_msg))
			puts "Creating a new field #{field_label} on object #{object_name}"
			find($sf_fls_visible_select_all).set true
			SF.click_button $sf_next_button
			check($sf_add_page_layouts_add_field)
			SF.click_button_save
			SF.wait_for_search_button
		else	
			puts "#{field_label} is already created on #{object_name}."
		end	
	end
	
	
	
############################################
# Create new field 
############################################
# Create new field - types text, date, and look_up
# object_name : object on which field needs to be created
# related_object - related object name required for lookup
# field_label : label you want to provide in Field Label field
# field_length : Length of text type field which you want to set (for Text field)
############################################
	def SF.create_new_field data_type, object_name, related_object , field_label, field_name , field_length
		SF.admin $sf_setup
		SF.click_link $sf_setup_create
		SF.click_link $sf_setup_create_objects
		SF.wait_for_search_button
		SF.click_link object_name
		SF.wait_for_search_button
		SF.click_link $sf_custom_fields_and_relationships_link
		within($sf_custom_field_relationship_section) do
			SF.click_button_new
		end
		
		choose(data_type)
		SF.click_button $sf_next_button
		if data_type == $sf_data_type_lookup_relationship
			page.has_css?($sf_related_to_object_list)
			select related_object, :from => $sf_related_to_object_list			
			SF.click_button $sf_next_button
		end		
		SF.wait_for_search_button
		page.has_link?("Show Formula Editor")
		fill_in $sf_field_label, :with => field_label
		find($sf_field_name).click
		if field_name != ""
			find($sf_field_name).set field_name
		end
		
		if data_type == $sf_data_type_text
			fill_in $sf_field_length, :with => field_length
		end
				
		SF.click_button $sf_next_button
		# Create new custom field only when the field is not already created on org.
		if (!page.has_text?($ffa_msg_custom_field_already_present_error_msg))
			puts "Creating a new field #{field_label} on object #{object_name}"
			find($sf_fls_visible_select_all).set true
			SF.click_button $sf_next_button
			check($sf_add_page_layouts_add_field)
			if page.has_button?($sf_next_button)
				SF.click_button $sf_next_button
			end
			SF.click_button_save
			SF.wait_for_search_button
		else	
			puts "#{field_label} is already created on #{object_name}."
		end	
	end

############################################
# Make field required/ non required
############################################
# Make text type field required
# object_name : object on which field needs to be required
# field_api_name : api_name of field, e.g. Line_descripton__c
# required : true - to make required , false to make it non required field
############################################
	def SF.make_field_required object_name, field_api_name, required
		SF.retry_script_block do 
			SF.admin $sf_setup
			SF.click_link $sf_setup_create
			SF.click_link $sf_setup_create_objects
			SF.wait_for_search_button
			SF.click_link object_name
			SF.wait_for_search_button
			
			within($sf_custom_field_relationship_section) do
				find($sf_field_with_title.gsub($sf_param_substitute, field_api_name)).click
			end
			
			page.has_css?($sf_always_required_radio_button)
			find($sf_always_required_radio_button).set(required)
			if page.has_button?($sf_confirm_button)
				SF.click_button $sf_confirm_button				
			end
			
			SF.click_button_save
			SF.wait_for_search_button
		end
	end
###############################################
#Check Field exists on Object or not
###############################################	
def SF.is_object_field_exists object_name, field_label
	SF.admin $sf_setup
	SF.click_link $sf_setup_create
	SF.click_link $sf_setup_create_objects
	SF.wait_for_search_button
	SF.click_link object_name
	SF.wait_for_search_button
	#Check Field already exists on Object or not
	return page.has_link?(field_label)
end

###############################################
# Create currency
###############################################
	def SF.create_currency currency_type, conv_rate, decimal_places
		SF.admin $sf_setup
		SF.click_link $sf_setup_company_profile
		SF.click_link $sf_setup_manage_currencies
		SF.click_button $sf_new_currency_button
		select currency_type, :from => $sf_new_curr_currency_type
		fill_in $sf_new_curr_conversion_rate, :with => conv_rate
		fill_in $sf_new_curr_decimal_places, :with => decimal_places
		SF.click_button_save
	end
	
	def SF.is_active_currency currency_type
		SF.admin $sf_setup
		SF.click_link $sf_setup_company_profile
		SF.click_link $sf_setup_manage_currencies
		within($sf_active_currencies_section) do
			Array rows_list = all($sf_grid_rows)
			for i in 2..rows_list.size do
				_currency_name = find($sf_currency_name_pattern.gsub($sf_param_substitute, i.to_s)).text
				if (_currency_name == currency_type)
					return true
				end
			end
			return false
		end
	end
	
#############################
# manage currency
#############################
	# Enable advance currency management
	def SF.enable_adv_currency_management
		# Enable the currency ,if already not aenable
		if (page.has_css?($sf_enable_button,:wait => LESS_WAIT))
			find($sf_enable_button).click
			within_window(windows.last) do
				SF.retry_script_block do
					find($sf_confirm_enable_currency_checkbox).set true
					find($sf_enable_button).click
				end
			end
		else
			puts "Advance Currency Management is already enabled"
		end
		SF.wait_for_search_button
	end
	
	# Enable Parenthetical Currency Conversion
	def SF.enable_parenthetical_currency_conversion
		# Enable the currency ,if already not aenable
		if (page.has_css?($sf_enable_button,:wait => LESS_WAIT))
			find($sf_enable_button).click
		else
			puts "Parenthetical Currency Conversion is already enabled"
		end
	end
#############################
# User management
#############################	
# User permission set assignment
	def SF.set_user_permission_set_assignment permission_set_names, user_name, exclusive_delete_all
		if(exclusive_delete_all == true)
			SF.delete_all_permission_set_assignment_if_exists user_name
			SF.wait_for_search_button
		end
		SF.admin $sf_setup
		# view user page
		if (SF.org_is_lightning)
			SFL.view_users
		else
			SF.click_link $sf_setup_manage_users
			SF.wait_for_search_button
			SF.click_link $sf_setup_manage_users_users
			SF.wait_for_search_button
		end
		page.has_text?(user_name,:wait => LESS_WAIT)
		# view all available users
		SF.execute_script do
			SF.retry_script_block do
				select $sf_all_users_view_active_users, :from => $sf_all_users_view
			end
		end
		# click on user name to view detail page
		SF.execute_script do
			SF.click_link user_name
		end
		SF.retry_script_block do
			SF.execute_script do
				# Edit permission set
				within($sf_user_permission_set_assignment_section) do
					SF.click_button $sf_permission_set_edit_assignment_button
				end
			end
		end
		SF.execute_script do
			# Assign permission set
			permission_set_names.each do |permission_set|
				find(:xpath, $sf_user_permission_name_pattern.sub($sf_param_substitute ,permission_set )).click
				find(:xpath, $sf_multi_select_add_button).click
			end
		end
		#end
		SF.click_button_save
	end
# Delete all permission set assignment if exists	
	def SF.delete_all_permission_set_assignment_if_exists user_name
		SF.admin $sf_setup
		# view users of org
		if (SF.org_is_lightning)
			SFL.view_users
		else
			SF.click_link $sf_setup_manage_users
			SF.wait_for_search_button
			SF.click_link $sf_setup_manage_users_users
			SF.wait_for_search_button
		end
		# select all users
		SF.execute_script do	
			SF.retry_script_block do
				select $sf_all_users_view_active_users, :from => $sf_all_users_view
			end
		end
		# click on user
		SF.execute_script do
			SF.click_link user_name
		end
		# click on edit permission button to edit permission set
		SF.retry_script_block do
			SF.execute_script do
				page.has_css?($sf_user_permission_set_assignment_section)
				# Edit permission set
				within($sf_user_permission_set_assignment_section) do
					SF.click_button $sf_permission_set_edit_assignment_button
				end
			end
		end
		# remove all enabled permission for user
		SF.retry_script_block do
			SF.execute_script do
				page.has_xpath?($sf_enabled_user_permissions)
				assigned_permission_num = all(:xpath,$sf_enabled_user_permissions).count
				row = 1 
				while row <= assigned_permission_num
					find(:xpath ,$sf_enabled_user_permissions + "[1]" ).click
					find($sf_multi_select_remove_button).click
					row+=1
				end
			end
		end
		SF.click_button_save
	end

###############################################
# Set Bcc email
# enable_true (boolean value) : enable or disable Bcc email functionality 
###############################################
	def SF.set_bcc_email mail_id, enable_true
		SF.admin $sf_setup
		SF.click_link $sf_setup_email_administration 
		page.has_link?($sf_setup_email_admin_compliance_bcc_email)
		SF.click_link $sf_setup_email_admin_compliance_bcc_email
		SF.execute_script do
			page.has_xpath?($sf_bcc_email_enable_checkbox)
			checkbox_id = find(:xpath,$sf_bcc_email_enable_checkbox)[:for]
			if(enable_true == true)
				check(checkbox_id)
			else
				uncheck(checkbox_id)
			end
			fill_in $sf_setup_email_admin_compliance_bcc_email, :with => mail_id
		end
		SF.click_button_save
	end
###################################
# edit layout for Object to extended or normal layout
###################################
	def SF.edit_extended_layout object_name, profile_name, layout_name
		SF.retry_script_block do 
			SF.admin $sf_setup 
			# If org is lightning, search the link and click on it.
			if (SF.org_is_lightning)
				SF.retry_script_block do
					SF.set_global_search $sf_setup_create_objects
				end
			else
				SF.click_link $sf_setup_create
			end
			SF.click_link $sf_setup_create_objects
			# wait for all the object to load on page
			page.has_css?($sf_custom_object_page_table)
			#It will filter the result and display the object which is searched.
			if (SF.org_is_lightning)
				SF.retry_script_block do
					page.has_xpath?($sf_lightning_setup_object_manager_search_textbox)
					find(:xpath , $sf_lightning_setup_object_manager_search_textbox).set object_name
					page.has_link?(object_name)
				end
			end
			SF.retry_script_block do
				within($sf_object_list_section) do 
					SF.click_link object_name
				end
			end
			page.has_css?($sf_object_page_layout_assignment)
			find($sf_object_page_layout_assignment).click
			SF.execute_script do
				find($sf_object_edit_assignment).click
				record_to_select = $sf_edit_page_layout_select_record.gsub($sf_param_substitute,profile_name)
				page.has_xpath?(record_to_select)
				within($sf_edit_page_layout_list_window) do
					find(:xpath, record_to_select).click
				end 
				find($sf_edit_page_layout_selector).select layout_name
			end
			SF.click_button_save
			SF.wait_for_search_button 
		end
	end
###################################
# edit button properties
################################### 
	def SF.object_button_edit object_name, button_name
		SF.retry_script_block do 
			SF.admin $sf_setup 
			if (SF.org_is_lightning)
				SFL.object_button_edit object_name, button_name
			else
				SF.click_link $sf_setup_create
				SF.click_link $sf_setup_create_objects
				SF.wait_for_search_button
				SF.click_link object_name
				SF.wait_for_search_button
				rows_in_action_grid = all($sf_object_button_list).count
				row_num =1
				while row_num <= rows_in_action_grid
					button = $sf_object_button.sub($sf_param_substitute,row_num.to_s)
					label_text = find(button).text
					if button_name == label_text 
						edit_button = $sf_object_button_edit.sub($sf_param_substitute,row_num.to_s)
						find(edit_button).click
						break
					end
					row_num+=1 
				end
			end
		end
	end

	# following method (set_button_standard_salesforce) is applicable only on managed org
	def SF.set_button_standard_salesforce
		SF.execute_script do
			find($sf_object_button_standard_salesforce).click
		end
		SF.click_button_save
		SF.wait_for_search_button
	end
 
	def SF.choose_no_override_and_save
		SF.execute_script do
			find($sf_no_override_radio_button).click
			first(:button, 'Save').click
			SF.alert_ok
		end
	end
	
	def SF.choose_visualforce_page _visualforce_page_name
		SF.execute_script do
			choose($sf_visualforce_page_label)		
			find($sf_button_property_visualforce_page_dropdown).find(:xpath, $sf_button_property_visualforce_page_option.sub($sf_param_substitute, _visualforce_page_name)).select_option
		end
		SF.click_button_save
	end

# change button property to set it for extended layout as per type of ORG
	def SF.set_button_property_for_extended_layout
		if (ORG_TYPE == UNMANAGED or ORG_IS_NAMESPACE == "true")
			SF.choose_no_override_and_save
		else 
			SF.set_button_standard_salesforce
		end
	end
	
	# change button property to set it for visual force page layout as per type of ORG
	# pass vf_page_name as null when org type is managed.
	def SF.set_button_property_for_visualforce_page_layout vf_page_name
		if (ORG_TYPE == UNMANAGED or ORG_IS_NAMESPACE == "true")
			SF.choose_visualforce_page vf_page_name
		else 
			SF.choose_no_override_and_save
		end
	end
###########################################
# Handle SF Alert
###########################################
	def SF.alert_ok
		if page.driver.class == Capybara::Selenium::Driver
			page.driver.browser.switch_to.alert.accept
		elsif page.driver.class == Capybara::Webkit::Driver
			page.driver.switch_to.alert.accept
		end 
		SF.wait_less
	end
##########################################
# Delete custom field from object
##########################################
	def SF.delete_custom_field object_name, field_label
		SF.admin $sf_setup 
		SF.click_link $sf_setup_create
		SF.click_link $sf_setup_create_objects
		SF.click_link object_name
		SF.wait_for_search_button
		find(:xpath, $sf_custom_field_delete_link_pattern.sub($sf_param_substitute, field_label)).click
		within_window(->{ page.title == $sf_custom_field_delete_confirm_popup_title }) do
			check($sf_custom_field_delete_confirm_label)
			find($sf_custom_field_confirm_delete_button).click
			SF.wait_for_search_button
		end
	end
###########################################
# Show feed content
###########################################
	def SF.click_show_feed
		SF.on_chatter_feed do
			if page.has_css?($sf_show_feed, :wait => DEFAULT_LESS_WAIT)
			   find(:xpath,$sf_show_feed_link).click
			   sleep 1 # so that feed part is shown properly
			end
		end
	end
# to perform operation on chatter feed. 
# On lightning org, feed are displayed under chatter section.
	def SF.on_chatter_feed (&block)
		if (SF.org_is_lightning)
			SF.retry_script_block do
				find("a[class='tabHeader'][title='Chatter']").click
			end
		end
		block.call()
	end
###########################################
# Handle Tab hide or show feature from Tab Settings dropdown.
# 1: Default Off
# 2: Default On
# 3: Tab Hidden
###########################################
	def SF.display_tab_in_All_Tabs tab_name,display_flag
		SF.set_global_search $sf_profiles_in_manage_users
		SF.click_link $sf_profiles_in_manage_users
		SF.select_records_per_page "100"
		SF.click_link $bd_user_admin_user
		page.has_button?($sf_edit_button)
		SF.click_button $sf_edit_button
		SF.wait_for_search_button
		custom_tab_settings_dropdown = $sf_custom_tab_setting.gsub($sf_param_substitute, tab_name)
		forId = find(:xpath,custom_tab_settings_dropdown)[:for]		
		select(display_flag, :from => forId)
		page.has_button?($sf_save_button)
		SF.click_button $sf_save_button		
	end
#########################################################################
# Retreive first Alphabet of record and call click_on_item_of_listItemPad
#########################################################################
	def SF.listview_filter_result_by_alphabet alphabet_name	
		if (!SF.org_is_lightning)
			first_alphabet = alphabet_name[0].upcase
			alphabet_filter = $sf_alphabet_filter_on_listview.gsub($sf_param_substitute, first_alphabet)
			first(:xpath, alphabet_filter).click
		end
	end

#########################################################################
# check/uncheck user interface setting checkbox
# user_interface_option_names- array of user interface setting
# checkbox_option- true to check and false to uncheck the option
#########################################################################	
	def SF.user_interface_option user_interface_option_names ,checkbox_option
		SF.admin $sf_setup
		find($sf_global_search).set "User Interface"
		SF.click_link "User Interface"
		user_interface_option_names.each do |option|
			page.has_text?(option)
			checkbox_id = find(:xpath , "//label[text()='#{option}']")[:for]
			if checkbox_option 	
				check(checkbox_id)
			else
				uncheck(checkbox_id)
			end
		end
	end
	
#########################################################################
# check/uncheck custom app setting for any profiles
# custom_app_setting_names= list of custom app settings
# profile_name = profile name for which custom app setting need to be updated
# checkbox_option= true to check and false to uncheck
#########################################################################	
	def SF.check_custom_app_setting custom_app_setting_names ,profile_name, checkbox_option
		SF.admin $sf_setup
		find($sf_global_search).set "Profiles"
		SF.click_link "Profiles"
		page.has_button?("New Profile")
		first_character_of_profile = profile_name[0]
		SF.listview_filter_result_by_alphabet first_character_of_profile
		page.has_text?(profile_name)
		SF.click_link profile_name
		SF.click_button $sf_edit_button
		custom_app_setting_names.each do |option|
			page.has_text?(option)
			checkbox_id = find($sf_user_profile_custom_app_setting_checkbox_pattern.sub($sf_param_substitute,option))[:id]
			if checkbox_option 	
				check(checkbox_id)
			else
				uncheck(checkbox_id)
			end
		end
	end
	
	# Change the page Layout for standard Objects.
	# Parameters:
	# object_name = Name of the object.
	# profile_name= Name of the profile  for which page layout need to be assigned.
	# pagelayout_name= Name of the Layout
	def SF.set_page_layout_for_standard_objects object_name,profile_name,pagelayout_name
		SF.admin $sf_setup	
		SF.click_link $sf_setup_customize
		SF.wait_for_search_button
		within($sf_customize_child_objects_section) do
			SF.click_link object_name
			sleep 1 # wait for the options under object name to display.
			SF.click_link $sf_setup_customize_stdobj_layout		
		end
		page.has_css?($sf_object_page_layout_assignment)
		find($sf_object_page_layout_assignment).click
		find($sf_object_edit_assignment).click
		SF.wait_for_search_button
		record_to_select = $sf_edit_page_layout_select_record.gsub($sf_param_substitute,profile_name)
		page.has_xpath?(record_to_select)
		within($sf_edit_page_layout_list_window) do
			find(:xpath, record_to_select).click
		end 
		find($sf_edit_page_layout_selector).select pagelayout_name
		SF.click_button_save
		SF.wait_for_search_button
	end

	# Change the page Layout for Custom Objects.
	# Parameters:
	# object_name = Name of the object.
	# profile_name= Name of the profile  for which page layout need to be assigned.
	# pagelayout_name= Name of the Layout
	def SF.set_page_layout_for_custom_objects object_name,profile_name,pagelayout_name
		SF.admin $sf_setup 
		SF.click_link $sf_setup_create
		SF.click_link $sf_setup_create_objects
		SF.wait_for_search_button
		SF.click_link object_name
		SF.wait_for_search_button
		page.has_css?($sf_object_page_layout_assignment)
		find($sf_object_page_layout_assignment).click
		find($sf_object_edit_assignment).click
		SF.wait_for_search_button
		record_to_select = $sf_edit_page_layout_select_record.gsub($sf_param_substitute,profile_name)
		page.has_xpath?(record_to_select)
		within($sf_edit_page_layout_list_window) do
			find(:xpath, record_to_select).click
		end 
		find($sf_edit_page_layout_selector).select pagelayout_name
		SF.click_button_save
		SF.wait_for_search_button
	end
#########################################################################
# Add column on lookup window
# object_name= Name Of the Object
# add_field_name = name of the field which need to be added on lookup result.
# search_layout_name = name of the search layout in which field need to be add
#########################################################################		
	def SF.add_field_to_search_layout object_name, search_layout_name,add_field_name		
		SF.admin $sf_setup
		SF.click_link $sf_setup_create
		SF.click_link $sf_setup_create_objects				
		SF.wait_for_search_button
		SF.click_link object_name
		search_layout = $sf_object_search_layout_pattern.sub($sf_param_substitute,search_layout_name)
		# If search layout is not present, User need to edit the object and need to check the Allow Search checkbox.
		# After that the search layout option will be displayed to user.
		if !(page.has_xpath?(search_layout))
			SF.click_button_edit
			SF.check_checkbox "Allow Search"
			SF.click_button_save
			SF.wait_for_search_button
		end
		find(:xpath, search_layout).click
		SF.wait_for_search_button
		within($sf_search_layout_add_field_section) do
			find(:xpath, $sf_object_search_layouts_available_field_pattern.sub($sf_param_substitute ,add_field_name )).click
		end
		find(:xpath, $sf_multi_select_add_button).click	  
		SF.click_button_save
		SF.wait_for_search_button
	end
	
	# To Scroll the page up
	# num_of_page_to_scroll_up - number of pages to scroll up
	def SF.scroll_page_up num_of_page_to_scroll_up
		# adding -ve before number to scroll up
		num_of_page_to_scroll_up = "-"+num_of_page_to_scroll_up.to_s		
		page.execute_script($sf_page_layout_scroll_page.sub($sf_param_substitute,num_of_page_to_scroll_up))
	end
	
	# To Scroll the page down
	# num_of_page_to_scroll_down - number of pages to scroll down
	def SF.scroll_page_down num_of_page_to_scroll_down
		page.execute_script($sf_page_layout_scroll_page.sub($sf_param_substitute,num_of_page_to_scroll_down.to_s))
	end
	
	# To Scroll the lines down
	# num_of_lines_to_scroll_down - number of lines to scroll down
	def SF.scroll_line_down num_of_lines_to_scroll_down
		page.execute_script($sf_page_layout_page_scroll_lines.sub($sf_param_substitute,num_of_lines_to_scroll_down.to_s))
	end
	
	# num_of_lines_to_scroll - number of lines to scroll up
	def SF.scroll_line_up num_of_lines_to_scroll
		# adding -ve before number to scroll up
		num_of_lines_to_scroll = "-"+num_of_lines_to_scroll.to_s
		page.execute_script($sf_page_layout_page_scroll_lines.sub($sf_param_substitute,num_of_lines_to_scroll.to_s))
	end
################################################
# Enable the visualforce page access to profile
# page_name: list of items
#user_profile: Profile like Standard User/Administrator
################################################
	def SF.enable_visualforce_page_access user_profile, page_name
		SF.admin $sf_setup
		SF.set_global_search $sf_profiles_in_manage_users
		SF.click_link $sf_profiles_in_manage_users
		SF.select_records_per_page "100"
		SF.click_link user_profile
		puts page.has_xpath?($ffa_edit_enabled_visualforce_page_access)
		find(:xpath,$ffa_edit_enabled_visualforce_page_access).click
		SF.move_item_from_left_pane_to_right_pane page_name	
	end
################################################
# Disable the visualforce page access to profile
# page_name: list of items
#user_profile: Profile like Standard User/Administrator
################################################
	def SF.disable_visualforce_page_access user_profile, page_name
		SF.admin $sf_setup
		SF.set_global_search $sf_profiles_in_manage_users
		SF.click_link $sf_profiles_in_manage_users
		SF.select_records_per_page "100"
		SF.click_link user_profile
		puts page.has_xpath?($ffa_edit_enabled_visualforce_page_access)
		find(:xpath,$ffa_edit_enabled_visualforce_page_access).click
		SF.move_item_from_right_pane_to_left_pane page_name	
	end
###########################################################################################
# Selecting the items from the table in left pane which need to be moved to right pane
# item_names: list of items
###########################################################################################
	def SF.move_item_from_left_pane_to_right_pane item_names		
		gen_wait_until_object $sf_search_layout_add_field_section
		item_names.each do |add_field_name|
			within($sf_search_layout_add_field_section) do
				find(:xpath, $sf_object_search_layouts_available_field_pattern.sub($sf_param_substitute ,add_field_name )).click
			end
			find(:xpath, $sf_multi_select_add_button).click
		end
		SF.click_button_save
		SF.wait_for_search_button
	end
###########################################################################################
# De-Selecting the items, move them from right pane to left pane
# item_names: list of items
###########################################################################################
	def SF.move_item_from_right_pane_to_left_pane item_names		
		gen_wait_until_object $sf_search_layout_remove_field_section
		item_names.each do |remove_field_name|
			within($sf_search_layout_remove_field_section) do
				find(:xpath, $sf_object_search_layouts_available_field_pattern.sub($sf_param_substitute ,remove_field_name )).click
			end
			find($sf_multi_select_remove_button).click
		end
		SF.click_button_save
		SF.wait_for_search_button
	end

	# To Scroll the line up
	# num_of_lines_to_scroll_up - number of lines to scroll up
	def SF.scroll_line_up num_of_lines_to_scroll_up
		# adding -ve before number to scroll up
		num_of_lines_to_scroll_up = "-"+num_of_lines_to_scroll_up.to_s		
		page.execute_script($sf_page_layout_page_num_lines_up.sub($sf_param_substitute,num_of_lines_to_scroll_up))
	end
	
	# execute code as per org type(lightening or non lightening)
	def SF.execute_script (&block)
		if (SF.org_is_lightning)
		    gen_start_time_tracker 
				frame_exist = page.has_css?($sf_lightening_iframe_locator , :wait => LESS_WAIT)
			gen_show_time_tracker "iframe lookup in lightning org (#{frame_exist}) "
			if (frame_exist) 
				within_frame(find($sf_lightening_iframe_locator)) do 
					block.call()
				end
			else
				block.call()
			end
		else 
			block.call()
		end	
	end
	
	# To perform more actions on standard SF object which are available under down arrow key
	# action_name = Name of the option which need to be clicked. (Ex- Manage Lines, Post , Convert To credit Note, Classic View )
	def SF.click_action action_name
		SF.retry_script_block do
			SFL.click_action action_name
		end
	end
	
	# To select the value from standard SF lookup object 
	# object_locator = locator of the lookup
	# value = name of the value which need to be selected
	def SF.fill_in_lookup object_label , value
		SF.retry_script_block do
			if (SF.org_is_lightning)
				SFL.fill_in_lookup object_label , value
			else
				fill_in object_label ,:with => value
			end
		end
	end
	
	# To select the value from standard SF dropdown object 
	# object_label = label of the picklist
	# value = name of the value which need to be selected
	def SF.select_value object_label , value
		SF.retry_script_block do
			if (SF.org_is_lightning)
				SFL.select_value object_label , value
			else
				select(value, :from => object_label)
			end
		end
	end
###########################################
# Add BaseDataJob page to tab list
# @param vf_page_name = visualforce page technical name
# @param tab_name = tab label name
###########################################
	def SF.create_tab_from_visualforce_page vf_page_name,tab_name
		# Create new tab only when it is not already created.
		find("#tabBar").find(:link,$sf_tab_all_tabs).click
		if (page.has_no_css?($sf_tab_link.sub($sf_param_substitute ,tab_name)))
			SF.admin $sf_setup
			SF.retry_script_block do
				SF.set_global_search $sf_setup_create_tabs			
				find(:xpath, $sf_object_create_tabs).click
				find(:xpath, $sf_vf_tabs_new_button).click		
				find(:xpath,$sf_vf_page_select).select vf_page_name
				find(:xpath ,$sf_create_new_vf_tab_label_input).set tab_name
				find(:xpath , $sf_create_new_vf_tab_name_input).click
				find($sf_vf_tab_lookup_window).click		
				sleep 1# wait for the look up to appear
				within_window(windows.last) do
					find(:xpath, $sf_vf_tab_style_selector).click
				end
			end
			page.has_button?$sf_next_button
			SF.click_button $sf_next_button
			SF.wait_for_search_button
			SF.click_button $sf_next_button
			page.has_button?($sf_save_button)
			SF.click_button $sf_save_button
		else	
			puts "Tab: #{tab_name} already exist in org."
		end
	end
	
###########################################
# Add custom tab
###########################################
	def SF.create_tab_for_custom_object object_name, tab_name
		# Create new tab only when it is not already created.
		find("#tabBar").find(:link,$sf_tab_all_tabs).click
		if (page.has_no_css?($sf_tab_link.sub($sf_param_substitute ,tab_name)))
			SF.admin $sf_setup
			SF.retry_script_block do
				SF.set_global_search $sf_setup_create_tabs			
				find(:xpath, $sf_object_create_tabs).click
				find($sf_custom_tabs_new_button).click	
				SF.select_value $sf_object_label, object_name				
				find($sf_vf_tab_lookup_window).click		
				sleep 1# wait for the look up to appear
				within_window(windows.last) do
					find(:xpath, $sf_vf_tab_style_selector).click
				end
				SF.click_button $sf_next_button
			end
			
			SF.wait_for_search_button
			SF.click_button $sf_next_button
			SF.wait_for_search_button
			page.has_button?($sf_save_button)
			SF.click_button $sf_save_button
		else	
			puts "Tab: #{tab_name} already exist in org."
		end
	end
	
	# Perform execution of code on related list items of object
	def SF.on_related_list (&block)
		# Navigate user to related list for lightning org.
		if (SF.org_is_lightning)
			find($sf_lightning_related_list_tab).click
		end
		block.call()
	end
	
	# Assign a license of package to user
	# license_name = Name of the license.
	# user_alias - alias name of the user.
	def SF.assign_license license_name , user_alias
		license_assigned = false
		SF.admin $sf_setup
		# view user page
		if (SF.org_is_lightning)
			SFL.view_users
		else
			SF.click_link $sf_setup_manage_users
			SF.wait_for_search_button
			SF.click_link $sf_setup_manage_users_users
			SF.wait_for_search_button
		end
		# Display all active users 
		SF.retry_script_block do
			select $sf_all_users_view_active_users, :from => $sf_all_users_view
		end
		page.has_text?(user_alias,:wait => LESS_WAIT)
		SF.click_link user_alias
		page.has_css?($sf_assign_package_button)
		# check if license is already assigned to user
		within(find(:xpath , $sf_assign_license_Section)) do 
			license_assigned = page.has_text?(license_name,:wait => LESS_WAIT)
			SF.log_info "License #{license_name} is assigned to user - #{license_assigned.to_s}"
		end
		# Add license only if it is not assigned, otherwise skip it
		if (!license_assigned)
			find($sf_assign_package_button).click
			SF.wait_for_search_button
			within_frame(find($sf_assign_licenses_frame)) do 
				find(:xpath , $sf_license_pattern.sub($sf_param_substitute ,license_name)).click
			end
			SF.click_button $sf_add_button
		end
		SF.wait_for_search_button
	end
	
	# To enable a community in org
	# community_domain= Unique Name of the community domain.
	def SF.enable_community community_domain
		SF.set_global_search $sf_fm_community_setting_label
		SF.click_link $sf_fm_community_setting_label
		# Enable a new community only when no other communtiy is already present on org.
		SF.execute_script do
			if (page.has_css?($sf_fm_enable_community_checkbox))
				find($sf_fm_enable_community_checkbox).set true
				find($sf_fm_community_domain_name).set community_domain
				find($sf_fm_community_check_availability_button).click
				domain_availability_msg = find($sf_fm_community_domain_availability_message).text
				puts domain_availability_msg	
				# add code to check for successfull message.
				if(domain_availability_msg.include? "Success! Domain name available") 
					first(:button, $sf_save_button).click
					sleep 1 # wait for the alert to appear
					SF.alert_ok
				else
					raise "Domain name is not avialble, Please try other domain name."
				end
				page.has_css?($sf_fm_new_community_button)
			end
		end
	end
	
	# To set a role for users
	# user_name= username of the user 
	# user_role = role of the user which need to be assigned to user.
	def SF.set_user_role user_name , user_role
		# view user page
		if (SF.org_is_lightning)
			SFL.view_users
		else
			SF.click_link $sf_setup_manage_users
			SF.wait_for_search_button
			SF.click_link $sf_setup_manage_users_users
			SF.wait_for_search_button
		end
		# click on user name to view detail page
		SF.execute_script do
			page.has_text?(user_name,:wait => LESS_WAIT)
			SF.click_link user_name
		end
		SF.click_button_edit
		SF.execute_script do
			page.has_css?($sf_user_role_picklist)
			select(user_role, :from => $sf_user_role_label)
			first(:button, $sf_save_button).click
		end
		page.has_text?(user_name,:wait => LESS_WAIT)
	end

	# setup community in org
	# template_name- name of the template which need to be used when doing setup for community.
	# community_name- name of the community
	def SF.setup_community community_name,template_name
		SF.set_global_search $sf_fm_all_community_setting_label
		SF.click_link $sf_fm_all_community_setting_label
		SF.execute_script do
			page.has_css?($sf_fm_new_community_button)
			find($sf_fm_new_community_button).click
		end
		SF.retry_script_block do
			page.has_xpath?($sf_community_template_name_pattern.sub($sf_param_substitute,template_name))
			find(:xpath ,$sf_community_template_name_pattern.sub($sf_param_substitute,template_name)).click
		end
		find($sf_community_get_started_button).click
		find($sf_new_community_name_input).set community_name
		find($sf_community_create_button).click
	end
	
	# click on manage link of community
	def SF.manage_community community_name
		SF.admin $sf_setup
		SF.set_global_search $sf_fm_all_community_setting_label
		SF.click_link $sf_fm_all_community_setting_label
		SF.execute_script do
			page.has_css?($sf_fm_new_community_button)
			SF.click_link $sf_community_workspace_label
			SF.wait_for_search_button
		end
	end

	# Add tabs for FM community from manage community page
	# tab_name_list : List of tab names which need to be add.
	def SF.select_community_tab tab_name_list
		SF.retry_script_block do
			find(:xpath , $sf_fm_community_administration_link).click
			find(:xpath , $sf_fm_community_tabs_link).click
		end
		within_frame(find($sf_community_iframe)) do
			tab_name_list.each do |name|
				page.has_text?(name)
				find(:xpath, $sf_fm_community_tab_name_pattern.sub($sf_param_substitute,name)).click
				find(:xpath,$sf_multi_select_add_button).click
			end
			first(:button, $sf_save_button).click
			page.has_css?($page_text_message)
		end 
	end
	
	# Add tabs for FM community from manage community page
	# permission_list : List of tab names which need to be add.
	def SF.assign_community_permission_set permission_list
		SF.retry_script_block do
			if(page.has_xpath?($sf_fm_community_administration_link,:wait => LESS_WAIT))
				find(:xpath , $sf_fm_community_administration_link).click
			end
			find(:xpath , $sf_fm_community_members_link).click
		end
		within_frame(find($sf_community_iframe)) do
			permission_list.each do |name|
				find($sf_community_permission_set_search_input).set name
				find(:xpath,$sf_community_permission_set_find_button).click
				sleep 1# wait for result to appear
				page.has_text?(name)
				find(:xpath, $sf_fm_community_option_list_pattern.sub($sf_param_substitute,name)).click
				find(:xpath,$sf_fm_community_permission_set_add_button).click
			end
			first(:button, $sf_save_button).click
			page.has_css?($page_text_message)
		end
	end
	
	# To navigate back from community page to FFA setup page.
	def SF.navigate_ffa_setup
		find($sf_community_user_link).click
		sleep 1 # wait for option to appear
		find($sf_community_setup_link).click
		SF.wait_for_search_button
	end
	
	# Add sharing setting for Community
	# label_name- name of the label
	# profile_list- Array of profile names for which sharing set need to added
	# object_list- Array of object names for which sharing set need to added
	def SF.set_community_sharing_setting_name setting_label_name 	
		fill_in "Label" ,:with => setting_label_name  
	end
	
	# Add profiles for sharing setting
	def SF.select_community_sharing_profile profile_list
		profile_list.each do |name|
			page.has_text?(name)
			find(:xpath, $sf_fm_community_option_list_pattern.sub($sf_param_substitute,name)).click
			find(:xpath,$sf_multi_select_add_button).click
		end
	end
	# Add Objects for sharing setting
	def SF.select_community_sharing_objects object_list
		object_list.each do |name|
			page.has_text?(name)
			find(:xpath, $sf_fm_community_option_list_pattern.sub($sf_param_substitute,name)).click
			find(:xpath,$sf_fm_community_object_add_button).click
			gen_wait_less # wait for page to refresh after the object is added
			page.has_css?($sf_community_configure_access_section)
		end
	end
	
	# Configure access for community 
	# object_name= name of the object
	# user = name of the user
	# target_name= name of the target
	# access_level= access level
	def SF.setup_configure_access object_name ,user,target_name, access_level
		find(:xpath,$sf_community_configure_access_setup_link_pattern.sub($sf_param_substitute,object_name)).click
		page.has_css?($sf_community_configure_access_setup_iframe)
		within_frame(find($sf_community_configure_access_setup_iframe)) do
			select(user, :from => "User")
			select(target_name, :from => "Target #{object_name}")
			select(access_level, :from => "Access Level")
			first(:button, $sf_update_button).click
		end
		page.has_css?($sf_community_configure_access_section)
	end
	
	# set home page layout for different profiles
	# profile= name of the profile for which layout need to be set
	# layout_name = name of the layout which need to be assigned
	def SF.set_home_page_layout  profile,layout_name 
		SF.admin $sf_setup
		SF.set_global_search $ffa_home_page_layout_label
		SF.click_link $ffa_home_page_layout_label
		find($sf_object_page_layout_assignment) .click
		find($sf_object_edit_assignment).click
		select(layout_name, :from => profile)
		SF.click_button_save
	end
	
	# check a checkbox by its label
	def SF.check_checkbox checkbox_label
		page.check checkbox_label
	end
	
	# Un-check a checkbox by its label
	def SF.uncheck_checkbox checkbox_label
		page.uncheck checkbox_label
	end
	
	#Add Button to custom object's list view layout
	#object_name- Name of custom object
	#list_view_layout_name - list view layout Name
	#button_name_list - Name of buttons to add in layout
	def SF.add_buttons_to_list_view_layout object_name, list_view_layout_name, button_name_list
		SF.admin $sf_setup
		SF.click_link $sf_setup_create
		SF.click_link $sf_setup_create_objects
		SF.wait_for_search_button
		SF.click_link object_name
		SF.wait_for_search_button
		find($sf_list_view_layout_edit_link.gsub($sf_param_substitute,list_view_layout_name)).click
		SF.wait_for_search_button
		#select button and Add each to another list
		button_name_list.each do |button|
			find(:xpath, $sf_list_view_listbox_option.gsub($sf_param_substitute,button)).click
			find($sf_list_view_add_button).click
		end
		SF.click_button_save
		SF.wait_for_search_button
	end
	
	#Add Button to standard object's list view layout
	#object_name- Name of custom object
	#list_view_layout_name - list view layout Name
	#button_name_list - Name of buttons to add in layout
	def SF.add_buttons_to_standard_object_list_view_layout object_name, list_view_layout_name, button_name_list
		SF.admin $sf_setup
		SF.click_link $sf_setup_customize
		within($sf_customize_child_objects_section) do
			SF.click_link object_name
			SF.click_link $sf_search_layout
		end
		find($sf_list_view_layout_edit_link.gsub($sf_param_substitute,list_view_layout_name)).click
		SF.wait_for_search_button
		#select button and Add each to another list
		button_name_list.each do |button|
			find(:xpath, $sf_list_view_listbox_option.gsub($sf_param_substitute,button)).click
			find($sf_list_view_add_button).click
		end
		SF.click_button_save
		SF.wait_for_search_button
	end

# Below code will hide one specific tab(as per package) for given profile.
# @profile_name = Profile for which tab need to be hide.
# @tab_name - name of the tab which need to be hide.
# @package_prefix - Prefix of the package to which the tab belongs(ex- c2g or fferpcore)
	def SF.hide_duplicate_tab profile_name ,tab_name , package_prefix 
		tab_id = nil
		SF.admin $sf_setup
		SF.retry_script_block do
			SF.set_global_search $sf_setup_create_tabs			
			find(:xpath, $sf_object_create_tabs).click
			num_of_tab = all(:xpath ,$sf_vf_tab_name_pattern.sub($sf_param_substitute,tab_name)).size
			SF.log_info "number of duplicate tab for #{tab_name} = #{num_of_tab}"
			for i in 1..num_of_tab do
				SF.set_global_search $sf_setup_create_tabs			
				find(:xpath, $sf_object_create_tabs).click
				tab_index = $sf_vf_tab_name_pattern.sub($sf_param_substitute,tab_name) + "[#{i}]"
				find(:xpath, tab_index).click
				namespace_prefix = find(:xpath , $sf_object_namespace_prefix).text
				if (package_prefix == namespace_prefix)
					# get the id of tab from object href/link
					tab_url = page.current_url
					tab_url = tab_url.split("?").first
					tab_id = tab_url.split("/").last
					SF.log_info tab_id
					break
				end
			end
			# Hide the Tab
			if (tab_id != nil)
				SF.admin $sf_setup
				find($sf_global_search).set $sf_profiles_in_manage_users
				SF.click_link $sf_profiles_in_manage_users
				SF.wait_for_search_button
				first_character_of_profile = profile_name[0]
				SF.listview_filter_result_by_alphabet first_character_of_profile
				page.has_text?(profile_name)
				SF.click_link profile_name
				SF.click_button $sf_edit_button
				page.has_button?($sf_save_button)
				select($bd_tab_hidden_option , :from => "tab___#{tab_id}")
			end
		end
	end
	
	# Login as another user, can receive as parameter:
	# - user alias (ex. 'iclerk') 
	def SF.login_as_user user_alias
		SF.retry_script_block do
			SF.admin $sf_setup
			SF.click_link $sf_setup_manage_users
			SF.wait_for_search_button
			within(:xpath, $sf_users_child) do
				click_link $sf_setup_manage_users_users
			end
			# remove leading and trailing whitespaces
			user_alias = user_alias.strip
			click_link user_alias
		end
		# If login button is not displayed, Add additional setting and click on login button .
		if !(page.has_button?($sf_users_login_button,:wait => LESS_WAIT))
			SF.click_link_and_wait "Security Controls"
			SF.click_link_and_wait "Login Access Policies"
			find(:xpath,$sf_login_as_any_user_checkbox).set true
			SF.click_button_save
			SF.click_link_and_wait "Session Settings"
			find(:xpath,$sf_force_relogin_after_login_as_user).set false
			SF.click_button_save
			SF.click_link $sf_setup_manage_users
			SF.wait_for_search_button
			within(:xpath, $sf_users_child) do
				click_link $sf_setup_manage_users_users
			end
			click_link user_alias
			SF.wait_for_search_button
		end
		SF.retry_script_block do
			click_button $sf_users_login_button
			gen_wait_until_object_disappear $sf_users_login_button_input
		end
		page.has_css?($sf_global_search)
	end
	
#This method is used to check current status of the org that its on lightning mode or classic mode
	def SF.is_lightning_org_active 
		page.has_css?($sf_global_search)
		# Check if org is already has lightning component enabled.
		if (page.has_css?($sfl_profile_icon , :wait => LESS_WAIT))
			return true
		else
			return false
		end
	end
	
	#It will enable the lightning component at org level by Enabling the lightning component from setup page.
	def SF.enable_lightning_component
		SF.retry_script_block do
			# Enable lightning component on org only when org is in classic state.
			if !(SF.is_lightning_org_active)
				find(:xpath, $sf_user_name_selector).click
				switch_to_lightning_link = $sf_setup_option_pattern.gsub($sf_param_substitute, $sf_setup_option_switch_to_lightning_experience_label)
				# check if link to switch lightning component exist in setup. If not, turn the lighting component on org .
				if page.has_no_xpath?(switch_to_lightning_link,:wait => LESS_WAIT)
					find(:xpath,$sf_setup_option_pattern.sub($sf_param_substitute ,$sf_setup )).click
					SF.wait_for_search_button
					# Goto Lightning page and turn it ON
					find($sf_lightning_get_started_button).click
					page.has_xpath?($sf_lightning_turn_on_link)
					# Click on Ok button if page reports any error on page.
					# this error dont impact turning on/off lightning, so handling it.
					if page.has_css?($sf_lightning_ok_button)
						find($sf_lightning_ok_button).click
					end
					find(:xpath , $sf_lightning_turn_on_link).click
					# if lightning component is marked as disabled, turn it ON on complete org for all users.
					if (page.has_no_xpath?($sf_lightning_enable,:wait => LESS_WAIT))
						find($sf_lighting_component_toggle).click 
						find(:xpath , $sf_lighthing_confirmation_button).click
						# Click on Ok button if page reports any error on page.
						# this error dont impact turning on/off lightning, so handling it.
						if page.has_css?($sf_lightning_ok_button)
							find($sf_lightning_ok_button).click
						end
						# wait for page to reload with lightening feature on
						page.has_xpath?($sf_lightening_next_button)
						SF.log_info "Enabled lightning component on org." 
					end
				end
			end
		end
	end
	
# It will enable the lightning component at org level and after that switch the user to lightning component	org.
	def SF.switch_to_lightning
		SF.retry_script_block do 
			if !(SF.is_lightning_org_active)
				# Enable lightning component on org from setup before switching to lightning org.
				SF.enable_lightning_component
				switch_to_lightning_link = $sf_setup_option_pattern.gsub($sf_param_substitute, $sf_setup_option_switch_to_lightning_experience_label)
				if (page.has_no_xpath?(switch_to_lightning_link,:wait => LESS_WAIT))
					find(:xpath, $sf_user_name_selector).click
				end
				find(:xpath,switch_to_lightning_link).click
			end
		end
		page.has_css?($sf_global_search)
	end

	# It will disable the lightening component at org level by turning OFF the lightning component from setup.
	def SF.disable_lightning_component
		# Switch to classic view first
		SFL.switch_to_classic
		SF.retry_script_block do 
			# Navigate to setup page to check the active component.
			SF.admin $sf_setup
			#turn off lightning component
			find($sf_lightning_get_started_button).click
			page.has_xpath?($sf_lightning_turn_on_link)
			# Click on Ok button if page reports any error on page.
			# this error dont impact turning on/off lightning, so handling it.
			if page.has_css?($sf_lightning_ok_button)
				find($sf_lightning_ok_button).click
			end
			find(:xpath , $sf_lightning_turn_on_link).click
			# if lightning component is marked as enabled, turn it OFF on complete org for all users.
			if (page.has_xpath?($sf_lightning_enable,:wait => LESS_WAIT))
				find($sf_lighting_component_toggle).click 
				page.has_xpath?($sf_lightening_next_button)
				# Click on Ok button if page reports any error on page.
				# this error dont impact turning on/off lightning, so handling it.
				if page.has_css?($sf_lightning_ok_button)
					find($sf_lightning_ok_button).click
				end
				SF.log_info "Disabled lightning component on org." 
			else
				SF.log_info "Lightning is already disables on org."
			end
		end
	end
	
# Below code will enable field level security of a field in an object
# @object_name = Name(Field Label) of the object
# @is_object_standard = true if object is standard , false if object is custom.
# @field_name - name of the field for which field level security need to be enabled
	def SF.enable_field_level_security object_name ,is_object_standard ,field_name 
		SF.retry_script_block do 
			SF.admin $sf_setup
			# Open the object to view the fields.
			if is_object_standard
				SF.set_global_search object_name
				SF.click_link "Fields"	
			else
				SF.click_link $sf_setup_create
				SF.click_link $sf_setup_create_objects
				SF.wait_for_search_button
				SF.click_link object_name
				SF.wait_for_search_button
			end
			page.has_link?(field_name)
			SF.click_link field_name
			page.has_button?($sf_edit_button)
			find($sf_field_level_security_button).click
			find($sf_field_level_security_visible_checkbox).set(true)
			SF.click_button_save
		end
	end
end
