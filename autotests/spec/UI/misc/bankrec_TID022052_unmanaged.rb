#--------------------------------------------------------------------#
#   TID : TID022052
#   Pre-Requisite: Org with basedata deployed. Deploy CODATID000696Data.cls on org.
#   Product Area: Bank Reconciliation
#   Story: AC-13633
#--------------------------------------------------------------------#

_bank_statement_in_progress = "In progress"
_bank_statement_imported = "Imported"
_bank_statement_number = ""
_bank_statement_number_query = "SELECT id, Name FROM codaBankStatement__c WHERE Reference__c = 'TID000696#Santander Statement #001' LIMIT 1"

describe "This TID verifies the functionality of the bank statement reconciliation confirmation page ", :type => :request do
    include_context "login"
    include_context "logout_after_each"

    before :all do
        #Hold Base Data
        FFA.hold_base_data_and_wait
    end
		
    it "TID022052 - Bank Statement reconciliation confirmation", :unmanaged => true  do
        gen_start_test "TST039599 : Create a bank statement and ensure correct behaviour of the bank statement auto reconcile confirmation page."

        SF.app $accounting
        SF.tab $tab_select_company
        FFA.select_company [$company_merlin_auto_spain] ,true

        # 1.1 Data setup 
        puts "Step 1.1 Create bank statement"
        create_additional_data = ["CODATID000696Data.createData();"]
        APEX.execute_commands create_additional_data
        APEX.execute_soql _bank_statement_number_query
        bank_statement_number = APEX.get_field_value_from_soql_result("Name")

        #1.2
        begin
            SF.tab $tab_bank_statements
            SF.select_view $bd_select_view_all
            SF.click_button_go  
            BS.open_bank_statement_detail_page bank_statement_number
            bank_statement_status = BS.get_bank_statement_status
            gen_compare _bank_statement_imported , bank_statement_status , "Expected Bank statement status to be in imported. "
            BS.click_button_reconcile
            BS.click_button_reconcile_confirm
            SF.tab $tab_bank_statements
            SF.select_view $bd_select_view_all
            SF.click_button_go
            BS.open_bank_statement_detail_page bank_statement_number
            bank_statement_status = BS.get_bank_statement_status
            gen_compare _bank_statement_in_progress , bank_statement_status , "Expected Bank statement status to be in progress. "
        end

        #1.3
        begin
            BS.click_button_reconcile_skips_confirmation
            SF.tab $tab_bank_statements
            SF.select_view $bd_select_view_all
            SF.click_button_go
            BS.open_bank_statement_detail_page bank_statement_number
            bank_statement_status = BS.get_bank_statement_status
            gen_compare _bank_statement_in_progress , bank_statement_status , "Expected Bank statement status to be in progress. "
        end

        gen_end_test "TST039599 : Create a bank statement and ensure correct behaviour of the bank statement auto reconcile confirmation page."
        gen_end_test "TID022052 - Bank Statement reconciliation confirmation"
    end

    after :all do
        login_user
        FFA.delete_new_data_and_wait
        puts "Removing TID data"
        SF.retry_script_block do
            delete_data = ["CODATID000696Data.destroyData();"]
            APEX.execute_commands delete_data
        end
        SF.logout
    end
end