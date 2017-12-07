SFACC_USER =   ENV['SF.ACCOUNTANT_USERNAME'] ? ENV['SF.ACCOUNTANT_USERNAME'] : get_property("sf.accountant_username")

SFINVCLERK_USER = ENV['SF.INVCLERK_USERNAME'] ? ENV['SF.INVCLERK_USERNAME'] : get_property("sf.invoicingclerk_username")

SFPAYCLERK_USER = ENV['SF.PAYCLERK_USERNAME'] ? ENV['SF.PAYCLERK_USERNAME'] : get_property("sf.payablesclerk_username")

SFSTANDARD_USER = ENV['SF.STANDARD_USERNAME'] ? ENV['SF.STANDARD_USERNAME'] : get_property("sf.standard_username")
