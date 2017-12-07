/*
* FinancialForce.com, inc. claims copyright in this software, its screen display designs and 
* supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc. 
* Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may 
* result in criminal or other legal proceedings. 
*
* Copyright FinancialForce.com, inc. All rights reserved.
*/
public class CODATID010944Data 
{
    public static String SUFFIX = '#TID010944'; 
    public static String COMPANY_NAME = CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN;
    public static String incomeScheduleName_36 = 'IncomePeriod_36';
    public static String incomeScheduleName_36_1 = 'IncomePeriod_36_1';
    public static String incomeScheduleName_3 = 'IncomePeriod_3';
    public static String incomeScheduleName_6 = 'IncomePeriod_6';
    public static String incomeScheduleName_9 = 'IncomePeriod_9';  
    public static String monthlySpread = 'Monthly Spread 1';
    public static String PROD_NAME = 'PROD_SUT_';
    public static String ACCOUNT_NAME_EUR = 'ACC_EUR_1';
    public static String INVOICE_REF = 'IS-SIN1';
    public static String EUR_CURRENCY=CODABaseData.CURRENCYCODE_EUR;  
    public static String INVOICE_NAME='SIN_NAME';
    public static String INVOICE_NAME_1='SIN_NAME_1';
    public static String INVOICE_NAME_2='SIN_NAME_2';
    public static integer LINEITEM_QUANTITY =1;
    public static integer UNITPRICE = 10;
    public static String DIMENSION1_NAME='Dim 1-EUR-';
    public static String DIMENSION2_NAME='Dim 2-EUR-';
    public static String DIMENSION3_NAME='Dim 3-EUR-';
    public static String DIMENSION4_NAME='Dim 4-EUR-';
    public static String SAVE_INV = 'SAVE';
    public static String POST_INV = 'POST';
    public static String SAVE_AND_POST_INV = 'SAVE_AND_POST';    
    
    
   public static void switchProfile() 
    {
        Id userId = CODABaseData.getProfile(CODABaseData.ACCOUNTANT).Id;
        CODABaseData.switchCurrentCompany(COMPANY_NAME, true, false, userId);
    }
    
    public static void selectCompany()
    {              
        CODABaseData.switchCurrentCompany(COMPANY_NAME, true, true, UserInfo.getUserId());
    }
    
    //create Income Schedules
    public static void createData()
    {
        loadmap(); 
        CODAUnitOfWork.getCurrent();
        
        CODAIncomeScheduleDefinition incomeSchedule = new CODAIncomeScheduleDefinition();
        incomeSchedule.setName(incomeScheduleName_36);
        incomeSchedule.setNumberofJournals(36);
        incomeSchedule.setPeriodInterval(1);
        id gla = CODATestIDMap.resolve(CODABaseData.NAMEGLA_DEFERREDINCOMESERVICECONTRACTS);        
        incomeSchedule.setGeneralLedgerAccountId(gla);        
       
		CODAIncomeScheduleDefinition incomeSchedule1 = new CODAIncomeScheduleDefinition();
        incomeSchedule1.setName(incomeScheduleName_36_1);
        incomeSchedule1.setNumberofJournals(36);
        incomeSchedule1.setPeriodInterval(1);        
        incomeSchedule1.setGeneralLedgerAccountId(gla);
      
        CODAIncomeScheduleDefinition incomeSchedule2 = new CODAIncomeScheduleDefinition();
        incomeSchedule2.setName(incomeScheduleName_3);
        incomeSchedule2.setNumberofJournals(3);
        incomeSchedule2.setPeriodInterval(1);
        incomeSchedule2.setGeneralLedgerAccountId(gla);        
        
        CODAIncomeScheduleDefinition incomeSchedule4 = new CODAIncomeScheduleDefinition();
        incomeSchedule4.setName(incomeScheduleName_6);
        incomeSchedule4.setNumberofJournals(6);
        incomeSchedule4.setPeriodInterval(1);
        incomeSchedule4.setGeneralLedgerAccountId(gla); 
        
        CODAIncomeScheduleDefinition incomeSchedule6 = new CODAIncomeScheduleDefinition();
        incomeSchedule6.setName(incomeScheduleName_9);
        incomeSchedule6.setNumberofJournals(9);
        incomeSchedule6.setPeriodInterval(1);        
        incomeSchedule6.setGeneralLedgerAccountId(gla);  
        
        CODAIncomeScheduleDefinition incomeSchedule8 = new CODAIncomeScheduleDefinition();
        incomeSchedule8.setName(monthlySpread);
        incomeSchedule8.setNumberofJournals(12);
        incomeSchedule8.setPeriodInterval(1);        
        incomeSchedule8.setGeneralLedgerAccountId(gla);          
        
        CODAUnitOfWork.getCurrent().commitWork();
        CODATestIDMapExt.put(incomeScheduleName_36, incomeSchedule.getId());   
        CODATestIDMapExt.put(incomeScheduleName_36_1, incomeSchedule1.getId());
        CODATestIDMapExt.put(incomeScheduleName_3, incomeSchedule2.getId());   
        CODATestIDMapExt.put(incomeScheduleName_6, incomeSchedule4.getId());   
        CODATestIDMapExt.put(incomeScheduleName_9, incomeSchedule6.getId());
        CODATestIDMapExt.put(monthlySpread, incomeSchedule8.getId());
        CODATestIDMapExt.save(SUFFIX);        
    }
    
