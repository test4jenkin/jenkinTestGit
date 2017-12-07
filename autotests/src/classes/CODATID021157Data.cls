/*
 *  Copyright (c) 2017 FinancialForce.com, inc. All rights reserved
 */

public class CODATID021157Data
{
    public static String COMPANY_NAME = CODABaseData.NAMECOMPANY_MERLINAUTOGB;
    public static String SUFFIX = '#TID021157#';
    public static String GLA_POSTAGE_AND_STATIONERY = CODABaseData.NAMEGLA_POSTAGEANDSTATIONERY;
    public static String GLA_ACCOUNTS_RECEIVABLE_CONTROL_USD = CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD;
    public static String GLA_ACCOUNTS_ACCOUNTS_RECEIVABLE_IS = CODABaseDataExt.NAMEGLA_ACCOUNTSRECEIVABLEIS;
    public static String PRODUCT_A4PAPER = 'A4 Paper';
    public static String REFERENCE1 = 'BMW001';
    public static String REFERENCE2 = 'BMW002';
    
    public static void selectCompany()
    {
        CODABaseData.switchCurrentCompany(COMPANY_NAME, true, true, UserInfo.getUserId());
    }

    public static void switchProfile()
    {
        Id userId = CODABaseData.getProfile(CODABaseData.ACCOUNTANT).Id;
        CODABaseData.switchCurrentCompany(COMPANY_NAME, true, false, userId);
    }

    public static void createData()
    {
        loadmap();
        CODAUnitOfWork.createAndSetCurrent();
        Date invoiceDate= System.today();
        string currentPeriodName = CODAPeriodMapExt.getPeriodByDate(invoiceDate).getName() + ':' + COMPANY_NAME;
        
        // Create PINV1
        CODAPurchaseInvoiceTestHelper purchaseInvoice1 = new CODAPurchaseInvoiceTestHelper();
        purchaseInvoice1.setAccount(CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES);
        purchaseInvoice1.setInvoiceCurrency(CODABaseData.CURRENCYCODE_EUR+':'+COMPANY_NAME);
        purchaseInvoice1.setPeriod(currentPeriodName); 
        purchaseInvoice1.setInvoiceDate(invoiceDate);
        purchaseInvoice1.setVendorInvoiceNumber(REFERENCE1);
       
        //ExpenseLine1
        CODAPurchaseInvoiceTestHelper.ExpenseLineItem expLine1 = purchaseInvoice1.newExpenseLine(GLA_ACCOUNTS_ACCOUNTS_RECEIVABLE_IS);
        expLine1.setNetValue(100.00);
        expLine1.setDimension1(CODABaseDataExt.NAMEDIM1_EUR);
        
        //ExpenseLine2
        CODAPurchaseInvoiceTestHelper.ExpenseLineItem expLine2 = purchaseInvoice1.newExpenseLine(GLA_POSTAGE_AND_STATIONERY);
        expLine2.setNetValue(400.00);
        expLine2.setDimension1(CODABaseData.s_apexEurDim001_name);
        expLine2.setDimension3(CODABaseData.s_apexEurDim003_name);

        //ProductLine1
        CODAPurchaseInvoiceTestHelper.ProductLineItem pinvLine1 = purchaseInvoice1.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
        pinvLine1.setQuantity(1);
        pinvLine1.setUnitPrice(100.00);
        pinvLine1.setDimension2(CODABaseData.s_apexEurDim002_name);
        pinvLine1.setDimension4(CODABaseData.s_apexEurDim004_name);

        //ProductLine2
        CODAPurchaseInvoiceTestHelper.ProductLineItem pinvLine2 = purchaseInvoice1.newProductLine(CODABaseDataExt.NAMEPRODUCT_A4PAPE);
        pinvLine2.setQuantity(1);
        pinvLine2.setUnitPrice(200.00);
        purchaseInvoice1.setAccountInvoiceTotal(purchaseInvoice1.getInvoiceTotal());
        purchaseInvoice1.saveAndPost();
        
        CODATestIDMapExt.put(REFERENCE1, purchaseInvoice1.getId());
        CODATestIDMapExt.save(SUFFIX);
    }

