#--------------------------------------------------------------------#
#TID : TID04545
# Pre-Requisit: org with base data and deploy CODATID004545Data.cls on org
#  Product Area: Accounting - Payments Collections & Cash Entries
# Story: 26168 
#--------------------------------------------------------------------#

describe "Part Pay - Save - Volume 1 Acc x 3000 transaction line items 3000 Acc x 1 transaction line item ", :type => :request do
include_context "login"
before :all do
	#Hold Base Data
	gen_start_test  "TID04545-Create payable Invoices Invoice"
	FFA.hold_base_data_and_wait
end
	it "Execute Script as Anonymous user , Post Invoice and Credit Notes " do
		begin
			# "Execute Script as Anonymous user" 
			create_payable_invoices = [ "CODATID004545Data.selectCompany();",
				"CODATID004545Data.createData();",
				"CODATID004545Data.switchProfile();",
				"CODATID004545Data.CreatePayableInvoices(200,1,'V_123');",
				"CODATID004545Data.CreatePayableInvoices(200,1,'V_123');",
				"CODATID004545Data.CreatePayableInvoices(200,1,'V_123');",
				"CODATID004545Data.CreatePayableInvoices(200,1,'V_123');",
				"CODATID004545Data.CreatePayableInvoices(200,1,'V_123');",
				"CODATID004545Data.CreatePayableInvoices(200,1,'V_123');",
				"CODATID004545Data.CreatePayableInvoices(200,1,'V_123');",
				"CODATID004545Data.CreatePayableInvoices(200,1,'V_123');",
				"CODATID004545Data.CreatePayableInvoices(200,1,'V_123');",
				"CODATID004545Data.CreatePayableInvoices(200,1,'V_123');",
				"CODATID004545Data.CreatePayableInvoices(200,1,'V_123');",
				"CODATID004545Data.CreatePayableInvoices(200,1,'V_123');",
				"CODATID004545Data.CreatePayableInvoices(200,1,'V_123');",
				"CODATID004545Data.CreatePayableInvoices(200,1,'V_123');",
				"CODATID004545Data.CreatePayableInvoices(200,1,'V_123');"]
				APEX.execute_commands create_payable_invoices	
				
			post_payable_invoices = ["CODATID004545Data.postPurchaseInvoices(75);",
				"CODATID004545Data.postPurchaseInvoices(75);",
				"CODATID004545Data.postPurchaseInvoices(75);",
				"CODATID004545Data.postPurchaseInvoices(75);",
				"CODATID004545Data.postPurchaseInvoices(75);",
				"CODATID004545Data.postPurchaseInvoices(75);",
				"CODATID004545Data.postPurchaseInvoices(75);",
				"CODATID004545Data.postPurchaseInvoices(75);",
				"CODATID004545Data.postPurchaseInvoices(75);",
				"CODATID004545Data.postPurchaseInvoices(75);",
				"CODATID004545Data.postPurchaseInvoices(75);",
				"CODATID004545Data.postPurchaseInvoices(75);",
				"CODATID004545Data.postPurchaseInvoices(75);",
				"CODATID004545Data.postPurchaseInvoices(75);",
				"CODATID004545Data.postPurchaseInvoices(75);",
				"CODATID004545Data.postPurchaseInvoices(75);",
				"CODATID004545Data.postPurchaseInvoices(75);",
				"CODATID004545Data.postPurchaseInvoices(75);",
				"CODATID004545Data.postPurchaseInvoices(75);",
				"CODATID004545Data.postPurchaseInvoices(75);",
				"CODATID004545Data.postPurchaseInvoices(75);",
				"CODATID004545Data.postPurchaseInvoices(75);",
				"CODATID004545Data.postPurchaseInvoices(75);",
				"CODATID004545Data.postPurchaseInvoices(75);",
				"CODATID004545Data.postPurchaseInvoices(75);",
				"CODATID004545Data.postPurchaseInvoices(75);",
				"CODATID004545Data.postPurchaseInvoices(75);",
				"CODATID004545Data.postPurchaseInvoices(75);",
				"CODATID004545Data.postPurchaseInvoices(75);",
				"CODATID004545Data.postPurchaseInvoices(75);",
				"CODATID004545Data.postPurchaseInvoices(75);",
				"CODATID004545Data.postPurchaseInvoices(75);",
				"CODATID004545Data.postPurchaseInvoices(75);",
				"CODATID004545Data.postPurchaseInvoices(75);",
				"CODATID004545Data.postPurchaseInvoices(75);",
				"CODATID004545Data.postPurchaseInvoices(75);",
				"CODATID004545Data.postPurchaseInvoices(75);",
				"CODATID004545Data.postPurchaseInvoices(75);",
				"CODATID004545Data.postPurchaseInvoices(75);",
				"CODATID004545Data.postPurchaseInvoices(75);",
				"CODATID004545Data.postPurchaseInvoices(75);",
				"CODATID004545Data.postPurchaseInvoices(75);",
				"CODATID004545Data.postPurchaseInvoices(75);",
				"CODATID004545Data.postPurchaseInvoices(75);",
				"CODATID004545Data.postPurchaseInvoices(75);",
				"CODATID004545Data.postPurchaseInvoices(75);",
				"CODATID004545Data.postPurchaseInvoices(75);",
				"CODATID004545Data.postPurchaseInvoices(75);",
				"CODATID004545Data.postPurchaseInvoices(75);",
				"CODATID004545Data.postPurchaseInvoices(75);",
				"CODATID004545Data.postPurchaseInvoices(75);",
				"CODAPaymentData.retrievePayment(CODATID004545Data.SUFFIX, CODAPaymentExt.PAYMENT_TYPE_PAYMENTS,CODAPayment.PAYMENTMETHOD_ELECTRONIC,'Santander Current Account', CODABaseData.NAMEGLA_SETTLEMENTDISCOUNTSALLOWEDUS, CODABaseData.NAMEGLA_WRITEOFFUS, null, CODATID004545Data.UNIQUE_PAYMENT_ID, CODATID004545Data.COMPANY_NAME,System.today(), System.today()+10);"]
		
			APEX.execute_commands post_payable_invoices, 10
			#wait for apex jobs to complete
			SF.wait_for_apex_job
			
		end
		#edit Account line items 
		begin		
								
			_payment_total_value_N600960 = "-600,960.00"
			_new_payment_value_N100 = "-100.00"
			_account_VEND0001 = "VEND0001"				
			_expected_payment_value_N300000 = "-300,000.00"
			_expected_outstanding_payment_N667740 = "-667,740.00"
			_expected_gross_value_N667740 = "-667,740.00"
			_expected_discount_value_0 = "0.00"
			_line_item_type = "Account"
			_matching_status = "Proposed"
			_number_of_line_items_3000 = "3000"
			_items_per_page_200 = 200
			
			SF.retry_script_block do
				SF.tab $tab_payments
				SF.select_view $bd_select_view_all
				SF.click_button_go
				SF.wait_for_search_button
				payment_no = FFA.get_column_value_in_grid $label_payment_payment_value , _payment_total_value_N600960 , $label_payment_number
				
				gen_start_test "Edit All account line items, and click OK and Save"
				PAY.edit_all_Account_line_Items _account_VEND0001, payment_no, _new_payment_value_N100, _items_per_page_200
				PAY.click_save_button		
				#wait for apex jobs to complete
				SF.wait_for_apex_job
			end 
			
			puts "Validating results"
			SF.tab $tab_payments
			SF.select_view $bd_select_view_all
			SF.click_button_go
			SF.wait_for_search_button
			payment_no = FFA.get_column_value_in_grid $label_payment_payment_value , _expected_payment_value_N300000 , $label_payment_number
			PAY.open_payment_detail_page payment_no
			
			#validation 
			_actual_payment_value = PAY.get_payment_value _account_VEND0001
			gen_compare  _expected_payment_value_N300000 , _actual_payment_value.to_s , "payment value same as expected"
			
			_actual_outstanding_payment = PAY.get_outstanding_value _account_VEND0001
			gen_compare  _expected_outstanding_payment_N667740 , _actual_outstanding_payment.to_s , "Outstanding payment same as expected"
			
			_actual_gross_value = PAY.get_gross_value _account_VEND0001
			gen_compare  _expected_gross_value_N667740 , _actual_gross_value.to_s , "gross payment same as expected"
			
			_actual_discount_value = PAY.get_discount _account_VEND0001
			gen_compare  _expected_discount_value_0 , _actual_discount_value.to_s , "Discount value same as expected"
			
			checkbox_checked = "true"
			actual_checkbox_status = PAY.get_account_checkbox_status _account_VEND0001
			gen_compare  checkbox_checked , actual_checkbox_status.to_s , "account checkbox is checked"
			
			line_item_count_script = "Select Count() from codaTransactionLineItem__c WHERE Linetype__c='" + _line_item_type + "'"
			line_item_count_script += " AND MatchingStatus__c='"+_matching_status  + "'"
			line_item_count_script += " AND Account__c IN (SELECT ID from Account where MirrorName__c='"+_account_VEND0001+"')"
			
			APEX.execute_soql line_item_count_script
			script_status = APEX.get_execution_status_message
			gen_include ":"+_number_of_line_items_3000 + ",",script_status, "Total Number of Proposed items are 3000"		
				
		end
	end
	after :all do
		login_user
		#Delete Test Data
		SF.retry_script_block do
			delete_data = [ "CODATID004545Data.destroyData();",
			"CODATID004545Data.destroyDataExt1();",
			"CODATID004545Data.destroyDataExt2();",
			"CODATID004545Data.destroyDataExt3();",
			"CODATID004545Data.destroyDataExt4();",
			"CODATID004545Data.destroyDataExt5();",
			"CODATID004545Data.destroyDataExt6();",
			"CODATID004545Data.destroyDataExt7();",
			"CODATID004545Data.destroyDataExt8();",
			"CODATID004545Data.destroyDataExt9();",
			"CODATID004545Data.destroyDataExt10();"]				
			APEX.execute_commands delete_data
		end

		FFA.delete_new_data_and_wait
		gen_end_test "TID04545-Create payable Invoices Invoices, and validations"	
	end
end
