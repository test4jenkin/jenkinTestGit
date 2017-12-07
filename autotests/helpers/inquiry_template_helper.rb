 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.

INQUIRY_TEMPLATE_COLUMN_FIELD_SELECTION = 1
INQUIRY_TEMPLATE_COLUMN_TYPE = 2 
INQUIRY_TEMPLATE_COLUMN_FIELD = 3 
INQUIRY_TEMPLATE_COLUMN_TITLE = 4
INQUIRY_TEMPLATE_COLUMN_MODE = 5
INQUIRY_TEMPLATE_COLUMN_FORMULA = 6
INQUIRY_TEMPLATE_COLUMN_FORMATTING = 8
INQUIRY_TEMPLATE_COLUMN_FILTER = 9
INQUIRY_TEMPLATE_COLUMN_COMMON_NAME = 10
INQUIRY_TEMPLATE_COLUMN_DRILL_INQ_TEMPLATE = 11
module InquiryTemplate  
extend Capybara::DSL
###################################################
# Selectors 
###################################################

# aliases 
$inquiry_template_tab_columns = "Columns"
$inquiry_template_tab_row_selection = "Row Selection"
$inquiry_template_tab_reverse_sign = "Reverse Sign"
$inquiry_template_tab_sort_group = "Sort and Group"
$inquiry_template_tab_common_name_override = "Common Name Override"
$inquiry_template_tab_ledger_inquiry = "Ledger Inquiry"
$inquiry_template_tab_rcp = "Related Content Panes"
$inquiry_template_tab_general = "General"

# buttons 
$inquiry_template_add_button = "a[data-ffid=addButton]"
$inquiry_template_add_all_button = "a[data-ffid=addAllButton]"
$inquiry_template_delete = "a[data-ffid=deleteButton]"

#22699 - radio buttons
$inquiry_template_radio_actionview = "div[data-ffid=TemplateTypeActionViewOption] input"
$inquiry_template_radio_ledgerinquiry = "div[data-ffid=TemplateTypeLedgerInquiryOption] input"

# Column's Tab objects 
$inquiry_template_name = "div[data-ffid=TemplateName] input"
$inquiry_template_dataview = "div[data-ffid=dataviewField] input"
$inquiry_template_column_grid = "div[data-ffid='columnsGridView']"
$inquiry_template_column_grid_table  = $inquiry_template_column_grid + " table"
$inquiry_template_column_grid_all_rows = $inquiry_template_column_grid+" tr"
$inquiry_template_select_all_fields_checkbox = "div[data-ffid=inquiryTemplateCheckbox] span"
$inquiry_template_type = "div[data-ffid=Type] input"
$inquiry_template_field = "div[data-ffid=FieldId] input"
$inquiry_template_title = "div[data-ffid=DisplayName] input"
$inquiry_template_mode = "div[data-ffid=Mode] input"
$inquiry_template_drill_inquiry_template = "div[data-ffid=DrillId] input"
$inquiry_template_green_tick_icon = "img[class*='INQUIRYTEMPLATE-image-green-tick']" # green tick icon 
$inquiry_template_column_filter_icon = "img[class*='INQUIRYTEMPLATE-image-column-filter']" # filter icon
$inquiry_template_column_transpose_icon = "img[class*='INQUIRYTEMPLATE-image-column-transpose']" # filter icon

# Transpose drill inquiry Template window 
$inquiry_template_transpose_drill_window = "div[data-ffid='transposeWindow']"
$inquiry_template_transpose_drill_window_title  = $inquiry_template_transpose_drill_window + " "+ "div[data-ffxtype=header]"
$inquiry_template_transpose_drill_window_cancel_button = "a[data-ffid=transposeCancelButton]"
$inquiry_template_transpose_drill_window_clear_button = "a[data-ffid=transposeClearButton]"
$inquiry_template_transpose_drill_window_reset_button = "a[data-ffid=transposeResetButton]"
$inquiry_template_transpose_drill_window_ok_button = "a[data-ffid=transposeSaveButton]"
$inquiry_template_transpose_drill_template = "div[data-ffid=DrillTemplateId] input"
$inquiry_template_tranpose_grid = "div[data-ffid=transposeWindow] div[data-ffxtype=grid] table" # tr:nth-of-type(1) td:nth-of-type(1)"

# Ledger inquiry tab


$inquiry_template_ledger_inquiry_tab = "div[data-ffid=tabPanel] a:nth-of-type(7)"
$ledgerinquiry_basis_date = "div[data-ffid=BasisDate] input"
$ledgerinquiry_base_date = "div[data-ffid=BaseDate] input"
$ledgerinquiry_show_doc_count = "div[data-ffid=LedgerInquiryShowDocumentCount] input"
$ledgerinquiry_show_doc_count_box = "div[data-ffid=ShowDocumentCount][data-ffxtype=checkbox].f-form-cb-checked"
$ledgerinquiry_exclude_on_hold = "div[data-ffid=ExcludeDocumentsOnHold] input"
$ledgerinquiry_exclude_on_hold_box = "div[data-ffid=ExcludeDocumentsOnHold][data-ffxtype=checkbox].f-form-cb-checked"
$inquiry_template_column_filter_drill = "div[data-ffid='ColumnFilterDrill'] input"
$inquiry_template_summarization_template = "div[data-ffid=SummarizationTemplateComboBox] input"


