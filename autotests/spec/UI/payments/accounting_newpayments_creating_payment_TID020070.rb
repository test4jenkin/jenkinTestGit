#--------------------------------------------------------------------#
# TID : TID020070
# Pre-Requisit: Org with basedata deployed
# Product Area: Accounting - Payments Collections & Cash Entries
# Story: AC-6534 AC11390
#--------------------------------------------------------------------#
describe "Payment details", :type => :request do
include_context "login"
	before :all do
		gen_start_test  "TID020070- Create a new Payment"
		#Hold Base Data
		FFA.hold_base_data_and_wait
		_create_data = ["CODATID020070Data.selectCompany();", "CODATID020070Data.createData();"]
		_create_data+= ["CODATID020070Data.createDataExt1();"];
		# Execute Commands
		APEX.execute_commands _create_data
	end

	it "Execute Script as Admin user. Create a Payment" do
	current_date = FFA.get_current_formatted_date

	gen_start_test "TST032971 - Create Payment Details"
	begin
		SF.tab $tab_new_payment
		gen_wait_until_object $newpay_detail_panel

		puts "1. Verify that Document Proposed and Vendors Proposed have both value 0."
		gen_compare_has_css_with_text($newpay_proposal_payment_document_proposed_label, $label_newpayment_document_proposed, true, $newpay_assert_output_text)
		gen_compare("0", NEWPAY.get_proposal_document_proposed_value, $newpay_assert_output_text)
		
		gen_compare("0", NEWPAY.get_proposal_vendors_proposed_value, $newpay_assert_output_text)
		puts "2. Verify that Status at this stage is NEW."
		gen_compare($newpay_status_new, NEWPAY.get_proposal_status_value, $newpay_assert_output_text)
		puts "3. Setting Payment date. Verify that Payment Date is also updated in the Payment Proposal."
		NEWPAY.set_payment_date current_date
		gen_compare_has_css_with_text($newpay_detail_payment_date_label, $label_newpayment_date, true, $newpay_assert_output_text)
		gen_compare_has_css_with_text($newpay_proposal_payment_date_label, $label_newpayment_date, true, $newpay_assert_output_text)

		puts "4. Setting Bank Account. Verify that Bank Account is also updated in the Payment Proposal."
		NEWPAY.set_bank_account $bd_bank_account_bristol_checking_account
		gen_compare_has_css_with_text($newpay_detail_bank_account_label,$label_newpayment_bank_account, true, $newpay_assert_output_text)
		gen_compare_has_css_with_text($newpay_proposal_bank_account_label,$label_newpayment_bank_account, true, $newpay_assert_output_text)

		puts "5. Setting Payment Currency. Verify that Payment Currency is also updated in the Payment Proposal."
		NEWPAY.set_payment_currency $bd_currency_usd
		gen_compare_has_css_with_text($newpay_detail_payment_currency_label,$label_newpayment_currency, true, $newpay_assert_output_text)
		gen_compare_has_css_with_text($newpay_proposal_payment_currency_label,$label_newpayment_currency, true, $newpay_assert_output_text)
		gen_compare($bd_currency_usd +" 0.00", NEWPAY.get_proposal_total_value, $newpay_assert_output_text)

		puts "6. Setting Payment Media. Verify that Payment Media is also updated in the Payment Proposal."
		NEWPAY.set_payment_media $bd_payment_method_electronic
		gen_compare_has_css_with_text($newpay_detail_payment_media_label, $label_newpayment_media_electronic, true, $newpay_assert_output_text)
		gen_compare_has_css_with_text($newpay_proposal_payment_media_label,$label_newpayment_media_electronic, true, $newpay_assert_output_text)
		NEWPAY.set_payment_media $bd_payment_method_check
		gen_compare_has_css_with_text($newpay_detail_payment_media_label, $label_newpayment_media_check, true, $newpay_assert_output_text)
		gen_compare_has_css_with_text($newpay_proposal_payment_media_label,$label_newpayment_media_check, true, $newpay_assert_output_text)

		puts "7. Setting Settlement Discount. Verify that Settlement Discount is also updated in the Payment Proposal."
		NEWPAY.set_settlement_discount $bd_gla_settlement_discounts_allowed_us
		gen_compare_has_css_with_text($newpay_detail_settlement_discount_label, $label_newpayment_settlement_discount, true, $newpay_assert_output_text)
		gen_compare_has_css_with_text($newpay_proposal_settlement_discount_label, $label_newpayment_settlement_discount, true, $newpay_assert_output_text)

		NEWPAY.click_sett_disc_dim_button
		puts "8. Setting Settlement Discount Dimension 1."
		NEWPAY.set_settlement_discount_dim1 $bd_dim1_usd
		gen_compare_has_css_with_text($newpay_detail_settlement_discount_dim1_label, $label_newpayment_settlement_discount_dim1, true, $newpay_assert_output_text)
		puts "9. Setting Settlement Discount Dimension 2."
		NEWPAY.set_settlement_discount_dim2 $bd_dim2_usd
		gen_compare_has_css_with_text($newpay_detail_settlement_discount_dim2_label, $label_newpayment_settlement_discount_dim2, true, $newpay_assert_output_text)
		puts "10. Setting Settlement Discount Dimension 3."
		NEWPAY.set_settlement_discount_dim3 $bd_dim3_usd
		gen_compare_has_css_with_text($newpay_detail_settlement_discount_dim3_label, $label_newpayment_settlement_discount_dim3, true, $newpay_assert_output_text)
		puts "11. Setting Settlement Discount Dimension 4."
		NEWPAY.set_settlement_discount_dim4 $bd_dim4_usd
		gen_compare_has_css_with_text($newpay_detail_settlement_discount_dim4_label, $label_newpayment_settlement_discount_dim4, true, $newpay_assert_output_text)
		puts "12. Setting Currency Write-off. Aso verify that Currency Write-off is updated in the Payment Proposal."
		NEWPAY.set_currency_write_off $bd_gla_write_off_us
		gen_compare_has_css_with_text($newpay_proposal_currency_write_off_label, $label_newpayment_currency_write_off, true, $newpay_assert_output_text)

		NEWPAY.click_writeoff_dim_button
		puts "13. Setting Cureency Write-Off Dimension 1."
		NEWPAY.set_currency_write_off_dim1 $bd_dim1_eur
		gen_compare_has_css_with_text($newpay_detail_currency_write_off_dim1_label, $label_newpayment_write_off_dim1, true, $newpay_assert_output_text)
		puts "14. Setting Cureency Write-Off Dimension 2."
		NEWPAY.set_currency_write_off_dim2 $bd_dim2_eur
		gen_compare_has_css_with_text($newpay_detail_currency_write_off_dim2_label, $label_newpayment_write_off_dim2, true, $newpay_assert_output_text)
		puts "15. Setting Cureency Write-Off Dimension 3."
		NEWPAY.set_currency_write_off_dim3 $bd_dim3_eur
		gen_compare_has_css_with_text($newpay_detail_currency_write_off_dim3_label, $label_newpayment_write_off_dim3, true, $newpay_assert_output_text)
		puts "16. Setting Cureency Write-Off Dimension 4."
		NEWPAY.set_currency_write_off_dim4 $bd_dim4_eur
		gen_compare_has_css_with_text($newpay_detail_currency_write_off_dim4_label, $label_newpayment_write_off_dim4, true, $newpay_assert_output_text)
		puts "17. Verifying Settlement Discount Dimensions in the Payment Proposal panel."


		gen_compare($bd_comapny_merlin_auto_usa, NEWPAY.get_proposal_company_value, $newpay_assert_output_text)
		gen_compare(current_date, NEWPAY.get_proposal_payment_date_value, $newpay_assert_output_text)
		gen_compare($bd_bank_account_bristol_checking_account, NEWPAY.get_proposal_payment_bank_account_value, $newpay_assert_output_text)
		gen_compare($bd_currency_usd, NEWPAY.get_proposal_payment_currency_value, $newpay_assert_output_text)
		gen_compare($bd_payment_method_check, NEWPAY.get_proposal_payment_media_value, $newpay_assert_output_text)
		gen_compare($bd_gla_settlement_discounts_allowed_us, NEWPAY.get_proposal_settlement_discount_value, $newpay_assert_output_text)
		gen_compare($bd_gla_write_off_us , NEWPAY.get_proposal_currency_write_off_value, $newpay_assert_output_text)
		gen_compare($label_newpayment_settlement_discount_dim1 + ": " + $bd_dim1_usd +
					$label_newpayment_settlement_discount_dim2 + ": " + $bd_dim2_usd +
					$label_newpayment_settlement_discount_dim3 + ": " + $bd_dim3_usd +
					$label_newpayment_settlement_discount_dim4 + ": " + $bd_dim4_usd, 
					NEWPAY.get_proposal_settlement_discount_dimensions_value, $newpay_assert_output_text)

		gen_compare($label_newpayment_write_off_dim1 + ": " + $bd_dim1_eur +
					$label_newpayment_write_off_dim2 + ": " + $bd_dim2_eur +
					$label_newpayment_write_off_dim3 + ": " + $bd_dim3_eur +
					$label_newpayment_write_off_dim4 + ": " + $bd_dim4_eur,
					NEWPAY.get_proposal_currency_write_off_dimensions_value, $newpay_assert_output_text)

		NEWPAY.click_next_button

	end
	gen_end_test "TST032971 - Create Payment Details"


	gen_start_test "Create a payment by loading a Payment Details Template"
	begin
		_template1 = 'PDT1'
		_templateDefault = 'PDT2Default'
		_current_period = FFA.get_current_period

		_create_data= ["CODATID020070Data.createDataExt2();"];
		# Execute Commands
		APEX.execute_commands _create_data

		SF.tab $tab_new_payment
		gen_wait_until_object $newpay_detail_panel
		expect(NEWPAY.get_toast_message).to eq('The default template has been applied to this payment.')

		NEWPAY.set_payment_date current_date
		NEWPAY.set_discount_date current_date
		NEWPAY.click_sett_disc_dim_button
		NEWPAY.click_writeoff_dim_button

		gen_compare($bd_comapny_merlin_auto_usa, NEWPAY.get_proposal_company_value, $newpay_assert_output_text)
		gen_compare($bd_gla_accounts_payable_control_eur, NEWPAY.get_proposal_settlement_discount_value, $newpay_assert_output_text)
		gen_compare($bd_gla_accounts_payable_control_eur , NEWPAY.get_proposal_currency_write_off_value, $newpay_assert_output_text)
		gen_compare($bd_bank_account_bristol_deposit_account, NEWPAY.get_proposal_payment_bank_account_value, $newpay_assert_output_text)
		gen_compare($bd_payment_method_check, NEWPAY.get_proposal_payment_media_value, $newpay_assert_output_text)

		gen_compare($label_newpayment_settlement_discount_dim1 + ": " + $bd_dim1_eur +
					$label_newpayment_settlement_discount_dim2 + ": " + $bd_dim2_eur +
					$label_newpayment_settlement_discount_dim3 + ": " + $bd_dim3_eur +
					$label_newpayment_settlement_discount_dim4 + ": " + $bd_dim4_eur, 
					NEWPAY.get_proposal_settlement_discount_dimensions_value, $newpay_assert_output_text)

		gen_compare($label_newpayment_write_off_dim1 + ": " + $bd_dim1_eur +
					$label_newpayment_write_off_dim2 + ": " + $bd_dim2_eur +
					$label_newpayment_write_off_dim3 + ": " + $bd_dim3_eur +
					$label_newpayment_write_off_dim4 + ": " + $bd_dim4_eur,
					NEWPAY.get_proposal_currency_write_off_dimensions_value, $newpay_assert_output_text)

		NEWPAY.set_payment_detail_template _template1
		gen_wait_until_object_disappear $page_loadmask_message

		gen_compare($bd_comapny_merlin_auto_usa, NEWPAY.get_proposal_company_value, $newpay_assert_output_text)
		gen_compare(current_date, NEWPAY.get_proposal_payment_date_value, $newpay_assert_output_text)
		gen_compare($bd_gla_account_payable_control_usd, NEWPAY.get_proposal_settlement_discount_value, $newpay_assert_output_text)
		gen_compare($bd_gla_account_payable_control_usd , NEWPAY.get_proposal_currency_write_off_value, $newpay_assert_output_text)
		gen_compare($bd_bank_account_bristol_euros_account, NEWPAY.get_proposal_payment_bank_account_value, $newpay_assert_output_text)
		gen_compare($bd_payment_method_check, NEWPAY.get_proposal_payment_media_value, $newpay_assert_output_text)

		gen_compare($label_newpayment_settlement_discount_dim1 + ": " + $bd_dim1_usd +
					$label_newpayment_settlement_discount_dim2 + ": " + $bd_dim2_usd +
					$label_newpayment_settlement_discount_dim3 + ": " + $bd_dim3_usd +
					$label_newpayment_settlement_discount_dim4 + ": " + $bd_dim4_usd, 
					NEWPAY.get_proposal_settlement_discount_dimensions_value, $newpay_assert_output_text)

		gen_compare($label_newpayment_write_off_dim1 + ": " + $bd_dim1_usd +
					$label_newpayment_write_off_dim2 + ": " + $bd_dim2_usd +
					$label_newpayment_write_off_dim3 + ": " + $bd_dim3_usd +
					$label_newpayment_write_off_dim4 + ": " + $bd_dim4_usd,
					NEWPAY.get_proposal_currency_write_off_dimensions_value, $newpay_assert_output_text)


		NEWPAY.set_when_and_how_to_pay current_date, $bd_bank_account_bristol_checking_account, $bd_payment_method_check
		NEWPAY.set_settlement_discount $bd_gla_settlement_discounts_allowed_us
		NEWPAY.set_currency_write_off $bd_gla_write_off_us

		gen_compare($bd_comapny_merlin_auto_usa, NEWPAY.get_proposal_company_value, $newpay_assert_output_text)
		gen_compare(current_date, NEWPAY.get_proposal_payment_date_value, $newpay_assert_output_text)
		gen_compare($bd_currency_usd, NEWPAY.get_proposal_payment_currency_value, $newpay_assert_output_text)
		gen_compare($bd_gla_settlement_discounts_allowed_us, NEWPAY.get_proposal_settlement_discount_value, $newpay_assert_output_text)
		gen_compare($bd_gla_write_off_us , NEWPAY.get_proposal_currency_write_off_value, $newpay_assert_output_text)
		gen_compare($bd_bank_account_bristol_checking_account, NEWPAY.get_proposal_payment_bank_account_value, $newpay_assert_output_text)
		gen_compare($bd_payment_method_check, NEWPAY.get_proposal_payment_media_value, $newpay_assert_output_text)
	end
end
after :all do
		login_user
		#Delete Test Data
		_delete_data = ["CODATID020070Data.destroyData();"]
		APEX.execute_commands _delete_data
		FFA.delete_new_data_and_wait
		SF.logout
		gen_end_test  "TID020070- Create a new Payment"
	end
end
