#FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module OPP  
extend Capybara::DSL	

# Selectors 
# Product_selection page 
$opp_product_selection_col_product_name  = "div[id$='PRODUCT_NAME']"
$opp_product_selection_check_box_pattern = "div.x-grid3-row:nth-child("+$sf_param_substitute+") input[name='ids']"
$opp_product_selection_select_pricebook = "p1"
# Add product to page 
$opp_add_product_to_product_row_pattern = "//*[contains(text(),'"+$sf_param_substitute+"')]/.."
$opp_add_product_to_quantity = "input[id^=Quantity]"
$opp_add_product_to_sale_price = "input[id^=UnitPrice]"
$opp_add_product_to_date = "input[id^=ServiceDate]"
$opp_add_product_to_line_desc = "input[id^=Description]"

# Opportunity to Invoice vf page 
$opp_invoice_date= "input[id$='invoiceDate']"
$opp_due_date = "input[id$='dueDate']"
$opp_invoice_rate= "input[id$='documentRate']"
$opp_dual_rate= "input[id$='dualRate']"

#Opportunity View page
$opp_clone_without_product= "//*[@id='CloneMenu']/a[text()='Clone without Products']"
$opp_click_clone_button = "div[id='Clone'] , input[title='Clone']"
$opp_delete_schedule = "//h3[contains(@id,'RelatedScheduleList_title')]/../following-sibling::td/input[@value='Delete']"
$opp_account_name = "//label[text()='Account Name']/../following-sibling::td/span/input"

# buttons
$opp_create_invoice_button = "Create Invoice"
$opp_push_to_dsm = "Push to DSM"
$opp_push_to_dsm_yes = "Yes"
$opp_push_to_dsm_back = "Back"
$opp_dsm_sync = "DSM Sync"
$opp_dsm_comments = "DSM Comments"
$opp_opportunity_name_text = "Opportunity Name"

#############################
# Opportunities
#############################

###################################################
# Selectors  
###################################################
# buttons
$opp_create_invoice_button = "Create Invoice"
$opp_convert_button = "Convert"
$opp_new_opportunity_button = "New Opportunity"
$opp_list_view_generate_sales_agreement_button = "input[title*='Generate Sales Agreements']"

# objects 

# Product_selection page 
$opp_product_selection_col_product_name  = "div[id$='PRODUCT_NAME']"
$opp_product_selection_check_box_pattern = "div.x-grid3-row:nth-child("+$sf_param_substitute+") input[name='ids']"

# Add product to page 
$opp_add_product_to_product_row_pattern = "//*[contains(text(),'"+$sf_param_substitute+"')]/.."
$opp_add_product_to_quantity = "input[id^=Quantity]"
$opp_add_product_to_sale_price = "input[id^=UnitPrice]"
$opp_add_product_to_date = "input[id^=ServiceDate]"
$opp_add_product_to_line_desc = "input[id^=Description]"

# Opportunity to Invoice vf page 
$opp_invoice_date= "input[id$='invoiceDate']"
$opp_due_date = "input[id$='dueDate']"
$opp_invoice_rate= "input[id$='documentRate']"
$opp_dual_rate= "input[id$='dualRate']"
$opp_period= "//label[text()='Period']/../following-sibling::td/span/input"
$opp_opportunity_name= "//*[text()='Opportunity Name']/../td/span"
$opp_first_invoice_date= "//label[contains(text(),'First Invoice Date')]/../following-sibling::td/span" 
$opp_first_due_date= "//label[contains(text(),'First Due Date')]/../following-sibling::td/span"
$opp_currency= "//label[contains(text(),'Currency')]/../following-sibling::td"
$opp_first_period= "//label[contains(text(),'First Period')]/../following-sibling::td/span"
$opp_current_document_rate= "//label[contains(text(),'Current Document Rate')]/../following-sibling::td/span"
$opp_opportunity_lookup= "//label[text()='Opportunity']/../following-sibling::td/div/span/a"
$opp_opportunity_list_view_layout = "Opportunities List View"
$opp_generate_sales_agreements_button = "Generate Sales Agreements"
#$opp_opportunity_list_view_edit_link = "a[title*='Opportunities List View']"
#$opp_generate_sales_agreement_button_option = "//option[text()='Generate Sales Agreements']"
$opp_proposal_id = "//span[text()='Proposal ID']/following::td[1]/div[1]"
$opp_dsm_last_modified_date = "//td[text()='DSM Last Modified Date']/following::td[1]/div"
$opp_dsm_sync_error = "//td[text()='DSM Sync Error']/following::td[1]/div[1]"
$opp_dsm_sync_status = "//td[text()='DSM Sync Status']/following::td[1]/div[1]"
$opp_dsm_start_date = "//td[text()='Start Date']/following::td[1]/div[1]"
$opp_dsm_end_date = "//td[text()='End Date']/following::td[1]/div[1]"
$opp_product_row = $opp_add_product_to_product_row_pattern + "/.."
$opp_sales_agreement_prefix = "//a[contains(text(), 'SA0')]"
$opp_sales_agreement_required_checkbox = "(//label[text()='Sales Agreement Required']//following::td)[1]/input"
$opp_create_sales_agreement_checkbox = "(//label[text()='Create Sales Agreement']//following::td)[1]/input"
#label
$opp_label_account_name = "Account Name"
$opp_clone_without_product_label = "Clone without Products"
$opp_po_number = "PO Number"
$opp_close_date = "Close Date"
$opp_pricing_modal ="Pricing Model"
$opp_budget = "Budget"
$opp_advertiser_discount = "Advertiser Discount"
$opp_proposal_discount = "Proposal Discount"
$opp_additional_adjustment = "Additional Adjustment"
$opp_agency_commission = "Agency Commission"
#Opportunities Views
$opp_all_opportunies = "All Opportunities"

