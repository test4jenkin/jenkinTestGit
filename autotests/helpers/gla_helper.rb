 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module GLA  
extend Capybara::DSL
#############################
# General Ledger Account 
#############################
	def GLA.create gla_name ,reporting_code ,gla_type,allow_revaluation
		if gla_name != nil 
			fill_in "Name" , :with => gla_name
		end 
		if reporting_code !=nil 
			fill_in "Reporting Code" , :with => reporting_code
		end 

		if gla_type != nil
			SF.select_value 'Type' , gla_type
		end 
		if allow_revaluation != nil
			if allow_revaluation == true 
				check "Allow Revaluation"
			elsif allow_revaluation == false 
				uncheck "Allow Revaluation"
			end
		end 
	end
end 