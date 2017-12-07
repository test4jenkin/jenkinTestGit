require './helpers/config_helper.rb'
require './helpers/ffa_users.rb'
require './helpers/sf_helper.rb'
require './helpers/sfl_helper.rb'
require './helpers/account_helper.rb'
require './helpers/accounting_currency_helper.rb'
require './helpers/ffa_helper.rb'
require './helpers/ffa_uimap.rb'
require './helpers/dataview_helper.rb'
require './helpers/inquiry_template_helper.rb'
require './helpers/online_inquries_helper.rb'
require './helpers/gla_helper.rb'
require './helpers/company_helper.rb'
require './helpers/opportunity_helper.rb'
require './helpers/product_helper.rb'
require './helpers/salesinvoice_helper.rb'
require './helpers/creditnote_helper.rb'
require './helpers/sales_tax_calculation_settings_helper.rb'
require './helpers/allocations_helper.rb'
require './helpers/alloc_helper.rb'
require './helpers/income_schedule_helper.rb'
require './helpers/cashmatching_helper.rb'
require './helpers/bank_statement_helper.rb'
require './helpers/bank_account_helper.rb'
require './helpers/intercompanydefinition_helper.rb'
require './helpers/journal_helper.rb'
require './helpers/intercompanytransfer_helper.rb'
require './helpers/payableinvoice_helper.rb'
require './helpers/payablecreditnote_helper.rb'
require './helpers/transaction_helper.rb'
require './helpers/basedata_helper.rb'
require './helpers/subanalysismap_helper.rb'
require './helpers/avalara_helper.rb'
require './helpers/currencyrevaluation_helper.rb'
require './helpers/budgetandbalances_helper.rb'
require './helpers/paymentselection_helper.rb'
require './helpers/balanceupdates_helper.rb'
require './helpers/usercompany_helper.rb'
require './helpers/taxcode_helper.rb'
require './helpers/years_helper.rb'
require './helpers/payments_helper.rb'
require './helpers/allocation_scheduler_helper.rb'
require './helpers/cashentry_helper.rb'
require './helpers/quickstart_helper.rb'
require './helpers/intersect_definitions_helper.rb'
require './helpers/merge_accounts_helper.rb'
require './helpers/as_of_aging.rb'
require './helpers/allocation_template_helper.rb'
require './helpers/creditnote_ext_helper.rb'
require './helpers/salesinvoice_ext_helper.rb'
require './helpers/payableinvoice_ext_helper.rb'
require './helpers/payablecreditnote_ext_helper.rb'
require './helpers/intercompany_helper.rb'
require './helpers/backgroundmatching_helper.rb'
require './helpers/mailinator_helper.rb'
require './helpers/related_content_panes_helper.rb'
require './helpers/select_palette_section_helper.rb'
require './helpers/basedata_unmanaged_helper.rb'
require './helpers/bankreconciliation_helper.rb'
require './helpers/summarization_template_helper.rb'
require './helpers/contacts_helper.rb'
require './helpers/apex_helper.rb'
require './helpers/periods_helper.rb'
require './helpers/chatter_helper.rb'
require './helpers/cif_input_form_editor_helper.rb'
require './helpers/cif_helper.rb'
require './helpers/cif_uimap.rb'
require './helpers/cif_journal_helper.rb'
require './helpers/cif_input_form_manager_helper.rb'
require './helpers/cif_payable_invoice_helper.rb'
require './helpers/cif_sales_invoice_helper.rb'
require './helpers/cif_credit_note_helper.rb'
require './helpers/cif_payablecredit_note_helper.rb'
require './helpers/cif_cashentry_helper.rb'
require './helpers/selection_definition_helper.rb'
require './helpers/mass_email_helper.rb'
require './helpers/chart_of_accounts_mappings_helper.rb'
require './helpers/newpayments_helper.rb'
require './helpers/user_helper.rb'
require './helpers/myaccount_helper.rb'
require './helpers/dfp_helper.rb' 
require './helpers/sales_agreement.rb' 
require './helpers/dsm_mapping.rb'
require './helpers/myaccount_helper.rb' 
require './helpers/psa_helper.rb' 
require './helpers/region_helper.rb'
require './helpers/permission_control_helper.rb'
require './helpers/work_calendar_helper.rb'
require './helpers/dataloader_helper.rb'
require './helpers/project_helper.rb'
require './helpers/milestone_helper.rb'
require './helpers/misc_adjustment_helper.rb'
require './helpers/budget_helper.rb'
require './helpers/billingeventgenerate_helper.rb'
require './helpers/vendorinvoice_helper.rb'
require './helpers/billingevent_helper.rb'
require './helpers/lockbox_helper.rb'
require './helpers/transactionreconciliation_helper.rb'
require './helpers/cashentry_helper_extended.rb' 
require './helpers/chart_of_accounts_structure_helper.rb'
require './helpers/sales_order_process_helper.rb'
require './helpers/sales_order_quick_start_helper.rb'
require './helpers/bank_format_definition_helper.rb'
require './helpers/bank_format_mapping_helper.rb'
require './helpers/bank_format_export_import_helper.rb'
require './helpers/statistical_basis_helper.rb'
require './helpers/allocation_rules_helper.rb'
require './helpers/template_helper.rb'
require './helpers/recognition_year_helper.rb'
require './helpers/recognize_revenue_helper.rb'
require './helpers/setting_helper.rb'
require './helpers/action_queues_helper.rb'
require './helpers/avalara_settings_helper.rb'
require './helpers/avalara_tax_mapping_helper.rb'
require './helpers/product_group_helper.rb'
require './helpers/sales_order_helper.rb'
require './helpers/scm_product_mapping_helper.rb'
require './helpers/inventory_network_helper.rb'
require './helpers/invoicing_helper.rb'
require './helpers/document_helper.rb'
require './helpers/reports_helper.rb'
require './helpers/home_page_helper.rb'
require './helpers/journal_ext_helper.rb'
require './helpers/payments_detail_template_helper.rb'
require './helpers/erp_billingdocument_helper.rb'
require './helpers/feature_console_helper.rb'
require './helpers/erp_setup_helper.rb'
require './helpers/archiving_data_helper.rb'

$default_status_file_name="examples.txt"
STATUS_FILE = ENV['STATUS_FILE'] ? ENV['STATUS_FILE'] : $default_status_file_name
RSpec.configure do |config|
  config.pattern = '**/*.rb'
  config.example_status_persistence_file_path = STATUS_FILE
  config.run_all_when_everything_filtered = false
end
