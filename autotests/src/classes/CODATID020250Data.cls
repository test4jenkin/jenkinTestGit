/*
 * Copyright (c) 2016 FinancialForce.com, inc. All rights reserved.
 */
 
public class CODATID020250Data
{
    public static final String SUFFIX = '#TID020250';
    public static final string COMPANY_NAME_SPAIN = CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN;
    public static final string PIN1 = 'PIN001';
    public static final string PIN2 = 'PIN002';
    public static final string PCN1 = 'PCN001';
    public static final string PCN2 = 'PCN002';
    public static final String PERIODNAME_CURRENT = CODAPeriodMapExt.getPeriodByDate(system.today()).getName();
    public static final string VENDOR_INV_NUMBER = 'VIN001';
    public static final string VENDOR_CRN_NUMBER = 'VCRN009';
    public static String LOCAL_GLA_6000 = '6000';
    public static String DEFAULT_CORP_GLA_4001 = '4001';
    public static String NAME_GLA_REPCODE_SPAIN = 'SPAIN';
    public static final String CURRENCY_USD = CODABaseData.CURRENCYCODE_USD;
    public static final String CURRENCY_GBP = CODABaseData.CURRENCYCODE_GBP;
    public static final String LINE_DESCRIPTION = 'Line Description';
    public static final String TRIALBALANCE1_BALANCESHEET = CODAGeneralLedgerAccount.TRIALBALANCE1_BALANCESHEET;
    public static final String TRIALBALANCE2_CURRENTLIABILITIES = CODAGeneralLedgerAccount.TRIALBALANCE2_CURRENTLIABILITIES;
    public static void selectCompany()
    {
        CODABaseData.switchCurrentCompany( COMPANY_NAME_SPAIN, true, true, UserInfo.getUserId());
        CODACompanyMapExt.resetCompanyCache();
    }

    public static void switchProfile()
    {
        Id userId = CODABaseData.getProfile(CODABaseData.ACCOUNTANT).Id;
        CODABaseData.switchCurrentCompany( COMPANY_NAME_SPAIN, true, false, userId);
        CODACompanyMapExt.resetCompanyCache();
    }