    public static void createDataExt1()
    {
        CODATestIDMapExt.load(SUFFIX);
        Date invoiceDate= System.today().addDays(-90);
        string currentPeriodName = CODAPeriodMapExt.getPeriodByDate(invoiceDate).getName() + ':' + COMPANY_NAME;
        
        // Create PINV2
        CODAPurchaseInvoiceTestHelper purchaseInvoice2 = new CODAPurchaseInvoiceTestHelper();
        purchaseInvoice2.setAccount(CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES);
        purchaseInvoice2.setInvoiceCurrency(CODABaseData.CURRENCYCODE_EUR+':'+COMPANY_NAME);
        purchaseInvoice2.setPeriod(currentPeriodName); 
        purchaseInvoice2.setInvoiceDate(invoiceDate);
        purchaseInvoice2.setVendorInvoiceNumber(REFERENCE2);
       
        
        //ExpenseLine1
        CODAPurchaseInvoiceTestHelper.ExpenseLineItem expLine1 = purchaseInvoice2.newExpenseLine(GLA_ACCOUNTS_RECEIVABLE_CONTROL_USD );
        expLine1.setNetValue(100.00);
        expLine1.setDimension1(CODABaseDataExt.NAMEDIM1_GBP);
        expLine1.setDimension4(CODABaseDataExt.NAMEDIM4_HARROGATE);
        
        //ExpenseLine2
        CODAPurchaseInvoiceTestHelper.ExpenseLineItem expLine2 = purchaseInvoice2.newExpenseLine(GLA_POSTAGE_AND_STATIONERY);
        expLine2.setNetValue(400.00);
        
        //ProductLine1
        CODAPurchaseInvoiceTestHelper.ProductLineItem pinvLine1 = purchaseInvoice2.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
        pinvLine1.setQuantity(1);
        pinvLine1.setUnitPrice(100.00);
        pinvLine1.setDimension1(CODABaseDataExt.NAMEDIM1_GBP);
        pinvLine1.setDimension4(CODABaseData.s_apexEurDim004_name);

        //ProductLine2
        CODAPurchaseInvoiceTestHelper.ProductLineItem pinvLine2 = purchaseInvoice2.newProductLine(CODABaseDataExt.NAMEPRODUCT_A4PAPE);
        pinvLine2.setQuantity(1);
        pinvLine2.setUnitPrice(200.00);
        purchaseInvoice2.setAccountInvoiceTotal(purchaseInvoice2.getInvoiceTotal());
        purchaseInvoice2.saveAndPost();
         
        CODATestIDMapExt.put(REFERENCE2, purchaseInvoice2.getId());
        CODATestIDMapExt.save(SUFFIX);
    }
    
    public static void destroyData()
    {
        CODATestIDMapExt.load(SUFFIX);
        CODAContext.enableSupportAccess();
        delete [SELECT Id FROM codaPurchaseInvoice__c];
        delete [SELECT Id FROM codaTransaction__c];
        delete [SELECT Id FROM codaTransactionLineItem__c];
        CODAContext.disableSupportAccess();
        CODATestIDMapExt.purge(SUFFIX);
    }

    public static void loadMap()
    {
        Set<String> glaNames = new Set<String>();
        glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD);
        glaNames.add(CODABaseData.NAMEGLA_POSTAGEANDSTATIONERY);
        glaNames.add(CODABaseDataExt.NAMEGLA_ACCOUNTSRECEIVABLEIS);

        for (CODAGeneralLedgerAccount__c item : [Select Id, Name from CODAGeneralLedgerAccount__c where Name in :glaNames])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }

        CODACompany company = CODACompanyMapExt.getCurrentCompany();
        Id compId = company.getId();
        CODATestIDMapExt.put(company.getName(), compId);
        
        //Periods for Merlin Auto GB
        for (codaPeriod__c period : [Select Id, Name, OwnerCompany__r.Name from codaPeriod__c where OwnerCompany__c = :compId])
        {
            CODATestIDMapExt.put(period.Name + ':' + period.OwnerCompany__r.Name, period.id);
        }

        Account accId = [Select Id, Name from Account where MirrorName__c =: CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES];
        {
            CODATestIDMapExt.put(accId.Name, accId.id);
        }
        
        //Currencies for Merlin Auto GB
        for (codaAccountingCurrency__c accCurrGB : [Select Id, Name, OwnerCompany__r.Name from codaAccountingCurrency__c where OwnerCompany__c  = :compId])
        {
            CODATestIDMapExt.put(accCurrGB.Name + ':' + accCurrGB.OwnerCompany__r.Name, accCurrGB.id);
        }

        Set<String> prodNames = new Set<String>();
        prodNames.add(CODABaseDataExt.NAMEPRODUCT_A4PAPE);
        prodNames.add(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);

        for(Product2 item : [Select Id, Name from Product2 where Name in :prodNames])
        {
            CODATestIDMapExt.put(item.Name, item.Id);
        }
        
        Set<String> dim1 = new Set<String>();
        dim1.add(CODABaseDataExt.NAMEDIM1_EUR);
        dim1.add(CODABaseDataExt.NAMEDIM1_GBP);
        dim1.add(CODABaseData.s_apexEurDim001_name);
        for (CODADimension1__c item : [Select Id, Name from CODADimension1__c where Name in :dim1])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }
        
        Set<String> dim2 = new Set<String>();
        dim2.add(CODABaseData.s_apexEurDim002_name);
        for (CODADimension2__c item : [Select Id, Name from CODADimension2__c where Name in :dim2])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }
        
        Set<String> dim3 = new Set<String>();
        dim3.add(CODABaseData.s_apexEurDim003_name);
        for (CODADimension3__c item : [Select Id, Name from CODADimension3__c where Name in :dim3])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }
        
        Set<String> dim4 = new Set<String>();
        dim4.add(CODABaseDataExt.NAMEDIM4_HARROGATE);
        dim4.add(CODABaseData.s_apexEurDim004_name);
        for (CODADimension4__c item : [Select Id, Name from CODADimension4__c where Name in :dim4])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }
        
        CODATestIDMapExt.save(SUFFIX);
    }
}