/*
* Copyright (c) 2016 FinancialForce.com, inc.  All rights reserved.
*/
public class CODATID021023Data
{
	public static String SUFFIX = 'TID021023#';
	public static String PPLUS_TID021023 = 'PPLUS-TID021023';

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

		CODAPurchaseInvoiceTestHelper purchaseInvoice = new CODAPurchaseInvoiceTestHelper();

		purchaseInvoice.setAccount(CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES);
		purchaseInvoice.setInvoiceDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice.setVendorInvoiceNumber('PIN1');
		purchaseInvoice.setReference1('PAY');
		purchaseInvoice.setAccountInvoiceTotal('149.00');
		purchaseInvoice.setInvoiceCurrency(CODABaseData.CURRENCYCODE_EUR);

		CODAPurchaseInvoiceTestHelper.ProductLineItem lineItem = purchaseInvoice.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		lineItem.setQuantity(1.00);
		lineItem.setUnitPrice(149.00);

		purchaseInvoice.saveAndPost();

		CODAPurchaseInvoiceTestHelper purchaseInvoice2 = new CODAPurchaseInvoiceTestHelper();

		purchaseInvoice2.setAccount(CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES);
		purchaseInvoice2.setInvoiceDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice2.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice2.setVendorInvoiceNumber('PIN2');
		purchaseInvoice2.setReference1('PAY');
		purchaseInvoice2.setAccountInvoiceTotal('149.00');
		purchaseInvoice2.setInvoiceCurrency(CODABaseData.CURRENCYCODE_EUR);

		CODAPurchaseInvoiceTestHelper.ProductLineItem lineItem1 = purchaseInvoice2.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		lineItem1.setQuantity(1.00);
		lineItem1.setUnitPrice(149.00);

