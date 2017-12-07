/*
* Copyright (c) 2016 FinancialForce.com, inc.  All rights reserved.
*/
public class CODATID016689Data  
{ 
    public static String SUFFIX = 'TID016689#';
    public static string COMPANY_NAME = CODABaseData.NAMECOMPANY_MERLINAUTOUSA;
    public static string INVOICE_REF1 = 'PINV_REF_1';
    public static string CREDIT_NOTE_REF1 = 'PCRN_REF_1';
    public static string JOURNAL_REF1 = 'JRNL_REF_1';
    public static Decimal UNIT_PRICE_6_64583333 = 6.64583333;
    public static Decimal QUANTITY_12 = 12;
    public static Date INVOICE_DATE = Date.today();
    public static Date DUE_DATE = Date.today().AddDays(7);
    public static string INVOICE_NAME1 = 'INVOICE1';
    public static string SCRN_NAME1 = 'SCRN1';
    
    /* Required by the system test runner: switch profile for this test script */ 
    public static void switchProfile() 
    { 
        Id userId = CODABaseData.getProfile(CODABaseData.ACCOUNTANT).Id;
        CODABaseData.switchCurrentCompany(COMPANY_NAME, true, false, userId);        
    } 
    
    /* Required by the system test runner: change to the correct company for this test script */ 
    public static void selectCompany()
    { 
        CODABaseData.switchCurrentCompany(COMPANY_NAME, true, true, UserInfo.getUserId());        
    } 
    
    /*Set accounting settings CopyProductDescriptionToLine__c = false  */ 
    public static void createData() 
    { 
        loadMap();
		codaAccountingSettings__c accSetting = new codaAccountingSettings__c();
        accSetting.CopyProductDescriptionToLine__c = false;
        Insert accSetting;
    }
	
	//Revert accounting settings
	public static void destroyData()
    {
        DELETE [select Id from codaAccountingSettings__c];
        CODAPaymentData.destroyPaymentData(SUFFIX);
    }
    
    public static void loadMap()
    {
        //Account
        for (Account acc : [SELECT Id, Name FROM Account WHERE MirrorName__c = :CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO])
        {
            CODATestIDMapExt.put(acc.Name, acc.id); 
        }	
        //Product
        Set<String> prodNames = new Set<String>();
        prodNames.add(CODABaseDataExt.NAMEPRODUCT_AUTO1COMCLUTCH);
        prodNames.add(CODABaseDataExt.NAMEPRODUCT_A4PAPE);
        for (Product2 item : [Select Id, Name from Product2 where Name = :CODABaseDataExt.NAMEPRODUCT_AUTO1COMCLUTCH])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }
        
        // Company
        CODACompany company = CODACompanyMapExt.getCurrentCompany();
        Id compId = company.getId();
        
        // Years for Merlin Auto USA
        for (codaPeriod__c period : [Select Id, Name, OwnerCompany__r.Name from codaPeriod__c where OwnerCompany__c = :compId])
        {
            CODATestIDMapExt.put(period.Name + ':' + period.OwnerCompany__r.Name, period.id);
        }
        
        // Periods for Merlin Auto USA
        for (codaYear__c year : [Select Id, Name, OwnerCompany__r.Name from codaYear__c where OwnerCompany__c = :compId])
        {
            CODATestIDMapExt.put(year.Name + ':' + year.OwnerCompany__r.Name, year.id);
        }
        
        // Currencies for Merlin Auto USA
        for (codaAccountingCurrency__c accCurr : [Select Id, Name, OwnerCompany__r.Name from codaAccountingCurrency__c where OwnerCompany__c  = :compId])
        {
            CODATestIDMapExt.put(accCurr.Name + ':' + accCurr.OwnerCompany__r.Name, accCurr.id);
        }
        
        Set<String> taxNames = new Set<String>();
        taxNames.add(CODABaseDataExt.NAMETAXCODE_VOSTDSALES);
        for (codaTaxCode__c item : [Select Id, Name from codaTaxCode__c])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }
        
        for (CODAGeneralLedgerAccount__c item : [Select Id, Name from CODAGeneralLedgerAccount__c])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }        
        CODATestIDMapExt.save(SUFFIX);        
    }    
}