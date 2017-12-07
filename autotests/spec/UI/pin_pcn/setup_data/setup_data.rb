#--------------------------------------------------------------------#
#	TID :  
# 	Pre-Requisite: Org with basedata deployed.
#  	Product Area: FFA UI test data setup extension
# 	Story:  
#--------------------------------------------------------------------#
describe "UI Test - Extended Data Setup for payable invoice and payable credit notes.", :type => :request do
	include_context "login"
	
	_pcr_extended_layout_fields_to_add = [$pcrext_company_label]
	_pcr_line_item_extended_layout_fields_to_add = [$pcrext_company_label]
	_pcr_expense_line_item_extended_layout_fields_to_add = [$pcrext_company_label]
	
	_pin_extended_layout_fields_to_add = [$pcrext_company_label]
	_pin_line_item_extended_layout_fields_to_add = [$pcrext_company_label]
	_pin_expense_line_item_extended_layout_fields_to_add = [$pcrext_company_label]
	
	it "Add fields to payable credit note extended layout." do
		puts "Add fields to layout"
		begin
			puts "Add company field to layout on Payable credit note extended layout"
			SF.retry_script_block do
				SF.edit_layout_add_field $ffa_object_payable_credit_note, $ffa_purchase_credit_note_extended_layout, $sf_layout_panel_fields, _pcr_extended_layout_fields_to_add, $sf_edit_page_layout_target_position2
			end
			puts "Add company field to layout on Payable credit note product line item extended layout"
			SF.retry_script_block do
				SF.edit_layout_add_field $ffa_object_payable_credit_note_line_item, $ffa_purchase_credit_note_line_item_extended_layout, $sf_layout_panel_fields, _pcr_line_item_extended_layout_fields_to_add, $sf_edit_page_layout_target_position2
			end
			puts "Add company field to layout on Payable credit note expense line item extended layout"
			SF.retry_script_block do
				SF.edit_layout_add_field $ffa_object_payable_credit_note_expense_line_item, $ffa_purchase_credit_note_expense_line_item_extended_layout, $sf_layout_panel_fields, _pcr_expense_line_item_extended_layout_fields_to_add, $sf_edit_page_layout_target_position2
			end
		end
	end

	it "Add fields to layout" do
		login_user
		_field_name_owner_company = ["Owner Company"]
		puts "Add company field to payable invoice extended layout"
		SF.retry_script_block do
			SF.edit_layout_add_field $ffa_object_payable_invoice, $ffa_purchase_invoice_extended_layout, $sf_layout_panel_fields, _pin_extended_layout_fields_to_add, $sf_edit_page_layout_target_position2
		end
		puts "Add company field to payable invoice line item extended layout"
		SF.retry_script_block do
			SF.edit_layout_add_field $ffa_object_payable_invoice_line_item, $ffa_purchase_invoice_line_item_extended_layout, $sf_layout_panel_fields, _pin_line_item_extended_layout_fields_to_add, $sf_edit_page_layout_target_position
		end
		puts "Add company field to payable invoice expense line item extended layout"
		SF.retry_script_block do
			SF.edit_layout_add_field $ffa_object_payable_invoice_expense_line_item, $ffa_purchase_invoice_expense_line_item_extended_layout, $sf_layout_panel_fields, _pin_expense_line_item_extended_layout_fields_to_add, $sf_edit_page_layout_target_position2
		end
		puts "Add owner company field to period layout"
		SF.retry_script_block do
			SF.edit_layout_add_field $ffa_object_period, $ffa_period_layout, $sf_layout_panel_fields, _field_name_owner_company, $sf_edit_page_layout_target_position
		end
	end
end
