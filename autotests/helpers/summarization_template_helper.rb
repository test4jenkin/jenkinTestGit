 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.

SUMMARIZATION_TEMPLATE_COLUMN_FIELD_SELECTION = 1
SUMMARIZATION_TEMPLATE_COLUMN_FROM = 2
SUMMARIZATION_TEMPLATE_COLUMN_TO = 3
SUMMARIZATION_TEMPLATE_COLUMN_SUMMARIZATION_METHOD = 4
SUMMARIZATION_TEMPLATE_COLUMN_FILTER = 5

module SummarizationTemplate
extend Capybara::DSL
#############################
# Summerization (VF pages)
#############################
# Selectors
$summarization_template_tab_field_mapping = "Field Mappings"
$summarization_template_tab_row_selection = "Row Selection"

# Buttons
$summarization_template_add_button = "a[data-ffid=addButton]"
$summarization_template_add_all_button = "a[data-ffid=addAllButton]"
$summarization_template_delete = "a[data-ffid=deleteButton]"
$summarization_template_back_to_list = "a[data-ffid=ok]"
$summarization_template_purge_data = "input[title='Purge Summarized Data']"

# Column Tab's Objects
$summarization_template_name = "table[data-ffid=TemplateName] input"
$summarization_template_dataview = "table[data-ffid=dataviewField] input"
$summarization_template_destination = "table[data-ffid=destinationField] input"
$summarization_template_field_mapping_grid = "div[data-ffid='columnsGridView'] table tbody"
$summarization_template_select_allrow_checkbox = "div[data-ffid=summarizationTemplateCheckbox] span"
$summarization_template_from_field = "table[data-ffid=FieldName] input"
$summarization_template_to_field = "table[data-ffid=DestinationFieldLabel] input"
$summarization_template_summarization_method_field = "table[data-ffid=Process] input"
$summarization_template_name = "[data-ffid=TemplateName] input"
$summarization_template_dataview = "[data-ffid=dataviewField] input"
$summarization_template_destination = "[data-ffid=destinationField] input"
$summarization_template_field_mapping_grid = "[data-ffid='columnsGridView']"
$summarization_template_select_allrow_checkbox = "[data-ffid=summarizationTemplateCheckbox] span"
$summarization_template_from_field = "[data-ffid=FieldName] input"
$summarization_template_to_field = "[data-ffid=DestinationFieldLabel] input"
$summarization_template_summarization_method_field = "[data-ffid=Process] input"
$summarization_template_green_tick_icon = "img[class*='SUMMARIZATIONTEMPLATE-image-green-tick']"
$summarization_template_column_filter_icon = "img[class*='SUMMARIZATIONTEMPLATE-image-column-filter']"
$summarization_template_row_count = $summarization_template_field_mapping_grid +" "+ "td:nth-of-type(1)"

###################################################
# Filter window 
###################################################
$summarization_template_column_filter_window = "div[data-ffid='columnFilterWindow']"
$summarization_template_column_filter_window_title = $summarization_template_column_filter_window + " " + "div[class*=f-window-header-default]"
$summarization_template_column_filter_window_filter = $summarization_template_column_filter_window + " " + "div[data-ffid=filterText]"
$summarization_template_column_filter_window_cancel_button = "a[data-ffid=columnFilterCancel]"
$summarization_template_column_filter_window_reset_button = "a[data-ffid=columnFilterReset]"
$summarization_template_column_filter_window_ok_button = "a[data-ffid=columnFilterOk]"