# Row Selection Tab
# shared objects with selection component

# Reverse Sign Tab
# most objects shared with selection component
$inquiry_template_reversesign_sign_reversal = "div[data-ffid='templateSignFilterCosmetic'] input"

# Aggregation tab (general)
$inquiry_template_aggregation_tab = 'div[data-ffid=aggregationForm]'
$inquiry_template_aggregation_summarize_duplicate_rows_table = "div[data-ffid='SummarizeDuplicateRows']"
$inquiry_template_summarize_duplicate_rows = "div[data-ffid='aggregationForm'][data-ffxtype=panel]" 
$inquiry_template_aggregation_summarize_duplicate_rows_checkbox  = $inquiry_template_aggregation_summarize_duplicate_rows_table+" "+"input"
$inquiry_template_select_all_button = "[data-ffid=selectAll]"
$inquiry_template_deselect_all_button = "[data-ffid=deselectAll]"

# Sort and Group Tab 
# shared objects with  Sorting and grouping component

# Common name override Tab
$inquiry_template_common_name_override_add_button = "a[data-ffid=commonNameAddButton]"
$inquiry_template_common_name_override_delete_button = "a[data-ffid=commonNameDeleteButton]"
$inquiry_template_common_name_override_field  = "div[data-ffid=fieldComboBox] input"  #"div[data-ffid=commonNameField] input"
$inquiry_template_common_name_override_common_name = "div[data-ffid=CommonName] input"
$inquiry_template_common_name_override_select_all_rows = "div[data-ffid=commonNameGridCheckbox] [data-ref='textEl']"
$inquiry_template_common_name_grid = "div[data-ffxtype='tableview']"
$inquiry_template_common_name_table = "div[data-ffxtype='tableview'] table"

# Related content pane tab 
$inquiry_template_rcp_header = "div[data-ffid=rcpSelection] [class=f-column-header-text]"
$inquiry_template_rcp_available = "div[data-ffid=fromGrid]"
$inquiry_template_rcp_selected = "div[data-ffid=toGrid]"
$inquiry_template_rcp_available_grid = $inquiry_template_rcp_available + " table"
$inquiry_template_rcp_selected_grid = $inquiry_template_rcp_selected  + " table"
$inquiry_template_rcp_default = "td[class*=-radio-column] img[class*=f-grid-checkcolumn-checked]"

$inquiry_template_rcp_center_button_bar = "div[data-ffid=centerButtonPanel]" # a[data-ffid*=Btn]"
$inquiry_template_rcp_add = "a[data-ffid=addBtn]"
$inquiry_template_rcp_remove = "a[data-ffid=removeBtn]"
$inquiry_template_rcp_add_all = "a[data-ffid=addAllBtn]"
$inquiry_template_rcp_remove_all = "a[data-ffid=removeAllBtn]"
$inquiry_template_rcp_tree_expand_pattern = "//span[contains(text(),'"+$sf_param_substitute+"')]/preceding-sibling::img[2]"



# Available actions
$inquiry_template_available_actions = "div[data-ffid=actionsForm]"
$inquiry_template_action_one = "[data-ffid=action-0] input"
$inquiry_template_action_two = "[data-ffid=action-1] input"

###################################################
# Filter window 
###################################################
$inquiry_template_column_filter_window = "div[data-ffid='columnFilterWindow']"
$inquiry_template_column_filter_window_title = $inquiry_template_column_filter_window + " " + "div[class*=f-window-header-default]"
$inquiry_template_column_filter_window_filter = $inquiry_template_column_filter_window + " " + "div[data-ffid=filterText]"
$inquiry_template_column_filter_window_cancel_button = "a[data-ffid=columnFilterCancel]"
$inquiry_template_column_filter_window_reset_button = "a[data-ffid=columnFilterReset]"
$inquiry_template_column_filter_window_ok_button = "a[data-ffid=columnFilterOk]"
# Formatting window
$red_color = "FF0000"
$green_color = "339966"
$blue_color = "0000FF"
$orange_color = "FF6600"
$purple_color = "000080"
$pink_color = "FF99CC"
$yellow_color = "FFCC00"
$black_color = "000000"
$inquiry_template_formatting_window = "div[data-ffid=formattingWindow]"
$inquiry_template_formatting_window_scaling = "div[data-ffid=Scaling] input"
$inquiry_template_formatting_window_decimal_places = "div[data-ffid=DecimalPlaces] input"
$inquiry_template_formatting_window_show_separator = "div[data-ffid=ShowNumberSeparators] input"
$inquiry_template_formatting_window_negative_number_format = "div[data-ffid=NegativeNumberFormat] input"
$inquiry_template_formatting_window_operator = "div[data-ffid=Condition] input"
$inquiry_template_formatting_window_from = "div[data-ffid=colFormConditionValue] input ,div[data-ffid=colFormConditionValue] textarea"
$inquiry_template_formatting_window_to = "div[data-ffid=colFormConditionToValue] input"
$inquiry_template_formatting_window_cancel_button = "a[data-ffid=colFormCancelButton]"
$inquiry_template_formatting_window_clear_button = "a[data-ffid=colFormClearButton]"
$inquiry_template_formatting_window_reset_button = "a[data-ffid=colFormResetButton]"
$inquiry_template_formatting_window_ok_button = "a[data-ffid=colFormSaveButton]"
$inquiry_template_formatting_window_number_text_true = "a[data-ffid=colFormTrueNumTextPick]"
$inquiry_template_formatting_window_number_fill_true = "a[data-ffid=colFormTrueNumFillPick]"
$inquiry_template_formatting_window_number_text_false = "a[data-ffid=colFormFalseNumTextPick]"
$inquiry_template_formatting_window_number_fill_false = "a[data-ffid=colFormFalseNumFillPick]"
$inquiry_template_formatting_window_colors_selection = "div[data-ffid=ColorMenuId][data-ffxtype=colormenu]"

