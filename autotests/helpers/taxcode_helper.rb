 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module Taxcode  
extend Capybara::DSL
##################################################
# Tax Code ,Tax Echange Rates Labels and Locators
##################################################
$tax_code_name = "Tax Code"
$tax_code_description = "Description"
$tax_code_general_ledger_account = "General Ledger Account"
$tax_code_gst_code = "GST"
$tax_code_pst_qst_code = "PST/QST"
$tax_code_tax_group_picklist = "Tax Group"
$tax_code_tax_model_picklist = "Tax Model"
$tax_code_new_tax_rate_button = "input[title='New Tax Rate'] , article[aria-describedby='title#{ORG_PREFIX}TaxRates__r'] div a[title='New']"

$tax_code_parent_checkbox_label = "Parent"
$tax_code_name_value = "//td[text()='Tax Code']/following::td[1]/div | //span[text()='Tax Code']/ancestor::div[1]/following::div[1]/div/span"
$tax_code_combined_taxcode_label = "Combined Tax Code"
$tax_code_parent_checkbox= "input[id*='"+$sf_param_substitute+"']"
# tax rate
$tax_rate_start_date_label = "Start Date"
$tax_rate_label = "Rate"
$tax_rate_tax_code_label = "Tax Code"
$tax_rate_tax_code_value = "//td[text()='Tax Code']/following::td[1]/div/a | //span[text()='Tax Code']/ancestor::div[1]/following::div[1]/div[1]/div[1]/a"
#Lightning specific
$tax_code_rates_view_all_link = "a[data-relatedlistid='TaxRates__r'] span[class='view-all-label']"
$tax_code_rate_line_item_link = "//div[@class = 'active oneContent']//div[@class = 'headerRegion']/following::div[1]//tbody/tr[1]/th[1]/a"

##################################################
#############################
# Tax Code
#############################
# Create new Tax Code
	def Taxcode.set_taxcode_name name
		fill_in $tax_code_name , :with => name
	end 
# Set tax code description
	def Taxcode.set_tax_code_description description
		fill_in $tax_code_description , :with => description
	end
# set general ledger account
	def Taxcode.set_general_ledger_account gla
		SF.fill_in_lookup $tax_code_general_ledger_account ,  gla
	end
# set gst tax value
	def Taxcode.set_gst_tax_value value
		SF.fill_in_lookup $tax_code_gst_code ,  value
	end
# set gst tax value
	def Taxcode.set_pst_qst_tax_value value
		SF.fill_in_lookup $tax_code_pst_qst_code ,  value
	end
# select tax group
	def Taxcode.select_tax_group tax_group_value
		select(tax_group_value, :from => $tax_code_tax_group_picklist) 
	end
# select tax model
	def Taxcode.select_tax_model tax_model_value
		SF.select_value $tax_code_tax_model_picklist , tax_model_value
	end
# check parent checkbox [select_deselect=true to check and false to uncheck]
	def Taxcode.check_parent_checkbox select_deselect
		#element_id = find(:field_by_label,$tax_code_parent_checkbox_label)[:for]
		#find($tax_code_parent_checkbox.sub($sf_param_substitute,element_id)).set(select_deselect)
		if(select_deselect)
			page.check($tax_code_parent_checkbox_label)
		else
			page.uncheck($tax_code_parent_checkbox_label)
		end
	end
		
# Create new Tax Rate
	def Taxcode.create_new_tax_rate start_date , rate , tax_code
		if start_date != nil
			fill_in $tax_rate_start_date_label , :with=>  start_date
		end
		if rate != nil
			fill_in $tax_rate_label , :with=>  rate
		end
		if tax_code != nil
			SF.fill_in_lookup $tax_rate_tax_code_label ,   tax_code
		end
	end

# get tax code details
# get tax code name
	def Taxcode.get_taxcode_name 
		return find(:xpath,$tax_code_name_value).text
	end
# get tax code value from tax rate page
	def Taxcode.get_tax_code_of_tax_rate
		Taxcode.on_tax_rate_line_item do
			return find(:xpath , $tax_rate_tax_code_value).text
		end
	end
	
# buttons
# click new tax rate buttons	
	def Taxcode.click_new_tax_rate_button
		SF.on_related_list do 
			find($tax_code_new_tax_rate_button).click
			SF.wait_for_search_button
		end
	end
	
	# Execute the block code on Tax rate Of tax code
	# If org is lightning, user will be redirected to related list and then to tax rate item detail page.
	def Taxcode.on_tax_rate_line_item (&block)
		# If org is lightning, click on related list and open the tax rate line item.
		if (SF.org_is_lightning)
			SF.retry_script_block do
				find($sf_lightning_related_list_tab).click
				page.has_css?($tax_code_rates_view_all_link)
				find($tax_code_rates_view_all_link).click
				page.has_css?($page_grid_columns)
				# Open the tax rate line item
				find(:xpath,$tax_code_rate_line_item_link).click
			end
		end
		block.call()
	end
end 