###################################################
# methods
###################################################
	# select summarization template tab
	def SummarizationTemplate.tab_summarization_template
		SF.tab $tab_summarization_template
	end

	# select a tab field mapping
	def SummarizationTemplate.tab_field_mapping
		FFA.click_tab_by_label $summarization_template_tab_field_mapping
	end

	# select row selection tab
	def SummarizationTemplate.tab_row_selecttion
		FFA.click_tab_by_label $summarization_template_tab_row_selection
	end

	# set the name of summarization template 
	def SummarizationTemplate.set_name summarization_template_name
		find($summarization_template_name).set summarization_template_name
	end

	# set the name of dataview on summarization template
	def SummarizationTemplate.set_dataview summarization_template_dataview_selection
		find($summarization_template_dataview).set summarization_template_dataview_selection
		FFA.wait_for_popup_msg_sync $ffa_msg_loading_dataview
		gen_wait_less
		gen_tab_out $summarization_template_dataview
	end

	# Set the name of destination
	def SummarizationTemplate.set_destination summ_dataview_dest
		find($summarization_template_destination).set summ_dataview_dest
		gen_tab_out $summarization_template_destination
		FFA.wait_for_popup_msg_sync $ffa_msg_loading
	end
	
	# select checkbox to select all rows on the grid
	def SummarizationTemplate.select_all_row
		find($summarization_template_select_allrow_checkbox).click
	end

    # select checkbox for a single row on the grid
	def SummarizationTemplate.select_checkbox row
		find("#{$summarization_template_field_mapping_grid} table:nth-of-type(#{row}) tr td:nth-of-type(#{SUMMARIZATION_TEMPLATE_COLUMN_FIELD_SELECTION})").click
	end

	# Set the From field on the grid
	def SummarizationTemplate.set_from_field row , from_field
		find("#{$summarization_template_field_mapping_grid} table:nth-of-type(#{row}) tr td:nth-of-type(#{SUMMARIZATION_TEMPLATE_COLUMN_FROM})").click 
		find($summarization_template_from_field).set from_field
		gen_tab_out $summarization_template_from_field
	end

	# Set the To field on the grid
	def SummarizationTemplate.set_to_field row , to_field
		find("#{$summarization_template_field_mapping_grid} table:nth-of-type(#{row}) tr td:nth-of-type(#{SUMMARIZATION_TEMPLATE_COLUMN_TO})").click 
		find($summarization_template_to_field).set to_field
		sleep 5
		gen_tab_out $summarization_template_to_field
	end

	# Set the Summarization Method field on the grid
	def SummarizationTemplate.select_method row , summ_method
		find("#{$summarization_template_field_mapping_grid} table:nth-of-type(#{row}) tr td:nth-of-type(#{SUMMARIZATION_TEMPLATE_COLUMN_SUMMARIZATION_METHOD})").click
		find($summarization_template_summarization_method_field).set summ_method
		gen_tab_out $summarization_template_summarization_method_field
	end

	# set all field in one row
	def SummarizationTemplate.set_field_mapping row , dv_from_field , summ_to_field
		SummarizationTemplate.add
		SummarizationTemplate.set_from_field row , dv_from_field
		SummarizationTemplate.set_to_field row , summ_to_field
	end

	# open / launch column filter popup window
	def SummarizationTemplate.open_column_filter filter_on_to_field
			row = gen_get_row_in_grid $summarization_template_field_mapping_grid ,filter_on_to_field, SUMMARIZATION_TEMPLATE_COLUMN_TO
			find("#{$summarization_template_field_mapping_grid} table:nth-of-type(#{row}) tr td:nth-of-type(#{SUMMARIZATION_TEMPLATE_COLUMN_FILTER}) img").click 
			page.has_css?($summarization_template_column_filter_window)
	end 

	# Column Filter window 
	def SummarizationTemplate.column_filter_get_title
		return find($summarization_template_column_filter_window_title).text
	end 
	def SummarizationTemplate.column_filter_get_filter
		return find($summarization_template_column_filter_window_filter).text
	end 
	def SummarizationTemplate.column_filter_cancel_button
		find($summarization_template_column_filter_window_cancel_button).click
	end 
	def SummarizationTemplate.column_filter_reset_button
		find($summarization_template_column_filter_window_reset_button).click
	end
	def SummarizationTemplate.column_filter_ok_button
		find($summarization_template_column_filter_window_ok_button).click
		page.has_no_css? $summarization_template_column_filter_window_ok_button
	end
	
	# Set the filter 
	def SummarizationTemplate.set_column_filter filter_on_to_field , filter_field , operator ,value_from , value_to , prompt , apply_column_filter
		# find the row based on file tilte
		if filter_on_to_field != nil
			SummarizationTemplate.open_column_filter filter_on_to_field
		end 
		FFA.selection_component_add_field
		FFA.selection_component_set_filter filter_field,operator,value_from,value_to,prompt
		
		if apply_column_filter == true 
			SummarizationTemplate.column_filter_ok_button
		end 
	end

	# get destination value
	def SummarizationTemplate.get_destination_value
		return find($summarization_template_destination).value	
	end

	# get dataview value
	def SummarizationTemplate.get_dataview_value
		return find($summarization_template_dataview).value	
	end
        

	# select and delete all rows
	def SummarizationTemplate.delete_all_rows
		SummarizationTemplate.select_all_row
		SummarizationTemplate.delete
	end
    

	# delete all summarization template
	def SummarizationTemplate.delete_all_summarization_template
		SummarizationTemplate.tab_summarization_template
		FFA.delete_all_record
	end

	# return data for specified row
	def SummarizationTemplate.get_grid_cell_value search_text 
		row = gen_get_row_in_grid $summarization_template_field_mapping_grid , search_text , 2
		return find($summarization_template_field_mapping_grid+ " " + "table:nth-of-type(#{row}) tr td:nth-of-type(#{SUMMARIZATION_TEMPLATE_COLUMN_SUMMARIZATION_METHOD})").text
	end
	
	# Buttons
	# Save a summarization template
	def SummarizationTemplate.save
		FFA.toolbar_save
		FFA.wait_for_popup_msg_sync $ffa_msg_saving
        gen_wait_less
	end

	# Save and Build Summarization Template
	def SummarizationTemplate.save_and_build
		FFA.toolbar_save_and_build
	end
	
	# Clone Summarization Template
	def SummarizationTemplate.clone
		FFA.toolbar_clone
		FFA.sencha_popup_click_ok
	end

	# Click Add Button
	def SummarizationTemplate.add
		find($summarization_template_add_button).click
	end

	# Click Add All Button
	def SummarizationTemplate.add_all
		find($summarization_template_add_all_button).click
	end

	# Click Delete Button
	def SummarizationTemplate.delete
		find($summarization_template_delete).click
	end

	# Click Back to List button on success message popup
	def SummarizationTemplate.back_to_list
		find($summarization_template_back_to_list).click
	end

	# Purge Summarization Template Data
	def SummarizationTemplate.purge_data summTempName
		gen_select_record  summTempName
		SF.click_button "Purge Summarized Data"
		# Click on Purge Summarized Data on the new page 
		SF.click_button "Purge Summarized Data"
		# Clcik to go back to list view
		SF.click_button "Go Back"
		page.has_css? $summarization_template_purge_data
	end
end
