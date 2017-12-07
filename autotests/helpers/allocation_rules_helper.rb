#FinancialForce.com, inc. claims copyright in this software, its screen display designs and
#supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
#Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
#result in criminal or other legal proceedings.
#Copyright FinancialForce.com, inc. All rights reserved.

ALLOCATION_FIXED_RULE_GRID_GLA_COLUMN = 1
ALLOCATION_FIXED_RULE_GRID_DIMENSION1_COLUMN = 2
ALLOCATION_FIXED_RULE_GRID_DIMENSION2_COLUMN = 3
ALLOCATION_FIXED_RULE_GRID_DIMENSION3_COLUMN = 4
ALLOCATION_FIXED_RULE_GRID_DIMENSION4_COLUMN = 5
ALLOCATION_FIXED_RULE_GRID_PERCENTAGE_COLUMN = 6
module AllocationRules
	extend Capybara::DSL
#######################
#Selectors Section
#######################
####### List View ########
$allocationrules_link_pattern = "//div[contains(@class,'listBody')]//span[contains(text(),'"+$sf_param_substitute+"')]/ancestor::a[1] | //a[contains(text(), '"+$sf_param_substitute+"')]"

####### Labels ###########
$allocationrules_type_fixed_label = "Fixed"
$allocationrules_type_variable_label = "Variable"
$allocationrules_type_spread_evenly_label = "Spread Evenly"
$allocationrules_type_populate_all_label = "Populate All"
$allocationrules_gla_label = "General Ledger Account"
$allocationrules_local_gla_label = "LOCAL GLA"
$allocationrules_dim1_label = "Dimension 1"
$allocationrules_dim2_label = "Dimension 2"
$allocationrules_dim3_label = "Dimension 3"
$allocationrules_dim4_label = "Dimension 4"
$allocationrules_percentage_label = "Percentage (%)"
$allocationrules_value_label = "Value"
$allocationrules_filter_operator_contains_label = "Contains"
$allocationrules_filter_operator_equals_label = "Equals"
$allocationrules_filter_operator_not_equals_label = "Not Equals"

####### Header ###########
$allocationrules_name_textbox = "div[data-ffid='RuleName'] input"
$allocationrules_description_textbox = "div[data-ffid='RuleDescription'] input"
$allocationrules_alloc_type = "div[data-ffid='AllocationType']"
$allocationrules_alloc_type_picklist = "//div[@data-ffid='AllocationType']//input/../following-sibling::div"
$allocationrules_is_active_checkbox = "div[data-ffid='active']"
$allocationrules_is_active_checkbox_input = "div[data-ffid='active'] input"
$allocationrules_is_active_checkbox_span = "div[data-ffid='active'] span[class*='f-form-checkbox']"
$allocationrules_type_list = "div[data-ffxtype='boundlist']"
$allocationrules_loading_mask = "div[data-ffxtype=loadmask]"
$allocationrules_statistical_bases_input = "div[data-ffid='StatisticalValues'] input"
$allocationrules_distribution_field_input = "div[data-ffid='DistributionFields'] input"
$allocationrules_distribution_field_selected = "//div[@data-ffid='DistributionFields']//div[contains(text(),'"+$sf_param_substitute+"')]"
$allocationrules_company_field = "div[data-ffid='CompanyField'] input"

####### Buttons ###########
$allocationrules_save_button = "a[data-ffid='saveButton']"
$allocationrules_edit_button = "a[data-ffid='editButton']"
$allocationrules_back_to_list_button = "a[data-ffid='backButton']"
$allocationrules_delete_button = "a[data-ffid='deleteButton']"
$allocationrules_clear_all_button = "a[data-ffid='cleraAllBtn']"
$allocationrules_toggle_button = "a[data-ffxtype='fillbutton']"
$allocationrules_back_popup_yes_button = "a[data-ffid='ok']"
$allocationrules_back_popup_no_button = "a[data-ffid='cancel']"
$allocationrules_add_statistical_bases_button = "a[data-ffid='CreateStatisticalValues']"
$allocationrules_edit_statistical_bases_button = "a[data-ffid='EditStatisticalValues']"
$allocationrules_save_and_select_basis_button = "a[data-ffid='continueButton']"

