 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module PAYSEL
extend Capybara::DSL
#############################
# Payment Selection (VF pages)
#############################
##################################################
# Payment Selection selectors    #
##################################################
$paysel_transactions_select_all = "div[data-ffid='customSelectColumn']"
$paysel_retrieve_documents = "a[data-ffid='retrieveButton']"
$paysel_create_payment = "a[data-ffid='createPaymentPopupButton']"
$paysel_filter_list_due_date = "div[data-ffid='filterCheckbox_DUEDATE_FILTER']"
$paysel_filter_layout_due_date = "//label[text()='Due Date']"
$paysel_filter_criteria_gla = "div[data-ffid$='filterCheckbox_ACCOUNTGLA_FILTER']"
$paysel_filter_criteria_gla_label = "div[data-ffid$='filterCheckbox_ACCOUNTGLA_FILTER'] input+span+label"
$paysel_filter_gla = "div[data-ffid='ACCOUNTGLA_FILTER'] input"
$paysel_filter_gla_label = "div[data-ffid='ACCOUNTGLA_FILTER'] div[data-ffxtype = 'header'] div[class*='f-title-text']"
$paysel_create_payment_bank_account = "div[data-ffid = 'BANKACCOUNT_POPUP_FIELD'] input"
$paysel_create_payment_settlement_discount = "div[data-ffid = 'SETTLEMENTGLA_POPUP_FIELD'] input"
$paysel_create_payment_settlement_discount_label = "div[data-ffid = 'SETTLEMENTGLA_POPUP_FIELD'] div[data-ffxtype = 'header'] div[class*='f-title-text']"
$paysel_create_payment_currency_write_off = "div[data-ffid = 'WRITEOFFGLA_POPUP_FIELD'] input"
$paysel_create_payment_currency_write_off_label = "div[data-ffid = 'WRITEOFFGLA_POPUP_FIELD'] div[data-ffxtype = 'header'] div[class*='f-title-text']"
$paysel_payment_media_pattern = "//label[text()='"+$sf_param_substitute+"']/preceding-sibling::span" # replace $sf_param_substitute with payment media name (either Check or Electronic)
$paysel_payment_media_pattern_2 = "//label[text()='"+$sf_param_substitute+"']/preceding-sibling::input" # replace $sf_param_substitute with payment media name (either Check or Electronic)
$paysel_create_payment_pay_boundlist_container_pattern = "//div[contains(text(),'"+$sf_param_substitute+"')]"
$paysel_create_button = "a[data-ffid='createPaymentButton']"
$paysel_go_to_payments_home_button = "a[data-ffid='goToPaymentsHomeButton']"
$paysel_filter_list_vendor_account_name = "div[data-ffid='filterCheckbox_ACCOUNT_FILTER']"
$paysel_filter_layout_vendor_account_name = "//label[text()='Vendor Account Name']"
$paysel_continue_button_on_error_message_popup = "//span[text()='Continue']/ancestor::a"
$paysel_clear_filter_button = "//span[text()='Clear Filters']"
$paysel_due_date_to_label = "To"
$paysel_retrieved_document_row = "div[data-groupname='"+$sf_param_substitute+"'][class$='collapsible']"
$paysel_due_date_end_date = "input[id^='DUEDATE_FILTER_endDate']"
$paysel_picklist_pattern = "//li/div[(text()='#{$sf_param_substitute}')]"
$paysel_gla_picklist_value_pattern = "//div[contains(text(),'"+$sf_param_substitute+"')]"
$paysel_local_gla_label = "Local GLA"
$paysel_vendor_account_name_gear_icon = "a[data-ffid='criteriaMenu']"
$payment_selection_payment_total = "span[class='PAY-grid-title-right']"
$payment_selection_account_total = "span[class='PAY-grid-grouped-header-right']"
$payment_selection_screen_toogle_button ="a[data-ffxtype='fillbutton']"
# Methods

# Click Toggle Button
    def PAYSEL.click_payment_selection_toogle
		find($payment_selection_screen_toogle_button).click
	end