Add = "Add"
Remove = "Remove"
# Methods 
	# set the name of inquiry template 
	def InquiryTemplate.set_name inq_template_name
		SF.execute_script do
			gen_wait_until_object $inquiry_template_name
			find($inquiry_template_name).set inq_template_name
		end
	end
	# set the name of dataview on inquiry template 
	def InquiryTemplate.set_dataview inquiry_template_data_view_name
		SF.execute_script do
			find($inquiry_template_dataview).set inquiry_template_data_view_name
			FFA.wait_for_popup_msg_sync $ffa_msg_loading_sencha
			find($gen_f_list_plain).find("li",:text => inquiry_template_data_view_name).click
			FFA.wait_for_popup_msg_sync $ffa_msg_loading_dataview
		end
	end
	# Buttons
	# save an inquiry template 
	def InquiryTemplate.save
		FFA.toolbar_save
		SF.execute_script do
			FFA.wait_for_popup_msg_sync $ffa_msg_saving
		end
		gen_wait_less
	end
	def InquiryTemplate.save_and_run
		FFA.toolbar_save_and_run
		SF.execute_script do
			FFA.wait_for_popup_msg_sync $ffa_msg_saving
			FFA.wait_for_popup_msg_sync $ffa_msg_loading
		end
	end
	
	def InquiryTemplate.tab_sort_and_group
		FFA.click_grid_tab_by_label $inquiry_template_tab_sort_group
	end 

	# click add button 
	def InquiryTemplate.add 
		find($inquiry_template_add_button).click
		gen_wait_less
	end
	# click Add all button 
	def InquiryTemplate.add_all 
		SF.execute_script do
			find($inquiry_template_add_all_button).click
		end
		gen_wait_less
	end
	# Click Delete button 
	def InquiryTemplate.delete
		SF.execute_script do
			find($inquiry_template_delete).click
		end
		gen_wait_less
	end
	# open an inquiry template 
	def InquiryTemplate.open inquiry_template_name 
		SF.click_button_go
		gen_click_link_and_wait inquiry_template_name
		page.has_css?($inquiry_template_name)
	end
