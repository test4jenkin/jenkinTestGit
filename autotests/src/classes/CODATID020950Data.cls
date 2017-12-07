/*
 * Copyright (c) 2017 FinancialForce.com, inc. All rights reserved.
 */

public class CODATID020950Data
{

	public static final String SUFFIX = '#TID020950';
	public static Integer ACTUAL_YEAR = System.today().year();
	public static String PPLUS_PAYMENT = 'PPLUS-PAYMENT';
	public static String PPLUS_PAYMENT50 = 'PPLUS-PAYMENT50';

	public static void selectCompany()
	{
		CODABaseData.switchCurrentCompany(CODABaseData.NAMECOMPANY_MERLINAUTOUSA, true, true, UserInfo.getUserId());
	}

	public static void switchProfile()
	{
	}

	public static void createData()
	{
		CODADataTestHelper.setSystemTestDate(SUFFIX);
		loadMap();

		Account accAudi = [select CODADaysOffset1__c, CODADiscount1__c, CODADescription2__c, CODADaysOffset2__c, CODABaseDate2__c, CODADiscount2__c, CODADescription3__c, CODADaysOffset3__c, CODABaseDate3__c, CODADiscount3__c from Account where MirrorName__c = 'Audi'][0];
		accAudi.CODABaseDate1__c = 'End of Next Month';
        accAudi.CODADaysOffset1__c = 0;
        accAudi.CODADiscount1__c = 0;
        accAudi.CODABaseDate2__c = 'Invoice Date';
        accAudi.CODADaysOffset2__c = 10;
        accAudi.CODADiscount2__c = 5;
        accAudi.CODABaseDate3__c = 'Start of Next Month';
        accAudi.CODADaysOffset3__c = 15;
        accAudi.CODADiscount3__c = 2;
        accAudi.CODABaseDate4__c = 'Start of Next Month';
        accAudi.CODADaysOffset4__c = 20;
        accAudi.CODADiscount4__c = 1;
		update accAudi;
	}

