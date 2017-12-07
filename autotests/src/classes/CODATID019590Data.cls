/*
 * FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 * supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 * Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 * result in criminal or other legal proceedings.
 *
 * Copyright (c) 2016 FinancialForce.com, inc. All rights reserved.
 */
 public class CODATID019590Data
{
    public static final String SUFFIX = '#TID019590';
    public static final String COMPANY_NAME = CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN;
    public static String PERIODNAME_CURRENT = CODAPeriodMapExt.getPeriodByDate(system.today()).getName();
    public static final String DEFAULT_CORPORATE_GLA = '4001'+SUFFIX;
    public static final String DEFAULT_LOCAL_GLA_60001 = '60001'+SUFFIX;
    public static final String LOCAL_GLA_60002 = '60002'+SUFFIX;
    public static final String LOCAL_GLA_60003 = '60003'+SUFFIX;
    public static final String LOCAL_GLA_60004 = '60004'+SUFFIX;
    public static final String CORPORATE_COA = 'Corporate';
    public static final String LOCAL_COA_FRENCH = 'French'+SUFFIX;
    public static final String NAMEGLA_ACCOUNTSPAYABLECONTROLEUR = CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLEUR;
    public static final String NAMEGLA_POSTAGEANDSTATIONERY = CODABaseData.NAMEGLA_POSTAGEANDSTATIONERY;
    public static final String NAMEGLA_VATINPUT = CODABaseData.NAMEGLA_VATINPUT;
    public static string REFERENCE1 = 'PIN001'+SUFFIX;
    public static string INTERSECTDEFINITION_NAME = 'Local GLA';
    
    // Select current company for the current user
    public static void selectCompany()
    {
        CODABaseData.switchCurrentCompany(COMPANY_NAME, true, true, UserInfo.getUserId());
        CODAUnitOfWork.getCurrent().clearWork();
    }

    // switch Profile and select current company
    public static void switchProfile()
    {
        Id accountant = CODABaseData.getProfile(CODABaseData.ACCOUNTANT).Id;
        CODABaseData.switchCurrentCompany(COMPANY_NAME, true, false, accountant);
    }

