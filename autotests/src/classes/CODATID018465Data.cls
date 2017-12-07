/*
 * Copyright (c) 2016 FinancialForce.com, inc. All rights reserved.
 */

public class CODATID018465Data
{
    public static final String SUFFIX = '#TID018465';
    public static final string COMPANY_NAME = CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN;
    public static final String PERIODNAME_CURRENT = CODAPeriodMapExt.getPeriodByDate(system.today()).getName();
    public static final String PERIODNAME_NEXT_TO_CURRENT = CODAPeriodMapExt.getPeriodByDate(system.today().addMonths(1)).getName();
    public static string GBP_CURRENCY= CODABaseData.CURRENCYCODE_GBP+ ':' +COMPANY_NAME;
    public static string INV_NAME='SIN_NAME';
    public static final boolean allowRevaluationValue_ACCOUNTSRECEIVABLECONTROLUSD = CODAGeneralLedgerAccountMapper.getByName(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD)[0].getAllowRevaluation();
    public static final boolean allowRevaluationValue_s_APEXProductGLA_name = CODAGeneralLedgerAccountMapper.getByName(CODABaseData.s_APEXProductGLA_name)[0].getAllowRevaluation();
    public static final boolean allowRevaluationValue_ACCOUNTSRECEIVABLECONTROLEUR = CODAGeneralLedgerAccountMapper.getByName(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLEUR)[0].getAllowRevaluation();
    
    public static void selectCompany()
    {
        CODABaseData.switchCurrentCompany(COMPANY_NAME, true, true, UserInfo.getUserId());
    }

    public static void switchProfile()
    {
        Id accountant = CODABaseData.getProfile(CODABaseData.ACCOUNTANT).Id;
        CODABaseData.switchCurrentCompany(COMPANY_NAME, true, false, accountant);
    }

    public static void createData()
    {
        loadMap();
        
        CODAUnitOfWork.createAndSetCurrent();
        CODAGeneralLedgerAccountMapper.getByName(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD)[0].setAllowRevaluation(false);
        CODAGeneralLedgerAccountMapper.getByName(CODABaseData.s_APEXProductGLA_name)[0].setAllowRevaluation(true);
        CODAGeneralLedgerAccountMapper.getByName(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLEUR)[0].setAllowRevaluation(false);
        CODAUnitOfWork.getCurrent().commitWork();
        CODATestIDMapExt.save(SUFFIX);
    }
    
    public static void createDataExt1()
    {
        createInvoices(3,CODABaseDataExt.NAMEACCOUNT_CAMBRIDGEAUTO); 
    }
    
    public static void createDataExt2()
    {
        bulkPostInvoices();
    }
    
    public static void assertions_TST028918()
    {
        Decimal homeValueOnSummary = -4286.40;
        Decimal dualValueOnSummary = -3000;
        list<codaCurrencyRevaluation__c> currencyRevalSummaryLevel = [select Id, DocumentCurrency__r.Name from codaCurrencyRevaluation__c where Analysis__c =:CODACurrencyRevaluation.ANALYSIS_SUMMARYLEVEL AND OwnerCompany__c =:CODACompanyMapExt.getCurrentCompany().getId()];
        system.assert(currencyRevalSummaryLevel.size()==1, 'TST028918: Assertion failed, expected 1 Summary Level CRV but got '+currencyRevalSummaryLevel.size());
        
        CODACurrencyRevaluation currencyReval = CODACurrencyRevaluationMapper.getById(currencyRevalSummaryLevel[0].Id);
        system.assertEquals(CODABaseData.CURRENCYCODE_GBP, currencyReval.getDocumentCurrency().getName());
        
        list<CODACurrencyRevaluationSummary> crSummaries = currencyReval.getCurrencyRevaluationSummaries();
        system.assert(crSummaries.size()==1, 'TST028918: Assertion failed, expected 1 Summary to be created under this CRV but got '+crSummaries.size());
        system.assertEquals(CODACurrencyRevaluationSummary.STATUS_POSTED, crSummaries[0].getStatus());
        system.assertEquals(homeValueOnSummary, crSummaries[0].getHomeValue());
        system.assertEquals(dualValueOnSummary, crSummaries[0].getDualValue());
    }
    
    public static void assertions_TST028941()
    {
        Decimal homeValueOnSummary = -4286.40;
        Decimal dualValueOnSummary = -3000;
        list<codaCurrencyRevaluation__c> currencyRevalDetailLevel = [select Id, DocumentCurrency__r.Name from codaCurrencyRevaluation__c where Analysis__c =:CODACurrencyRevaluation.ANALYSIS_DETAILLEVEL AND OwnerCompany__c =:CODACompanyMapExt.getCurrentCompany().getId()];
        system.assert(currencyRevalDetailLevel.size()==1, 'TST028941: Assertion failed, expected 1 Detail Level CRV but got '+currencyRevalDetailLevel.size());
        
        CODACurrencyRevaluation currencyReval = CODACurrencyRevaluationMapper.getById(currencyRevalDetailLevel[0].Id);
        system.assertEquals(CODABaseData.CURRENCYCODE_GBP, currencyReval.getDocumentCurrency().getName());
        system.assertEquals(CODACurrencyRevaluation.ANALYSIS_DETAILLEVEL, currencyReval.getAnalysis());
        list<CODACurrencyRevaluationSummary> crSummaries = currencyReval.getCurrencyRevaluationSummaries();
        system.assert(crSummaries.size()==1, 'TST028941: Assertion failed, expected 1 Summary to be created under this CRV but got '+crSummaries.size());
        system.assertEquals(CODACurrencyRevaluationSummary.STATUS_POSTED, crSummaries[0].getStatus());
        system.assertEquals(homeValueOnSummary, crSummaries[0].getHomeValue());
        system.assertEquals(dualValueOnSummary, crSummaries[0].getDualValue());
        system.assert(crSummaries[0].getCurrencyRevaluationLineItems().size()==240, 'TST028941: Assertion failed, expected 240 CRV Lines to be created under this Summary but got '+crSummaries[0].getCurrencyRevaluationLineItems().size());
    }
    
