#--------------------------------------------------------------------#
#	TID : TID014300
# 	Pre-Requisit: FFA installed
#  	Product Area: Payable Extension Setting
# 	Story: 25742 fieldsets not avaiable manage lines crossfix 
#--------------------------------------------------------------------#

describe "Field sets availability", :type => :request do

	before(:all) do
		gen_start_test "TID014300"
	end

	after(:all) do
		gen_end_test "TID014300"
	end

	AVAILABLE_FIELD_EXP_SUT = ['Calculate Tax Val...', 'Date From', 'Date To', 'Derive Line Number', 'Derive Tax Rate f...', 'Dimension 1', 'Dimension 2', 
						'Dimension 3', 'Dimension 4', 'Edit Tax Value', 'External Id', 'GLA Code', 'Input Tax Code', 'Line Number',
						'Set GLA to Default', 'Tax Rate', 'Tax Rate Total', 'Tax Value', 'Tax Value Total']

	DEFAULT_FIELD_EXP_SUT = ['General Ledger Account', 'Line Description', 'Net Value'];

	AVAILABLE_FIELD_EXP_VAT = ['Calculate Tax Val...', 'Date From', 'Date To', 'Derive Line Number', 'Derive Tax Rate f...', 'Dimension 1', 'Dimension 2', 
								'Dimension 3', 'Dimension 4', 'Edit Tax Value', 'External Id', 'GLA Code', 'Line Number',
								'Set GLA to Default', 'Set Tax Code to D...', 'Tax Rate Total', 'Tax Value Total']

	DEFAULT_FIELD_EXP_VAT = ['General Ledger Account', 'Line Description', 'Input Tax Code', 'Tax Rate', 'Tax Value', 'Net Value'];

	AVAILABLE_FIELD_PROD_SUT = ['Calculate Tax Val...', 'Date From', 'Date To', 'Derive Line Number', 'Derive Tax Rate f...', 'Derive Unit Price...',
								'Dimension 1', 'Dimension 2', 'Dimension 3', 'Dimension 4', 'Edit Tax Value', 'External Id', 'Input Tax Code', 'Line Number',
								'Set Tax Code to D...', 'Tax Rate', 'Tax Rate Total', 'Tax Value', 'Tax Value Total']

	DEFAULT_FIELD_PROD_SUT = ['Product', 'Line Description', 'Quantity', 'Unit Price', 'Net Value'];

	AVAILABLE_FIELD_PROD_VAT = ['Calculate Tax Val...', 'Date From', 'Date To', 'Derive Line Number', 'Derive Tax Rate f', 'Derive Unit Price...',
								'Dimension 1', 'Dimension 2', 'Dimension 3', 'Dimension 4', 'Edit Tax Value', 'External Id', 'Line Number',
								'Set Tax Code to D...', 'Tax Rate Total', 'Tax Value Total']

	DEFAULT_FIELD_PROD_VAT = ['Product', 'Line Description', 'Quantity', 'Unit Price', 'Net Value', 'Input Tax Code', 'Tax Rate', 'Tax Value', 'Net Value'];

	DEFAULT_FIELD_PROD_COMBINED = ['Product', 'Line Description', 'Quantity', 'Unit Price', 'Combined Tax Code', 'Input Tax Code', 'Input Tax Code 2', 'Tax Rate', 'Tax Rate 2', 'Tax Value', 'Tax Value 2', 'Net Value'];

	DEFAULT_FIELD_EXP_COMBINED = ['General Ledger Account', 'Line Description', 'Combined Tax Code', 'Input Tax Code', 'Input Tax Code 2', 'Tax Rate', 'Tax Rate 2', 'Tax Value', 'Tax Value 2', 'Net Value'];

	def check_fields_set line_type_object_name, field_set_name
		SF.admin $sf_setup
		SF.click_link $sf_setup_create
		SF.click_link $sf_setup_create_objects
		SF.click_link line_type_object_name
		SF.click_link $sf_custom_object_field_sets

		SF.click_edit_link_by_element_title field_set_name

		# Check visible fields
		if field_set_name.include? "SUT"
			if field_set_name.include? "Expense"
				AVAILABLE_FIELD_EXP_SUT.each do |available_field|
					expect(find($sf_custom_object_field_sets_draggables)).to have_content(available_field)
				end
				DEFAULT_FIELD_EXP_SUT.each do |default_field|
					expect(find($sf_custom_object_field_sets_default_list)).to have_content(default_field)
				end
			else 
				AVAILABLE_FIELD_PROD_SUT.each do |available_field|
					expect(find($sf_custom_object_field_sets_draggables)).to have_content(available_field)
				end
				DEFAULT_FIELD_PROD_SUT.each do |default_field|
					expect(find($sf_custom_object_field_sets_default_list)).to have_content(default_field)
				end
			end
			if line_type_object_name.include? "Invoice"
				expect(find($sf_custom_object_field_sets_draggables)).to have_content('Payable Invoice N...');
			else
				expect(find($sf_custom_object_field_sets_draggables)).to have_content('Payable Credit No...');
			end
		end

		if field_set_name.include? "VAT"
			if field_set_name.include? "Expense"
				AVAILABLE_FIELD_EXP_VAT.each do |available_field|
					expect(find($sf_custom_object_field_sets_draggables)).to have_content(available_field)
				end
				DEFAULT_FIELD_EXP_VAT.each do |default_field|
					expect(find($sf_custom_object_field_sets_default_list)).to have_content(default_field)
				end
			else 
				AVAILABLE_FIELD_PROD_VAT.each do |available_field|
					expect(find($sf_custom_object_field_sets_draggables)).to have_content(available_field)
				end
				DEFAULT_FIELD_PROD_VAT.each do |default_field|
					expect(find($sf_custom_object_field_sets_default_list)).to have_content(default_field)
				end
			end
			if line_type_object_name.include? "Invoice"
				expect(find($sf_custom_object_field_sets_draggables)).to have_content('Payable Invoice N...');
			else
				expect(find($sf_custom_object_field_sets_draggables)).to have_content('Payable Credit No...');
			end
		end

		if field_set_name.include? "Combined"
			if field_set_name.include? "Expense"
				DEFAULT_FIELD_EXP_COMBINED.each do |default_field|
					expect(find($sf_custom_object_field_sets_default_list)).to have_content(default_field)
				end
			end
			if field_set_name.include? "Product"
				DEFAULT_FIELD_PROD_COMBINED.each do |default_field|
					expect(find($sf_custom_object_field_sets_default_list)).to have_content(default_field)
				end
			end
		end

	end

	include_context "login"
	include_context "logout_after_each"
	it "TID014300 - Field sets configuration for managed lines (payable extension)" do

		check_fields_set $label_payable_invoice_manage_exp_lines, "Manage Expense Lines (SUT)"
		check_fields_set $label_payable_invoice_manage_exp_lines, "Manage Expense Lines (VAT)"
		check_fields_set $label_payable_invoice_manage_exp_lines, "Manage Expense Lines (Combined)"
		gen_report_test "TST019282 - PIN Field sets for Manage Expense Lines"

		check_fields_set $label_payable_invoice_manage_prod_lines, "Manage Product Lines (SUT)"
		check_fields_set $label_payable_invoice_manage_prod_lines, "Manage Product Lines (VAT/GST)"
		check_fields_set $label_payable_invoice_manage_prod_lines, "Manage Product Lines (Combined)"
		gen_report_test "TST019283 - PIN Field sets for Manage Product Lines"

		check_fields_set $label_payable_credit_note_manage_exp_lines, "Manage Expense Lines (SUT)"
		check_fields_set $label_payable_credit_note_manage_exp_lines, "Manage Expense Lines (VAT)"
		check_fields_set $label_payable_credit_note_manage_exp_lines, "Manage Expense Lines (Combined)"
		gen_report_test "TST019285 - PCR Field sets for Manage Expense Lines"

		check_fields_set $label_payable_credit_note_manage_prod_lines, "Manage Product Lines (SUT)"
		check_fields_set $label_payable_credit_note_manage_prod_lines, "Manage Product Lines (VAT)"
		check_fields_set $label_payable_credit_note_manage_prod_lines, "Manage Product Lines (Combined)"
		gen_report_test "TST019284 - PCR Field sets for Manage Product Lines"

	end
end