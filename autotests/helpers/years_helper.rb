 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module YEAR  
extend Capybara::DSL
##################################################
# Years and Periods	Labels and Locators							 #
##################################################
$year_name = "input[id='Name']"
$year_start_date_label = "Start Date"
$year_end_date_label = "End Date"
$year_number_of_periods_label = "Number of Periods"
$year_period_calculation_basis_label = "Period Calculation Basis"
$year_name_value = "//td[text()='Year Name']/following::td[1]/div | //span[text()='Year Name']/ancestor::div[1]/following::div[1]/div/span"
$year_body_cell = "//*[@id='bodyCell'] | //*[@class='listViewContainer']"
$year_suspense_gla_label = "Suspense GLA"
$year_retained_earning_label = "Retained Earnings GLA"
$year_start_year_end_button = "Start Year End"
$year_run_year_end_button = "Run Year End"
$year_period_list = "//div[@class ='pbBody']/table//tr"
$year_go_to_period_list = "//div[@class = 'pShowMore']//a[contains(text(), 'Go to list')]"
$year_table = "div[class*='x-grid3-row'] table tbody tr"
$year_name_pattern= "div[class*='x-grid3-body'] div:nth-of-type("+$sf_param_substitute+") table tbody tr td:nth-of-type(4) div a "
$year_list_grid = "div[id='ext-gen10'] , div[class*='listViewContent'] table tbody"
$year_name_label = "Year Name"
#periods
$period_calculate_label = "input[id*='calculate']"
$period_calculate_periods_button = "Calculate Periods"
$period_end_process_already_run_message = "The Year End process has already been run for this year.;"

#############################
# Years
#############################
## year information
	# set year name
	def YEAR.set_year_name year
		fill_in $year_name_label , :with => year
	end
	#set year start date
	def YEAR.set_start_date start_date
		fill_in $year_start_date_label , :with => start_date 
	end
	# set year end date
	def YEAR.set_year_end_date end_date
		fill_in $year_end_date_label , :with => end_date 
	end
	# set number of periods
	def YEAR.set_number_of_periods num_of_period
		fill_in $year_number_of_periods_label , :with => num_of_period 
	end
	#select period calculation basis
	def YEAR.select_period_calculation_basis value
		SF.select_value $year_period_calculation_basis_label , value
	end

	#set suspense GLA
	def YEAR.set_suspense_gla gla_value
		SF.fill_in_lookup $year_suspense_gla_label , gla_value	
	end
	#set retained earning
	def YEAR.set_retained_earning_gla earning_value		
		SF.fill_in_lookup $year_retained_earning_label , earning_value	
	end

## Buttons
	def YEAR.click_calculate_periods_button
		SF.click_action $period_calculate_periods_button
		SF.wait_for_search_button
	end

# Get buttons
# get year name
	def YEAR.get_year_name
		page.has_xpath?($year_name_value)
		return find(:xpath , $year_name_value).text
	end

	
	def YEAR.open_year_detail_page year_name ,company_name
		SF.retry_script_block do
			if(page.has_xpath?($year_body_cell))
				within(:xpath, $year_body_cell) do
					 click_link year_name
				end
			else
				click_link year_name
			end
		end
		page.has_text?(year_name)
	end
	
	def YEAR.click_start_year_end_button
		 SF.click_action $year_start_year_end_button
		 SF.wait_for_search_button
	end
	
	def YEAR.click_run_year_end_button
		 SF.click_action $year_run_year_end_button
		 SF.wait_for_search_button
	end
	
	def YEAR.click_go_to_period_list
		if (!SF.org_is_lightning)
			if (page.has_xpath?($year_go_to_period_list))
				find(:xpath, $year_go_to_period_list).click
			end
		end
		 SF.wait_for_search_button
	 end
	
	#Get last year for specified company
	def YEAR.get_last_year company_name
		num_of_rows  = all($year_table).count
		return find($year_name_pattern.sub($sf_param_substitute,num_of_rows.to_s)).text		
	end
	
	#Create New year using specified parameters
	def YEAR.create_new_year year_to_create, start_date, end_date, no_of_periods
		YEAR.set_year_name year_to_create
		YEAR.set_start_date start_date
		YEAR.set_year_end_date end_date
		YEAR.set_number_of_periods no_of_periods		
		SF.click_button_save	
		SF.wait_for_search_button		
	end
	
	#Calculate Periods for specified company and year
	def YEAR.calculate_periods company_name, year
		YEAR.click_calculate_periods_button
		gen_wait_until_object $period_calculate_label
		#Confirm period button calculation
		YEAR.click_calculate_periods_button
		SF.wait_for_search_button
	end
	
	# Execute code on the transaction line items related list page. 
    def YEAR.on_period_list (&block)
		# On Lightning org, Navigate to related list to view line items
		if (SF.org_is_lightning)
			find($sf_lightning_related_list_tab).click
		    page.has_xpath?($sf_view_all_line_items_link)
		    find(:xpath , $sf_view_all_line_items_link).click
		    SF.wait_for_search_button
		end
		# execute the code block on line item
		block.call()
    end
end 