#----------------------------------------------------------------#
# TIDS : TID016780 & TID016786
# Pre-Requisite: Org with FFA v14 deployed
# Product Area: Journals-CIF
#Story: CIF - Capybara Smoke Tests - Builder


#----------------------------------------------------------------#
describe "TID016786 - CIF Input Form Manager Test", :type => :request do
  # Log in to the org
  include_context "login"
  include_context "logout_after_each"
  # Name of form(s) used in this test
  __formName = "Capybara-Generated Journal Input" # Probably shouldn't be hardcoded, but it is for now
  __formNameEdited = "Capybara-Generated Journal Input (Edited)" # Probably shouldn't be hardcoded, but it is for now
  __clonedName = "Cloned Capybara-Generated Journal Input"

  it "TID016786-Create a new Journal Layout using the CIF Builder" do
    ###################
    # local variables #
    ###################
    # Fields to be added
    __headerFieldsAddArray = [ "Year", "Dual Rate","Company","Journal Rate" ] # Header fields to be added
    __totalsFieldsAddArray = ["Tax Total", "Taxable Value Total"] # Totals fields to be added
    __lineFieldsAddArray = ["Dimension 3", "Dimension 4", "Currency ISO Code"] # Line Items fields to be added
    __cloneFieldsAddArray = ["Year", "Group", "Discard Reason", "Created Date"]

    # Fields to be removed
    __headerFieldsRemoveArray = ["Dual Rate", "Year", "Taxable Value Total"]
	
	#"Product Analysis" field is removed from the below array as now fields are added to desired position not to the end as per story AC-3336
	# So field is now pushed to end thus not visible. Instead of this added "Dimension 4" field to test the coverage for this story.
    __lineFieldsRemoveArray = ["Product", "Dimension 4", "General Ledger Account", "Taxable Value", "Bank Account"]

    $expectedelementstart="//table/tbody/tr/td[2]/div[text()='"
    $expectedelementend="']"

    # select the accounting app and input form manager tab
    SF.app $accounting
    SF.tab $tab_input_form_manager

    #------------------------------------------------------------------------------#
    # Clean up - delete this form that will be created later, if it already exists #
    #------------------------------------------------------------------------------#

    # TST - Cleanup - in case these tests have been run and possibly failed before. Not an offical test step (TSTXXXX)
    #gen_start_test "Cleanup"
      # We are going to delete all the forms that are used in the following tests - if they already exist, which they
      # might if for some reason the previous run of this test was only partially successful.
    #  deleteFormsArray = IFM.check_if_forms_exist ([__formName, __formNameEdited, __clonedName])
      # IF the cloned form exists and/or if it is active
      # Deactivate the form that should have been activated in some test below
     # if (deleteFormsArray).include? __clonedName
     #   if IFM.check_if_active(__clonedName)
     #     IFM.deactivate(__clonedName)
     #   end
     # end

    # IF there is anything to delete, delete them.
    #if !(deleteFormsArray).empty?
    #  IFM.select_and_delete_forms(deleteFormsArray,"yes") # Do delete
    #end
    #gen_end_test "Cleanup"

    # TST024260 - Verify that a user can create a new journal layout using the CIF builder
    gen_start_test "TST024260 - Verify that a user can create a new journal layout using the CIF builder"
      # go to input form manager tab
    CIF_IFM.click_new_button
    CIF_IFM.newCIFLayout("Journal", "Input", "No")
    CIF_IFM.click_new_button
    CIF_IFM.newCIFLayout("Journal", "Input", "Yes")
      #gen_wait_more
    gen_end_test "TST024260 - Verify that a user can create a new journal layout using the CIF builder"

    # TST024527 - Verify that a user can Edit the new layout in the builder and save it successfully
    gen_start_test "TST024527 - Verify that a user can edit and save the new layout"
      # Make some changes to the layout and save it
    CIF_IFM.selectFields("Journal Header Items")
	
    CIF_IFM.drag_fields_on_layout(__headerFieldsAddArray, $cif_ifm_field_add, $cif_ifm_first_new_row, $cif_ifm_new_row_next)
	CIF_IFM.drag_fields_on_layout(__totalsFieldsAddArray, $cif_ifm_field_add, $cif_ifm_totals_next, nil)
    CIF.click_toggle_button #Added because firefox shrinks the window sometimes causing intermittent failure
    CIF_IFM.selectFields("Journal Line Items")
    CIF_IFM.drag_fields_on_layout(__lineFieldsAddArray, $cif_ifm_field_add, $cif_ifm_journal_line_headers, nil)
    CIF.click_toggle_button #Added because firefox shrinks the window sometimes causing intermittent failure
    CIF_IFM.verify_no_name_exception
    CIF_IFM.verify_save_success __formName
      expect(page).to have_xpath($expectedelementstart + __formName + $expectedelementend)#, visible: true)
      puts ("Form: #{__formName} saved successfully")

    gen_end_test "TST024527 - Verify that a user can edit and save the new layout"


    # TST024549 - Verify that a user can re-edit the new layout
    gen_start_test "TST024549 - Verify that a user can edit and save an existing layout"
      # Edit stuff, then save it again.
    CIF_IFM.select_and_edit_form(__formName)
    CIF_IFM.selectFields("Journal Header Items")
    CIF_IFM.drag_fields_on_layout(__headerFieldsRemoveArray, $cif_ifm_header_field_remove, $cif_ifm_drag_off, nil)
    CIF_IFM.selectFields("Journal Line Items")
      __manipulatedStrings = CIF_IFM.strip_spaces_from_strings __lineFieldsRemoveArray
    CIF_IFM.drag_fields_on_layout(__manipulatedStrings, $cif_ifm_line_field_remove, $cif_ifm_drag_off, nil)
    CIF_IFM.verify_save_success __formNameEdited
    expect(page).to have_xpath($expectedelementstart + __formNameEdited + $expectedelementend)#, visible: true)
      puts ("Form: #{__formNameEdited} saved successfully")
    gen_end_test "TST024549 - Verify that a user can edit and save an existing layout"


    # - Verify that a user can clone a layout
    gen_start_test "TST024748 - Verify that a user can clone an existing layout"
    CIF_IFM.select_and_clone_form __formNameEdited
    CIF_IFM.selectFields("Journal Header Items")
    CIF_IFM.drag_fields_on_layout(__cloneFieldsAddArray, $cif_ifm_field_add, $cif_ifm_first_new_row, $cif_ifm_new_row_next)
    CIF_IFM.verify_save_success __clonedName
      expect(page).to have_xpath($expectedelementstart + __clonedName + $expectedelementend)#, visible: true)
      puts ("Form: #{__clonedName} saved successfully")
    gen_end_test "TST024748 - Verify that a user can clone an existing layout"

    # - Verify that a user can activate a layout
    gen_start_test "TST024766 - Verify that a user can activate an existing layout"
    CIF_IFM.deselect_if_selected __formNameEdited # Required because it's still checked after cloning
    CIF_IFM.select_and_activate_form __clonedName, $company_merlin_auto_spain
      if CIF_IFM.check_if_active(__clonedName)
        puts ("Form: #{__clonedName} activated successfully")
      end
    gen_end_test "TST024766 - Verify that a user can activate an existing layout"

    # Verify that a user can deactivate and delete a layout
    gen_start_test "TST024771 - Verify that a user can deactivate and delete a layout"
    # IF we get this far, then we should be confident that the following will work without additional checks....
    # e.g. check if it's active first; it will be.
    CIF_IFM.deactivate(__clonedName)
    CIF_IFM.deselect_if_selected(__clonedName)
    CIF_IFM.select_and_delete_forms([__formNameEdited], "no")
    CIF_IFM.select_and_delete_forms([__formNameEdited], "yes")
      puts ("Deleted forms successfully, end of test!")
    gen_end_test "TST024771 - Verify that a user can deactivate and delete a layout"
  end

  after(:all) do
    puts ("After Hook: Cleanup/Delete any forms created during the test")
    login_user
	FFA.delete_new_data_and_wait
    SF.app $accounting
    SF.tab $tab_input_form_manager

    deleteFormsArray = CIF_IFM.check_if_forms_exist ([__formName, __formNameEdited, __clonedName])
      # IF the cloned form exists and/or if it is active
      # Deactivate the form that should have been activated in some test below
    if (deleteFormsArray).include? __clonedName
      if CIF_IFM.check_if_active(__clonedName)
        CIF_IFM.deactivate(__clonedName)
      end
    end
      # IF there is anything to delete, delete them.
    if !(deleteFormsArray).empty?
      CIF_IFM.select_and_delete_forms(deleteFormsArray,"yes") # Do delete
    end
    CIF.wait_for_loading_mask_to_complete 5
    expect(page).not_to have_xpath($expectedelementstart + __formName + $expectedelementend)
    expect(page).not_to have_xpath($expectedelementstart + __formNameEdited + $expectedelementend)
    expect(page).not_to have_xpath($expectedelementstart + __clonedName + $expectedelementend)
    puts ("After Hook: All forms cleaned up ok")
  end

end
