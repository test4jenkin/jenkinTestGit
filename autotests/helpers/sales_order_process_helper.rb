 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module SOP
extend Capybara::DSL
###################################################
# Selectors 
###################################################
$sop_opportunity_textbox = "//label[text()='Opportunity']/../following-sibling::td[1]/span/input"
$sop_account_textbox = "//label[text()='Account']/../following-sibling::td[1]/span/input"
$sop_order_status_dropdown = "//label[text()='Order Status']/../following-sibling::td[1]/span/select"
$sop_order_date_today_link = "//label[text()='Order Date']/../following-sibling::td[1]/span/span[@class='dateFormat']"
$sop_required_by_date_textbox = "//label[text()='Required By']/../following-sibling::td[1]/span/input"
$sop_shipping_date_textbox = "//label[text()='Shipping Date']/../following-sibling::td[1]/span/input"
$sop_new_sales_order_line_item = "New Sales Order Line Item"
$sop_line_item_type_dropdown = "//label[text()='Type']/../following-sibling::td[1]/span/select"
$sop_line_item_quantity_text_box = "//label[text()='Quantity']/../following-sibling::td[1]/input"
$sop_line_item_unit_price_text_box = "//label[text()='Unit Price']/../following-sibling::td[1]/input"
$sop_line_item_type_stock = "Stock"

	#Set Opportunity Name
	def SOP.set_opportunity opportunity_name
		SF.execute_script do
			find(:xpath,$sop_opportunity_textbox).set opportunity_name
		end
	end

	#Set account Name
	def SOP.set_account account_name
		SF.execute_script do
			find(:xpath,$sop_account_textbox).set account_name
		end
	end

	#Set Order Status
	def SOP.set_order_status status
		SF.execute_script do
			find(:xpath,$sop_order_status_dropdown).set status
		end
	end

	#Set Order date todat
	def SOP.set_order_status_today
		SF.execute_script do
			find(:xpath,$sop_order_date_today_link).click
		end
	end

	#Set Required by date
	def SOP.set_required_by_date date_value
		SF.execute_script do
			find(:xpath,$sop_required_by_date_textbox).set date_value
		end
	end

	#Set Shipping Date
	def SOP.set_shipping_date date_value
		SF.execute_script do
			find(:xpath,$sop_shipping_date_textbox).set date_value
		end
	end

	#Set Shipping Date
	def SOP.set_shipping_date date_value
		SF.execute_script do
			find(:xpath,$sop_shipping_date_textbox).set date_value
		end
	end

	##################################################
	#Sales Order Line Items
	##################################################

	#Set line Item type
	def SOP.set_line_item_type type_name
		SF.execute_script do
			find(:xpath,$sop_line_item_type_dropdown).set type_name
		end
	end

	#Set line Item quantity
	def SOP.set_line_item_quantity quantity
		SF.execute_script do
			find(:xpath,$sop_line_item_quantity_text_box).set quantity
		end
	end

	#Set line Item unit Price
	def SOP.set_line_item_unit_price unit_price
		SF.execute_script do
			find(:xpath,$sop_line_item_unit_price_text_box).set unit_price
		end
	end	
end