    public static void createData()
    {
        loadMap();
        CODAUnitOfWork.createAndSetCurrent();
        delete[select ID from codaAccountingSettings__c];
        codaAccountingSettings__c accSetting = new codaAccountingSettings__c();
        accSetting.AllowUseOfLocalGLAs__c = true;
        insert accSetting;
        
        CODACompany companySpain= CODACompanyMapper.getByName(COMPANY_NAME_SPAIN)[0];
        
        //creating Corporate Chart of Account
        ChartOfAccountsStructure__c corporate = new ChartOfAccountsStructure__c();
        corporate.Name = 'Corporate';
        corporate.DefaultCorporateGLA__c = null;
        corporate.DefaultLocalGLA__c = null;
        corporate.IsCorporate__c = true;
        corporate.Active__c = true;
        insert corporate;
        
        //creating Corporate GLA
        CODAGeneralLedgerAccount glaCorporate = CODAGeneralLedgerAccount.create();
        glaCorporate.setName(DEFAULT_CORP_GLA_4001);
        glaCorporate.setReportingCode('Corporate');
        glaCorporate.setType(CODAGeneralLedgerAccount.TYPE_BALANCESHEET);
        glaCorporate.setCurrencyIsoCode(CURRENCY_USD);
        glaCorporate.getDto().ChartOfAccountsStructure__c = corporate.Id;
        
        CODAUnitOfWork.getCurrent().commitWork();
        CODATestIDMapExt.put(DEFAULT_CORP_GLA_4001, glaCorporate.getId());
        
        //Creating Local COA 'Spain'
        ChartOfAccountsStructure__c coaSpain = new ChartOfAccountsStructure__c();
        coaSpain.Name = 'Spain';
        coaSpain.DefaultCorporateGLA__c = null;
        coaSpain.DefaultLocalGLA__c = null;
        coaSpain.IsCorporate__c = false;
        coaSpain.Active__c = false;
        insert coaSpain;
        
        //creating Local GLAs for Spain
        CODAGeneralLedgerAccount localGLA60001 = createLocalGLA('Local Default', '', '', coaSpain);
        CODAGeneralLedgerAccount localGLAAPC60002 = createLocalGLA('Local APC', TRIALBALANCE1_BALANCESHEET, TRIALBALANCE2_CURRENTLIABILITIES, coaSpain);
        CODAGeneralLedgerAccount localGLASettlmentAcc1 = createLocalGLA('Local Settlement Acc 1', '', '', coaSpain);
        CODAGeneralLedgerAccount localGLAWritOffAcc1 = createLocalGLA('Local WriteOff Acc 1', '', '', coaSpain);
        CODAUnitOfWork.getCurrent().commitWork();
        
        CODATestIDMapExt.put(localGLA60001.getName(), localGLA60001.getId());
        CODATestIDMapExt.put(localGLAAPC60002.getName(), localGLAAPC60002.getId());
        CODATestIDMapExt.put(localGLASettlmentAcc1.getName(), localGLASettlmentAcc1.getId());
        CODATestIDMapExt.put(localGLAWritOffAcc1.getName(), localGLAWritOffAcc1.getId());
        
        //Set 'Active' as true for the local COA = Spain
        coaSpain.DefaultCorporateGLA__c = glaCorporate.getDto().Id;
        coaSpain.DefaultLocalGLA__c = localGLA60001.getId();
        coaSpain.Active__c = true;
        update coaSpain;
        
        companySpain.getDto().LocalChartOfAccountsStructure__c = coaSpain.id;
        companySpain.getDto().EnablePlaceOfSupplyRules__c = true;
        companySpain.setDirty();
        
        CODAUnitOfWork.getCurrent().commitWork();
        
        Set<String> corporateGla = new Set<String>(); 
        corporateGla.add(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLEUR);
        corporateGla.add(CODABaseData.NAMEGLA_SETTLEMENTDISCOUNTSALLOWEDUS);
        corporateGla.add(CODABaseData.NAMEGLA_WRITEOFFUS);
        
        List<CODAGeneralLedgerAccount__c> glas = [Select Id, Name from CODAGeneralLedgerAccount__c where Name in :corporateGla];       
        for(CODAGeneralLedgerAccount__c gla : glas)
        {
            gla.ChartOfAccountsStructure__c = corporate.Id;
        }
        update glas;
        
        //Creating chart of Account mappings
        List<ChartOfAccountsMapping__c> mappings = new List<ChartOfAccountsMapping__c>();
        mappings.add(createMapping(DEFAULT_CORP_GLA_4001, localGLA60001.getId()));
        mappings.add(createMapping(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLEUR, localGLAAPC60002.getId()));
        mappings.add(createMapping(CODABaseData.NAMEGLA_SETTLEMENTDISCOUNTSALLOWEDUS, localGLASettlmentAcc1.getId()));
        mappings.add(createMapping(CODABaseData.NAMEGLA_WRITEOFFUS, localGLAWritOffAcc1.getId()));
        insert mappings;
        
        CODAUserCompany usercomp = CODABaseData.getUserCompany(companySpain.getId(),UserInfo.getUserId());
        usercomp.setUseLocalAccount(true);
        CODAUnitOfWork.getCurrent().commitWork();
        
        CODATestIDMapExt.save(SUFFIX);
    }
    
    // Create PINV in complete for Buying on behalf of functionality
    public static void createDataExt1()
    {
        CODATestIDMapExt.load(SUFFIX);
        CODAUnitOfWork.createAndSetCurrent();
        
        CODAPurchaseInvoiceTestHelper pinv = new CODAPurchaseInvoiceTestHelper();
        pinv.setAccount(CODABaseDataExt.NAMEACCOUNT_AUDI);
        pinv.setInvoiceDate(system.today());
        pinv.setVendorInvoiceNumber(VENDOR_INV_NUMBER);
        pinv.setAccountInvoiceTotal(CODAFormatter.decimalToString(100.00));
        pinv.setInvoiceDescription(VENDOR_INV_NUMBER);
        
        CODAPurchaseInvoiceTestHelper.ProductLineItem pline1 = pinv.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
        pline1.setQuantity(1);
        pline1.setUnitPrice(100);
        pline1.setLineDescription(PIN1+LINE_DESCRIPTION+'1');
        pinv.setAccountInvoiceTotal(pinv.getInvoiceTotal());
        
        pinv.saveAndPost();
        pinv.reload();
        CODATestIDMapExt.put(PIN1, pinv.getId());
        CODATestIDMapExt.save(SUFFIX);
    }
    