########### Filter Section fields ################
$allocationrules_filter_selected_count = "div[data-ffid='FilterCount'] span[class*='filters-selected']"
$allocationrules_filter_clear_all_button = "a[data-ffid='clearFilterButton']"
$allocationrules_filter_preview_button = "a[data-ffid='PreviewButton']"
$allocationrules_filter_show_filter_button = "//span[contains(text(),'Show Filter')]/ancestor::a"
$allocationrules_filter_hide_filter_button = "//span[contains(text(),'Hide Filter')]/ancestor::a"
$allocationrules_filter_add_filter_button = "a[data-ffid='addFilterButton']"
$allocationrules_filter_close_button = "div[data-ffxtype='allocrule-filter-box']:nth-of-type("+$sf_param_substitute+") a[data-ffid='closeButton']"
$allocationrules_filter_field_input = "div[data-ffxtype='allocrule-filter-box']:nth-of-type("+$sf_param_substitute+") div[data-ffid='FilterField'] input"
$allocationrules_filter_operator_input = "div[data-ffxtype='allocrule-filter-box']:nth-of-type("+$sf_param_substitute+") div[data-ffid='Operator'] input"
$allocationrules_filter_value_input = "div[data-ffxtype='allocrule-filter-box']:nth-of-type("+$sf_param_substitute+") div[data-ffid='Value'] input"
$allocationrules_filter_row = "div[data-ffxtype='allocrule-filter-box']:nth-of-type("+$sf_param_substitute+")"
$allocationrules_filter_rows = "div[data-ffxtype='allocrule-filter-box']"
$allocationrules_filter_search_input = "div[data-ffid='searchField'] input"
$allocationrules_filter_search_icon = "//div[@data-ffid='searchField']//input/parent::div/following-sibling::div"

########### Fixed Rule Grid fields ################
$allocationrules_grid_rows = "div[data-ffxtype='tableview'] table"
$allocationrules_grid_row = "div[data-ffxtype='tableview'] table:nth-of-type("+$sf_param_substitute+") tbody tr"
$allocationrules_fixed_grid_delete_row = "//div[@data-ffxtype='tableview']//table["+$sf_param_substitute+"]/tbody/tr/td[contains(@data-columnid,'ColumnDEL')]/div/div"
$allocationrules_fixed_grid_gla_column_edit = "//div[@data-ffxtype='tableview']//table["+$sf_param_substitute+"]/tbody/tr/td[contains(@data-columnid,'GLA')]/div"
$allocationrules_fixed_grid_gla_column_input = "input[name='GeneralLedgerAccountId']"
$allocationrules_fixed_grid_dimension1_column_edit = "//div[@data-ffxtype='tableview']//table["+$sf_param_substitute+"]/tbody/tr/td[contains(@data-columnid,'DIM1')]/div"
$allocationrules_fixed_grid_dimension1_column_input = "input[name='Dimension1Id']"
$allocationrules_fixed_grid_dimension2_column_edit = "//div[@data-ffxtype='tableview']//table["+$sf_param_substitute+"]/tbody/tr/td[contains(@data-columnid,'DIM2')]/div"
$allocationrules_fixed_grid_dimension2_column_input = "input[name='Dimension2Id']"
$allocationrules_fixed_grid_dimension3_column_edit = "//div[@data-ffxtype='tableview']//table["+$sf_param_substitute+"]/tbody/tr/td[contains(@data-columnid,'DIM3')]/div"
$allocationrules_fixed_grid_dimension3_column_input = "input[name='Dimension3Id']"
$allocationrules_fixed_grid_dimension4_column_edit = "//div[@data-ffxtype='tableview']//table["+$sf_param_substitute+"]/tbody/tr/td[contains(@data-columnid,'DIM4')]/div"
$allocationrules_fixed_grid_dimension4_column_input = "input[name='Dimension4Id']"
$allocationrules_fixed_grid_percentage_column_edit = "//div[@data-ffxtype='tableview']//table["+$sf_param_substitute+"]/tbody/tr/td[contains(@data-columnid,'Percent')]/div"
$allocationrules_fixed_grid_percentage_column_input = "input[name='Percentage']"
$allocationrules_fixed_menu_pattern = "//span[text()='"+$sf_param_substitute+"']"
$allocationrules_fixed_menu_div = $allocationrules_fixed_menu_pattern +"/ancestor::div[1]/following::div[1]"
$allocationrules_fixed_column_menu_drop_down = ".f-column-header-trigger"
$allocationrules_fixed_menu = "//span[text()='"+$sf_param_substitute+"']/ancestor::div[contains(@data-ffid,'allocationRuleTable')]"
$allocationrules_fixed_rowcolumn_pattern = "//div[@data-ffxtype='tableview']//table["+$sf_param_substitute+"]/tbody/tr/td["+$sf_param_substitute+"]/div"
$allocationrules_fixed_rowcolumn_pattern_view_page = "div[data-ffid='fixedallocationgrid'] div[data-ffxtype='tableview'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type("+$sf_param_substitute+") div"
$allocationrules_picklist_value_pattern = "//ul[@class='f-list-plain']//li[contains(text(), '#{$sf_param_substitute}')]"
$allocationrules_grid_total_percentage = "div[data-ffid='summaryBar'] td[data-columnid='allocationRuleTableColumnPercent'] span[class*='summary-value']"
$allocationrules_grid_total_value = "div[data-ffid='summaryBar'] td[data-columnid='splitTableColumnValue'] span:nth-of-type(2)"

