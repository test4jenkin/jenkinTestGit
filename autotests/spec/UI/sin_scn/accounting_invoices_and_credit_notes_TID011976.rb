#--------------------------------------------------------------------#
#	TID : TID011976
# 	Pre-Requisite : 
#  	Product Area: Accounting - Invoices & Credit Notes (UI Test)
# 	Story: 25719
#--------------------------------------------------------------------#


describe "UI Test - Accounting - Sales Credit Notes : Edit from list view", :type => :request do
include_context "login"
include_context "logout_after_each"
	before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait
		gen_start_test "UI Test - Accounting - Sales Credit Notes : Edit from list view"
	end
		
	it "TID011976 : Update Sales Credit Note using edit link from List view" do
		gen_start_test "TID011976 : Update Sales Credit Note using edit link from List view"
		_line = 1
		_error_message_credit_note = "Sales Credit Note: Object validation has failed. Posted or discarded credit notes cannot be modified."
		_error_message_line_item = "Sales Credit Note Line Item: Object validation has failed. Posted or discarded credit notes cannot be modified."
		_date_5_days_back = (Time.now-5*24*60*60).strftime("%-m/%-d/%Y")
		_date_6_days_back = (Time.now-6*24*60*60).strftime("%-m/%-d/%Y")
		_unit_price_100 = "100.00"
		_unit_price_200 = "200.00"
		_customer_reference_headerRef = "HeaderRef"
		_customer_reference_headerRef_changed = "HeaderRef changed"
		_customer_reference_revised_headerRef = "Revised HeaderRef"
		_credit_note_description = "Description"
		_credit_note_updating_description = "Updating Description"
		_credit_note_updating_description_standard = "Updating Description in standard UI"
		_quantity_2 = "2"
		_tax_value_50 = "50.00" 
		_tax_value_100 = "100.00"
		_period_7 = "2015/007"
		_period_8 = "2015/008"
		_page_codacreditnoteedit = "codacreditnoteedit"
		
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_spain] ,true
		
		gen_start_test "Additional data required for TID011976"
		begin
			# set classic layout for sales credit note
			SF.edit_extended_layout $ffa_object_sales_credit_note, $ffa_profile_standard_user, $ffa_sales_credit_note_normal_layout
			
			# set button properties for sales credit note buttons
			SF.object_button_edit $ffa_object_sales_credit_note, $sf_edit_button
			SF.choose_visualforce_page $ffa_vf_page_coda_creditnote_edit
			SF.object_button_edit $ffa_object_sales_credit_note, $sf_new_button
			SF.choose_visualforce_page $ffa_vf_page_coda_creditnote_new
			SF.object_button_edit $ffa_object_sales_credit_note, $sf_view_button
			SF.choose_visualforce_page $ffa_vf_page_coda_creditnote_view
			
			# set classic layout for sales credit note line item
			SF.edit_extended_layout $ffa_object_sales_credit_note_line_item, $ffa_profile_standard_user, $ffa_sales_credit_note_line_items_normal_layout
			
			# set custom setting property
			SF.new_custom_setting $ffa_custom_setting_accounting_settings
			SF.set_custom_setting_property $ffa_accounting_settings_enable_edit_dimensions_after_posting, true
			SF.click_button_save
			
			# login with accountant user
			SF.login_as_user SFACC_USER
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_spain] ,true
			
			# creating sales credit note with complete status
			SF.tab $tab_sales_credit_notes
			SF.click_button_new
			SCR.set_account $bdu_account_cambridge_auto
			FFA.click_account_toggle_icon
			SCR.set_account_dimension $scn_dimension_1_label, $bdu_dim1_new_york
			SCR.set_account_dimension $scn_dimension_2_label, $bdu_dim2_dodge_uk
			SCR.set_account_dimension $scn_dimension_3_label, $bdu_dim3_sales_gbp
			SCR.set_account_dimension $scn_dimension_4_label, $bdu_dim4_harrogate
			FFA.click_account_toggle_icon
			SCR.set_customer_reference _customer_reference_headerRef
			SCR.set_description _credit_note_description
			FFA.click_new_line
			SCR.line_set_product_name _line, $bdu_product_auto_com_clutch_kit_1989_dodge_raider
			SCR.line_set_unit_price _line , _unit_price_100
			FFA.click_save_post
			_posted_sales_credit_note_number = SCR.get_credit_note_number
			
			# creating sales credit note with in progress status

			SF.tab $tab_sales_credit_notes
			SF.click_button_new
			SCR.set_account $bdu_account_cambridge_auto
			FFA.click_account_toggle_icon
			SCR.set_account_dimension $scn_dimension_1_label, $bdu_dim1_new_york
			SCR.set_account_dimension $scn_dimension_2_label, $bdu_dim2_dodge_uk
			SCR.set_account_dimension $scn_dimension_3_label, $bdu_dim3_sales_gbp
			SCR.set_account_dimension $scn_dimension_4_label, $bdu_dim4_harrogate
			FFA.click_account_toggle_icon
			SCR.set_customer_reference _customer_reference_headerRef
			SCR.set_description _credit_note_description
			FFA.click_new_line
			SCR.line_set_product_name _line, $bdu_product_auto_com_clutch_kit_1989_dodge_raider
			SCR.line_set_unit_price _line , _unit_price_100
			SF.click_button_save
			_draft_sales_credit_note_number = SCR.get_credit_note_number
		end

		gen_start_test "TST015313 : Proper error message to be diaplyed on updating a 'Complete' status 'Sales Credit Note' from list view with Edit page opening in Classic UI"
		begin
			SF.tab $tab_sales_credit_notes
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_credit_note_number , _posted_sales_credit_note_number
			gen_include _page_codacreditnoteedit, current_url, "Expected Edit page #{_page_codacreditnoteedit} should get opened"
			
			# verify edit if customer reference is updated
			SCR.set_customer_reference _customer_reference_headerRef_changed
			SF.click_button_save
			gen_include _error_message_credit_note, FFA.get_error_message, "Expected Sales Credit note should not get Saved/Posted with change of customer reference and the error should contain following message:\"#{_error_message_credit_note}\""
			SF.click_link $scn_back_to_list_sales_credit_notes
			
			# verify edit if credit note date is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_credit_note_number , _posted_sales_credit_note_number
			SCR.set_creditnote_date _date_5_days_back
			SF.click_button_save
			gen_include _error_message_credit_note, FFA.get_error_message, "Expected Sales Credit note should not get Saved/Posted with change of credit note date and the error should contain following message:\"#{_error_message_credit_note}\""
			SF.click_link $scn_back_to_list_sales_credit_notes
			
			# verify edit if due date is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_credit_note_number , _posted_sales_credit_note_number
			SCR.set_due_date _date_5_days_back
			SF.click_button_save
			gen_include _error_message_credit_note, FFA.get_error_message, "Expected Sales Credit note should not get Saved/Posted with change of due date and the error should contain following message:\"#{_error_message_credit_note}\""
			SF.click_link $scn_back_to_list_sales_credit_notes
			
			# verify edit if period is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_credit_note_number , _posted_sales_credit_note_number
			FFA.select_period_from_lookup $scn_period_lookup_icon, _period_8, $company_merlin_auto_spain
			SF.click_button_save
			gen_include _error_message_credit_note, FFA.get_error_message, "Expected Sales Credit note should not get Saved/Posted with change of period and the error should contain following message:\"#{_error_message_credit_note}\""
			SF.click_link $scn_back_to_list_sales_credit_notes
			
			# verify edit if credit note reason is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_credit_note_number , _posted_sales_credit_note_number
			SCR.select_reason $bdu_credit_note_reason_incorrect_shipment
			SF.click_button_save
			gen_include _error_message_credit_note, FFA.get_error_message, "Expected Sales Credit note should not get Saved/Posted with change of credit note reason and the error should contain following message:\"#{_error_message_credit_note}\""
			SF.click_link $scn_back_to_list_sales_credit_notes
			
			# verify edit if Credit Note description is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_credit_note_number , _posted_sales_credit_note_number
			SCR.set_description _credit_note_updating_description
			SF.click_button_save
			gen_include _error_message_credit_note, FFA.get_error_message, "Expected Sales Credit note should not get Saved/Posted with change of credit note description and the error should contain following message:\"#{_error_message_credit_note}\""
			SF.click_link $scn_back_to_list_sales_credit_notes
			
			# verify edit if product name is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_credit_note_number , _posted_sales_credit_note_number
			SCR.line_set_product_name _line , $bdu_product_centric_rear_brake_hose_1987_1989_dodge_raider
			SF.click_button_save
			gen_include _error_message_line_item, FFA.get_error_message, "Expected Sales Credit note should not get Saved/Posted with change of product name and the error should contain following message:\"#{_error_message_line_item}\""
			SF.click_link $scn_back_to_list_sales_credit_notes
			
			# verify edit if quantity is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_credit_note_number , _posted_sales_credit_note_number
			SCR.line_set_quantity _line , _quantity_2
			SF.click_button_save
			gen_include _error_message_line_item, FFA.get_error_message, "Expected Sales Credit note should not get Saved/Posted with change of quantity and the error should contain following message:\"#{_error_message_line_item}\""
			SF.click_link $scn_back_to_list_sales_credit_notes
			
			# verify edit if unit price is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_credit_note_number , _posted_sales_credit_note_number
			SCR.line_set_unit_price _line , _unit_price_200
			SF.click_button_save
			gen_include _error_message_line_item, FFA.get_error_message, "Expected Sales Credit note should not get Saved/Posted with change of unit price and the error should contain following message:\"#{_error_message_line_item}\""
			SF.click_link $scn_back_to_list_sales_credit_notes
			
			# verify edit if tax code is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_credit_note_number , _posted_sales_credit_note_number
			SCR.line_set_tax_code _line , $bdu_tax_code_vo_r_purchase
			SF.click_button_save
			gen_include _error_message_line_item, FFA.get_error_message, "Expected Sales Credit note should not get Saved/Posted with change of tax code and the error should contain following message:\"#{_error_message_line_item}\""
			SF.click_link $scn_back_to_list_sales_credit_notes
			
			# verify edit if tax value is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_credit_note_number , _posted_sales_credit_note_number
			SCR.line_set_tax_value _line , _tax_value_50
			SF.click_button_save
			gen_include _error_message_line_item, FFA.get_error_message, "Expected Sales Credit note should not get Saved/Posted with change of tax value and the error should contain following message:\"#{_error_message_line_item}\""
			SF.click_link $scn_back_to_list_sales_credit_notes
			
			# verify edit if account dimension1 is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_credit_note_number , _posted_sales_credit_note_number
			FFA.click_account_toggle_icon
			SCR.set_account_dimension $scn_dimension_1_label, $bdu_dim1_usd
			SF.click_button_save
			gen_include _error_message_credit_note, FFA.get_error_message, "Expected Sales Credit note should not get Saved/Posted with change of account dimension1 and the error should contain following message:\"#{_error_message_credit_note}\""
			SF.click_link $scn_back_to_list_sales_credit_notes
			
			# verify edit if account dimension2 is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_credit_note_number , _posted_sales_credit_note_number
			FFA.click_account_toggle_icon
			SCR.set_account_dimension $scn_dimension_2_label, $bdu_dim2_usd
			SF.click_button_save
			gen_include _error_message_credit_note, FFA.get_error_message, "Expected Sales Credit note should not get Saved/Posted with change of account dimension2 and the error should contain following message:\"#{_error_message_credit_note}\""
			SF.click_link $scn_back_to_list_sales_credit_notes
			
			# verify edit if account dimension3 is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_credit_note_number , _posted_sales_credit_note_number
			FFA.click_account_toggle_icon
			SCR.set_account_dimension $scn_dimension_3_label, $bdu_dim3_usd
			SF.click_button_save
			gen_include _error_message_credit_note, FFA.get_error_message, "Expected Sales Credit note should not get Saved/Posted with change of account dimension3 and the error should contain following message:\"#{_error_message_credit_note}\""
			SF.click_link $scn_back_to_list_sales_credit_notes
			
			# verify edit if account dimension4 is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_credit_note_number , _posted_sales_credit_note_number
			FFA.click_account_toggle_icon
			SCR.set_account_dimension $scn_dimension_4_label, $bdu_dim4_usd
			SF.click_button_save
			gen_include _error_message_credit_note, FFA.get_error_message, "Expected Sales Credit note should not get Saved/Posted with change of account dimension4 and the error should contain following message:\"#{_error_message_credit_note}\""
			SF.click_link $scn_back_to_list_sales_credit_notes
		end
		
		gen_start_test "TST015314 : Proper error message to be displayed on updating a 'Complete' status 'Sales Credit Note' from list view with Edit page opening in Standard UI"
		begin
			SF.logout
			gen_start_test "Additional data required for TST015314"
			begin
				# set standard layout for sales credit note and line item
				SF.edit_extended_layout $ffa_object_sales_credit_note, $ffa_profile_standard_user, $ffa_sales_credit_note_extended_layout
				SF.object_button_edit $ffa_object_sales_credit_note, $sf_edit_button
				SF.set_button_property_for_extended_layout
				SF.object_button_edit $ffa_object_sales_credit_note, $sf_new_button
				SF.set_button_property_for_extended_layout
				SF.object_button_edit $ffa_object_sales_credit_note, $sf_view_button
				SF.set_button_property_for_extended_layout
				SF.edit_extended_layout $ffa_object_sales_credit_note_line_item, $ffa_profile_standard_user, $ffa_credit_note_line_item_extended_layout
			end
			gen_end_test "Additional data required for TST015314"
			# login with accountant user
			SF.login_as_user SFACC_USER
			SF.tab $tab_sales_credit_notes
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			
			# verify edit if customer reference is updated
			FFA.click_edit_link_on_list_gird $label_credit_note_number , _posted_sales_credit_note_number
			SCRX.set_customer_reference _customer_reference_headerRef_changed
			SF.click_button_save
			gen_include _error_message_credit_note, FFA.get_error_message, "Expected Sales Credit note should not get Saved/Posted with change of customer reference and the error should contain following message:\"#{_error_message_credit_note}\""
			SF.click_button_cancel
			
			# verify edit if credit note date is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_credit_note_number , _posted_sales_credit_note_number
			SCRX.set_creditnote_date _date_5_days_back
			SF.click_button_save
			gen_include _error_message_credit_note, FFA.get_error_message, "Expected Sales Credit note should not get Saved/Posted with change of credit note date and the error should contain following message:\"#{_error_message_credit_note}\""
			SF.click_button_cancel
			
			# verify edit if due date is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_credit_note_number , _posted_sales_credit_note_number
			SCRX.set_due_date _date_5_days_back
			SF.click_button_save
			gen_include _error_message_credit_note, FFA.get_error_message, "Expected Sales Credit note should not get Saved/Posted with change of due date and the error should contain following message:\"#{_error_message_credit_note}\""
			SF.click_button_cancel
			
			# verify edit if period is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_credit_note_number , _posted_sales_credit_note_number
			FFA.select_period_from_lookup $scrx_period_lookup_icon, _period_8, $company_merlin_auto_spain
			SF.click_button_save
			gen_include _error_message_credit_note, FFA.get_error_message, "Expected Sales Credit note should not get Saved/Posted with change of period and the error should contain following message:\"#{_error_message_credit_note}\""
			SF.click_button_cancel
			
			# verify edit if credit note reason is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_credit_note_number , _posted_sales_credit_note_number
			SCRX.set_credit_note_reason $bdu_credit_note_reason_incorrect_shipment
			SF.click_button_save
			gen_include _error_message_credit_note, FFA.get_error_message, "Expected Sales Credit note should not get Saved/Posted with change of credit note reason and the error should contain following message:\"#{_error_message_credit_note}\""
			SF.click_button_cancel
			
			# verify edit if credit note description is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_credit_note_number , _posted_sales_credit_note_number
			SCRX.set_credit_note_description _credit_note_updating_description
			SF.click_button_save
			gen_include _error_message_credit_note, FFA.get_error_message, "Expected Sales Credit note should not get Saved/Posted with change of credit note description and the error should contain following message:\"#{_error_message_credit_note}\""
			SF.click_button_cancel
			
			# verify edit if account dimension1 is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_credit_note_number , _posted_sales_credit_note_number
			SCRX.set_account_dimension $scrx_dimension_1_label, $bdu_dim1_usd
			SF.click_button_save
			gen_include _error_message_credit_note, FFA.get_error_message, "Expected Sales Credit note should not get Saved/Posted with change of account dimension1 and the error should contain following message:\"#{_error_message_credit_note}\""
			SF.click_button_cancel
			
			# verify edit if account dimension2 is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_credit_note_number , _posted_sales_credit_note_number
			SCRX.set_account_dimension $scrx_dimension_2_label, $bdu_dim2_usd
			SF.click_button_save
			gen_include _error_message_credit_note, FFA.get_error_message, "Expected Sales Credit note should not get Saved/Posted with change of account dimension2 and the error should contain following message:\"#{_error_message_credit_note}\""
			SF.click_button_cancel
			
			# verify edit if account dimension3 is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_credit_note_number , _posted_sales_credit_note_number
			SCRX.set_account_dimension $scrx_dimension_3_label, $bdu_dim3_usd
			SF.click_button_save
			gen_include _error_message_credit_note, FFA.get_error_message, "Expected Sales Credit note should not get Saved/Posted with change of account dimension3 and the error should contain following message:\"#{_error_message_credit_note}\""
			SF.click_button_cancel
			
			# verify edit if account dimension4 is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_credit_note_number , _posted_sales_credit_note_number
			SCRX.set_account_dimension $scrx_dimension_4_label, $bdu_dim4_usd
			SF.click_button_save
			gen_include _error_message_credit_note, FFA.get_error_message, "Expected Sales Credit note should not get Saved/Posted with change of account dimension4 and the error should contain following message:\"#{_error_message_credit_note}\""
			SF.click_button_cancel
			
			#verify edit if product name is updated
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			SCRX.open_credit_note_detail_page _posted_sales_credit_note_number
			SCRX.click_credit_note_line_item_edit_link $bdu_product_auto_com_clutch_kit_1989_dodge_raider
			SCRX.set_product $bdu_product_centric_rear_brake_hose_1987_1989_dodge_raider
			SF.click_button_save
			gen_include _error_message_line_item, FFA.get_error_message, "Expected Sales Credit note should not get Saved/Posted with change of product name and the error should contain following message:\"#{_error_message_line_item}\""
			SF.click_button_cancel
			
			# verify edit if quantity is updated
			SCRX.click_credit_note_line_item_edit_link $bdu_product_auto_com_clutch_kit_1989_dodge_raider
			SCRX.set_quantity _quantity_2
			SF.click_button_save
			gen_include _error_message_line_item, FFA.get_error_message, "Expected Sales Credit note should not get Saved/Posted with change of quantity and the error should contain following message:\"#{_error_message_line_item}\""
			SF.click_button_cancel
			
			# verify edit if unit price is updated		
			SCRX.click_credit_note_line_item_edit_link $bdu_product_auto_com_clutch_kit_1989_dodge_raider
			SCRX.set_unit_price _unit_price_200
			SF.click_button_save
			gen_include _error_message_line_item, FFA.get_error_message, "Expected Sales Credit note should not get Saved/Posted with change of unit price and the error should contain following message:\"#{_error_message_line_item}\""
			SF.click_button_cancel
			
			# verify edit if tax code is updated
			SCRX.click_credit_note_line_item_edit_link $bdu_product_auto_com_clutch_kit_1989_dodge_raider
			SCRX.set_tax_code $bdu_tax_code_vo_r_purchase
			SF.click_button_save
			gen_include _error_message_line_item, FFA.get_error_message, "Expected Sales Credit note should not get Saved/Posted with change of tax code and the error should contain following message:\"#{_error_message_line_item}\""
			SF.click_button_cancel
			
			# verify edit if tax value is updated
			SCRX.click_credit_note_line_item_edit_link $bdu_product_auto_com_clutch_kit_1989_dodge_raider
			SCRX.set_tax_value _tax_value_50
			SF.click_button_save
			gen_include _error_message_line_item, FFA.get_error_message, "Expected Sales Credit note should not get Saved/Posted with change of tax value and the error should contain following message:\"#{_error_message_line_item}\""
			SF.click_button_cancel
		end
		
		gen_start_test "TST015315 : Sales Credit Note with 'In Progress' Status can be updated successfully from List view."
		begin
			dimension_1 = 1
			dimension_2 = 2
			dimension_3 = 3
			dimension_4 = 4
			gen_start_test "Additional data required to set credit note layout to classic UI"
			begin
				SF.logout
				SF.edit_extended_layout $ffa_object_sales_credit_note, $ffa_profile_standard_user, $ffa_sales_credit_note_normal_layout
				SF.object_button_edit $ffa_object_sales_credit_note, $sf_edit_button
				SF.choose_visualforce_page $ffa_vf_page_coda_creditnote_edit
				SF.object_button_edit $ffa_object_sales_credit_note, $sf_new_button
				SF.choose_visualforce_page $ffa_vf_page_coda_creditnote_new
				SF.object_button_edit $ffa_object_sales_credit_note, $sf_view_button
				SF.choose_visualforce_page $ffa_vf_page_coda_creditnote_view
				SF.edit_extended_layout $ffa_object_sales_credit_note_line_item, $ffa_profile_standard_user, $ffa_sales_credit_note_line_items_normal_layout
			end
			gen_end_test "Additional data required to set credit note layout to classic UI"
			SF.login_as_user SFACC_USER
			gen_start_test "Verification in classic view"
			begin
				SF.tab $tab_sales_credit_notes
				SF.select_view $bdu_select_view_all
				SF.click_button_go
				
				# edit sales credit note which is in progress status
				FFA.click_edit_link_on_list_gird $label_credit_note_number , _draft_sales_credit_note_number
				gen_include _page_codacreditnoteedit, current_url, "Expected Edit page #{_page_codacreditnoteedit} should get opened"
				SCR.set_customer_reference _customer_reference_headerRef_changed
				SCR.set_creditnote_date _date_5_days_back
				SCR.set_due_date _date_5_days_back
				FFA.select_period_from_lookup $scn_period_lookup_icon, _period_8, $company_merlin_auto_spain
				SCR.select_reason $bdu_credit_note_reason_incorrect_shipment
				SCR.set_description _credit_note_updating_description
				SCR.line_set_product_name _line , $bdu_product_centric_rear_brake_hose_1987_1989_dodge_raider
				SCR.line_set_quantity _line , _quantity_2
				SCR.line_set_unit_price _line , _unit_price_200
				SCR.line_set_tax_code _line , $bdu_tax_code_vo_r_purchase
				SCR.line_set_tax_value _line , _tax_value_50
				FFA.click_account_toggle_icon
				SCR.set_account_dimension $scn_dimension_1_label, $bdu_dim1_usd
				SCR.set_account_dimension $scn_dimension_2_label, $bdu_dim2_usd
				SCR.set_account_dimension $scn_dimension_3_label, $bdu_dim3_usd
				SCR.set_account_dimension $scn_dimension_4_label, $bdu_dim4_usd
				SF.click_button_save
				_prod_name = SCR.line_get_product_name _line
				_quantity = SCR.line_get_quantity _line
				_unit_price = SCR.line_get_unit_price _line
				_tax_code = SCR.line_get_tax_code _line
				_tax_value = SCR.line_get_tax_value _line
				gen_compare _customer_reference_headerRef_changed, SCR.get_customer_reference, "Expected Sales Credit note to be Saved successfully with the new value of customer reference"
				gen_compare _date_5_days_back, SCR.get_credit_note_date, "Expected Sales Credit note to be Saved successfully with the new value of credit note date"
				gen_compare _date_5_days_back, SCR.get_due_date, "Expected Sales Credit note to be Saved successfully with the new value of due date"
				gen_compare _period_8, SCR.get_credit_note_period, "Expected Sales Credit note to be Saved successfully with the new value of period"
				gen_compare $bdu_credit_note_reason_incorrect_shipment, SCR.get_credit_note_reason, "Expected Sales Credit note to be Saved successfully with the new value of credit note reason"
				gen_compare _credit_note_updating_description, SCR.get_credit_note_description, "Expected Sales Credit note to be Saved successfully with the new value of description"
				gen_compare $bdu_product_centric_rear_brake_hose_1987_1989_dodge_raider, _prod_name, "Expected Sales Credit note to be Saved successfully with the new value of product"
				gen_compare _quantity_2, _quantity, "Expected Sales Credit note to be Saved successfully with the new value of quantity"
				gen_compare "200", _unit_price, "Expected Sales Credit note to be Saved successfully with the new value of unit price"
				gen_compare $bdu_tax_code_vo_r_purchase, _tax_code, "Expected Sales Credit note to be Saved successfully with the new value of tax code"
				gen_compare _tax_value_50, _tax_value, "Expected Sales Credit note to be Saved successfully with the new value of tax value"
				FFA.click_account_toggle_icon
				_account_dimension_1 = SCR.get_credit_note_account_dimension dimension_1
				_account_dimension_2 = SCR.get_credit_note_account_dimension dimension_2
				_account_dimension_3 = SCR.get_credit_note_account_dimension dimension_3
				_account_dimension_4 = SCR.get_credit_note_account_dimension dimension_4
				gen_compare $bdu_dim1_usd, _account_dimension_1, "Expected Sales Credit note to be Saved successfully with the new value of account dimension 1"
				gen_compare $bdu_dim2_usd, _account_dimension_2, "Expected Sales Credit note to be Saved successfully with the new value of account dimension 2"
				gen_compare $bdu_dim3_usd, _account_dimension_3, "Expected Sales Credit note to be Saved successfully with the new value of account dimension 3"
				gen_compare $bdu_dim4_usd, _account_dimension_4, "Expected Sales Credit note to be Saved successfully with the new value of account dimension 4"
			end
			
			gen_start_test "Additional data required to set credit note layout to standard UI"
			begin
				SF.logout
				SF.edit_extended_layout $ffa_object_sales_credit_note, $ffa_profile_standard_user, $ffa_sales_credit_note_extended_layout
				SF.object_button_edit $ffa_object_sales_credit_note, $sf_edit_button
				SF.set_button_property_for_extended_layout
				SF.object_button_edit $ffa_object_sales_credit_note, $sf_new_button
				SF.set_button_property_for_extended_layout
				SF.object_button_edit $ffa_object_sales_credit_note, $sf_view_button
				SF.set_button_property_for_extended_layout
				SF.edit_extended_layout $ffa_object_sales_credit_note_line_item, $ffa_profile_standard_user, $ffa_credit_note_line_item_extended_layout
			end
			gen_end_test "Additional data required to set credit note layout to standard UI"
			gen_start_test "Verification in standard view"
			begin
				SF.login_as_user SFACC_USER
				SF.tab $tab_sales_credit_notes
				SF.select_view $bdu_select_view_all
				SF.click_button_go
				
				# edit credit note which is in progress status
				FFA.click_edit_link_on_list_gird $label_credit_note_number , _draft_sales_credit_note_number
				SCRX.set_customer_reference _customer_reference_revised_headerRef
				SCRX.set_creditnote_date _date_6_days_back
				SCRX.set_due_date _date_6_days_back
				FFA.select_period_from_lookup $scrx_period_lookup_icon, _period_7, $company_merlin_auto_spain
				SCRX.set_credit_note_reason $bdu_credit_note_reason_damaged_goods
				SCRX.set_credit_note_description _credit_note_updating_description_standard
				SCRX.set_account_dimension $scrx_dimension_1_label, $bdu_dim1_eur
				SCRX.set_account_dimension $scrx_dimension_2_label, $bdu_dim2_eur
				SCRX.set_account_dimension $scrx_dimension_3_label, $bdu_dim3_eur
				SCRX.set_account_dimension $scrx_dimension_4_label, $bdu_dim4_eur
				SF.click_button_save
				SF.select_view $bdu_select_view_all
				SF.click_button_go
				SCRX.open_credit_note_detail_page _draft_sales_credit_note_number
				_account_dimension_1 = SCRX.get_account_dimension $scrx_dimension_1_label
				_account_dimension_2 = SCRX.get_account_dimension $scrx_dimension_2_label
				_account_dimension_3 = SCRX.get_account_dimension $scrx_dimension_3_label
				_account_dimension_4 = SCRX.get_account_dimension $scrx_dimension_4_label
				gen_compare _customer_reference_revised_headerRef, SCRX.get_customer_reference_number, "Expected Sales Credit note to be Saved successfully with the new value of customer reference"
				gen_compare _date_6_days_back, SCRX.get_credit_note_date, "Expected Sales Credit note to be Saved successfully with the new value of credit note date"
				gen_compare _date_6_days_back, SCRX.get_due_date, "Expected Sales Credit note to be Saved successfully with the new value of due date"
				gen_compare _period_7, SCRX.get_credit_note_period, "Expected Sales Credit note to be Saved successfully with the new value of period"
				gen_compare $bdu_credit_note_reason_damaged_goods, SCRX.get_credit_note_reason, "Expected Sales Credit note to be Saved successfully with the new value of credit note reason"
				gen_compare _credit_note_updating_description_standard, SCRX.get_credit_note_description, "Expected Sales Credit note to be Saved successfully with the new value of description"
				gen_compare $bdu_dim1_eur, _account_dimension_1, "Expected Sales Credit note to be Saved successfully with the new value of account dimension1 "
				gen_compare $bdu_dim2_eur, _account_dimension_2, "Expected Sales Credit note to be Saved successfully with the new value of account dimension 2"
				gen_compare $bdu_dim3_eur, _account_dimension_3, "Expected Sales Credit note to be Saved successfully with the new value of account dimension 3"
				gen_compare $bdu_dim4_eur, _account_dimension_4, "Expected Sales Credit note to be Saved successfully with the new value of account dimension 3"
				
				# edit credit note line item
				SCRX.click_credit_note_line_item_edit_link $bdu_product_centric_rear_brake_hose_1987_1989_dodge_raider
				SCRX.set_product $bdu_product_bbk_fuel_pump_power_plus_series_universal
				SCRX.set_quantity 3
				SCRX.set_unit_price "300.00"
				SCRX.set_tax_code $bdu_tax_code_vo_s
				SCRX.set_tax_value _tax_value_100
				SF.click_button_save
				SCRX.click_credit_note_line_item_id $bdu_product_bbk_fuel_pump_power_plus_series_universal
				gen_compare $bdu_product_bbk_fuel_pump_power_plus_series_universal, SCRX.get_product_name, "Expected Sales Credit note to be Saved successfully with the new value of product name"
				gen_compare "3.000000", SCRX.get_quantity, "Expected Sales Credit note to be Saved successfully with the new value of quantity"
				gen_compare "300.000000000", SCRX.get_unit_price, "Expected Sales Credit note to be Saved successfully with the new value of unit price"
				gen_compare $bdu_tax_code_vo_s, SCRX.get_tax_code, "Expected Sales Credit note to be Saved successfully with the new value of tax code"
				gen_compare _tax_value_100, SCRX.get_tax_value, "Expected Sales Credit note to be Saved successfully with the new value of tax value"
			end
		end
		gen_end_test "TID011976 : Update Sales Credit Note using edit link from List view"
	end
	after :all do
		login_user
		# Delete Test Data
		FFA.delete_new_data_and_wait
		
		# revert sales credit note layout properties
		SF.edit_extended_layout $ffa_object_sales_credit_note, $ffa_profile_standard_user, $ffa_sales_credit_note_normal_layout
		SF.object_button_edit $ffa_object_sales_credit_note, $sf_edit_button
		SF.choose_visualforce_page $ffa_vf_page_coda_creditnote_edit
		SF.object_button_edit $ffa_object_sales_credit_note, $sf_new_button
		SF.choose_visualforce_page $ffa_vf_page_coda_creditnote_new
		SF.object_button_edit $ffa_object_sales_credit_note, $sf_view_button
		SF.choose_visualforce_page $ffa_vf_page_coda_creditnote_view
		SF.edit_extended_layout $ffa_object_sales_credit_note_line_item, $ffa_profile_standard_user, $ffa_sales_credit_note_line_items_normal_layout
		
		# revert custom setting property
		SF.new_custom_setting $ffa_custom_setting_accounting_settings
		SF.set_custom_setting_property $ffa_accounting_settings_enable_edit_dimensions_after_posting, false
		SF.click_button_save
		SF.logout
		gen_end_test "UI Test - Accounting - Credit Notes : Edit from list view"
	end
end