# --------------------------#	
# Columns Tab Methods
# --------------------------# 
	def InquiryTemplate.tab_columns 
		FFA.click_grid_tab_by_label $inquiry_template_tab_columns
	end 
	# select a field on the columns tab , pass the name of the field.
	def InquiryTemplate.select_field field_name 
		row = gen_get_row_in_grid $inquiry_template_column_grid ,field_name, INQUIRY_TEMPLATE_COLUMN_FIELD
		find("#{$inquiry_template_column_grid} table:nth-of-type(#{row}) tr td:nth-of-type(#{INQUIRY_TEMPLATE_COLUMN_FIELD_SELECTION})").click 
	end 
	# select a column on the columns tab by title , pass the title of the column.
	def InquiryTemplate.select_column column_title
		row = gen_get_row_in_grid $inquiry_template_column_grid ,column_title, INQUIRY_TEMPLATE_COLUMN_TITLE
		find("#{$inquiry_template_column_grid} table:nth-of-type(#{row}) tr td:nth-of-type(#{INQUIRY_TEMPLATE_COLUMN_FIELD_SELECTION})").click 
	end 

	def InquiryTemplate.set_type row , column_type
		# check if input field is already displayed.
		input_field_available = gen_is_object_visible $inquiry_template_type
		# If input field is not available,click on field to make input field available.
		if(!input_field_available)
			find("#{$inquiry_template_column_grid} table:nth-of-type(#{row}) tr td:nth-of-type(#{INQUIRY_TEMPLATE_COLUMN_TYPE})").click 
		end
		find($inquiry_template_type).set column_type
	end
	
	def InquiryTemplate.set_field row , column_field
		# check if input field is already displayed.
		input_field_available = gen_is_object_visible $inquiry_template_field
		# If input field is not available,click on field to make input field available.
		if(!input_field_available)
			find("#{$inquiry_template_column_grid} table:nth-of-type(#{row}) tr td:nth-of-type(#{INQUIRY_TEMPLATE_COLUMN_FIELD})").click 
		end
		# set the value
		find($inquiry_template_field).set column_field
		gen_tab_out $inquiry_template_field
	end

	#  set the title of the field 
	# field_name : if its a string it will look for the name if its integer then it will set the title for that row 
	# for formula fields pass the row number
	def InquiryTemplate.set_title field_name , field_title
		if field_name.is_a?(String)
			row = gen_get_row_in_grid $inquiry_template_column_grid ,field_name, INQUIRY_TEMPLATE_COLUMN_FIELD
		else 
			row = field_name
		end 
		# check if input field is already displayed.
		input_field_available = gen_is_object_visible $inquiry_template_title
		# If input field is not available,click on field to make input field available.
		if(!input_field_available)
			find("#{$inquiry_template_column_grid} table:nth-of-type(#{row}) tr td:nth-of-type(#{INQUIRY_TEMPLATE_COLUMN_TITLE})").click 
		end
		# set the value
		find($inquiry_template_title).set field_title
		gen_tab_out $inquiry_template_title
	end 
	# Set the Mode for the field
	# field_name : if you want to set the Mode by Field Name then pass the field_name as string (Filed name ) 
	# For formula fields where there is no Title then pass the row number to set the Mode 
	def InquiryTemplate.set_mode field_name , field_mode
		if field_name.is_a?(String)
			row = gen_get_row_in_grid $inquiry_template_column_grid ,field_name, INQUIRY_TEMPLATE_COLUMN_FIELD
		else 
			row = field_name
		end
		# check if input field is already displayed.
		input_field_available = gen_is_object_visible $inquiry_template_mode
		# If input field is not available,click on field to make input field available.
		if(!input_field_available)
			find("#{$inquiry_template_column_grid} table:nth-of-type(#{row}) tr td:nth-of-type(#{INQUIRY_TEMPLATE_COLUMN_MODE})").click 
		end
		# set the value
		find($inquiry_template_mode).set field_mode
		gen_tab_out $inquiry_template_mode
	end 
	# Set the Drill Inquiry Template
	def InquiryTemplate.set_drill_template tilte , field_drill_template
		row = gen_get_row_in_grid $inquiry_template_column_grid ,tilte, INQUIRY_TEMPLATE_COLUMN_TITLE
		SF.execute_script do
			find("#{$inquiry_template_column_grid} table:nth-of-type(#{row}) tr td:nth-of-type(#{INQUIRY_TEMPLATE_COLUMN_DRILL_INQ_TEMPLATE})").click 
			find($inquiry_template_drill_inquiry_template).set field_drill_template
			gen_tab_out $inquiry_template_drill_inquiry_template
		end
	end
	
	def InquiryTemplate.add_count_column row , column_field , column_title
	 	InquiryTemplate.add
	 	InquiryTemplate.set_type row , "Count"
	 	InquiryTemplate.set_field row , column_field
	 	InquiryTemplate.set_title row , column_title
	end 
	
	def InquiryTemplate.add_field_column row , column_field , column_title , column_mode
	 	InquiryTemplate.add
	 	InquiryTemplate.set_type row , "Field"
	 	InquiryTemplate.set_field row , column_field
	 	InquiryTemplate.set_title row , column_title
	 	InquiryTemplate.set_mode row , column_mode
	end 

	# select check box for selecting all the rows on the data view Field tab 
	def InquiryTemplate.select_all_fields_checkbox
		SF.execute_script do
			find($inquiry_template_select_all_fields_checkbox).click
		end
		gen_wait_less
	end
	# open / launch column filter popup window
	def InquiryTemplate.open_column_filter filter_on_field_title
			row = gen_get_row_in_grid $inquiry_template_column_grid ,filter_on_field_title, INQUIRY_TEMPLATE_COLUMN_TITLE
			find("#{$inquiry_template_column_grid} table:nth-of-type(#{row}) tr td:nth-of-type(#{INQUIRY_TEMPLATE_COLUMN_FILTER}) img").click 
			page.has_css?($inquiry_template_column_filter_window)
	end 
	# Column Filter window 
	def InquiryTemplate.column_filter_get_title
		return find($inquiry_template_column_filter_window_title).text
	end 
	def InquiryTemplate.column_filter_get_filter
		return find($inquiry_template_column_filter_window_filter).text
	end 
	def InquiryTemplate.column_filter_cancel_button
		find($inquiry_template_column_filter_window_cancel_button).click
	end 
	def InquiryTemplate.column_filter_reset_button
		find($inquiry_template_column_filter_window_reset_button).click
	end
	def InquiryTemplate.column_filter_ok_button
		find($inquiry_template_column_filter_window_ok_button).click
		page.has_no_css? $inquiry_template_column_filter_window_ok_button
	end
	# Set the filter 
	def InquiryTemplate.set_column_filter filter_on_field_title , filter_field , operator ,value_from , value_to , prompt , apply_column_filter
		# find the row based on file tilte
		if filter_on_field_title != nil
			InquiryTemplate.open_column_filter filter_on_field_title
		end 
		FFA.selection_component_add_field
		FFA.selection_component_set_filter filter_field,operator,value_from,value_to,prompt
		
		if apply_column_filter == true 
			InquiryTemplate.column_filter_ok_button
		end 
	end 