########## Popup #########################
$allocationrules_message_box = "div[data-ffxtype='messagebox']"
$allocationrules_message_text = ".f-window-text"

########## Toast #########################
$allocationrules_toast_message_box = "div[class*='f-window f-toast']"
$allocationrules_toast_message = ".f-window-body"
$allocationrules_toast_message_undo_button = "div[class*='f-window f-toast'] div[data-ffxtype='toolbar'] a[data-ffxtype='button']"
$allocationrules_toast_message_close_button = "div[class*='f-window f-toast'] div[data-ffxtype='tool'] img"

########## Messages ########################
$allocationrules_message_name_required = FFA.fetch_label 'AllocationRuleNameRequired'
$allocationrules_message_type_required = FFA.fetch_label 'AllocationRuleTypeRequired'
$allocationrules_message_percentage_limit = FFA.fetch_label 'AllocationRulePercentageLimit'
$allocationrules_message_name_already_exist = FFA.fetch_label 'AllocationRuleNameAlreadyExist'
$allocationrules_message_gla_manadatory = "You must enter a General Ledger Account on allocation rule lines."
$allocationrules_message_activation_failed = FFA.fetch_label 'AllocationRuleActivationFailed'
$allocationrules_message_percentage_limit = FFA.fetch_label 'AllocationRulePercentageLimit'
$allocationrules_message_basis_distribution_field_mandatory = FFA.fetch_label 'StatisticalValuesAndDistributionFieldsMandatory'
$allocationrules_message_distribution_field_mandatory = FFA.fetch_label 'AllocationDistributionFieldMustContainDimensionOrGla'
$allocationrules_message_no_basis = FFA.fetch_label 'AllocationRuleSaveFailedNoBasis'
$allocationrules_message_no_distribution_field = FFA.fetch_label 'AllocationRuleSaveFailedNoDistributionField'
$allocationrules_message_required_filter_field = FFA.fetch_label 'RequiredFilterFieldMessage'
$allocationrules_message_filter_undo_confirmation = FFA.fetch_label 'FiltersUndoConfirmationMessage'
$allocationrules_message_statistical_value_unselected = FFA.fetch_label 'StatisticalValueNotSelected'

#### Allocation rule list view fields #####
$allocationrules_is_local_checked = "//span[text()='Local fixed AR_1']/ancestor::tr[1]//td[10]/div/img[@title='Checked']"
$allocationrules_is_local_not_checked = "//span[text()='Local fixed AR_1']/ancestor::tr[1]//td[10]/div/img[@title='Not Checked']"

#######################
#Method Section
#######################

