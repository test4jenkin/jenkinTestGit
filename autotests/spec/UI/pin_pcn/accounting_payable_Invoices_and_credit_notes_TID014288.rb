#--------------------------------------------------------------------#
#	TID : TID014288
# 	Pre-Requisite : Org with basedata deployed.
#  	Product Area: Accounting - Payables Invoices & Credit Notes (UI Test)
# 	Story: 26950
#--------------------------------------------------------------------#

describe "UI Test - Accounting - Payables Invoices & Credit Notes", :type => :request do
	include_context "login"
	_name_space_name= ORG_PREFIX.gsub("__", ".").sub(" ","") 
	include_context "logout_after_each"

	before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait
		gen_start_test "TID014288 : Accounting - Payables Invoices & Credit Notes UI Test"
	end
	
	it "TID014288 : check that an admin user can post the payable invoices in a company that's not selected as current company" do
		gen_start_test "TID014288 : check that an admin user can post the payable invoices in a company that's not selected as current company"
		
		_expected_error_message = "Period: You must enter a period that belongs to the current company. Object validation has failed. Period Field: You must enter a period that belongs to the current company."
		_net_value_100 = "100"
		
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_spain] ,true	
		
		puts "Additional data required for TID014288"
		begin
			# Set extended layout for payable invoice
			SF.edit_extended_layout $ffa_object_payable_invoice, $ffa_profile_system_administrator, $ffa_purchase_invoice_extended_layout
			SF.object_button_edit $ffa_object_payable_invoice, $sf_new_button
			SF.set_button_property_for_extended_layout			
			SF.object_button_edit $ffa_object_payable_invoice, $sf_edit_button
			SF.set_button_property_for_extended_layout			
			SF.object_button_edit $ffa_object_payable_invoice, $sf_view_button
			SF.set_button_property_for_extended_layout			
		end
		
		gen_start_test "TST019236 : Admin user will get an error message, if POST payable invoice through extended UI in a company that's not selected as current company."
		begin
			# Create payable invoice
			SF.tab $tab_payable_invoices
			SF.click_button_new
			PINEXT.set_account $bdu_account_bmw_automobiles
			PINEXT.set_company $company_merlin_auto_gb
			PINEXT.set_vendor_invoice_number "VIN142881"
			SF.click_button_save
			
			# Create new payable invoice expense line item
			PINEXT.click_new_payable_invoice_expense_line_item_button
			PINEXT.set_net_value _net_value_100
			PINEXT.set_gla $bdu_gla_account_payable_control_eur
			PINEXT.set_line_company $company_merlin_auto_gb
			SF.click_button_save
			PINEXT.click_payable_invoice_number
			
			# Post payable invoice
			FFA.click_post
			FFA.click_post # confirm post
			gen_wait_until_object_disappear $ffa_processing_button_locator
			gen_include _expected_error_message, PINEXT.get_error_message_on_post, "Expected Following error message should be displayed : #{_expected_error_message}" 
		end
		
		gen_start_test "TST019237 : Admin user can POST payable invoice in a company that's not selected as current company through API"
		begin
			# Create payable invoice
			SF.tab $tab_payable_invoices
			SF.click_button_new
			PINEXT.set_account $bdu_account_bmw_automobiles
			PINEXT.set_company $company_merlin_auto_gb
			PINEXT.set_vendor_invoice_number "VIN142882"
			SF.click_button_save
			_pay_inv_number = PINEXT.get_invoice_number
			_command_to_execute = "#{ORG_PREFIX}codaCompany__c comp = [select Id, Name from #{ORG_PREFIX}codaCompany__c where Name = 'Merlin Auto GB'];\r\n#{_name_space_name}CODAAPICommon_9_0.Context context = new #{_name_space_name}CODAAPICommon_9_0.Context();\r\ncontext.CompanyName = comp.Name; // it is used when we want to change invoice company rather than current company\r\ncontext.token = EncodingUtil.convertToHex(Crypto.generateDigest('SHA1',Blob.valueOf('0000000000000000C000000000000046' + UserInfo.getUserId() + 'PROBABLEMENTE EL MEJOR SOFTWARE DE CONTABILIDAD EN EL MUNDO')));\r\n#{_name_space_name}CODAAPICommon.Reference invrefer = #{_name_space_name}CodaAPICommon.getRef(null, '#{_pay_inv_number}');\r\n#{_name_space_name}CODAAPIPurchaseInvoice_9_0.PostPurchaseInvoice(context, invrefer);"
			
			# Create new payable invoice expense line item
			PINEXT.click_new_payable_invoice_expense_line_item_button
			PINEXT.set_net_value _net_value_100
			PINEXT.set_gla $bdu_gla_account_payable_control_eur
			PINEXT.set_line_company $company_merlin_auto_gb
			SF.click_button_save
			
			# Execute API script through developer console.
			APEX.execute_script _command_to_execute
			SF.tab $tab_payable_invoices
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			SF.click_link _pay_inv_number
			gen_compare $bdu_document_status_complete, PINEXT.get_invoice_status, "Expected payable invoice to be of status #{$bdu_document_status_complete}"
		end
		gen_end_test "TID014288 : check that an admin user can post the payable invoices in a company that's not selected as current company"
	end
	
	after :all do
		login_user
		FFA.delete_new_data_and_wait
		puts "Revert additional data"
		begin
			SF.edit_extended_layout $ffa_object_payable_invoice, $ffa_profile_system_administrator, $ffa_purchase_invoice_layout
			SF.object_button_edit $ffa_object_payable_invoice, $sf_new_button
			SF.choose_visualforce_page $ffa_vf_page_coda_purchase_invoice_new
			SF.object_button_edit $ffa_object_payable_invoice, $sf_edit_button
			SF.choose_visualforce_page $ffa_vf_page_coda_purchase_invoice_edit
			SF.object_button_edit $ffa_object_payable_invoice, $sf_view_button
			SF.choose_visualforce_page $ffa_vf_page_coda_purchase_invoice_view
		end
		gen_end_test "TID014288 : Accounting - Payables Invoices & Credit Notes UI Test"
	end
end