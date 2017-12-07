#Copyright 2017 FinancialForce.com, inc. All rights reserved.
module ARCHIVING
extend Capybara::DSL

############################################
##Archiving Feature Console selectors
############################################
$arc_feature_step_description ="Assign the Accounting - Data Archiving permission set to the user."
$arc_feature_enabled_succesfully ="//li[text()='Enabled successfully.']"
$arc_feature_disabled_succesfully ="//li[text()='Disabled successfully.']"
$arc_feature_step_done_permission_set = "//li[text()='Step 1. DataArchivingAssignPermissionSet:']"
$arc_feature_On_error_locator = "//li[text()='You cannot enable a feature while there are outstanding required steps.']"
$arc_feature_revert_error_locator  = "//li[text()='You cannot revert required steps while the feature is enabled.']"

#############################
# Archiving Labels
#############################
$archiving_documents_label ="AR Documents"
$archiving_payment_status_all_label = "All"
$archiving_payment_status_paid_label = "Paid"
$archiving_set_filter_structure_number_label='Archive Set Filter Structure Number'
$archiving_set_filter_criteria_label='Filter Criteria'
$archiving_filter_structure_type_label= 'Filter Structure Type'
$archiving_set_filter_number_label='Archive Set Filter Number'
$archiving_set_filter_structure_label='Archive Set Filter Structure'
$archiving_set_label='Archive Set'
$archiving_set_year_label='Year'
$archiving_set_period_label='Period'
$archiving_new_set_button_label='New Archive Set'
$archiving_set_detail_page_label='Archive Set Detail'
$archiving_set_number_label='Archive Set Number'
$archiving_job_type_label='Job Type'
$archiving_set_status_label='Status'
$archiving_set_process_started_label= 'Process Started'
$archiving_set_process_completed_label = 'Process Completed'
$archiving_set_payment_status_label= 'Payment Status'
$archiving_set_document_type_label= 'Document Type'
$archiving_set_company_label = 'Company'
$archiving_coda_year_label= 'codaYear__c'
$archiving_coda_period_label= 'codaPeriod__c'

#############################
# Archiving Selectors
#############################

$archiving_documents_picklist = "div[data-ffid='DocumentType'] input"
$archiving_company_picklist = "div[data-ffid='Company'] input" 
$archiving_year_picklist ="div[data-ffid='codaYear__c'] input"
$archiving_period_from_picklist ="div[data-ffid='codaPeriod__cFrom'] input"
$archiving_period_to_picklist= "div[data-ffid='codaPeriod__cTo'] input"
$archiving_payment_status_picklist ="div[data-ffid='PaymentStatus'] input"
$archiving_run_button = "a[data-ffid='runButtonId']"
$archiving_clear_all_button = "a[data-ffid='clearAllButton']"
$archiving_click_on_archive_set_list_button= "a[data-ffid='backToListButton']"
$archiving_help_message="label[data-ffxtype='label']"
$archiving_click_on_new_button="//input[@title='New']"
$archiving_click_on_new_archive_set_button="//input[@value='New Archive Set']"
$archiving_filter_type="//td[text()='"+$sf_param_substitute+"']/ancestor::tr[1]/th/a"
$archiving_filter_type_link = "//a[text()='"+$sf_param_substitute+"']/ancestor::tr[1]/th/a"
$archiving_detail_page_value="//td[text()='"+$sf_param_substitute+"']/following-sibling::td[1]/div"
$archiving_detail_page_value_link="//td[text()='"+$sf_param_substitute+"']/following-sibling::td[1]/div/a"
$archiving_set_detail_page_path="//*[text()='Archive Set Detail']"

# Methods
#
# Method Summary: Set the type of documents to be archived. 
# Values for archive documents type picklist can have values 'AR-Documents'

def ARCHIVING.set_archive_documents archive_documents
	SF.execute_script do
	    find($archiving_documents_picklist).click
		find($archiving_documents_picklist).set('')
		find($archiving_documents_picklist).set(archive_documents)
		gen_tab_out $archiving_documents_picklist
	end
end 	
	
# Method Summary : Get the value of picklist for Document Type

def ARCHIVING.get_archive_documents 
	return find($archiving_documents_picklist).value
end

# Method Summary: Set the company for which data will be archived 

def ARCHIVING.set_arch_company arch_company
	SF.execute_script do
		find($archiving_company_picklist).click
		find($archiving_company_picklist).set('')
		find($archiving_company_picklist).set(arch_company)
		gen_tab_out $archiving_company_picklist
	end
end 

# Method Summary : Get the value of Company field
	
def ARCHIVING.get_arch_company 
	return find($archiving_company_picklist).value