#######################
######Header###########
#######################

	###
	# Method Summary: Set Allocation Rule Name
	#
	# @param [String] rule_name     Value to fill in to the input field.
	#
	def AllocationRules.set_rule_name rule_name
		find($allocationrules_name_textbox).set rule_name
	end
	
	###
	# Method Summary: Get Allocation Rule Name
	#
	def AllocationRules.get_rule_name
		return find($allocationrules_name_textbox).value
	end

	###
	# Method Summary: Set Allocation Rule Description
	#
	# @param [String] description     Value to fill in to the input field.
	#
	def AllocationRules.set_rule_description description
		find($allocationrules_description_textbox).set description
	end
	
	###
	# Method Summary: Get Allocation Rule Description
	#
	def AllocationRules.get_rule_description
		return find($allocationrules_description_textbox).text
	end

	###
	# Method Summary: Set is active checkbox on the header of Allocation Rule page.It will not do anything if already selected
	#
	def AllocationRules.set_is_active_checkbox
		element = find($allocationrules_is_active_checkbox)
		is_checked = element[:class].include?("f-form-cb-checked")
		if(!is_checked)
			# It sometime treat the form type radio button as Input or Span,
			# Handling both scenarios using Begin-resuce block.
			begin
				find($allocationrules_is_active_checkbox_input).click
			rescue
				find($allocationrules_is_active_checkbox_span).click
			end
		end
	end

	###
	# Method Summary: Unset is active checkbox on the header of Allocation Rule page.It will not do anything if already not selected
	#
	def AllocationRules.unset_is_active_checkbox
		element = find($allocationrules_is_active_checkbox)
		is_checked = element[:class].include?("f-form-cb-checked")
		if(is_checked)
			# It sometime treat the form type radio button as Input or Span,
			# Handling both scenarios using Begin-resuce block.
			begin
				find($allocationrules_is_active_checkbox_input).click
			rescue
				find($allocationrules_is_active_checkbox_span).click
			end
		end
	end
	
	###
	# Method Summary: Select the rule type from the list.
	#
	# @param [String] rule_type          Name of the Rule to select.
	#
	def AllocationRules.select_rule_type rule_type
		find(:xpath, $allocationrules_alloc_type_picklist).click
		find($allocationrules_type_list).find("li",:text => rule_type).click
	end
	
	###
	# Method Summary: Select the company value from picklist
	#
	# @param [String] company_name Name of the Company to select.
	# Company field will be displayed on allocation rule header only when Alternate account feature is turned ON
	#
	def AllocationRules.set_company_name company_name
		SF.execute_script do
			find($allocationrules_company_field).click
			find($allocationrules_company_field).set company_name
			gen_wait_less
			gen_tab_out $allocationrules_company_field
		end
	end
	
	###
	# Method Summary: Method to assert company value on allocation rules header
	#
	# @param [String] value Company field value
	# Company field will be displayed on allocation rule header only when Alternate account feature is turned ON
	#
	def AllocationRules.assert_company_field_value value
		company_field = find($allocationrules_company_field)
		return company_field['value'] == value
	end
	
	###
    # Method Summary: Select the Statistical Bases from the list.
    #
    # @param [String] bases_name          Name of the Statistical Bases to select.
    #
    def AllocationRules.select_statistical_bases bases_name
        AllocationRules.set_value_tab_out $allocationrules_statistical_bases_input, bases_name
    end

    ###
    # Method Summary: Select the Distribution Field from the list.
    #
    # @param [List<String>] field_names          List of the Distribution Field to select.
    #
    def AllocationRules.select_distribution_fields field_names
		field_names.each do |field_name|
			AllocationRules.set_value_tab_out $allocationrules_distribution_field_input, field_name
		end
    end
	
	###
    # Method Summary: Remove the Field from the distibution list.
    #
    # @param [String] field_name          Name of the Distribution Field to remove.
    #
    def AllocationRules.remove_distribution_field field_name
		distribution_field_selected = $allocationrules_distribution_field_selected.sub($sf_param_substitute, field_name)
		object_visible = gen_is_object_visible distribution_field_selected
		if (object_visible)
			close_distribution_field_icon = distribution_field_selected + '/following-sibling::div'
			find(:xpath,close_distribution_field_icon).click
		end
    end
	
	###
    # Method Summary: Assert the Field in the distibution field list.
    #
    # @param [String] field_name          Field Name to be asserted in Distribution Field
    #
    def AllocationRules.is_distribution_field_selected? field_name
        distribution_field_selected = $allocationrules_distribution_field_selected.sub($sf_param_substitute, field_name)
        object_visible = gen_is_object_visible distribution_field_selected
        return object_visible
    end

    ###
    # Method Summary: Click the Add Statistical Bases button
    #
    def AllocationRules.click_add_statistical_bases_button
        find($allocationrules_add_statistical_bases_button).click
    end
    
    ###
    # Method Summary: Click the Edit Statistical Bases button
    #
    def AllocationRules.click_edit_statistical_bases_button
        find($allocationrules_edit_statistical_bases_button).click
    end

