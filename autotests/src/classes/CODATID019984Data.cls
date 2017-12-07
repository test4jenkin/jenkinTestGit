/*
 * Copyright (c) 2016 FinancialForce.com, inc. All rights reserved.
 */
public class CODATID019984Data
{
    public static final String SUFFIX = 'TID019984';
    public static final string PINV_REFERENCE = 'PINV'+SUFFIX;
    public static final string PINV_DESCRIPTION = 'Payable Invoice Description';
    public static final string REFERENCE1 = 'Reference 1';
    public static final string REFERENCE2 = 'Reference 2';
    public static final string PCRN_REFERENCE = 'PCRN'+SUFFIX;
    public static final string PCRN_DESCRIPTION = 'Payable Credit Note Description';
    public static final String PCRN_REASON = 'Reason';
    public static final string CSH_REFERENCE = 'CE'+SUFFIX;
    public static final string CSH_DESCRIPTION = 'Cash Entry Description';
    public static final String JOURNAL_REFERENCE = 'JNL'+SUFFIX;
    public static final String JOURNAL_DESCRIPTION = 'Journal Description';
    public static final String SINV_REFERENCE = 'SIN'+SUFFIX;
    public static final String SINV_DESCRIPTION = 'Sales Invoice Description';
    public static final String SCN_REFERENCE = 'SCN'+SUFFIX;
    public static final String SCN_DESCRIPTION = 'Sales Credit Note Description';
    public static final String SCN_REASON = 'Reason';
    public static String COMPANY_NAME = CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN; 
    public static String PERIODNAME_CURRENT = CODAPeriodMapExt.getPeriodByDate(System.today()).getName();
    
    public static void selectCompany()
    {
        CODABaseData.switchCurrentCompany(COMPANY_NAME, true, true, UserInfo.getUserId());
    }
    
    public static void switchProfile()
    {
        //No Use for this TID
    }
    
    public static void createData()
    {
        loadMap();
        //create custom setting for dimension
        codaAccountingSettings__c dimSetting = new codaAccountingSettings__c();
        dimSetting.EnableEditDimensionsafterposting__c = true;
        insert dimSetting;
    }