    //create Products with 42 line Items
    public static void createDataExt1()
    {
        CODAContext.SetService(true);
        CODAUnitOfWork.getCurrent();
        CODATestIDMapExt.load(SUFFIX);
        
        String salesRevenueAccountName='GLA_USD_1';
        Integer StartRange=1;
        Integer EndRange=14;
        boolean differentRevenueAccount=false;
        
        Set<String> productNames1=CODAVolumeBaseData.createProducts(PROD_NAME, salesRevenueAccountName,  StartRange , EndRange ,differentRevenueAccount);
        
        salesRevenueAccountName='GLA_EUR_1';
        StartRange=15;
        EndRange=28;
        differentRevenueAccount=false;
        Set<String> productNames2=CODAVolumeBaseData.createProducts(PROD_NAME, salesRevenueAccountName,  StartRange , EndRange ,differentRevenueAccount);
        
        salesRevenueAccountName='GLA_GBP_1';
        StartRange=29;
        EndRange=42;
        Set<String> productNames3= CODAVolumeBaseData.createProducts(PROD_NAME, salesRevenueAccountName,  StartRange , EndRange ,differentRevenueAccount);
        
        CODAUnitOfWork.getCurrent().commitWork();
        for (Product2  item : [Select Id, Name from Product2  where Name like 'PROD_%'])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }
        CODATestIDMapExt.save(SUFFIX);        
    }
    
    //Create Sales invoices 1 and 2
    public static void createDataExt2()
    {    
        CODAUnitOfWork.getCurrent();
        CODATestIDMapExt.load(SUFFIX);
        Date invoiceDate=date.newInstance(2010,01,01);
        CODAAccount accSales = CODAAccountHelperForTests.getCodaAccountByName(ACCOUNT_NAME_EUR)[0];
        CODAInvoice invoice4=CODAVolumeDataTestHelper.createSalesInvoice(accSales,invoiceDate,EUR_CURRENCY,INVOICE_REF);
        CODAInvoice invoice5=CODAVolumeDataTestHelper.createSalesInvoice(accSales,invoiceDate,EUR_CURRENCY,INVOICE_REF);

        CODAUnitOfWork.getCurrent().commitWork();
        CODATestIDMapExt.put(INVOICE_NAME_1, invoice4.getId());
        CODATestIDMapExt.put(INVOICE_NAME_2, invoice5.getId());        
		
        CODATestIDMapExt.save(SUFFIX);        
    }  

    
    //Invoice 42 line items with Invoice 1
    public static void createDataExt3()
    {	
        CODAContext.SetService(true); 
        CODAUnitOfWork.getCurrent();
        CODATestIDMapExt.load(SUFFIX);
        CODAInvoice  invoiceObj=CODAInvoiceMapper.getById(CODATestIDMap.resolve(INVOICE_NAME_1));
        invoiceObj.setInvoiceDescription('SIN_IS_1');
        CODATaxCode taxCode1= CODATaxCodeMapper.getByName(CODABaseDataExt.NAMETAXCODE_STATETAXCODESUT)[0];
        CODATaxCode taxCode2= CODATaxCodeMapper.getByName(CODABaseDataExt.NAMETAXCODE_COUNTRYTAXCODESUT)[0]; 
        CODATaxCode taxCode3= CODATaxCodeMapper.getByName(CODABaseDataExt.NAMETAXCODE_CITYTAXCODESUT)[0];        
        
        CODAVolumeDataTestHelper.addInvoiceLineItems(invoiceObj,null,PROD_NAME,LINEITEM_QUANTITY,UNITPRICE,taxCode1,taxCode2,taxCode3,DIMENSION1_NAME,DIMENSION2_NAME,DIMENSION3_NAME,DIMENSION4_NAME,1,10); 
        CODAVolumeDataTestHelper.addInvoiceLineItems(invoiceObj,null,PROD_NAME,LINEITEM_QUANTITY,UNITPRICE,taxCode1,taxCode2,taxCode3,DIMENSION1_NAME,DIMENSION2_NAME,DIMENSION3_NAME,DIMENSION4_NAME,11,20); 
        CODAVolumeDataTestHelper.addInvoiceLineItems(invoiceObj,null,PROD_NAME,LINEITEM_QUANTITY,UNITPRICE,taxCode1,taxCode2,taxCode3,DIMENSION1_NAME,DIMENSION2_NAME,DIMENSION3_NAME,DIMENSION4_NAME,21,30); 
        CODAVolumeDataTestHelper.addInvoiceLineItems(invoiceObj,null,PROD_NAME,LINEITEM_QUANTITY,UNITPRICE,taxCode1,taxCode2,taxCode3,DIMENSION1_NAME,DIMENSION2_NAME,DIMENSION3_NAME,DIMENSION4_NAME,31,40);
        CODAVolumeDataTestHelper.addInvoiceLineItems(invoiceObj,null,PROD_NAME,LINEITEM_QUANTITY,UNITPRICE,taxCode1,taxCode2,taxCode3,DIMENSION1_NAME,DIMENSION2_NAME,DIMENSION3_NAME,DIMENSION4_NAME,41,42); 
        
        CODAUnitOfWork.getCurrent().commitWork();
    }    
   
    //Invoice 42 line items with Invoice 2
    public static void createDataExt4()
    {	
        CODAContext.SetService(true); 
        CODAUnitOfWork.getCurrent();
        CODATestIDMapExt.load(SUFFIX);
        CODAInvoice  invoiceObj=CODAInvoiceMapper.getById(CODATestIDMap.resolve(INVOICE_NAME_2));
        invoiceObj.setInvoiceDescription('SIN_IS_2');
        CODATaxCode taxCode1= CODATaxCodeMapper.getByName(CODABaseDataExt.NAMETAXCODE_STATETAXCODESUT)[0];
        CODATaxCode taxCode2= CODATaxCodeMapper.getByName(CODABaseDataExt.NAMETAXCODE_COUNTRYTAXCODESUT)[0]; 
        CODATaxCode taxCode3= CODATaxCodeMapper.getByName(CODABaseDataExt.NAMETAXCODE_CITYTAXCODESUT)[0];           
        
        CODAVolumeDataTestHelper.addInvoiceLineItems(invoiceObj,null,PROD_NAME,LINEITEM_QUANTITY,UNITPRICE,taxCode1,taxCode2,taxCode3,DIMENSION1_NAME,DIMENSION2_NAME,DIMENSION3_NAME,DIMENSION4_NAME,1,10); 
        CODAVolumeDataTestHelper.addInvoiceLineItems(invoiceObj,null,PROD_NAME,LINEITEM_QUANTITY,UNITPRICE,taxCode1,taxCode2,taxCode3,DIMENSION1_NAME,DIMENSION2_NAME,DIMENSION3_NAME,DIMENSION4_NAME,11,20); 
        CODAVolumeDataTestHelper.addInvoiceLineItems(invoiceObj,null,PROD_NAME,LINEITEM_QUANTITY,UNITPRICE,taxCode1,taxCode2,taxCode3,DIMENSION1_NAME,DIMENSION2_NAME,DIMENSION3_NAME,DIMENSION4_NAME,21,30); 
        CODAVolumeDataTestHelper.addInvoiceLineItems(invoiceObj,null,PROD_NAME,LINEITEM_QUANTITY,UNITPRICE,taxCode1,taxCode2,taxCode3,DIMENSION1_NAME,DIMENSION2_NAME,DIMENSION3_NAME,DIMENSION4_NAME,31,40);
        CODAVolumeDataTestHelper.addInvoiceLineItems(invoiceObj,null,PROD_NAME,LINEITEM_QUANTITY,UNITPRICE,taxCode1,taxCode2,taxCode3,DIMENSION1_NAME,DIMENSION2_NAME,DIMENSION3_NAME,DIMENSION4_NAME,41,42); 
        
        CODAUnitOfWork.getCurrent().commitWork();
    }     
    
    public static void destroyData()
    {
        CODAUnitOfWork.createAndSetCurrent();
        CODAContext.enableSupportAccess(); 
        CODAPaymentData.destroyPaymentData(SUFFIX);
        List<codaIncomeScheduleDefinition__c> ICD= [SELECT Id, Name FROM codaIncomeScheduleDefinition__c WHERE Name LIKE 'IncomePeriod_%' OR Name =:monthlySpread];
        delete ICD;
        
        delete [Select Id from Product2  where Name like 'PROD_%'];
        CODAContext.disableSupportAccess();
        CODATestIDMapExt.purge(SUFFIX);
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
        
        // Accounts
        Set<String> accNames = new Set<String>();
        accNames.add(CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO);
        accNames.add(CODATID010944Data.ACCOUNT_NAME_EUR);
        for (Account accId : [Select Id, Name from Account where MirrorName__c in :accNames])
        {
            CODATestIDMapExt.put(accId.Name, accId.id);
        }
        
        // Tax Codes
        Set<String> taxNames = new Set<String>();
        taxNames.add(CODABaseDataExt.NAMETAXCODE_STATETAXCODESUT);
        taxNames.add(CODABaseDataExt.NAMETAXCODE_COUNTRYTAXCODESUT);
        taxNames.add(CODABaseDataExt.NAMETAXCODE_CITYTAXCODESUT);
        taxNames.add(CODABaseDataExt.NAMETAXCODE_VOS);
        taxNames.add(CODABaseDataExt.NAMETAXCODE_VOSTDSALES);
        for (codaTaxCode__c item : [Select Id, Name from codaTaxCode__c where Name in :taxNames])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }
        
        //Income Schedule
        Set<String> incomeScheduleDefinition = new Set<String>();
        incomeScheduleDefinition.add(CODABaseDataExt.NAMEINCOMESCHEDULE_MONTHLYSPREAD);
        for (codaIncomeScheduleDefinition__c   item : [Select Id, Name from codaIncomeScheduleDefinition__c  where Name in :incomeScheduleDefinition])
        {
            CODATestIDMapExt.put(item.Name , item.id);
        }        
        
        //New Dimension1
        for (codaDimension1__c  item : [Select Id, Name from codaDimension1__c  where Name like 'Dim 1-EUR-%'])
        {
            CODATestIDMapExt.put(item.Name , item.id);
        }
        
        //New Dimension2
        for (codaDimension2__c  item : [Select Id, Name from codaDimension2__c  where Name like 'Dim 2-EUR-%'])
        {
            CODATestIDMapExt.put(item.Name , item.id);
        }
        
        //New Dimension3
        for (codaDimension3__c  item : [Select Id, Name from codaDimension3__c  where Name like 'Dim 3-EUR-%'])
        {
            CODATestIDMapExt.put(item.Name , item.id);
        }
        
        //New Dimension4
        for (codaDimension4__c  item : [Select Id, Name from codaDimension4__c  where Name like 'Dim 4-EUR-%'])
        {
            CODATestIDMapExt.put(item.Name , item.id);
        }
        
        CODATestIDMapExt.save(SUFFIX);
    }
}
