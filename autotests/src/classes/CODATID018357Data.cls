/*
* Copyright (c) 2016 FinancialForce.com, inc.  All rights reserved.
*/
public class CODATID018357Data 
{
    public static String SUFFIX = '#TID018357';
    public static string REFERENCE2 = 'REFERENCE2';
    public static string LINE_TYPE_ACCOUNT = 'Account';
    public static string LINE_TYPE_ANALYSIS = 'Analysis';
	public static string LINE_TYPE_TAX = 'Tax';
    public static string COMPANY_NAME = CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN;
    public static Date INVOICE_DATE = Date.newInstance(2009,01,01);
    public static Date DUE_DATE = Date.newInstance(2009,01,06);
    public static integer NUM_OF_INSTALLMENTS_6 = 6;
    public static double QUANTITY_10 = 10;
    public static double QUANTITY_12 = 12;
	public static double UNIT_PRICE_95 = 95.0;
    public static double UNIT_PRICE_120 = 120.0;
    public static String INTERVAL_MONTHLY = 'Monthly'; 
    public static double VALUE_351_80 = 351.80;
    public static double VALUE_731_80 = 731.80;
	public static double VALUE_N300_00 = -300.00;
	public static double VALUE_21_00 = 21.00;
	public static double VALUE_N21_00 = -21.00;
	public static double VALUE_ZERO =0;
	public static double VALUE_439_75 =439.75 ;
	public static double VALUE_N439_75 = - 439.75 ;
	public static double VALUE_N118_75 = -118.75 ;
	public static string SHIPPING_ADDRESS = '52 New Street';
	public static string INVOICE_DESCRIPTION_2= 'Invoice 1 of 6';
	public static string TRANSACTION_TYPE= 'Invoice';
    
    public static Date INVOICEDATE1 = INVOICE_DATE;
    public static Date INVOICEDATE2 = INVOICE_DATE.AddMonths(1);
    public static Date INVOICEDATE3 = INVOICE_DATE.AddMonths(2);
    public static Date INVOICEDATE4 = INVOICE_DATE.AddMonths(3);
    public static Date INVOICEDATE5 = INVOICE_DATE.AddMonths(4);
    public static Date INVOICEDATE6 = INVOICE_DATE.AddMonths(5);  
    
    public static Date DUEDATE1 = DUE_DATE;
    public static Date DUEDATE2 = DUE_DATE.AddMonths(1);
    public static Date DUEDATE3 = DUE_DATE.AddMonths(2);
    public static Date DUEDATE4 = DUE_DATE.AddMonths(3);
    public static Date DUEDATE5 = DUE_DATE.AddMonths(4);
    public static Date DUEDATE6 = DUE_DATE.AddMonths(5);     
    public static CODAPeriod PERIOD1 =  CODAPeriodMapExt.getPeriodByDate(invoiceDate1);		
    
    /**
	* select the current company
	*/
    
    public static void switchProfile() 
    {
        Id userId = CODABaseData.getProfile(CODABaseData.ACCOUNTANT).Id;
        CODABaseData.switchCurrentCompany(COMPANY_NAME, true, false, userId);
    }
    
    public static void selectCompany()
    {              
        CODABaseData.switchCurrentCompany(COMPANY_NAME, true, true, UserInfo.getUserId());
    }	
    
    /**
	* Load Map values and create account settings
	*/
    public static void createData()
    {
        loadMap();
        //Account settings
        Account acctCambridgeAuto = [Select Id from account where MirrorName__c=:CODABaseDataExt.NAMEACCOUNT_CAMBRIDGEAUTO];
        acctCambridgeAuto.CODADimension1__c = CODATestIdMap.resolve(CODABaseDataExt.NAMEDIM1_NORTH);
        acctCambridgeAuto.CODADimension2__c = CODATestIdMap.resolve(CODABaseDataExt.NAMEDIM2_DODGEUK);
        acctCambridgeAuto.CODADimension3__c = CODATestIdMap.resolve(CODABaseDataExt.NAMEDIM3_BILLYRAY);
        acctCambridgeAuto.CODADimension4__c = CODATestIdMap.resolve(CODABaseDataExt.NAMEDIM4_HARROGATE);
        acctCambridgeAuto.ShippingStreet = SHIPPING_ADDRESS;
        update acctCambridgeAuto;
    }
    
