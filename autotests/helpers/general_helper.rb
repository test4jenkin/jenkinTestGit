 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.

DEFAULT_LESS_WAIT = 2 # in seconds 
DEFAULT_MORE_WAIT = 5 # in seconds 
DEFAULT_LONG_WAIT = 10 # in seconds 
DEFAULT_WAIT_LOOP_ITERATION = 20
DEFAULT_GMT_OFFSET = "-07:00"
ALL_TYPE_FILES = "" # select all type of files
TIME_OUT = 60 #in seconds
$gen_failed_steps = []
$gen_step_dependencies_errors = []
$gen_f_list_plain = "ul.f-list-plain"
$gen_tool_tip = "[data-ffxtype=tooltip]:not([style='display: none;'])"
$gen_quick_tip = "[data-ffxtype=quicktip]:not([style='display: none;'])"
$gen_user_nav_button = "div[id='userNavButton']"
$gen_user_nav_menu_items ="div[id='userNav-menuItems']"
$gen_setup_link = "Setup"
$gen_item_disabled = "f-item-disabled"
$gen_refresh_button = "input[title='Refresh']"
$driver_chrome="chrome"
$driver_firefox="firefox"
$gen_test_wait_time=0
$gen_default_property_file_name="uitest.run.properties"
$gen_start_test_time = 0
PROPERTY_FILE = ENV['PROPERTY_FILE'] ? ENV['PROPERTY_FILE'] : $gen_default_property_file_name

$gen_locale_date_ref = {
	"English (United Kingdom)" => "%d/%m/%Y",
	"English (United States)" => "%m/%d/%Y",
	"German (Germany)" => "%d.%m.%Y",
	"Spanish (Spain)" => "%d/%m/%Y",
	"English (Australia)" => "%d/%m/%Y"
}

$gen_locale_number_ref = {
	"English (United Kingdom)" => {
		"decimals" => ".",
		"thousands" => ","
	},
	"English (Australia)" => {
		"decimals" => ".",
		"thousands" => ","
	},
	"English (United States)" => {
		"decimals" => ".",
		"thousands" => ","
	},
	"German (Germany)" => {
		"decimals" => ",",
		"thousands" => "."
	},
	"Spanish (Spain)" => {
		"decimals" => ",",
		"thousands" => "."
	}
}
##########################################
# Custom exceptions
##########################################
class FailedDependencyError < Exception
end

class LocaleNotFoundError < Exception
end

##########################################
# Wait functions
##########################################

def gen_wait_less 
	sleep DEFAULT_LESS_WAIT
	$gen_test_wait_time = $gen_test_wait_time + DEFAULT_LESS_WAIT
end 
def gen_wait_more 
	sleep DEFAULT_MORE_WAIT
	$gen_test_wait_time = $gen_test_wait_time + DEFAULT_MORE_WAIT
end 
def gen_wait_long
	sleep DEFAULT_LONG_WAIT
	$gen_test_wait_time = $gen_test_wait_time + DEFAULT_LONG_WAIT
end 

# Press tab out on the provided object 
def gen_tab_out object_name 
	find(object_name).native.send_keys :tab
	sleep 1
end

def gen_send_key object_name , key_to_send
	find(object_name).native.send_keys key_to_send
	sleep 1
end

##########################################
# general compare and verification method
##########################################

# exactly compare the Expected with Actuals
def gen_compare sExpected , sActual , sTest
	if (expect(sActual).to eql(sExpected))
		puts "Test #{sTest} Passed."
	end 
end
# compare casse insensitive for strings
def gen_compare_ignore_case sExpected , sActual , sTest
	if sExpected.is_a?(String)
		sExpected = sExpected.downcase
		sActual = sActual.downcase
	end 
	if (expect(sActual).to eql(sExpected))
		puts "Test #{sTest} Passed."
	end 
end
# compare two arrays. Return true if the order of the elements is the same.
def gen_compare_arrays aExpected , aActual , sTest
	if !(aExpected.eql? aActual)
		puts "Test #{sTest} Failed."
		return false
	else
		puts "Test #{sTest} Passed."
		return true
	end