########################################
######Filter Section###########
########################################
    ###
    # Method Summary: Click Clear All Filter button
    #
    def AllocationRules.click_clear_all_filter_button
        find($allocationrules_filter_clear_all_button).click
    end

    ###
    # Method Summary: Click Preview button to apply filter and statistical basis
    #
    def AllocationRules.click_preview_button
        find($allocationrules_filter_preview_button).click
    end

    ###
    # Method Summary: Click Show filter button on Filter Section of Variable Allocation Rule Page
    #
    def AllocationRules.click_show_filter_button
		find(:xpath,$allocationrules_filter_show_filter_button).click
    end

	###
    # Method Summary: Click Hide filter button on Filter Section of Variable Allocation Rule Page
	#
    def AllocationRules.click_hide_filter_button
        find(:xpath,$allocationrules_filter_hide_filter_button).click
    end

	###
    # Method Summary: Click Add Filter button to add a new filter
    #
    def AllocationRules.click_add_filter_button
        find($allocationrules_filter_add_filter_button).click
    end

	###
    # Method Summary: Click delete filter button next to the filter selected
    # @param [Integer] row_num                Row Number of the filter to delete
    #
    def AllocationRules.click_delete_filter_icon row_num
        element_to_click = $allocationrules_filter_close_button.sub($sf_param_substitute,row_num.to_s)
        find(element_to_click).click
    end
	
    ###
    # Method Summary: Set the filter field for the particular row
    # @param [String]  field                  Field for which filter needs to be applied
    # @param [Integer] row_num                Filter row number where field needs to be set
    #
    def AllocationRules.set_filter_field field,row_num
        element_to_click = $allocationrules_filter_field_input.sub($sf_param_substitute,row_num.to_s)
        AllocationRules.set_value_tab_out element_to_click,field
    end

	###
    # Method Summary: Set the filter operator for the particular row
    # @param [String]  operator               Operator to be applied on filter
    # @param [Integer] row_num                Filter row number where operator needs to be set
    #
    def AllocationRules.set_filter_operator operator,row_num
        element_to_click = $allocationrules_filter_operator_input.sub($sf_param_substitute,row_num.to_s)
        AllocationRules.set_value_tab_out element_to_click,operator
    end
	
	###
    # Method Summary: Set the filter value for the particular row
    # @param [String]  value                  Operator to be set on filter
    # @param [Integer] row_num                Filter row number where field needs to be set
    #
    def AllocationRules.set_filter_value value,row_num
        element_to_click = $allocationrules_filter_value_input.sub($sf_param_substitute,row_num.to_s)
        AllocationRules.set_value element_to_click,value
    end

    ###
    # Method Summary: Get the filter count displayed in Filter Selected box
    #
    def AllocationRules.get_displayed_filter_count
        return find($allocationrules_filter_selected_count).text
    end

    ###
    # Method Summary: Get the filter count
    #
    def AllocationRules.get_filter_count
        row_size = page.all($allocationrules_filter_rows)
        return row_size.count
    end
	
	###
    # Method Summary: Set the filter field, operator and value for the particular row
    # @param [String]  field                   Field for which filter needs to be applied
    # @param [String]  operator                Operator to be applied on filter
    # @param [String]  value                   Value to be filtered
    # @param [Integer] row_num                 Filter row number to be provided[DEFAULT = 1]
    #
    def AllocationRules.set_filter_values field,operator,value,row_num=1
        if(field != nil)
			AllocationRules.set_filter_field field,row_num
        end
        if(operator != nil)
			AllocationRules.set_filter_operator operator,row_num
        end
        if(value != nil)
			AllocationRules.set_filter_value value,row_num
        end
    end

