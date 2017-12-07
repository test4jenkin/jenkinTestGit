 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module DFP
extend Capybara::DSL

# DFP Selectors
$dfp_authorize_with_google_button = "Authorize with Google"
$dfp_tab_sales = "Sales"
$dfp_all_proposals = "All proposals"
$dfp_no_proposal_to_display = "No proposals to display"
$dfp_proposal_settings = "Settings"
$dfp_filters = "(//div[text()='Filters'])[1]"
$dfp_add_filters = "(//div[text()='Add filters'])[1]"
$dfp_filter_by_name_option="//div[@role='menubar']/div[text()='Name']"
$dfp_filter_textbox =  "input[Id*='gwt-debug-conditionValueTextBox-textInput']"
$dfp_all_proposals_apply_filters = "(//div[@id='gwt-debug-filterView-actionBar']/div/div/span[text()='Apply filters'])[1]"
$dfp_proposal_add_product_button = "//div[text()='Add products']"
$dfp_rate_card_arrow = "//div[text()=' Rate card ']"
$dfp_product_rate_card = "//div[text()='"+$sf_param_substitute+"']"
$dfp_product_search_box_go_button = "div[id$='standardTableWidget-searchButton']"
$dfp_product_add_plus_button = "(//button[text()='+'])[last()]"
$dfp_product_budget_textbox = "input[id*='gwt-debug-shoppingCart-budgetInputBox']"
$dfp_product_net_rate_textbox = "table[id$='itemTable-cellTableContent'] td:nth-of-type(7) input"
$dfp_product_gross_rate_textbox= "table[id$='itemTable-cellTableContent'] td:nth-of-type(8) input"
$dfp_product_quantity_textbox = "table[id$='itemTable-cellTableContent'] td:nth-of-type(11) input"
$dfp_product_update_proposal_button = "//div[text()='Update proposal'][2]"
$dfp_save_draft_button = "//div[text()='Save draft']"
$dfp_submit_approve_access_button = "div[id*='submit_approve_access']"
$dfp_gross_rate_card = "Gross Rate Card"
$dfp_product_start_end_date_column = "//*[@id='gwt-debug-EntityCellTableWidget-sales.shoppingCart.itemTable-cellTableContent']/tbody[1]/tr/td[10]/div/span[1]/div[1]/div[1]"
$dfp_product_start_date_input = "//*[@id='gwt-debug-start-date-selector']/tbody/tr[1]/td/input"
$dfp_product_end_date_input = "//*[@id='gwt-debug-end-date-selector']/tbody/tr[1]/td/input"
$dfp_product_search_box = "input[id$='standardTableWidget-searchBox']"
$dfp_product_date_range_apply_button = "div[Id$='gwt-debug-apply-date-range-button']"
$dfp_home_anchor = "a[href*='#home']"
$dfp_all_proposal_anchor = "a[Id$='ALL_PROPOSALS']"
$dfp_myproposals_header_checkbox1 = "(//div[text()='Name']//ancestor::tr[1]/th[2]//input[@type='checkbox'])[2]"
$dfp_myproposals_header_checkbox2 = "(//div[text()='Name']//ancestor::tr[1]/th[2]//input[@type='checkbox'])[1]"
$dfp_myproposals_archive_button = "//div[text()='Archive']"
$dfp_leftpane_expand_button = "div[class='BRUV4YD-o-d']"
$dfp_leftpane_collapse_button = "div[class='BRUV4YD-o-e']"
$dfp_proposal_custom_field_input = "div[id='gwt-debug-customFields-SuggestBox'] input[class='BRUV4YD-u-i BRUV4YD-gb-a']"
$dfp_proposal_custom_field_checkbox_pattern = "//span[text()='"+$sf_param_substitute+"']/..//input[@type='checkbox']"
$dfp_proposal_custom_field_input_pattern = "//span[text()='"+$sf_param_substitute+"']/../div//input"
$dfp_salesperson_name = "FFA DFP automation2"
$dfp_proposal_salesperson_input = "div[id*='primarySalespersonInputHierSelectorWidget'] input[type='text']"
$dfp_sidebar_cart_link = "//glyph/i[text()='shopping_cart']//ancestor::div[1]//following-sibling::material-ripple[1]"
$dfp_sidebar_subcart_proposal_link = "a[href$='sales/ListProposals']"
#others
$dfp_product_bulk_product_temp_1 = "Bulk Product Temp 1"

