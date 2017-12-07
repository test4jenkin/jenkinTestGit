 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module HOME_PAGE
extend Capybara::DSL

$home_page_curr_comp_company_checkbox_label_pattern = "//span[text()='"+$sf_param_substitute+"']"
$home_page_curr_comp_company_checkbox_label_pattern2 = $home_page_curr_comp_company_checkbox_label_pattern + "/ancestor::li/div//label"
$home_page_curr_comp_company_checkbox_pattern = $home_page_curr_comp_company_checkbox_label_pattern + "/ancestor::label/input[@type='checkbox']"
$home_page_curr_comp_down_arrow_icon = "//article[contains(@class,'CurrentCompany')]/header/div[2]//span"
$home_page_curr_comp_select_all = "//span[text()='Select All']/.."
$home_page_curr_comp_deselect_all = "//span[text()='Deselect All']/.."
$home_page_profitability_report_api_name_input = "//span[text()='Filter API Name']/ancestor::div[1]/input"
$home_page_profitability_report_field_value_input = "//span[text()='Filter Field Value']/ancestor::div[1]/input"
$home_page_profitability_report_header = "//div[@data-label='Profitability Reporting']"
$home_page_profitability_report_total =  "//td[text()='Total']/ancestor::tr/td[2]/span"
$home_page_report_activation =  "Activation..."
$home_page_report_activate =  "Activate"
$home_page_loading_icon = "div[class='slds-spinner_container slds-hide']"
$home_page_edit_page_frame = "iframe[class='surfaceFrame']"
$home_page_edit_back = "Back"
$home_page_refresh_button= "button[class$='refresh']"
$home_page_current_company_widget = "article[data-aura-class='cCurrentCompany']"
$home_page_profitability_reporting_widget = "div[data-aura-class='cProfitabilityReportingWidget']"
$home_page_default_today_event_widget = "div[data-aura-class='homeHomeCard homeEventContainer']"

	#Select company
	def HOME_PAGE.select_company company_name, select_deselect
		HOME_PAGE.deselect_all_companies
		gen_scroll_to $home_page_curr_comp_down_arrow_icon
		SF.retry_script_block do			
			company_name.each do |comp|
				company_checkbox = $home_page_curr_comp_company_checkbox_pattern.sub($sf_param_substitute,comp)
				company_checkbox_label = $home_page_curr_comp_company_checkbox_label_pattern2.sub($sf_param_substitute,comp)
				if(!(HOME_PAGE.is_company_selected comp))
					find(:xpath,company_checkbox_label).hover
					find(:xpath,company_checkbox_label).click
				end
				gen_wait_until_object_disappear $home_page_loading_icon 
			end
		end
	end

	#check for company is selected or not
	def HOME_PAGE.is_company_selected company_name
		SF.retry_script_block do 
			is_selected = false
			company_checkbox = $home_page_curr_comp_company_checkbox_pattern.sub($sf_param_substitute,company_name)
			if(find(:xpath,company_checkbox)[:checked] == "true" || find(:xpath,company_checkbox)[:checked] == "checked")
				is_selected = true
			end
			return is_selected	
		end
	end
	
	#select All companies
	def HOME_PAGE.select_all_companies
		SF.retry_script_block do
			find(:xpath,$home_page_curr_comp_down_arrow_icon).click
			gen_wait_until_object $home_page_curr_comp_select_all
			find(:xpath,$home_page_curr_comp_select_all).click
			gen_wait_until_object_disappear $home_page_loading_icon 			
		end
	end
	
	#De select All companies
	def HOME_PAGE.deselect_all_companies
		SF.retry_script_block do
			find(:xpath,$home_page_curr_comp_down_arrow_icon).click
			gen_wait_until_object $home_page_curr_comp_deselect_all
			find(:xpath,$home_page_curr_comp_deselect_all).click
			gen_wait_until_object_disappear $home_page_loading_icon	
		end
	end
	
	#set API Name
	def HOME_PAGE.profitability_report_set_api_name api_name
		SF.retry_script_block do 
			find(:xpath,$home_page_profitability_report_api_name_input).set api_name
		end
	end

	#set field value
	def HOME_PAGE.profitability_report_set_field_value field_value
		SF.retry_script_block do 
			find(:xpath,$home_page_profitability_report_field_value_input).set field_value
		end
	end
	
	#select profitablility report in edit page
	def HOME_PAGE.select_profitibility_report_in_edit_page
		SF.retry_script_block do 
			within_frame(find($home_page_edit_page_frame))do
				gen_wait_until_object_disappear $home_page_loading_icon	
				find(:xpath,$home_page_profitability_report_header).hover
				find(:xpath,$home_page_profitability_report_header).click
				gen_wait_until_object_disappear $home_page_loading_icon	
				if page.has_no_xpath?($home_page_profitability_report_field_value_input)
					raise "retry selecting report"
				end
			end
		end
	end
	
	#get profitability Report total
	def HOME_PAGE.get_profitability_report_total
		report_total = nil
		SF.retry_script_block do 
			gen_wait_until_object $home_page_profitability_report_total
			report_total =  find(:xpath,$home_page_profitability_report_total).text
		end
		return report_total
	end	
	
	# click refresh button
	def HOME_PAGE.click_refresh_button
		SF.retry_script_block do 
			find($home_page_refresh_button).click
			page.has_css?($home_page_default_today_event_widget)
		end
	end
	
	# activate the home page 
	def HOME_PAGE.activate_home_page_widget
		SF.retry_script_block do 
			SF.click_button $home_page_report_activation
			gen_wait_until_object_disappear $home_page_loading_icon	
			SF.click_button $sf_next_button
			gen_wait_until_object_disappear $home_page_loading_icon	
			SF.click_button $home_page_report_activate
			gen_wait_until_object_disappear $home_page_loading_icon
		end
	end
end