    //create invoice and its line Items
    public static void CreateDataExt1()
    {
        CODATestIDMapExt.load(SUFFIX);
        CODAInvoice__c sInv2 = CreateInvoicewithLineItem();
        CODATestIDMapExt.put(REFERENCE2, sInv2.id);   
        CODATestIDMapExt.save(SUFFIX);
		
		ffb_RecurringInvoiceTestHelper testHelper = new ffb_RecurringInvoiceTestHelper( REFERENCE2);
		testHelper.setRecurringType(CODAInvoiceController.TYPE_QUANTITY);
		testHelper.setRecurringStartDate( INVOICE_DATE);
		testHelper.setScheduleType(CODAInvoiceController.SCHEDULETYPE_DIVIDE);
		testHelper.setInstallmentInterval(CODAInvoice.INTERVAL_MONTHLY);
		testHelper.setNumberOfInstallment( NUM_OF_INSTALLMENTS_6);
		//Save , SF Preview is similar to VF Save action
		testHelper.Preview();
		List<ffb_RecurringInvoiceTestHelper.RecurringRulesLineItems> reccLines = testHelper.getRecurringLines();
		System.assert(reccLines.size() ==  NUM_OF_INSTALLMENTS_6, 'Error-TST025184- Recurring Invoice size is not correct Expected 6, Actual-'+reccLines.size());
		// Save the Invoice with recurring invoices
		testHelper.SaveAndPost();        
    }
    
	public static codaInvoice__c CreateInvoicewithLineItem()
	{
		//Create Invoice
        CODAPeriod period = CODAPeriodMapExt.getPeriodByDate(INVOICE_DATE);
        codaInvoice__c sInv2 = new codaInvoice__c();
        sInv2.Account__c = CODATestIdMap.resolve(CODABaseDataExt.NAMEACCOUNT_CAMBRIDGEAUTO);
        sInv2.InvoiceCurrency__c = CODATestIdMap.resolve(CODABaseData.CURRENCYCODE_GBP+':' +  COMPANY_NAME);
        sInv2.InvoiceDate__c = INVOICE_DATE;
        sInv2.DueDate__c = DUE_DATE;
        sInv2.Period__c = period.getDto().Id;   
		sInv2.Dimension1__c = CODATestIdMap.resolve(CODABaseDataExt.NAMEDIM1_NORTH);
        sInv2.Dimension2__c = CODATestIdMap.resolve(CODABaseDataExt.NAMEDIM2_DODGEUK);
        sInv2.Dimension3__c = CODATestIdMap.resolve(CODABaseDataExt.NAMEDIM3_BILLYRAY);
        sInv2.Dimension4__c = CODATestIdMap.resolve(CODABaseDataExt.NAMEDIM4_HARROGATE);

        insert sInv2;
        
        //Add line Items
        List<CodaInvoiceLineItem__c> lineItemList = new List<CodaInvoiceLineItem__c>();
		//line Item 1 
        CodaInvoiceLineItem__c lineItem1 = new CodaInvoiceLineItem__c();
        lineItem1.Invoice__c = sInv2.Id;
        lineItem1.Product__c = CODATestIdMap.resolve(CODABaseDataExt.NAMEPRODUCT_BOSCHOILFILTER);
        lineItem1.Quantity__c = QUANTITY_10;
        lineItem1.UnitPrice__c = UNIT_PRICE_95;
        lineItem1.TaxCode1__c = CODATestIdMap.resolve(CODABaseDataExt.NAMETAXCODE_VOZ);
        lineItem1.Dimension1__c = CODATestIdMap.resolve(CODABaseDataExt.NAMEDIM1_NORTH);
        lineItem1.Dimension2__c = CODATestIdMap.resolve(CODABaseDataExt.NAMEDIM2_DODGEUK);
        lineItem1.Dimension3__c = CODATestIdMap.resolve(CODABaseDataExt.NAMEDIM3_BILLYRAY);
        lineItem1.Dimension4__c = CODATestIdMap.resolve(CODABaseDataExt.NAMEDIM4_HARROGATE);
        lineItemList.add(lineItem1);
        //line Item 2
        CodaInvoiceLineItem__c lineItem2 = new CodaInvoiceLineItem__c();
        lineItem2.Invoice__c = sInv2.Id;
        lineItem2.Product__c = CODATestIdMap.resolve(CODABaseDataExt.NAMEPRODUCT_CENTRICREARBRAKE);
        lineItem2.Quantity__c = QUANTITY_12;
        lineItem2.UnitPrice__c = UNIT_PRICE_120;
        lineItem2.TaxCode1__c = CODATestIdMap.resolve(CODABaseDataExt.NAMETAXCODE_VOECSALES);
        lineItem2.Dimension1__c = CODATestIdMap.resolve(CODABaseDataExt.NAMEDIM1_NORTH);
        lineItem2.Dimension2__c = CODATestIdMap.resolve(CODABaseDataExt.NAMEDIM2_DODGEUK);
        lineItem2.Dimension3__c = CODATestIdMap.resolve(CODABaseDataExt.NAMEDIM3_BILLYRAY);
        lineItem2.Dimension4__c = CODATestIdMap.resolve(CODABaseDataExt.NAMEDIM4_HARROGATE);
        lineItemList.add(lineItem2);
        
        insert lineItemList;
		return sInv2;	
	}
	