    // Destroy data
    public static void destroyData()
    {
        CODATestIDMapExt.load(SUFFIX);
        CODAUnitOfWork.createAndSetCurrent();
        CODACompany companySpain= CODACompanyMapper.getByName(COMPANY_NAME_SPAIN)[0];
        companySpain.getDto().EnablePlaceOfSupplyRules__c = false;
        companySpain.setDirty();
        CODAUnitOfWork.getCurrent().commitWork();
        CODAContext.enableSupportAccess();
        delete[SELECT Id FROM ChartOfAccountsMapping__c];
        delete[SELECT Id FROM ChartOfAccountsStructure__c];
        delete[SELECT Id FROM CODAGeneralLedgerAccount__c where Name='4001'or reportingCode__c like 'Local%' or reportingCode__c like 'SPAIN%'];
        delete[select ID from codaAccountingSettings__c];
        delete[select Id from codaTransaction__c];
        delete[select Id from codaPurchaseInvoice__c];
        delete[select Id from codaPurchaseCreditNote__c];
        CODAContext.disableSupportAccess();
        CODATestIDMapExt.purge(SUFFIX);
    }
    
    // create mapping
    public static ChartOfAccountsMapping__c createMapping(String corpGLA, Id localGLAId)
    {
        ChartOfAccountsMapping__c mapping = new ChartOfAccountsMapping__c();
        mapping.CorporateGLA__c = CODATestIDMap.Resolve(corpGLA);
        mapping.LocalGLA__c = localGLAId;
        return mapping;
    }
    
    // create local glas
    public static CODAGeneralLedgerAccount createLocalGLA(String glaName, String trailBalance1, String trailBalance2, ChartOfAccountsStructure__c coaSpain)
    {
        CODAGeneralLedgerAccount gla = CODAGeneralLedgerAccount.create();
        gla.setName(glaName);
        gla.setCurrencyIsoCode(CURRENCY_USD);
        gla.setReportingCode(glaName);
        gla.setType(CODAGeneralLedgerAccount.TYPE_BALANCESHEET);
        gla.setTrialBalance1(trailBalance1);
        gla.setTrialBalance2(trailBalance2);
        gla.getDto().ChartOfAccountsStructure__c = coaSpain.Id;
        return gla;
    }
    
    // LoadMap method to load base data into Coda Test Id Map
    public static void loadMap()
    {
        //Company
        CODACompany compVAT = CODACompanyMapper.getByName( COMPANY_NAME_SPAIN)[0];
        Id compId = compVAT.getId();
        CODATestIDMapExt.put(COMPANY_NAME_SPAIN, compId);
        
        //Spain Period
        codaPeriod__c periodSpain = [Select Id, Name, OwnerCompany__r.Name from codaPeriod__c where Name = :PERIODNAME_CURRENT AND OwnerCompany__c = :compId limit 1];
        CODATestIDMapExt.put(PERIODNAME_CURRENT + ':' +  COMPANY_NAME_SPAIN, periodSpain.id);
        
        //Currencies for Merlin Auto Spain
        for (codaAccountingCurrency__c accCurrSpain : [Select Id, Name, OwnerCompany__r.Name from codaAccountingCurrency__c where OwnerCompany__c  = :compId])
        {
            CODATestIDMapExt.put(accCurrSpain.Name + ':' + accCurrSpain.OwnerCompany__r.Name, accCurrSpain.id);
        }
        //Bank Account
        codaBankAccount__c bankAccount = [Select Id, Name, OwnerCompany__r.Name from codaBankAccount__c where Name =:CODABaseDataExt.NAMEBANKACC_SANTANDERUSDACCOUNT limit 1];
        CODATestIDMapExt.put(bankAccount.Name + ':' + bankAccount.OwnerCompany__r.Name, bankAccount.id);
        
        //Accounts
        Set<String> accNames = new Set<String>();
        accNames.add(CODABaseDataExt.NAMEACCOUNT_AUDI);
        for (Account accId : [Select Id, Name from Account where MirrorName__c in :accNames])
        {
            CODATestIDMapExt.put(accId.Name, accId.id);
        }
        
        //Product
        Product2  item = [Select Id, Name from Product2  where Name =: CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH];
        CODATestIDMapExt.put(item.Name, item.id);
        
        //GLAs
        Set<String> glaNames = new Set<String>();
        glaNames.add(CODABaseData.NAMEGLA_SETTLEMENTDISCOUNTSALLOWEDUS);
        glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLEUR);
        glaNames.add(CODABaseData.NAMEGLA_WRITEOFFUS);
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