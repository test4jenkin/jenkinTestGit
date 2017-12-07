#--------------------------------------------------------------------#
# TID : TID021225
# Product Area: Accounting - Payments Collections & Cash Entries
# Story: AC-9267
#--------------------------------------------------------------------#
describe "New Payment as of V16 - Print Checks", :type => :request do
	include_context "login"
	include_context "logout_after_each"
	before :all do
		gen_start_test  "TID021225"
		#Hold Base Data
		FFA.hold_base_data_and_wait
		_create_data = ["CODATID021225Data.selectCompany();", "CODATID021225Data.createData();", "CODATID021225Data.createDataExt1();"]
		_create_data+= ["CODATID021225Data.createDataExt2();", "CODATID021225Data.createDataExt3();"]
		_create_data+= ["CODATID021225Data.createDataExt4();", "CODATID021225Data.createDataExt5();", "CODATID021225Data.createDataExt6();"]
		_create_data+= ["CODATID021225Data.createDataExt7();", "CODATID021225Data.createDataExt8();", "CODATID021225Data.createDataExt9();"]
		# Execute Commands
		APEX.execute_commands _create_data
	end

	it "Payment Plus- Opening payments with different Status", :unmanaged => true  do
		_PAYMENT_NAME='TID021225PAYMENT1';
		_PPLUS1_NEW='PPLUS1-NEW';
		_PPLUS2_PROPOSED ='PPLUS2-PROPOSED';
		_PPLUS3_MEDIAPREPARED=	'PPLUS3-MEDIAPREPARED';
		_PPLUS4_MEDIAPREPAREDERROR ='PPLUS4-MEDIAPREPAREDERROR';

		gen_start_test "1. TST036721 - Positive case - open a Payment Plus with Status New"
		begin
			puts "- Opening a payment in status NEW (Payment Details tab)"
			NEWPAY.open_payment_by_description _PPLUS1_NEW
			gen_wait_until_object $newpay_selecttrans_Toduedate_dataffid_access
			gen_compare("NEW", NEWPAY.get_proposal_status_value, $newpay_assert_output_text)
		end
		gen_end_test "TST036721 - Positive case - open a Payment Plus with Status New"

		gen_start_test "2. TST036722 - Positive case - open a Payment Plus with Status Proposed"
		begin
			puts "- Opening a payment in status PROPOSED (Payment Review tab)"
			NEWPAY.open_payment_by_description _PPLUS2_PROPOSED
 			gen_wait_until_object $newpay_review_edit_proposal_slider_dataffid
 			puts "Verify that Status at this stage is PROPOSED."
			gen_compare("PROPOSED", NEWPAY.get_proposal_status_value, $newpay_assert_output_text)
		end
		gen_end_test "TST036722 - Positive case - open a Payment Plus with Status Proposed"

		gen_start_test "3. TST036751 - Positive case - open a Payment Plus with Status Preparing Media Error"
		begin
			NEWPAY.open_payment_by_description _PPLUS4_MEDIAPREPAREDERROR
			gen_wait_until_object $newpay_review_edit_proposal_slider_dataffid
			NEWPAY.click_next_button
			puts "- Opening a payment in status PREPARING MEDIA ERROR (Payment Review tab)"
			NEWPAY.open_payment_by_description _PPLUS4_MEDIAPREPAREDERROR
			puts "Verify that Status is PREPARING MEDIA ERROR."
			gen_compare("PREPARING MEDIA ERROR", NEWPAY.get_proposal_status_value, $newpay_assert_output_text)
		end
		gen_end_test "TST036751 - Positive case - open a Payment Plus with Status Preparing Media Error"

		gen_start_test "4. TST036723 - Positive case - open a Payment Plus with Status Media Prepared"
		begin
			puts "- Opening a payment in status PREPARING MEDIA ERROR (Payment Review tab)"
			NEWPAY.open_payment_by_description _PPLUS3_MEDIAPREPARED
			gen_wait_until_object $newpay_checknumber_grid
			puts "Verify that Status at this stage is MEDIA PREPARED."
			gen_compare("MEDIA PREPARED", NEWPAY.get_proposal_status_value, $newpay_assert_output_text)
		end
		gen_end_test "TST036723 - Positive case - open a Payment Plus with Status Media Prepared"
end
	after :all do
		login_user
		# Delete Test Data
		_delete_data = ["CODATID021225Data.destroyData();"]
		APEX.execute_commands _delete_data
		FFA.delete_new_data_and_wait
		gen_end_test "TID021225"
		SF.logout
	end
end