end

# Method Summary: Set the year for which data will be archived 
# Values for years is a picklist displaying all years for the selected company

def ARCHIVING.set_arch_year arch_year
	SF.execute_script do
		find($archiving_year_picklist).click
		find($archiving_year_picklist).set('')
		find($archiving_year_picklist).set arch_year
		gen_tab_out $archiving_year_picklist
	end
end 

# Method Summary : Get the value of year field
	
def ARCHIVING.get_arch_year 
	return find($archiving_year_picklist).value
end

# Method Summary: Set the starting range for period for which data will be archived 
# Values for arch_periods_from is a picklist displaying all periods for the selected year

def ARCHIVING.set_arch_periods_from arch_periods_from
	SF.execute_script do
		find($archiving_period_from_picklist).click
		find($archiving_period_from_picklist).set arch_periods_from
		gen_tab_out $archiving_period_from_picklist
	end
end 
	
# Method Summary : Get the value of From Period field
	
def ARCHIVING.get_arch_periods_from 
	return find($archiving_period_from_picklist).value
end
	
# Method Summary: Set the ending range for period for which data will be archived 
# Values for arch_periods_to is a picklist displaying all periods for the selected year

def ARCHIVING.set_arch_periods_to arch_periods_to
	SF.execute_script do
		find($archiving_period_to_picklist).click
		find($archiving_period_to_picklist).set arch_periods_to
		gen_tab_out $archiving_period_to_picklist
	end
end 
	
# Method Summary : Get the value of To Period field 
	
def ARCHIVING.get_arch_periods_to
	return find($archiving_period_to_picklist).value
end
	
# Method Summary: Set the payment status for which data will be archived 
# Values for payment status is a picklist with 'All' or 'Paid' values. 

def ARCHIVING.set_arch_payment_status arch_payment_status
	SF.execute_script do
	    find($archiving_payment_status_picklist).click
		find($archiving_payment_status_picklist).set('')
		find($archiving_payment_status_picklist).set(arch_payment_status)
		gen_tab_out $archiving_payment_status_picklist
	end
end 

# Method Summary : Get the value of Payment Status field

def ARCHIVING.get_arch_payment_status
	return find($archiving_payment_status_picklist).value
end
	
# Method Summary: Click the run button to start the process

def ARCHIVING.click_on_run_button
	SF.execute_script do
		find($archiving_run_button).click
	end
end 

# Method Summary: Click the clear all button to reset all the values

def ARCHIVING.click_on_clear_all_button
	SF.execute_script do
		find($archiving_clear_all_button).click
	end
end	

# Method Summary: Click the archive set list button to go to Archive Set List page

def ARCHIVING.click_on_archive_set_list_button
	SF.execute_script do
		find($archiving_click_on_archive_set_list_button).click
	end
end	
	
# Method Summary: Click the New button to create records. 

def ARCHIVING.click_on_new_button
	SF.execute_script do
		find(:xpath,$archiving_click_on_new_button).click
	end
end	

# Method Summary: Click the New Archive Set button to create records.

def ARCHIVING.click_on_new_archive_set_button
	SF.execute_script do
		find(:xpath,$archiving_click_on_new_archive_set_button).click
	end
end	

# Method Summary : get the Help message displayed on the page 

def ARCHIVING.get_help_message 
	return find($archiving_help_message).text 
end

# Method Summary: Click the archive set filter number to go to its detail page 

def ARCHIVING.click_on_arcsetf_number filter_type 
	SF.execute_script do
		find(:xpath,$archiving_filter_type.sub($sf_param_substitute,filter_type)).click
	end
end 

def ARCHIVING.click_on_arcsetf_number_link filter_type 
	SF.execute_script do
		find(:xpath,$archiving_filter_type_link.sub($sf_param_substitute,filter_type)).click
	end
end 

# Method Summary: Get the values displayed on the detail page for all the fields.

def ARCHIVING.get_archive_set_detail_page_value page_value
	SF.execute_script do 
		field_value=find(:xpath,$archiving_detail_page_value.sub($sf_param_substitute,page_value)).text
		return field_value 
	end 
end

# Method Summary: click on the archive set value to read its details

def ARCHIVING.click_archive_set_filter_detail page_value
	SF.execute_script do 
		find(:xpath,$archiving_detail_page_value.sub($sf_param_substitute,page_value)).click
	end 
end

# Method Summary: click on the archive set link to go to the details page. 

def ARCHIVING.click_archive_set_filter_page_link page_value
	SF.execute_script do 
		find(:xpath,$archiving_detail_page_value_link.sub($sf_param_substitute,page_value)).click
	end 
end
end 