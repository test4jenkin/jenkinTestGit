#FinancialForce.com, inc. claims copyright in this software, its screen display designs and
#supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
#Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
#result in criminal or other legal proceedings.
#Copyright FinancialForce.com, inc. All rights reserved.

BUTTON_SAVE = 'Save'
PRODUCT_NAME_BILLING_CENTRAL = "BILLING CENTRAL"
PRODUCT_NAME_ERP = "ERP"
PRODUCT_NAME_FFA = "FFA"
module ERPSETUP
	extend Capybara::DSL
	
	#############################################
	#ERP Setup Locators
	#############################################

  	$erpsetup_tab = "ERP Setup"
  	$erpsetup_tab_publications_and_subscription = 'PUBLICATIONS & SUBSCRIPTIONS'
  	$erpsetup_sencha_tab = '.f-tab'
	$erpsetup_sencha_button = '.f-btn'
	$erpsetup_sencha_message_box = '.f-message-box'
	$erpsetup_sencha_loading_mask = 'div[data-ffxtype=loadmask]'
	$erpsetup_sencha_message_type_grid = '.message-type-grid'
	$erpsetup_sencha_grid_header_row = '.f-grid-header-ct'
	$erpsetup_sencha_grid_heading = '.f-column-header'
  	$erpsetup_sencha_grid_row = '.f-grid-row'
	$erpsetup_sencha_grid_cell = '.f-grid-cell'
	$erpsetup_sencha_publish_checkbox = 'div[data-ffid="end-point-panel"] .f-grid-cell-checkcolumn:nth-child(3)'
	$erpsetup_sencha_subscribe_checkbox = 'div[data-ffid="end-point-panel"] .f-grid-cell-checkcolumn:nth-child(4)'
    $erpsetup_sencha_publish_checkbox_checked = $erpsetup_sencha_publish_checkbox + ' img.f-grid-checkcolumn-checked'
	$erpsetup_sencha_subscribe_checkbox_checked = $erpsetup_sencha_subscribe_checkbox + ' img.f-grid-checkcolumn-checked'
	
	#############################################
	#ERP Setup Methods
	#############################################

	###
	# Method Summary: Clicking tab on ERP Setup page
	#
	# @param [String] tab_name     Name of the tabs such as $erpsetup_tab_publications_and_subscription
	#
	def ERPSETUP.click_tab tab_name
		find($erpsetup_sencha_tab, :text => tab_name).click
	end
	
	###
	# Method Summary: Clicking button on ERP Setup page
	#
	# @param [String] button_name     Name of the button such as BUTTON_SAVE
	#
	def ERPSETUP.click_button button_name
		find($erpsetup_sencha_button, :text => button_name).click
	end

	###
	# Method Summary: Clicking popup save button on ERP Setup page
	#
	def ERPSETUP.click_popup_save_button
		within($erpsetup_sencha_message_box) do
			find($erpsetup_sencha_button, :text => BUTTON_SAVE).click
			gen_wait_until_object_disappear $erpsetup_sencha_loading_mask
		end
	end
	
	###
	# Method Summary: Setting Publication and Subscription checkbox on the Product and Message type
	#
	# @param [String] product_name     Name of the Product such as PRODUCT_NAME_BILLING_CENTRAL,PRODUCT_NAME_ERP,PRODUCT_NAME_FFA
	# @param [String] message_type     Name of the message [Example "BillingDocument.Complete","BillingDocument.Completion.Process"]
	#
	def ERPSETUP.set_publication_and_subscription product_name, message_type
		ERPSETUP.click_cell product_name, message_type
		ERPSETUP.check_publish_checkbox
		ERPSETUP.check_subscribe_checkbox
	end

	###
	# Method Summary: Setting Publication checkbox on the Product and Message type
	#
	# @param [String] product_name     Name of the Product such as PRODUCT_NAME_BILLING_CENTRAL,PRODUCT_NAME_ERP,PRODUCT_NAME_FFA
	# @param [String] message_type     Name of the message [Example "BillingDocument.Complete","BillingDocument.Completion.Process"]
	#
	def ERPSETUP.set_publication product_name, message_type
		ERPSETUP.click_cell product_name, message_type
		ERPSETUP.check_publish_checkbox
	end

	###
	# Method Summary: Setting Subscription checkbox on the Product and Message type
	#
	# @param [String] product_name     Name of the Product such as PRODUCT_NAME_BILLING_CENTRAL,PRODUCT_NAME_ERP,PRODUCT_NAME_FFA
	# @param [String] message_type     Name of the message [Example "BillingDocument.Complete","BillingDocument.Completion.Process"]
	#
	def ERPSETUP.set_subscription product_name, message_type
		ERPSETUP.click_cell product_name, message_type
		ERPSETUP.check_subscribe_checkbox
	end

	###
	# Method Summary: Click Cell of Publications and Subcriptions tab on the ERP Setup page
	#
	# @param [String] product_name     Name of the Product such as PRODUCT_NAME_BILLING_CENTRAL,PRODUCT_NAME_ERP,PRODUCT_NAME_FFA
	# @param [String] message_type     Name of the message [Example "BillingDocument.Complete","BillingDocument.Completion.Process"]
	#
	def ERPSETUP.click_cell product_name, message_type
		find_cell(product_name, message_type).click
	end
	
	###
	# Method Summary: Click Publications checkbox on the Exdpoint panel
	#
	def ERPSETUP.check_publish_checkbox
		if(!publish_checkbox_checked?)
			find($erpsetup_sencha_publish_checkbox).click
		end
	end

	###
	# Method Summary: Click Subscriptions checkbox on the Exdpoint panel
	#
	def ERPSETUP.check_subscribe_checkbox
		if(!subscribe_checkbox_checked?)
			find($erpsetup_sencha_subscribe_checkbox).click
		end
	end
	
	###
	# Method Summary: Helper method to find cell in Publications and Subscription tab
	#
	def self.find_cell product_name, message_type
		row_headings = message_type.split('.')
		find_tree_view_cell row_headings, product_name, $erpsetup_sencha_message_type_grid
	end
  	
  	###
	# Method Summary: Helper method to return cell location in Publications and Subscription tab
	#
	def self.find_tree_view_cell row_headings, col_heading_text, table_selector
		num_row_headings = row_headings.length

		col_heading_index = 0
		table = find table_selector
		columnHeadings = table.find($erpsetup_sencha_grid_header_row).all $erpsetup_sencha_grid_heading
		columnHeadings.each do |columnHeading|
			if (columnHeading.text == col_heading_text)
				break
			end
			col_heading_index += 1
		end

		row_heading_index = 0
		row_heading_col_sel = 'td:nth-child(1)'
		message_split_depth = 0
		found_row_headings = table.all row_heading_col_sel

		found_row_headings.each do |found_row_heading|
			if (found_row_heading.text == row_headings[message_split_depth])
				if message_split_depth + 1 == num_row_headings
					break
				end
				message_split_depth += 1

			end
			row_heading_index += 1
		end

		return nil if col_heading_index == 0 && row_heading_index == 0

		rows = table.all $erpsetup_sencha_grid_row
		row_cells = rows[row_heading_index].all $erpsetup_sencha_grid_cell
		cell = row_cells[col_heading_index]
		return cell
	end
	
	###
	# Method Summary: Helper method to check if the publication checkbox is checked in Endpoint panel for a cell
	#
	def self.publish_checkbox_checked?
		!first($erpsetup_sencha_publish_checkbox_checked).nil?
	end

	###
	# Method Summary: Helper method to check if the subscription checkbox is checked in Endpoint panel for a cell
	#
	def self.subscribe_checkbox_checked?
		!first($erpsetup_sencha_subscribe_checkbox_checked).nil?
	end
end