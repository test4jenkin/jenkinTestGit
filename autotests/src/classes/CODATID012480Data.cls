/*
* FinancialForce.com, inc. claims copyright in this software, its screen
* display designs and supporting documentation. FinancialForce and
* FinancialForce.com are trademarks of FinancialForce.com, inc. Any
* unauthorized use, copying or sale of the above may constitute an
* infringement of copyright and may result in criminal or other legal
* proceedings.
*
* Copyright (c) 2015 FinancialForce.com, inc. All rights reserved.
*/
public class CODATID012480Data
{
    public static String SUFFIX = '#TID012480'; 
    public static String COMPANY_NAME = CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN;
    public static String incomeScheduleName_1 = 'Test Income Schedule 1';
    public static String incomeScheduleName_2 = 'Test Income Schedule 2';  
    
    public static void selectCompany()
    {              
        CODABaseData.switchCurrentCompany(COMPANY_NAME, true, true, UserInfo.getUserId());
    }
    
    // Create Income Schedule and exchange rate for USD currency.
    public static void createData()
    {
        loadmap();
        CODAUnitOfWork.createAndSetCurrent();
        id gla = CODATestIDMap.resolve(CODABaseData.NAMEGLA_DEFERREDINCOMESERVICECONTRACTS);
        //Create Income schedule 1
        CODAIncomeScheduleDefinition incomeSchedule1 = new CODAIncomeScheduleDefinition();
        incomeSchedule1.setName(incomeScheduleName_1);
        incomeSchedule1.setNumberofJournals(2);
        incomeSchedule1.setPeriodInterval(1);        
        incomeSchedule1.setGeneralLedgerAccountId(gla);
        
        //Create Income schedule 2
        CODAIncomeScheduleDefinition incomeSchedule2 = new CODAIncomeScheduleDefinition();
        incomeSchedule2.setName(incomeScheduleName_2);
        incomeSchedule2.setNumberofJournals(3);
        incomeSchedule2.setPeriodInterval(1);
        incomeSchedule2.setGeneralLedgerAccountId(gla);        
        
        //Create Exchange rate for USD currency
        CODACompany company1 = CODACompanyMapper.getByName(COMPANY_NAME)[0];
        Id usdCurrency = CODATestIDMap.resolve(CODABaseData.CURRENCYCODE_USD+':'+CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN);
        CODAAccountingCurrency USDCurr = CODAAccountingCurrencyMapper.getById(usdCurrency);
        String todayDate = String.valueOf(System.Date.today());
        String todayDatePlus15Days = String.valueOf(System.Date.today()+15);
        CODABaseDataExt.createExchangeRate(USDCurr, company1, 1.5, todayDate);
        CODABaseDataExt.createExchangeRate(USDCurr, company1, 2, todayDatePlus15Days);
        
        CODAUnitOfWork.getCurrent().commitWork();     
    }
    
    public static void destroyData()
    {
        CODAContext.enableSupportAccess(); 
        CODAPaymentData.destroyPaymentData(SUFFIX);
        List<codaIncomeScheduleDefinition__c> ICD= [SELECT Id, Name FROM codaIncomeScheduleDefinition__c WHERE Name LIKE 'Test Income Schedule%'];
        delete ICD;
        Date todayDate = Date.valueOf(System.Date.today());
        Date todayDatePlus15Days = Date.valueOf(System.Date.today()+15);
        delete [select Id from codaExchangeRate__c where OwnerCompany__r.name=:CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN and ExchangeRateCurrency__r.name=:CODABaseData.CURRENCYCODE_USD and StartDate__c =:todayDate];
        delete [select Id from codaExchangeRate__c where OwnerCompany__r.name=:CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN and ExchangeRateCurrency__r.name=:CODABaseData.CURRENCYCODE_USD and StartDate__c =:todayDatePlus15Days];
        CODAContext.disableSupportAccess();
    } 
    
    public static void loadMap()
    {        
        // GLAs
        Set<String> glaNames = new Set<String>();
        glaNames.add(CODABaseData.NAMEGLA_DEFERREDINCOMESERVICECONTRACTS);
        for (CODAGeneralLedgerAccount__c item : [Select Id, Name from CODAGeneralLedgerAccount__c where Name in :glaNames])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }
        // Currencies for Merlin Auto Spain
        for (codaAccountingCurrency__c accCurr: [SELECT Id, Name, OwnerCompany__r.Name from codaAccountingCurrency__c where OwnerCompany__r.name = :CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN]) 
        {
            CODATestIDMapExt.put(accCurr.Name + ':' + accCurr.OwnerCompany__r.Name, accCurr.id);            
        }
        CODATestIDMapExt.save(SUFFIX);
    }   
}