# open / launch formatting popup window
	def InquiryTemplate.open_column_formatting_window formatting_column_title
		SF.retry_script_block do
			row = gen_get_row_in_grid $inquiry_template_column_grid ,formatting_column_title, INQUIRY_TEMPLATE_COLUMN_TITLE
			SF.execute_script do
				find("#{$inquiry_template_column_grid} table:nth-of-type(#{row}) tr td:nth-of-type(#{INQUIRY_TEMPLATE_COLUMN_FORMATTING}) img").click 
			end
			# check if the formatting window is opened. If not, retry again.
			if (page.has_no_css?($inquiry_template_formatting_window_operator , :wait => DEFAULT_LESS_WAIT))
				raise "Window not opened yet, trying again..."
			end
		end	
	end 
# Number Formatting section Methods
	def InquiryTemplate.formatting_set_scaling value 
		find($inquiry_template_formatting_window_scaling).set value
		gen_tab_out $inquiry_template_formatting_window_scaling
	end

	def InquiryTemplate.formatting_set_decimal dp_value 
		find($inquiry_template_formatting_window_decimal_places).set dp_value
		gen_tab_out $inquiry_template_formatting_window_decimal_places
	end
	def InquiryTemplate.formatting_set_show_separotor show_separator 
		find($inquiry_template_formatting_window_show_separator).click
		gen_tab_out $inquiry_template_formatting_window_show_separator
	end
	
	def InquiryTemplate.column_number_formatting column, scalling , dp , show_separator 
		InquiryTemplate.open_column_formatting_window column
		if scalling != nil 
			InquiryTemplate.formatting_set_scaling scalling
		end 
		if dp != nil 
			InquiryTemplate.formatting_set_decimal dp
		end 
		if show_separator != nil 
			InquiryTemplate.formatting_set_show_separotor show_separator
		end 
		InquiryTemplate.formatting_click_button_ok
	end 

# Conditinal Formatting Section Methods 
	def InquiryTemplate.formatting_set_operator operator 
		SF.execute_script do
			find($inquiry_template_formatting_window_operator).set operator
			sleep 1
			gen_tab_out $inquiry_template_formatting_window_operator
		end
	end 

	def InquiryTemplate.formatting_set_from_value from_value 
		SF.execute_script do
			find($inquiry_template_formatting_window_from).set from_value
		end
	end 

	def InquiryTemplate.formatting_set_to_value to_value 
		find($inquiry_template_formatting_window_to).set to_value
	end 
	# click save on formatting window
	def InquiryTemplate.formatting_click_button_ok
		SF.execute_script do
			find($inquiry_template_formatting_window_ok_button).click
		end
	end 

	# pick the color from color selection 
	def InquiryTemplate.formatting_pick_color color_code
		SF.execute_script do
			within $inquiry_template_formatting_window_colors_selection do 
				find("a[class='color-#{color_code} f-color-picker-item']").click
			end 
		end
	end 
	# Set Condition true colors (Text)
	def InquiryTemplate.formatting_set_text_color_condition_true color
		SF.retry_script_block do 
			SF.execute_script do
				find($inquiry_template_formatting_window_number_text_true).click
			end
			InquiryTemplate.formatting_pick_color color
		end
	end 
	# Set Condition true colors (fill)
	def InquiryTemplate.formatting_set_fill_color_condition_true color
		SF.retry_script_block do
			SF.execute_script do
				find($inquiry_template_formatting_window_number_fill_true).click
			end
			InquiryTemplate.formatting_pick_color color
		end
	end 
	# Set Condition false colors (Text)
	def InquiryTemplate.formatting_set_text_color_condition_false color
		SF.retry_script_block do 
			SF.execute_script do
				find($inquiry_template_formatting_window_number_text_false).click
			end
			InquiryTemplate.formatting_pick_color color
		end
	end 
	# Set Condition false colors (Fill)
	def InquiryTemplate.formatting_set_fill_color_condition_false color
		SF.retry_script_block do
			SF.execute_script do
				find($inquiry_template_formatting_window_number_fill_false).click
			end
			InquiryTemplate.formatting_pick_color color
		end
	end 
	def InquiryTemplate.column_conditional_formatting field, operator, value_from , value_to , text_color_true,fill_color_true,text_color_false,fill_color_false
		InquiryTemplate.open_column_formatting_window field
		InquiryTemplate.formatting_set_operator operator
		InquiryTemplate.formatting_set_from_value value_from
		if value_to != nil 
			InquiryTemplate.formatting_set_to_value value_to
		end 
		if text_color_true != nil 
			InquiryTemplate.formatting_set_text_color_condition_true text_color_true
		end 
		if fill_color_true != nil 
			InquiryTemplate.formatting_set_fill_color_condition_true fill_color_true
		end 
		if text_color_false != nil 
			InquiryTemplate.formatting_set_text_color_condition_false text_color_false
		end 
		if fill_color_false != nil 
			InquiryTemplate.formatting_set_fill_color_condition_false fill_color_false
		end 
		InquiryTemplate.formatting_click_button_ok
	end 

