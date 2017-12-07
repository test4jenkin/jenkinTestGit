#FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module SO
extend Capybara::DSL

$so_customer_site_sold_to_icon = "img[title='Customer Site Sold To Lookup (New Window)']"
#$so_shipment_status_label = "//label[text()='Shipment Status']"
$so_shipment_status_label = "Shipment Status"
$so_line_item_name_link_pattern = "//h3[text()='Sales Order Line Items']/ancestor::div[2]/div[2]//tr["+$sf_param_substitute+"]/th/a"
$so_line_item_item_master_input = "//label[text()='Item Master']"
$so_line_item_quantity_input = "//label[text()='Quantity']"
$so_line_item_commitment_date = "//label[text()='Commitment Date']"
$so_line_item_condition = "//label[text()='Condition']"
$so_line_item_price_input= "//label[text()='Price']"
$so_shipment_status_div= "//span[text()='Shipment Status']/../following-sibling::td[1]/div"
$so_status_div= "//span[text()='Status']/../following-sibling::td[1]/div"
$so_sales_order_number_div = "//td[text()='Sales Order Number']/following-sibling::td[1]/div"
$so_sales_order_number_invoice_list_row = "//h3[text()='Invoices']/ancestor::div[1]/following-sibling::div[1]//tr["+$sf_param_substitute+"]"
$so_line_item_check_box_pattern = "(//input[@type='checkbox'])["+$sf_param_substitute+"]"
$so_line_item_status_div = "//span[text()='Status']/ancestor::tr[1]/td[2]//div"
$so_line_item_sales_inventory_iframe = "iframe[title*='SalesInventory']"
#buttons
$so_button_allocate = "Allocate"
$so_button_submit_for_approval = "Submit for Approval"
$so_tax_and_push_to_ffa = "Tax and Push to FFA"
$so_shipment_status_allocated = "Allocated"
$so_line_item_status_new = "New"
$so_status_approved= "Approved"
$so_shipment_status_pending_pulling_all_items = "Pending Pulling All Items"
#Labels
$so_invoicing_sales_invoice_label = "Sales Invoice"
$so_invoicing_sales_invoice_status_label = "Sales Invoice Status"

	#Set customer site sold to value from lookup
	def SO.set_customer_site_sold_to site_sold_to_value
		find($so_customer_site_sold_to_icon).click		
		sleep 1# wait for the look up to appear
		within_window(windows.last) do
			page.has_text?($lookup_search_frame_lookup_text)
			SF.retry_script_block do
				page.driver.browser.switch_to.frame $lookup_search_frame
			end
			fill_in $lookup_search_text, with: site_sold_to_value 
			SF.click_button_go			
			SF.retry_script_block do
				page.driver.browser.switch_to.default_content
				page.driver.browser.switch_to.frame $lookup_result_frame
				SF.click_link site_sold_to_value			
			end
		end
	end
	
	#Set shipment status
	def SO.set_shipment_status status
		SF.retry_script_block do
		    SF.select_value $so_shipment_status_label, status
		end		
	end
	
	#click on line Item link specified row in related list
	def SO.click_line_item_link_in_list row_number
		row_number = row_number +1
		find(:xpath,$so_line_item_name_link_pattern.sub($sf_param_substitute, row_number.to_s)).click
	end
	
	#Set line Item Item master
	def SO.set_line_item_item_master item_master
		SF.retry_script_block do
			element_id = find(:xpath , $so_line_item_item_master_input)[:for]
			fill_in(element_id , :with => item_master)	
		end
	end
	
	#Set line Item quantity
	def SO.set_line_item_quantity quantity
		SF.retry_script_block do
			element_id = find(:xpath , $so_line_item_quantity_input)[:for]
			fill_in(element_id , :with => quantity)	
		end
	end
	
	#Set line Item commitment date
	def SO.set_line_item_commitment_date commitment_date
		SF.retry_script_block do
			element_id = find(:xpath , $so_line_item_commitment_date)[:for]
			fill_in(element_id , :with => commitment_date)	
		end
	end
	
	#Set line Item price
	def SO.set_line_item_price price
		SF.retry_script_block do
			element_id = find(:xpath , $so_line_item_price_input)[:for]
			fill_in(element_id , :with => price)	
		end
	end
	
	#Set line Item price
	def SO.set_line_item_condition condition_name
		SF.retry_script_block do
			element_id = find(:xpath , $so_line_item_condition)[:for]
			fill_in(element_id , :with => condition_name)	
		end
	end	
	
	#get Sales order Number
	def SO.get_sales_order_number
		SF.retry_script_block do
			return find(:xpath , $so_sales_order_number_div).text
		end
	end

	#get Sales order status
	def SO.get_status
		SF.retry_script_block do
			return find(:xpath , $so_status_div).text
		end
	end
	
	#get Sales order shipment status
	def SO.get_shipment_status
		SF.retry_script_block do
			return find(:xpath , $so_shipment_status_div).text
		end
	end
	
	#get invoice row text from releated list
	def SO.get_invoice_row_text row_number
		row_number = row_number + 1
		SF.retry_script_block do
			return find(:xpath , $so_sales_order_number_invoice_list_row.gsub($sf_param_substitute,row_number.to_s)).text
		end
	end
	
	#check line Item checkbox to allocate	
	def SO.check_line_item_to_allocate line_number
		SF.retry_script_block do
			within_frame($so_line_item_sales_inventory_iframe)do
				find(:xpath,$so_line_item_check_box_pattern.gsub($sf_param_substitute, line_number.to_s)).set(true)
			end
		end
	end
	
	#click line Items Allocate Button
	def SO.click_button_line_item_allocate
		SF.retry_script_block do
			within_frame($so_line_item_sales_inventory_iframe)do
				SF.click_button so_button_allocate
			end
		end
	end
	
	#get line Item status
	def SO.get_line_item_status
		return find(:xpath,$so_line_item_status_div).text
	end
	
	def SO.click_submit_for_approval
		SF.retry_script_block do
			SF.click_button $so_button_submit_for_approval
			SF.alert_ok
			SF.wait_for_search_button
		end
	end
end	