	//Save&Post Recurring Invoices
    public static void validateResults()
    {
		CODATestIDMapExt.load(SUFFIX);
		Id currId = CODATestIdMap.resolve(CODABaseData.CURRENCYCODE_GBP+':' +  COMPANY_NAME);
		//Validation A
		list <CODAInvoice__c> invoiceLines = [Select Id,Name,InvoiceDate__c,DueDate__c,InvoiceTotal__c,InvoiceCurrency__c   from CODAInvoice__c where InvoiceStatus__c=: CODAInvoice.INVOICESTATUS_COMPLETE ORDER BY InvoiceDate__c ASC];
		System.assertEquals(invoiceLines.size() ,  NUM_OF_INSTALLMENTS_6, 'Error-TST025185- Recurring Invoice Inprogress size is not correct Expected 6, Actual-'+invoiceLines.size());
		System.assertEquals(invoiceLines[0].InvoiceDate__c ,  INVOICEDATE1);              
		System.assertEquals(invoiceLines[0].DueDate__c  ,  DUEDATE1 );   
		System.assertEquals(invoiceLines[0].InvoiceCurrency__c ,currId );   
		System.assertEquals(invoiceLines[0].InvoiceTotal__c , VALUE_351_80 );  

		System.assertEquals(invoiceLines[1].InvoiceDate__c ,  INVOICEDATE2);              
		System.assertEquals(invoiceLines[1].DueDate__c , DUEDATE2 );   
		System.assertEquals(invoiceLines[1].InvoiceCurrency__c ,currId );   
		System.assertEquals(invoiceLines[1].InvoiceTotal__c , VALUE_351_80 );  

		System.assertEquals(invoiceLines[2].InvoiceDate__c ,  INVOICEDATE3);              
		System.assertEquals(invoiceLines[2].DueDate__c , DUEDATE3 );   
		System.assertEquals(invoiceLines[2].InvoiceCurrency__c ,currId );   
		System.assertEquals(invoiceLines[2].InvoiceTotal__c , VALUE_351_80 );  

		System.assertEquals(invoiceLines[3].InvoiceDate__c ,  INVOICEDATE4);              
		System.assertEquals(invoiceLines[3].DueDate__c , DUEDATE4 );   
		System.assertEquals(invoiceLines[3].InvoiceCurrency__c ,currId );   
		System.assertEquals(invoiceLines[3].InvoiceTotal__c , VALUE_351_80 );

		System.assertEquals(invoiceLines[4].InvoiceDate__c ,  INVOICEDATE5);              
		System.assertEquals(invoiceLines[4].DueDate__c , DUEDATE5 );   
		System.assertEquals(invoiceLines[4].InvoiceCurrency__c ,currId );   
		System.assertEquals(invoiceLines[4].InvoiceTotal__c , VALUE_351_80 );  

		System.assertEquals(invoiceLines[5].InvoiceDate__c ,  INVOICEDATE6);              
		System.assertEquals(invoiceLines[5].DueDate__c , DUEDATE6 );   
		System.assertEquals(invoiceLines[5].InvoiceCurrency__c ,currId );   
		System.assertEquals(invoiceLines[5].InvoiceTotal__c , VALUE_731_80 );

		//Go to the First Invoice Check A)
		//get Invoice transaction Details
		CODATransaction__c transact = [select Id, 	Name, TransactionDate__c, Period__c, TransactionType__c, 
					DocumentNumber__c , OwnerCompany__c,Debits__c,Credits__c,HomeValueTotal__c,											
					AccountTotal__c, AccountOutstandingTotal__c, DocumentTotal__c, DocumentOutstandingTotal__c,
					(Select ID,HomeValue__c, HomeTaxTotal__c, HomeTaxableValue__c, GeneralLedgerAccount__c,
					LineType__c,LineDescription__c,DueDate__c , Dimension1__c,Dimension2__c,Dimension3__c, Dimension4__c from TransactionLineItems__r) 
					from CODATransaction__c WHERE SalesInvoice__c=:invoiceLines[0].Id];

		
		//1)Transaction details						   
		system.assert(transact.Name != null, 'Error- transaction name /number should nut be null');
		system.assert(transact.TransactionDate__c ==  INVOICE_DATE, 'Error-incorrect  transaction INVOICE DATE  should not be null, actual'+ transact.TransactionDate__c);
		system.assert(transact.Period__c ==  PERIOD1.getDto().ID, 'Error- transaction Period  incorrect, actual'+ transact.Period__c );
		system.assert(transact.TransactionType__c ==  TRANSACTION_TYPE, 'Error-incorrect  Transaction Type, actual'+ transact.TransactionType__c );
		system.assert(transact.DocumentNumber__c == invoiceLines[0].Name , 'Error-incorrect  transaction Document Number, actual'+ transact.DocumentNumber__c );
		system.assert(transact.OwnerCompany__c == CODATestIdMap.resolve( COMPANY_NAME) , 'Error-incorrect  transaction Company, actual'+ transact.OwnerCompany__c );	

		//a)Transaction Details
		system.assert(transact.Debits__c ==  VALUE_439_75 , 'Error-incorrect  transaction home debits, actual'+ transact.Debits__c );	
		system.assert(transact.Credits__c == VALUE_N439_75 , 'Error-incorrect  transaction home credits, actual- '+ transact.Credits__c );	
		system.assert(transact.HomeValueTotal__c ==  VALUE_ZERO , 'Error-incorrect  transaction Home Totalvalue, actual'+ transact.HomeValueTotal__c );	

		//b) Account Line Summary:
		system.assert(transact.AccountTotal__c ==  VALUE_351_80 , 'Error-incorrect  transaction Account Total, expected '+  VALUE_351_80 +', actual'+ transact.AccountTotal__c );	
		system.assert(transact.AccountOutstandingTotal__c == VALUE_351_80 , 'Error-incorrect  transaction Account Outstanding Total '+  VALUE_351_80 +', actual'+ transact.AccountOutstandingTotal__c );	
		system.assert(transact.DocumentTotal__c ==  VALUE_351_80 , 'Error-incorrect  transaction Document Total '+  VALUE_351_80 +', actual'+ transact.DocumentTotal__c );	
		system.assert(transact.DocumentOutstandingTotal__c ==  VALUE_351_80 , 'Error-incorrect  transaction Document outstanding Total '+  VALUE_351_80 +', actual'+ transact.DocumentOutstandingTotal__c );	

		//c) Transaction line items
		integer lineCount = 0;
		integer linetypeAcoountCount = 0;
		integer linetypeAnalysisValue_N118_75_count = 0;
		integer linetypeAnalysisValue_N300_00 = 0;
		integer linetypeTaxValue_Zero = 0;
		integer linetypeTaxValue_N21_00 = 0;			
		for(codaTransactionLineItem__c tranLineItem : transact.TransactionLineItems__r)
		{
			if(tranLineItem.LineType__c ==  LINE_TYPE_ACCOUNT)
			{
				system.assert(tranLineItem.HomeValue__c ==  VALUE_439_75 , 'Error-incorrect  transaction line Item  Home Value , expected '+  VALUE_439_75 +', actual'+ tranLineItem.HomeValue__c );	
				system.assert(tranLineItem.HomeTaxTotal__c ==  VALUE_21_00 , 'Error-incorrect  transaction line Item  Home Tax Total Value , expected '+  VALUE_21_00 +', actual'+ tranLineItem.HomeTaxTotal__c );	
				system.assert(tranLineItem.HomeTaxableValue__c == null , 'Error-incorrect  transaction line Item  Home HomeTaxableValue Value should be null, actual'+ tranLineItem.HomeTaxableValue__c );	
				system.assert(tranLineItem.GeneralLedgerAccount__c == CODATestIdMap.resolve(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD) , 'Error-incorrect  transaction line Item  Home GeneralLedgerAccount Value , expected '+ CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD +', actual'+ tranLineItem.GeneralLedgerAccount__c );	
				system.assert(tranLineItem.LineDescription__c ==  INVOICE_DESCRIPTION_2 , 'Error-incorrect  transaction line Item  Home LineDescription Value , expected '+  INVOICE_DESCRIPTION_2 +', actual'+ tranLineItem.LineDescription__c );	
				lineCount ++;
				linetypeAcoountCount ++;
			}
			else if(tranLineItem.LineType__c ==  LINE_TYPE_ANALYSIS)
			{
				if(tranLineItem.HomeValue__c ==  VALUE_N118_75)
				{
					system.assert(tranLineItem.HomeTaxTotal__c ==  VALUE_ZERO , 'Error-incorrect  transaction line Item  Home Tax Total Value , expected '+  VALUE_ZERO +', actual'+ tranLineItem.HomeTaxTotal__c );	
					system.assert(tranLineItem.HomeTaxableValue__c == null , 'Error-incorrect  transaction line Item  Home HomeTaxableValue Value should be null, actual'+ tranLineItem.HomeTaxableValue__c );	
					system.assert(tranLineItem.GeneralLedgerAccount__c == CODATestIdMap.resolve(CODABaseData.NAMEGLA_SALESPARTS) , 'Error-incorrect  transaction line Item  Home GeneralLedgerAccount Value , expected '+ CODABaseData.NAMEGLA_SALESPARTS +', actual'+ tranLineItem.GeneralLedgerAccount__c );	
					lineCount ++;
					linetypeAnalysisValue_N118_75_count ++;
				}
				else if(tranLineItem.HomeValue__c ==  VALUE_N300_00)
				{
					system.assert(tranLineItem.HomeTaxTotal__c ==  VALUE_N21_00 , 'Error-incorrect  transaction line Item  Home Tax Total Value , expected '+  VALUE_N21_00 +', actual'+ tranLineItem.HomeTaxTotal__c );	
					system.assert(tranLineItem.HomeTaxableValue__c == null , 'Error-incorrect  transaction line Item  Home HomeTaxableValue Value should be null, actual'+ tranLineItem.HomeTaxableValue__c );	
					system.assert(tranLineItem.GeneralLedgerAccount__c == CODATestIdMap.resolve(CODABaseData.NAMEGLA_SALESPARTS) , 'Error-incorrect  transaction line Item  Home GeneralLedgerAccount Value , expected '+ CODABaseData.NAMEGLA_SALESPARTS +', actual'+ tranLineItem.GeneralLedgerAccount__c );	
					lineCount ++;
					linetypeAnalysisValue_N300_00++;
				}
			}
			else if(tranLineItem.LineType__c ==  LINE_TYPE_TAX)
			{
				if(tranLineItem.HomeValue__c ==  VALUE_ZERO)
				{
					system.assert(tranLineItem.HomeTaxTotal__c ==  VALUE_ZERO , 'Error-incorrect  transaction line Item  Home Tax Total Value , expected '+  VALUE_ZERO +', actual'+ tranLineItem.HomeTaxTotal__c );	
					system.assert(tranLineItem.HomeTaxableValue__c ==  VALUE_N118_75 , 'Error-incorrect  transaction line Item  Home HomeTaxableValue Value should be '+ VALUE_N118_75+', actual'+ tranLineItem.HomeTaxableValue__c );	
					system.assert(tranLineItem.GeneralLedgerAccount__c == CODATestIdMap.resolve(CODABaseData.NAMEGLA_VATOUTPUT) , 'Error-incorrect  transaction line Item  Home GeneralLedgerAccount Value , expected '+ CODABaseData.NAMEGLA_VATOUTPUT +', actual'+ tranLineItem.GeneralLedgerAccount__c );	
					system.assert(tranLineItem.LineDescription__c == CODABaseDataExt.NAMETAXCODE_VOZ , 'Error-incorrect  transaction line Item  Home LineDescription Value , expected '+ CODABaseDataExt.NAMETAXCODE_VOZ +', actual'+ tranLineItem.LineDescription__c );	
					lineCount ++;
					linetypeTaxValue_Zero ++;
				}
				else if(tranLineItem.HomeValue__c ==  VALUE_N21_00)
				{
					system.assert(tranLineItem.HomeTaxTotal__c ==  VALUE_ZERO , 'Error-incorrect  transaction line Item  Home Tax Total Value , expected '+  VALUE_ZERO +', actual'+ tranLineItem.HomeTaxTotal__c );	
					system.assert(tranLineItem.HomeTaxableValue__c ==  VALUE_N300_00 , 'Error-incorrect  transaction line Item  Home HomeTaxableValue Value should be '+  VALUE_N300_00 +', actual'+ tranLineItem.HomeTaxableValue__c );	
					system.assert(tranLineItem.GeneralLedgerAccount__c == CODATestIdMap.resolve(CODABaseData.NAMEGLA_VATOUTPUT) , 'Error-incorrect  transaction line Item  Home GeneralLedgerAccount Value , expected '+ CODABaseData.NAMEGLA_VATOUTPUT +', actual'+ tranLineItem.GeneralLedgerAccount__c );	
					system.assert(tranLineItem.LineDescription__c == CODABaseDataExt.NAMETAXCODE_VOECSALES , 'Error-incorrect  transaction line Item  Home LineDescription Value , expected '+ CODABaseDataExt.NAMETAXCODE_VOECSALES +', actual'+ tranLineItem.LineDescription__c );	
					lineCount ++;
					linetypeTaxValue_N21_00 ++;
				}
			}				
		}
		system.assert(lineCount == 5, 'Error-Incorrect transaction LineItems of type Account , Analysis, and Tax, Expected 5, Actual-'+lineCount);
		system.assert(linetypeAcoountCount == 1, 'Error-Incorrect count transaction LineItems of type Account '+linetypeAcoountCount);
		system.assert(linetypeAnalysisValue_N118_75_count == 1, 'Error-Incorrect count transaction linetype Analysis Value -118.75count , Actual-'+linetypeAnalysisValue_N118_75_count);
		system.assert(linetypeAnalysisValue_N300_00 == 1, 'Error-Incorrect count transaction linetypeAnalysisValue_N300_00, Actual-'+linetypeAnalysisValue_N300_00);
		system.assert(linetypeTaxValue_Zero == 1, 'Error-Incorrect count transaction linetype Tax Value Zero, Actual-'+linetypeTaxValue_Zero);
		system.assert(linetypeTaxValue_N21_00 == 1, 'Error-Incorrect count transaction LineItems line type TaxValue -21.00 , Actual-'+linetypeTaxValue_N21_00);
    }
	
