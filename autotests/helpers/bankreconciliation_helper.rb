 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module BR
extend Capybara::DSL
#############################
# bank reconciliation (VF pages)
#############################
#selectors
$br_reconciliation_status = "//td[text()='Reconciliation Status']/following-sibling::td//div | //span[text()='Reconciliation Status']/ancestor::div[1]/following::div[1]/div/span"

#methods
# open bank reconciliation detail page
	def BR.open_bank_reconciliation_detail_page bankreconciliation_ref
		SF.retry_script_block do
			SF.click_link bankreconciliation_ref
		end
		SF.wait_for_search_button
	end
	
# get reconciliation status
	def BR.get_bank_reconciliation_status
		return find(:xpath,$br_reconciliation_status).text
	end
end

