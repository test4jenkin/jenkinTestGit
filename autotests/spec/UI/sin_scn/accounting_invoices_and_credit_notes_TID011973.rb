#--------------------------------------------------------------------#
#	TID : TID011973
# 	Pre-Requisite : 
#  	Product Area: Accounting - Invoices & Credit Notes (UI Test)
# 	Story: 25719
#--------------------------------------------------------------------#


describe "UI Test - Accounting - Sales Invoices : Edit from list view ", :type => :request do
include_context "login"
include_context "logout_after_each"
	 before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait
		gen_start_test "UI Test - Accounting - Sales Invoices : Edit from list view"
		
	end
	
	it "TID011973 : Update Sales Invoice using edit link from List view" do
		gen_start_test "TID011973 : Update Sales Invoice using edit link from List view"
		_line = 1
		_error_message = "Sales Invoice: Object validation has failed. You cannot modify this invoice."
		_error_message_sales_inv_line_item = "Sales Invoice Line Item: Object validation has failed. You cannot modify this invoice."
		_date_5_days_back = (Time.now-5*24*60*60).strftime("%-m/%-d/%Y")
		_date_6_days_back = (Time.now-6*24*60*60).strftime("%-m/%-d/%Y")
		_unit_price_100 = "100.00"
		_unit_price_200 = "200.00"
		_customer_reference_headerRef = "HeaderRef"
		_customer_reference_headerRef_changed = "HeaderRef changed"
		_customer_reference_revised_headerRef = "Revised HeaderRef"
		_invoice_description = "Description"
		_invoice_updating_description = "Updating Description"
		_invoice_updating_description_standard = "Updating Description in standard UI"
		_product_line_description = "LineDesc"
		_updated_product_line_description = "Update linedesc"
		_revised_product_line_description = "Revised linedesc"
		_quantity_2 = "2"
		_tax_value_50 = "50.00" 
		_tax_value_100 = "100.00"
		_period_7 = "2015/007"
		_period_8 = "2015/008"
		_page_codainvoiceedit = "codainvoiceedit"
					
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_spain] ,true
		
		gen_start_test "Additional data required for TID011973"
		begin
			#set classic layout for sales invoice and line item
			SF.edit_extended_layout $ffa_object_sales_invoice, $ffa_profile_standard_user, $ffa_sales_invoice_normal_layout
			SF.object_button_edit $ffa_object_sales_invoice, $sf_edit_button
			SF.choose_visualforce_page $ffa_vf_page_coda_invoice_edit
			SF.object_button_edit $ffa_object_sales_invoice, $sf_new_button
			SF.choose_visualforce_page $ffa_vf_page_coda_invoice_new
			SF.object_button_edit $ffa_object_sales_invoice, $sf_view_button
			SF.choose_visualforce_page $ffa_vf_page_coda_invoice_view
			SF.edit_extended_layout $ffa_object_sales_invoice_line_item, $ffa_profile_standard_user, $ffa_sales_invoice_line_item_normal_layout
			
			# set custom setting property
			SF.new_custom_setting $ffa_custom_setting_accounting_settings
			SF.set_custom_setting_property $ffa_accounting_settings_enable_edit_dimensions_after_posting, true
			SF.click_button_save
			
			# login with accountant user
			SF.login_as_user SFACC_USER
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_spain] ,true
			
			# creating sales invoice with complete status
			SF.tab $tab_sales_invoices
			SF.click_button_new
			SIN.set_account $bdu_account_cambridge_auto
			FFA.click_account_toggle_icon
			SIN.set_account_dimension $sin_dimension_1_label, $bdu_dim1_new_york
			SIN.set_account_dimension $sin_dimension_2_label, $bdu_dim2_dodge_uk
			SIN.set_account_dimension $sin_dimension_3_label, $bdu_dim3_sales_gbp
			SIN.set_account_dimension $sin_dimension_4_label, $bdu_dim4_harrogate
			FFA.click_account_toggle_icon
			SIN.set_customer_reference _customer_reference_headerRef
			SIN.set_description _invoice_description
			FFA.click_new_line
			SIN.line_set_product_name _line, $bdu_product_auto_com_clutch_kit_1989_dodge_raider
			FFA.click_product_toggle_icon _line
			SIN.line_set_product_dimensions _line, $sin_dimension_1_label, $bdu_dim1_new_york
			SIN.line_set_product_dimensions _line, $sin_dimension_2_label, $bdu_dim2_dodge_uk
			SIN.line_set_product_dimensions _line, $sin_dimension_3_label, $bdu_dim3_sales_gbp
			SIN.line_set_product_dimensions _line, $sin_dimension_4_label, $bdu_dim4_harrogate
			SIN.line_set_product_line_description _line, _product_line_description
			FFA.click_product_toggle_icon _line
			SIN.line_set_unit_price _line , _unit_price_100
			FFA.click_save_post
			_posted_sales_invoice_number = SIN.get_invoice_number
			
			#creating sales invoice with in progress status
			SF.tab $tab_sales_invoices
			SF.click_button_new
			SIN.set_account $bdu_account_cambridge_auto
			FFA.click_account_toggle_icon
			SIN.set_account_dimension $sin_dimension_1_label, $bdu_dim1_new_york
			SIN.set_account_dimension $sin_dimension_2_label, $bdu_dim2_dodge_uk
			SIN.set_account_dimension $sin_dimension_3_label, $bdu_dim3_sales_gbp
			SIN.set_account_dimension $sin_dimension_4_label, $bdu_dim4_harrogate
			FFA.click_account_toggle_icon
			SIN.set_customer_reference _customer_reference_headerRef
			SIN.set_description _invoice_description
			FFA.click_new_line
			SIN.line_set_product_name _line, $bdu_product_auto_com_clutch_kit_1989_dodge_raider
			FFA.click_product_toggle_icon _line
			SIN.line_set_product_dimensions _line, $sin_dimension_1_label, $bdu_dim1_new_york
			SIN.line_set_product_dimensions _line, $sin_dimension_2_label, $bdu_dim2_dodge_uk
			SIN.line_set_product_dimensions _line, $sin_dimension_3_label, $bdu_dim3_sales_gbp
			SIN.line_set_product_dimensions _line, $sin_dimension_4_label, $bdu_dim4_harrogate
			SIN.line_set_product_line_description _line, _product_line_description
			FFA.click_product_toggle_icon _line
			SIN.line_set_unit_price  _line , _unit_price_100
			SF.click_button_save
			_draft_sales_invoice_number = SIN.get_invoice_number
		end

		gen_start_test "TST015310 : Proper error message to be displayed on updating a 'Complete' status 'Sales Invoice' from list view with Edit page opening in Classic UI"
		begin
			SF.tab $tab_sales_invoices
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_invoice_number , _posted_sales_invoice_number
			gen_include _page_codainvoiceedit, current_url, "Expected Edit page #{_page_codainvoiceedit} should get opened"
			
			# verify edit if customer reference is updated
			SIN.set_customer_reference _customer_reference_headerRef_changed
			SF.click_button_save
			gen_include _error_message, FFA.get_error_message2, "Expected Sales Invoice should not get Saved/Posted with change of customer reference and the error should contain following message:\"#{_error_message}\""
			SF.click_button_cancel
			
			# verify edit if invoice date is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_invoice_number , _posted_sales_invoice_number
			SIN.set_invoice_date _date_5_days_back
			SF.click_button_save
			gen_include _error_message, FFA.get_error_message2, "Expected Sales Invoice should not get Saved/Posted with change of invoice date and the error should contain following message:\"#{_error_message}\""
			SF.click_button_cancel
			
			# verify edit if due date is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_invoice_number , _posted_sales_invoice_number
			SIN.set_due_date _date_5_days_back
			SF.click_button_save
			gen_include _error_message, FFA.get_error_message2, "Expected Sales Invoice should not get Saved/Posted with change of due date and the error should contain following message:\"#{_error_message}\""
			SF.click_button_cancel
			
			# verify edit if period is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_invoice_number , _posted_sales_invoice_number
			FFA.select_period_from_lookup $sin_period_lookup_icon, _period_8, $company_merlin_auto_spain
			SF.click_button_save
			gen_include _error_message, FFA.get_error_message2, "Expected Sales Invoice should not get Saved/Posted with change of period and the error should contain following message:\"#{_error_message}\""
			SF.click_button_cancel
			
			# verify edit if shipping method is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_invoice_number , _posted_sales_invoice_number
			SIN.select_shipping_method $bdu_shipping_method_fedex
			SF.click_button_save
			gen_include _error_message, FFA.get_error_message2, "Expected Sales Invoice should not get Saved/Posted with change of shipping method and the error should contain following message:\"#{_error_message}\""
			SF.click_button_cancel
			
			# verify edit if invoice description is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_invoice_number , _posted_sales_invoice_number
			SIN.set_description _invoice_updating_description
			SF.click_button_save
			gen_include _error_message, FFA.get_error_message2, "Expected Sales Invoice should not get Saved/Posted with change of invoice description and the error should contain following message:\"#{_error_message}\""
			SF.click_button_cancel
			
			# verify edit if product name is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_invoice_number , _posted_sales_invoice_number
			SIN.line_set_product_name _line , $bdu_product_centric_rear_brake_hose_1987_1989_dodge_raider
			SF.click_button_save
			gen_include _error_message_sales_inv_line_item, FFA.get_error_message2, "Expected Sales Invoice should not get Saved/Posted with change of product name and the error should contain following message:\"#{_error_message_sales_inv_line_item}\""
			SF.click_button_cancel
			
			# verify edit if quantity name is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_invoice_number , _posted_sales_invoice_number
			SIN.line_set_quantity _line , _quantity_2
			SF.click_button_save
			gen_include _error_message_sales_inv_line_item, FFA.get_error_message2, "Expected Sales Invoice should not get Saved/Posted with change of quantity and the error should contain following message:\"#{_error_message_sales_inv_line_item}\""
			SF.click_button_cancel
			
			# verify edit if unit price is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_invoice_number , _posted_sales_invoice_number
			SIN.line_set_unit_price _line , _unit_price_200
			SF.click_button_save
			gen_include _error_message_sales_inv_line_item, FFA.get_error_message2, "Expected Sales Invoice should not get Saved/Posted with change of unit price and the error should contain following message:\"#{_error_message_sales_inv_line_item}\""
			SF.click_button_cancel
			
			# verify edit if tax code is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_invoice_number , _posted_sales_invoice_number
			SIN.line_set_tax_code _line , $bdu_tax_code_vo_r_purchase
			SF.click_button_save
			gen_include _error_message_sales_inv_line_item, FFA.get_error_message2, "Expected Sales Invoice should not get Saved/Posted with change of tax code and the error should contain following message:\"#{_error_message_sales_inv_line_item}\""
			SF.click_button_cancel
			
			# verify edit if tax value is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_invoice_number , _posted_sales_invoice_number
			SIN.line_set_tax_value _line , _tax_value_50
			SF.click_button_save
			gen_include _error_message_sales_inv_line_item, FFA.get_error_message2, "Expected Sales Invoice should not get Saved/Posted with change of tax value and the error should contain following message:\"#{_error_message_sales_inv_line_item}\""
			SF.click_button_cancel
			
			# verify edit if income schedule is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_invoice_number , _posted_sales_invoice_number
			SIN.line_set_income_schedule  _line , "Monthly Spread"
			SF.click_button_save
			gen_include _error_message, FFA.get_error_message2, "Expected Sales Invoice should not get Saved/Posted with change of income schedule and the error should contain following message:\"#{_error_message_sales_inv_line_item}\""
			SF.click_button_cancel
			
			# verify edit if payment schedule is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_invoice_number , _posted_sales_invoice_number
			SIN.set_payment_schedule $bdu_payment_schedule_type_payment_schedule
			SIN.set_payment_schedule_number_of_payments 2
			SIN.click_calculate_payment_schedule_button
			SF.click_button_save
			gen_include _error_message, FFA.get_error_message2, "Expected Sales Invoice should not get Saved/Posted with change of payment schedule and the error should contain following message:\"#{_error_message}\""
			SF.click_button_cancel
			
			# verify edit if product dimension is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_invoice_number , _posted_sales_invoice_number
			FFA.click_product_toggle_icon _line
			SIN.line_set_product_dimensions _line, $sin_dimension_1_label, $bdu_dim1_usd
			SF.click_button_save
			gen_include _error_message_sales_inv_line_item, FFA.get_error_message2, "Expected Sales Invoice should not get Saved/Posted with change of product dimension and the error should contain following message:\"#{_error_message_sales_inv_line_item}\""
			SF.click_button_cancel
			
			# verify edit if product line description is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_invoice_number , _posted_sales_invoice_number
			FFA.click_product_toggle_icon _line
			SIN.line_set_product_line_description _line, _updated_product_line_description
			SF.click_button_save
			gen_include _error_message_sales_inv_line_item, FFA.get_error_message2, "Expected Sales Invoice should not get Saved/Posted with change of product line description and the error should contain following message:\"#{_error_message_sales_inv_line_item}\""
			SF.click_button_cancel
			
			# verify edit if account dimension1 is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_invoice_number , _posted_sales_invoice_number
			FFA.click_account_toggle_icon
			SIN.set_account_dimension $sin_dimension_1_label, $bdu_dim1_usd
			SF.click_button_save
			gen_include _error_message, FFA.get_error_message2, "Expected Sales Invoice should not get Saved/Posted with change of account dimension1 and the error should contain following message:\"#{_error_message}\""
			SF.click_button_cancel
			
			# verify edit if account dimension2 is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_invoice_number , _posted_sales_invoice_number
			FFA.click_account_toggle_icon
			SIN.set_account_dimension $sin_dimension_2_label, $bdu_dim2_usd
			SF.click_button_save
			gen_include _error_message, FFA.get_error_message2, "Expected Sales Invoice should not get Saved/Posted with change of account dimension2 and the error should contain following message:\"#{_error_message}\""
			SF.click_button_cancel
			
			# verify edit if account dimension3 is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_invoice_number , _posted_sales_invoice_number
			FFA.click_account_toggle_icon
			SIN.set_account_dimension $sin_dimension_3_label, $bdu_dim3_usd
			SF.click_button_save
			gen_include _error_message, FFA.get_error_message2, "Expected Sales Invoice should not get Saved/Posted with change of account dimension3 and the error should contain following message:\"#{_error_message}\""
			SF.click_button_cancel
			
			# verify edit if account dimension4 is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_invoice_number , _posted_sales_invoice_number
			FFA.click_account_toggle_icon
			SIN.set_account_dimension $sin_dimension_4_label, $bdu_dim4_usd
			SF.click_button_save
			gen_include _error_message, FFA.get_error_message2, "Expected Sales Invoice should not get Saved/Posted with change of account dimension4 and the error should contain following message:\"#{_error_message}\""
			SF.click_button_cancel
			
			# verify edit if Generate Adjustment Journal is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_invoice_number , _posted_sales_invoice_number
			SIN.set_generate_adjustment_journal_checkbox false
			SF.click_button_save
			gen_include _error_message, FFA.get_error_message2, "Expected Sales Invoice should not get Saved/Posted with change of generate adjustment journal and the error should contain following message:\"#{_error_message}\""
			SF.click_button_cancel
		end
		
		gen_start_test "TST015311 : Proper error message to be displayed on updating a 'Complete' status 'Sales Invoice' from list view with Edit page opening in Standard UI"
		begin
			SF.logout
			gen_start_test "Additional data required for TST015311"
			begin
				# set standard layout for sales invoice and line item
				SF.edit_extended_layout $ffa_object_sales_invoice, $ffa_profile_standard_user, $ffa_sales_invoice_extended_layout
				SF.object_button_edit $ffa_object_sales_invoice, $sf_edit_button
				SF.set_button_property_for_extended_layout
				SF.object_button_edit $ffa_object_sales_invoice, $sf_new_button
				SF.set_button_property_for_extended_layout
				SF.object_button_edit $ffa_object_sales_invoice, $sf_view_button
				SF.set_button_property_for_extended_layout
				SF.edit_extended_layout $ffa_object_sales_invoice_line_item, $ffa_profile_standard_user, $ffa_invoice_line_item_extended_layout
			end
			gen_end_test "Additional data required for TST015311"
			
			# login with accountant user
			SF.login_as_user SFACC_USER
			SF.tab $tab_sales_invoices
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			
			# verify edit if customer reference is updated
			FFA.click_edit_link_on_list_gird $label_invoice_number , _posted_sales_invoice_number
			SINX.set_customer_reference _customer_reference_headerRef_changed
			SF.click_button_save
			gen_include _error_message, FFA.get_error_message, "Expected Sales Invoice should not get Saved/Posted with change of customer reference and the error should contain following message:\"#{_error_message}\""
			SF.click_button_cancel
			
			# verify edit if invoice date is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_invoice_number , _posted_sales_invoice_number
			SINX.set_invoice_date _date_5_days_back
			SF.click_button_save
			gen_include _error_message, FFA.get_error_message, "Expected Sales Invoice should not get Saved/Posted with change of invoice date and the error should contain following message:\"#{_error_message}\""
			SF.click_button_cancel
			
			# verify edit if due date is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_invoice_number , _posted_sales_invoice_number
			SINX.set_due_date _date_5_days_back
			SF.click_button_save
			gen_include _error_message, FFA.get_error_message, "Expected Sales Invoice should not get Saved/Posted with change of due date and the error should contain following message:\"#{_error_message}\""
			SF.click_button_cancel
			
			# verify edit if period is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_invoice_number , _posted_sales_invoice_number
			FFA.select_period_from_lookup $sinx_period_lookup_icon, _period_8, $company_merlin_auto_spain
			SF.click_button_save
			gen_include _error_message, FFA.get_error_message, "Expected Sales Invoice should not get Saved/Posted with change of period and the error should contain following message:\"#{_error_message}\""
			SF.click_button_cancel
			
			# verify edit if shipping method is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_invoice_number , _posted_sales_invoice_number
			SINX.set_shipping_method $bdu_shipping_method_fedex
			SF.click_button_save
			gen_include _error_message, FFA.get_error_message, "Expected Sales Invoice should not get Saved/Posted with change of shipping method and the error should contain following message:\"#{_error_message}\""
			SF.click_button_cancel
			
			# verify edit if invoice description is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_invoice_number , _posted_sales_invoice_number
			SINX.set_invoice_description _invoice_updating_description
			SF.click_button_save
			gen_include _error_message, FFA.get_error_message, "Expected Sales Invoice should not get Saved/Posted with change of invoice description and the error should contain following message:\"#{_error_message}\""
			SF.click_button_cancel
			
			# verify edit if income schedule is updated	
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_invoice_number , _posted_sales_invoice_number
			SINX.set_income_schedule "Monthly Spread"
			SF.click_button_save
			gen_include _error_message, FFA.get_error_message, "Expected Sales Invoice should not get Saved/Posted with change of income schedule and the error should contain following message:\"#{_error_message}\""
			SF.click_button_cancel
			
			# verify edit if payment schedule is updated	
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_invoice_number , _posted_sales_invoice_number
			SINX.set_number_of_payments 2
			SF.click_button_save
			gen_include _error_message, FFA.get_error_message, "Expected Sales Invoice should not get Saved/Posted with change of payment schedule and the error should contain following message:\"#{_error_message}\""
			SF.click_button_cancel
			
			# verify edit if account dimension1 is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_invoice_number , _posted_sales_invoice_number
			SINX.set_account_dimension $sinx_dimension1_label, $bdu_dim1_usd
			SF.click_button_save
			gen_include _error_message, FFA.get_error_message, "Expected Sales Invoice should not get Saved/Posted with change of account dimension1 and the error should contain following message:\"#{_error_message}\""
			SF.click_button_cancel
			
			# verify edit if account dimension2 is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_invoice_number , _posted_sales_invoice_number
			SINX.set_account_dimension $sinx_dimension2_label, $bdu_dim2_usd
			SF.click_button_save
			gen_include _error_message, FFA.get_error_message, "Expected Sales Invoice should not get Saved/Posted with change of account dimension2 and the error should contain following message:\"#{_error_message}\""
			SF.click_button_cancel
			
			# verify edit if account dimension3 is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_invoice_number , _posted_sales_invoice_number
			SINX.set_account_dimension $sinx_dimension3_label, $bdu_dim3_usd
			SF.click_button_save
			gen_include _error_message, FFA.get_error_message, "Expected Sales Invoice should not get Saved/Posted with change of account dimension3 and the error should contain following message:\"#{_error_message}\""
			SF.click_button_cancel
			
			# verify edit if account dimension4 is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_invoice_number , _posted_sales_invoice_number
			SINX.set_account_dimension $sinx_dimension4_label, $bdu_dim4_usd
			SF.click_button_save
			gen_include _error_message, FFA.get_error_message, "Expected Sales Invoice should not get Saved/Posted with change of account dimension4 and the error should contain following message:\"#{_error_message}\""
			SF.click_button_cancel
			
			# verify edit if Generate Adjustment Journal is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_invoice_number , _posted_sales_invoice_number
			SINX.set_generate_adjustment_journal_checkbox false
			SF.click_button_save
			gen_include _error_message, FFA.get_error_message, "Expected Sales Invoice should not get Saved/Posted with change of generate adjustment journal and the error should contain following message:\"#{_error_message}\""
			SF.click_button_cancel
			
			# verify edit if product name is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go			
			SINX.open_invoice_detail_page _posted_sales_invoice_number
			SINX.click_sales_invoice_line_item_edit_link $bdu_product_auto_com_clutch_kit_1989_dodge_raider
			SINX.set_product_name $bdu_product_centric_rear_brake_hose_1987_1989_dodge_raider
			SF.click_button_save
			gen_include _error_message_sales_inv_line_item, FFA.get_error_message, "Expected Sales Invoice should not get Saved/Posted with change of product name and the error should contain following message:\"#{_error_message_sales_inv_line_item}\""
			SF.click_button_cancel
			
			# verify edit if product dimension is updated	
			SINX.click_sales_invoice_line_item_edit_link $bdu_product_auto_com_clutch_kit_1989_dodge_raider
			SINX.set_product_dimension $sinx_dimension1_label, $bdu_dim1_usd
			SF.click_button_save
			gen_include _error_message_sales_inv_line_item, FFA.get_error_message, "Expected Sales Invoice should not get Saved/Posted with change of product dimension and the error should contain following message:\"#{_error_message_sales_inv_line_item}\""
			SF.click_button_cancel
			
			# verify edit if product line description is updated	
			SINX.click_sales_invoice_line_item_edit_link $bdu_product_auto_com_clutch_kit_1989_dodge_raider
			SINX.set_product_line_description _updated_product_line_description
			SF.click_button_save
			gen_include _error_message_sales_inv_line_item, FFA.get_error_message, "Expected Sales Invoice should not get Saved/Posted with change of product line description and the error should contain following message:\"#{_error_message_sales_inv_line_item}\""
			SF.click_button_cancel
			
			# verify edit if quantity is updated	
			SINX.click_sales_invoice_line_item_edit_link $bdu_product_auto_com_clutch_kit_1989_dodge_raider
			SINX.set_product_quantity _quantity_2
			SF.click_button_save
			gen_include _error_message_sales_inv_line_item, FFA.get_error_message, "Expected Sales Invoice should not get Saved/Posted with change of quantity and the error should contain following message:\"#{_error_message_sales_inv_line_item}\""
			SF.click_button_cancel
			
			# verify edit if unit price is updated	
			SINX.click_sales_invoice_line_item_edit_link $bdu_product_auto_com_clutch_kit_1989_dodge_raider
			SINX.set_product_unit_price _unit_price_200
			SF.click_button_save
			gen_include _error_message_sales_inv_line_item, FFA.get_error_message, "Expected Sales Invoice should not get Saved/Posted with change of unit price and the error should contain following message:\"#{_error_message_sales_inv_line_item}\""
			SF.click_button_cancel
			
			# verify edit if tax code is updated	
			SINX.click_sales_invoice_line_item_edit_link $bdu_product_auto_com_clutch_kit_1989_dodge_raider
			SINX.set_tax_code $bdu_tax_code_vo_r_purchase
			SF.click_button_save
			gen_include _error_message_sales_inv_line_item, FFA.get_error_message, "Expected Sales Invoice should not get Saved/Posted with change of tax code and the error should contain following message:\"#{_error_message_sales_inv_line_item}\""
			SF.click_button_cancel
			
			# verify edit if tax value is updated	
			SINX.click_sales_invoice_line_item_edit_link $bdu_product_auto_com_clutch_kit_1989_dodge_raider
			SINX.set_product_tax_value _tax_value_50
			SF.click_button_save
			gen_include _error_message_sales_inv_line_item, FFA.get_error_message, "Expected Sales Invoice should not get Saved/Posted with change of tax value and the error should contain following message:\"#{_error_message_sales_inv_line_item}\""
			SF.click_button_cancel
		end
		
		gen_start_test "TST015312 : Sales Invoice with 'In Progress' Status can be updated successfully from List view."
		begin
			dimension_1 = 1
			dimension_2 = 2
			dimension_3 = 3
			dimension_4 = 4
			gen_start_test "Additional data required to set sales invoice layout to classic UI"
			begin
				SF.logout
				SF.edit_extended_layout $ffa_object_sales_invoice, $ffa_profile_standard_user, $ffa_sales_invoice_normal_layout
				SF.object_button_edit $ffa_object_sales_invoice, $sf_edit_button
				SF.choose_visualforce_page $ffa_vf_page_coda_invoice_edit
				SF.object_button_edit $ffa_object_sales_invoice, $sf_new_button
				SF.choose_visualforce_page $ffa_vf_page_coda_invoice_new
				SF.object_button_edit $ffa_object_sales_invoice, $sf_view_button
				SF.choose_visualforce_page $ffa_vf_page_coda_invoice_view
				SF.edit_extended_layout $ffa_object_sales_invoice_line_item, $ffa_profile_standard_user, $ffa_sales_invoice_line_item_normal_layout
			end
			gen_end_test "Additional data required to set sales invoice layout to classic UI"
			gen_start_test "Verification in classic view"
			begin
				SF.login_as_user SFACC_USER
				SF.tab $tab_sales_invoices
				SF.select_view $bdu_select_view_all
				SF.click_button_go
				FFA.click_edit_link_on_list_gird $label_invoice_number , _draft_sales_invoice_number
				gen_include _page_codainvoiceedit, current_url, "Expected Edit page #{_page_codainvoiceedit} should get opened"
				SIN.set_customer_reference _customer_reference_headerRef_changed
				SIN.set_invoice_date _date_5_days_back
				FFA.select_period_from_lookup $sin_period_lookup_icon, _period_8, $company_merlin_auto_spain
				SIN.select_shipping_method $bdu_shipping_method_fedex
				SIN.set_description _invoice_updating_description
				SIN.line_set_product_name _line , $bdu_product_centric_rear_brake_hose_1987_1989_dodge_raider
				SIN.line_set_quantity _line , _quantity_2
				SIN.line_set_unit_price _line , _unit_price_200
				SIN.line_set_tax_code _line , $bdu_tax_code_vo_r_purchase
				SIN.line_set_tax_value _line , _tax_value_50
				SIN.line_set_income_schedule  _line , "Monthly Spread"
				SIN.set_payment_schedule $bdu_payment_schedule_type_payment_schedule
				SIN.set_payment_schedule_number_of_payments 2
				SIN.click_calculate_payment_schedule_button
				FFA.click_product_toggle_icon _line
				SIN.line_set_product_dimensions _line, $sin_dimension_1_label, $bdu_dim1_usd
				SIN.line_set_product_line_description _line, _updated_product_line_description
				FFA.click_product_toggle_icon _line
				FFA.click_account_toggle_icon
				SIN.set_account_dimension $sin_dimension_1_label, $bdu_dim1_usd
				SIN.set_account_dimension $sin_dimension_2_label, $bdu_dim2_usd
				SIN.set_account_dimension $sin_dimension_3_label, $bdu_dim3_usd
				SIN.set_account_dimension $sin_dimension_4_label, $bdu_dim4_usd
				FFA.click_account_toggle_icon
				SIN.set_generate_adjustment_journal_checkbox false
				SF.click_button_save
				_prod_name = SIN.line_get_product_name _line
				_quantity = SIN.line_get_quantity _line
				_unit_price = SIN.line_get_unit_price _line
				_tax_code = SIN.line_get_tax_code _line
				_tax_value = SIN.line_get_tax_value _line
				gen_compare _customer_reference_headerRef_changed, SIN.get_customer_reference, "Expected Sales Invoice to be Saved successfully with the new value of customer reference"
				gen_compare _date_5_days_back, SIN.get_invoice_date, "Expected Sales Invoice to be Saved successfully with the new value of invoice date"
				gen_compare $bdu_payment_schedule_type_payment_schedule, SIN.get_due_date, "Expected Sales Invoice to be Saved successfully with the new value of due date"
				gen_compare _period_8, SIN.get_invoice_period_after_save, "Expected Sales Invoice to be Saved successfully with the new value of period"
				gen_compare $bdu_shipping_method_fedex, SIN.get_shipping_method, "Expected Sales Invoice to be Saved successfully with the new value of shipping method"
				gen_compare _invoice_updating_description, SIN.get_invoice_description, "Expected Sales Invoice to be Saved successfully with the new value of invoice description"
				gen_compare "Not Checked", SIN.get_generate_adjustment_journal, "Expected Sales Invoice to be Saved successfully with the new value of generate adjustment journal"
				gen_compare $bdu_product_centric_rear_brake_hose_1987_1989_dodge_raider, _prod_name, "Expected Sales Invoice to be Saved successfully with the new value of product"
				gen_compare _quantity_2, _quantity, "Expected Sales Invoice to be Saved successfully with the new value of quantity"
				gen_compare "200", _unit_price, "Expected Sales Invoice to be Saved successfully with the new value of unit price"
				gen_compare $bdu_tax_code_vo_r_purchase, _tax_code, "Expected Sales Invoice to be Saved successfully with the new value of tax code"
				gen_compare _tax_value_50, _tax_value, "Expected Sales Invoice to be Saved successfully with the new value of tax value"
				gen_compare $bdu_payment_schedule_type_payment_schedule, SIN.get_payment_schedule, "Expected Sales Invoice to be Saved successfully with the new value of payment schedule"
				gen_compare "Monthly Spread", SIN.get_income_schedule, "Expected Sales Invoice to be Saved successfully with the new value of income schedule"
				FFA.click_product_toggle_icon _line
				_product_dimension_1 = SIN.get_product_dimension _line, $sin_dimension_1_label
				_line_desc = SIN.get_product_line_description _line
				gen_compare $bdu_dim1_usd, _product_dimension_1, "Expected Sales Invoice to be Saved successfully with the new value of product dimension"
				gen_compare _updated_product_line_description, _line_desc, "Expected Sales Invoice to be Saved successfully with the new value of line description"
				FFA.click_product_toggle_icon _line
				FFA.click_account_toggle_icon
				_account_dimension_1 = SIN.get_invoice_account_dimension dimension_1
				_account_dimension_2 = SIN.get_invoice_account_dimension dimension_2
				_account_dimension_3 = SIN.get_invoice_account_dimension dimension_3
				_account_dimension_4 = SIN.get_invoice_account_dimension dimension_4
				gen_compare $bdu_dim1_usd, _account_dimension_1, "Expected Sales Invoice to be Saved successfully with the new value of account dimension"
				gen_compare $bdu_dim2_usd, _account_dimension_2, "Expected Sales Invoice to be Saved successfully with the new value of account dimension"
				gen_compare $bdu_dim3_usd, _account_dimension_3, "Expected Sales Invoice to be Saved successfully with the new value of account dimension"
				gen_compare $bdu_dim4_usd, _account_dimension_4, "Expected Sales Invoice to be Saved successfully with the new value of account dimension"	
			end
		
			gen_start_test "Additional data required to set sales invoice layout to standard UI"
			begin
				SF.logout
				SF.edit_extended_layout $ffa_object_sales_invoice, $ffa_profile_standard_user, $ffa_sales_invoice_extended_layout
				SF.object_button_edit $ffa_object_sales_invoice, $sf_edit_button
				SF.set_button_property_for_extended_layout
				SF.object_button_edit $ffa_object_sales_invoice, $sf_new_button
				SF.set_button_property_for_extended_layout
				SF.object_button_edit $ffa_object_sales_invoice, $sf_view_button
				SF.set_button_property_for_extended_layout
				SF.edit_extended_layout $ffa_object_sales_invoice_line_item, $ffa_profile_standard_user, $ffa_invoice_line_item_extended_layout
			end
			gen_end_test "Additional data required to set sales invoice layout to standard UI"
			gen_start_test "Verification in standard view"
			begin
				SF.login_as_user SFACC_USER
				SF.tab $tab_sales_invoices
				SF.select_view $bdu_select_view_all
				SF.click_button_go
				
				# edit sales invoice which is in progress status
				FFA.click_edit_link_on_list_gird $label_invoice_number , _draft_sales_invoice_number
				SINX.set_customer_reference _customer_reference_revised_headerRef
				SINX.set_invoice_date _date_6_days_back
				FFA.select_period_from_lookup $sinx_period_lookup_icon, _period_7, $company_merlin_auto_spain
				SINX.set_shipping_method $bdu_shipping_method_mail
				SINX.set_generate_adjustment_journal_checkbox true
				SINX.set_income_schedule "Quarterly"
				SINX.set_number_of_payments 3
				SINX.set_payment_interval "Quarterly"
				SINX.set_invoice_description _invoice_updating_description_standard
				SINX.set_account_dimension $sinx_dimension1_label, $bdu_dim1_eur
				SINX.set_account_dimension $sinx_dimension2_label, $bdu_dim2_eur
				SINX.set_account_dimension $sinx_dimension3_label, $bdu_dim3_eur
				SINX.set_account_dimension $sinx_dimension4_label, $bdu_dim4_eur
				SF.click_button_save
				SF.select_view $bdu_select_view_all
				SF.click_button_go
				SINX.open_invoice_detail_page _draft_sales_invoice_number
				_account_dimension_1 = SINX.get_account_dimension $sinx_dimension1_label
				_account_dimension_2 = SINX.get_account_dimension $sinx_dimension2_label
				_account_dimension_3 = SINX.get_account_dimension $sinx_dimension3_label
				_account_dimension_4 = SINX.get_account_dimension $sinx_dimension4_label
				gen_compare _customer_reference_revised_headerRef, SINX.get_customer_reference_number, "Expected Sales Invoice to be Saved successfully with the new value of customer reference"
				gen_compare _date_6_days_back, SINX.get_invoice_date, "Expected Sales Invoice to be Saved successfully with the new value of invoice date"
				gen_compare _period_7, SINX.get_sales_invoice_period, "Expected Sales Invoice to be Saved successfully with the new value of period"
				gen_compare $bdu_shipping_method_mail, SINX.get_shipping_method, "Expected Sales Invoice to be Saved successfully with the new value of shipping method"
				gen_compare "Checked", SINX.get_generate_adjustment_journal, "Expected Sales Invoice to be Saved successfully with the new value of generate adjustment journal"
				gen_compare _invoice_updating_description_standard, SINX.get_invoice_description, "Expected Sales Invoice to be Saved successfully with the new value of description"
				gen_compare "Quarterly", SINX.get_income_schedule, "Expected Sales Invoice to be Saved successfully with the new value of income schedule"
				gen_compare "3", SINX.get_number_of_payments, "Expected Sales Invoice to be Saved successfully with the new value of number of payments"
				gen_compare $bdu_dim1_eur, _account_dimension_1, "Expected Sales Invoice to be Saved successfully with the new value of account dimension1 "
				gen_compare $bdu_dim2_eur, _account_dimension_2, "Expected Sales Invoice to be Saved successfully with the new value of account dimension 2"
				gen_compare $bdu_dim3_eur, _account_dimension_3, "Expected Sales Invoice to be Saved successfully with the new value of account dimension 3"
				gen_compare $bdu_dim4_eur, _account_dimension_4, "Expected Sales Invoice to be Saved successfully with the new value of account dimension 4"
				
				# edit sales invoice line item
				SINX.click_sales_invoice_line_item_edit_link $bdu_product_centric_rear_brake_hose_1987_1989_dodge_raider
				SINX.set_product_name $bdu_product_bbk_fuel_pump_power_plus_series_universal
				SINX.set_product_quantity 3
				SINX.set_product_unit_price "300.00"
				SINX.set_tax_code $bdu_tax_code_vo_s
				SINX.set_product_tax_value _tax_value_100
				SINX.set_product_dimension $sinx_dimension1_label, $bdu_dim1_eur
				SINX.set_product_line_description _revised_product_line_description
				SF.click_button_save
				SINX.click_sales_invoice_line_item_id $bdu_product_bbk_fuel_pump_power_plus_series_universal
				gen_compare $bdu_product_bbk_fuel_pump_power_plus_series_universal, SINX.get_product_name, "Expected Sales Invoice to be Saved successfully with the new value of product name"
				gen_compare "3.000000", SINX.get_quantity, "Expected Sales Invoice to be Saved successfully with the new value of quantity"
				gen_compare "300.000000000", SINX.get_unit_price, "Expected Sales Invoice to be Saved successfully with the new value of unit price"
				gen_compare $bdu_tax_code_vo_s, SINX.get_tax_code, "Expected Sales Invoice to be Saved successfully with the new value of tax code"
				gen_compare _tax_value_100, SINX.get_tax_value, "Expected Sales Invoice to be Saved successfully with the new value of tax value"
				gen_compare _revised_product_line_description, SINX.get_product_line_description, "Expected Sales Invoice to be Saved successfully with the new value of line description"
				_dimension_value = SINX.get_product_dimension $sinx_dimension1_label
				gen_compare $bdu_dim1_eur, _dimension_value, "Expected Sales Invoice to be Saved successfully with the new value of product dimension"
			end
		end
		gen_end_test "TID011973 : Update Sales Invoice using edit link from List view"
	end
	after :all do
		login_user
		# Delete Test Data
		FFA.delete_new_data_and_wait
		
		# revert sales invoice layout properties
		SF.edit_extended_layout $ffa_object_sales_invoice, $ffa_profile_standard_user, $ffa_sales_invoice_normal_layout
		SF.object_button_edit $ffa_object_sales_invoice, $sf_edit_button
		SF.choose_visualforce_page $ffa_vf_page_coda_invoice_edit
		SF.object_button_edit $ffa_object_sales_invoice, $sf_new_button
		SF.choose_visualforce_page $ffa_vf_page_coda_invoice_new
		SF.object_button_edit $ffa_object_sales_invoice, $sf_view_button
		SF.choose_visualforce_page $ffa_vf_page_coda_invoice_view
		SF.edit_extended_layout $ffa_object_sales_invoice_line_item, $ffa_profile_standard_user, $ffa_sales_invoice_line_item_normal_layout
		# revert custom setting property
		SF.new_custom_setting $ffa_custom_setting_accounting_settings
		SF.set_custom_setting_property $ffa_accounting_settings_enable_edit_dimensions_after_posting, false
		SF.click_button_save
		SF.logout
		gen_end_test "UI Test - Accounting - Invoices : Edit from list view"
	end
end