# Check payment total
    def PAYSEL.get_payment_selection_total
		payment_selection_total = nil
		SF.retry_script_block do
			payment_selection_total = find($payment_selection_payment_total).text # Payment total numeric Value
			payment_selection_total.slice! 'Payment Total' #Sliced "payment total" from String
            payment_selection_total=payment_selection_total.strip #Returning only value
		end
		return payment_selection_total
	end

# Check account total
    def PAYSEL.get_payment_account_total
		payment_account_total = nil
		SF.retry_script_block do
			payment_account_total = find($payment_selection_account_total).text # Account Total numeric value
			payment_account_total.slice! 'Account Total:'  #Sliced Account total from String
            payment_account_total=payment_account_total.strip # Returning only numeric Value
		end
		return payment_account_total
	end	

# check create payment popup settlement field label
	def PAYSEL.get_create_payment_settlement_field_label
		settlement_gla_label = nil
		SF.retry_script_block do
			settlement_gla_label = find($paysel_create_payment_settlement_discount_label).text
		end
		return settlement_gla_label
	end
# check create payment popup settlement field label
	def PAYSEL.get_create_payment_writeoff_field_label
		writeoff_gla_label = nil
		SF.retry_script_block do
			writeoff_gla_label = find($paysel_create_payment_currency_write_off_label).text
		end
		return writeoff_gla_label
	end	
# check filter gla label
	def PAYSEL.get_filter_gla_label
		filter_gla_label = nil
		SF.retry_script_block do
			filter_gla_label = find($paysel_filter_gla_label).text
		end
		return filter_gla_label
	end
# Check criteria gla label
	def PAYSEL.get_gla_checkbox_label
		checkbox_label = nil
		SF.retry_script_block do
			page.has_css?($paysel_filter_criteria_gla_label)
			checkbox_label = find($paysel_filter_criteria_gla_label).text
		end
		return checkbox_label
	end
# deselect Due Date(checkbox) filter
# mark_check is a boolean value
	def PAYSEL.set_due_date_filter mark_check
		SF.execute_script do
			# Check if sencha is already checked.
			checkbox_checked = FFA.is_sencha_check $paysel_filter_list_due_date
			if (mark_check)
				if (!checkbox_checked)
				    begin
					 find($paysel_filter_list_due_date + " input").click
					rescue
					 find($paysel_filter_list_due_date ).click
					end
				end
			else
				if(checkbox_checked)
					begin
					 find($paysel_filter_list_due_date + " span[class*=f-form-checkbox]").click
					rescue
					 find($paysel_filter_list_due_date ).click
					end
				end
			end
		end
	end
# select - deselect gla filter checkbox
# mark_check is a boolean value
	def PAYSEL.set_gla_filter mark_check
		SF.execute_script do
			if (mark_check)
			  FFA.sencha_check($paysel_filter_criteria_gla)
			  page.has_text?($paysel_local_gla_label)
			else
			  FFA.sencha_uncheck($paysel_filter_criteria_gla)
			  page.has_no_text?($paysel_local_gla_label)
			end
		end
		page.has_css?($paysel_filter_gla_label)
	end
# click Retrieve documents
	def PAYSEL.click_retrieve_documents
		SF.execute_script do
			find($paysel_retrieve_documents).click
			gen_wait_until_object_disappear $page_loadmask_message
		end
	end
# select all transactions	
	def PAYSEL.select_all_transactions
		SF.execute_script do
			find($paysel_transactions_select_all).click
			gen_wait_less # after selecting transaction, It takes some time for create payment button to become enable
		end
	end
# click Create payment
	def PAYSEL.click_create_payment
		SF.retry_script_block do
			SF.execute_script do
				find($paysel_create_payment).click
			end
		end
	end
# set GLA value in the filter set 
	def PAYSEL.set_gla_value gla_name
		SF.execute_script do
			gla_name.each do |value|
				find($paysel_filter_gla).click
				find($paysel_filter_gla).set value
				CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
				gen_tab_out $paysel_filter_gla
			end
		end
	end
	
	def PAYSEL.select_gla_value gla_name 
		SF.execute_script do
			find($paysel_filter_gla).click
			find($paysel_filter_gla).set gla_name
			CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
			list_value = $paysel_gla_picklist_value_pattern.gsub($sf_param_substitute, gla_name)
			find(:xpath, list_value).click
		end
	end