    /**
	* Destroy the data created by createData
	*/
	public static void destroyData()
    {
        CODAContext.enableSupportAccess();
		//Revert Account settings
        Account acctCambridgeAuto = [Select Id from account where MirrorName__c=:CODABaseDataExt.NAMEACCOUNT_CAMBRIDGEAUTO];
        acctCambridgeAuto.CODADimension1__c = null;
        acctCambridgeAuto.CODADimension2__c = null;
        acctCambridgeAuto.CODADimension3__c = null;
        acctCambridgeAuto.CODADimension4__c = null;
        acctCambridgeAuto.ShippingStreet = null;
        update acctCambridgeAuto;
		
        CODAPaymentData.destroyPaymentData(SUFFIX);	
    }
    
    private static void loadMap()
    {
		//Load Multiples Companies
        Set<String> companyNames = new Set<String>();
        companyNames.add(COMPANY_NAME);
               
        for (codaCompany__c companyName : [Select Id, Name From codaCompany__c where Name in :companyNames])
        {
            CODATestIDMapExt.put(companyName.Name, companyName.id);
        }
        // GLAs
        Set<String> glaNames = new Set<String>();
        glaNames.add(CODABaseData.NAMEGLA_WRITEOFFUK);
        glaNames.add(CODABaseData.NAMEGLA_SALESPARTS);
        glaNames.add(CODABaseData.NAMEGLA_VATOUTPUT);
        glaNames.add(CODABaseData.NAMEGLA_SETTLEMENTDISCOUNTSALLOWEDUS);
        glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLEUR);
        glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLUSD);
        glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD);
        glaNames.add(CODABaseData.NAMEGLA_POSTAGEANDSTATIONERY);
        glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLEUR);
        glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLGBP);
        glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLGBP);
        
        
        for (CODAGeneralLedgerAccount__c item : [Select Id, Name from CODAGeneralLedgerAccount__c where Name in :glaNames])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }
        // Accounts
        Account account = [Select Id, Name from Account where MirrorName__c = :CODABaseDataExt.NAMEACCOUNT_CAMBRIDGEAUTO];
        CODATestIDMapExt.put(account.Name, account.Id);
        
        // Product
        Set<String> prodNames = new Set<String>();
        prodNames.add(CODABaseDataExt.NAMEPRODUCT_BOSCHOILFILTER);
        prodNames.add(CODABaseDataExt.NAMEPRODUCT_CENTRICREARBRAKE);
        for(Product2  product : [Select Id, Name from Product2 where Name IN :prodNames])
        {
        	CODATestIDMapExt.put(product.Name, product.Id);
        }
        
        // Period for Merlin Auto Spain
        for(codaPeriod__c period : [Select Id, Name, OwnerCompany__r.Name from codaPeriod__c where OwnerCompany__r.Name = :CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN])
        {
            CODATestIDMapExt.put(period.Name + ':' + period.OwnerCompany__r.Name, period.Id);
        }
        
        // Currencies for Merlin Auto Spain
        for (codaAccountingCurrency__c accCurr : [Select Id, Name, OwnerCompany__r.Name from codaAccountingCurrency__c where OwnerCompany__r.Name  = :CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN])
        {
            CODATestIDMapExt.put(accCurr.Name + ':' + accCurr.OwnerCompany__r.Name, accCurr.Id);
        }
        
        // Tax Code
        Set<String> taxCodes = new Set<String>();
        taxCodes.add(CODABaseDataExt.NAMETAXCODE_VOZ);
        taxCodes.add(CODABaseDataExt.NAMETAXCODE_VOECSALES);
        for (codaTaxCode__c voSTD : [Select Id, Name from codaTaxCode__c where Name IN :taxCodes])
        {
            CODATestIDMapExt.put(voSTD.Name, voSTD.Id);
        }
        
        // Dimension 1s
        Set<String> dim1Names = new Set<String>();
        dim1Names.add(CODABaseDataExt.NAMEDIM1_NORTH);
        dim1Names.add(CODABaseDataExt.NAMEDIM1_USD);
        dim1Names.add(CODABaseDataExt.NAMEDIM1_EUR);
        dim1Names.add(CODABaseDataExt.NAMEDIM1_EUROPEAN);
        
        for (codaDimension1__c item : [Select Id, Name from codaDimension1__c where Name in :dim1Names])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }
        // Dimension 2s
        Set<String> dim2Names = new Set<String>();
        dim2Names.add(CODABaseDataExt.NAMEDIM2_DODGEUK);
        dim2Names.add(CODABaseDataExt.NAMEDIM2_USD);
        dim2Names.add(CODABaseDataExt.NAMEDIM2_EUR);
        dim2Names.add(CODABaseDataExt.NAMEDIM2_DODGEUS);
        
        for (codaDimension2__c item : [Select Id, Name from codaDimension2__c where Name in :dim2Names])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }
        
        // Dimension 3s
        Set<String> dim3Names = new Set<String>();
        dim3Names.add(CODABaseDataExt.NAMEDIM3_BILLYRAY);
        dim3Names.add(CODABaseDataExt.NAMEDIM3_USD);
        dim3Names.add(CODABaseDataExt.NAMEDIM3_EUR);
        
        for (codaDimension3__c item : [Select Id, Name from codaDimension3__c where Name in :dim3Names])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }
        
        // Dimension 4s
        Set<String> dim4Names = new Set<String>();
        dim4Names.add(CODABaseDataExt.NAMEDIM4_HARROGATE);
        dim4Names.add(CODABaseDataExt.NAMEDIM4_GBP);
        dim4Names.add(CODABaseDataExt.NAMEDIM4_USD);
        
        for (codaDimension4__c item : [Select Id, Name from codaDimension4__c where Name in :dim4Names])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }
        CODATestIDMapExt.save(SUFFIX);
    }

}
