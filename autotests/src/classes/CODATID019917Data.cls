/*
 * Copyright (c) 2016 FinancialForce.com, inc. All rights reserved.
 */
 
public class CODATID019917Data
{
    public static final String SUFFIX = '#TID019917';
    public static final string VAT_COMPANY_NAME = CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN;
    public static final String PERIODNAME_CURRENT = CODAPeriodMapExt.getPeriodByDate(system.today()).getName();
    public static String NAME_GLA1 = '4001#TID019917' ;
    public static String NAME_GLA2 = '6000' ;
    public static String SPAIN_GLA_REPCODE = 'SpainLocal' + SUFFIX;
    public static String CORPORATE_COA = 'Corporate' + SUFFIX;
    
    public static void selectCompany()
    {
        CODABaseData.switchCurrentCompany(VAT_COMPANY_NAME, true, true, UserInfo.getUserId());
    }

    public static void switchProfile()
    {
        Id accountant = CODABaseData.getProfile(CODABaseData.ACCOUNTANT).Id;
        CODABaseData.switchCurrentCompany(VAT_COMPANY_NAME, true, false, accountant);
    }

    public static void createData()
    {
        loadMap();
        CODAUnitOfWork.createAndSetCurrent();
        
        // Enable "Allow Use of Local GLAs" custom setting to true.
        codaAccountingSettings__c accSetting = new codaAccountingSettings__c();
        accSetting.AllowUseOfLocalGLAs__c = true;
        accSetting.EnableOverrideProductGLA__c = false;
        insert accSetting;
        
        CODACompany company= CODACompanyMapper.getByName(VAT_COMPANY_NAME)[0];

        //creating Corporate Chart of Account
        ChartOfAccountsStructure__c corporate = new ChartOfAccountsStructure__c();
        corporate.Name = CORPORATE_COA;
        corporate.DefaultCorporateGLA__c = null;
        corporate.DefaultLocalGLA__c = null;
        corporate.IsCorporate__c = true;
        corporate.Active__c = true;
        insert corporate;
        CODATestIDMapExt.put(CORPORATE_COA, corporate.Id);

        //creating Corporate GLA
        CODAGeneralLedgerAccount glaCorporate = CODAGeneralLedgerAccount.create();
        glaCorporate.setName(NAME_GLA1);
        glaCorporate.setReportingCode(CORPORATE_COA);
        glaCorporate.setType(CODAGeneralLedgerAccount.TYPE_BALANCESHEET);
        glaCorporate.setCurrencyIsoCode(company.getDto().CurrencyIsoCode);
        glaCorporate.getDto().ChartOfAccountsStructure__c = corporate.Id;
        CODAUnitOfWork.getCurrent().commitWork();
        CODATestIDMapExt.put(NAME_GLA1,glaCorporate.getId());

        //Creating Local COA 'Spain'
        ChartOfAccountsStructure__c coaSpain = new ChartOfAccountsStructure__c();
        coaSpain.Name = 'Spain';
        coaSpain.DefaultCorporateGLA__c = null;
        coaSpain.DefaultLocalGLA__c = null;
        coaSpain.IsCorporate__c = false;
        coaSpain.Active__c = false;
        insert coaSpain;
        
        //creating Local GLAs for Spain COA
        List<CODAGeneralLedgerAccount> spainGlaList = new List<CODAGeneralLedgerAccount>();
        for(integer i=1;i<=3;i++)
        {
            CODAGeneralLedgerAccount gla_spain = CODAGeneralLedgerAccount.create();
            gla_spain.setName(NAME_GLA2+i +SUFFIX);
            gla_spain.setReportingCode(SPAIN_GLA_REPCODE + i);
            gla_spain.setType(CODAGeneralLedgerAccount.TYPE_BALANCESHEET);
            gla_spain.getDto().ChartOfAccountsStructure__c = coaSpain.Id;
            spainGlaList.add(gla_spain);
        }
        CODAUnitOfWork.getCurrent().commitWork();
        
        for(integer j=1;j<=3;j++)
        {
            CODATestIDMapExt.put(NAME_GLA2 + j + SUFFIX, spainGlaList.get(j-1).getId());
        }
        
        //Set 'Active' as true for the local COA = Spain
        coaSpain.DefaultCorporateGLA__c = glaCorporate.getDto().Id;
        coaSpain.DefaultLocalGLA__c = spainGlaList[0].getDto().Id;
        coaSpain.Active__c = true;
        update coaSpain;
        CODATestIDMapExt.put('Spain', coaSpain.Id);

        CodaTestIDMapExt.save(SUFFIX);
    }
    