end
# Expected text is included in the Actual text 
def gen_include sExpected , sActual , sTest
	if (expect(sActual).to include(sExpected))
		puts "Test #{sTest} Passed."
	end 
end
# Expected text is not included in the Actual text
def gen_not_include sExpected , sActual , sTest
	result = (sActual).include?(sExpected)
	if(expect(result).to eql(false))
		puts "Test #{sTest} Passed."
	end
end
# Check that a Value is in Given range 
def gen_in_range value, lower , upper
	rc =  value.between?(lower,upper) 
	if rc == false 
		puts "Value not in given range."
	end 
	return rc 
end
# Compare object is editable or not (Argument "shoulde_be_editable" is a boolean value)
def gen_compare_object_editable obj_locator, shoulde_be_editable, sTest
	_editable_object_tag = ["input", "select", "textarea"]
	_actual_object_tag = gen_get_element_tag obj_locator
	if(shoulde_be_editable)
		gen_include _actual_object_tag, _editable_object_tag, sTest
	else
		gen_not_include _actual_object_tag, _editable_object_tag, sTest
	end	
end
# compare object is visible on UI or not (argument "shoulde_be_visible" is boolean value)
def gen_compare_object_visible obj_locator, shoulde_be_visible, sTest
	SF.execute_script do
		locator_strategy = :css
		if(obj_locator[0]=='/')
			locator_strategy = :xpath
		end
		if(shoulde_be_visible)
			expect(page).to have_selector(locator_strategy, obj_locator)
			puts "Test #{sTest} passed"
		else
			expect(page).to have_no_selector(locator_strategy, obj_locator)
			puts "Test #{sTest} passed"
		end
	end
end
# Verify existence of button on page
def gen_compare_has_button button_name, should_have_button, sTest
	gen_execute_script do
		if (should_have_button)
			expect(page).to have_button(button_name)
			puts "Test #{sTest} Passed."
		else
			expect(page).to have_no_button(button_name)
			puts "Test #{sTest} Passed."
		end
	end
end

# Verify existence of content on page
def gen_compare_has_content content_value, should_have_content, sTest
	gen_execute_script do
		if (should_have_content)
			expect(page).to have_content(content_value)
			puts "Test #{sTest} Passed."
		else
			expect(page).to have_no_content(content_value)
			puts "Test #{sTest} Passed."
		end
	end
end

# gen_compare_has_css "cssName",  false, "Test step message to be disaplayed"
def gen_compare_has_css css_value, should_have_css_with_text, sTest
	gen_execute_script do
		if(should_have_css_with_text)
			expect(page).to have_css(css_value)  
			puts "Test #{sTest} Passed."
		else
			expect(page).to have_no_css(css_value)  
			puts "Test #{sTest} Passed."
		end
	end
end
# Verify existence/Non-existence of CSS with Text on page
# css_value - Value of css to be verified 
# lable_name - text to be verified along with css
# should_have_css_with_text - = Boolean value, (true / false)
# sTest = string for test verification
# Example 1- check for css with Text exists on Page
# gen_compare_has_css_with_text "cssName", "textValue", true, "Test step message to be disaplayed"
# Example 1- check for css with Text not exists on Page
# gen_compare_has_css_with_text "cssName", "textValue", false, "Test step message to be disaplayed"
def gen_compare_has_css_with_text css_value, lable_name, should_have_css_with_text, sTest
	gen_execute_script do
		if(should_have_css_with_text)
			expect(page).to have_css(css_value, :text =>lable_name)  
			puts "Test #{sTest} Passed."
		else
			expect(page).to have_no_css(css_value, :text =>lable_name)  
			puts "Test #{sTest} Passed."
		end
	end
end


# Verify existence of link on page
# link_name - Name of the link
# should_have_link = Boolean value, (true / false)
# sTest = string for test verification
def gen_compare_has_link link_name, should_have_link, sTest
	gen_execute_script do
		if (should_have_link)
			expect(page).to have_link(link_name)
			puts "Test #{sTest} Passed."
		else
			expect(page).to have_no_link(link_name)
			puts "Test #{sTest} Passed."
		end
	end
