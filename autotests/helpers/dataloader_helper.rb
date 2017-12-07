 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved. 
module DL
extend Capybara::DSL

$dl_url = "dataloader.io"
#Locators
$dl_login_with_saleforce_button = "a[class='iframe_login blue-button']"
$dl_login_iframe = "iframe[name*='fancybox']"
$dl_login_button = "input[value='Login']"
$dl_new_task_button = "a[id='cmd-new-task']"
$dl_task_import = "a[href='#import']"
$dl_list_option_account = "li[data-object='Account']"
$dl_import_task_quick_find_search_textbox = "input[type='search']"
$dl_time_period_object = "a[data-object='pse__Time_Period__c']"
$dl_next_button = "button[class$='next']"
$dl_upload_csv_button = "input[type='file']"
$dl_import_next_button = "button[class$='large next']"
$dl_save_run_button = "//button[text()='Save & Run']"
$dl_run_button = "//button[text()='Run']"
$dl_search_textbox = "input[class='search']"
$dl_allow_button = "input[title='Allow']"
#Labels
$dl_time_period_label = "Time Period"
#methods

# login in dataloader io 
	def DL.login_dataloader
		visit $dl_url
		page.has_css?($dl_login_with_saleforce_button)
		find($dl_login_with_saleforce_button).click
		page.has_css?($dl_login_iframe)
		within_frame(find($dl_login_iframe)) do 
			find($dl_login_button).click
		end
		if(page.has_css?($dl_allow_button))
			find($dl_allow_button).click
		end
		page.has_css?($dl_new_task_button)
	end
	
	def DL.import_time_period_files file_name
		SF.retry_script_block do 
			find($dl_new_task_button).click
			page.has_css?($dl_task_import)
			find($dl_task_import).click
		end
		page.has_css?($dl_list_option_account)
		find($dl_import_task_quick_find_search_textbox).set $dl_time_period_label
		page.has_css?($dl_time_period_object)
		find($dl_time_period_object).hover
		find($dl_time_period_object).click
		find($dl_next_button).click
		upload_csv_id = find($dl_upload_csv_button)[:id]
		FFA.upload_file upload_csv_id, file_name
		page.has_css?($dl_search_textbox)
		find($dl_import_next_button).click
		find(:xpath,$dl_save_run_button).click
		page.has_xpath?($dl_run_button)
		find(:xpath,$dl_run_button).click
		page.has_css?($dl_search_textbox)
		page.has_no_text?("Queued")
	end
end