# set bank account on create payment popup
	def PAYSEL.set_create_payment_bank_account bank_acc_name
		SF.retry_script_block do
			SF.execute_script do
				find($paysel_create_payment_bank_account).set bank_acc_name
				find(:xpath, $paysel_create_payment_pay_boundlist_container_pattern.gsub($sf_param_substitute, bank_acc_name)).click
			end
		end
	end
# set settlement discount on create payment pop up
	def PAYSEL.set_create_payment_settlement_discount gla_name
		SF.retry_script_block do
			SF.execute_script do
				find($paysel_create_payment_settlement_discount).set gla_name
				find(:xpath, $paysel_create_payment_pay_boundlist_container_pattern.gsub($sf_param_substitute, gla_name)).click
			end
		end
	end
# set currency write-off on create payment pop up	
	def PAYSEL.set_create_payment_currency_write_off gla_name
		SF.retry_script_block do
			SF.execute_script do
				find($paysel_create_payment_currency_write_off).set gla_name
				find(:xpath, $paysel_create_payment_pay_boundlist_container_pattern.gsub($sf_param_substitute, gla_name)).click
			end
		end
	end
# choose payment media on create payment pop up
	def PAYSEL.choose_create_payment_payment_media media_name
		SF.retry_script_block do
			SF.execute_script do
				if page.has_xpath?($paysel_payment_media_pattern.gsub($sf_param_substitute, media_name))
					find(:xpath, $paysel_payment_media_pattern.gsub($sf_param_substitute, media_name)).click
				else
					find(:xpath, $paysel_payment_media_pattern_2.gsub($sf_param_substitute, media_name)).click
				end
			end
		end
	end
# click create button on Create payment pop up
	def PAYSEL.click_create_button
		SF.retry_script_block do
			SF.execute_script do
				page.has_css?($paysel_create_button)
				find($paysel_create_button).click
			end
			gen_wait_until_object_disappear $page_loadmask_message
		end
	end
# click go to payments home button on Create Payment pop up
	def PAYSEL.click_go_to_payments_home_button
		SF.retry_script_block do
			SF.execute_script do
				page.has_css?($paysel_go_to_payments_home_button)
				find($paysel_go_to_payments_home_button).click
			end
		end
	end

# set Vendor Account Name(checkbox) filter
# mark_check is a boolean value
	def PAYSEL.set_vendor_account_name_filter mark_check
		SF.retry_script_block do
			if (mark_check)
			  FFA.sencha_check($paysel_filter_list_vendor_account_name)
			else
			  FFA.sencha_uncheck($paysel_filter_list_vendor_account_name)
			end
		end
	end
	
	def PAYSEL.click_continue_button
		SF.retry_script_block do
			find(:xpath, $paysel_continue_button_on_error_message_popup).click
		end
	end
# set due date => end date filter
	def PAYSEL.set_due_date_end_date_filter due_date
		SF.retry_script_block do
			fill_in $paysel_due_date_to_label, :with=> due_date
		end
	end
# expand retrieved documents
	def PAYSEL.expand_retreived_documents account_name
		SF.retry_script_block do
			find($paysel_retrieved_document_row.gsub($sf_param_substitute, account_name)).click
		end
	end
	##
	# Method Summary: Returns the count of GLA's present in the input field
	#
	# @param [String] gla_list to pass the list of gla's 
	#
	def PAYSEL.get_matched_count_gla gla_list
		SF.retry_script_block do
			num_of_field_present_in_picklist=0
			gla_list.each do |value|
				picklist_filtered_value = $paysel_picklist_pattern.sub($cif_param_substitute,value.to_s)
				if page.has_xpath?(picklist_filtered_value)
					num_of_field_present_in_picklist+=1
					SF.log_info "value is present in picklist: "+value
				else	
					SF.log_info "Value is not present in picklist: "+ value
				end
			end
			return num_of_field_present_in_picklist
		end
	end
end
