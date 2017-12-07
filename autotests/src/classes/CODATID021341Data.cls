/*
* Copyright (c) 2016 FinancialForce.com, inc.  All rights reserved.
*/
public class CODATID021341Data
{
    public static String SUFFIX = 'TID021341#';
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
        
  
        
		List<Account> accList = [SELECT Id, CODAAccountsPayableControl__c, CODAAccountsReceivableControl__c FROM Account WHERE MirrorName__c =:CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO or MirrorName__c =:CODABaseDataExt.NAMEACCOUNT_HOGANREPAIRS];

		for (Account acc: accList){
			acc.CODAAccountsPayableControl__c = acc.CODAAccountsReceivableControl__c;
		}
		
		update accList;

        CODAPurchaseInvoiceTestHelper purchaseInvoice = new CODAPurchaseInvoiceTestHelper();
        purchaseInvoice.setAccount(CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO);
        purchaseInvoice.setInvoiceDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
        purchaseInvoice.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX) + 10);
        purchaseInvoice.setVendorInvoiceNumber('PIN000001');
        purchaseInvoice.setAccountInvoiceTotal('10000');
        purchaseInvoice.setInvoiceCurrency(CODABaseData.CURRENCYCODE_USD);
        CODAPurchaseInvoiceTestHelper.ProductLineItem lineItem = purchaseInvoice.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
        lineItem.setQuantity(1.00);
        lineItem.setUnitPrice(10000.00);
        purchaseInvoice.saveAndPost();

        CODAPurchaseCreditNoteTestHelper purchaseCreditNote = new CODAPurchaseCreditNoteTestHelper();
        purchaseCreditNote.setAccount(CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO);
        purchaseCreditNote.setCreditNoteDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
        purchaseCreditNote.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX)+20);
        purchaseCreditNote.setAccountCreditNoteTotal('777');
        purchaseCreditNote.setVendorCreditNoteNumber('PCR000000');
        purchaseCreditNote.setCreditNoteCurrency(CODABaseData.CURRENCYCODE_USD);
        CODAPurchaseCreditNoteTestHelper.ProductLineItem productLine = purchaseCreditNote.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
        productLine.setUnitPrice(777.00);
        productLine.setQuantity(1);
        purchaseCreditNote.saveAndPost();
    }

    public static void createDataExt1() 
    {
        CODATestIDMapExt.load(SUFFIX);
        CODACashEntryTestHelper cashEntry = new CODACashEntryTestHelper();
        cashEntry.setType(CODACashEntry.TYPE_PAYMENT);
        cashEntry.setBankAccount(CODABaseDataExt.NAMEBANKACC_BRISTOLDEPOSITACCOUNT);
        cashEntry.updateCashEntryCurrency();
        cashEntry.setDate(CODADataTestHelper.getSystemTestDate(SUFFIX)-2);
        cashEntry.setReference('CSH000005');
        cashEntry.setAccount(CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO);
        CODACashEntryTestHelper.LineItem lineItem = cashEntry.newLine();
        lineItem.setCashEntryValue('880');
        cashEntry.saveAndPost();
 
        CODACashEntryTestHelper cashEntry2 = new CODACashEntryTestHelper();
        cashEntry2.setType(CODACashEntry.TYPE_PAYMENTREFUND);
        cashEntry2.setBankAccount(CODABaseDataExt.NAMEBANKACC_BRISTOLDEPOSITACCOUNT);
        cashEntry2.updateCashEntryCurrency();
        cashEntry2.setDate(CODADataTestHelper.getSystemTestDate(SUFFIX)-2);
        cashEntry2.setReference('CSH000006');
        cashEntry2.setAccount(CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO);
        CODACashEntryTestHelper.LineItem lineItem2 = cashEntry2.newLine();
        lineItem2.setCashEntryValue('50');
        cashEntry2.saveAndPost();
    }

    public static void createDataExt2() 
    {
        CODATestIDMapExt.load(SUFFIX);
        CODAJournalTestHelper jnl1 = new CODAJournalTestHelper();
        jnl1.setJournalDate(CODADataTestHelper.getSystemTestDate(SUFFIX)-1);
        jnl1.setJournalCurrency(CODABaseData.CURRENCYCODE_USD);
        jnl1.setReference('JNL000000');
        CODAJournalTestHelper.LineItem jnlLineItem1 = jnl1.newLine(CODAJournalLineItem.LINETYPE_ACCOUNTVENDOR, CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO);
        jnlLineItem1.setGeneralLedgerAccount(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD);
        jnlLineItem1.setAmount('100.00');
        CODAJournalTestHelper.LineItem jnlLineItem2 = jnl1.newLine(CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseData.NAMEGLA_SALESPARTS);
        jnlLineItem2.setAmount('-100.00');
        jnl1.save();
        jnl1.post();


        CODAJournalTestHelper jnl2 = new CODAJournalTestHelper();
        jnl2.setJournalDate(CODADataTestHelper.getSystemTestDate(SUFFIX)-1);
        jnl2.setJournalCurrency(CODABaseData.CURRENCYCODE_USD);
        jnl2.setReference('JNL000001');
        jnlLineItem1 = jnl2.newLine(CODAJournalLineItem.LINETYPE_ACCOUNTVENDOR, CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO);
        jnlLineItem1.setGeneralLedgerAccount(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD);
        jnlLineItem1.setAmount('-120.00');
        jnlLineItem2 = jnl2.newLine(CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseData.NAMEGLA_SALESPARTS);
        jnlLineItem2.setAmount('120.00');
        jnl2.save();
        jnl2.post();

    }

    public static void createDataExt3() 
    {
        CODATestIDMapExt.load(SUFFIX);
        CODAInvoiceTestHelper salesInv = new CODAInvoiceTestHelper();
        salesInv.setAccount(CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO);
        salesInv.setInvoiceDate(system.today());
        salesInv.setDueDate(system.today()+60);
        salesInv.setCustomerReference('SIN000001');
        CODAInvoiceTestHelper.LineItem line1 = salesInv.newLine();
        line1.setProduct(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
        line1.setQuantity(1);
        line1.setUnitPrice(5000);
        salesInv.saveAndPost();


        CODACreditNoteTestHelper cre = new CODACreditNoteTestHelper();
        cre.setAccount(CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO);
        cre.setCreditNoteCurrency(CODABaseData.CURRENCYCODE_USD);
        cre.setCreditNoteDate(System.today());
        cre.setCustomerReference('SCR000000');
        CODACreditNoteTestHelper.LineItem line = cre.newLine();
        line.setProduct(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
        line.setQuantity('1.0');
        line.setUnitPrice('777.00');
        cre.save();
        cre.reload();
        cre.post();
    }

    public static void createDataExt4() 
    {
        CODATestIDMapExt.load(SUFFIX);
        CODACashEntryTestHelper cashEntry = new CODACashEntryTestHelper();
        cashentry.setType(CODACashEntry.TYPE_RECEIPT);
        cashentry.setBankAccount(CODABaseDataExt.NAMEBANKACC_BRISTOLDEPOSITACCOUNT);
        cashentry.updateCashEntryCurrency();
        cashEntry.setDate(CODADataTestHelper.getSystemTestDate(SUFFIX)-2);
        cashEntry.setReference('CSH000002');
        cashentry.setAccount(CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO);
        CODACashEntryTestHelper.LineItem lineItem = cashentry.newLine();
        lineItem.setCashEntryValue('880');
        cashentry.saveAndPost();

        cashEntry = new CODACashEntryTestHelper();
        cashentry.setType(CODACashEntry.TYPE_REFUND);
        cashentry.setBankAccount(CODABaseDataExt.NAMEBANKACC_BRISTOLDEPOSITACCOUNT);
        cashentry.updateCashEntryCurrency();
        cashEntry.setDate(CODADataTestHelper.getSystemTestDate(SUFFIX)-2);
        cashEntry.setReference('CSH000003');
        cashentry.setAccount(CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO);
        lineItem = cashentry.newLine();
        lineItem.setCashEntryValue('50');
        cashentry.saveAndPost();
    }

    public static void createDataExt5() 
    {
        CODATestIDMapExt.load(SUFFIX);
        CODAJournalTestHelper jnl1 = new CODAJournalTestHelper();
        jnl1.setJournalDate(CODADataTestHelper.getSystemTestDate(SUFFIX)-1);
        jnl1.setJournalCurrency(CODABaseData.CURRENCYCODE_USD);
        jnl1.setReference('JNL000002');
        CODAJournalTestHelper.LineItem jnlLineItem1 = jnl1.newLine(CODAJournalLineItem.LINETYPE_ACCOUNTVENDOR, CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO);
        jnlLineItem1.setGeneralLedgerAccount(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD);
        jnlLineItem1.setAmount('-100.00');
        jnlLineItem1 = jnl1.newLine(CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseData.NAMEGLA_SALESPARTS);
        jnlLineItem1.setAmount('100.00');
        jnl1.save();
        jnl1.post();


        CODAJournalTestHelper jnl2 = new CODAJournalTestHelper();
        jnl2.setJournalDate(CODADataTestHelper.getSystemTestDate(SUFFIX)-1);
        jnl2.setJournalCurrency(CODABaseData.CURRENCYCODE_USD);
        jnl2.setReference('JNL000003');
        CODAJournalTestHelper.LineItem jnlLineItem2 = jnl2.newLine(CODAJournalLineItem.LINETYPE_ACCOUNTVENDOR, CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO);
        jnlLineItem2.setGeneralLedgerAccount(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD);
        jnlLineItem2.setAmount('120.00');
        jnlLineItem2 = jnl2.newLine(CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseData.NAMEGLA_SALESPARTS);
        jnlLineItem2.setAmount('-120.00');
        jnl2.save();
        jnl2.post();
    }

    public static void createDataExt6() 
    {
        CODATestIDMapExt.load(SUFFIX);
        CODAPurchaseInvoiceTestHelper purchaseInvoice = new CODAPurchaseInvoiceTestHelper();
        purchaseInvoice.setAccount(CODABaseDataExt.NAMEACCOUNT_HOGANREPAIRS);
        purchaseInvoice.setInvoiceDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
        purchaseInvoice.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX) + 10);
        purchaseInvoice.setVendorInvoiceNumber('PIN000001');
        purchaseInvoice.setAccountInvoiceTotal('5000');
        purchaseInvoice.setInvoiceCurrency(CODABaseData.CURRENCYCODE_USD);
        CODAPurchaseInvoiceTestHelper.ProductLineItem lineItem = purchaseInvoice.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
        lineItem.setQuantity(1.00);
        lineItem.setUnitPrice(5000.00);
        purchaseInvoice.saveAndPost();

        CODAPurchaseCreditNoteTestHelper purchaseCreditNote = new CODAPurchaseCreditNoteTestHelper();
        purchaseCreditNote.setAccount(CODABaseDataExt.NAMEACCOUNT_HOGANREPAIRS);
        purchaseCreditNote.setCreditNoteDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
        purchaseCreditNote.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX)+20);
        purchaseCreditNote.setAccountCreditNoteTotal('777');
        purchaseCreditNote.setVendorCreditNoteNumber('PCR000000');
        purchaseCreditNote.setCreditNoteCurrency(CODABaseData.CURRENCYCODE_USD);
        CODAPurchaseCreditNoteTestHelper.ProductLineItem productLine = purchaseCreditNote.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
        productLine.setUnitPrice(777.00);
        productLine.setQuantity(1);
        purchaseCreditNote.saveAndPost();
    }

    public static void createDataExt7() 
    {
        CODATestIDMapExt.load(SUFFIX);
        CODACashEntryTestHelper cashEntry = new CODACashEntryTestHelper();
        cashEntry.setType(CODACashEntry.TYPE_PAYMENT);
        cashEntry.setBankAccount(CODABaseDataExt.NAMEBANKACC_BRISTOLDEPOSITACCOUNT);
        cashEntry.updateCashEntryCurrency();
        cashEntry.setDate(CODADataTestHelper.getSystemTestDate(SUFFIX)-2);
        cashEntry.setReference('CSH000005');
        cashEntry.setAccount(CODABaseDataExt.NAMEACCOUNT_HOGANREPAIRS);
        CODACashEntryTestHelper.LineItem lineItem = cashEntry.newLine();
        lineItem.setCashEntryValue('880');
        cashEntry.saveAndPost();

        CODACashEntryTestHelper cashEntry2 = new CODACashEntryTestHelper();
        cashEntry2.setType(CODACashEntry.TYPE_PAYMENTREFUND);
        cashEntry2.setBankAccount(CODABaseDataExt.NAMEBANKACC_BRISTOLDEPOSITACCOUNT);
        cashEntry2.updateCashEntryCurrency();
        cashEntry2.setDate(CODADataTestHelper.getSystemTestDate(SUFFIX)-2);
        cashEntry2.setReference('CSH000006');
        cashEntry2.setAccount(CODABaseDataExt.NAMEACCOUNT_HOGANREPAIRS);
        lineItem = cashEntry2.newLine();
        lineItem.setCashEntryValue('50');
        cashEntry2.saveAndPost();
    }

    public static void createDataExt8() 
    {
        CODATestIDMapExt.load(SUFFIX);
        CODAJournalTestHelper jnl1 = new CODAJournalTestHelper();
        jnl1.setJournalDate(CODADataTestHelper.getSystemTestDate(SUFFIX)-1);
        jnl1.setJournalCurrency(CODABaseData.CURRENCYCODE_USD);
        jnl1.setReference('JNL000000');
        CODAJournalTestHelper.LineItem jnlLineItem1 = jnl1.newLine(CODAJournalLineItem.LINETYPE_ACCOUNTVENDOR, CODABaseDataExt.NAMEACCOUNT_HOGANREPAIRS);
        jnlLineItem1.setGeneralLedgerAccount(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD);
        jnlLineItem1.setAmount('100.00');
        CODAJournalTestHelper.LineItem jnlLineItem2 = jnl1.newLine(CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseData.NAMEGLA_SALESPARTS);
        jnlLineItem2.setAmount('-100.00');
        jnl1.save();
        jnl1.post();


        CODAJournalTestHelper jnl2 = new CODAJournalTestHelper();
        jnl2.setJournalDate(CODADataTestHelper.getSystemTestDate(SUFFIX)-1);
        jnl2.setJournalCurrency(CODABaseData.CURRENCYCODE_USD);
        jnl2.setReference('JNL000001');
        jnlLineItem1 = jnl2.newLine(CODAJournalLineItem.LINETYPE_ACCOUNTVENDOR, CODABaseDataExt.NAMEACCOUNT_HOGANREPAIRS);
        jnlLineItem1.setGeneralLedgerAccount(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD);
        jnlLineItem1.setAmount('-120.00');
        jnlLineItem2 = jnl2.newLine(CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseData.NAMEGLA_SALESPARTS);
        jnlLineItem2.setAmount('120.00');
        jnl2.save();
        jnl2.post();

    }

    public static void createDataExt9() 
    {
        CODATestIDMapExt.load(SUFFIX);
        CODAInvoiceTestHelper salesInv = new CODAInvoiceTestHelper();
        salesInv.setAccount(CODABaseDataExt.NAMEACCOUNT_HOGANREPAIRS);
        salesInv.setInvoiceCurrency(CODABaseData.CURRENCYCODE_USD);
        salesInv.setInvoiceDate(system.today());
        salesInv.setDueDate(system.today()+60);
        salesInv.setCustomerReference('SIN000001');
        CODAInvoiceTestHelper.LineItem line1 = salesInv.newLine();
        line1.setProduct(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
        line1.setQuantity(1);
        line1.setUnitPrice(10000);
        salesInv.saveAndPost();


        CODACreditNoteTestHelper cre = new CODACreditNoteTestHelper();
        cre.setAccount(CODABaseDataExt.NAMEACCOUNT_HOGANREPAIRS);
        cre.setCreditNoteCurrency(CODABaseData.CURRENCYCODE_USD);
        cre.setCreditNoteDate(System.today());
        cre.setCustomerReference('SCR000000');
        CODACreditNoteTestHelper.LineItem line = cre.newLine();
        line.setProduct(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
        line.setQuantity('1.0');
        line.setUnitPrice('777.00');
        cre.save();
        cre.reload();
        cre.post();
    }

    public static void createDataExt10() 
    {
        CODATestIDMapExt.load(SUFFIX);
        CODACashEntryTestHelper cashEntry = new CODACashEntryTestHelper();
        cashentry.setType(CODACashEntry.TYPE_RECEIPT);
        cashentry.setBankAccount(CODABaseDataExt.NAMEBANKACC_BRISTOLDEPOSITACCOUNT);
        cashentry.updateCashEntryCurrency();
        cashEntry.setDate(CODADataTestHelper.getSystemTestDate(SUFFIX)-2);
        cashEntry.setReference('CSH000002');
        cashentry.setAccount(CODABaseDataExt.NAMEACCOUNT_HOGANREPAIRS);
        CODACashEntryTestHelper.LineItem lineItem = cashentry.newLine();
        lineItem.setCashEntryValue('880');
        cashentry.saveAndPost();

        cashEntry = new CODACashEntryTestHelper();
        cashentry.setType(CODACashEntry.TYPE_REFUND);
        cashentry.setBankAccount(CODABaseDataExt.NAMEBANKACC_BRISTOLDEPOSITACCOUNT);
        cashentry.updateCashEntryCurrency();
        cashEntry.setDate(CODADataTestHelper.getSystemTestDate(SUFFIX)-2);
        cashEntry.setReference('CSH000003');
        cashentry.setAccount(CODABaseDataExt.NAMEACCOUNT_HOGANREPAIRS);
        lineItem = cashentry.newLine();
        lineItem.setCashEntryValue('50');
        cashentry.saveAndPost();
    }

    public static void createDataExt11() 
    {
        CODATestIDMapExt.load(SUFFIX);
        CODAJournalTestHelper jnl1 = new CODAJournalTestHelper();
        jnl1.setJournalDate(CODADataTestHelper.getSystemTestDate(SUFFIX)-1);
        jnl1.setJournalCurrency(CODABaseData.CURRENCYCODE_USD);
        jnl1.setReference('JNL000002');
        CODAJournalTestHelper.LineItem jnlLineItem1 = jnl1.newLine(CODAJournalLineItem.LINETYPE_ACCOUNTVENDOR, CODABaseDataExt.NAMEACCOUNT_HOGANREPAIRS);
        jnlLineItem1.setGeneralLedgerAccount(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD);
        jnlLineItem1.setAmount('-100.00');
        jnlLineItem1 = jnl1.newLine(CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseData.NAMEGLA_SALESPARTS);
        jnlLineItem1.setAmount('100.00');
        jnl1.save();
        jnl1.post();


        CODAJournalTestHelper jnl2 = new CODAJournalTestHelper();
        jnl2.setJournalDate(CODADataTestHelper.getSystemTestDate(SUFFIX)-1);
        jnl2.setJournalCurrency(CODABaseData.CURRENCYCODE_USD);
        jnl2.setReference('JNL000003');
        jnlLineItem1 = jnl2.newLine(CODAJournalLineItem.LINETYPE_ACCOUNTVENDOR, CODABaseDataExt.NAMEACCOUNT_HOGANREPAIRS);
        jnlLineItem1.setGeneralLedgerAccount(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD);
        jnlLineItem1.setAmount('120.00');
        jnlLineItem1 = jnl2.newLine(CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseData.NAMEGLA_SALESPARTS);
        jnlLineItem1.setAmount('-120.00');
        jnl2.save();
        jnl2.post();
    }
 
   public static void destroyData()
    {
		CODATestIDMapExt.load(SUFFIX);
		CODAContext.enableSupportAccess();
		List<Account> accList = [SELECT Id, CODAAccountsPayableControl__c FROM Account WHERE MirrorName__c =:CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO or MirrorName__c =:CODABaseDataExt.NAMEACCOUNT_HOGANREPAIRS];

		for (Account acc: accList){
			acc.CODAAccountsPayableControl__c = NULL;
		}
		update accList;
		CODADataTestHelper.deleteSystemTestDate(SUFFIX);
		delete [select Id from PaymentsPlusErrorLog__c];
		delete [select Id from codaCashEntry__c];
		delete [select Id from codaJournal__c];
		delete [select Id from codaPurchaseCreditNote__c];
		delete [select Id from codaPurchaseInvoice__c];
		delete [select Id from codaTransaction__c];
		delete [select Id from codaAccountingSettings__c];
		delete [select Id from codaPayment__c];
        delete [select Id from codaInvoice__c];
		delete [select Id from codacreditnote__c];
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
        glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD);
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
        accNames.add(CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO);
        accNames.add(CODABaseDataExt.NAMEACCOUNT_AUDI);
        accNames.add(CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES);
        accNames.add(CODABaseDataExt.NAMEACCOUNT_HOGANREPAIRS);
 
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

        CODATestIDMapExt.save(SUFFIX);
    }
}