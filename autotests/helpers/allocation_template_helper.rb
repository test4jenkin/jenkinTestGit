#FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module AllocationTemplate 

extend Capybara::DSL
#############################
# Allocation Template 
#############################
###################################################
#Selectors 
###################################################
$allocationtemplate_new_allocation_filter_structure_button = "input[title = 'New Allocation Filter Structure'] , article[class*='test-Allocation Filter Structures'] div a[title='New'] div"  
$allocationtemplate_new_allocation_filter = "input[title = 'New Allocation Filter'] , article[class*='test-Allocation Filters'] div a[title='New'] div"
$allocationtemplate_name_value = "//td [text() = 'Allocation Template Name']/following-sibling::td[1]//div | //span[text()='Allocation Template Name']/ancestor::div[1]/following::div[1]/div/span"
$allocationtemplate_save_and_new = "input[name ='save_new'] , button[title='Save & New']"

##new for allocation template
$allocationtemplate_name_input = "//label[text()='Allocation Template Name']/ancestor::td[1]/following::td[1]/div/input | //span[text()='Allocation Template Name']/ancestor::label[1]/following::input[1]"
$allocationtemplate_description_input = "//label[text()='Description']/ancestor::td[1]/following::td[1]/textarea | //span[text()='Description']/ancestor::label[1]/following::textarea[1]"
$allocationtemplate_filter_structure_position_input = "//label[text()='Filter Position']/ancestor::td[1]/following::td[1]/input | //span[text()='Filter Position']/ancestor::label[1]/following::input[1]"
$allocationtemplate_allocation_filter_gla = "//label[text()='General Ledger Account']/ancestor::td[1]/following::td[1]/span/input"

# Locators for lightning
$allocationtemplate_related_list_link = "a[title='Related']"
$allocationtemplate_filter_structure_link = "//a[contains(text(),'AFS')]"
# Labels
###################################################
#Structure Type value
###################################################
$allocationtemplate_filter_structure_type_coda_general_ledgeraccount = 'codaGeneralLedgerAccount__c'
$allocationtemplate_filter_structure_type_criteria_multiselect = 'Multiselect'
$allocationtemplate_filter_structure_type_picklist = "Filter Structure Type"
$allocationtemplate_default_filter_criteria_picklist = "Default Filter Criteria"
$allocationtemplate_allocation_filter_criteria = "Filter Criteria"
$allocationtemplate_allocation_filter_gla_label = "General Ledger Account"

##################################################
## Methods

# set allocation template name
	def AllocationTemplate.set_template_name name
		find(:xpath,$allocationtemplate_name_input).set name 
	end 
# set description of template
	def AllocationTemplate.set_description_value des_value
		find(:xpath,$allocationtemplate_description_input).set des_value
	end 
# click on new allocation filter structure button	
	def AllocationTemplate.click_new_filter_structure_button
		# click on related link to view allocation filter.
		if (SF.org_is_lightning)
			find($allocationtemplate_related_list_link).click
		end
		page.has_css?($allocationtemplate_new_allocation_filter_structure_button)
		find($allocationtemplate_new_allocation_filter_structure_button).click
		page.has_xpath?($allocationtemplate_filter_structure_position_input)
	end 
# Allocation filter structure
# set allocation filter position on allocation filter structure page
	def AllocationTemplate.set_filter_structure_filter_position position_value
		find(:xpath,$allocationtemplate_filter_structure_position_input).set position_value
	end 
# set allocation filter structure type 
	def AllocationTemplate.set_filter_structure_filter_type type_value
		SF.select_value $allocationtemplate_filter_structure_type_picklist , type_value
	end 
# set default filter criteria for allocation filter structure
	def AllocationTemplate.set_filter_structure_filter_criteria criteria_value
		SF.select_value $allocationtemplate_default_filter_criteria_picklist , criteria_value
	end 
# click on new allocation filter button	
	def AllocationTemplate.click_new_allocation_filter_button
		if (SF.org_is_lightning)
			find(:xpath , $allocationtemplate_filter_structure_link).click
			page.has_css?($allocationtemplate_related_list_link)
			find($allocationtemplate_related_list_link).click
		end
		gen_wait_until_object $allocationtemplate_new_allocation_filter
		find($allocationtemplate_new_allocation_filter).click
	end 
	
#Allocation Filter
# set allocation filter gla value
	def AllocationTemplate.set_allocation_filter_gla gla_value
		SF.fill_in_lookup $allocationtemplate_allocation_filter_gla_label,gla_value
	end 
# set allocation filter criteria
	def AllocationTemplate.set_allocation_filter_criteria criteria_value
		SF.select_value $allocationtemplate_allocation_filter_criteria , criteria_value
	end 
# Click on save and new button
	def AllocationTemplate.click_save_and_new_button
		find($allocationtemplate_save_and_new).click
		# wait for new window to disappear
		page.has_no_css?($allocationtemplate_save_and_new)
	end 
# get allocation template name
	def AllocationTemplate.get_template_name
		return find(:xpath, $allocationtemplate_name_value).text
	end 
# open allocation template detail page.	
	def AllocationTemplate.open_allocation_template_detail_page template_name
		click_link template_name
		page.has_text?(template_name)
        gen_wait_until_object_disappear $page_loadmask_message
	end 
	
end