end

# Verify existence of xpath on page
# xpath_locator =  xpath provide
# should_have_link = Boolean value, (true / false)
# sTest = string for test verification
def gen_compare_has_xpath xpath_locator, should_have_xpath, sTest
	gen_execute_script do
		if (should_have_xpath)
			expect(page).to have_xpath(xpath_locator)			
			puts "Test #{sTest} Passed."
		else
			expect(page).to have_no_xpath(xpath_locator)
			puts "Test #{sTest} Passed."
		end
	end
end

# Verify if page has given title
def gen_has_page_title page_title, sTest
	gen_execute_script do
		if (expect(page).to have_title(page_title))
			puts "Test #{sTest} Passed"
		end
	end
end
# Compare if object value is pre-selected(not nil) or nil
def gen_compare_objval_not_null obj_value, should_not_null, sTest
	if(should_not_null)
		expect(obj_value ==nil || obj_value =='').to eql false
		puts "Test #{sTest} Passed"
	else
		expect(obj_value ==nil || obj_value =='').to eql true
		puts "Test #{sTest} Passed"
	end
end

def gen_report_test sTest
	puts "Test #{sTest} Passed."
end

def gen_start_test sTest
	puts "Start of  #{sTest}"
	$gen_test_wait_time=0
	$gen_failed_steps = []
	$gen_step_dependencies_errors = []
end

def gen_end_test sTest
	puts "End of #{sTest}"
    puts "Total wait time in test: #{$gen_test_wait_time} sec"
	if gen_test_has_failed
		gen_report_test_failure sTest
	end
end

def gen_report_step_start step_name
	puts "Step #{step_name} start"
end

def gen_report_step_end step_name
	puts "Step #{step_name} end"
	puts ""
end

def gen_report_step_failure step_name, exception
	puts "Step #{step_name} failed with error: "
	puts exception.message
	puts exception.backtrace.join("\n")
end

def gen_report_step_skip step_name, dependency
	puts "Step #{step_name} was not executed due to failed dependencies: " + dependency
end

def gen_test_has_failed
	return $gen_failed_steps.length > 0
end

def gen_report_test_failure step_name
	fail "Test #{step_name} failed due to steps: \n" + $gen_failed_steps.join("\n").to_s
end

def gen_set_failed_step step_name
	$gen_failed_steps.push(step_name)
end

def gen_check_dependency dependency
	if $gen_step_dependencies_errors.include? dependency or $gen_failed_steps.include? dependency
		raise FailedDependencyError, dependency
	end
end

def gen_set_step_dependency_failure step_name
	$gen_step_dependencies_errors.push(step_name)
end

# marks test step
# call as:
# test_step "TST######" do
# 	...
# end
def test_step name, &block
	begin
		$env_step_name = name
		gen_report_step_start name
		block.call
	rescue FailedDependencyError => e
		gen_report_step_skip name, e.message
		gen_set_step_dependency_failure name
	rescue Exception => e
		gen_report_step_failure name, e
		gen_set_failed_step name
	ensure
		gen_report_step_end name
	end
end

# get property value from uitest.run.properties
def get_property propperty_name
property = ""
File.open(PROPERTY_FILE, "r") do |infile|
		while (row = infile.gets)
			if row.include? propperty_name
				property_row = row
			end 
		end
		property = property_row.split("=")
	end
	return  property[1].chop
end

# get tagname of element
def gen_get_element_tag obj_locator
	locator_strategy = :css
	if(obj_locator[0]=='/')
		locator_strategy = :xpath
	end
	gen_execute_script do
		return find(locator_strategy, obj_locator).tag_name
	end
end

# get class of element
def gen_get_element_class obj_locator
	locator_strategy = :css
	if(obj_locator[0]=='/')
		locator_strategy = :xpath
	end
	gen_execute_script do
		element = find(locator_strategy,obj_locator)
		return  element[:class]
	end
