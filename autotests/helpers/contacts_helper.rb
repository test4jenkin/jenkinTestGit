 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module Contacts  
extend Capybara::DSL
#############################
# Contacs Helper
#############################
#selector
$contacts_contact_name_value= "//td[text()='Name']/following::td[1]/div | //h1[contains(@class,'slds-page-header__title')]/span"
$contacts_enable_customer_user_label = "Enable Customer User"
$contacts_login_to_community_as_user = "Log in to Community as User"
$contacts_external_user_button = "//span[text()='Manage External User']"
$contacts_name_pattern = "//span[text()='"+$sf_param_substitute+"']"
$contacts_new_button = "input[value='New Contact']"
$contacts_work_calendar_label = "Work Calendar"
$contacts_is_resource_active_checkbox_label = "Is Resource Active"
$contacts_is_resource_checkbox_label  = "Is Resource"
$contacts_salesforce_user_label = "Salesforce User"
#Methods
	# set the first name
	def Contacts.set_frist_name first_name  
		fill_in "First Name" ,:with => first_name
	end 
	# set the last name
	def Contacts.set_last_name last_name
		fill_in "Last Name" ,:with => last_name
	end
		# set the accoiunt name 
	def Contacts.set_account_name account_name 
		fill_in "Account Name" , :with => account_name
		gen_wait_less 
	end 
	# Set title 
	def Contacts.set_title title
		fill_in "Title" ,:with => title
	end
	# set phone number for contacts 
	def Contacts.set_phone phone
		fill_in "Phone" ,:with => phone
	end
	# set contact email address
	def Contacts.set_email email 
		fill_in "Email" , :with => email
	end 
	
	# set salesforce user name
	def Contacts.set_salesforce_user user_name
		fill_in $contacts_salesforce_user_label , :with => user_name
	end
	# set work calendar for contacts
	def Contacts.set_work_calendar_name name
		fill_in $contacts_work_calendar_label , :with => name
	end
	# add contact with basci fields in one go 
	def Contacts.add_contact first_name,last_name,account_name,title,phone,email
		SF.tab $tab_contacts
		SF.click_button_new

		if first_name != nil 
		 Contacts.set_frist_name first_name  
		end 
		if last_name != nil 
		 	Contacts.set_last_name last_name
		end 
		if account_name != nil 
			Contacts.set_account_name account_name 
		end 
		if phone != nil 
			Contacts.set_phone phone
		end 
		if title != nil 
			Contacts.set_title title
		end 
		if email != nil 
			Contacts.set_email email 
		end 
		Contacts.save
	end 
	
	# click on new contact button
	def Contacts.click_new_contact
		SF.click_button_new
		SF.wait_for_search_button
	end
	# Save Contacts 
	def Contacts.save
		SF.click_button_save
	end 
	
	# get contact name
	def Contacts.get_contact_name
		find(:xpath,$contacts_contact_name_value).text
	end
	
	# select option from manage external user option list
	# option- option which need to be selected
	def Contacts.manage_external_user option
		SF.execute_script do
			find(:xpath,$contacts_external_user_button).click
			sleep 1 # wait for options to appear
			SF.click_link option
		end
	end
	
	# open contact detail page
	# contact_name- name in same pattern as displayed on UI {LAST_NAME, FIRST_NAME}
	def Contacts.open_contact_detail_page contact_name
		find(:xpath, $contacts_name_pattern.sub($sf_param_substitute ,contact_name)).click
		page.has_text?(contact_name)
	end
	
	# check is resource checkbox to true
	def Contacts.check_is_resource_checkbox
		page.check $contacts_is_resource_checkbox_label
	end
	
	# check is resource active checkbox to true
	def Contacts.check_is_resource_active_checkbox
		page.check $contacts_is_resource_active_checkbox_label
	end
end 
