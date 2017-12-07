/*
 * Copyright (c) 2017 FinancialForce.com, inc. All rights reserved.
 */
 
public class CODATID021066Data
{
    public static final String SUFFIX = '#TID021066';
    public static final string COMPANY_NAME = CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN;
    public static final string SIN001 = 'SIN001';
    public static final string SIN002 = 'SIN002';
    public static final string SIN003 = 'SIN003';
    public static final String PERIODNAME_CURRENT = CODAPeriodMapExt.getPeriodByDate(system.today()).getName();
    
    public static void selectCompany()
    {
        CODABaseData.switchCurrentCompany(COMPANY_NAME, true, true, UserInfo.getUserId());
    }

    public static void createData()
    {
        loadMap();
        CODAUnitOfWork.createAndSetCurrent();
        
        codaGeneralLedgerAccount__c glaApexProd001 = [Select AllowRevaluation__c, Name From codaGeneralLedgerAccount__c where Name = 'APEXPRODGLA001'];
        glaApexProd001.AllowRevaluation__c = true;
        glaApexProd001.Type__c = 'Profit and Loss';
        update glaApexProd001;
        
        //Sales Invoice header          
        CODAInvoiceTestHelper salesInv = new CODAInvoiceTestHelper();
        salesInv.setAccount(CODABaseDataExt.NAMEACCOUNT_CAMBRIDGEAUTO);
        salesInv.setInvoiceDate(system.today());
        salesInv.setDueDate(system.today()+60);
        salesInv.setPeriod(PERIODNAME_CURRENT+ ':' +COMPANY_NAME);
        salesInv.setInvoiceCurrency(CODABaseData.CURRENCYCODE_EUR);
         
        //Product line 1
        CODAInvoiceTestHelper.LineItem line1 = salesInv.newLine();
        line1.setProduct(CODABaseDataExt.NAMEPRODUCT_A4PAPE);
        line1.setQuantity(1);
        line1.setUnitPrice(100);
        line1.setTaxCode1(null);
        
        //Product line 2
        CODAInvoiceTestHelper.LineItem line2 = salesInv.newLine();
        line2.setProduct(CODABaseData.s_apexProd001Name);
        line2.setQuantity(1);
        line2.setUnitPrice(100);
        line2.setTaxCode1(null);
        
        salesInv.saveAndPost();
        CODAInvoice invoice = CODAInvoiceMapper.getById(salesInv.getId());
        System.assertEquals(CODAInvoice.INVOICESTATUS_COMPLETE, invoice.getInvoiceStatus());
        CODATestIDMapExt.put(SIN001, salesInv.getId());
        CODATestIDMapExt.save(SUFFIX);
    }
    
    public static void createDataExt1()
    {
        CODATestIDMapExt.load(SUFFIX);
        
        //Sales Invoice header          
        CODAInvoiceTestHelper salesInv = new CODAInvoiceTestHelper();
        salesInv.setAccount(CODABaseDataExt.NAMEACCOUNT_CAMBRIDGEAUTO);
        salesInv.setInvoiceDate(system.today());
        salesInv.setDueDate(system.today()+60);
        salesInv.setPeriod(PERIODNAME_CURRENT+ ':' +COMPANY_NAME);
        salesInv.setInvoiceCurrency(CODABaseData.CURRENCYCODE_GBP);
         
        //Product line 1
        CODAInvoiceTestHelper.LineItem line1 = salesInv.newLine();
        line1.setProduct(CODABaseDataExt.NAMEPRODUCT_A4PAPE);
        line1.setQuantity(1);
        line1.setUnitPrice(100);
        line1.setTaxCode1(null);
        
        //Product line 2
        CODAInvoiceTestHelper.LineItem line2 = salesInv.newLine();
        line2.setProduct(CODABaseData.s_apexProd001Name);
        line2.setQuantity(1);
        line2.setUnitPrice(100);
        line2.setTaxCode1(null);
        
        salesInv.saveAndPost();
        CODAInvoice invoice = CODAInvoiceMapper.getById(salesInv.getId());
        System.assertEquals(CODAInvoice.INVOICESTATUS_COMPLETE, invoice.getInvoiceStatus());
        CODATestIDMapExt.put(SIN002, salesInv.getId());
        CODATestIDMapExt.save(SUFFIX);
    }
    
    public static void createDataExt2()
    {
        CODATestIDMapExt.load(SUFFIX);
        
        //Sales Invoice header          
        CODAInvoiceTestHelper salesInv = new CODAInvoiceTestHelper();
        salesInv.setAccount(CODABaseDataExt.NAMEACCOUNT_CAMBRIDGEAUTO);
        salesInv.setInvoiceDate(system.today());
        salesInv.setDueDate(system.today()+60);
        salesInv.setPeriod(PERIODNAME_CURRENT+ ':' +COMPANY_NAME);
        salesInv.setInvoiceCurrency(CODABaseData.CURRENCYCODE_USD);
         
        //Product line 1
        CODAInvoiceTestHelper.LineItem line1 = salesInv.newLine();
        line1.setProduct(CODABaseDataExt.NAMEPRODUCT_A4PAPE);
        line1.setQuantity(1);
        line1.setUnitPrice(100);
        line1.setTaxCode1(null);
        
        //Product line 2
        CODAInvoiceTestHelper.LineItem line2 = salesInv.newLine();
        line2.setProduct(CODABaseData.s_apexProd001Name);
        line2.setQuantity(1);
        line2.setUnitPrice(100);
        line2.setTaxCode1(null);
        
        salesInv.saveAndPost();
        CODAInvoice invoice = CODAInvoiceMapper.getById(salesInv.getId());
        System.assertEquals(CODAInvoice.INVOICESTATUS_COMPLETE, invoice.getInvoiceStatus());
        CODATestIDMapExt.put(SIN003, salesInv.getId());
        CODATestIDMapExt.save(SUFFIX);
    }
    