end

# get page name/heading
def gen_get_page_name
	gen_execute_script do
		return find($page_heading).text
	end
end

# drag the object on the other object 
# passs the selectors for dragged object and the object you want to drop on 
def gen_drag_drop drag_object , drop_object
	drag_object.drag_to(drop_object)
	gen_wait_less
end 

# click on a link and wait
def gen_click_link_and_wait link
	gen_execute_script do
		click_link link
		gen_wait_less
	end
end 
# get tool tip
def gen_get_tool_tip
	return find($gen_tool_tip).text 
end 
# get the quick tip
def gen_get_quick_tip
	return find($gen_quick_tip).text 
end 
# return quick tip for specifind object
def gen_get_object_quick_tip object_name 
	find(object_name).hover 
	return gen_get_quick_tip
end 

#############################
# general grid methods  
#############################
# Return  the row of a grid by searching a text in specified column 
# grid_selector grid selector css, xpath or id 
# search_text text you want to search 
# col_to_search column in which you want to search 

def gen_get_row_in_grid grid_selector, search_text, col_to_search 
	gen_execute_script do
		# default search type  exact 
		search_type = "exact"
		if search_text.end_with? "*"
			search_type = "partial"
		end 
		allrows  = all("#{grid_selector} tr")
		row = 1 
		while  row <= allrows.count
			cellvalue = find("#{grid_selector} table:nth-of-type(#{row}) tr td:nth-of-type(#{col_to_search})").text 
			# exact mact 
			if search_type == "exact"
				if search_text == cellvalue
					break
				end
			# partial match	
			elsif search_type == "partial"
				if cellvalue.include? search_text.chomp('*')
					break
				end
			end 
			row += 1
		end 
		return row 
	end
end
################################
# grid_selector pas the table / grid selector 
# this will count and return the number of rows in a table / grid
################################
def gen_get_grid_rows grid_selector
	rows = all("#{grid_selector} tr")
	return rows.size
end

################################
# Return  the row  number of a grid by searching every row for search_text string
# col_number_to_search- column number  in which value need to be searched
################################
def gen_get_row_number_in_grid  search_text, col_number_to_search 
	allrows  = all($page_vf_table_rows)
	row = 1
	result_grid_row_pattern = $page_grid_row_pattern
	# In lightning org, Document cell in result table is displayed as header(th) and other cells are displayed as normal cell td.
	# so if column number is 3 , replacing td with th tag. First two column are to display number and checkbox.
	if (SF.org_is_lightning and col_number_to_search ==3)
		result_grid_row_pattern = $page_grid_row_pattern.sub("td" ,"th")
		# There is only one th cell present intable for document name cell, So making the value as 1.
		col_number_to_search = 1  
	end
	# In lightning org result table, cells(td) in a row(tr) starts from second cell in result table. 
	# first cell is displayed as header cell(th), so if column to return is 2, td[1] cell will be containing that info.
	if (SF.org_is_lightning and col_number_to_search > 3)
		col_number_to_search = col_number_to_search-1
	end
	# get the value of 
	while  row <= allrows.count
		page_grid_row = result_grid_row_pattern.sub($sf_param_substitute , row.to_s)	
		cellvalue = find(page_grid_row.sub($sf_param_substitute , col_number_to_search.to_s)).text
		if search_text == cellvalue
			break
		end
	    row += 1
	end 
	return row 
end 
 
################################
# Return  the column number of a grid by searching header column 
# col_header_name- column name which need to be searched in header column
################################
def gen_get_column_number_in_grid col_header_name
	col_header_name = col_header_name.downcase
    num_of_col_in_grid =  all($page_grid_columns)
    col_num=3
    while col_num <= num_of_col_in_grid.count
        header_name = find($page_grid_columns+":nth-of-type(#{col_num})").text
		header_name = header_name.downcase
		#Comparing both the values in lowercase.
		# In lightning org, text=sort is also displayed along with the column name. Ex SORT PAYMENT NUMBER, SORT DISCOUNT etc.
        if (col_header_name == header_name or header_name.start_with?("sort #{col_header_name}"))
            break
        end
        col_num+=1
    end
    return col_num