########################################
######Fixed Rule Grid Section###########
########################################

	###
	# Method Summary: Delete the row of the grid
	#
	# @param [Integer] row_number           Row Number where gla needs to be set [DEFAULT = 1]
	#
	def AllocationRules.delete_fixed_rule_line row_number=1
		row_selector = $allocationrules_fixed_grid_delete_row.sub($sf_param_substitute,row_number.to_s)
		find(:xpath, row_selector).click
	end
	
	###
	# Method Summary: Set the GLA on Grid Line of Fixed Allocation Rule
	#
	# @param [String] gla          			GLA Value to be set on line
	# @param [Integer] row_number           Row Number where gla needs to be set [DEFAULT = 1]
	#
	def AllocationRules.set_fixed_rule_line_gla gla, row_number=1
		object_visible = gen_is_object_visible $allocationrules_fixed_grid_gla_column_input
		if(!object_visible)
			gla_row_selector = $allocationrules_fixed_grid_gla_column_edit.sub($sf_param_substitute,row_number.to_s)
			find(:xpath, gla_row_selector).click
		end
		AllocationRules.set_value_tab_out($allocationrules_fixed_grid_gla_column_input , gla)
	end

	###
	# Method Summary: Set the Dimension 1 on Grid Line of Fixed Allocation Rule
	#
	# @param [String]  dim1          		Dimension 1 Value to be set on line
	# @param [Integer] row_number           Row Number where dimension 1 needs to be set [DEFAULT = 1]
	#
	def AllocationRules.set_fixed_rule_line_dim1 dim1, row_number=1
		object_visible = gen_is_object_visible $allocationrules_fixed_grid_dimension1_column_input
		if(!object_visible)
			dim1_row_selector = $allocationrules_fixed_grid_dimension1_column_edit.sub($sf_param_substitute,row_number.to_s)
			find(:xpath, dim1_row_selector).click
		end
		AllocationRules.set_value_tab_out($allocationrules_fixed_grid_dimension1_column_input, dim1)
	end
	
	###
	# Method Summary: Set the Dimension 2 on Grid Line of Fixed Allocation Rule
	#
	# @param [String]  dim2          		Dimension 2 Value to be set on line
	# @param [Integer] row_number           Row Number where dimension 2 needs to be set [DEFAULT = 1]
	#
	def AllocationRules.set_fixed_rule_line_dim2 dim2, row_number=1
		object_visible = gen_is_object_visible $allocationrules_fixed_grid_dimension2_column_input
		if(!object_visible)
			dim2_row_selector = $allocationrules_fixed_grid_dimension2_column_edit.sub($sf_param_substitute,row_number.to_s)
			find(:xpath, dim2_row_selector).click
		end
		AllocationRules.set_value_tab_out($allocationrules_fixed_grid_dimension2_column_input, dim2)
	end
	
	###
	# Method Summary: Set the Dimension 3 on Grid Line of Fixed Allocation Rule
	#
	# @param [String]  dim3          		Dimension 3 Value to be set on line
	# @param [Integer] row_number           Row Number where dimension 3 needs to be set [DEFAULT = 1]
	#
	def AllocationRules.set_fixed_rule_line_dim3 dim3, row_number=1
		object_visible = gen_is_object_visible $allocationrules_fixed_grid_dimension3_column_input
		if(!object_visible)
			dim3_row_selector = $allocationrules_fixed_grid_dimension3_column_edit.sub($sf_param_substitute,row_number.to_s)
			find(:xpath, dim3_row_selector).click
		end
		AllocationRules.set_value_tab_out($allocationrules_fixed_grid_dimension3_column_input, dim3)
	end
	
	###
	# Method Summary: Set the Dimension 4 on Grid Line of Fixed Allocation Rule
	#
	# @param [String]  dim4          		Dimension 4 Value to be set on line
	# @param [Integer] row_number           Row Number where dimension 4 needs to be set [DEFAULT = 1]
	#
	def AllocationRules.set_fixed_rule_line_dim4 dim4, row_number=1
		object_visible = gen_is_object_visible $allocationrules_fixed_grid_dimension4_column_input
		if(!object_visible)
			dim4_row_selector = $allocationrules_fixed_grid_dimension4_column_edit.sub($sf_param_substitute,row_number.to_s)
			find(:xpath, dim4_row_selector).click
		end
		AllocationRules.set_value_tab_out($allocationrules_fixed_grid_dimension4_column_input, dim4)
	end

	###
	# Method Summary: Set the percentage on Grid Line of Fixed Allocation Rule
	#
	# @param [Integer] percentage          	Percentage Value to be set on line
	# @param [Integer] row_number           Row Number where percentage needs to be set [DEFAULT = 1]
	#
	def AllocationRules.set_fixed_rule_line_percentage percentage, row_number=1
		object_visible = gen_is_object_visible $allocationrules_fixed_grid_percentage_column_input
		if(!object_visible)
			percentage_row_selector = $allocationrules_fixed_grid_percentage_column_edit.sub($sf_param_substitute,row_number.to_s)
			find(:xpath, percentage_row_selector).click
		end
		AllocationRules.set_value($allocationrules_fixed_grid_percentage_column_input, percentage)
	end

	###
	# Method Summary: Get the total percentage on the grid toolbar of Allocation Rule Page
	#
	def AllocationRules.get_total_percentage
		total_string = find($allocationrules_grid_total_percentage).text
		percentage_value = total_string.split("%")[0]
		return percentage_value
	end
	
	###
	# Method Summary: Get the total value on the grid toolbar of Allocation Rule Page
	#
	def AllocationRules.get_total_value
		return find($allocationrules_grid_total_value).text
	end
	
	###
	# Method Summary: Get the grid row value for the particular column for fixed type in the Allocation Rule View Page
	#
	# @param [Integer] row_number          	Row Number of the grid[DEFAULT = 1]
	# @param [Integer] column_number        Column Number of the grid. Use Constants like ALLOCATION_FIXED_RULE_GRID_GLA_COLUMN[DEFAULT = 1]
	#
	def AllocationRules.get_grid_row_value_by_column_view_page row_number=1,column_number=1 
		row_selector = $allocationrules_fixed_rowcolumn_pattern_view_page.sub($sf_param_substitute,row_number.to_s)
		column_selector = row_selector.sub($sf_param_substitute,column_number.to_s)
		return find(column_selector).text
	end

	###
	# Method Summary: Get the grid row value for the particular column for fixed type in the Allocation Rule Edit Page
	#
	# @param [Integer] row_number          	Row Number of the grid[DEFAULT = 1]
	# @param [Integer] column_number        Column Number of the grid. Use Constants like ALLOCATION_FIXED_RULE_GRID_GLA_COLUMN[DEFAULT = 1]
	#
	def AllocationRules.get_grid_row_value_by_column row_number=1, column_number=1
		row_selector =  $allocationrules_fixed_rowcolumn_pattern.sub($sf_param_substitute,row_number.to_s)
		column_selector =  row_selector.sub($sf_param_substitute,(column_number+1).to_s)
		return find(:xpath, column_selector).text
	end
	
	###
	# Method Summary: Click the menu option on column on Fixed Allocation Rule page
	#
	# @param [String] column_name          	Column Name of the grid like $allocationrules_percentage_label 
	# @param [String] menu_option_name      Menu option in the column to click like $allocationrules_type_spread_even_label
	#
	def AllocationRules.click_fixed_rule_menu_option column_name, menu_option_name
		SF.retry_script_block do 
			column_to_click = $allocationrules_fixed_menu.sub($sf_param_substitute,column_name)
			find(:xpath, column_to_click).hover
									
			find(:xpath, $allocationrules_fixed_menu_div.sub($sf_param_substitute,column_name)).click
			menu_option = $allocationrules_fixed_menu_pattern.sub($sf_param_substitute,menu_option_name)
			page.has_xpath?(menu_option)
			find(:xpath, menu_option).hover
			find(:xpath, menu_option).click
		end
	end
	
	
	###
	# Method Summary: Set the column grid values by line number for all columns
	#
	# @param [String] gla          	GLA value to be set on the line
	# @param [String] dim1          Dimnsion 1 value to be set on the line
	# @param [String] dim2          Dimnsion 2 value to be set on the line
	# @param [String] dim3          Dimnsion 3 value to be set on the line
	# @param [String] dim4          Dimnsion 4 value to be set on the line
	# @param [Decimal] percentage   Percentage value to be set on the line
	# @param [Integer] row_number   Row Number where column values needs to be set [DEFAULT = 1]
	#
	def AllocationRules.set_fixed_rule_grid_row gla, dim1, dim2, dim3, dim4, percentage, row_number=1
		if (gla != nil)
			AllocationRules.set_fixed_rule_line_gla gla, row_number
		end
		if (dim1 != nil)
			AllocationRules.set_fixed_rule_line_dim1 dim1, row_number
		end
		if (dim2 != nil)
			AllocationRules.set_fixed_rule_line_dim2 dim2, row_number
		end
		if (dim3 != nil)
			AllocationRules.set_fixed_rule_line_dim3 dim3, row_number
		end
		if (dim4 != nil)
			AllocationRules.set_fixed_rule_line_dim4 dim4, row_number
		end
		if (percentage != nil)
			AllocationRules.set_fixed_rule_line_percentage percentage, row_number
		end
	end

	###
	# Method Summary: Get complete grid row by row number for Allocation Rule Table
	#
	# @param [Integer] row_number          	Row Number of the grid[DEFAULT = 1]
	#
	def AllocationRules.get_allocation_rule_grid_row row_number=1
		row_to_fetch = $allocationrules_grid_row.sub($sf_param_substitute,row_number.to_s)
		return find(row_to_fetch).text
	end
	
	###
	# Method Summary: Get Number of grid rows
	#
	# @param [Integer] row_number          	Row Number of the grid[DEFAULT = 1]
	#
	def AllocationRules.get_count_of_grid_rows
		gen_wait_until_object $allocationrules_grid_rows
		row_size = page.all($allocationrules_grid_rows)
        return row_size.count
	end

	###
	# Method Summary: Search the Grid of the Allocation Rule by entering the input and clicking search icon
	#
	# @param [Integer] input_value          	Input to search in the grid
	#
	def AllocationRules.search_grid input_value
		find($allocationrules_filter_search_input).set input_value
		find(:xpath,$allocationrules_filter_search_icon).click
	end
