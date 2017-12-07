/*
* Copyright (c) 2017 FinancialForce.com, inc.  All rights reserved.
*/
public class CODATID021225Data
{
	public static String SUFFIX='TID021225#';
	public static string PAYMENT_NAME='TID021225PAYMENT1';
	public static string PPLUS1_NEW='PPLUS1-NEW';
	public static string PPLUS2_PROPOSED ='PPLUS2-PROPOSED';
	public static string PPLUS3_MEDIAPREPARED=	'PPLUS3-MEDIAPREPARED';
	public static string PPLUS4_MEDIAPREPAREDERROR ='PPLUS4-MEDIAPREPAREDERROR';
	public static Integer ACTUAL_YEAR= System.today().year();

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

	  list<PaymentsPlusSettings__c> payPlussettingList = [select id from PaymentsPlusSettings__c];
	  if (payPlussettingList.size()>0) {
		  payPlussettingList[0].CreateMediaDataBatchLineLimit__c = 1;
		  payPlussettingList[0].CreateMediaBatchScope__c =1;
		  update payPlussettingList;
	  }
	  else {
		  PaymentsPlusSettings__c payPlussetting = new PaymentsPlusSettings__c();
		  payPlussetting.CreateMediaDataBatchLineLimit__c = 1;
		  payPlussetting.CreateMediaBatchScope__c =1;
		  insert payPlussetting;
	  }