#Message
$opp_proposal_success_message = "The proposal was created successfully"
$opp_dsm_sync_success_message = "The opportunity and the proposal have been synced successfully."
$opp_sales_agreement_inprogress_message =	"Sales Agreement synchronization is in progress. You will be notified by email when synchronization is complete."


#methods
	def OPP.all_opportunities_view	
		SF.select_view $opp_all_opportunies
		SF.wait_for_search_button
	end 	
# Opportunities List page
	def OPP.view_opportunity opportunity_name
		SF.click_link opportunity_name
		SF.wait_for_search_button
	end
# Opportunity view Page
	def OPP.click_clone_without_product
		find($opp_click_clone_button).click
		sleep 1 # for options(if present) to display
		if page.has_link?($opp_clone_without_product_label,:wait => DEFAULT_LESS_WAIT)
			SF.click_link $opp_clone_without_product_label
		end
		SF.wait_for_search_button
	end
	
	def OPP.click_add_product
		SF.click_button "Add Product"
		SF.wait_for_search_button
	end
	def OPP.view_opp_product prod_name
		SF.click_link prod_name
		SF.wait_for_search_button
	end
	def OPP.click_create_invoice
		SF.click_action $opp_create_invoice_button	
		SF.wait_for_search_button
	end

# Opportunity Product View Page
	def OPP.view_opp_product_schedule_click_delete
		find(:xpath,$opp_delete_schedule).click
		gen_alert_ok
	end

# Opportunity Add Product
	def OPP.set_product_quantity prod_name, qty
		product_row = $opp_add_product_to_product_row_pattern.gsub(""+$sf_param_substitute+"",prod_name)
		find(:xpath,product_row).find($opp_add_product_to_quantity).set(qty)
	end

	def OPP.set_product_date prod_name, date
		product_row = $opp_add_product_to_product_row_pattern.gsub(""+$sf_param_substitute+"",prod_name)
		find(:xpath,product_row).find($opp_add_product_to_date).set(date)
	end

	# select price book
	def OPP.select_price_book pricebook
		select(pricebook, :from => $opp_product_selection_select_pricebook) 
	end
# opp first page  
	def OPP.set_opportunity_name opportunity_name 
		fill_in "Opportunity Name" , :with => opportunity_name
	end

	def OPP.select_stage opp_stage 
		select(opp_stage, :from => 'Stage') 
	end 
	def OPP.set_account_name account_name
		SF.fill_in_lookup $opp_label_account_name, account_name
	end