    public static void createDataExt1()
    {
        CODATestIDMapExt.load(SUFFIX);
        CODAUnitOfWork.createAndSetCurrent();
        
        CODACompany company= CODACompanyMapper.getByName(VAT_COMPANY_NAME)[0];
        company.getDto().LocalChartOfAccountsStructure__c = CODATestIDMap.resolve('Spain');
        company.getDto().EnablePlaceOfSupplyRules__c = true;
        company.setDirty();
        CODAUnitOfWork.getCurrent().commitWork();
        
        //add corporate chart of account structure in corporate glas
        CODAGeneralLedgerAccount__c corporateGLA = [Select Id, Name from CODAGeneralLedgerAccount__c where Name=:CODABaseData.NAMEGLA_STOCKPARTS];
        corporateGLA.ChartOfAccountsStructure__c = CODATestIDMap.resolve(CORPORATE_COA);
        update corporateGLA;
        
        //Creating chart of Account mappings
        List<ChartOfAccountsMapping__c> coaMappings = new List<ChartOfAccountsMapping__c>();
        coaMappings.add(new ChartOfAccountsMapping__c(CorporateGLA__c = CODATestIDMap.resolve(CODABaseData.NAMEGLA_STOCKPARTS), LocalGLA__c = CODATestIDMap.resolve(NAME_GLA2 + '2' + SUFFIX)));
        coaMappings.add(new ChartOfAccountsMapping__c(CorporateGLA__c = CODATestIDMap.resolve(CODABaseData.NAMEGLA_STOCKPARTS), LocalGLA__c = CODATestIDMap.resolve(NAME_GLA2 + '3' + SUFFIX),Dimension1__c = CODATestIDMap.resolve(CODABaseDataExt.NAMEDIM1_EUR)));
        insert coaMappings;
    }
    
    public static void destroyData()
    {
        CODATestIDMapExt.load(SUFFIX);
        CODAContext.enableSupportAccess();
		delete[SELECT Id FROM ChartOfAccountsMapping__c];
        delete[SELECT Id FROM ChartOfAccountsStructure__c];
        delete[SELECT Id FROM CODAGeneralLedgerAccount__c where Name like :'%'+SUFFIX];
        delete[SELECT Id from codaAccountingSettings__c];
		CODACompany company= CODACompanyMapper.getByName(VAT_COMPANY_NAME)[0];
        company.getDto().LocalChartOfAccountsStructure__c = null;
        CODAUnitOfWork.getCurrent().commitWork();
        CODAContext.disableSupportAccess();
        CODATestIDMapExt.purge(SUFFIX);
    }
    
    public static void loadMap()
    {
        // Company Spain
        CODACompany compVAT = CODACompanyMapExt.getCurrentCompany();
        Id compId = compVAT.getId();
        CODATestIDMapExt.put(VAT_COMPANY_NAME, compId);
        
        //Spain Period
        codaPeriod__c periodSpain = [Select Id, Name, OwnerCompany__r.Name from codaPeriod__c where Name = :PERIODNAME_CURRENT AND OwnerCompany__c = :compId limit 1];
        CODATestIDMapExt.put(PERIODNAME_CURRENT + ':' + compVAT.getName(), periodSpain.id);
        
        // Currencies for Merlin Auto Spain
        for (codaAccountingCurrency__c accCurrSpain : [Select Id, Name, OwnerCompany__r.Name from codaAccountingCurrency__c where OwnerCompany__c  = :compId])
        {
            CODATestIDMapExt.put(accCurrSpain.Name + ':' + accCurrSpain.OwnerCompany__r.Name, accCurrSpain.id);
        }
        
        //Bank Account
        codaBankAccount__c bankAccount = [Select Id, Name, OwnerCompany__r.Name from codaBankAccount__c where Name =:CODABaseDataExt.NAMEBANKACC_SANTANDERCURRENTACCOUNT limit 1];
        CODATestIDMapExt.put(bankAccount.Name + ':' + bankAccount.OwnerCompany__r.Name, bankAccount.id);
        
        //Accounts
        Account accId = [Select Id, Name from Account where MirrorName__c =:CODABaseDataExt.NAMEACCOUNT_CAMBRIDGEAUTO];
        CODATestIDMapExt.put(accId.Name, accId.id);
        
        // Products
        Set<String> productList = new Set<String>();
        productList.add(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
        productList.add(CODABaseDataExt.NAMEPRODUCT_BBKFUELPUMP); 
        for (Product2 product : [Select Id, Name from Product2 where Name in :productList])    
        {                                                                                               
            CODATestIDMapExt.put(product.Name, product.id);
        }
        
        //Tax Codes
        codaTaxCode__c tax = [Select Id, Name from codaTaxCode__c where Name =:CODABaseDataExt.NAMETAXCODE_VOSTDSALES];
        CODATestIDMapExt.put(tax.Name, tax.id);
        
        //GLAs
        Set<String> glaNames = new Set<String>();
        glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLEUR);
        glaNames.add(CODABaseData.NAMEGLA_VATINPUT);
        glaNames.add(CODABaseData.NAMEGLA_SALESPARTS);
        glaNames.add(CODABaseData.NAMEGLA_STOCKPARTS);
        glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD);
        
        for(CODAGeneralLedgerAccount__c gla: [Select Id, Name from CODAGeneralLedgerAccount__c where Name in :glaNames])
        {
            CODATestIDMapExt.put(gla.Name, gla.id);
        }
        
        // Dimension 1
        for (codaDimension1__c dim1 : [select id, name from codaDimension1__c])
        {
            CODATestIDMapExt.put(dim1.Name, dim1.id);
        }
        
        // Dimension 2
        for (codaDimension2__c dim2 : [select id, name from codaDimension2__c])
        {
            CODATestIDMapExt.put(dim2.Name, dim2.id);
        }
        
        // Dimension 3
        for (codaDimension3__c dim3 : [select id, name from codaDimension3__c])
        {
            CODATestIDMapExt.put(dim3.Name, dim3.id);
        }
        
        // Dimension 4
        for (codaDimension4__c dim4 : [select id, name from codaDimension4__c])
        {
            CODATestIDMapExt.put(dim4.Name, dim4.id);
        }
       
        CODATestIDMapExt.save(SUFFIX);
    }
}