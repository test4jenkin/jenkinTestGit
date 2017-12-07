 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module SOQS
extend Capybara::DSL
###################################################
# Selectors 
###################################################
    $soqs_iframe = "div[id='contentDiv'] iframe"
	$soqs_start_the_wizard_link = "a[title*='Start the Wizard!']"
	$soqs_select_buisiness_process_title = "//span[text()='Select your business process']"
	$soqs_wizard_ok_button = "//a[text()='OK']"
	$soqs_wizard_source_object_dropdown = "//select[contains(@id,'sourceObject')][1]"
	$soqs_wizard_view_example_link = "//a[text()='View Example']"
	$soqs_wizard_next_link = "//a[text()='Next']"
	$soqs_wizard_skip_link = "//a[text()='Skip']"
	$soqs_wizard_run_now_link ="//a[text()='Run Now']"
	$soqs_wizard_save_link ="//a[text()='Save']"
	$soqs_wizard_close_wizard_link = "//a[text()='Close Wizard']"
	$soqs_wizard_sales_order_process_complete_text = "The Sales Order process has completed."
	$soqs_wizard_sales_order_listview = "select[id*='listView']"
	$soqs_wizard_preferred_start_time_listview = "select[id*='startTime']"
	
	$soqs_wizard_sales_order_list_option_all =	"All"
	$soqs_wizard_preferred_start_time_12_30_AM =	"12:00 AM"
	
	#methods
	#set source Object
	def SOQS.wizard_select_source_object object_name
		SF.execute_script do
			within_frame(find($soqs_iframe)) do				
				gen_wait_until_object $soqs_wizard_source_object_dropdown
				element_id = find(:xpath, $soqs_wizard_source_object_dropdown)[:id]
				select(object_name, :from => element_id)
			end
		end
	end

	#click Button OK
	def SOQS.wizard_click_button_ok
		SF.execute_script do
			within_frame(find($soqs_iframe)) do 
				gen_wait_until_object $soqs_wizard_ok_button
				find(:xpath, $soqs_wizard_ok_button).click
			end
		end
	end

	#click view example
	def SOQS.wizard_click_button_view_example
		SF.execute_script do
			within_frame(find($soqs_iframe)) do 
				gen_wait_until_object $soqs_wizard_view_example_link
				find(:xpath, $soqs_wizard_view_example_link).click
			end
		end
	end

	#click button Next
	def SOQS.wizard_click_button_next
		SF.execute_script do
			within_frame(find($soqs_iframe)) do 
				gen_wait_until_object $soqs_wizard_next_link
				find(:xpath, $soqs_wizard_next_link).click
			end
		end
	end

	#click button skip
	def SOQS.wizard_click_button_skip
		SF.execute_script do
			within_frame(find($soqs_iframe)) do 
				gen_wait_until_object $soqs_wizard_skip_link
				find(:xpath,$soqs_wizard_skip_link).click
			end
		end
	end

	#click button save
	def SOQS.wizard_click_button_save
		SF.execute_script do
			within_frame(find($soqs_iframe)) do 
				gen_wait_until_object $soqs_wizard_save_link
				find(:xpath,$soqs_wizard_save_link).click
			end
		end
	end

	#click button run now
	def SOQS.wizard_click_button_run_now
		SF.execute_script do
			within_frame(find($soqs_iframe)) do 
				gen_wait_until_object $soqs_wizard_run_now_link
				find(:xpath,$soqs_wizard_run_now_link).click
			end
		end
	end

	#click close wizard button
	def SOQS.wizard_click_button_close_wizard
		SF.execute_script do
			within_frame(find($soqs_iframe)) do 
				gen_wait_until_object $soqs_wizard_close_wizard_link
				find(:xpath,$soqs_wizard_close_wizard_link).click
			end
		end
	end
	
	#click start the wizard button
	def SOQS.wizard_click_button_start_the_wizard
		SF.execute_script do
			gen_wait_until_object $soqs_start_the_wizard_link
			find($soqs_start_the_wizard_link).click			
		end
	end
	
	#set sales order listview value
	def SOQS.set_sales_order_listview list_value
		SF.execute_script do
			within_frame(find($soqs_iframe)) do 
				gen_wait_until_object $soqs_wizard_sales_order_listview
				element_id = find($soqs_wizard_sales_order_listview)[:id]
				select(list_value, :from => element_id)
			end
		end
	end
	
	#set preferred_start_time
	def SOQS.set_preferred_start_time list_value
		SF.execute_script do
			within_frame(find($soqs_iframe)) do 
				gen_wait_until_object $soqs_wizard_preferred_start_time_listview
				element_id = find($soqs_wizard_preferred_start_time_listview)[:id]
				select(list_value, :from => element_id)
			end
		end
	end	
end
