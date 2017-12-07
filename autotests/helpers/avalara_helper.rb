 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module Avalara  
extend Capybara::DSL
################################
# avalara transaction common 
################################
################################
# Selectors
################################

#credentials
$avalara_url = "https://admin-development.avalara.net"
$avalara_username = "financial"
$avalara_password = "ff@avalara33"

#avalara common
$avalara_pop_up = "div[title='Stop Walk-thru']"

#transaction tab common
$avalara_doc_status = ".rgMasterTable>tbody>tr:nth-of-type(1)>td:nth-of-type(14)"
$avalara_doc_list_first_element = ".rgMasterTable>tbody>tr:nth-of-type(1)"
$avalara_doc_list_first_element_code = ".rgMasterTable>tbody>tr:nth-of-type(1)>td:nth-of-type(2)>span>a"
$avalara_filter_doc_code = "input[name$='InvoiceNum']"
$avalara_filter_from_date = "input[id$='dateInput']"
$avalara_search_go = "input[name$='imageGo']"
$avalara_transaction_tab = "#Transactions>a"
$avalara_loading_image = "img[alt$='Loading...']"
$avalara_error_on_uncommit = "span[class='MessageError']"
#transaction document common
$avalara_line_amount = "tr[class*='rgRow'] td:nth-of-type(7)"
$avalara_tax_value = "tr[class*='rgRow'] td:nth-of-type(11)"
$avalara_Jurisdiction_Type = ".SubGridItemStyle td"
$avalara_item_code = "tr[class*='rgRow'] td:nth-of-type(3)>a"
$avalara_expand_collapse_checkbox = "input[id$='chkExpandCollapse']"
$avalara_company_selector = "select[name$='comboCompanySelector']"

#transaction document edit common
$avalara_address_iframe = "//div[@id = 'RadWindowWrapper_my title']//iframe"
$avalara_address_location_code = "input[id$='Locations_Input']"
$avalara_address_location_code_dropdown = "div[id$='WpShippingAddress1_rdcLocations_DropDown']"
$avalara_img_btn_copy_from_add = "input[id$='imgBtnCopyFromAddress']"
$avalara_img_btn_copy_from_org_to_dest = "input[id$='imgBtnCopyToAddress']"
$avalara_doc_adjustment_reason = "select[id$='drpModificationReason']>option:nth-of-type(2)"
$avalara_doc_description = "textarea[id$='txtDescription']"
$avalara_doc_edit_button = "input[value='Edit']"

#transaction tab buttons and links
$avalara_doc_save_as_uncommitted_button = "input[id$='btnSave']"
$avalara_doc_ok_button = "input[id$='btnOK']"
$avalara_doc_origin_address_link = "//a[contains(text(),'Origin')]"
$avalara_doc_status_uncommitted = "Uncommitted"

#methods
	
	def Avalara.login
		SF.retry_script_block do
			visit $avalara_url
			if(!page.has_content?($avalara_username))
				fill_in "ctl00_MainContentPlaceHolder_Login1_UserName", with: $avalara_username
				fill_in "ctl00_MainContentPlaceHolder_Login1_Password", with: $avalara_password
				click_button "Log in"
				gen_wait_less
				Avalara.pop_up_handle
				page.has_content?($avalara_username)
			end
		end
	end
	
	def Avalara.pop_up_handle
		begin	
			find($avalara_pop_up).click
		rescue			
			#Nothing, means no popup	
		end
	end
	def Avalara.get_doc_status
		return find($avalara_doc_status).text
	end
	
	def Avalara.search_doc_from_list doc_num
		gen_wait_until_object $avalara_filter_doc_code
		find($avalara_filter_doc_code).set(doc_num)
		find($avalara_filter_from_date).set("01/01/2000")
		gen_tab_out $avalara_filter_from_date
		find($avalara_search_go).click
		gen_wait_until_object_disappear $avalara_loading_image
	end		
	def Avalara.select_first_doc_from_list
		find($avalara_doc_list_first_element_code).click		
	end	
	
	def Avalara.set_expand_collapse_true
		find($avalara_expand_collapse_checkbox).set(true)
	end
	
	def Avalara.get_line_amount
		return find($avalara_line_amount).text
	end
	
	def Avalara.get_item_code
		return find($avalara_item_code).text
	end
			
	def Avalara.get_tax_value
		return find($avalara_tax_value).text
	end
	
	def Avalara.get_Jurisdiction_Type
		return find($avalara_Jurisdiction_Type).text
	end
	def Avalara.select_transaction_tab
		find($avalara_transaction_tab).click
	end
	def Avalara.wait_for_page_load
		begin
			page.has_content?($avalara_username)
		rescue
			#do nothing
		end
	end
	
################################
# document status as uncommitted 
################################
		
	def Avalara.set_existing_doc_status_uncommitted record_number
		SF.retry_script_block do
			Avalara.login
			Avalara.select_transaction_tab
			gen_wait_until_object $avalara_company_selector
			find($avalara_company_selector).select "Circa96"			
			Avalara.search_doc_from_list record_number

			doc_list_element = find($avalara_doc_list_first_element)["class"]
			if(doc_list_element!="rgNoRecords")
				find($avalara_doc_list_first_element_code).click
				Avalara.wait_for_page_load
				click_button "Edit"
				Avalara.wait_for_page_load
				# set address details to set the document as uncommitted
				gen_wait_until_object $avalara_doc_adjustment_reason
				find($avalara_doc_adjustment_reason).click
				find($avalara_doc_description).set("abc")
				gen_wait_until_object $avalara_doc_save_as_uncommitted_button
				find($avalara_doc_save_as_uncommitted_button).click
				Avalara.wait_for_page_load
				# Try below logic to edit the other details only,if document is not set as uncommitted after changing the address details
				# and throws an error for other details.
				if (page.has_css?($avalara_error_on_uncommit))
					find(:xpath,$avalara_doc_origin_address_link).click
					gen_wait_more
					page.has_content?('Location Code')
					gen_wait_until_object $avalara_address_iframe
					within_frame (find(:xpath,$avalara_address_iframe))do
						find($avalara_address_location_code).click
						gen_wait_until_object $avalara_address_location_code_dropdown
						find($avalara_address_location_code_dropdown).find(:xpath,"//li[2]").click
						gen_wait_until_object $avalara_address_location_code
						page.has_content?('Location Code')
						find($avalara_doc_ok_button).click
					end
					gen_wait_until_object $avalara_img_btn_copy_from_add
					find($avalara_img_btn_copy_from_add).click
					Avalara.wait_for_page_load
					find($avalara_img_btn_copy_from_org_to_dest).click
					Avalara.wait_for_page_load
					gen_wait_until_object $avalara_doc_save_as_uncommitted_button
					find($avalara_doc_save_as_uncommitted_button).click
					Avalara.wait_for_page_load
				end
				page.has_content?('The operation completed successfully')
			end
		end					
	end
end
