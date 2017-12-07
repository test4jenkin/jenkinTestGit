/*
* Copyright (c) 2016 FinancialForce.com, inc.  All rights reserved.
*/
public class CODATID015246Data  
{ 
    public static String SUFFIX = 'TID015246#';
    public static string COMPANY_NAME = CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN;
    public static string INVOICE_REF1 = 'SINV_REF_1';
    public static string CREDIT_NOTE_REF1 = 'PCRN_REF_1';
    public static Decimal UNIT_PRICE_6_64583333 = 6.64583333;
    public static Decimal QUANTITY_1 = 1;
    public static Decimal ZERO = 0;
    public static Date INVOICE_DATE = Date.today().addYears(-1);
    public static Date DUE_DATE = Date.today().AddDays(7);
    public static string MONTHLY_SPREAD = 'Monthly Spread';
    public static string QUARTERLY = 'Quarterly';
    public static string STATUS_COMPLETE = 'Complete';
    public static string SALES_HARDWARE = 'Sales - Hardware';
    
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
    
    /* Required by the system test runner: create the data used by this test */ 
    /*Create Sales Invoice with line Items*/
    public static void createData() 
    { 
        loadMap();
        //For the product 'Bendix Front Brake Pad Set 1975-1983 Chrysler Cordoba' setup Sales Revenue Account = Sales – Hardware. 
        list<Product2> prodList = new list<Product2>();
        ID prod1 =  CODATestIDMap.Resolve(CODABaseDataExt.NAMEPRODUCT_BENDIXFRONTBRAKE);
        Product2 bendixFrontBrake = [select Id from Product2 where ID=:prod1];
        bendixFrontBrake.CODASalesRevenueAccount__c =  CODATestIDMap.Resolve(SALES_HARDWARE);
        prodList.add(bendixFrontBrake);
        
        //product 'Auto Com Clutch Kit 1989 Dodge Raider' the value in Sales Revenue Account is Sales – Parts 
        ID prod2 = CODATestIDMap.Resolve(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
        Product2 autoCOMClutch = [select Id from Product2 where ID=:prod2];
        autoCOMClutch.CODASalesRevenueAccount__c =   CODATestIDMap.Resolve(CODABaseData.NAMEGLA_SALESPARTS);
        prodList.add(autoCOMClutch);
        update prodList;
        
        CODAPeriod period = CODAPeriodMapExt.getPeriodByDate(INVOICE_DATE);
        CODAInvoice__c sinv = new CODAInvoice__c();
        sinv.Account__c = CODATestIdMap.resolve(CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO);
        sinv.InvoiceDate__c = INVOICE_DATE;
        sinv.DueDate__c = DUE_DATE;
        sinv.Period__c = period.getDto().Id;   
        INSERT sinv;
        CODATestIDMapExt.put(INVOICE_REF1, sInv.Id);
        CODATestIDMapExt.save(SUFFIX);
        
        List<CodaInvoiceLineItem__c> lineItemList = new List<CodaInvoiceLineItem__c>();
        //line Item 1 
        CodaInvoiceLineItem__c lineItem1 = new CodaInvoiceLineItem__c();
        lineItem1.Invoice__c = sinv.Id;
        lineItem1.Product__c = CODATestIdMap.resolve(CODABaseDataExt.NAMEPRODUCT_BENDIXFRONTBRAKE);
        lineItem1.Quantity__c = QUANTITY_1;
        lineItem1.UnitPrice__c = UNIT_PRICE_6_64583333;
        lineItem1.IncomeSchedule__c = CODATestIdMap.resolve(MONTHLY_SPREAD);
        lineItemList.add(lineItem1);	
        
        //line Item 2
        CodaInvoiceLineItem__c lineItem2 = new CodaInvoiceLineItem__c();
        lineItem2.Invoice__c = sinv.Id;
        lineItem2.Product__c = CODATestIdMap.resolve(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
        lineItem2.Quantity__c = QUANTITY_1;
        lineItem2.UnitPrice__c = UNIT_PRICE_6_64583333;
        lineItem2.IncomeSchedule__c = CODATestIdMap.resolve(QUARTERLY);
        lineItemList.add(lineItem2);	
        insert lineItemList;       
    }
    
    //Post sales invoice 
    public static void PostInvoice()
    {
        CODATestIDMapExt.load(SUFFIX);
		CODAContext.setSystemTest(true);
        //posting invoice
        CODAConfirmPostTestHelper invPost = new CODAConfirmPostTestHelper(INVOICE_REF1);
        try
        {
            invPost.post();
            System.assert(false, 'Error : Expected information message on confirm post, invoice should be posted successfully');
        }
        catch(Exception ex)
        {
            System.assert(ex.getMessage().contains(Label.codaConfirmPostInfoMessage), 'Error : Invoice should be posted succesfully');
        }            
    }
	
	/* Check that the SIN is posted successfully and the Create Currency Adjustment is completed without errors. */ 
	public static void ValidateLogs_TST021139()	
    {
		CODAContext.setSystemTest(true); 
        CODAUnitOfWork.getCurrent();
        CODATestIDMapExt.load(SUFFIX);
		//check invoice status
		Set<Id> workerLogsDetailIds = new Set<Id>();
		CODAInvoice__c invoice = [select ID, InvoiceStatus__c from CODAInvoice__c where ID=: CODATestIDMap.resolve(INVOICE_REF1)];
		system.assert(invoice.InvoiceStatus__c == CODAInvoice.INVOICESTATUS_COMPLETE, 'Invoice status is not complete, Actual-'+invoice.InvoiceStatus__c );
	
		//7. Go to “Accounting Background Workers" tab to check Messages. Group 0
		// Check C)- 8. Go to Worker Log Group Related list. Check D)
		list <worker__c> workerList = [select ID, Status__c, (Select ID, TotalNumberOfErrors__c from WorkerLogGroups__r) from Worker__c];
		system.assert(workerList.size() > ZERO, 'Error-worker List size should be greater than 0');
		for(worker__c worker:workerList ) 
		{
			//D) There are no errors on the log for the SIN number created.
			system.assert(worker.status__c == STATUS_COMPLETE, 'Error-Status should be Complete');
			for(WorkerLogGroup__c logGroup :worker.WorkerLogGroups__r)
			{
				system.assert(logGroup.TotalNumberOfErrors__c == ZERO, 'Error-Error in workerLog, TotalNumberOfErrors__c='+logGroup.TotalNumberOfErrors__c );
				workerLogsDetailIds.add(logGroup.Id); 
			}
		}
		
		//There is a message like this: Create Currency Adjustment: Work completed successfully.
		boolean currencyAdjustment = false;
		list<WorkerLog__c> workerLogList = [Select Id,Message__c  from WorkerLog__c where WorkerLogGroup__c IN :workerLogsDetailIds];
		system.assert(workerLogList.size() > ZERO, 'Error-worker log List size should be greater than 0');
		for(WorkerLog__c workerlog:workerLogList ) 
		{
			if(workerlog.Message__c.contains(WorkerItemService.WORKACTION_CREATECURRENCYADJUSTMENT))
			{
				currencyAdjustment = true;
			}
		}
		system.assert(currencyAdjustment == true, 'Error- Currency Adjustment not done');        
    }
	
    public static void destroyData()
    {
        CODATestIDMapExt.load(SUFFIX);
        CODAContext.enableSupportAccess();
        list<Product2> prodList = new list<Product2>();
        ID prod1 =  CODATestIDMap.Resolve(CODABaseDataExt.NAMEPRODUCT_BENDIXFRONTBRAKE);
        Product2 bendixFrontBrake = [select Id from Product2 where ID=:prod1];
        bendixFrontBrake.CODASalesRevenueAccount__c =  CODATestIDMap.Resolve(CODABaseData.NAMEGLA_SALESPARTS);
        prodList.add(bendixFrontBrake);
        
        //product 'Auto Com Clutch Kit 1989 Dodge Raider' the value in Sales Revenue Account is Sales – Parts 
        ID prod2 = CODATestIDMap.Resolve(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
        Product2 autoCOMClutch = [select Id from Product2 where ID=:prod2];
        autoCOMClutch.CODASalesRevenueAccount__c =   CODATestIDMap.Resolve(CODABaseData.NAMEGLA_SALESPARTS);
        prodList.add(autoCOMClutch);
        update prodList;
        CODAPaymentData.destroyPaymentData(SUFFIX);	
        CODAContext.disableSupportAccess();         	
    }
    
    public static void loadMap()
    {
        //Account
        for (Account acc : [SELECT Id, Name FROM Account WHERE MirrorName__c = :CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO])
        {
            CODATestIDMapExt.put(acc.Name, acc.id); 
        }	
        
        // Product
        Set<String> prodNames = new Set<String>();
        prodNames.add(CODABaseDataExt.NAMEPRODUCT_BENDIXFRONTBRAKE);
        prodNames.add(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
        for(Product2  product : [Select Id, Name from Product2 where Name IN :prodNames])
        {
            CODATestIDMapExt.put(product.Name, product.Id);
        }
        
        // GLAs
        Set<String> glaNames = new Set<String>();
        glaNames.add(CODABaseData.NAMEGLA_WRITEOFFUK);
        glaNames.add(CODABaseData.NAMEGLA_SALESPARTS);
        glaNames.add(SALES_HARDWARE);
        for (CODAGeneralLedgerAccount__c item : [Select Id, Name from CODAGeneralLedgerAccount__c where Name in :glaNames])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }
        
        // GLAs
        Set<String> incomeScheduDefinations = new Set<String>();
        incomeScheduDefinations.add(MONTHLY_SPREAD);
        incomeScheduDefinations.add(QUARTERLY);
        for (codaIncomeScheduleDefinition__c item : [Select Id, Name from codaIncomeScheduleDefinition__c where Name in :incomeScheduDefinations])
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
        
        CODATestIDMapExt.save(SUFFIX);        
    }  
}