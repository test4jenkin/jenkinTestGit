#FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module SAM  
extend Capybara::DSL	
#############################
# Sub Analysis Mapping
#############################

##################################################
# Selectors                         #
##################################################
$sam_new_mapping_icon = "img[id^='img_subAnalysisMapping:']"
$sam_derive_transaction_line_item = "Derive Transaction Line Item from Header"
$sam_sales_invoice_header = "[id$='mapSalesInvoiceHeader']"
$sam_sales_invoice_line_item = "[id$='mapSalesInvoiceLineItem']"
$sam_transaction_header = "[id$='mapTransactionHeader']"
$sam_transaction_line_item = "[id$='mapTransactionLineItem']"

#methods
	def SAM.click_new_mapping_icon
		find($sam_new_mapping_icon).click
	end
	
	def SAM.set_derive_transaction_line_item to_check  	#to_check is boolean value
		if (to_check == true)
			check($sam_derive_transaction_line_item)
		else
			uncheck($sam_derive_transaction_line_item)
		end
	end
	
	def SAM.select_sales_invoice_header option_name
		find($sam_sales_invoice_header).select(option_name)
	end
	
	def SAM.select_sales_invoice_line_item option_name
		find($sam_sales_invoice_line_item).select(option_name)
	end
	
	def SAM.select_transaction_header option_name
		find($sam_transaction_header).select(option_name)
	end
	
	def SAM.select_transaction_line_item option_name
		find($sam_transaction_line_item).select(option_name)
	end
end