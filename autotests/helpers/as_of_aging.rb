#FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module AOA 
 extend Capybara::DSL	
#############################
#As Of Aging
#############################
###################################################
#Selectors 
###################################################
$aoa_start_process = "input[value='Start Process']"
###################################################
#Methods
###################################################

# set As of Age Date
	def AOA.set_as_of_date date
		SF.execute_script do
			fill_in "As of Date" , :with => date
		end
	end 
	
# click on start process button
	def AOA.click_start_process_button
		SF.execute_script do
			find($aoa_start_process).click
		end
	end 
end