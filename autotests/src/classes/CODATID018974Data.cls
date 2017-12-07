/*
 * Copyright (c) 2016 FinancialForce.com, inc. All rights reserved.
 */
public class CODATID018974Data
{
    public static final String SUFFIX = 'TID018974';
    public static final string PINV_REFERENCE = 'PINV'+SUFFIX;
    public static final string PCRN_REFERENCE = 'PCRN'+SUFFIX;
    public static final string CSH_REFERENCE = 'CE'+SUFFIX;
    public static final String JOURNAL_REFERENCE = 'JNL'+SUFFIX;
    public static final String SINV_REFERENCE = 'SIN'+SUFFIX;
    public static final String SCN_REFERENCE = 'SCN'+SUFFIX;
    public static String COMPANY_NAME = CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN; 
    public static String PERIODNAME_CURRENT = CODAPeriodMapExt.getPeriodByDate(system.today()).getName();
    
    public static void selectCompany()
    {
        CODABaseData.switchCurrentCompany(COMPANY_NAME, true, true, UserInfo.getUserId());
    }
    
    public static void switchProfile()
    {
        Id userId = CODABaseData.getProfile(CODABaseData.SYSADMIN).Id;
        CODABaseData.switchCurrentCompany(COMPANY_NAME, true, false, userId);
    }
    
