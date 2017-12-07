/*
* Copyright (c) 2017 FinancialForce.com, inc.  All rights reserved.
*/
public class CODATID020070Data
{
	public static String SUFFIX = 'TID020070#';
	public static Integer ACTUAL_YEAR = System.today().year();

	public static void switchProfile() 
	{
	}

	public static void selectCompany()
	{
		CODABaseData.switchCurrentCompany(CODABaseData.NAMECOMPANY_MERLINAUTOUSA, true, true, UserInfo.getUserId());
	}

	public static void createData() 
	{
		CODADataTestHelper.setSystemTestDate(SUFFIX);
		loadMap();

		list<codaAccountingSettings__c> accountingsetting = [select id from codaAccountingSettings__c];
		if (accountingsetting.size()>0) {
			accountingsetting[0].GLAFilteringInPaymentSelection__c = 'NO FILTERING';
			update accountingsetting;
		}
		else {
			codaAccountingSettings__c accsetting = new codaAccountingSettings__c();
			accsetting.GLAFilteringInPaymentSelection__c = 'NO FILTERING';
			insert accsetting;
		}

		CODAPurchaseInvoiceTestHelper purchaseInvoice = new CODAPurchaseInvoiceTestHelper();

		purchaseInvoice.setAccount(CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES);
		purchaseInvoice.setInvoiceDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX) + 10);
		purchaseInvoice.setVendorInvoiceNumber('PIN1');
		purchaseInvoice.setAccountInvoiceTotal('149');

		CODAPurchaseInvoiceTestHelper.ProductLineItem lineItem = purchaseInvoice.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		lineItem.setQuantity(1.00);
		lineItem.setUnitPrice(149.00);
		purchaseInvoice.saveAndPost();

		CODAPurchaseCreditNoteTestHelper purchaseCreditNote = new CODAPurchaseCreditNoteTestHelper();
		purchaseCreditNote.setAccount(CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES);
		purchaseCreditNote.setCreditNoteDate(CODADataTestHelper.getSystemTestDate(SUFFIX));

		purchaseCreditNote.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX)+20);
		purchaseCreditNote.setAccountCreditNoteTotal('149');

		purchaseCreditNote.setVendorCreditNoteNumber('PCR1');

		CODAPurchaseCreditNoteTestHelper.ProductLineItem productLine = purchaseCreditNote.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		productLine.setUnitPrice(149.00);
		productLine.setQuantity(1);
		purchaseCreditNote.saveAndPost();
	}

	public static void createDataExt1() 
	{
		CODATestIDMapExt.load(SUFFIX);
		PaymentDetailsTemplate__c paymentDetailsTemplate = new PaymentDetailsTemplate__c();
		paymentDetailsTemplate.Name= 'PDT1';
		paymentDetailsTemplate.PaymentCurrency__c = CODATestIDMap.resolve(CODABaseData.CURRENCYCODE_USD);
		paymentDetailsTemplate.BankAccount__c= CODATestIDMap.resolve(CODABaseDataExt.NAMEBANKACC_BRISTOLEUROSACCOUNT);
		paymentDetailsTemplate.PaymentMediaTypes__c= CODAPayment.PAYMENTMETHOD_CHECK;
		paymentDetailsTemplate.SettlementDiscountGLA__c = CODATestIDMap.resolve(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLUSD);
		paymentDetailsTemplate.SettlementDiscountDimension1__c = CODATestIDMap.resolve(CODABaseDataExt.NAMEDIM1_USD);
		paymentDetailsTemplate.SettlementDiscountDimension2__c = CODATestIDMap.resolve(CODABaseDataExt.NAMEDIM2_USD);
		paymentDetailsTemplate.SettlementDiscountDimension3__c = CODATestIDMap.resolve(CODABaseDataExt.NAMEDIM3_USD);
		paymentDetailsTemplate.SettlementDiscountDimension4__c = CODATestIDMap.resolve(CODABaseDataExt.NAMEDIM4_USD);
		paymentDetailsTemplate.CurrencyWriteOffGLA__c = CODATestIDMap.resolve(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLUSD);
		paymentDetailsTemplate.CurrencyWriteOffDimension1__c = CODATestIDMap.resolve(CODABaseDataExt.NAMEDIM1_USD);
		paymentDetailsTemplate.CurrencyWriteOffDimension2__c = CODATestIDMap.resolve(CODABaseDataExt.NAMEDIM2_USD);
		paymentDetailsTemplate.CurrencyWriteOffDimension3__c = CODATestIDMap.resolve(CODABaseDataExt.NAMEDIM3_USD);
		paymentDetailsTemplate.CurrencyWriteOffDimension4__c = CODATestIDMap.resolve(CODABaseDataExt.NAMEDIM4_USD);

		insert paymentDetailsTemplate;
	}

	public static void createDataExt2()
	{
		CODATestIDMapExt.load(SUFFIX);
		PaymentDetailsTemplate__c paymentDetailsTemplate = new PaymentDetailsTemplate__c();
		paymentDetailsTemplate.Name= 'PDT2Default';
		paymentDetailsTemplate.PaymentCurrency__c = CODATestIDMap.resolve(CODABaseData.CURRENCYCODE_EUR);
		paymentDetailsTemplate.BankAccount__c= CODATestIDMap.resolve(CODABaseDataExt.NAMEBANKACC_BRISTOLDEPOSITACCOUNT);
		paymentDetailsTemplate.PaymentMediaTypes__c= CODAPayment.PAYMENTMETHOD_CHECK;
		paymentDetailsTemplate.SettlementDiscountGLA__c = CODATestIDMap.resolve(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLEUR);
		paymentDetailsTemplate.SettlementDiscountDimension1__c = CODATestIDMap.resolve(CODABaseDataExt.NAMEDIM1_EUR);
		paymentDetailsTemplate.SettlementDiscountDimension2__c = CODATestIDMap.resolve(CODABaseDataExt.NAMEDIM2_EUR);
		paymentDetailsTemplate.SettlementDiscountDimension3__c = CODATestIDMap.resolve(CODABaseDataExt.NAMEDIM3_EUR);
		paymentDetailsTemplate.SettlementDiscountDimension4__c = CODATestIDMap.resolve(CODABaseDataExt.NAMEDIM4_EUR);
		paymentDetailsTemplate.CurrencyWriteOffGLA__c = CODATestIDMap.resolve(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLEUR);
		paymentDetailsTemplate.CurrencyWriteOffDimension1__c = CODATestIDMap.resolve(CODABaseDataExt.NAMEDIM1_EUR);
		paymentDetailsTemplate.CurrencyWriteOffDimension2__c = CODATestIDMap.resolve(CODABaseDataExt.NAMEDIM2_EUR);
		paymentDetailsTemplate.CurrencyWriteOffDimension3__c = CODATestIDMap.resolve(CODABaseDataExt.NAMEDIM3_EUR);
		paymentDetailsTemplate.CurrencyWriteOffDimension4__c = CODATestIDMap.resolve(CODABaseDataExt.NAMEDIM4_EUR);
		paymentDetailsTemplate.Default__c= true;
		insert paymentDetailsTemplate;
	}

	public static void destroyData()
	{
		CODATestIDMapExt.load(SUFFIX);
		CODAContext.enableSupportAccess();
		CODADataTestHelper.deleteSystemTestDate(SUFFIX);
		delete [select Id from codaPurchaseCreditNote__c];
		delete [select Id from codaPurchaseInvoice__c];
		delete [select Id from codaTransaction__c];
		delete [select Id from codaAccountingSettings__c];
		delete [select Id from codaPayment__c];
		delete [select Id from PaymentDetailsTemplate__c];
		CODATestIDMapExt.purge(SUFFIX);
	}

	public static void loadMap()
	{
		// Company
		CODACompany company = CODACompanyMapExt.getCurrentCompany();
		Id compID = company.getId();
		CODATestIDMapExt.put(CODABaseData.NAMECOMPANY_MERLINAUTOUSA, compID);

		// Currencies for Merlin Auto USA
		for (codaAccountingCurrency__c accCurr : [SELECT Id, Name FROM codaAccountingCurrency__c WHERE OwnerCompany__c  = :compId])
		{
			CODATestIDMapExt.put(accCurr.Name, accCurr.id);
		}

		// Periods for Merlin Auto Spain
		for (codaPeriod__c period : [SELECT Id, Name FROM codaPeriod__c WHERE YearName__r.Name = :String.valueof(ACTUAL_YEAR) AND OwnerCompany__c = :compId])
		{
			CODATestIDMapExt.put(period.Name, period.id);
		}

		// General Ledger Account
		Set<String> glaNames = new Set<String>();
		glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLUSD);
		glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLEUR);

		for (CODAGeneralLedgerAccount__c item : [SELECT Id, Name FROM CODAGeneralLedgerAccount__c WHERE Name in :glaNames])
		{
			CODATestIDMapExt.put(item.Name, item.id);
		}
        
        // Products
		Set<String> productNames = new Set<String>();
		productNames.add(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		Map<String, Id> CODAProduct2Map = CODAProduct2Mapper.getIDsByNames(productNames);

		for(String key : CODAProduct2Map.keyset())
		{
			CODATestIDMapExt.put(key, CODAProduct2Map.get(key));
		}
        
        // Accounts
		Set<String> accNames = new Set<String>();
		accNames.add(CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES);

		for (Account accId : [SELECT Id, Name FROM Account WHERE MirrorName__c in :accNames])
		{
			CODATestIDMapExt.put(accId.Name, accId.id);
		}

		// Bank Accounts
		Set<String> bankAccouns = new Set<String>();
		bankAccouns.add(CODABaseDataExt.NAMEBANKACC_BRISTOLEUROSACCOUNT);
		bankAccouns.add(CODABaseDataExt.NAMEBANKACC_BRISTOLDEPOSITACCOUNT);

		for (CODABankAccount__c account : [SELECT Id, Name FROM codaBankAccount__c WHERE Name in :bankAccouns and OwnerCompany__c = :compID])
		{
			CODATestIDMapExt.put(account.Name, account.id);
		}

		//Dimensions
		CODADimension1__c dim1_usd= [select Id from CODADimension1__c where Name=:CODABaseDataExt.NAMEDIM1_USD];
		CODADimension1__c dim1_eur= [select Id from CODADimension1__c where Name=:CODABaseDataExt.NAMEDIM1_EUR];
		CODADimension2__c dim2_usd= [select Id from CODADimension2__c where Name=:CODABaseDataExt.NAMEDIM2_USD];
		CODADimension2__c dim2_eur= [select Id from CODADimension2__c where Name=:CODABaseDataExt.NAMEDIM2_EUR];
		CODADimension3__c dim3_usd= [select Id from CODADimension3__c where Name=:CODABaseDataExt.NAMEDIM3_USD];
		CODADimension3__c dim3_eur= [select Id from CODADimension3__c where Name=:CODABaseDataExt.NAMEDIM3_EUR];
		CODADimension4__c dim4_usd= [select Id from CODADimension4__c where Name=:CODABaseDataExt.NAMEDIM4_USD];
		CODADimension4__c dim4_eur= [select Id from CODADimension4__c where Name=:CODABaseDataExt.NAMEDIM4_EUR];

		CODATestIDMapExt.put(CODABaseDataExt.NAMEDIM1_USD, dim1_usd.id);
		CODATestIDMapExt.put(CODABaseDataExt.NAMEDIM1_EUR, dim1_eur.id);
		CODATestIDMapExt.put(CODABaseDataExt.NAMEDIM2_USD, dim2_usd.id);
		CODATestIDMapExt.put(CODABaseDataExt.NAMEDIM2_EUR, dim2_eur.id);
		CODATestIDMapExt.put(CODABaseDataExt.NAMEDIM3_USD, dim3_usd.id);
		CODATestIDMapExt.put(CODABaseDataExt.NAMEDIM3_EUR, dim3_eur.id);
		CODATestIDMapExt.put(CODABaseDataExt.NAMEDIM4_USD, dim4_usd.id);
		CODATestIDMapExt.put(CODABaseDataExt.NAMEDIM4_EUR, dim4_eur.id);

		CODATestIDMapExt.save(SUFFIX);
	}
}