end

# default is name column 
def gen_search_list_view search_text , col = 4 
	_name_cell = "div[class*=x-grid3-row] td:nth-of-type(#{col})"
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
# click on the Del Link in salesforce List view 
def gen_delete_record  search_text 
	page.has_css?($gen_refresh_button)
	row = gen_search_list_view search_text
	find("div[class*=x-grid3-row]:nth-of-type(#{row}) table tr td:nth-of-type(3) a:nth-of-type(2)").click
	sleep 1
	gen_alert_ok
end
# select the row in saleforce list view 
def gen_select_record  search_text 
	row = gen_search_list_view search_text
	find("div[class*=x-grid3-row]:nth-of-type(#{row}) table td:nth-of-type(1) input").click
end

# click on the specified row of the grid/table (Sencha 4 Table structure)
def gen_grid_click_row grid_selector , row
	find("#{grid_selector} tr:nth-of-type(#{row})").click 
end 

# click on the specified row of the grid/table (sencha 5 table structure)
def gen_table_click_row grid_selector , row
	find("#{grid_selector}:nth-of-type(#{row}) tr").click 
end 

# click on specified cell of the grid / table 
def gen_grid_click_cell grid_selector , row , col 
	find("#{grid_selector} tr:nth-of-type(#{row}) td:nth-of-type(#{col})").click 
end 
# click on specified cell of the grid / table 
def gen_table_click_cell grid_selector , row , col 
	find("#{grid_selector}:nth-of-type(#{row}) tr td:nth-of-type(#{col})").click 
end 

# return data from the specified row of the grid/table
def gen_grid_data_row grid_selector , row
	return find("#{grid_selector} tr:nth-of-type(#{row})").text
end

# return data from the specified row of the grid/table
def gen_table_data_row table_selector , row
	return find("#{table_selector}:nth-of-type(#{row}) tr").text
end

# return the data from whole grid/table in form of list 
# return data will be like this ["abc", "asd", "xyz"]
def gen_get_grid_data grid_selector
	return find("#{grid_selector} tbody").all('tr').collect(&:text)
end
# return the data from whole table in form of list 
def gen_get_table_data table_selector
	return find("#{table_selector}").all('table').collect(&:text)
end

# get the css style and return the property from the style of provided element 
# left: 412px; top: 1px; width: 824px; height: 395px
# possible values are width, height,top 
def gen_get_element_style_property element_selector , style_property_name 
	element = find(element_selector)
	style =  element[:style]
	attributes  = style.split(';')
	attributes.each do |item|
		if item.include? style_property_name
			property =  item.split(':')
			return property[1].sub('px','')
		end 
	end 
end 

#############################
# general list methods  
#############################
def gen_get_ul_list_items 
	return find($gen_f_list_plain).all('li').collect(&:text)
end 

############################################
# general browser ralated 
############################################
	def gen_alert_ok
		if page.driver.class == Capybara::Selenium::Driver
			page.driver.browser.switch_to.alert.accept
		elsif page.driver.class == Capybara::Webkit::Driver
			page.driver.switch_to.alert.accept
		end 
		gen_wait_less
	end

	def gen_alert_cancel
		if page.driver.class == Capybara::Selenium::Driver
			page.driver.browser.switch_to.alert.dismiss
		elsif page.driver.class == Capybara::Webkit::Driver
			page.driver.switch_to.alert.dismiss
		end 
	end

	def gen_alert_text
		if page.driver.class == Capybara::Selenium::Driver
			alert_text  = page.driver.browser.switch_to.alert.text
		elsif page.driver.class == Capybara::Webkit::Driver
			alert_text  = page.driver.switch_to.alert.text
		end 
		return alert_text
	end	
	