# Opp2invoice vf page 
	def OPP.set_invoice_date invoice_date 
		find($opp_invoice_date).set invoice_date
		gen_tab_out $opp_invoice_date
		FFA.wait_page_message $ffa_msg_updating_due_date_and_period
	end 

	def OPP.set_due_date due_date 
		find($opp_due_date).set due_date
		gen_tab_out $opp_due_date
		SF.wait_for_search_button
	end 

	def OPP.set_invoice_rate invoice_rate 
		SF.execute_script do
			find($opp_invoice_rate).set invoice_rate
		end
	end 

	def OPP.set_dual_rate dual_rate 
		find($opp_dual_rate).set dual_rate
	end 
	
	def OPP.click_convert
		SF.execute_script do
			first(:button, $opp_convert_button).click
		end
	end
	
	#click Save button
	def OPP.click_save_button
		SF.execute_script do
			click_button('Save')			
		end
	end
	
	#click Save button and accept alert
	def OPP.click_save_button_and_accept_alert
		SF.execute_script do
			click_button('Save')
			gen_alert_ok
		end
	end
	
	# get value of invoice date	
	def OPP.get_invoice_date
		SF.execute_script do
			return find($opp_invoice_date)[:value]
		end
	end
	
	# get value of due date
	def OPP.get_due_date
		SF.execute_script do
			return find($opp_due_date)[:value]
		end
	end
	
	# get value of period
	def OPP.get_period
		SF.execute_script do
			return find(:xpath, $opp_period)[:value]
		end
	end
# select the product on page product selection for opportunity after user 
# click on add prodcut button on the Opportunity main page
	def OPP.product_select product_name 
		row = 1
		all($opp_product_selection_col_product_name).each do |prod|
			if prod.text == product_name
				break
			end 
			row += 1
		end 
		prod_selection_check_box=$opp_product_selection_check_box_pattern.gsub(""+$sf_param_substitute+"",row.to_s)
		find(prod_selection_check_box).click
		SF.wait_for_search_button
	end 

	# Invoice to Opportunity page (pull)
	def OPP.convert_set_opp_name convert_opp_name 
		SF.execute_script do
			fill_in "Opportunity" , :with => convert_opp_name
		end
	end 
	
	#set DSM Comment
	def OPP.set_dsm_comments comments
		fill_in $opp_dsm_comments , :with => comments
	end
	
	#set PO Number 
	def OPP.set_po_number po_number
		fill_in $opp_po_number , :with => po_number
	end
	
	#set close date 
	def OPP.set_close_date close_date
		fill_in $opp_close_date , :with => close_date
	end
	
	#set Pricing Model
	def OPP.set_pricing_model model_val
		select(model_val, :from => $opp_pricing_modal) 
	end
	
	#set Budget 
	def OPP.set_budget budget
		fill_in $opp_budget , :with => budget
	end
	
	#set Advertiser Discount
	def OPP.set_advertiser_discount discount
		fill_in $opp_advertiser_discount , :with => discount
	end
	
	#set Proposal Discount
	def OPP.set_proposal_discount discount
		fill_in $opp_proposal_discount , :with => discount
	end
	
	#set Additional Adjustment
	def OPP.set_additional_adjustment adjustment
		fill_in $opp_additional_adjustment , :with => adjustment
	end
	
	#set Agency Commission
	def OPP.set_agency_commission commission
		fill_in $opp_agency_commission , :with => commission
	end	
	
	#get DFP proposal ID
	def OPP.get_proposal_id
		return find(:xpath,$opp_proposal_id).text
	end	
	
	#get dsm last modified date
	def OPP.get_dsm_last_modified_date
		return find(:xpath,$opp_dsm_last_modified_date).text
	end	
	
	#get DSM sync error
	def OPP.get_dsm_sync_error
		return find(:xpath,$opp_dsm_sync_error).text
	end	
	
	#get dsm sync status
	def OPP.get_dsm_sync_status
		return find(:xpath,$opp_dsm_sync_status).text
	end	
	
	#get dsm start date
	def OPP.get_dsm_start_date
		return find(:xpath,$opp_dsm_start_date).text
	end
	
	#get dsm end date
	def OPP.get_dsm_end_date
		return find(:xpath,$opp_dsm_end_date).text
	end
	
	#check create set agreement
	def OPP.select_create_sales_agreement 
		find(:xpath, $opp_create_sales_agreement_checkbox).click
	end
	
	#check Sales Agreement Required
	def OPP.select_sales_agreement_required
		find(:xpath, $opp_sales_agreement_required_checkbox).click
	end
	
	# click button generate sales agreement and confirm
	def OPP.click_button_generate_sales_agreement_button_and_confirm
		find($opp_list_view_generate_sales_agreement_button).click
		SF.wait_for_search_button
		page.has_button?($opp_push_to_dsm_yes)
		SF.click_button $opp_push_to_dsm_yes
		SF.wait_for_search_button
	end
	
	#get product row outputof sppecified product
	def OPP.get_product_row_output product_name
		return find(:xpath,$opp_product_row.gsub($sf_param_substitute, product_name)).text
	end
end 
