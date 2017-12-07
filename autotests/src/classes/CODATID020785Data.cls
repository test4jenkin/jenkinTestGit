/*
* Copyright (c) 2016 FinancialForce.com, inc.  All rights reserved.
*/
public class CODATID020785Data
{
	public static String SUFFIX = 'TID020785#';
	public static Integer ACTUAL_YEAR = System.today().year();
	public static String PPLUS_PAYMENT1 = 'PPLUS-PAYMENT1';

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

		CODAPurchaseInvoiceTestHelper purchaseInvoice = new CODAPurchaseInvoiceTestHelper();

		purchaseInvoice.setAccount(CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES);
		purchaseInvoice.setInvoiceDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice.setVendorInvoiceNumber('PIV3');
		purchaseInvoice.setAccountInvoiceTotal('149.00');
		purchaseInvoice.setInvoiceCurrency(CODABaseData.CURRENCYCODE_EUR);

		CODAPurchaseInvoiceTestHelper.ProductLineItem lineItem = purchaseInvoice.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		lineItem.setQuantity(1.00);
		lineItem.setUnitPrice(149.00);

		purchaseInvoice.saveAndPost();

		CODAPurchaseInvoiceTestHelper purchaseInvoice3 = new CODAPurchaseInvoiceTestHelper();

		purchaseInvoice3.setAccount(CODABaseDataExt.NAMEACCOUNT_AUDI);
		purchaseInvoice3.setInvoiceDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice3.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice3.setVendorInvoiceNumber('PIN3');
		purchaseInvoice3.setAccountInvoiceTotal('149.00');
		purchaseInvoice3.setInvoiceCurrency(CODABaseData.CURRENCYCODE_EUR);

		CODAPurchaseInvoiceTestHelper.ProductLineItem lineItem1 = purchaseInvoice3.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		lineItem1.setQuantity(1.00);
		lineItem1.setUnitPrice(149.00);
		purchaseInvoice3.saveAndPost();
	}

	public static void createDataExt2()
	{
		CODATestIDMapExt.load(SUFFIX);
		CODAPurchaseInvoiceTestHelper purchaseInvoice4 = new CODAPurchaseInvoiceTestHelper();
		purchaseInvoice4.setAccount(CODABaseDataExt.NAMEACCOUNT_AUDI);
		purchaseInvoice4.setInvoiceDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice4.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice4.setVendorInvoiceNumber('PIN4');
		purchaseInvoice4.setAccountInvoiceTotal('149.00');
		purchaseInvoice4.setInvoiceCurrency(CODABaseData.CURRENCYCODE_EUR);

		CODAPurchaseInvoiceTestHelper.ProductLineItem lineItem1 = purchaseInvoice4.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		lineItem1.setQuantity(1.00);
		lineItem1.setUnitPrice(149.00);

		purchaseInvoice4.saveAndPost();
		purchaseInvoice4.reload();
		purchaseInvoice4.paymentOnHold();

	}

	public static void createDataext3()
	{
		CODATestIDMapExt.load(SUFFIX);

		CODACashEntryTestHelper cashEntry = new CODACashEntryTestHelper();
		cashentry.setType(CODACashEntry.TYPE_PAYMENT);
		cashentry.setBankAccount(CODABaseDataExt.NAMEBANKACC_BRISTOLDEPOSITACCOUNT);
		cashentry.setCurrency(CODABaseData.CURRENCYCODE_EUR);
		cashEntry.setDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		cashEntry.setReference('CSH1');
		cashentry.setAccount(CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES);
		
		CODACashEntryTestHelper.LineItem lineItem = cashentry.newLine();
		lineItem.setCashEntryValue('149');

		cashentry.saveAndPost();
	}


	public static void createDataext4()
	{
		CODATestIDMapExt.load(SUFFIX);
		Set<String> specialPeriods = new Set<String> {'000', '100', '101'};
		codaPeriod__c period = [Select id, EndDate__c from codaPeriod__c where StartDate__c <= :CODADataTestHelper.getSystemTestDate(SUFFIX) and EndDate__c >= :CODADataTestHelper.getSystemTestDate(SUFFIX) and OwnerCompany__r.Name = :CODABaseData.NAMECOMPANY_MERLINAUTOUSA and Closed__c = false and PeriodNumber__c not in :specialPeriods];

		codaPayment__c pay = new codaPayment__c();
		pay.PaymentCurrency__c = CODATestIDMap.resolve(CODABaseData.CURRENCYCODE_EUR);
		pay.BankAccount__c = CODATestIDMap.resolve(CODABaseDataExt.NAMEBANKACC_BRISTOLDEPOSITACCOUNT);
		pay.OwnerCompany__c = CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOUSA);
		pay.CurrencyMode__c = 'Document';
		pay.CurrencyWriteOff__c = CODATestIDMap.resolve(CODABaseData.NAMEGLA_WRITEOFFUS);
		pay.Description__c = PPLUS_PAYMENT1;
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

	public static void createDataext5()
	{
		CODATestIDMapExt.load(SUFFIX);
		codaPayment__c pay = [select id from codaPayment__c where Description__c =:PPLUS_PAYMENT1];

		Set<Id> transLineIDs = new Map<Id,codaTransactionLineItem__c>([Select Id from codaTransactionLineItem__c where LineType__c = 'Account' and transaction__r.VendorDocumentNumber__c IN ('PIN1', 'PIN2','PIN3','PIN4')]).keySet();
		List<Id> transLineIDListToRemove = new List<Id> (transLineIDs);
		PaymentsPlusService.removeFromProposal(pay.Id, transLineIDListToRemove);
	}

	public static void destroyData()
	{
		CODATestIDMapExt.load(SUFFIX);
		CODAContext.enableSupportAccess();
		CODADataTestHelper.deleteSystemTestDate(SUFFIX);

		delete [select Id from codaCashEntry__c];
		delete [select Id from codaPurchaseInvoice__c];
		delete [select id from codaPayment__c];
		delete [select Id from codaTransaction__c];
		delete [select Id from codaAccountingSettings__c];
		delete [select id from codaCashMatchingHistory__c];
		delete [select id from codaMatchingReference__c];
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
		accNames.add(CODABaseDataExt.NAMEACCOUNT_AUDI);
		accNames.add(CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES);

		for (Account accId : [SELECT Id, Name FROM Account WHERE MirrorName__c in :accNames])
		{
			CODATestIDMapExt.put(accId.Name, accId.id);
		}
		
		// Bank Accounts
		Set<String> bankAccouns = new Set<String>();
		bankAccouns.add(CODABaseDataExt.NAMEBANKACC_BRISTOLDEPOSITACCOUNT);

		for (CODABankAccount__c account : [SELECT Id, Name FROM codaBankAccount__c WHERE Name in :bankAccouns and OwnerCompany__c = :compID])
		{
			CODATestIDMapExt.put(account.Name, account.id);
		}

		CODATestIDMapExt.save(SUFFIX);
	}
}