# To switch driver as per browser profile
	def gen_switch_to_driver driver_name ,browser_profile
		if driver_name ==$driver_chrome
			Capybara.default_driver=:chrome
		elsif driver_name ==$driver_firefox
			if browser_profile == nil || browser_profile ==''
				Capybara.default_driver = :selenium 
			elsif browser_profile == FIREFOX_PROFILE1
				Capybara.register_driver :selenium_custom do |app|
					Capybara::Selenium::Driver.new(app, :browser => :firefox, :profile => $firefox_profile1)
				end
				Capybara.default_driver = :selenium_custom
			end
		end
		page.driver.browser.manage.window.maximize
	end	
############################################
# general wait method 
############################################
#wait for object to appear
	def gen_wait_until_object object_path
		gen_execute_script do
			object_found = false
			for i in 1..DEFAULT_WAIT_LOOP_ITERATION do
				begin
					if(object_path[0,1]=='/')
						find(:xpath, object_path)
					else
						find(object_path)
					end
					object_found = true
					break
				rescue
					puts "waiting for object to appear."
					gen_wait_less
				end
			end
			if(object_found==false)
				puts "object not found: #{object_path}"
				raise "object not found: #{object_path}"
			end
		end
	end
#wait for object to disappear	
	def gen_wait_until_object_disappear object_path
		object_found = true
		for i in 1..DEFAULT_WAIT_LOOP_ITERATION do
			begin
				puts "Waiting for object to disappear"
				gen_wait_less
				if(object_path[0,1]=='/')
					find(:xpath, object_path)
				else
					find(object_path)
				end
			rescue
				object_found = false
				break
			end
		end
		if(object_found==true)
			raise "Object still not disappeared.#{object_path}"
		end
	end

	# AJAX Methods
	def gen_wait_for_ajax_process_to_complete
			Timeout.timeout(Capybara.default_wait_time) do
			loop until gen_finished_all_ajax_requests?
		end
	end
	
	def gen_finished_all_ajax_requests?
		begin
			page.evaluate_script('jQuery.active').zero?
		rescue Exception=>e
			puts "Warning: gen_finished_all_ajax_requests failed with message :#{e}"
			return true
		end
	end

	def gen_wait_for_new_window
		counter = 0
		while windows.length != 2 and counter <= DEFAULT_TIME_OUT do
			counter+=1
			sleep 1
		end
	end

	def gen_wait_for_enabled element
		gen_execute_script do
		counter = 0
		loop do
			element_classes = find(element)['class']
			is_enabled = !(element_classes.include? 'disabled')
			counter += 1
			sleep 1
			break if is_enabled or (counter >= DEFAULT_TIME_OUT)
		end
	end
	end

	def gen_wait_for_text text_to_find
		counter = 0
		loop do
			sleep 1
			counter += 1
			break if page.has_content? text_to_find or (counter >= DEFAULT_TIME_OUT)
		end
	end

############################################
# general date helper
############################################
#setting the date
def gen_date_minus_days days
	_date = ((Date.today) - days)
	_date_format = _date.strftime("%d/%m/%Y")
end

def gen_date_plus_days days
	_date = ((Date.today) + days)
	_date_format = _date.strftime("%d/%m/%Y")
end

############################################
# open link in new tab
############################################
def gen_open_link_in_new_tab link_name
	new_tab = window_opened_by do
		link_to_open = page.find_link(link_name).native
		page.driver.browser.action.key_down(:shift).click(link_to_open).key_up(:shift).perform() 
	end
	return new_tab
end

############################################
# open a new window and return the window object
# @   (&block) - block of code which will open a new window after performing the steps  
############################################
def gen_open_new_window (&block)
	new_tab = window_opened_by do
		SF.execute_script do
			block.call()
		end
	end
	return new_tab
end
############################################
# visibility helpers
############################################


def gen_assert_enabled element
	classes = find(element)['class']
	enabled = find(element)['disabled']
	is_disabled = ((classes.include? 'disabled') or (enabled == "true"))
	expect(is_disabled).to eq(false)
end

def gen_assert_disabled element
	classes = find(element)['class']
	enabled = find(element)['disabled']
	is_disabled = ((classes.include? 'disabled') or (enabled == "true"))
	expect(is_disabled).to eq(true)
