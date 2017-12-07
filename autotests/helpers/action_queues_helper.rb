#FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module AQ
extend Capybara::DSL

$aq_tab_link_pattern = "//a[text()='"+$sf_param_substitute+"']"
$aq_so_confirm_link_pattern = "//a[text()='"+$sf_param_substitute+"']/ancestor::td[1]/following-sibling::td[6]/a"
$aq_so_shipment_link_pattern = "//a[text()='"+$sf_param_substitute+"']/ancestor::tr[1]//td[1]//a"
$aq_shipment_carrier_label = "Carrier"
$aq_shipment_carrier_service_label = "Carrier Service"

$aq_shipment_confirmed = "Confirmed"
$aq_tab_warehouse = "Warehouse"
$aq_tab_shipping = "Shipping"
	
	#Set line Item Item master
	def AQ.click_tab tab_name
		SF.retry_script_block do
			find(:xpath , $aq_tab_link_pattern.sub($sf_param_substitute, tab_name)).click
			SF.wait_for_search_button
		end
	end
	
	#click sles order confirm
	def AQ.click_sales_order_confirm sales_order_name
		SF.retry_script_block do
			find(:xpath , $aq_so_confirm_link_pattern.gsub($sf_param_substitute,sales_order_name)).click			
		end
	end
	
	def AQ.click_sales_order_shipment_link sales_order_name
		SF.retry_script_block do
			find(:xpath , $aq_so_shipment_link_pattern.gsub($sf_param_substitute,sales_order_name)).click			
		end
	end
	
	#set shipment carrier value
	def AQ.set_shipment_carrier option_value
		SF.retry_script_block do
			SF.select_value $aq_shipment_carrier_label, option_value			
		end
	end
	
	#set shipment carrier service value
	def AQ.set_shipment_carrier_service option_value
		SF.retry_script_block do
			SF.select_value $aq_shipment_carrier_service_label, option_value			
		end
	end
end