/*
 *  Copyright (c) 2017 FinancialForce.com, inc. All rights reserved
 */

public class CODATID021158Data
{
    public static String COMPANY_SPAIN = CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN;
    public static String COMPANY_GB = CODABaseData.NAMECOMPANY_MERLINAUTOGB;
    public static final string COMPANY_USA = CODABaseData.NAMECOMPANY_MERLINAUTOUSA;
    public static String SUFFIX = '#TID021158#';
    public static final String PERIODNAME_CURRENT = CODAPeriodMapExt.getPeriodByDate(system.today()).getName();
    public static final String INTERCOMACC_USA = 'Intercompany USA Account';
    public static final String INTERCOMACC_SPAIN = 'Intercompany SPAIN Account';
    public static String SINV1 = 'SIN001';
    public static String SINV2 = 'SIN002';
    public static final String INTERCOMACC_SIN1 = 'SIN003';
    public static final String ICD_SPAIN_USA = 'Spain to USA';
    public static final String ICD_USA_SPAIN = 'USA to Spain';
    
    public static void selectCompany()
    {
        CODABaseData.switchCurrentCompany(COMPANY_SPAIN, true, true, UserInfo.getUserId());
    }

    public static void switchProfile()
    {
        Id userId = CODABaseData.getProfile(CODABaseData.ACCOUNTANT).Id;
        CODABaseData.switchCurrentCompany(COMPANY_SPAIN, true, false, userId);
    }

    public static void createData()
    {
        loadmap();
        CODAUnitOfWork.createAndSetCurrent();
       
        //Sales Invoice header          
        CODAInvoiceTestHelper salesInv = new CODAInvoiceTestHelper();
        salesInv.setAccount(CODABaseDataExt.NAMEACCOUNT_CAMBRIDGEAUTO);
        salesInv.setInvoiceDate(system.today());
        salesInv.setDueDate(system.today()+60);
        salesInv.setPeriod(PERIODNAME_CURRENT+ ':' +COMPANY_SPAIN);
        salesInv.setInvoiceCurrency(CODABaseData.CURRENCYCODE_GBP);
         
        //Product line 1
        CODAInvoiceTestHelper.LineItem line1 = salesInv.newLine();
        line1.setProduct(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
        line1.setQuantity(1);
        line1.setUnitPrice(74.5);
        line1.setTaxCode1(CODABaseDataExt.NAMETAXCODE_VOSTDSALES);
        line1.setTaxValue1(13.04);
        line1.setDimension1(CODABaseDataExt.NAMEDIM1_EUR);
        line1.setDimension2(null);
        line1.setDimension3(CODABaseDataExt.NAMEDIM3_EUR);
        line1.setDimension4(null);
        
        salesInv.saveAndPost();
        
        CODATestIDMapExt.put(SINV1, salesInv.getId());
        CODATestIDMapExt.save(SUFFIX);
    }
    
    // Create intercompany definition SPAIN to USA
    public static void createDataExt1()
    {
        CODATestIDMapExt.load(SUFFIX);
        CODAUnitOfWork.createAndSetCurrent();

        //Create Intercompany Definition
        CODAIntercompanyDefinition icd = new CODAIntercompanyDefinition();
        icd.setRelatedCompanyId(CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOUSA));
        icd.setSendingControlAccountId(CODATestIDMap.resolve(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLUSD));
        icd.setReceivingControlAccountId(CODATestIDMap.resolve(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLEUR));
        icd.setOwnerCompanyId(CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN));
        icd.setAutoPost(true);
        icd.setAutoProcess(true);
        CODAUnitOfWork.getCurrent().commitWork();
        CODATestIDMapExt.put(ICD_SPAIN_USA, icd.getId());
        