    public static void createDataExt1()
    {
        // Sales Invoice
        CODATestIDMapExt.load(SUFFIX);
        CODAInvoiceTestHelper invoice = new CODAInvoiceTestHelper();
        invoice.setAccount(CODABaseDataExt.NAMEACCOUNT_HOGANREPAIRS);
        invoice.setDimension1(CODABaseDataExt.NAMEDIM1_EUR);
        invoice.setInvoiceDate(System.today());
        invoice.setDueDate(System.today() + 1);
        invoice.setInvoiceCurrency(CODABaseData.CURRENCYCODE_EUR);
        invoice.setCustomerReference(SINV_REFERENCE);
        invoice.setInvoiceDescription(SINV_DESCRIPTION);
        
        CODAInvoiceTestHelper.LineItem line = invoice.newLine();
        line.setProduct(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
        line.setDimension1(CODABaseDataExt.NAMEDIM1_EUR);
        line.setUnitPrice(100);
        line.setQuantity(1);       
        invoice.save();
        invoice.reload();
        invoice.post();
        CODATestIDMapExt.put(SINV_REFERENCE, invoice.getId());
        CODATestIDMapExt.save(SUFFIX);
    }  
    
    public static void createDataExt2()
    {
        // Sales Credit Note
        CODATestIDMapExt.load(SUFFIX);       
        CODACreditNoteTestHelper cre = new CODACreditNoteTestHelper();
        cre.setAccount(CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO);
        cre.setCreditNoteCurrency(CODABaseData.CURRENCYCODE_EUR);
        cre.setDimension1(CODABaseDataExt.NAMEDIM1_EUR);
        cre.setDueDate(System.today() + 1);
        cre.setCreditNoteDate(System.today());
        cre.setCreditNoteDescription(SCN_DESCRIPTION);
        cre.setCustomerReference(SCN_REFERENCE);
        cre.setCreditNoteReason(SCN_REASON);

        CODACreditNoteTestHelper.LineItem line = cre.newLine();
        line.setProduct(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
        line.setDimension1(CODABaseDataExt.NAMEDIM1_EUR);
        line.setQuantity(1);
        line.setUnitPrice(100.00);
        cre.save();
        cre.reload();
		cre.post();
        CODATestIDMapExt.put(SCN_REFERENCE, cre.getId());
        CODATestIDMapExt.save(SUFFIX);
    }
    
    public static void createDataExt3()
    {
        // Purchase Invoice
        CODATestIDMapExt.load(SUFFIX);
        CODAPurchaseInvoiceTestHelper pInv = new CODAPurchaseInvoiceTestHelper();
        pInv.setAccount(CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES);
        pInv.setInvoiceCurrency(CODABaseData.CURRENCYCODE_EUR + ':' + CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN);
        pInv.setInvoiceDate(System.today());
        pInv.setDueDate(System.today() + 1);
        pInv.setReference1(REFERENCE1);
        pInv.setReference2(REFERENCE2);
        pInv.setInvoiceDescription(PINV_DESCRIPTION);

        CODAPurchaseInvoiceTestHelper.ExpenseLineItem expLine = pInv.newExpenseLine(CODABaseData.NAMEGLA_SALESPARTS);
        expLine.setNetValue(100.00);
        expLine.setTaxCode(CODABaseDataExt.NAMETAXCODE_VORPURCHASE);
        expLine.setTaxValue1(CODAFormatter.decimalToString(5.00));

        CODAPurchaseInvoiceTestHelper.ProductLineItem line = pInv.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
        line.setQuantity('1');
        line.setDimension1(CODABaseDataExt.NAMEDIM1_EUR);
        line.setUnitPrice(CODAFormatter.decimalToString(100.00));
        line.setTaxCode(CODABaseDataExt.NAMETAXCODE_VOSTDPURCHASE);
        line.setTaxValue1(CODAFormatter.decimalToString(17.50));    

        pInv.setVendorInvoiceNumber(PINV_REFERENCE);
        pInv.setAccountInvoiceTotal(CODAFormatter.decimalToString(222.50));
        pInv.save();
        pInv.reload();
		pInv.post();
        CODATestIDMapExt.put(PINV_REFERENCE, pInv.getId());
        CODATestIDMapExt.save(SUFFIX);    
    }
    
    public static void createDataExt4()
    {   
        //Payable Credit Note
        CODATestIDMapExt.load(SUFFIX);
        CODAPurchaseCreditNoteTestHelper pCre = new CODAPurchaseCreditNoteTestHelper();
        pCre.setAccount(CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES);
        pCre.setCreditNoteCurrency(CODABaseData.CURRENCYCODE_EUR + ':' + CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN);
        pCre.setCreditNoteDate(System.today());
        pCre.setDueDate(System.today() + 1);
        pCre.setCreditNoteDescription(PCRN_DESCRIPTION);
        pCre.setReference1(REFERENCE1);
        pCre.setReference2(REFERENCE2);
        pCre.setCreditNoteReason(PCRN_REASON);

        pCre.setDimension1(CODABaseDataExt.NAMEDIM1_EUR);

        CODAPurchaseCreditNoteTestHelper.ExpenseLineItem expLine = pCre.newExpenseLine(CODABaseData.NAMEGLA_SALESPARTS);
        expLine.setNetValue(100.00);
        expLine.setTaxCode(CODABaseDataExt.NAMETAXCODE_VORPURCHASE);
        expLine.setTaxValue1(CODAFormatter.decimalToString(5.00));
        
        CODAPurchaseCreditNoteTestHelper.ProductLineItem line = pCre.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
        line.setQuantity('1');
        line.setUnitPrice(CODAFormatter.decimalToString(100.00));
        line.setDimension1(CODABaseDataExt.NAMEDIM1_EUR);
        line.setTaxCode(CODABaseDataExt.NAMETAXCODE_VOSTDPURCHASE);
        line.setTaxValue1(CODAFormatter.decimalToString(17.50));
        pCre.setVendorCreditNoteNumber(PCRN_REFERENCE);
        pCre.setAccountCreditNoteTotal(CODAFormatter.decimalToString(222.50));
        pCre.save();
        pCre.reload();
		pCre.post();
        CODATestIDMapExt.put(PCRN_REFERENCE, pCre.getId());
        CODATestIDMapExt.save(SUFFIX); 
    }
    
    public static void createDataExt5()
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
        ce.setDescription(CSH_DESCRIPTION);
        ce.setAccount(CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO);

        CODACashEntryTestHelper.LineItem line = ce.newLine();
        line.setAccountReference(CSH_REFERENCE);
        line.setAccountDimension1(CODABaseDataExt.NAMEDIM1_EUR);
        line.setAccountPaymentMethod(CODACashEntryLineItem.ACCOUNTPAYMENTMETHOD_CASH);
        line.setCashEntryValue(CODAFormatter.decimalToString(100.00));
        line.setBankAccountValue(CODAFormatter.decimalToString(100.00));
        ce.save();
        ce.reload();
		ce.post();
        CODATestIDMapExt.put(CSH_REFERENCE, ce.getId());
        CODATestIDMapExt.save(SUFFIX); 
    }
    
    public static void createDataExt6()
    {   
        //Journal
        CODATestIDMapExt.load(SUFFIX);
        CODAJournalTestHelper journal = new CODAJournalTestHelper();
        journal.setJournalCurrency(CODABaseData.CURRENCYCODE_EUR + ':' + CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN);
        journal.setJournalDate(System.today());
        journal.setReference(JOURNAL_REFERENCE);
        journal.setJournalDescription(JOURNAL_DESCRIPTION);

        CODAJournalTestHelper.LineItem lineItem = journal.newLine(CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseData.NAMEGLA_SALESPARTS);
        lineItem.setAmount(600);
        
        CODAJournalTestHelper.LineItem lineItem2 = journal.newLine(CODAJournalLineItem.LINETYPE_PRODUCTPURCHASES, CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
        lineItem2.setGeneralLedgerAccount(CODABaseData.NAMEGLA_SALESPARTS);
        lineItem2.setDimension1(CODABaseDataExt.NAMEDIM1_EUR);
        lineItem2.setLineDescription(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
        lineItem2.setAmount(-400);
        
        CODAJournalTestHelper.LineItem lineItem3 = journal.newLine(CODAJournalLineItem.LINETYPE_TAXCODE, CODABaseDataExt.NAMETAXCODE_VORSALES);
        lineItem3.setGeneralLedgerAccount(CODABaseData.NAMEGLA_SALESPARTS);
        lineItem3.setAmount(-200);
        journal.save();
        journal.reload();
		journal.post();
        CODATestIDMapExt.put(JOURNAL_REFERENCE, journal.getId());
        CODATestIDMapExt.save(SUFFIX);
    }
    
    public static void destroyData()
    {
        CODATestIDMapExt.load(SUFFIX);
        CODAContext.enableSupportAccess();
        delete[SELECT Id FROM codaAccountingSettings__c];
        CODAPaymentData.destroyPaymentData(SUFFIX);
    }
    
    public static void loadMap()
    {
        // Accounts
        Set<String> accNames = new Set<String>();
        accNames.add(CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO);
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
        for (codaGeneralLedgerAccount__c gla : [Select Id, Name from codaGeneralLedgerAccount__c where Name in :glaNames])
        {
            CODATestIDMapExt.put(gla.Name, gla.id);
        }

        // Dimensions 1
        Set<String> dim1Names = new Set<String>();
        dim1Names.add(CODABaseDataExt.NAMEDIM1_EUR);
        for (codaDimension1__c item : [Select Id, Name from codaDimension1__c where Name in :dim1Names])
        {
            CODATestIDMapExt.put(item.Name, item.id);
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