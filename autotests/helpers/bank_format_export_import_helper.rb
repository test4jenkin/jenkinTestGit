 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module BFEI
extend Capybara::DSL

#Button
$bfei_import_from_button = "Import From"
$bfei_choose_file_locator= "//label[contains(text(), 'File')]"

# Methods

	def BFEI.click_import_from_button
		SF.click_button $bfei_import_from_button
		SF.wait_for_search_button
	end

	def BFEI.import_file file_name_to_import
		SF.execute_script do
			element_id = find(:xpath , $bfei_choose_file_locator)[:for]
			FFA.upload_file element_id,file_name_to_import
		end
	end
end	
