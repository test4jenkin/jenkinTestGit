 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module Product  
extend Capybara::DSL
#############################
# Products fields label and locators
#############################
$product_add_to_pricebook_selection_col_pricebook_name = "table.list tr[class*=dataRow] th"
$product_add_to_pricebook_selection_col_use_std_price = "table[class*='tabularEditElement'] tr[class=dataRow] td[class*=numericalColumn]"
$products_search_text = "input[class='searchTextBox']"
$product_find_product_button = "Find Product"
$product_add_standard_price_button = "input[title='Add'] , div[title='Add Standard Price']"
$product_add_pricebook_search = "input[id$='search']"
$product_add_pricebook_save_button = "input[name$='saveButton']"
$product_add_pricebook_list_price_checkbox_pattern = "//label[text()='"+$sf_param_substitute+"']/following::input[1]"
$product_add_standard_price_options_rows = "table[class$='genericTable brandSecondaryBrd'] tr"
$product_add_standard_price_currency_value_pattern = "table[class$='genericTable brandSecondaryBrd'] tr:nth-of-type("+$sf_param_substitute+") td:nth-of-type(2)"
$product_set_standard_price_value_pattern = "table[class$='genericTable brandSecondaryBrd'] tr:nth-of-type("+$sf_param_substitute+") td:nth-of-type(3) input"
$product_sales_revenue_account_label = "Sales Revenue Account"
$product_name_label = "Product Name"
$product_pricebook_standard_label = "Standard"
$product_purchase_analysis_account = "Purchase Analysis Account"
$product_select_pricebook_dropdown = "select[id='p1']"
#############################
# Products  
#############################

###################################################
# Selectors 
###################################################

$product_add_to_pricebook_selection_col_pricebook_name = "table.list tr[class*=dataRow] th"
$product_add_to_pricebook_selection_col_use_std_price = "table[class*='tabularEditElement'] tr[class=dataRow] td[class*=numericalColumn]"

#methods
# product detail 
	def Product.set_product_code product_code 
		fill_in "Product Code" , :with => product_code
	end 
# Accounting information 
	def Product.set_sales_revenue_account sales_revenue_account
		SF.fill_in_lookup "Sales Revenue Account" , sales_revenue_account
	end 
# Purchase Analysis account
	def Product.set_purchase_analysis_account purchase_analysis_account
		SF.fill_in_lookup $product_purchase_analysis_account , purchase_analysis_account
	end 

# default quantity schedule 
	def Product.select_quantity_schedule_type quantity_schedule_type	
		select(quantity_schedule_type, :from => 'QuantityScheduleType') 
	end 
	def Product.set_no_of_qty_installments no_of_qty_installments
		fill_in "NumberOfQuantityInstallments" , :with => no_of_qty_installments
	end
	def Product.select_qty_installment_period qty_installment_period
		select(qty_installment_period, :from => 'QuantityInstallmentPeriod') 
	end
# default revenue schedule 
	def Product.select_revenue_schedule_type revenue_schedule_type
		select(revenue_schedule_type, :from => 'RevenueScheduleType') 
	end
	def Product.set_no_of_revenue_installments no_of_revenue_installments
			fill_in "NumberOfRevenueInstallments" , :with => no_of_revenue_installments
	end 		
	def Product.select_revenue_installment_period revenue_installment_period 
			select(revenue_installment_period, :from => 'RevenueInstallmentPeriod') 
	end 
# select the product on page product selection for opportunity after user 
# click on add prodcut button on the Opportunity main page
	def Product.price_book_select price_book_name 
		row = 1
		all($product_add_to_pricebook_selection_col_pricebook_name).each do |pricebook|
			if pricebook.text == price_book_name
				break
			end 
			row += 1
		end 
		check "ids#{row - 1}" 
	end 
# Add List Price Page
# add the list price for currency  
	def Product.add_list_price  product_currency , list_price 
		row = 1
		all($product_add_to_pricebook_selection_col_use_std_price).each do |prod_curr|
			if prod_curr.text.include? product_currency
				break
			end 
			row += 1
		end 
		fill_in "td#{row - 1}_8", :with => list_price
	end
	
# Search a product
	def Product.search_product prod_name
		# on lightning org, no search field is available to search product.
		if (!SF.org_is_lightning)
			find($products_search_text).set prod_name
			SF.click_button $product_find_product_button
			SF.wait_for_search_button
		end
	end
# Buttons
	def Product.click_add_standard_price_button 
		SF.on_related_list do
			find($product_add_standard_price_button).click
			SF.wait_for_search_button
		end
	end
# add standard price to product
	def Product.set_standard_price_to_product currency_name, standard_price 
		# On lightning, User has to select the currency from dropdown and enter price
		if (SF.org_is_lightning)
			SF.select_value "Currency" , currency_name
			fill_in "List Price" , :with => standard_price
		else
		# on Non lightning, user has to select corresponding checkbox for currency before adding price.
			row = 2
			while row <= (all($product_add_standard_price_options_rows).count - 1)
				currency_value = find($product_add_standard_price_currency_value_pattern.sub($sf_param_substitute,row.to_s)).text
				if currency_name == currency_value
					find($product_set_standard_price_value_pattern.sub($sf_param_substitute,row.to_s)).set standard_price
					break
				end
				row+=1
			end
		end
	end
end 