end

def gen_assert_displayed element
	gen_execute_script do
	expect(page).to have_selector(element)
	end
end

def gen_assert_hidden element
	gen_execute_script do
		expect(page).not_to have_selector(element)
	end
end

############################################
# locale
############################################

def gen_get_user_locale username
	locale = false
	find("#userNavButton").click
	url = find("#userNav-menuItems").find(:link,"Setup")[:href]
	within_window open_new_window do
		visit url
		find($sf_setup_collapse_button.gsub('#', $sf_setup_manage_users)).click
		click_link $sf_setup_manage_users_users
		find(:option, 'All Users').select_option
		click_link username
		locale = SF.get_std_view_field "Locale"
		page.current_window.close
	end
	find("#userNavButton").click
	return locale
end
# Get GMT offset of current user from it's Time Zone, this method can be used with "gen_get_current_date" method
# to get the current date in user's time zone.
def gen_get_current_user_gmt_offset
	time_zone_offset = false
	find($gen_user_nav_button).click
	url = find($gen_user_nav_menu_items).find(:link, $gen_setup_link)[:href]
	within_window open_new_window do
		visit url
		find($sf_setup_collapse_button.gsub('#', $sf_setup_manage_users)).click
		click_link $sf_setup_manage_users_users
		find(:option, 'All Users').select_option
		click_link $current_user
		time_zone_offset = SF.get_std_view_field "Time Zone"
		page.current_window.close
	end
	find($gen_user_nav_button).click
	time_zone_offset = time_zone_offset.split("(",2)[1].split(")")[0].split("GMT")[1]
	return time_zone_offset
end
def gen_get_current_user_locale
	return gen_get_user_locale $current_user
end

def gen_locale_format_date date, locale = $locale
	if !$gen_locale_date_ref.keys.include? locale
		raise LocaleNotFoundError, locale
	end

	return date.strftime $gen_locale_date_ref[locale]
end

def gen_locale_format_number number, locale = $locale
	if !$gen_locale_number_ref.keys.include? locale
		raise LocaleNotFoundError, locale
	end

	thousands_separator = $gen_locale_number_ref[locale]["thousands"]
	decimals_separator = $gen_locale_number_ref[locale]["decimals"]

	parts = sprintf("%0.02f", number).to_s.split "."
	integer_part = parts[0]
	sign = ""
	if integer_part.start_with? "-"
		sign = "-"
		integer_part[0] = ""
	end
	decimal_part = parts[1]
	if !decimal_part
		decimal_part = decimals_separator = ""
	end
	
	return sign + integer_part.reverse.scan(/.{1,3}/).join(thousands_separator).reverse + decimals_separator + decimal_part
end

def gen_get_current_date gmtime_offset=DEFAULT_GMT_OFFSET
	return (Time.now).gmtime.getlocal(gmtime_offset).to_date
end

# to remove a specific file , pass the complete path along with filename
def gen_remove_file file_name
	if OS_TYPE == OS_WINDOWS
		pwd = Dir.pwd + $upload_file_path + file_name
		file=pwd.gsub("/", "\\")
	else 
		file=Dir.pwd + $upload_file_path + file_name
	end
	begin
		FileUtils.remove_file(file)
		puts "Removed file: "+file
	rescue Exception=>e
		puts "Unable to remove file. Error: :#{e}" 	
	end
end

#create file and write content
def gen_create_file file_name, file_content
	File.open(file_name, 'w') do |_file|  
				_file.puts file_content
	end
end

#move file to another location
def gen_move_file source_file_path, destination_file_path
	FileUtils.mv(source_file_path, destination_file_path) 
end 
###############################################
# wait till the file gets downloaded in firefox
###############################################
	def gen_wait_for_download_to_complete
		Timeout.timeout(TIME_OUT) do
			puts "Waiting for download to complete"
			gen_wait_less until !gen_downloading_in_progress?
		end
	end