# launch drill transpose window 
	def InquiryTemplate.open_drill_transpose transpose_on_field_title
			row = gen_get_row_in_grid $inquiry_template_column_grid ,transpose_on_field_title, INQUIRY_TEMPLATE_COLUMN_TITLE
			find("#{$inquiry_template_column_grid} table:nth-of-type(#{row}) tr td:nth-of-type(#{INQUIRY_TEMPLATE_COLUMN_DRILL_INQ_TEMPLATE}) img").click 
			page.has_css?($inquiry_template_transpose_drill_window)
	end
	# get the transpose window title
	def InquiryTemplate.drill_transpose_get_title
		return find($inquiry_template_transpose_drill_window_title).text
	end 
	
	# set the transpose field 
	def InquiryTemplate.transpose_set_drill_template row_number , transpose_drill_template
			find($inquiry_template_tranpose_grid + ":nth-of-type(#{row_number})"+" tr td:nth-of-type(2)").click 
			find($inquiry_template_transpose_drill_template).set transpose_drill_template
			gen_tab_out $inquiry_template_transpose_drill_template
	end 


	#  click cancel drill transpose window
	def InquiryTemplate.drill_transpose_click_button_cancel
		find($inquiry_template_transpose_drill_window_cancel_button).click
	end 
	# click clear drill transpose window
	def InquiryTemplate.drill_transpose_click_button_clear
		find($inquiry_template_transpose_drill_window_clear_button).click
	end 
	# click reset drill transpose window
	def InquiryTemplate.drill_transpose_click_button_reset
		find($inquiry_template_transpose_drill_window_reset_button).click
	end 
	# click Ok drill transpose window
	def InquiryTemplate.drill_transpose_click_button_ok
		find($inquiry_template_transpose_drill_window_ok_button).click
	end 
# --------------------------#	
# Row Selection  Tab Methods
# --------------------------# 

# Use Methods from FFA helper for formula component 

# --------------------------#	
# Reverse Sign Tab  Methods
# --------------------------# 
# Use Methods from FFA helper for formula component 
	def InquiryTemplate.tab_reverse_sign 
		FFA.click_grid_tab_by_label $inquiry_template_tab_reverse_sign
	end
	# click check box sign reversal on Reverse Sign tab 
	def InquiryTemplate.click_sign_reversal 
		find($inquiry_template_reversesign_sign_reversal).click 
	end 

# --------------------------#
# General Tab Methods 
# --------------------------#
	def InquiryTemplate.tab_general
		FFA.click_grid_tab_by_label $inquiry_template_tab_general
	end

	def InquiryTemplate.click_summarize_duplicate_rows 
		find($inquiry_template_aggregation_summarize_duplicate_rows_checkbox).click
	end 
	#Select action
	def InquiryTemplate.select_action_one_checkbox
		find($inquiry_template_action_one).click
	end
	def InquiryTemplate.select_action_two_checkbox
		find($inquiry_template_action_two).click
	end
	def InquiryTemplate.select_all_button
		find($inquiry_template_select_all_button).click
		gen_wait_less
	end
	def InquiryTemplate.deselect_all_button
		find($inquiry_template_deselect_all_button).click
		gen_wait_less
	end