########################
######Buttons###########
########################

	###
	# Method Summary: Click the save button on Allocation Rule page
	#
	def AllocationRules.click_save_button
		find($allocationrules_save_button).click
		gen_wait_until_object_disappear $allocationrules_loading_mask
		gen_wait_less
	end
	
	###
	# Method Summary: Click the edit button on Allocation Rule page
	#
	def AllocationRules.click_edit_button
		find($allocationrules_edit_button).click
		gen_wait_until_object_disappear $allocationrules_loading_mask
		gen_wait_less
	end
	
	###
	# Method Summary: Click the back to list button on Allocation Rule page
	#
	def AllocationRules.click_back_to_list_button
		find($allocationrules_back_to_list_button).click
		object_visible = gen_is_object_visible $allocationrules_message_box
		if(object_visible)
		 	AllocationRules.click_continue_button_on_popup
		end
	end
	
	###
	# Method Summary: Click the toggle expand/collapse button on Allocation Rule page
	#
	def AllocationRules.click_toggle_button
		find($allocationrules_toggle_button).click
	end
	
	###
	# Method Summary: Click the delete button on Allocation Rule page
	#
	def AllocationRules.click_delete_button
		find($allocationrules_delete_button).click
	end
	
	###
	# Method Summary: Click the clear all button on Allocation Rule page
	#
	def AllocationRules.click_clear_all_button
		find($allocationrules_clear_all_button).click
	end
	
	###
	# Method Summary: Click the Save and Select button on Statistical Basis Popup
	#
	def AllocationRules.click_save_and_select_on_basis_popup
		find($allocationrules_save_and_select_basis_button).click
		gen_wait_until_object_disappear $allocationrules_loading_mask
	end