	public static void createDataext1()
	{
		CODATestIDMapExt.load(SUFFIX); 

		CODAPurchaseInvoiceTestHelper purchaseInvoice = new CODAPurchaseInvoiceTestHelper();
		purchaseInvoice.setAccount(CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES);
		purchaseInvoice.setInvoiceDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX) + 10);
		purchaseInvoice.setVendorInvoiceNumber('PIN1');
		purchaseInvoice.setAccountInvoiceTotal('149.00');

		CODAPurchaseInvoiceTestHelper.ProductLineItem lineItem = purchaseInvoice.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		lineItem.setQuantity(1.00);
		lineItem.setUnitPrice(149.00);

		purchaseInvoice.saveAndPost();

		CODAPurchaseInvoiceTestHelper purchaseInvoice2 = new CODAPurchaseInvoiceTestHelper();
		purchaseInvoice2.setAccount(CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES);
		purchaseInvoice2.setInvoiceDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice2.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX) + 10);
		purchaseInvoice2.setVendorInvoiceNumber('PIN2');
		purchaseInvoice2.setAccountInvoiceTotal('300.00');

		CODAPurchaseInvoiceTestHelper.ProductLineItem lineItem2 = purchaseInvoice2.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		lineItem2.setQuantity(1.00);
		lineItem2.setUnitPrice(300.00);

		purchaseInvoice2.saveAndPost();
	}

	public static void createDataext2()
	{
		CODATestIDMapExt.load(SUFFIX);

		CODAPurchaseInvoiceTestHelper purchaseInvoice = new CODAPurchaseInvoiceTestHelper();
		purchaseInvoice.setAccount(CODABaseDataExt.NAMEACCOUNT_AUDI);
		purchaseInvoice.setInvoiceDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX) + 10);
		purchaseInvoice.setVendorInvoiceNumber('PIN3');
		purchaseInvoice.setAccountInvoiceTotal('149.00');

		CODAPurchaseInvoiceTestHelper.ProductLineItem lineItem = purchaseInvoice.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		lineItem.setQuantity(1.00);
		lineItem.setUnitPrice(149.00);

		purchaseInvoice.saveAndPost();

		CODAPurchaseInvoiceTestHelper purchaseInvoice2 = new CODAPurchaseInvoiceTestHelper();
		purchaseInvoice2.setAccount(CODABaseDataExt.NAMEACCOUNT_AUDI);
		purchaseInvoice2.setInvoiceDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice2.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX) + 10);
		purchaseInvoice2.setVendorInvoiceNumber('PIN4');
		purchaseInvoice2.setAccountInvoiceTotal('500.00');

		CODAPurchaseInvoiceTestHelper.ProductLineItem lineItem2 = purchaseInvoice2.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		lineItem2.setQuantity(1.00);
		lineItem2.setUnitPrice(500.00);

		purchaseInvoice2.saveAndPost();
	}

	public static void createDataext3()
	{
		CODATestIDMapExt.load(SUFFIX);

		CODACashEntryTestHelper cashEntry = new CODACashEntryTestHelper();
		cashentry.setType(CODACashEntry.TYPE_PAYMENT);
		cashentry.setBankAccount(CODABaseDataExt.NAMEBANKACC_BRISTOLEUROSACCOUNT);
		cashentry.updateCashEntryCurrency();
		cashEntry.setDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		cashEntry.setReference('CSH1');
		cashentry.setAccount(CODABaseDataExt.NAMEACCOUNT_AUDI);
		
		CODACashEntryTestHelper.LineItem lineItem = cashentry.newLine();
		lineItem.setCashEntryValue('100');

		cashentry.saveAndPost();
	}

	public static void createDataExt4()
	{
		CODATestIDMapExt.load(SUFFIX);

		CODAAPICashMatchingTypes_8_0.Configuration configuration = new CODAAPICashMatchingTypes_8_0.Configuration();
		CODAAPICommon.Reference ref = new CODAAPICommon.Reference();
		ref.Id = CODAAccountHelperForTests.getAccountByName(CODABaseDataExt.NAMEACCOUNT_AUDI)[0].Id;
		configuration.Account = ref;
		configuration.MatchingCurrencyMode = CODAAPICashMatchingTypes_8_0.enumMatchingCurrencyMode.Account;
		configuration.MatchingDate = CODADataTestHelper.getSystemTestDate(SUFFIX);

		CODAAPICashMatchingTypes_8_0.Analysis analysisInfoAPI = new CODAAPICashMatchingTypes_8_0.Analysis();

		CODAAPICommon_8_0.Context context2 = new CODAAPICommon_8_0.Context();
		context2.CompanyName = CODABaseData.NAMECOMPANY_MERLINAUTOUSA;

		List<CODATransactionLineItem__c> cashEntryList = [Select id, Name, DocumentOutstandingValue__c, Transaction__c from CODATransactionLineItem__c where LineType__c='Account' and Transaction__r.TransactionType__c='Cash' and DocumentOutstandingValue__c=100.00];
		System.assertEquals(1, cashEntryList.size(), 'Cash Entry to be matched has not been found.');
		List<CODATransactionLineItem__c> invoiceList = [Select id, Name, DocumentOutstandingValue__c, Transaction__c from CODATransactionLineItem__c where LineType__c='Account' and Transaction__r.TransactionType__c='Purchase Invoice' and Account__c = :CODATestIDMap.resolve(CODABaseDataExt.NAMEACCOUNT_AUDI) and transaction__r.VendorDocumentNumber__c = 'PIN4'];	// DocumentOutstandingValue__c=-500.00];
		System.assertEquals(1, invoiceList.size(), 'Invoice to be matched has not been found.');

		List<CODAAPICashMatchingTypes_8_0.Item> items =new List<CODAAPICashMatchingTypes_8_0.Item>();
		CODATransactionLineItem__c cashEntry = cashEntryList[0];
		CODAAPICashMatchingTypes_8_0.Item item = new CODAAPICashMatchingTypes_8_0.Item ();
		ref = new CODAAPICommon.Reference();
		ref.id = cashEntry.id;
		item.TransactionLineItem = ref;
		item.paid = 60;
		items.add(item);
	
		CODATransactionLineItem__c invoice = invoiceList[0];
		CODAAPICashMatchingTypes_8_0.Item item1 = new CODAAPICashMatchingTypes_8_0.Item ();
		ref = new CODAAPICommon.Reference();
		ref.id = invoice.id;
		item1.TransactionLineItem = ref;
		item1.paid = -60;
		items.add(item1);

		CODAAPICommon.Reference matchReference = CODAAPICashMatching_8_0.Match(context2, configuration, items, analysisInfoAPI);
		CODATestIDMapExt.put('CASHMATCHING', matchReference.getId());
		CODATestIDMapExt.save(SUFFIX);
	}

	public static void createDataext5()
	{
		CODATestIDMapExt.load(SUFFIX);
		Set<String> specialPeriods = new Set<String> {'000', '100', '101'};
		codaPeriod__c period = [Select id, EndDate__c from codaPeriod__c where StartDate__c <= :CODADataTestHelper.getSystemTestDate(SUFFIX) and EndDate__c >= :CODADataTestHelper.getSystemTestDate(SUFFIX) and OwnerCompany__r.Name = :CODABaseData.NAMECOMPANY_MERLINAUTOUSA and Closed__c = false and PeriodNumber__c not in :specialPeriods];

		List<codaPayment__c> payList = new List<codaPayment__c>();
		codaPayment__c pay = new codaPayment__c();
		pay.PaymentCurrency__c = CODATestIDMap.resolve(CODABaseData.CURRENCYCODE_EUR);
		pay.BankAccount__c = CODATestIDMap.resolve(CODABaseDataExt.NAMEBANKACC_BRISTOLEUROSACCOUNT);
		pay.OwnerCompany__c = CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOUSA);
		pay.CurrencyMode__c = 'Document';
		pay.CurrencyWriteOff__c = CODATestIDMap.resolve(CODABaseData.NAMEGLA_WRITEOFFUS);
		pay.Description__c = PPLUS_PAYMENT;
		pay.DocumentCurrency__c = CODATestIDMap.resolve(CODABaseData.CURRENCYCODE_EUR);
		pay.PaymentDate__c = system.today();
		pay.PaymentMediaTypes__c = 'Check';
		pay.PaymentTypes__c = 'Payments';
		pay.SettlementDiscountReceived__c = CODATestIDMap.resolve(CODABaseData.NAMEGLA_SETTLEMENTDISCOUNTSALLOWEDUS);
		pay.Status__c = 'New';
		pay.CreatedByPaymentsPlus__c = true;
		pay.DiscountDate__c = system.today();
		pay.period__c = period.Id;
		payList.add(pay);

		pay = new codaPayment__c();
		pay.PaymentCurrency__c = CODATestIDMap.resolve(CODABaseData.CURRENCYCODE_EUR);
		pay.BankAccount__c = CODATestIDMap.resolve(CODABaseDataExt.NAMEBANKACC_BRISTOLEUROSACCOUNT);
		pay.OwnerCompany__c = CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOUSA);
		pay.CurrencyMode__c = 'Document';
		pay.CurrencyWriteOff__c = CODATestIDMap.resolve(CODABaseData.NAMEGLA_WRITEOFFUS);
		pay.Description__c = PPLUS_PAYMENT50;
		pay.DocumentCurrency__c = CODATestIDMap.resolve(CODABaseData.CURRENCYCODE_EUR);
		pay.PaymentDate__c = system.today();
		pay.PaymentMediaTypes__c = 'Check';
		pay.PaymentTypes__c = 'Payments';
		pay.SettlementDiscountReceived__c = CODATestIDMap.resolve(CODABaseData.NAMEGLA_SETTLEMENTDISCOUNTSALLOWEDUS);
		pay.Status__c = 'New';
		pay.CreatedByPaymentsPlus__c = true;
		pay.DiscountDate__c = system.today() + 50;
		pay.period__c = period.Id;
		payList.add(pay);
		insert payList;
	}


	public static void createDataext6()
	{
		CODATestIDMapExt.load(SUFFIX);
		codaPayment__c pay = [select id from codaPayment__c where Description__c =:PPLUS_PAYMENT];

		Set<Id> transLineIDs = new Map<Id,codaTransactionLineItem__c>([Select Id from codaTransactionLineItem__c where LineType__c = 'Account' and transaction__r.VendorDocumentNumber__c IN ('PIN1', 'PIN2')]).keySet();
		List<Id> transLineIDListToRemove = new List<Id> (transLineIDs);
		PaymentsPlusService.removeFromProposal(pay.Id, transLineIDListToRemove);
	}

	public static void destroyData()
	{
		CODAContext.enablesupportaccess();

		Account accAudi = [select CODADaysOffset1__c, CODADiscount1__c, CODADescription2__c, CODADaysOffset2__c, CODABaseDate2__c, CODADiscount2__c, CODADescription3__c, CODADaysOffset3__c, CODABaseDate3__c, CODADiscount3__c from Account where MirrorName__c = 'Audi'][0];
		accAudi.CODABaseDate1__c = 'Invoice Date';
		accAudi.CODADaysOffset1__c = 30;
		accAudi.CODADiscount1__c = 0;
		accAudi.CODADescription2__c = null;
		accAudi.CODADaysOffset2__c = 0;
		accAudi.CODABaseDate2__c = null;
		accAudi.CODADiscount2__c = 0;
		accAudi.CODADescription3__c = null;
		accAudi.CODADaysOffset3__c = 0;
		accAudi.CODABaseDate3__c = null;
		accAudi.CODADiscount3__c = 0;
		accAudi.CODADescription4__c = null;
		accAudi.CODADaysOffset4__c = 0;
		accAudi.CODABaseDate4__c = null;
		accAudi.CODADiscount4__c = 0;
		update accAudi;

		delete [select id from codaTransaction__c];
		delete [select id from codaPurchaseInvoice__c];
		delete [select id from codaCashEntry__c];
		delete [select id from codaCashMatchingHistory__c];
		delete [select id from codaMatchingReference__c];
		delete [select Id from codaPayment__c];
		delete [select Id from codaPaymentMediaDetail__c];
		delete [select Id from codaPaymentMediaSummary__c];
		delete [select Id from codaPaymentMediaControl__c];

		CODADataTestHelper.deleteSystemTestDate(SUFFIX);
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

		// Periods for Merlin Auto USA
		for (codaPeriod__c period : [SELECT Id, Name FROM codaPeriod__c WHERE YearName__r.Name = :String.valueof(ACTUAL_YEAR) AND OwnerCompany__c = :compId])
		{
			CODATestIDMapExt.put(period.Name, period.id);
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
		accNames.add(CODABaseDataExt.NAMEACCOUNT_CHRYSLERMOTORSLLC);
		accNames.add(CODABaseDataExt.NAMEACCOUNT_AUDI);
		accNames.add(CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES);

		for (Account accId : [SELECT Id, Name FROM Account WHERE MirrorName__c in :accNames])
		{
			CODATestIDMapExt.put(accId.Name, accId.id);
		}
		
		// Bank Accounts
		Set<String> bankAccouns = new Set<String>();
		bankAccouns.add(CODABaseDataExt.NAMEBANKACC_BRISTOLDEPOSITACCOUNT);
		bankAccouns.add(CODABaseDataExt.NAMEBANKACC_BRISTOLCHECKINGACCOUNT);
		bankAccouns.add(CODABaseDataExt.NAMEBANKACC_BRISTOLEUROSACCOUNT);
		for (CODABankAccount__c account : [SELECT Id, Name FROM codaBankAccount__c WHERE Name in :bankAccouns and OwnerCompany__c = :compID])
		{
			CODATestIDMapExt.put(account.Name, account.id);
		}

		CODATestIDMapExt.save(SUFFIX);
	}
}