# --------------------------#
# Grouping and sorting Tab Methods 
# --------------------------#
	# Sort - Add Sort
	def InquiryTemplate.sort_click_button_add_sort
		SF.execute_script do
			find($sorting_grouping_add_new_sort_button).click 
		end
		gen_wait_less
	end 
	#  Sort - Clear Sort
	def InquiryTemplate.sort_click_button_clear_sort
		find($sorting_grouping_clear_sort_button).click 
		gen_wait_less
	end 
	# Sort - remove sort 
	def InquiryTemplate.sort_remove column_no 
		sort_item = $sorting_grouping_items.sub"nnn",String(column_no)
		sort_item = sort_item + " "+$sorting_grouping_remove
		find(sort_item).click
	end 
	# Sort - Move Up
	def InquiryTemplate.sort_move_up column_no 
		sort_item = $sorting_grouping_items.sub"nnn",String(column_no)
		sort_item = sort_item + " "+$sorting_grouping_move_up
		find(sort_item).click
	end 
	# Sort Move down
	def InquiryTemplate.sort_move_down column_no 
		sort_item = $sorting_grouping_items.sub"nnn",String(column_no)
		sort_item = sort_item + " "+$sorting_grouping_move_down
		find(sort_item).click
	end 
	# Sort - Set the display field  
	def InquiryTemplate.set_sort_field column_no , sort_field
		SF.execute_script do
			sort_item = $sorting_grouping_items.sub"nnn",String(column_no)
			sort_item = sort_item + " "+$sorting_grouping_field
			find(sort_item).set sort_field
			find(sort_item).native.send_keys :down
			gen_tab_out sort_item
		end
	end 
	# Sort - Set the sort Order field 
	def InquiryTemplate.set_sort_order column_no, sort_by
		SF.execute_script do
			sort_item = $sorting_grouping_items.sub"nnn",String(column_no)
			sort_item = sort_item + " "+$sorting_grouping_order
			find(sort_item).set sort_by
			find(sort_item).native.send_keys :down
			gen_tab_out sort_item
		end
	end
	#  Sort - Check Group By
	def InquiryTemplate.click_group_by column_no
		SF.execute_script do
			sort_item = $sorting_grouping_items.sub"nnn",String(column_no)
			sort_item = sort_item + " "+$sorting_grouping_group
			find(sort_item).click
			gen_tab_out sort_item
		end
	end

	# Sort - Check hide
	def InquiryTemplate.click_hide column_no
		SF.execute_script do
			sort_item = $sorting_grouping_items.sub"nnn",String(column_no)
			sort_item = sort_item + " "+$sorting_grouping_hide
			find(sort_item).click
			gen_tab_out sort_item
		end
	end
	# drag a column in the sort area 
	def InquiryTemplate.sort_drag_column column_header
		filter_col = FFA.get_column_by_header column_header
		dropzone = find($sorting_grouping_area_drop_zone)
		gen_drag_drop filter_col, dropzone
	end

	# Add a sort field with possible values 
	def InquiryTemplate.add_sort column_no, sort_by_field , sort_order , group_by , hide_details
		if column_no != 1
			InquiryTemplate.sort_click_button_add_sort
		end 
		InquiryTemplate.set_sort_field column_no,sort_by_field
		InquiryTemplate.set_sort_order column_no,sort_order
		if group_by == true
			InquiryTemplate.click_group_by column_no
		end 
		
		if hide_details == true 
			InquiryTemplate.click_hide column_no
		end 
	end

# --------------------------#
# Common Name Override Tab Methods 
# --------------------------#

	# Add button
	def InquiryTemplate.common_name_override_add
		find($inquiry_template_common_name_override_add_button).click
	end
	# Delete button 
	def InquiryTemplate.common_name_override_delete
		find($inquiry_template_common_name_override_delete_button).click
	end
	# 
	def InquiryTemplate.select_all_common_names
		find($inquiry_template_common_name_override_select_all_rows).click 
	end 
	# set the field for common name
	def InquiryTemplate.common_name_set_field row , field 
		# check if input field is already displayed.
		input_field_available = gen_is_object_visible $inquiry_template_common_name_override_field
		# If input field is not available,click on field to make input field available.
		if(!input_field_available)
			find("#{$inquiry_template_common_name_table}:nth-of-type(#{row}) tr td:nth-of-type(2)").click 
		end
		find($inquiry_template_common_name_override_field).set field
		gen_tab_out $inquiry_template_common_name_override_field
	end
	# set the overriden common name 
	def InquiryTemplate.common_name_set_commonname row , common_name
		# check if input field is already displayed.
		input_field_available = gen_is_object_visible $inquiry_template_common_name_override_common_name
		# If input field is not available,click on field to make input field available.
		if(!input_field_available)
			find("#{$inquiry_template_common_name_table}:nth-of-type(#{row}) tr td:nth-of-type(3)").click 
		end	
		find($inquiry_template_common_name_override_common_name).set common_name
		gen_tab_out $inquiry_template_common_name_override_common_name
		FFA.click_out
	end
 	# add a overrride common name in one go
 	def InquiryTemplate.common_name_override row , field, common_name
 		InquiryTemplate.common_name_override_add
		InquiryTemplate.common_name_set_field row , field
		InquiryTemplate.common_name_set_commonname row , common_name

	end 
	# select a common name row (pass the field name )
	def InquiryTemplate.select_common_name field_name 
		row = gen_get_row_in_grid $inquiry_template_common_name_grid ,field_name, 2
		find("#{$inquiry_template_common_name_table}:nth-of-type(#{row}) tr td:nth-of-type(1)").click 
	end 
# --------------------------#
# Ledger Inquiry
# --------------------------#
	# Ledger Inquiry Tab 
	def InquiryTemplate.tab_ledger_inquiry 
		FFA.click_grid_tab_by_label $inquiry_template_tab_ledger_inquiry
	end 
	# Click on Column filter Dril 
	def InquiryTemplate.click_column_filter_drill 
		find($inquiry_template_column_filter_drill).click
	end 
	# Click on documnet count 
	def InquiryTemplate.click_document_count
		find($ledgerinquiry_show_doc_count).click
	end 
	# Select Summarization Template
	def InquiryTemplate.select_summarization_template summarization_template
		find($inquiry_template_summarization_template).set summarization_template
		gen_tab_out $inquiry_template_summarization_template
	end
