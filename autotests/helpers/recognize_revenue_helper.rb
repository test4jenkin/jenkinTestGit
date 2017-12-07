 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module RECREV
extend Capybara::DSL

#############################
# standard Recognition Revenue Page
#############################
#selectors
$recrev_recognition_date_input = "//span[text()='Recognition Date ']/../../following::div[1]//input"
$recrev_generate_data_button = "//span[text()='Generate Data']"
$recrev_currency_dropdown = "//span[text()='Currency ']/../../following::div[1]//input"
$recrev_data_row = "table[id*='treeview-'] tr:nth-of-type(#{$sf_param_substitute})"
$recrev_load_mask = "div[data-ffxtype=loadmask]"
$recrev_default_wait_for_loading_mask = 10
$recrev_plus_image_for_object = "img[role='presentation']"
$recrev_object_name = "//span[text()='#{$sf_param_substitute}']"
$recrev_currency_option = "//li[text()='#{$sf_param_substitute}'] | //div[text()='#{$sf_param_substitute}']"
$recrev_data_for_sin_load_text = "Data for Sales Invoice"
#############################
# method section
#############################
	
	#set recognition Date
	def RECREV.set_recognition_date rec_date
		SF.retry_script_block do 
			page.has_xpath?($recrev_recognition_date_input)
			find(:xpath,$recrev_recognition_date_input).set rec_date
		end
	end
	
	#set Currency
	def RECREV.set_currency currency
		find(:xpath,$recrev_currency_dropdown).click
		find(:xpath,$recrev_currency_option.sub($sf_param_substitute, currency)).click
	end

	#click generate data
	def RECREV.generate_data
		find(:xpath,$recrev_generate_data_button).click
		RECREV.wait_for_loading_mask_to_complete $recrev_default_wait_for_loading_mask
	end
	
	#get row text from table [generated data]
	def RECREV.get_data_row_text row_index
		find($recrev_data_row.sub($sf_param_substitute,row_index.to_s)).text 
	end
	
  # Method Summary:  Method to Wait for Load Mask to disappear (could take full batch time of 5 mins)
  # @param [Integer] seconds -Time in seconds to wait for the loading mask to disappear.
  
  def RECREV.wait_for_loading_mask_to_complete seconds
    if seconds == nil
      seconds = DEFAULT_TIME_OUT
    end
    counter = 0
    begin
      _isMasked = page.has_css?($recrev_load_mask)
    rescue
      puts "Unable to see Load Mask."
    end
    if _isMasked == true
      puts "Waiting for Loading to complete..."
    end
    while _isMasked == true and counter < seconds do
      counter += 1
      sleep 1
      begin
        _isMasked = page.has_css?($recrev_load_mask)
      rescue
        puts "Loading Complete."
        break
      end
    end
  end
  
  #select object from plus list
  def RECREV.select_object object_name
		find($recrev_plus_image_for_object).click
		find(:xpath,$recrev_object_name.sub($sf_param_substitute, object_name)).click	
		RECREV.wait_for_loading_mask_to_complete $recrev_default_wait_for_loading_mask
		page.has_text?($recrev_data_for_sin_load_text)
  end
end

