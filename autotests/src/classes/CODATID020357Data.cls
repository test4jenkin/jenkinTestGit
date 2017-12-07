/*
* Copyright (c) 2016 FinancialForce.com, inc.  All rights reserved.
*/
public class CODATID020357Data
{
	public static String SUFFIX = 'TID020357#';
	public static Integer ACTUAL_YEAR = System.today().year();
	public static String PPLUS_TST033507 = 'PPLUS-TST033507';
	public static String PPLUS_10_DAYS_AGO = 'PPLUS 10 DAYS AGO';

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

		Account acc= [select id, Name, CODAPaymentMethod__c  from Account where MirrorName__c= :CODABaseDataExt.NAMEACCOUNT_CHRYSLERMOTORSLLC][0];
		acc.CODAPaymentMethod__c = CODAPayment.PAYMENTMETHOD_ELECTRONIC;
		update acc;

		CODAPurchaseInvoiceTestHelper purchaseInvoice = new CODAPurchaseInvoiceTestHelper();

		purchaseInvoice.setAccount(CODABaseDataExt.NAMEACCOUNT_CHRYSLERMOTORSLLC);
		purchaseInvoice.setInvoiceDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX) + 10);
		purchaseInvoice.setVendorInvoiceNumber('PIN1');
		purchaseInvoice.setAccountInvoiceTotal('2000');
		purchaseInvoice.setInvoiceCurrency(CODABaseData.CURRENCYCODE_USD);

		CODAPurchaseInvoiceTestHelper.ProductLineItem lineItem = purchaseInvoice.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		lineItem.setQuantity(1.00);
		lineItem.setUnitPrice(2000.00);

		purchaseInvoice.saveAndPost();

		CODAPurchaseInvoiceTestHelper purchaseInvoice2 = new CODAPurchaseInvoiceTestHelper();

		purchaseInvoice2.setAccount(CODABaseDataExt.NAMEACCOUNT_CHRYSLERMOTORSLLC);
		purchaseInvoice2.setInvoiceDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice2.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice2.setVendorInvoiceNumber('PIN2');
		purchaseInvoice2.setAccountInvoiceTotal('200');
		purchaseInvoice2.setInvoiceCurrency(CODABaseData.CURRENCYCODE_USD);

		CODAPurchaseInvoiceTestHelper.ProductLineItem lineItem1 = purchaseInvoice2.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		lineItem1.setQuantity(1.00);
		lineItem1.setUnitPrice(200.00);

		purchaseInvoice2.saveAndPost();
	}

	public static void createDataExt1()
	{
		CODATestIDMapExt.load(SUFFIX);
		CODAPurchaseCreditNoteTestHelper purchaseCreditNote = new CODAPurchaseCreditNoteTestHelper();
		purchaseCreditNote.setAccount(CODABaseDataExt.NAMEACCOUNT_CHRYSLERMOTORSLLC);
		purchaseCreditNote.setCreditNoteDate(CODADataTestHelper.getSystemTestDate(SUFFIX));

		purchaseCreditNote.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX)+20);
		purchaseCreditNote.setAccountCreditNoteTotal('500');

		purchaseCreditNote.setVendorCreditNoteNumber('PCN1');

		CODAPurchaseCreditNoteTestHelper.ProductLineItem productLine = purchaseCreditNote.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		productLine.setUnitPrice(500);
		productLine.setQuantity(1);

		purchaseCreditNote.saveAndPost();
		


		
		CODAJournalTestHelper jnl1 = new CODAJournalTestHelper();
		jnl1.setJournalDate(CODADataTestHelper.getSystemTestDate(SUFFIX)-1);
		jnl1.setJournalCurrency(CODABaseData.CURRENCYCODE_USD);
		jnl1.setReference('JNL1');


		CODAJournalTestHelper.LineItem jnlLineItem1 = jnl1.newLine(CODAJournalLineItem.LINETYPE_ACCOUNTVENDOR, CODABaseDataExt.NAMEACCOUNT_CHRYSLERMOTORSLLC);
		jnlLineItem1.setGeneralLedgerAccount(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLUSD);
		jnlLineItem1.setAmount('300.00');

		CODAJournalTestHelper.LineItem jnlLineItem = jnl1.newLine(CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseData.NAMEGLA_SALESPARTS);
		jnlLineItem.setAmount('-300.00');

		jnl1.save();
		jnl1.post();
		
	}
	public static void createDataExt2()
	{
		CODATestIDMapExt.load(SUFFIX);
		CODACashEntryTestHelper cashEntry = new CODACashEntryTestHelper();
		cashentry.setType(CODACashEntry.TYPE_PAYMENT);
		cashentry.setBankAccount(CODABaseDataExt.NAMEBANKACC_BRISTOLDEPOSITACCOUNT);
		cashentry.updateCashEntryCurrency();
		cashEntry.setDate(CODADataTestHelper.getSystemTestDate(SUFFIX)-2);
		cashEntry.setReference('CSH1');
		cashentry.setAccount(CODABaseDataExt.NAMEACCOUNT_CHRYSLERMOTORSLLC);
		
		CODACashEntryTestHelper.LineItem lineItem = cashentry.newLine();
		lineItem.setCashEntryValue('100');

		cashentry.saveAndPost();

		CODACashEntryTestHelper cashEntry2 = new CODACashEntryTestHelper();
		cashentry2.setType(CODACashEntry.TYPE_PAYMENT);
		cashentry2.setBankAccount(CODABaseDataExt.NAMEBANKACC_BRISTOLDEPOSITACCOUNT);
		cashentry2.updateCashEntryCurrency();
		cashEntry2.setDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		cashEntry2.setReference('CSH2');
		cashentry2.setAccount(CODABaseDataExt.NAMEACCOUNT_CHRYSLERMOTORSLLC);
		
		CODACashEntryTestHelper.LineItem lineItem2 = cashentry2.newLine();
		lineItem2.setCashEntryValue('200');

		cashentry2.saveAndPost();
	}

	public static void createDataExt3()
	{
		CODATestIDMapExt.load(SUFFIX);

		CODAAPICashMatchingTypes_8_0.Configuration configuration = new CODAAPICashMatchingTypes_8_0.Configuration();
		CODAAPICommon.Reference ref = new CODAAPICommon.Reference();
		ref.Id = CODAAccountHelperForTests.getAccountByName(CODABaseDataExt.NAMEACCOUNT_CHRYSLERMOTORSLLC)[0].Id;
		configuration.Account = ref;
		configuration.MatchingCurrencyMode = CODAAPICashMatchingTypes_8_0.enumMatchingCurrencyMode.Account;
		configuration.MatchingDate = CODADataTestHelper.getSystemTestDate(SUFFIX);

		CODAAPICashMatchingTypes_8_0.Analysis analysisInfoAPI = new CODAAPICashMatchingTypes_8_0.Analysis();

		CODAAPICommon_8_0.Context context2 = new CODAAPICommon_8_0.Context();
		context2.CompanyName = CODABaseData.NAMECOMPANY_MERLINAUTOUSA;

		List<CODATransactionLineItem__c> cashEntryList = [Select id, Name, DocumentOutstandingValue__c, Transaction__c from CODATransactionLineItem__c where LineType__c='Account' and Transaction__r.TransactionType__c='Cash' and DocumentOutstandingValue__c=200.00];
		System.assertEquals(1, cashEntryList.size(), 'Cash Entry to be matched has not been found.');
		List<CODATransactionLineItem__c> invoiceList = [Select id, Name, DocumentOutstandingValue__c, Transaction__c from CODATransactionLineItem__c where LineType__c='Account' and Transaction__r.TransactionType__c='Purchase Invoice' and DocumentOutstandingValue__c=-200.00];
		System.assertEquals(1, invoiceList.size(), 'Invoice to be matched has not been found.');

		List<CODAAPICashMatchingTypes_8_0.Item> items =new List<CODAAPICashMatchingTypes_8_0.Item>();
		CODATransactionLineItem__c cashEntry = cashEntryList[0];
		CODAAPICashMatchingTypes_8_0.Item item = new CODAAPICashMatchingTypes_8_0.Item ();
		ref = new CODAAPICommon.Reference();
		ref.id = cashEntry.id;
		item.TransactionLineItem = ref;
		item.paid = 200;
		items.add(item);
	
		CODATransactionLineItem__c invoice = invoiceList[0];
		CODAAPICashMatchingTypes_8_0.Item item1 = new CODAAPICashMatchingTypes_8_0.Item ();
		ref = new CODAAPICommon.Reference();
		ref.id = invoice.id;
		item1.TransactionLineItem = ref;
		item1.paid = -200;
		items.add(item1);

		CODAAPICommon.Reference matchReference = CODAAPICashMatching_8_0.Match(context2, configuration, items, analysisInfoAPI);
		CODATestIDMapExt.put('TID020357', matchReference.getId());
		CODATestIDMapExt.save(SUFFIX);
	}

	public static void createDataExt4()
	{
		CODATestIDMapExt.load(SUFFIX);

		CODAPurchaseInvoiceTestHelper purchaseInvoice = new CODAPurchaseInvoiceTestHelper();

		purchaseInvoice.setAccount(CODABaseDataExt.NAMEACCOUNT_AUDI);
		purchaseInvoice.setInvoiceDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice.setVendorInvoiceNumber('PIN3');
		purchaseInvoice.setAccountInvoiceTotal('500');
		purchaseInvoice.setInvoiceCurrency(CODABaseData.CURRENCYCODE_USD);

		CODAPurchaseInvoiceTestHelper.ProductLineItem lineItem = purchaseInvoice.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		lineItem.setQuantity(1.00);
		lineItem.setUnitPrice(500.00);

		purchaseInvoice.saveAndPost();

		CODAPurchaseCreditNoteTestHelper purchaseCreditNote = new CODAPurchaseCreditNoteTestHelper();
		purchaseCreditNote.setAccount(CODABaseDataExt.NAMEACCOUNT_AUDI);
		purchaseCreditNote.setCreditNoteDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseCreditNote.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX)+20);
		purchaseCreditNote.setAccountCreditNoteTotal('600');
		purchaseCreditNote.setVendorCreditNoteNumber('PCN2');
		purchaseCreditNote.setCreditNoteCurrency(CODABaseData.CURRENCYCODE_USD);

		CODAPurchaseCreditNoteTestHelper.ProductLineItem productLine = purchaseCreditNote.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		productLine.setUnitPrice(600);
		productLine.setQuantity(1);

		purchaseCreditNote.saveAndPost();
	}

	public static void createDataExt5()
	{
		CODATestIDMapExt.load(SUFFIX);

		CODAPurchaseInvoiceTestHelper purchaseInvoice = new CODAPurchaseInvoiceTestHelper();

		purchaseInvoice.setAccount(CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES);
		purchaseInvoice.setInvoiceDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice.setVendorInvoiceNumber('PIN4');
		purchaseInvoice.setAccountInvoiceTotal('800');
		purchaseInvoice.setInvoiceCurrency(CODABaseData.CURRENCYCODE_EUR);


		CODAPurchaseInvoiceTestHelper.ProductLineItem lineItem = purchaseInvoice.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		lineItem.setQuantity(1.00);
		lineItem.setUnitPrice(800.00);
		purchaseInvoice.saveAndPost();
		purchaseInvoice.reload();
		purchaseInvoice.paymentOnHold();
	}

	public static void createDataExt6()
	{
		CODATestIDMapExt.load(SUFFIX);
		Set<String> specialPeriods = new Set<String> {'000', '100', '101'};
		codaPeriod__c period = [Select id, EndDate__c from codaPeriod__c where StartDate__c <= :CODADataTestHelper.getSystemTestDate(SUFFIX) and EndDate__c >= :CODADataTestHelper.getSystemTestDate(SUFFIX) and OwnerCompany__r.Name = :CODABaseData.NAMECOMPANY_MERLINAUTOUSA and Closed__c = false and PeriodNumber__c not in :specialPeriods];

		List<codaPayment__c> payList = new List<codaPayment__c>();
		codaPayment__c pay = new codaPayment__c();
		pay.PaymentCurrency__c = CODATestIDMap.resolve(CODABaseData.CURRENCYCODE_USD);
		pay.BankAccount__c = CODATestIDMap.resolve(CODABaseDataExt.NAMEBANKACC_BRISTOLCHECKINGACCOUNT);
		pay.OwnerCompany__c = CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOUSA);
		pay.CurrencyMode__c = 'Document';
		pay.CurrencyWriteOff__c = CODATestIDMap.resolve(CODABaseData.NAMEGLA_WRITEOFFUS);
		pay.Description__c = PPLUS_TST033507;
		pay.DocumentCurrency__c = CODATestIDMap.resolve(CODABaseData.CURRENCYCODE_USD);
		pay.PaymentDate__c = CODADataTestHelper.getSystemTestDate(SUFFIX);
		pay.PaymentMediaTypes__c = 'Check';
		pay.PaymentTypes__c = 'Payments';
		pay.SettlementDiscountReceived__c = CODATestIDMap.resolve(CODABaseData.NAMEGLA_SETTLEMENTDISCOUNTSALLOWEDUS);
		pay.Status__c = 'New';
		pay.CreatedByPaymentsPlus__c = true;
		pay.DiscountDate__c = CODADataTestHelper.getSystemTestDate(SUFFIX) + 10;
		pay.period__c = period.Id;
		payList.add(pay);

		pay = new codaPayment__c();
		pay.PaymentCurrency__c = CODATestIDMap.resolve(CODABaseData.CURRENCYCODE_EUR);
		pay.BankAccount__c = CODATestIDMap.resolve(CODABaseDataExt.NAMEBANKACC_BRISTOLCHECKINGACCOUNT);
		pay.OwnerCompany__c = CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOUSA);
		pay.CurrencyMode__c = 'Document';
		pay.CurrencyWriteOff__c = CODATestIDMap.resolve(CODABaseData.NAMEGLA_WRITEOFFUS);
		pay.Description__c = PPLUS_10_DAYS_AGO;
		pay.DocumentCurrency__c = CODATestIDMap.resolve(CODABaseData.CURRENCYCODE_EUR);
		pay.PaymentDate__c = CODADataTestHelper.getSystemTestDate(SUFFIX) -10;
		pay.PaymentMediaTypes__c = 'Check';
		pay.PaymentTypes__c = 'Payments';
		pay.SettlementDiscountReceived__c = CODATestIDMap.resolve(CODABaseData.NAMEGLA_SETTLEMENTDISCOUNTSALLOWEDUS);
		pay.Status__c = 'New';
		pay.CreatedByPaymentsPlus__c = true;
		pay.DiscountDate__c = CODADataTestHelper.getSystemTestDate(SUFFIX) + 10;
		pay.period__c = period.Id;
		payList.add(pay);

		insert payList;
	}

	public static void destroyData()
	{
		CODATestIDMapExt.load(SUFFIX);
		CODAContext.enableSupportAccess();
		CODADataTestHelper.deleteSystemTestDate(SUFFIX);
		Account acc= [select id, Name, CODAPaymentMethod__c  from Account where MirrorName__c= :CODABaseDataExt.NAMEACCOUNT_CHRYSLERMOTORSLLC][0];
		acc.CODAPaymentMethod__c = CODAPayment.PAYMENTMETHOD_CHECK;
		update acc;
		delete [select Id from codaCashEntry__c];
		delete [select Id from codaJournal__c];
		delete [select Id from codaPurchaseCreditNote__c];
		delete [select Id from codaPurchaseInvoice__c];
		delete [select Id from codaTransaction__c];
		delete [select Id from codaAccountingSettings__c];
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

		// Periods for Merlin Auto Spain
		for (codaPeriod__c period : [SELECT Id, Name FROM codaPeriod__c WHERE YearName__r.Name = :String.valueof(ACTUAL_YEAR) AND OwnerCompany__c = :compId])
		{
			CODATestIDMapExt.put(period.Name, period.id);
		}

		// General Ledger Account
		Set<String> glaNames = new Set<String>();
		glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLUSD);
		glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLEUR);
		glaNames.add(CODABaseData.NAMEGLA_SALESPARTS);
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
		for (CODABankAccount__c account : [SELECT Id, Name FROM codaBankAccount__c WHERE Name in :bankAccouns and OwnerCompany__c = :compID])
		{
			CODATestIDMapExt.put(account.Name, account.id);
		}

		CODATestIDMapExt.save(SUFFIX);
	}
}