##################
########Popup#####
##################

	###
	# Method Summary: Get error mesaage on popup
	#
	def AllocationRules.get_error_message
		within($allocationrules_message_box) do
			return find($allocationrules_message_text).text
		end
	end
	
	###
	# Method Summary: Click the Continue Button on the error message popup
	#
	def AllocationRules.click_continue_button_on_popup
		within($allocationrules_message_box) do
			find($allocationrules_back_popup_yes_button).click
		end
	end
	
###############################
########Toast Message Box#####
###############################

	###
	# Method Summary: Get toast message
	#
	def AllocationRules.get_toast_message
		SF.retry_script_block do
			within($allocationrules_toast_message_box) do
				return find($allocationrules_toast_message).text
			end
		end
	end
	
	###
	# Method Summary: Click the Undo Button on the toast message box
	#
	def AllocationRules.click_undo_button_on_toast_message_box
		SF.retry_script_block do
			within($allocationrules_toast_message_box) do
				find($allocationrules_toast_message_undo_button).click
			end
		end
	end
	
	###
	# Method Summary: Click the Close Button on the toast message box
	#
	def AllocationRules.click_close_button_on_toast_message_box
		SF.retry_script_block do
			within($allocationrules_toast_message_box) do
				find($allocationrules_toast_message_close_button).click
				gen_wait_until_object_disappear $allocationrules_toast_message_box
			end
		end
	end
###########################
########Helper Methods#####
###########################

	##
	# Method Summary: Find the element and enter the value in to the field.
	#
	# @param [String] element_locator     ID, Name, Label, CSS or Xpath of a picklist field to find.
	# @param [String] value               Value to fill in to the input field.
	#
	def AllocationRules.set_value element_locator, value
		page.has_css?(element_locator)
		find(element_locator).set('')
		find(element_locator).set(value)
	end
	
	##
	# Method Summary: Find the element, set the value and tab out from the input field.
	#
	# @param [String] element_locator     ID, Name, Label, CSS or Xpath of a picklist field to find.
	# @param [String] value               The required value to fill in.
	#
	def AllocationRules.set_value_tab_out element_locator, value
		AllocationRules.set_value element_locator, value
		picklist_filtered_value = $allocationrules_picklist_value_pattern.sub($sf_param_substitute,value.to_s)
		if page.has_xpath?(picklist_filtered_value)
			find(:xpath , picklist_filtered_value).click
		end
		gen_tab_out element_locator
	end
	
	##
	# Method Summary:  Method to open Allocation Rule Detail Page
	#
	# @param [String] rule_name     Allocation Rule Name to be edited
	#
	def AllocationRules.open_allocation_rule_detail_page rule_name
		record_to_click = $allocationrules_link_pattern.gsub($sf_param_substitute, rule_name.to_s)
		find(:xpath , record_to_click).click
		gen_wait_until_object_disappear $allocationrules_loading_mask
	end
	
	##
	# Method Summary: Returns the count of GLAs matched
	#
	# @param [String] gla_list to pass the list of gla's
	# @param [Integer] line to pass the line number. If not specified, it will take line = 1
	#
	def AllocationRules.is_gla_values_present gla_list,row_number=1
	num_of_field_present_in_picklist = 0
	gla_list.each do |value|
	object_visible = gen_is_object_visible $allocationrules_fixed_grid_gla_column_input
		if(!object_visible)
			gla_row_selector = $allocationrules_fixed_grid_gla_column_edit.sub($sf_param_substitute,row_number.to_s)
			find(:xpath, gla_row_selector).click
		end
		AllocationRules.set_value $allocationrules_fixed_grid_gla_column_input, value
		picklist_filtered_value = $allocationrules_picklist_value_pattern.sub($sf_param_substitute,value.to_s)
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