    //creating Sales Invoice
    public static void createInvoices(integer noOfinvoices, String acct)
    {
        CODAContext.SetService(true);
        CODAUnitOfWork.getCurrent();
        CODATestIDMapExt.load(SUFFIX);
        
        CODAAccount accSales = CODAAccountHelperForTests.getCodaAccountByName(acct)[0];
        
        for(integer i = 1; i<=noOfinvoices; i++)
        {
            CODAInvoice invoiceObj =  CODAVolumeDataTestHelper.createSalesInvoice(accSales,system.today(),'GBP',SUFFIX);
            
            CODAVolumeDataTestHelper.addInvoiceLineItems(invoiceObj,null,CODABaseData.s_apexProd001Name,1.00,100,null,null,null,null,null,null,null,1,80,true,true); 
        }
        CODAUnitOfWork.getCurrent().commitWork();
    }
    
    public static void bulkPostInvoices()
    {    
        CODAContext.SetService(true);
        CODAUnitOfWork.getCurrent();
        CODATestIDMapExt.load(SUFFIX);
        List<ID> invId = new List<ID>();
        
        for(CODAInvoice__c inv : [Select Id, Name from codaInvoice__c where InvoiceStatus__c = 'In Progress' limit 100])
        {
            invId.add(inv.id);
        }
        CODAInvoiceService.scheduleInvoicesForPosting(invId);
        WorkerService.runWorkerBatch();
    }
    
    public static void destroyData()
    {
        CODATestIDMapExt.load(SUFFIX);
        CODAUnitOfWork.createAndSetCurrent();
        CODAGeneralLedgerAccountMapper.getByName(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD)[0].setAllowRevaluation(allowRevaluationValue_ACCOUNTSRECEIVABLECONTROLUSD);
        CODAGeneralLedgerAccountMapper.getByName(CODABaseData.s_APEXProductGLA_name)[0].setAllowRevaluation(allowRevaluationValue_s_APEXProductGLA_name);
        CODAGeneralLedgerAccountMapper.getByName(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLEUR)[0].setAllowRevaluation(allowRevaluationValue_ACCOUNTSRECEIVABLECONTROLEUR);
        CODAUnitOfWork.getCurrent().commitWork();

         CODAContext.enableSupportAccess();

        delete[SELECT Id FROM codaInvoice__c];
        delete[SELECT Id FROM codaTransaction__c];
        delete[SELECT Id from codaCurrencyRevaluation__c];
        delete[SELECT Id from codaCurrencyRevaluationSummary__c];
        delete[SELECT Id from codaCurrencyRevalBatch__c ];
        delete[SELECT Id from codaCurrencyRevalBatchLineItem__c ];
        delete[SELECT Id from codaCurrencyRevaluationGLAItem__c ];
        delete[SELECT Id from codaCurrencyRevaluationGroup__c ];
        delete[SELECT Id from WorkerLog__c];

        CODATestIDMapExt.purge(SUFFIX);
    }
    
    public static void loadMap()
    {
        //Company
        CODACompany compVAT = CODACompanyMapExt.getCurrentCompany();
        Id compId = compVAT.getId();
        CODATestIDMapExt.put(COMPANY_NAME, compId);
        
        //Spain Period
        for(codaPeriod__c period : [Select Id, Name, OwnerCompany__r.Name from codaPeriod__c where OwnerCompany__c = :compId])
        {
            CODATestIDMapExt.put(period.Name + ':' + period.OwnerCompany__r.Name, period.id);
        }
        
        // Currencies for Merlin Auto Spain
        for (codaAccountingCurrency__c accCurrSpain : [Select Id, Name, OwnerCompany__r.Name from codaAccountingCurrency__c where OwnerCompany__c  = :compId])
        {
            CODATestIDMapExt.put(accCurrSpain.Name + ':' + accCurrSpain.OwnerCompany__r.Name, accCurrSpain.id);
        }
        
        // Accounts
        Account acc = [Select Id, Name from Account where MirrorName__c = :CODABaseDataExt.NAMEACCOUNT_CAMBRIDGEAUTO];
        CODATestIDMapExt.put(acc.Name, acc.id);
        
        // Product
        Product2  item = [Select Id, Name from Product2  where Name =: CODABaseData.s_apexProd001Name];
        CODATestIDMapExt.put(item.Name, item.id);
        
        // GLAs
        Set<String> glaNames = new Set<String>();
        glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD);
        glaNames.add(CODABaseData.s_APEXProductGLA_name);
        glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLEUR);
        for (CODAGeneralLedgerAccount__c gla: [Select Id, Name from CODAGeneralLedgerAccount__c where Name in :glaNames])
        {
            CODATestIDMapExt.put(gla.Name, gla.id);
        }
       
        CODATestIDMapExt.save(SUFFIX);
    }
}