    public static void assertions_TST035918()
    {
        integer numOfReverseRevalTrans = 0, numOfRevalTrans = 0;
        List<codaTransaction__c> transList = [select Id,DocumentReference2__c,DocumentDescription__c from CODATransaction__c where  TransactionType__c = 'Currency Revaluation'];
        System.assertEquals(9, transList.size());
        for(CODATransaction__c lines : transList)
        {
            if(lines.DocumentReference2__c == 'Reverse Revaluation')
            {   
                numOfReverseRevalTrans++;
            }
            else
            {
                numOfRevalTrans++;
            }    
        }
        System.assertEquals(3, numOfReverseRevalTrans);
        System.assertEquals(6, numOfRevalTrans);
    }
    
    public static void destroyData()
    {
        CODATestIDMapExt.load(SUFFIX);
		codaGeneralLedgerAccount__c glaApexProd001 = [Select AllowRevaluation__c, Name From codaGeneralLedgerAccount__c where Name = 'APEXPRODGLA001'];
        glaApexProd001.AllowRevaluation__c = false;
        glaApexProd001.Type__c = 'Balance Sheet';
        update glaApexProd001;
		
        CODAContext.enableSupportAccess();
        delete[SELECT Id FROM CODAInvoice__c];
        delete[SELECT Id FROM CODATransaction__c];
        delete[Select Id from codaCurrencyRevaluation__c];
        delete[Select Id from codaCurrencyRevaluationGroup__c];
		delete[Select Id from codaCurrencyRevalBatchLineItem__c];
		delete[Select Id from codaCurrencyRevaluationLineItem__c];
		delete[Select Id from codaCurrencyRevalBatch__c];
		delete[Select Id from codaCurrencyRevaluationSummary__c];
        CODAContext.disableSupportAccess();
        CODATestIDMapExt.purge(SUFFIX);
    }
    
    public static void loadMap()
    {
        //Company
        CODACompany compVAT = CODACompanyMapExt.getCurrentCompany();
        Id compId = compVAT.getId();
        CODATestIDMapExt.put(COMPANY_NAME, compId);
        
        //Spain Period
        codaPeriod__c periodSpain = [Select Id, Name, OwnerCompany__r.Name from codaPeriod__c where Name = :PERIODNAME_CURRENT AND OwnerCompany__c = :compId limit 1];
        CODATestIDMapExt.put(PERIODNAME_CURRENT + ':' + compVAT.getName(), periodSpain.id);
        
        //Currencies for Merlin Auto Spain
        for (codaAccountingCurrency__c accCurrSpain : [Select Id, Name, OwnerCompany__r.Name from codaAccountingCurrency__c where OwnerCompany__c  = :compId])
        {
            CODATestIDMapExt.put(accCurrSpain.Name + ':' + accCurrSpain.OwnerCompany__r.Name, accCurrSpain.id);
        }
        
        //Accounts
        Set<String> accNames = new Set<String>();
        accNames.add(CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES);
        accNames.add(CODABaseDataExt.NAMEACCOUNT_CAMBRIDGEAUTO);
        
        for (Account accId : [Select Id, Name from Account where MirrorName__c in :accNames])
        {
            CODATestIDMapExt.put(accId.Name, accId.id);
        }
        
        //Product
        Set<String> pdtNames = new Set<String>();
        pdtNames.add(CODABaseDataExt.NAMEPRODUCT_A4PAPE);
        pdtNames.add(CODABaseData.s_apexProd001Name);
        
        for(Product2 pdtId : [Select Id, Name from Product2  where Name in :pdtNames])
        {
            CODATestIDMapExt.put(pdtId.Name, pdtId.id);
        }
        
        //GLAs
        Set<String> glaNames = new Set<String>();
        glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLGBP);
        glaNames.add(CODABaseData.NAMEGLA_VATINPUT);
        glaNames.add(CODABaseData.NAMEGLA_VATOUTPUT);
        glaNames.add(CODABaseData.s_APEXProductGLA_name);
        glaNames.add(CODABaseData.NAMEGLA_STOCKPARTS);
        glaNames.add(CODABaseData.NAMEGLA_SALESPARTS);
        glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD);
        
        for(CODAGeneralLedgerAccount__c gla: [Select Id, Name from CODAGeneralLedgerAccount__c where Name in :glaNames])
        {
            CODATestIDMapExt.put(gla.Name, gla.id);
        }
        
        CODATestIDMapExt.save(SUFFIX);
    }
}