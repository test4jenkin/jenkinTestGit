 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.

module QuickStart
extend Capybara::DSL

###################################
# Selectors 
###################################
$tab_quickstart = "QuickStart"

#QuickStart tabs
$quickstart_tab_chart_of_accounts = ""
$quickstart_tab_tax_codes = ""
$quickstart_tab_company_setup = ""
$quickstart_tab_bank_accounts = ""

#Buttons

#Start screen
$quickstart_get_started_button = "a[data-ffid='getStartedButton']"

#Chart of accounts
$quickstart_chart_of_accounts_button = ""
$quickstart_chart_of_accounts_import_yes = ""
$quickstart_chart_of_accounts_import_no = ""
$quickstart_chart_of_accounts_import_open = ""
$quickstart_chart_of_accounts_import_cancel = ""
$quickstart_chart_of_accounts_import_next = ""
$quickstart_chart_of_accounts_edit = ""
$quickstart_chart_of_accounts_next = ""
$quickstart_chart_of_accounts_save = ""
$quickstart_chart_of_accounts_cancel = ""
$quickstart_chart_of_accounts_dimension1 = ""
$quickstart_chart_of_accounts_dimension2 = ""
$quickstart_chart_of_accounts_dimension3 = ""
$quickstart_chart_of_accounts_dimension4 = ""
$quickstart_chart_of_accounts_new_dimension = ""
#$quickstart_chart_of_accounts_remove_dimension = ""
#maybe not needed but just incase
$quickstart_chart_of_accounts_dimensions_edit = ""
$quickstart_chart_of_accounts_dimensions_next = ""
$quickstart_chart_of_accounts_dimensions_save = ""
$quickstart_chart_of_accounts_dimensions_cancel = ""

#Tax codes & rates
$quickstart_tax_codes_button = ""
$quickstart_tax_codes_import_yes = ""
$quickstart_tax_codes_import_no = ""
$quickstart_tax_codes_import_open = ""
$quickstart_tax_codes_import_cancel = ""
$quickstart_tax_codes_import_next = ""
$quickstart_tax_codes_use = ""
$quickstart_tax_codes_add = ""
#For the below we will probably have to define methods to add/remove codes
#$quickstart_tax_codes_remove = ""
#$quickstart_tax_codes_save = ""
#$quickstart_tax_codes_edit = ""

#Company setup - for next, the button name will actually be the name of the next screen
$quickstart_company_setup_button = ""
$quickstart_company_import_yes = ""
$quickstart_company_import_no = ""
$quickstart_company_import_open = ""
$quickstart_company_import_cancel = ""
$quickstart_company_import_next = ""
$quickstart_company_details_logo_upload = ""
$quickstart_company_details_next = ""
$quickstart_company_tax_details_previous = ""
$quickstart_company_tax_details_next = ""
$quickstart_company_access_previous = ""
$quickstart_company_access_next = ""
$quickstart_company_access_add_all = ""
$quickstart_company_access_remove_all = ""
#For the below we will probably have to define methods to add/remove single lines
#$quickstart_company_access_add_single = ""
#$quickstart_company_access_remove_single = ""
$quickstart_company_currencies_next = ""
$quickstart_company_currencies_previous = ""
$quickstart_company_currencies_new = ""
#For the below we will probably have to define a method to remove a certain line
#$quickstart_company_currencies_remove = ""
$quickstart_company_calendar_next = ""
$quickstart_company_calendar_previous = ""
$quickstart_company_cash_matching_next = ""
$quickstart_company_cash_matching_previous = ""
$quickstart_company_activate_next = ""
$quickstart_company_activate_previous = ""
$quickstart_company_summary_next = ""
$quickstart_company_summary_previous = ""

#Bank accounts
$quickstart_bank_accounts_button = ""
$quickstart_bank_accounts_import_yes = ""
$quickstart_bank_accounts_import_no = ""
$quickstart_bank_accounts_import_open = ""
$quickstart_bank_accounts_import_cancel = ""
$quickstart_bank_accounts_import_next = ""
$quickstart_bank_accounts_details_next = ""
$quickstart_bank_accounts_configure_glas_next = ""
$quickstart_bank_accounts_configure_glas_previous = ""
$quickstart_bank_accounts_summary_save_and_close = ""
$quickstart_bank_accounts_summary_create_another = ""

#End screen
$quickstart_finish_button = ""

######################################
# Methods 
######################################
	#Click the Get Started button on the QuickStart start screen
 	def QuickStart.click_getstarted
		find($quickstart_get_started_button).click
	end

end