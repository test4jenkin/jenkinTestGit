#--------------------------------------------------------------------#
# TID : TID014058
# Pre-Requisit: Org with basedata deployed.Deploy CODATID014058Data.cls on org.
# Product Area: Intercompany
# Story: 24319
#--------------------------------------------------------------------#


describe "Intercompany Company Structure", :type => :request do

	def assert_node_menu
		expect(page).to have_content($INTERCOMPANY_MENU_OPTION_VIEW_COMPANY_DETAILS)
		expect(page).to have_content($INTERCOMPANY_MENU_OPTION_VIEW_ALL_COMPANY_SUBSIDIARIES)
		expect(page).to have_content($INTERCOMPANY_MENU_OPTION_VIEW_ALL_COMPANY_OWNERS)
	end

	def assert_empty_popup
		expect(find($intercompany_relations_popup_body)).not_to have_content('CUSTOMCO')
	end

	def wait_for_popup_rows_load expectedRows
		counter = 0
		while all($intercompany_relations_popup_row).length != expectedRows and counter <= DEFAULT_TIME_OUT do
			counter+=1
			sleep 1
		end
	end

	def wait_for_number_of_nodes expectedNumberOfNodes
		counter = 0
		while Intercompany.get_all_tree_nodes.length != expectedNumberOfNodes and counter <= DEFAULT_TIME_OUT do
			counter+=1
			sleep 1
		end
	end

	def wait_for_new_window
		counter = 0
		while windows.length != 2 and counter <= DEFAULT_TIME_OUT do
			counter+=1
			sleep 1
		end
	end
	include_context "login"
	include_context "logout_after_each"
	before(:all) do
		gen_start_test "TID014058"
		## Group Structure does a lot of asynchronous requests.
		## Let's be a little patient.
		$current_default_wait_time = Capybara.default_wait_time
		## We do not want to take hidden elements into account
		$current_ignore_hidden = Capybara.ignore_hidden_elements

		Capybara.default_wait_time = 10
		Capybara.ignore_hidden_elements = true
		create_basedata_for_TID = [ "CODATID014058Data.selectCompany();",
						"CODATID014058Data.createData();",
						"CODATID014058Data.createDataExt1();",
						"CODATID014058Data.switchProfile();"]	
		APEX.execute_commands create_basedata_for_TID
	end

	after(:all) do
		login_user
		## Restore previous environment variables.
		destroy_test_data = [ "CODATID014058Data.selectCompany();","CODATID014058Data.destroyData();"]						
		APEX.execute_commands destroy_test_data	
		gen_end_test "TID014058"
		## Restore previous environment variables.
		Capybara.default_wait_time = $current_default_wait_time
		Capybara.ignore_hidden_elements = $current_ignore_hidden
		FFA.delete_new_data_and_wait
		SF.logout
	end

	

	it "TID014058 - Intercompany Company Structure", :unmanaged => true  do

		SF.tab "Group Structure"
		page.has_text?("CUSTOMCO1")
		gen_report_test "TST018731 - Check diagram - dropdown menu"

		begin
			node = Intercompany.find_node_with_name 'CUSTOMCO1'
			node.click
			assert_node_menu

			node = Intercompany.find_node_with_name 'CUSTOMCO3'
			node.click
			assert_node_menu

			node = Intercompany.find_node_with_name 'CUSTOMCO4'
			node.click
			assert_node_menu
		end

		gen_report_test "TST018733 - Check diagram - non grouped companies"

		begin
			node = Intercompany.find_node_with_name 'CUSTOMCO8'
			node.click
			assert_node_menu
		end

		gen_report_test "TST018732 - Check diagram - view company details"

		begin
			companiesToIterate = ['CUSTOMCO1', 'CUSTOMCO3', 'CUSTOMCO5']
			companiesToIterate.each do |oneCompany|
				node = Intercompany.find_node_with_name oneCompany
				node.click

				click_link $INTERCOMPANY_MENU_OPTION_VIEW_COMPANY_DETAILS
				wait_for_new_window
				within_window(windows.last) do
					expect(Company.get_name).to eq(oneCompany)
					page.current_window.close
				end
			end
		end

		gen_report_test "TST018735 - Check diagram - view all company owners"

		begin
			ownersHash = {
				'CUSTOMCO1' => {},
				'CUSTOMCO2' => {
					'CUSTOMCO1' => 60
				},
				'CUSTOMCO3' => {
					'CUSTOMCO1' => 60
				},
				'CUSTOMCO4' => {
					'CUSTOMCO3' => 60,
					'CUSTOMCO1' => 40
				},
				'CUSTOMCO5' => {
					'CUSTOMCO3' => 60
				},
				'CUSTOMCO6' => {},
				'CUSTOMCO7' => {
					'CUSTOMCO6' => 60,
					'CUSTOMCO5' => 40
				},
				'CUSTOMCO8' => {
					'External Company 1' => 100
				}
			}

			wait_for_number_of_nodes 14
			nodeList = Intercompany.get_all_tree_nodes
			nodeList.each do |oneNode|
				oneNode.click
				click_link($INTERCOMPANY_MENU_OPTION_VIEW_ALL_COMPANY_OWNERS)

				relations_popup = find($intercompany_relations_popup)
				within(relations_popup) do
					nodeName = Intercompany.get_node_name(oneNode)
					expectedRows = ownersHash[nodeName] ? ownersHash[nodeName].keys.length : 0

					expect(find($intercompany_relations_popup_title)).to have_content(nodeName + ' is owned by')
					wait_for_popup_rows_load expectedRows

					if(expectedRows == 0)
						assert_empty_popup
					else
						ownersHash[nodeName].keys.each do |relatedCompany|
							percentage = ownersHash[nodeName][relatedCompany]
							theRow = find($intercompany_relations_popup_row, :text => relatedCompany)
							expect(theRow).to have_content(percentage)
						end
					end
				end

				Intercompany.close_relations_popup
				expect(page).to_not have_selector($intercompany_relations_popup)
			end
		end

		gen_report_test "TST018736 - Check diagram - view all company subsidiaries"

		begin
			subsidiariesHash = {
				'CUSTOMCO1' => {
					'CUSTOMCO2' => 60,
					'CUSTOMCO3' => 60,
					'CUSTOMCO4' => 40
				},
				'CUSTOMCO2' => {},
				'CUSTOMCO3' => {
					'CUSTOMCO4' => 60,
					'CUSTOMCO5' => 60
				},
				'CUSTOMCO4' => {},
				'CUSTOMCO5' => {
					'CUSTOMCO7' => 40
				},
				'CUSTOMCO6' => {
					'CUSTOMCO7' => 60
				},
				'CUSTOMCO7' => {},
				'CUSTOMCO8' => {}
			}

			wait_for_number_of_nodes 14
			nodeList = Intercompany.get_all_tree_nodes
			nodeList.each do |oneNode|
				oneNode.click
				click_link($INTERCOMPANY_MENU_OPTION_VIEW_ALL_COMPANY_SUBSIDIARIES)

				relations_popup = find($intercompany_relations_popup)
				within(relations_popup) do
					nodeName = Intercompany.get_node_name(oneNode)
					expectedRows = subsidiariesHash[nodeName] ? subsidiariesHash[nodeName].keys.length : 0

					expect(find($intercompany_relations_popup_title)).to have_content(nodeName + ' owns')
					wait_for_popup_rows_load expectedRows

					if(expectedRows == 0)
						assert_empty_popup
					else
						subsidiariesHash[nodeName].keys.each do |relatedCompany|
							percentage = subsidiariesHash[nodeName][relatedCompany]
							theRow = find($intercompany_relations_popup_row, :text => relatedCompany)
							expect(theRow).to have_content(percentage)
						end
					end
				end

				Intercompany.close_relations_popup
				expect(page).to_not have_selector($intercompany_relations_popup)
			end
		end
	end
end