    // Creating data required for the test
    public static void createData()
    {
        loadMap();
        CODAUnitOfWork.createAndSetCurrent();
        codaAccountingSettings__c accountingSettings = new codaAccountingSettings__c(); 
        accountingSettings.AllowUseOfLocalGLAs__c = true;
        insert accountingSettings;
        // create corporate coa
        ChartOfAccountsStructure__c corporateCOA = new ChartOfAccountsStructure__c();
        corporateCOA.Name = CORPORATE_COA;
        corporateCOA.Active__c = true;
        corporateCOA.IsCorporate__c = true;
        insert corporateCOA;
        
        ChartOfAccountsStructure__c localCOA = new ChartOfAccountsStructure__c();
        localCOA.Name = LOCAL_COA_FRENCH;
        localCOA.Active__c = false;
        localCOA.IsCorporate__c = false;
        insert localCOA;
        
        // set COA on corporate glas
        CODAGeneralLedgerAccount__c corporateGLA1 = [select Id, ChartOfAccountsStructure__c from CODAGeneralLedgerAccount__c where Name =:NAMEGLA_ACCOUNTSPAYABLECONTROLEUR limit 1];
        corporateGLA1.ChartOfAccountsStructure__c = corporateCOA.Id;
        update corporateGLA1;
        CODAGeneralLedgerAccount__c corporateGLA2 = [select Id, ChartOfAccountsStructure__c from CODAGeneralLedgerAccount__c where Name =:NAMEGLA_POSTAGEANDSTATIONERY limit 1];
        corporateGLA2.ChartOfAccountsStructure__c = corporateCOA.Id;
        update corporateGLA2;
        CODAGeneralLedgerAccount__c corporateGLA3 = [select Id, ChartOfAccountsStructure__c from CODAGeneralLedgerAccount__c where Name =:NAMEGLA_VATINPUT limit 1];
        corporateGLA3.ChartOfAccountsStructure__c = corporateCOA.Id;
        update corporateGLA3;
        CODAGeneralLedgerAccount defaultCorporateGLA = CODAGeneralLedgerAccount.create();
        defaultCorporateGLA.setType(CODAGeneralLedgerAccount.TYPE_BALANCESHEET);
        defaultCorporateGLA.setName(DEFAULT_CORPORATE_GLA);
        defaultCorporateGLA.getdto().ChartOfAccountsStructure__c = corporateCOA.Id;
        
        CODAGeneralLedgerAccount localGLA1 = CODAGeneralLedgerAccount.create();
        localGLA1.setType(CODAGeneralLedgerAccount.TYPE_BALANCESHEET);
        localGLA1.setName(DEFAULT_LOCAL_GLA_60001);
        localGLA1.getdto().ChartOfAccountsStructure__c = localCOA.Id;
        
        CODAGeneralLedgerAccount localGLA2 = CODAGeneralLedgerAccount.create();
        localGLA2.setType(CODAGeneralLedgerAccount.TYPE_BALANCESHEET);
        localGLA2.setName(LOCAL_GLA_60002);
        localGLA2.getdto().ChartOfAccountsStructure__c = localCOA.Id;
        
        CODAGeneralLedgerAccount localGLA3 = CODAGeneralLedgerAccount.create();
        localGLA3.setType(CODAGeneralLedgerAccount.TYPE_BALANCESHEET);
        localGLA3.setName(LOCAL_GLA_60003);
        localGLA3.getdto().ChartOfAccountsStructure__c = localCOA.Id;
        
        CODAGeneralLedgerAccount localGLA4 = CODAGeneralLedgerAccount.create();
        localGLA4.setType(CODAGeneralLedgerAccount.TYPE_BALANCESHEET);
        localGLA4.setName(LOCAL_GLA_60004);
        localGLA4.getdto().ChartOfAccountsStructure__c = localCOA.Id;
        
        CODAUnitOfWork.getCurrent().commitWork();
        CODATestIDMapExt.put(defaultCorporateGLA.getName(), defaultCorporateGLA.getId());
        CODATestIDMapExt.put(localGLA1.getName(), localGLA1.getId());
        CODATestIDMapExt.put(localGLA2.getName(), localGLA2.getId());
        CODATestIDMapExt.put(localGLA3.getName(), localGLA3.getId());
        CODATestIDMapExt.put(localGLA4.getName(), localGLA4.getId());
        CODATestIDMapExt.put(CORPORATE_COA, corporateCOA.Id);
        CODATestIDMapExt.put(LOCAL_COA_FRENCH, localCOA.Id);
        CODATestIDMapExt.save(SUFFIX);  
    }
    
    // Activate local COA, set COA on current company
    public static void createDataExt1()
    {
        CODATestIDMapExt.load(SUFFIX);
        
        // Activate local COA 
        ChartOfAccountsStructure__c localCOAFrench = [select Active__c, DefaultLocalGLA__c, DefaultCorporateGLA__c from ChartOfAccountsStructure__c where Name = :LOCAL_COA_FRENCH limit 1];
        localCOAFrench.Active__c = true;
        localCOAFrench.DefaultLocalGLA__c = CODATestIDMap.resolve(DEFAULT_LOCAL_GLA_60001);
        localCOAFrench.DefaultCorporateGLA__c = CODATestIDMap.resolve(DEFAULT_CORPORATE_GLA);
        update localCOAFrench;
        
        // Populate COA on current company
        codaCompany__c company = [select Id, LocalChartOfAccountsStructure__c from codaCompany__c where Name =:COMPANY_NAME];
        company.LocalChartOfAccountsStructure__c = CODATestIDMap.resolve(LOCAL_COA_FRENCH);
        update company;
    }
    