    public static void createData()
    {
        // Sales Invoice 1
        loadMap();        
        CODAInvoiceTestHelper invoice = new CODAInvoiceTestHelper();
        invoice.setAccount(CODABaseDataExt.NAMEACCOUNT_HOGANREPAIRS);
        invoice.setInvoiceDate(system.today());
        invoice.setInvoiceCurrency(CODABaseData.CURRENCYCODE_EUR);
        invoice.setCustomerReference(SINV_REFERENCE);
        
        CODAInvoiceTestHelper.LineItem line = invoice.newLine();
        line.setProduct(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
        line.setUnitPrice(74.5);
        line.setQuantity(1);
        line.setTaxCode1(CODABaseDataExt.NAMETAXCODE_VOSTDSALES);           
        
        invoice.save();
        invoice.reload();
        invoice.post();
        CODATestIDMapExt.put(SINV_REFERENCE, invoice.getId());
        CODATestIDMapExt.save(SUFFIX);
    }  
    
    public static void createDataExt1()
    {
        // Sales Credit Note
        CODATestIDMapExt.load(SUFFIX);       
        CODACreditNoteTestHelper cre = new CODACreditNoteTestHelper();
        cre.setAccount(CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO);
        cre.setCreditNoteCurrency(CODABaseData.CURRENCYCODE_USD);
        cre.setCreditNoteDate(System.today());
        cre.setCustomerReference(SCN_REFERENCE);

        {
            CODACreditNoteTestHelper.LineItem line = cre.newLine();
            line.setProduct(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
            line.setQuantity('1.00');
            line.setUnitPrice('15.00');
            line.setTaxCode1(CODABaseDataExt.NAMETAXCODE_VOSTDSALES);
            line.setTaxValue1(2.63);
        }
        
        cre.save();
        cre.reload();
        cre.post();
        CODATestIDMapExt.put(SCN_REFERENCE, cre.getId());
        CODATestIDMapExt.save(SUFFIX);
    }
    
    public static void createDataExt2()
    {
        // Purchase Invoice
        CODATestIDMapExt.load(SUFFIX);
        CODAPurchaseInvoiceTestHelper pInv = new CODAPurchaseInvoiceTestHelper();
        pInv.setAccount(CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES);
        pInv.setInvoiceCurrency(CODABaseData.CURRENCYCODE_EUR + ':' + CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN);
        pInv.setInvoiceDate(System.today());
        {
            CODAPurchaseInvoiceTestHelper.ExpenseLineItem expLine = pInv.newExpenseLine(CODABaseData.NAMEGLA_SALESPARTS);
            expLine.setNetValue(220.00);
            expLine.setTaxCode(CODABaseDataExt.NAMETAXCODE_VOSTDPURCHASE);
            expLine.setTaxValue1('38.50');
            
            CODAPurchaseInvoiceTestHelper.ProductLineItem line = pInv.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
            line.setQuantity('1.00');
            line.setUnitPrice('156.00');
            line.setTaxCode(CODABaseDataExt.NAMETAXCODE_VORPURCHASE);
            line.setTaxValue1('7.80');
        }
        
        pInv.setVendorInvoiceNumber(PINV_REFERENCE);
        pInv.setAccountInvoiceTotal('422.30');
        
        pInv.save();
        pInv.reload();
        pInv.post();
        CODATestIDMapExt.put(PINV_REFERENCE, pInv.getId());
        CODATestIDMapExt.save(SUFFIX);    
    }
    
    public static void createDataExt3()
    {   
        //Payable Credit Note
        CODATestIDMapExt.load(SUFFIX);
        CODAPurchaseCreditNoteTestHelper pCre = new CODAPurchaseCreditNoteTestHelper();
        pCre.setAccount(CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES);
        pCre.setCreditNoteCurrency(CODABaseData.CURRENCYCODE_EUR + ':' + CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN);
        pCre.setCreditNoteDate(System.today());
        {
            CODAPurchaseCreditNoteTestHelper.ExpenseLineItem expLine = pCre.newExpenseLine(CODABaseData.NAMEGLA_SALESPARTS);
            expLine.setNetValue(100.00);
            expLine.setTaxCode(CODABaseDataExt.NAMETAXCODE_VOSTDPURCHASE);
            expLine.setTaxValue1('17.50');
            
            CODAPurchaseCreditNoteTestHelper.ProductLineItem line = pCre.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
            line.setQuantity('1.00');
            line.setUnitPrice('100.00');
            line.setTaxCode(CODABaseDataExt.NAMETAXCODE_VORPURCHASE);
            line.setTaxValue1('5.00');
        }
        
        pCre.setVendorCreditNoteNumber(PCRN_REFERENCE);
        pCre.setAccountCreditNoteTotal('222.50');
        
        pCre.save();
        pCre.reload();
        pCre.post();
        CODATestIDMapExt.put(PCRN_REFERENCE, pCre.getId());
        CODATestIDMapExt.save(SUFFIX); 
    }
    
    public static void createDataExt4()
    {   
        //Cash Entry
        CODATestIDMapExt.load(SUFFIX);
        CODACashEntryTestHelper ce = new CODACashEntryTestHelper();
        ce.setType(CODACashEntry.TYPE_REFUND);
        ce.setBankAccount(CODABaseDataExt.NAMEBANKACC_SANTANDERCURRENTACCOUNT + ':' + CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN);
        ce.setCurrency(CODABaseData.CURRENCYCODE_EUR + ':' + CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN);
        ce.setDate(System.today());
        ce.setPaymentMethod(CODACashEntry.PAYMENTMETHOD_CASH);
        ce.setReference(CSH_REFERENCE);
        {
            ce.setAccount(CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO);
            CODACashEntryTestHelper.LineItem line = ce.newLine();
            line.setAccountReference(CSH_REFERENCE);
            line.setAccountPaymentMethod(CODACashEntryLineItem.ACCOUNTPAYMENTMETHOD_CASH);
            line.setCashEntryValue('73.33');
            line.setBankAccountValue('73.33');
        }

        ce.save();
        ce.reload();
        ce.post();
        CODATestIDMapExt.put(CSH_REFERENCE, ce.getId());
        CODATestIDMapExt.save(SUFFIX); 
    }
    
    public static void createDataExt5()
    {   
        //Journal
        CODATestIDMapExt.load(SUFFIX);
        CODAJournalTestHelper journal = new CODAJournalTestHelper();
        journal.setJournalCurrency(CODABaseData.CURRENCYCODE_EUR + ':' + CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN); 
        journal.setJournalDate(System.today());
        journal.setReference(JOURNAL_REFERENCE);
        {
            CODAJournalTestHelper.LineItem lineItem = journal.newLine(CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseData.NAMEGLA_SALESPARTS);
            lineItem.setAmount(600);
            
            CODAJournalTestHelper.LineItem lineItem2 = journal.newLine(CODAJournalLineItem.LINETYPE_PRODUCTPURCHASES, CODABaseDataExt.NAMEPRODUCT_BBKFUELPUMP);
            lineItem2.setGeneralLedgerAccount(CODABaseData.NAMEGLA_SALESPARTS);
            lineItem2.setAmount(-400);
            
            CODAJournalTestHelper.LineItem lineItem3 = journal.newLine(CODAJournalLineItem.LINETYPE_TAXCODE, CODABaseDataExt.NAMETAXCODE_VORSALES);
            lineItem3.setGeneralLedgerAccount(CODABaseData.NAMEGLA_SALESPARTS);
            lineItem3.setAmount(-200);
        }
        
        journal.save();
        journal.reload();
        journal.post();
        CODATestIDMapExt.put(JOURNAL_REFERENCE, journal.getId());
        CODATestIDMapExt.save(SUFFIX);
    }
    
    public static void destroyData()
    {
        CODAContext.setUnitTest(true);
        CODAContext.setDisableValidation(true);
        CODAContext.setUnitTest(false); 
        
        for(codaBudget__c[] stuff : [select Id from codaBudget__c])
            delete stuff;
        for(codaIntersectDefinition__c[] stuff : [select Id from codaIntersectDefinition__c])
            delete stuff;
        for(codaTransactionLineItem__c[] stuff : [Select Id from codaTransactionLineItem__c])
            delete stuff;
        for(codaTransaction__c[] stuff : [Select Id from codaTransaction__c])
            delete stuff;
        for(codaInvoiceLineItem__c[] stuff : [Select Id from codaInvoiceLineItem__c])
            delete stuff;
        for(codaInvoice__c[] stuff : [Select Id from codaInvoice__c])
            delete stuff;
        for(codaCreditNoteLineItem__c[] stuff : [select Id from codaCreditNoteLineItem__c])
            delete stuff;
        for(codaCreditNote__c[] stuff : [select Id from codaCreditNote__c])
            delete stuff;
        for(codaPurchaseInvoiceLineItem__c[] stuff : [select Id from codaPurchaseInvoiceLineItem__c])
            delete stuff;
        for(codaPurchaseInvoice__c[] stuff : [select Id from codaPurchaseInvoice__c])
            delete stuff;
        for(codaPurchaseCreditNoteLineItem__c[] stuff : [select Id from codaPurchaseCreditNoteLineItem__c])
            delete stuff;
        for(codaPurchaseCreditNote__c[] stuff : [select Id from codaPurchaseCreditNote__c])
            delete stuff;
        for(codaCashEntryLineItem__c[] stuff : [select Id from codaCashEntryLineItem__c])
            delete stuff;
        for(codaCashEntry__c[] stuff : [select Id from codaCashEntry__c])
            delete stuff;
        for(codaJournalLineItem__c[] stuff : [select Id from codaJournalLineItem__c])
            delete stuff;
        for(codaJournal__c[] stuff : [select Id from codaJournal__c])
            delete stuff;
        CODATestIDMapExt.purge(SUFFIX);
    }
    
    public static void loadMap()
    {
        // Accounts
        Set<String> accNames = new Set<String>();
        accNames.add(CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO);
        accNames.add(CODABaseDataExt.NAMEACCOUNT_CAMBRIDGEAUTO);
        accNames.add(CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES);
        accNames.add(CODABaseDataExt.NAMEACCOUNT_HOGANREPAIRS); 
        for (Account item : [Select Id, Name from Account where MirrorName__c in :accNames])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }
        
        // Products
        Set<String> proNames = new Set<String>();
        proNames.add(CODABaseDataExt.NAMEPRODUCT_BBKFUELPUMP);
        proNames.add(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
        for (Product2 item : [Select Id, Name from Product2 where Name in :proNames])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }
        
        // General Ledger Account
        Set<String> glaNames = new Set<String>();
        glaNames.add(CODABaseData.NAMEGLA_SALESPARTS);
        glaNames.add(CODABaseData.NAMEGLA_STOCKPARTS);
        glaNames.add(CODABaseData.NAMEGLA_VATOUTPUT);
        glaNames.add(CODABaseData.NAMEGLA_VATINPUT);
        glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD);
        glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLEUR);
        glaNames.add(CODABaseData.NAMEGLA_BANKACCOUNTEUROSUS);
        for (codaGeneralLedgerAccount__c gla : [Select Id, Name from codaGeneralLedgerAccount__c where Name in :glaNames])
        {
            CODATestIDMapExt.put(gla.Name, gla.id);
        }
        