# --------------------------#
# Related Content Pane 
# --------------------------#
	Capybara.add_selector(:available_by_name) do
		xpath {|rcp_name| "//span[contains(text(),'#{rcp_name} (')]"}
	end
	Capybara.add_selector(:selected_by_name) do
		xpath {|rcp_name| "//div[text()='#{rcp_name}']"}
	end

	def InquiryTemplate.tab_rcp 
		FFA.click_grid_tab_by_label $inquiry_template_tab_rcp
	end
	def InquiryTemplate.rcp_get_headers 
		return all($inquiry_template_rcp_header).collect(&:text) 
	end 
	# expand/collapse rcp tree node 	
	def InquiryTemplate.expand_collapse_rcp_tree node_name
		node_name = node_name + " ("
		tree_expand = $inquiry_template_rcp_tree_expand_pattern.sub($sf_param_substitute , node_name)
		find(:xpath ,tree_expand).click
		sleep 0.5
	end 
	# select rcp from the selected list
	def InquiryTemplate.rcp_select_selected_pane rcp_name 
		within($inquiry_template_rcp_selected) do 
			find(:selected_by_name,rcp_name).click 
		end 
	end 
	# add rcp by double clicking on it 
	def InquiryTemplate.add_rcp_by_double_click rcp_name
		InquiryTemplate.add_remove_rcp_by_double_click rcp_name , InquiryTemplate::Add
	end
	# remove rcp by double clicking on it
	def InquiryTemplate.remove_rcp_by_double_click rcp_name
		InquiryTemplate.add_remove_rcp_by_double_click rcp_name , InquiryTemplate::Remove
	end
	# add / remove rcp by double clicking on them in the available / selected lists
	def InquiryTemplate.add_remove_rcp_by_double_click rcp_name , add_remove 
		if add_remove == InquiryTemplate::Add
			rcp_ele = "//span[text()='#{rcp_name}']"
		elsif add_remove == InquiryTemplate::Remove
			rcp_ele = "//div[text()='#{rcp_name}']"
		end 
		ele = page.driver.browser.find_element(:xpath , rcp_ele)
		page.driver.browser.action.double_click(ele).perform
	end
	# Click button add
	def InquiryTemplate.rcp_add
		find($inquiry_template_rcp_add).click 
	end 
	# Click Button remove 
	def InquiryTemplate.rcp_remove
		find($inquiry_template_rcp_remove).click 
	end 
	# Click Button Add All
	def InquiryTemplate.rcp_add_all
		find($inquiry_template_rcp_add_all).click 
	end 
	# Click Button Remove all 
	def InquiryTemplate.rcp_remove_all 
		find($inquiry_template_rcp_remove_all).click 
	end
	# Add rcp pane folder to selected  
	# pane_node_name Specify the name of node you wanted to add , expand ignore (1 Avaliable)
	# use this method when you want to add the whole folder or there is only one filed to add 
	#InquiryTemplate.rcp_add_pane 'RCP_Account_TID014453' (This will add the whole rcp folder node)
	def InquiryTemplate.rcp_add_pane_folder  rcp_node_name 
		within($inquiry_template_rcp_available) do 
			find(:available_by_name,rcp_node_name).click 
		end 
		InquiryTemplate.rcp_add
	end 
	# Select rcp from the available list
	# rcp_node_name rcp node name to expand 
	# field_name select the file under that node 
	# collapse_flag set to true by default will collapse the tree after adding it to selected pane pass false if you do not want to collapse or there is only one field under the node 
	# Example 
	#InquiryTemplate.rcp_add_pane 'RCP_Account_TID014453' , "Account ID" (add the Account ID field and collapse the tree)
	#InquiryTemplate.rcp_add_pane 'RCP_Account_TID014453' , "Account ID" , false (add the Account ID field and do not collapse the tree)
	def InquiryTemplate.rcp_add_pane_field rcp_node_name , field_name ,collapse_tree = true 
		InquiryTemplate.expand_collapse_rcp_tree rcp_node_name
		node_name = rcp_node_name + " ("
		find(:xpath ,"//span[contains(text(),'#{node_name}')]//ancestor::table/following-sibling::table//span[text()='#{field_name}']").click 
		InquiryTemplate.rcp_add
		# By default collapse the tree after adding the filed to selected 
		if collapse_tree == true 
			InquiryTemplate.expand_collapse_rcp_tree rcp_node_name
		end 
	end 
	#  remove pane form the selected list
	def InquiryTemplate.rcp_remove_pane  pane_name 
		InquiryTemplate.rcp_select_selected_pane pane_name
		InquiryTemplate.rcp_remove
	end 
end 