		purchaseInvoice2.saveAndPost();
	}
	
	public static void createDataExt1()
	{
		CODATestIDMapExt.load(SUFFIX);

		CODAPurchaseCreditNoteTestHelper pcrn = new CODAPurchaseCreditNoteTestHelper();

		pcrn.setAccount(CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES);
		pcrn.setCreditNoteDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		pcrn.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		pcrn.setVendorCreditNoteNumber('PCR1');
		pcrn.setReference1('PAY');
		pcrn.setAccountCreditNoteTotal('400.00');
		pcrn.setCreditNoteCurrency(CODABaseData.CURRENCYCODE_EUR);

		CODAPurchaseCreditNoteTestHelper.ProductLineItem lineItem1 = pcrn.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		lineItem1.setQuantity(1.00);
		lineItem1.setUnitPrice(400.00);

		pcrn.saveAndPost();

		CODAPurchaseInvoiceTestHelper purchaseInvoice3 = new CODAPurchaseInvoiceTestHelper();

		purchaseInvoice3.setAccount(CODABaseDataExt.NAMEACCOUNT_AUDI);
		purchaseInvoice3.setInvoiceDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice3.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice3.setVendorInvoiceNumber('PIN3');
		purchaseInvoice3.setReference1('PAY');
		purchaseInvoice3.setAccountInvoiceTotal('149.00');
		purchaseInvoice3.setInvoiceCurrency(CODABaseData.CURRENCYCODE_EUR);

		CODAPurchaseInvoiceTestHelper.ProductLineItem lineItem2 = purchaseInvoice3.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		lineItem2.setQuantity(1.00);
		lineItem2.setUnitPrice(149.00);
		purchaseInvoice3.saveAndPost();
	}

	public static void createDataExt2()
	{
		CODATestIDMapExt.load(SUFFIX);
		CODAPurchaseCreditNoteTestHelper pcrn = new CODAPurchaseCreditNoteTestHelper();
		pcrn.setAccount(CODABaseDataExt.NAMEACCOUNT_AUDI);
		pcrn.setCreditNoteDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		pcrn.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		pcrn.setVendorCreditNoteNumber('PCR2');
		pcrn.setReference1('PAY');
		pcrn.setAccountCreditNoteTotal('149.00');
		pcrn.setCreditNoteCurrency(CODABaseData.CURRENCYCODE_EUR);

		CODAPurchaseCreditNoteTestHelper.ProductLineItem lineItem1 = pcrn.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		lineItem1.setQuantity(1.00);
		lineItem1.setUnitPrice(149.00);

		pcrn.saveAndPost();

		CODAPurchaseInvoiceTestHelper purchaseInvoice3 = new CODAPurchaseInvoiceTestHelper();

		purchaseInvoice3.setAccount(CODABaseDataExt.NAMEACCOUNT_CHRYSLERMOTORSLLC);
		purchaseInvoice3.setInvoiceDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice3.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice3.setVendorInvoiceNumber('PIN4');
		purchaseInvoice3.setReference1('PAY');
		purchaseInvoice3.setAccountInvoiceTotal('149.00');
		purchaseInvoice3.setInvoiceCurrency(CODABaseData.CURRENCYCODE_EUR);

		CODAPurchaseInvoiceTestHelper.ProductLineItem lineItem2 = purchaseInvoice3.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		lineItem2.setQuantity(1.00);
		lineItem2.setUnitPrice(149.00);
		purchaseInvoice3.saveAndPost();
	}

	public static void createDataext3()
	{
		CODATestIDMapExt.load(SUFFIX);
		Set<String> specialPeriods = new Set<String> {'000', '100', '101'};
		codaPeriod__c period = [Select id, EndDate__c from codaPeriod__c where StartDate__c <= :CODADataTestHelper.getSystemTestDate(SUFFIX) and EndDate__c >= :CODADataTestHelper.getSystemTestDate(SUFFIX) and OwnerCompany__r.Name = :CODABaseData.NAMECOMPANY_MERLINAUTOUSA and Closed__c = false and PeriodNumber__c not in :specialPeriods];

		codaPayment__c pay = new codaPayment__c();
		pay.PaymentCurrency__c = CODATestIDMap.resolve(CODABaseData.CURRENCYCODE_EUR);
		pay.BankAccount__c = CODATestIDMap.resolve(CODABaseDataExt.NAMEBANKACC_BRISTOLEUROSACCOUNT);
		pay.OwnerCompany__c = CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOUSA);
		pay.CurrencyMode__c = 'Document';
		pay.CurrencyWriteOff__c = CODATestIDMap.resolve(CODABaseData.NAMEGLA_WRITEOFFUS);
		pay.Description__c = PPLUS_TID021023;
		pay.DocumentCurrency__c = CODATestIDMap.resolve(CODABaseData.CURRENCYCODE_EUR);
		pay.PaymentDate__c = system.today();
		pay.PaymentMediaTypes__c = 'Check';
		pay.PaymentTypes__c = 'Payments';
		pay.SettlementDiscountReceived__c = CODATestIDMap.resolve(CODABaseData.NAMEGLA_SETTLEMENTDISCOUNTSALLOWEDUS);
		pay.Status__c = 'New';
		pay.CreatedByPaymentsPlus__c = true;
		pay.DiscountDate__c = system.today() + 10;
		pay.period__c = period.Id;
		insert pay;
	}

	public static void createDataext4()
	{
		CODATestIDMapExt.load(SUFFIX);
		codaPayment__c pay = [select id from codaPayment__c where Description__c =:PPLUS_TID021023];

		Set<Id> transLineIDs = new Map<Id,codaTransactionLineItem__c>([Select Id from codaTransactionLineItem__c where LineType__c = 'Account' and matchingStatus__c = 'Available']).keySet();
		List<Id> transLineIDListToAdd = new List<Id> (transLineIDs);
		PaymentsPlusService.addToProposal(pay.Id, transLineIDListToAdd);
	}

	public static void destroyData()
	{
		CODATestIDMapExt.load(SUFFIX);
		CODAContext.enableSupportAccess();
		CODADataTestHelper.deleteSystemTestDate(SUFFIX);
		delete [select Id from codaPurchaseInvoice__c];
		delete [select Id from codaPurchaseCreditNote__c];
		delete [select Id from codaTransaction__c];
		delete [select Id from codaPayment__c];
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

		// General Ledger Account
		Set<String> glaNames = new Set<String>();
		glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLUSD);
		glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLEUR);
		glaNames.add(CODABaseData.NAMEGLA_WRITEOFFUS);
		glaNames.add(CODABaseData.NAMEGLA_SETTLEMENTDISCOUNTSALLOWEDUS);
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
		accNames.add(CODABaseDataExt.NAMEACCOUNT_AUDI);
		accNames.add(CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES);
		accNames.add(CODABaseDataExt.NAMEACCOUNT_CHRYSLERMOTORSLLC);
		for (Account accId : [SELECT Id, Name FROM Account WHERE MirrorName__c in :accNames])
		{
			CODATestIDMapExt.put(accId.Name, accId.id);
		}
		
		// Bank Accounts
		Set<String> bankAccouns = new Set<String>();
		bankAccouns.add(CODABaseDataExt.NAMEBANKACC_BRISTOLDEPOSITACCOUNT);
		bankAccouns.add(CODABaseDataExt.NAMEBANKACC_BRISTOLEUROSACCOUNT);
		for (CODABankAccount__c account : [SELECT Id, Name FROM codaBankAccount__c WHERE Name in :bankAccouns and OwnerCompany__c = :compID])
		{
			CODATestIDMapExt.put(account.Name, account.id);
		}

		CODATestIDMapExt.save(SUFFIX);
	}
}