    // Destroy the data created for the test
    public static void destroyData()
    {
        CODATestIDMapExt.load(SUFFIX);
         CODAContext.enableSupportAccess();
        
        // delete stuff
        delete [select Id from ChartOfAccountsMapping__c];
        delete [select Id from CodaGeneralLedgerAccount__c where Name =:DEFAULT_CORPORATE_GLA];
        delete [select Id from CodaGeneralLedgerAccount__c where Name =:DEFAULT_LOCAL_GLA_60001];
        delete [select Id from CodaGeneralLedgerAccount__c where Name =:LOCAL_GLA_60002];
        delete [select Id from CodaGeneralLedgerAccount__c where Name =:LOCAL_GLA_60003];
        delete [select Id from CodaGeneralLedgerAccount__c where Name =:LOCAL_GLA_60004];
        delete [select Id from codaAccountingSettings__c];

        // update company
        codaCompany__c company = [select Id, LocalChartOfAccountsStructure__c from codaCompany__c where Name =:COMPANY_NAME];
        company.LocalChartOfAccountsStructure__c = null;
        update company;
        
        // Update glas
        CODAGeneralLedgerAccount__c corporateGLA1 = [select Id, ChartOfAccountsStructure__c from CODAGeneralLedgerAccount__c where Name =:NAMEGLA_ACCOUNTSPAYABLECONTROLEUR limit 1];
        corporateGLA1.ChartOfAccountsStructure__c = null;
        update corporateGLA1;
        CODAGeneralLedgerAccount__c corporateGLA2 = [select Id, ChartOfAccountsStructure__c from CODAGeneralLedgerAccount__c where Name =:NAMEGLA_POSTAGEANDSTATIONERY limit 1];
        corporateGLA2.ChartOfAccountsStructure__c = null;
        update corporateGLA2;
        CODAGeneralLedgerAccount__c corporateGLA3 = [select Id, ChartOfAccountsStructure__c from CODAGeneralLedgerAccount__c where Name =:NAMEGLA_VATINPUT limit 1];
        corporateGLA3.ChartOfAccountsStructure__c = null;
        update corporateGLA3;
        
        list<ChartOfAccountsStructure__c> coaList = [select Id, Active__c from ChartOfAccountsStructure__c];
        for(ChartOfAccountsStructure__c coa : coaList)
        {
            coa.Active__c = false;
        }
        update coaList;
        delete coaList;

        
        CODATestIDMapExt.purge(SUFFIX);
    }
    
    // Loading usable data into CODATestIDMap
    public static void loadMap()
    {
        //SUT Company
        CODACompany compVAT = CODACompanyMapExt.getCurrentCompany();
        Id compId = compVAT.getId();
        CODATestIDMapExt.put(COMPANY_NAME, compId);
        
        // General Ledger Account
        set<String> glaNames = new set<String>();
        glaNames.add(NAMEGLA_ACCOUNTSPAYABLECONTROLEUR);
        glaNames.add(NAMEGLA_POSTAGEANDSTATIONERY);
        glaNames.add(NAMEGLA_VATINPUT);
        glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLGBP);
        for(CODAGeneralLedgerAccount__c gla : [select Id, Name from CODAGeneralLedgerAccount__c where Name In :glaNames])
        {
            CODATestIDMapExt.put(gla.Name, gla.id);
        }
        
        //USA Period
        codaPeriod__c periodUSA = [Select Id, Name, OwnerCompany__r.Name from codaPeriod__c where Name = :PERIODNAME_CURRENT AND OwnerCompany__c = :compId limit 1];
        CODATestIDMapExt.put(PERIODNAME_CURRENT + ':' + compVAT.getName(), periodUSA.id);
        
        // Currencies for Merlin Auto USA
        for (codaAccountingCurrency__c accCurrUSA : [Select Id, Name, OwnerCompany__r.Name from codaAccountingCurrency__c where OwnerCompany__c  = :compId])
        {
            CODATestIDMapExt.put(accCurrUSA.Name + ':' + accCurrUSA.OwnerCompany__r.Name, accCurrUSA.id);
        }
        
        CODATestIDMapExt.save(SUFFIX);
    }  
}