# Gmail Selectors
$dfp_gmail_email_textbox = "input[id*='identifier']"
$dfp_gmail_password_textbox ="input[type*='password']"
$dfp_gmail_next_button = "div[id='identifierNext']"
$dfp_gmail_signin_button = "div[id*='passwordNext']"

#config 
$dfp_url = "http://google.com/dfp"
$dfp_google_email_id = "ffa.dfp2@gmail.com"
$dfp_google_password = "metacube#123"
$dfp_user_id = "200040242"
$dfp_company_id = "39185642"
$dfp_network_code = "11297082"

#dfp report configuration
########################################
$dfp_report_config_tab_pattern = "//label[text()='"+$sf_param_substitute+"']"
$dfp_report_config_tab_format = "Format"
$dfp_report_config_tab_mapping = "Mapping"
$dfp_report_config_tab_schedule = "Schedule"
$dfp_report_config_add_mapping_button = "input[value='Add Mapping']"
$dfp_report_config_loading_span = "span[class='waitingDescription']"
$dfp_report_config_mapping_even_first_row_pattern = "tr[class*='dataRow even first last']"
$dfp_report_config_mapping_even_row_pattern = "tr[class*='dataRow even last']"
$dfp_report_config_mapping_odd_row_pattern = "tr[class*='dataRow odd last']"
$dfp_report_config_mapping_source_object_select = $dfp_report_config_mapping_even_first_row_pattern + " td:nth-of-type(2) select , "+  $dfp_report_config_mapping_even_row_pattern + " td:nth-of-type(2) select ," + $dfp_report_config_mapping_odd_row_pattern + " td:nth-of-type(2) select"
$dfp_report_config_mapping_source_field_select = $dfp_report_config_mapping_even_first_row_pattern + " td:nth-of-type(3) select , "+ $dfp_report_config_mapping_even_row_pattern +" td:nth-of-type(3) select ," + $dfp_report_config_mapping_odd_row_pattern +" td:nth-of-type(3) select"
$dfp_report_config_mapping_billing_lineitem_select = $dfp_report_config_mapping_even_first_row_pattern + " td:nth-of-type(4) select , "+ $dfp_report_config_mapping_even_row_pattern +" td:nth-of-type(4) select ," + $dfp_report_config_mapping_odd_row_pattern +" td:nth-of-type(4) select"
$dfp_report_config_schedule_retrieve_button = "Retrieve"
$dfp_report_config_schedule_year_select = "select[id*=':Year']"
$dfp_report_config_schedule_month_select = "select[id*=':Month']"
$dfp_report_config_schedule_confirm_button = "Confirm"
$dfp_report_billing_status_column = "//td[text()='Billing Status']/../td[2]//div"
$dfp_report_billing_report_csv_file_column = "//td[text()='Billing Report CSV File']/../td[4]//div"
$dfp_report_notes_and_attachment_section = "//h3[text()='Notes & Attachments']/ancestor::div[2]"


	# Methods 
	#click button authorize with google
	def DFP.click_button_authorise_with_google
		SF.click_button $dfp_authorize_with_google_button
	end
	
	#click google sign in Next button
	def DFP.click_button_google_signin_next
		SF.retry_script_block do 
			find($dfp_gmail_next_button).click			
		end
	end
	
	#click google sign in Next button
	def DFP.click_button_google_signin
		SF.retry_script_block do
			find($dfp_gmail_signin_button).click			
		end
	end
	
	#click google submit approve access
	def DFP.click_button_submit_approve_access
		SF.retry_script_block do 
			find($dfp_submit_approve_access_button).click
		end
	end
	
	#set google signIn email textbox 
	def DFP.set_google_signin_email email_id
	  	SF.retry_script_block do 
			find($dfp_gmail_email_textbox).set email_id			
		end
	end
	
	#set google signIn password textbox 
	def DFP.set_google_signin_password password
		SF.retry_script_block do
			find($dfp_gmail_password_textbox).set password			
		end
	end
	
	#click filter by click for all proposals
	def DFP.click_button_proposal_filter_by_click
		gen_wait_until_object $dfp_filter_by_name_option
		SF.retry_script_block do 
			find(:xpath,$dfp_filter_by_name_option).click
		end
	end
	
	#set filter 
	def DFP.set_proposal_filter_text filter_text
		SF.retry_script_block do 
			find($dfp_filter_textbox).set(filter_text)
		end
	end
	
	#set apply filter button on proposal
	def DFP.click_button_proposal_apply_filter
		SF.retry_script_block do 
			find(:xpath, $dfp_all_proposals_apply_filters).click
			SF.wait_for_search_button
		end
	end
	
	#click proposal add product button
	def DFP.click_button_proposal_add_product
		SF.retry_script_block do 
			find(:xpath,$dfp_proposal_add_product_button).click
			SF.wait_for_search_button
		end
	end
	
	#select product rate card
	#rate_card_name - name of rate card to select
	def DFP.select_product_rate_card rate_card_name
		SF.retry_script_block do 
			find(:xpath,$dfp_rate_card_arrow).click		
			find(:xpath,$dfp_product_rate_card.gsub($sf_param_substitute, rate_card_name)).click	
		end
	end
	
	#add product to proposal
	#product_name - Name of product to add
	def DFP.add_product_to_proposal product_name		
		find($dfp_product_search_box).set product_name
		find($dfp_product_search_box_go_button).click
		SF.retry_script_block do 
			page.has_xpath?($dfp_product_add_plus_button)
			find(:xpath, $dfp_product_add_plus_button).click
		end		
	end	
	
	#set product budget
	def DFP.set_product_budget budget_value
		find($dfp_product_budget_textbox).set budget_value
	end
	
	#set product net rate 
	def DFP.set_product_net_rate net_rate_value
		find($dfp_product_net_rate_textbox).set net_rate_value
	end
	
	#set product quantity
	def DFP.set_product_quantity quantity
		find($dfp_product_quantity_textbox).set quantity
	end
	
	#click update proposal button
	def DFP.click_button_update_proposal
		find(:xpath,$dfp_product_update_proposal_button).click
		SF.wait_for_search_button
	end
	
	#click Update save draft button
	def DFP.click_button_save_draft
		find(:xpath,$dfp_save_draft_button).click
		SF.wait_for_search_button
	end
	
	#set product start and end date
	def DFP.set_product_start_date_and_end_date start_date, end_date
		SF.retry_script_block do 
			find(:xpath,$dfp_product_start_end_date_column).click
			find(:xpath, $dfp_product_start_date_input).set start_date
			find(:xpath, $dfp_product_end_date_input).set end_date
			find($dfp_product_date_range_apply_button).click
			SF.wait_for_search_button
		end
	end	
	
	def DFP.click_button_filters
		SF.retry_script_block do
			page.has_xpath?($dfp_filters)
			find(:xpath,$dfp_filters).click
			sleep 1 # wait for the dropdown to appear
			find(:xpath,$dfp_add_filters).click
		end
	end
	
	#report configuration
	#################################
	#click add Mapping button in mapping table
	def DFP.click_report_config_add_mapping
		SF.retry_script_block do
			find($dfp_report_config_add_mapping_button).click
			gen_wait_until_object_disappear $dfp_report_config_loading_span
		end
	end
	
	#select source of object option from mappings
	#option_name - name to option to select
	def DFP.select_report_config_mapping_source_object option_name
		SF.retry_script_block do
			element_id = find($dfp_report_config_mapping_source_object_select)[:name]
			select option_name, :from => element_id				
		end
	end
	
	
	#select Source Field option from mappings
	#option_name - name to option to select
	def DFP.select_report_config_mapping_source_field option_name
		SF.retry_script_block do
			element_id = find($dfp_report_config_mapping_source_field_select)[:name]
			select option_name, :from => element_id	
			#find($dfp_report_config_mapping_source_field_select, option_xpath).select_option			
		end
	end
	
	
	#select Billing Line Item option from mappings
	#option_name - name to option to select
	def DFP.select_report_config_mapping_billing_lineitem option_name
		SF.retry_script_block do
			element_id = find($dfp_report_config_mapping_billing_lineitem_select)[:name]
			select option_name, :from => element_id		
		end
	end
	
	#select Billing Line Item option from mappings
	#source_object - name of source_object option to select
	#source_field - name of source_field option to select
	#billing_lineitem - name of billing_lineitem option to select
	def DFP.report_config_add_mapping source_object, source_field,  billing_lineitem
		SF.retry_script_block do
			DFP.select_report_config_mapping_source_object source_object
			gen_wait_until_object_disappear $dfp_report_config_loading_span
			DFP.select_report_config_mapping_source_field source_field
			gen_wait_until_object_disappear $dfp_report_config_loading_span
			DFP.select_report_config_mapping_billing_lineitem billing_lineitem
		end
	end
	
	#select schedule year option
	#year_name - name to year to select
	def DFP.select_report_config_schedule_year year_name
		SF.retry_script_block do
			element_id = find($dfp_report_config_schedule_year_select)[:id]
			select year_name, :from => element_id			
		end
	end
	
	#select schedule month option
	#month_name - name to month to select
	def DFP.select_report_config_schedule_month month_name
		SF.retry_script_block do
			element_id = find($dfp_report_config_schedule_month_select)[:id]
			select month_name, :from => element_id			
		end
	end
	
	#get DFP report billing Status
	def DFP.get_dfp_report_billing_status
		SF.retry_script_block do
			return find(:xpath,$dfp_report_billing_status_column).text
		end
	end
	
	#get DFP report csv file Name
	def DFP.get_dfp_report_csv_file_name
		SF.retry_script_block do
			return find(:xpath,$dfp_report_billing_report_csv_file_column).text
		end
	end
	
	#get dfp report Notes and attachment rows text
	def DFP.get_dfp_report_notes_and_attachment_text
		SF.retry_script_block do
			return find(:xpath,$dfp_report_notes_and_attachment_section).text
		end		
	end
	
	#Archive my proposals
	def DFP.archive_my_proposals_and_confirm
		SF.retry_script_block do
			if page.has_no_text?($dfp_no_proposal_to_display) 
				begin
					find(:xpath,$dfp_myproposals_header_checkbox1).click
				rescue
					find(:xpath,$dfp_myproposals_header_checkbox2).click
				end
				find(:xpath,$dfp_myproposals_archive_button).click
				SF.alert_ok
			else
				SF.log_info $dfp_no_proposal_to_display
			end
		end		
	end
	
	#Expand left panel
	def DFP.expand_left_panel
		if page.has_css? ($dfp_leftpane_expand_button)
			find ($dfp_leftpane_expand_button).click
		end
	end
	
	#collapse left panel
	def DFP.collapse_left_panel
		SF.retry_script_block do
			if page.has_css? ($dfp_leftpane_collapse_button)
				find ($dfp_leftpane_collapse_button).click
			end
		end
	end
	
	#click on proposal setting 
	def DFP.click_proposal_setting_tab
		click_link $dfp_proposal_settings
	end
	
	#click on dfp configuration tab
	#tab_name- tabname to click
	def DFP.click_dfp_report_cofiguration_sub_tab tab_name
		SF.retry_script_block do
			find(:xpath, $dfp_report_config_tab_pattern.sub($sf_param_substitute,tab_name)).click
		end
	end
	
	#set proposal custom field and value
	#setting_name- name of setting
	#setting_value - value for setting
	def DFP.set_proposal_setting_custom_field setting_name, setting_value
		SF.retry_script_block do
			find($dfp_proposal_custom_field_input).click
			checkbox_input = $dfp_proposal_custom_field_checkbox_pattern.gsub($sf_param_substitute,setting_name)
			gen_wait_until_object checkbox_input
			find(:xpath, checkbox_input).set true
			
			text_input = $dfp_proposal_custom_field_input_pattern.gsub($sf_param_substitute,setting_name)
			gen_wait_until_object text_input
			find(:xpath, text_input).set setting_value			
		end
	end
	
	#set proposal  salesperson value
	def DFP.set_proposal_setting_salesperson  salesperson_name
		SF.retry_script_block do
			find($dfp_proposal_salesperson_input).set salesperson_name			
		end
	end
	
	#log into dfp
	def DFP.login
		visit $dfp_url
		SF.retry_script_block do
			if page.has_no_css?($dfp_home_anchor)
				DFP.set_google_signin_email $dfp_google_email_id
				DFP.click_button_google_signin_next
				DFP.set_google_signin_password $dfp_google_password
				DFP.click_button_google_signin
				gen_wait_until_object $dfp_home_anchor
			end
		end
	end

	# click on proposal link from side bar.
	def DFP.open_proposal_page
		find(:xpath , $dfp_sidebar_cart_link).hover
		find(:xpath , $dfp_sidebar_cart_link).click
		page.has_css?($dfp_sidebar_subcart_proposal_link)
		find($dfp_sidebar_subcart_proposal_link).click
		page.has_xpath?($dfp_myproposals_archive_button)
	end
end