        CODATestIDMapExt.save(SUFFIX);
    }
    
    // Switch current company to Merlin Auto USA
    public static void createDataExt2()
    {
        switchCompany(COMPANY_USA);
    }
    
    // Create intercompany definition for Merlin Auto USA to Merlin Auto Spain
    public static void createDataExt3()
    {
        CODATestIDMapExt.load(SUFFIX);
        CODAUnitOfWork.createAndSetCurrent();

        CODAIntercompanyDefinition interCompany2 = new CODAIntercompanyDefinition();
        interCompany2.setRelatedCompanyId(CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN));
        interCompany2.setSendingControlAccountId(CODATestIDMap.resolve(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLEUR));
        interCompany2.setReceivingControlAccountId(CODATestIDMap.resolve(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD));
        interCompany2.setOwnerCompanyId(CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOUSA));
        interCompany2.setAutoPost(true);
        interCompany2.setAutoProcess(true);
        CODAUnitOfWork.getCurrent().commitWork();
        CODATestIDMapExt.put(ICD_USA_SPAIN, interCompany2.getId());
        CODATestIDMapExt.save(SUFFIX);
    }

    //Switch current company to Merlin Auto Spain
    public static void createDataExt4()
    {
        switchCompany(COMPANY_SPAIN);
    }
    
    // Create sales invoices Intercompany Account
    public static void createDataExt5()
    {
        CODATestIDMapExt.load(SUFFIX);
        //Sales Invoice header          
        CODAInvoiceTestHelper salesInv = new CODAInvoiceTestHelper();
        salesInv.setAccount(INTERCOMACC_USA);
        salesInv.setInvoiceDate(system.today());
        salesInv.setDueDate(system.today()+60);
        salesInv.setPeriod(PERIODNAME_CURRENT+ ':' +COMPANY_SPAIN);
        salesInv.setInvoiceCurrency(CODABaseData.CURRENCYCODE_GBP);
        salesInv.setInvoiceDescription(SUFFIX);
         
        //Product line without override Local GLA
        CODAInvoiceTestHelper.LineItem line1 = salesInv.newLine();
        line1.setProduct(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
        line1.setQuantity(1);
        line1.setUnitPrice(350);
        line1.setTaxCode1(null);
        line1.setDimension1(CODABaseDataExt.NAMEDIM1_EUR);
        line1.setDimension2(null);
        line1.setDimension3(CODABaseDataExt.NAMEDIM3_EUR);
        line1.setDimension4(null);
        salesInv.saveAndPost();
        salesInv.reload();
        CODATestIDMapExt.put(INTERCOMACC_SIN1, salesInv.getId());
        CODATestIDMapExt.save(SUFFIX);
    }   
    
    //Switch current company to Merlin Auto GB
    public static void createDataExt6()
    {
        switchCompany(COMPANY_GB);
    }
    
    public static void createDataExt7()
    {
        CODATestIDMapExt.load(SUFFIX);
        CODAUnitOfWork.createAndSetCurrent();
       
        //Sales Invoice header          
        CODAInvoiceTestHelper salesInv = new CODAInvoiceTestHelper();
        salesInv.setAccount(CODABaseDataExt.NAMEACCOUNT_CAMBRIDGEAUTO);
        salesInv.setInvoiceDate(system.today());
        salesInv.setDueDate(system.today()+60);
        salesInv.setPeriod(PERIODNAME_CURRENT+ ':' +COMPANY_GB);
        salesInv.setInvoiceCurrency(CODABaseData.CURRENCYCODE_GBP);
         
        //Product line 1
        CODAInvoiceTestHelper.LineItem line1 = salesInv.newLine();
        line1.setProduct(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
        line1.setQuantity(1);
        line1.setUnitPrice(120);
        line1.setTaxCode1(CODABaseDataExt.NAMETAXCODE_VOSTDSALES);
        line1.setTaxValue1(21.00);
        line1.setDimension1(CODABaseDataExt.NAMEDIM1_EUR);
        line1.setDimension2(null);
        line1.setDimension3(CODABaseDataExt.NAMEDIM3_EUR);
        line1.setDimension4(null);
        
        salesInv.saveAndPost();
        
        CODATestIDMapExt.put(SINV2, salesInv.getId());
        CODATestIDMapExt.save(SUFFIX);
    }
    
    // Switch current company
    public static void switchCompany(String companyName)
    {
        CODABaseData.switchCurrentCompany(companyName, true, true, UserInfo.getUserId());
        CODACompanyMapExt.resetCompanyCache();
    }
    
    public static void destroyData()
    {
        CODATestIDMapExt.load(SUFFIX);
        CODAContext.enableSupportAccess();
        delete[SELECT Id FROM codaInvoice__c];
        delete[SELECT Id FROM codaTransaction__c];
        delete[SELECT Id FROM codaTransactionLineItem__c];
        delete[select Id from codaPurchaseInvoice__c];
        delete[select Id from codaIntercompanyDefinition__c];
        delete[select Id from codaIntercompanyTransfer__c];
        CODAContext.disableSupportAccess();
        CODATestIDMapExt.purge(SUFFIX);
    }

    public static void loadMap()
    {
        //Company
        CODACompany compSpain = CODACompanyMapper.getByName(COMPANY_SPAIN)[0];
        Id compId = compSpain.getId();
        CODATestIDMapExt.put(COMPANY_SPAIN, compId);
        
        CODACompany compUSA = CODACompanyMapper.getByName(COMPANY_USA)[0];
        Id compIdUSA = compUSA.getId();
        CODATestIDMapExt.put(COMPANY_USA, compIdUSA);
        
        CODACompany compGB = CODACompanyMapper.getByName(COMPANY_GB)[0];
        Id compIdGB = compGB.getId();
        CODATestIDMapExt.put(COMPANY_GB, compIdGB);
        
        //Spain Period
        codaPeriod__c periodSpain = [Select Id, Name, OwnerCompany__r.Name from codaPeriod__c where Name = :PERIODNAME_CURRENT AND OwnerCompany__c = :compId limit 1];
        CODATestIDMapExt.put(PERIODNAME_CURRENT + ':' +  COMPANY_SPAIN, periodSpain.id);
        
        //GB Period
        codaPeriod__c periodGB = [Select Id, Name, OwnerCompany__r.Name from codaPeriod__c where Name = :PERIODNAME_CURRENT AND OwnerCompany__c = :compIdGB limit 1];
        CODATestIDMapExt.put(PERIODNAME_CURRENT + ':' +  COMPANY_GB, periodGB.id);
        
        //Currencies for Merlin Auto Spain
        for (codaAccountingCurrency__c accCurrSpain : [Select Id, Name, OwnerCompany__r.Name from codaAccountingCurrency__c where OwnerCompany__c  = :compId])
        {
            CODATestIDMapExt.put(accCurrSpain.Name + ':' + accCurrSpain.OwnerCompany__r.Name, accCurrSpain.id);
        }
        
        //Currencies for Merlin Auto USA
        for (codaAccountingCurrency__c accCurrUSA : [Select Id, Name, OwnerCompany__r.Name from codaAccountingCurrency__c where OwnerCompany__c  = :compIdUSA])
        {
            CODATestIDMapExt.put(accCurrUSA.Name + ':' + accCurrUSA.OwnerCompany__r.Name, accCurrUSA.id);
        }
        
        //Currencies for Merlin Auto GB
        for (codaAccountingCurrency__c accCurrGB : [Select Id, Name, OwnerCompany__r.Name from codaAccountingCurrency__c where OwnerCompany__c  = :compIdGB])
        {
            CODATestIDMapExt.put(accCurrGB.Name + ':' + accCurrGB.OwnerCompany__r.Name, accCurrGB.id);
        }
        
        //Accounts
        Set<String> accNames = new Set<String>();
        accNames.add(INTERCOMACC_USA);
        accNames.add(INTERCOMACC_SPAIN);
        accNames.add(CODABaseDataExt.NAMEACCOUNT_CAMBRIDGEAUTO);
        for (Account accId : [Select Id, Name from Account where MirrorName__c in :accNames])
        {
            CODATestIDMapExt.put(accId.Name, accId.id);
        }
        
        Set<String> glaNames = new Set<String>();
        glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLEUR);
        glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLEUR);
        glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD);
        glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLUSD);
        for(CODAGeneralLedgerAccount__c gla: [Select Id, Name from CODAGeneralLedgerAccount__c where Name in :glaNames])
        {
            CODATestIDMapExt.put(gla.Name, gla.id);
        }
        
        //Product
        Product2  item = [Select Id, Name from Product2  where Name =: CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH];
        CODATestIDMapExt.put(item.Name, item.id);
        
        CODADimension1__c dim1= [Select Id, Name from CODADimension1__c where Name =:CODABaseDataExt.NAMEDIM1_EUR];
        CODATestIDMapExt.put(dim1.Name, dim1.id);
        
        CODADimension3__c dim3= [Select Id, Name from CODADimension3__c where Name =:CODABaseDataExt.NAMEDIM3_EUR];
        CODATestIDMapExt.put(dim3.Name, dim3.id);
        
        codaTaxCode__c taxcode= [Select Id, Name from codaTaxCode__c where Name =:CODABaseDataExt.NAMETAXCODE_VOSTDSALES];
        CODATestIDMapExt.put(taxcode.Name, taxcode.id);
      
        CODATestIDMapExt.save(SUFFIX);
    }
}