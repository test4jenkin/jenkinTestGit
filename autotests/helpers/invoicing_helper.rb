#FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module INVOICING
extend Capybara::DSL

$invoicing_line_item_row_pattern = "//h3[text()='Invoice Line Items']/ancestor::div[2]/div[2]//table//tr["+$sf_param_substitute+"]"

	# invoice line Item row text
	def INVOICING.get_line_item_row_text row_num
		row_num = row_num + 1
		SF.retry_script_block do
			return find(:xpath, $invoicing_line_item_row_pattern.sub($sf_param_substitute,row_num.to_s)).text
		end
	end
end