	  Account acc= [select id, Name, CODAPaymentMethod__c  from Account where MirrorName__c= :CODABaseDataExt.NAMEACCOUNT_CHRYSLERMOTORSLLC][0];
	  acc.CODAPaymentMethod__c = CODAPayment.PAYMENTMETHOD_ELECTRONIC;
	  update acc;
	}

	public static void createDataExt1() 
	{
		CODATestIDMapExt.load(SUFFIX);
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

		purchaseInvoice = new CODAPurchaseInvoiceTestHelper();
		purchaseInvoice.setAccount(CODABaseDataExt.NAMEACCOUNT_AUDI);
		purchaseInvoice.setInvoiceDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX) + 10);
		purchaseInvoice.setVendorInvoiceNumber('PIN2');
		purchaseInvoice.setAccountInvoiceTotal('300');

		lineItem = purchaseInvoice.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		lineItem.setQuantity(1.00);
		lineItem.setUnitPrice(300.00);
		purchaseInvoice.saveAndPost();

		codaTransactionLineItem__c transLineItem = [select id from codaTransactionLineItem__c where Transaction__r.VendorDocumentNumber__c = 'PIN1' and LineType__c = 'Account'][0];
		CODATestIDMapExt.put('TLI1', transLineItem.Id);

		transLineItem = [select id from codaTransactionLineItem__c where Transaction__r.VendorDocumentNumber__c = 'PIN2' and LineType__c = 'Account'][0];
		CODATestIDMapExt.put('TLI2', transLineItem.Id);
		CODATestIDMapExt.save(SUFFIX);
	}

	public static void createDataExt2()
	{
		CODATestIDMapExt.load(SUFFIX);
		CODAPurchaseInvoiceTestHelper purchaseInvoice = new CODAPurchaseInvoiceTestHelper();

		purchaseInvoice.setAccount(CODABaseDataExt.NAMEACCOUNT_CHRYSLERMOTORSLLC);
		purchaseInvoice.setInvoiceDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX) + 10);
		purchaseInvoice.setVendorInvoiceNumber('PIN3');
		purchaseInvoice.setAccountInvoiceTotal('149');
		purchaseInvoice.setInvoiceCurrency(CODABaseData.CURRENCYCODE_EUR);

		CODAPurchaseInvoiceTestHelper.ProductLineItem lineItem = purchaseInvoice.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		lineItem.setQuantity(1.00);
		lineItem.setUnitPrice(149.00);
		purchaseInvoice.saveAndPost();

		CODAPurchaseInvoiceTestHelper purchaseInvoice2 = new CODAPurchaseInvoiceTestHelper();

		purchaseInvoice2.setAccount(CODABaseDataExt.NAMEACCOUNT_MERCEDESBENZINC);
		purchaseInvoice2.setInvoiceDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice2.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice2.setVendorInvoiceNumber('PIN4');
		purchaseInvoice2.setAccountInvoiceTotal('149');
		purchaseInvoice2.setInvoiceCurrency(CODABaseData.CURRENCYCODE_EUR);

		CODAPurchaseInvoiceTestHelper.ProductLineItem lineItem2 = purchaseInvoice2.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		lineItem2.setQuantity(1.00);
		lineItem2.setUnitPrice(149.00);
		purchaseInvoice2.saveAndPost();

		codaTransactionLineItem__c transLineItem = [select id from codaTransactionLineItem__c where Transaction__r.VendorDocumentNumber__c = 'PIN3' and LineType__c = 'Account'][0];
		CODATestIDMapExt.put('TLI3', transLineItem.Id);

		transLineItem = [select id from codaTransactionLineItem__c where Transaction__r.VendorDocumentNumber__c = 'PIN4' and LineType__c = 'Account'][0];
		CODATestIDMapExt.put('TLI4', transLineItem.Id);
		CODATestIDMapExt.save(SUFFIX);
	}

	public static void createDataExt3()
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
		pay.Description__c = PPLUS1_NEW;
		pay.DocumentCurrency__c = CODATestIDMap.resolve(CODABaseData.CURRENCYCODE_EUR);
		pay.PaymentDate__c = system.today();
		pay.PaymentMediaTypes__c = 'Check';
		pay.PaymentTypes__c = 'Payments';
		pay.SettlementDiscountReceived__c = CODATestIDMap.resolve(CODABaseData.NAMEGLA_SETTLEMENTDISCOUNTSALLOWEDUS);
		pay.Status__c = 'New';
		pay.CreatedByPaymentsPlus__c = true;
		pay.DiscountDate__c = system.today() + 10;
		pay.Period__c = period.Id;
		payList.add(pay);

		pay = new codaPayment__c();
		pay.PaymentCurrency__c = CODATestIDMap.resolve(CODABaseData.CURRENCYCODE_EUR);
		pay.BankAccount__c = CODATestIDMap.resolve(CODABaseDataExt.NAMEBANKACC_BRISTOLEUROSACCOUNT);
		pay.OwnerCompany__c = CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOUSA);
		pay.CurrencyMode__c = 'Document';
		pay.CurrencyWriteOff__c = CODATestIDMap.resolve(CODABaseData.NAMEGLA_WRITEOFFUS);
		pay.Description__c = PPLUS2_PROPOSED;
		pay.DocumentCurrency__c = CODATestIDMap.resolve(CODABaseData.CURRENCYCODE_EUR);
		pay.PaymentDate__c = system.today();
		pay.PaymentMediaTypes__c = 'Check';
		pay.PaymentTypes__c = 'Payments';
		pay.SettlementDiscountReceived__c = CODATestIDMap.resolve(CODABaseData.NAMEGLA_SETTLEMENTDISCOUNTSALLOWEDUS);
		pay.Status__c = 'New';
		pay.CreatedByPaymentsPlus__c = true;
		pay.DiscountDate__c = system.today() + 10;
		pay.Period__c = period.Id;
		payList.add(pay);
		insert payList;

		pay = [select id, Name from codaPayment__c where Description__c = 'PPLUS2-PROPOSED'];

		// add TLI3 to proposal
		List<Id> transLineIDList = new List<Id> {CODATestIDMap.resolve('TLI3')};
		PaymentsPlusService.addToProposal(pay.Id, transLineIDList);
	}


	public static void createDataExt4()
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
		pay.Description__c = PPLUS3_MEDIAPREPARED;
		pay.DocumentCurrency__c = CODATestIDMap.resolve(CODABaseData.CURRENCYCODE_EUR);
		pay.PaymentDate__c = system.today();
		pay.PaymentMediaTypes__c = 'Check';
		pay.PaymentTypes__c = 'Payments';
		pay.SettlementDiscountReceived__c = CODATestIDMap.resolve(CODABaseData.NAMEGLA_SETTLEMENTDISCOUNTSALLOWEDUS);
		pay.Status__c = 'New';
		pay.CreatedByPaymentsPlus__c = true;
		pay.DiscountDate__c = system.today() + 10;
		pay.period__c = period.Id;
		payList.add(pay);

		insert payList;

		pay = [select id, Name from codaPayment__c where Description__c = 'PPLUS3-MEDIAPREPARED'];

		// add TLI3 to proposal
		List<Id> transLineIDList = new List<Id> {CODATestIDMap.resolve('TLI4')};
		PaymentsPlusService.addToProposal(pay.Id, transLineIDList);
	}


	public static void createDataExt5()
	{
		CODATestIDMapExt.load(SUFFIX);
		codaPayment__c pay = [select id, Name, Status__c from codaPayment__c where Description__c = 'PPLUS3-MEDIAPREPARED'];
		PaymentsPlusService.createMediaData(pay.Id);
	}

	public static void createDataExt6()
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
		pay.Description__c = PPLUS4_MEDIAPREPAREDERROR;
		pay.DocumentCurrency__c = CODATestIDMap.resolve(CODABaseData.CURRENCYCODE_EUR);
		pay.PaymentDate__c = system.today();
		pay.PaymentMediaTypes__c = 'Check';
		pay.PaymentTypes__c = 'Payments';
		pay.SettlementDiscountReceived__c = CODATestIDMap.resolve(CODABaseData.NAMEGLA_SETTLEMENTDISCOUNTSALLOWEDUS);
		pay.Status__c = 'New';
		pay.CreatedByPaymentsPlus__c = true;
		pay.DiscountDate__c = system.today() + 10;
		pay.period__c = period.Id;
		payList.add(pay);

		insert payList;
		
		pay = [select id, Name from codaPayment__c where Description__c = 'PPLUS4-MEDIAPREPAREDERROR'];

		// add TLI1, TLI2 to proposal
		List<Id> transLineIDList = new List<Id> {CODATestIDMap.resolve('TLI1'), CODATestIDMap.resolve('TLI2') };
		PaymentsPlusService.addToProposal(pay.Id, transLineIDList);
		Account audi = [select id, CODAAccountsPayableControl__c from Account where MirrorName__c = :CODABaseDataExt.NAMEACCOUNT_AUDI][0];
		audi.CODAAccountsPayableControl__c = CODATestIDMap.resolve(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLUSD);
		update audi;
	}

	public static void createDataExt7() {  
		CODAContext.SetService(true); 
		CODAUnitOfWork.getCurrent();
		CODABankAccount bankAccount = CODABankAccountMapper.getByName(CODABaseDataExt.NAMEBANKACC_BRISTOLEUROSACCOUNT)[0];
		CODACheckRange cRange = new CODACheckRange();
		cRange.setCheckRangeName('CHR001');
		cRange.setBankAccount(bankAccount);
		cRange.setStartCheckNumber('000001');
		cRange.setLastCheckNumber('000100');
		cRange.setActivated(true);
		CODAUnitOfWork.getCurrent().commitWork();
	}
  
	public static void destroyData()
	{
		CODATestIDMapExt.load(SUFFIX);
		CODAContext.enableSupportAccess();
		CODADataTestHelper.deleteSystemTestDate(SUFFIX);
		List<Account> accList = new List<Account>();
		Account crys= [select id, Name, CODAPaymentMethod__c from Account where MirrorName__c= :CODABaseDataExt.NAMEACCOUNT_CHRYSLERMOTORSLLC][0];
		Account audi = [select id, CODAAccountsPayableControl__c from Account where MirrorName__c = :CODABaseDataExt.NAMEACCOUNT_AUDI][0];
		crys.CODAPaymentMethod__c = CODAPayment.PAYMENTMETHOD_CHECK;
		audi.CODAAccountsPayableControl__c = CODATestIDMap.resolve(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLEUR);
		accList.add(crys);
		accList.add(audi);
		update accList;

		delete [select Id from PaymentsPlusErrorLog__c];
		delete [select Id from codaCashEntry__c];
		delete [select Id from codaJournal__c];
		delete [select Id from codaCashMatchingHistory__c];
		delete [select Id from codaPurchaseCreditNote__c];
		delete [select Id from codaPurchaseInvoice__c];
		delete [select Id from codaTransaction__c];
		delete [select Id from codaAccountingSettings__c];
		delete [select Id from codaPayment__c];
		delete [select Id from codaPaymentMediaDetail__c];
		delete [select Id from codaPaymentMediaSummary__c];
		delete [select Id from codaPaymentMediaControl__c];
		delete [select Id from codaCheckRange__c];
		delete [select Id from codaCheckNumber__c];
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
		accNames.add(CODABaseDataExt.NAMEACCOUNT_MERCEDESBENZINC);

		for (Account accId : [SELECT Id, Name FROM Account WHERE MirrorName__c in :accNames])
		{
			CODATestIDMapExt.put(accId.Name, accId.id);
		}
		
		// Bank Accounts
		Set<String> bankAccouns = new Set<String>();
		bankAccouns.add(CODABaseDataExt.NAMEBANKACC_BRISTOLEUROSACCOUNT);

		for (CODABankAccount__c account : [SELECT Id, Name FROM codaBankAccount__c WHERE Name in :bankAccouns and OwnerCompany__c = :compID])
		{
			CODATestIDMapExt.put(account.Name, account.id);
		}
		CODATestIDMapExt.save(SUFFIX);
	}
}