        // Tax Codes
        Set<String> taxNames = new Set<String>();
        taxNames.add(CODABaseDataExt.NAMETAXCODE_VORSALES);
        taxNames.add(CODABaseDataExt.NAMETAXCODE_VORPURCHASE);
        taxNames.add(CODABaseDataExt.NAMETAXCODE_VOSTDSALES);
        taxNames.add(CODABaseDataExt.NAMETAXCODE_VOSTDPURCHASE);
        for (codaTaxCode__c item : [Select Id, Name from codaTaxCode__c where Name in :taxNames])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }
        
        // Dimensions 1
        Set<String> dim1Names = new Set<String>();
        dim1Names.add(CODABaseDataExt.NAMEDIM1_NORTH);
        dim1Names.add(CODABaseDataExt.NAMEDIM1_SOUTH);
        for (codaDimension1__c item : [Select Id, Name from codaDimension1__c where Name in :dim1Names])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }
        
        // Dimensions 2
        Set<String> dim2Names = new Set<String>();
        dim2Names.add(CODABaseDataExt.NAMEDIM2_DODGEUK);
        dim2Names.add(CODABaseDataExt.NAMEDIM2_FORDUK);
        for (codaDimension2__c item : [Select Id, Name from codaDimension2__c where Name in :dim2Names])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }
        
        // Dimensions 3
        Set<String> dim3Names = new Set<String>();
        dim3Names.add(CODABaseDataExt.NAMEDIM3_SALESEUR);
        dim3Names.add(CODABaseDataExt.NAMEDIM3_BILLYRAY);
        for (codaDimension3__c item : [Select Id, Name from codaDimension3__c where Name in :dim3Names])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }
        
        // Dimensions 4
        Set<String> dim4Names = new Set<String>();
        dim4Names.add(CODABaseDataExt.NAMEDIM4_HARROGATE);
        dim4Names.add(CODABaseDataExt.NAMEDIM4_ROGERSCARLATTI);
        for (codaDimension4__c item : [Select Id, Name from codaDimension4__c where Name in :dim4Names])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }
        
        // Periods for Merlin Auto Spain
        Id comId;
        for (codaPeriod__c period : [Select Id, Name, OwnerCompany__c, OwnerCompany__r.Name from codaPeriod__c where OwnerCompany__r.Name = :CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN])
        {
            CODATestIDMapExt.put(period.Name + ':' + period.OwnerCompany__r.Name, period.id);
            comId = period.OwnerCompany__c;
        }
        
        // Company
        CODATestIDMapExt.put(CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN, comId);
        
        // Years for Merlin Auto Spain
        for (codaYear__c year : [Select Id, Name, OwnerCompany__r.Name from codaYear__c where OwnerCompany__r.Name = :CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN])
        {
            CODATestIDMapExt.put(year.Name + ':' + year.OwnerCompany__r.Name, year.id);
        }

        // Currencies for Merlin Auto Spain
        for (codaAccountingCurrency__c accCurr : [Select Id, Name, OwnerCompany__r.Name from codaAccountingCurrency__c where OwnerCompany__r.Name  = :CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN])
        {
            CODATestIDMapExt.put(accCurr.Name + ':' + accCurr.OwnerCompany__r.Name, accCurr.id);
        }
        
        // Bank Account for Merlin Auto Spain
        codaBankAccount__c bankAcc = [Select Id, Name, OwnerCompany__r.Name from codaBankAccount__c where Name = :CODABaseDataExt.NAMEBANKACC_SANTANDERCURRENTACCOUNT and OwnerCompany__r.Name  = :CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN];
        CODATestIDMapExt.put(bankAcc.Name + ':' + bankAcc.OwnerCompany__r.Name, bankAcc.id);
        CODATestIDMapExt.save(SUFFIX);
    }
}