# Check if the file still getting downloaded, return true if download is In Progress else return false
	def gen_downloading_in_progress?
		if(DRIVER == "firefox")
			(gen_downloaded_files_names ALL_TYPE_FILES).grep(/\.part$/).any?
		else if(DRIVER == "chrome")
			(gen_downloaded_files_names ALL_TYPE_FILES).grep(/\.crdownload$/).any?
		end	
		end
	end
# return an array with files names with file_type extension in download folder 	
	def gen_downloaded_files_names file_type
		root_path = Dir.pwd
		files = Array.new
		if OS_TYPE == OS_WINDOWS
			file_path = root_path+$upload_file_path
			filepath = file_path.gsub("/", "\\")
		else
			filepath = root_path+$upload_file_path
		end
		Dir.chdir(filepath)
		if file_type == ".csv"
			files = Dir["*.csv"]
		elsif file_type == ".xls"
			files = Dir["*.xls"]
		elsif file_type == ".json"
			files = Dir["*.json"]
		elsif file_type == ALL_TYPE_FILES
			files = Dir["*.*"]
		else 
			puts "no file present as of type: " + file_type			
		end
		Dir.chdir(root_path)
		return files
	end

# is object visible on page	
def gen_is_object_visible obj_locator
	locator_strategy = :css
	if(obj_locator[0]=='/')
		locator_strategy = :xpath
	end
	if(locator_strategy == :css)
		return page.has_css?(obj_locator ,:wait => DEFAULT_LESS_WAIT)
	else
		return page.has_xpath?(obj_locator ,:wait => DEFAULT_LESS_WAIT)
	end
end

# to scroll to a particular element 
def gen_scroll_to obj_locator
	locator_strategy = :css
	if(obj_locator[0]=='/' || obj_locator[1]=='/')
		locator_strategy = :xpath
	end
	script = <<-JS
	  arguments[0].scrollIntoView(true);
	JS
	element_position = find(locator_strategy, obj_locator).native
	Capybara.current_session.driver.browser.execute_script(script, element_position)
 end
 
 # to start tracking the time for loading of an element on page
 def gen_start_time_tracker 
	$gen_start_test_time = Time.now()
 end

 # to show the time taken for element to load after the gen_start_time_tracker method is called.
 def gen_show_time_tracker log_information
	stop_test_time = Time.now() - $gen_start_test_time 
	SF.log_info "Time Taken for #{log_information} : #{stop_test_time}."
 end
 
 # execute code as per org type(lightening or non lightening)
def gen_execute_script (&block)
	SF.execute_script do
		block.call()
	end
end

# Method to round off the float value to any decimal values as required.
# float_number = float number 
# decimal_places- integer value to round off the float_number to this decimal places.
def gen_round_float_number float_number , decimal_places
	# In case passed float value is string, it will change it to float.
	float_number=float_number.to_f
	# round off the float number
	updated_float_num = "%.#{decimal_places}f" % float_number
	return updated_float_num
end

# On CIF UI, whenever user logout from a UI which is in Edit Mode. An alert appears if user is sure to leave the page.
# If That alert is not accepted , it wont allow user to logout or login again for executing after all block or executing next script(through rake file).
# So used below code to check for alert(Leave/Stay) and accept leave to leave the current UI and script can successfully move to next step/script.
# 
def gen_accept_alert_if_present
	begin
		gen_alert_ok
		SF.log_info "Alert present and accepted"
	rescue
		SF.log_info "No alert was present."
	end
end
# Substitute the last occurence of a pattern from a string.
# @actual_str  = Actual String Value
# @str_pattern - Pattern which last occurence need to be replaced.
# @str_replacement - Replace the last occurence of str_pattern in a string with this value(str_replacement)
def gen_sub_last_occurence actual_str , str_pattern, str_replacement
	array_of_pieces = actual_str.rpartition str_pattern
	( array_of_pieces[(array_of_pieces.find_index str_pattern)] =  str_replacement ) 
	new_str =  array_of_pieces.join
	SF.log_info  "got #{actual_str} and new #{new_str}"
	return new_str
end
