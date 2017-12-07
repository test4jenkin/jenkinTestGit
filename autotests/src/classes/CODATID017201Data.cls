/*
* Copyright (c) 2016 FinancialForce.com, inc.  All rights reserved.
*/
public class CODATID017201Data 
{
    public static String SUFFIX = '#TID017201';
    public static string REFERENCE = 'REFERENCE_0';
    public static string REFERENCE1 = 'REFERENCE1';
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
    public static double QUANTITY_5 = 5;
    public static double UNIT_PRICE_95 = 95.0;
    public static double UNIT_PRICE_16 = 16;
    public static double UNIT_PRICE_120 = 120.0;
    public static String INTERVAL_MONTHLY = 'Monthly'; 
    public static double VALUE_398_00 = 398.00 ;
    public static double VALUE_400_00 = 400.00 ;
    public static double VALUE_440_08 = 440.08;
    public static double VALUE_442_40 = 442.40;
    public static double VALUE_553_00 = 553.00;
    public static double VALUE_N553_00 = -553.00;
    public static double VALUE_N200_00 = -200;
    public static double VALUE_N300_00 = -300;
    public static double VALUE_21_00 = 21.00;
    public static double VALUE_N21_00 = -21.00;
    public static double VALUE_ZERO =0;
    public static double VALUE_160_00 =160.00 ;
    public static double VALUE_16_00 =16.00 ;
    public static double VALUE_25_60= 25.60;
    public static double VALUE_53_00 = 53.00;
    public static double VALUE_N32_00 = -32.00;
    public static double VALUE_550_10= 550.10;
    public static double VALUE_N550_10= -550.10;
    public static double VALUE_52_60 = 52.60;
    public static double VALUE_N31_60= -31.60;
    public static double VALUE_N197_50 = -197.50;
    public static double VALUE_N197_55= -197.55;
    public static double VALUE_414_80 = 414.80;
    public static double VALUE_416_80 = 416.80;
    public static string SHIPPING_ADDRESS = '52 New Street';
    public static string BILLING_ADDRESS = '47 New Street Cambridge MA 02138-1222 US';
    public static string INVOICE_DESCRIPTION_6_of_6= 'Invoice 6 of 6';
    public static string INVOICE_DESCRIPTION_1_of_6= 'Invoice 1 of 6';
    public static string TRANSACTION_TYPE= 'Invoice';
    public static string TAX_DESCRIPTION= 'Standard Rated';
    public static string TAX_NAME_VOZ_16= 'VOZ16';
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
    public static CODAPeriod PERIOD2 =  CODAPeriodMapExt.getPeriodByDate(invoiceDate2);
    public static CODAPeriod PERIOD3 =  CODAPeriodMapExt.getPeriodByDate(invoiceDate3);
    public static CODAPeriod PERIOD4 =  CODAPeriodMapExt.getPeriodByDate(invoiceDate4);
    public static CODAPeriod PERIOD5 =  CODAPeriodMapExt.getPeriodByDate(invoiceDate5);
    public static CODAPeriod PERIOD6 =  CODAPeriodMapExt.getPeriodByDate(invoiceDate6);
    
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
        
        //Create New Tax Code and Rate 
        CODATaxCode__c voz16 = new  CODATaxCode__c();
        voz16.Name = TAX_NAME_VOZ_16;
        voz16.Description__c = TAX_DESCRIPTION;
        voz16.GeneralLedgerAccount__c = CODATestIdMap.resolve(CODABaseData.NAMEGLA_VATOUTPUT);
        Insert voz16;
        
        codaTaxRate__c taxRate = new codaTaxRate__c();
        taxRate.StartDate__c =  Date.newInstance(2007,01,01);
        taxRate.TaxCode__c = voz16.Id;
        taxRate.Rate__c = VALUE_16_00 ;		
        insert taxRate;
        
        CODATestIDMapExt.put(TAX_NAME_VOZ_16, voz16.id);   
        CODATestIDMapExt.save(SUFFIX);        
    }
    
    //create invoice and its line Items
    public static void CreateInvoiceToSave()
    {
        CODATestIDMapExt.load(SUFFIX);
        CODAInvoice__c sInv1 = CreateInvoicewithLineItem(REFERENCE);
        CODATestIDMapExt.put(REFERENCE, sInv1.id);   
        CODATestIDMapExt.save(SUFFIX);        
    }
    
    //create invoice and its line Items
    public static void CreateInvoiceToSaveAndPost()
    {
        CODATestIDMapExt.load(SUFFIX);
        CODAInvoice__c sInv2 = CreateInvoicewithLineItem(REFERENCE2);
        CODATestIDMapExt.put(REFERENCE2, sInv2.id);   
        CODATestIDMapExt.save(SUFFIX);        
    }
    
    //recurring invoice Preview and Save
    public static void RecurringInvoicePreviewAndSave()
    {
        //Preview Recurring Invoice 
        CODATestIDMapExt.load(SUFFIX);
        ID SinvId = CODATestIdMap.resolve(REFERENCE);
        ffb_RecurringInvoiceTestHelper testHelper = new ffb_RecurringInvoiceTestHelper(REFERENCE);
        testHelper.setRecurringType(CODAInvoiceController.TYPE_REVENUE);
        testHelper.setRecurringStartDate(INVOICE_DATE);
        testHelper.setScheduleType(CODAInvoiceController.SCHEDULETYPE_DIVIDE);
        testHelper.setInstallmentInterval(CODAInvoice.INTERVAL_MONTHLY);
        testHelper.setNumberOfInstallment(NUM_OF_INSTALLMENTS_6);
        //Save , SF Preview is similar to VF Save action
        testHelper.Preview();
        List<ffb_RecurringInvoiceTestHelper.RecurringRulesLineItems> reccLines = testHelper.getRecurringLines();
        System.assert(reccLines.size() == NUM_OF_INSTALLMENTS_6, 'Error-Recurring Invoice size is not correct Expected 6, Actual-'+reccLines.size());
        
        //Line 1 validations
        reccLines[0].assertDueDate(DUEDATE1);
        reccLines[0].assertInvoiceDate(INVOICEDATE1);
        reccLines[0].assertPeriod(PERIOD1.getDto().Id);
        reccLines[0].assertCurrency(CODATestIdMap.resolve(CODABaseData.CURRENCYCODE_GBP+':' + COMPANY_NAME));
        reccLines[0].assertAmount(VALUE_398_00);
        //Line 2 validations
        reccLines[1].assertDueDate(DUEDATE2);
        reccLines[1].assertInvoiceDate(INVOICEDATE2);
        reccLines[1].assertPeriod(PERIOD2.getDto().Id);
        reccLines[1].assertCurrency(CODATestIdMap.resolve(CODABaseData.CURRENCYCODE_GBP+':' + COMPANY_NAME));
        reccLines[1].assertAmount(VALUE_398_00);
        //Line 3 validations
        reccLines[2].assertDueDate(DUEDATE3);
        reccLines[2].assertInvoiceDate(INVOICEDATE3);
        reccLines[2].assertPeriod(PERIOD3.getDto().Id);
        reccLines[2].assertCurrency(CODATestIdMap.resolve(CODABaseData.CURRENCYCODE_GBP+':' + COMPANY_NAME));
        reccLines[2].assertAmount(VALUE_398_00);
        //Line 4 validations
        reccLines[3].assertDueDate(DUEDATE4);
        reccLines[3].assertInvoiceDate(INVOICEDATE4);
        reccLines[3].assertPeriod(PERIOD4.getDto().Id);
        reccLines[3].assertCurrency(CODATestIdMap.resolve(CODABaseData.CURRENCYCODE_GBP+':' + COMPANY_NAME));
        reccLines[3].assertAmount(VALUE_398_00);
        //Line 5 validations
        reccLines[4].assertDueDate(DUEDATE5);
        reccLines[4].assertInvoiceDate(INVOICEDATE5);
        reccLines[4].assertPeriod(PERIOD5.getDto().Id);
        reccLines[4].assertCurrency(CODATestIdMap.resolve(CODABaseData.CURRENCYCODE_GBP+':' + COMPANY_NAME));
        reccLines[4].assertAmount(VALUE_398_00);
        //Line 6 validations
        reccLines[5].assertDueDate(DUEDATE6);
        reccLines[5].assertInvoiceDate(INVOICEDATE6);
        reccLines[5].assertPeriod(PERIOD6.getDto().Id);
        reccLines[5].assertCurrency(CODATestIdMap.resolve(CODABaseData.CURRENCYCODE_GBP+':' + COMPANY_NAME));
        reccLines[5].assertAmount(VALUE_400_00);      
        
        // Save the Invoice with recurring invoices
        testHelper.save();
    }
    
    public static void postLastInvoiceAndValidate()
    {
        CODATestIDMapExt.load(SUFFIX);
        ID SinvId = CODATestIdMap.resolve(REFERENCE);
        Id currId = CODATestIdMap.resolve(CODABaseData.CURRENCYCODE_GBP+':' + COMPANY_NAME);
        //Validation A
        list <CODAInvoice__c> invoiceList = [Select Id,Name,InvoiceDate__c,DueDate__c,InvoiceTotal__c,InvoiceCurrency__c  
                                             from CODAInvoice__c where InvoiceStatus__c=: CODAInvoice.INVOICESTATUS_INPROGRESS AND InvoiceDescription__c LIKE :REFERENCE + '%' ORDER BY InvoiceDate__c ASC];
        System.assertEquals(invoiceList.size() , NUM_OF_INSTALLMENTS_6, 'Error- Recurring Invoice Inprogress size is not correct Expected 6, Actual-'+invoiceList.size());
        ValidateRecurringInvoices(invoiceList,1, INVOICEDATE1, DUEDATE1, currId, VALUE_440_08);
        ValidateRecurringInvoices(invoiceList,2, INVOICEDATE2, DUEDATE2, currId, VALUE_440_08);
        ValidateRecurringInvoices(invoiceList,3, INVOICEDATE3, DUEDATE3, currId, VALUE_440_08);
        ValidateRecurringInvoices(invoiceList,4, INVOICEDATE4, DUEDATE4, currId, VALUE_440_08);
        ValidateRecurringInvoices(invoiceList,5, INVOICEDATE5, DUEDATE5, currId, VALUE_440_08);
        ValidateRecurringInvoices(invoiceList,6, INVOICEDATE6, DUEDATE6, currId, VALUE_442_40);
        
        //Go to Last Invoice Check B)
        CODAInvoice__c sInv = [select Id,Account__c,Dimension1__c,Dimension2__c,
                               Dimension3__c,Dimension4__c, InvoiceStatus__c,BillingAddress__c,
                               ShippingAddress__c, InvoiceGroup__c, transaction__c,Name,CustomerReference__c,
                               InvoiceDate__c, Period__c, DueDate__c, 	ShippingMethod__c, InvoiceCurrency__c ,
                               InvoiceDescription__c from CODAInvoice__c where ID=:invoiceList[5].Id];
        
        //Acccount Detail validations
        system.assertEquals(sInv.Account__c,CODATestIdMap.resolve(CODABaseDataExt.NAMEACCOUNT_CAMBRIDGEAUTO), 'Error- Incorrect Account , Expected '+CODABaseDataExt.NAMEACCOUNT_CAMBRIDGEAUTO+' Account, Actual value- '+sInv.InvoiceStatus__c);            
        system.assertEquals(sInv.Dimension1__c,CODATestIdMap.resolve(CODABaseDataExt.NAMEDIM1_NORTH), 'Error- Incorrect Dimension 1, Expected '+CODABaseDataExt.NAMEDIM1_NORTH+' , Actual value- '+sInv.Dimension1__c);            
        system.assertEquals(sInv.Dimension2__c,CODATestIdMap.resolve(CODABaseDataExt.NAMEDIM2_DODGEUK), 'Error- Incorrect Dimension 2, Expected '+CODABaseDataExt.NAMEDIM2_DODGEUK+' , Actual value- '+sInv.Dimension2__c);            
        system.assertEquals(sInv.Dimension3__c,CODATestIdMap.resolve(CODABaseDataExt.NAMEDIM3_BILLYRAY), 'Error- Incorrect Dimension 3, Expected '+CODABaseDataExt.NAMEDIM3_BILLYRAY+' , Actual value- '+sInv.Dimension3__c);            
        system.assertEquals(sInv.Dimension4__c,CODATestIdMap.resolve(CODABaseDataExt.NAMEDIM4_HARROGATE), 'Error- Incorrect Dimension 4, Expected '+CODABaseDataExt.NAMEDIM4_HARROGATE+' , Actual value- '+sInv.Dimension4__c);            
        
        //Invoice Details validations
        system.assert(sInv.transaction__c == null, 'Error- Incorrect Invoice detail Transaction  , Expected null');            
        system.assert(sInv.Name != null, 'Error- Incorrect Invoice Number , Expected not null');            
        system.assert(sInv.CustomerReference__c == null, 'Error- Incorrect Customer Reference Number , Expected null, Actual -'+sInv.CustomerReference__c);            
        system.assert(sInv.InvoiceDate__c == INVOICEDATE6, 'Error- Incorrect INVOICE DATE , Actual -'+sInv.InvoiceDate__c);            
        system.assert(sInv.Period__c == PERIOD6.getDto().ID, 'Error- Incorrect Period , Actual -'+sInv.Period__c);    
        system.assert(sInv.DueDate__c == DUEDATE6 , 'Error- Incorrect Period , Actual -'+sInv.DueDate__c);    
        system.assert(sInv.ShippingMethod__c == null , 'Error- Incorrect Shipping Method expected Null, Actual -'+sInv.ShippingMethod__c);    
        system.assert(sInv.InvoiceCurrency__c == CODATestIdMap.resolve(CODABaseData.CURRENCYCODE_GBP+':' + COMPANY_NAME), 'Error- Incorrect Invoice Currency  expected '+CODABaseData.CURRENCYCODE_GBP+', Actual -'+sInv.InvoiceCurrency__c);    
        system.assert(sInv.InvoiceDescription__c.Contains(INVOICE_DESCRIPTION_6_of_6) , 'Error- Incorrect Invoice description  expected '+INVOICE_DESCRIPTION_6_of_6+', Actual -'+sInv.InvoiceDescription__c);    
        
        integer prodCount = 0;
        for(codaInvoiceLineItem__c lineItem : [Select ID,Product__c, Dimension1__c, Dimension2__c,Dimension3__c,Dimension4__c,Quantity__c, UnitPrice__c, TaxCode1__c, TaxValue1__c, NetValue__c from codaInvoiceLineItem__c where Invoice__c =:invoiceList[5].Id])
        {
            if(lineItem.Product__c == CODATestIdMap.resolve(CODABaseDataExt.NAMEPRODUCT_BOSCHOILFILTER))
            {			
                system.assert(lineItem.Dimension1__c  == CODATestIdMap.resolve(CODABaseDataExt.NAMEDIM1_NORTH), 'Error- Incorrect Line Item Dimension 1, Expected '+CODABaseDataExt.NAMEDIM1_NORTH+' , Actual value- '+lineItem.Dimension1__c);            
                system.assert(lineItem.Dimension2__c  == CODATestIdMap.resolve(CODABaseDataExt.NAMEDIM2_DODGEUK), 'Error- Incorrect Line Item Dimension 2, Expected '+CODABaseDataExt.NAMEDIM2_DODGEUK+' , Actual value- '+lineItem.Dimension2__c);            
                system.assert(lineItem.Dimension3__c  == CODATestIdMap.resolve(CODABaseDataExt.NAMEDIM3_BILLYRAY), 'Error- Incorrect Line Item Dimension 3, Expected '+CODABaseDataExt.NAMEDIM3_BILLYRAY+' , Actual value- '+lineItem.Dimension3__c);            
                system.assert(lineItem.Dimension4__c  == CODATestIdMap.resolve(CODABaseDataExt.NAMEDIM4_HARROGATE), 'Error- Incorrect Line Item Dimension 4, Expected '+CODABaseDataExt.NAMEDIM4_HARROGATE+' , Actual value- '+lineItem.Dimension4__c);            
                system.assert(lineItem.Quantity__c  ==  QUANTITY_10, 'Error- Incorrect Line Item Quantity , Expected '+QUANTITY_10+' , Actual value- '+lineItem.Quantity__c);
                system.assert(lineItem.UnitPrice__c  ==  UNIT_PRICE_16, 'Error- Incorrect Line Item UNIT PRICE, Expected '+UNIT_PRICE_16+' , Actual value- '+lineItem.UnitPrice__c);            
                system.assert(lineItem.TaxCode1__c  == CODATestIdMap.resolve(TAX_NAME_VOZ_16), 'Error- Incorrect Line Item TAX CODE, Expected '+TAX_NAME_VOZ_16+' , Actual value- '+lineItem.TaxCode1__c);            
                system.assert(lineItem.TaxValue1__c  ==  VALUE_25_60, 'Error- Incorrect Line Item TAX value, Expected '+VALUE_25_60+' , Actual value- '+lineItem.TaxValue1__c); 
                system.assert(lineItem.NetValue__c  ==  VALUE_160_00, 'Error- Incorrect Line Item net Value, Expected '+VALUE_160_00+' , Actual value- '+lineItem.NetValue__c); 
                prodCount++;
            }
            else if(lineItem.Product__c == CODATestIdMap.resolve(CODABaseDataExt.NAMEPRODUCT_CENTRICREARBRAKE))
            {
                prodCount ++;
            }
            else
            {
                system.assert(false, 'Invalid/unknown Product in line Items');
            }			
        }
        system.assert(prodCount == 2 , 'Error-Invoice Details validations failed product did not match');
        
        //Click Post. C)
        CODATestIDMapExt.put(REFERENCE1, invoiceList[5].Id);
        //Test.setCurrentPageReference(new PageReference(Page.codainvoiceconfirmPost.getUrl()+'?id='+invoiceList[5].Id));
        CODAConfirmPostTestHelper postInv = new CODAConfirmPostTestHelper(REFERENCE1);
        try
        {
            postInv.post();
            System.assert(false,'Error:Expected a confirmation message for posting the document.');
        }
        catch(Exception ex)
        {
            System.assert(ex.getMessage().contains(Label.codaConfirmPostInfoMessage) , 'Error- Expected confirmation message for posting document is '+Label.codaConfirmPostInfoMessage+' , Actual message- '+ex.getMessage());
        }
        
        sInv = [select Id,Name,InvoiceStatus__c from CODAInvoice__c where ID=:invoiceList[5].Id];
        system.assertEquals(sInv.InvoiceStatus__c,CODAInvoice.INVOICESTATUS_COMPLETE, 'Error- Incorrect invoice stattus, Expected status Complete. Actual status '+sInv.InvoiceStatus__c);            
        
        //get Invoice transaction Details
        CODATransaction__c transact = [select Id, 	Name, TransactionDate__c, Period__c, TransactionType__c, 
                                       DocumentNumber__c , OwnerCompany__c,Debits__c,Credits__c,HomeValueTotal__c,											
                                       AccountTotal__c, AccountOutstandingTotal__c, DocumentTotal__c, DocumentOutstandingTotal__c,
                                       (Select ID,HomeValue__c, HomeTaxTotal__c, HomeTaxableValue__c, GeneralLedgerAccount__c,
                                        LineType__c,LineDescription__c,DueDate__c , Dimension1__c,Dimension2__c,Dimension3__c, Dimension4__c from TransactionLineItems__r) 
                                       from CODATransaction__c WHERE SalesInvoice__c=:invoiceList[5].Id];
        //1)Transaction details						   
        system.assert(transact.Name != null, 'Error- transaction name /number should nut be null');
        system.assert(transact.TransactionDate__c == INVOICEDATE6, 'Error-incorrect  transaction INVOICE DATE  should not be null, actual'+ transact.TransactionDate__c);
        system.assert(transact.Period__c == PERIOD6.getDto().ID, 'Error- transaction Period  incorrect, actual'+ transact.Period__c );
        system.assert(transact.TransactionType__c == TRANSACTION_TYPE, 'Error-incorrect  Transaction Type, actual'+ transact.TransactionType__c );
        system.assert(transact.DocumentNumber__c == sInv.Name , 'Error-incorrect  transaction Document Number, actual'+ transact.DocumentNumber__c);
        system.assert(transact.OwnerCompany__c == CODATestIdMap.resolve(COMPANY_NAME) , 'Error-incorrect  transaction Company, actual'+ transact.OwnerCompany__c );	
        
        //a)Transaction Details
        system.assert(transact.Debits__c == VALUE_553_00 , 'Error-incorrect  transaction home debits, actual'+ transact.Debits__c );	
        system.assert(transact.Credits__c ==VALUE_N553_00 , 'Error-incorrect  transaction home credits, actual'+ transact.Credits__c );	
        system.assert(transact.HomeValueTotal__c == VALUE_ZERO , 'Error-incorrect  transaction Home Totalvalue, actual'+ transact.HomeValueTotal__c );	
        
        //b) Account Line Summary:
        system.assert(transact.AccountTotal__c == VALUE_442_40 , 'Error-incorrect  transaction Account Total, expected '+ VALUE_442_40 +', actual'+ transact.AccountTotal__c );	
        system.assert(transact.AccountOutstandingTotal__c ==VALUE_442_40 , 'Error-incorrect  transaction Account Outstanding Total '+ VALUE_442_40 +', actual'+ transact.AccountOutstandingTotal__c );	
        system.assert(transact.DocumentTotal__c == VALUE_442_40 , 'Error-incorrect  transaction Document Total '+ VALUE_442_40 +', actual'+ transact.DocumentTotal__c );	
        system.assert(transact.DocumentOutstandingTotal__c == VALUE_442_40 , 'Error-incorrect  transaction Document outstanding Total '+ VALUE_442_40 +', actual'+ transact.DocumentOutstandingTotal__c );	
        
        //c) Transaction line items
        integer lineCount = 0;
        integer linetypeAcoountCount = 0;
        integer linetypeAnalysisValue_N200_00_count = 0;
        integer linetypeAnalysisValue_N300_00_count = 0;
        integer linetypeTaxValue_N32_00_count = 0;
        integer linetypeTaxValue_N21_00_count = 0;			
        System.assert(transact.TransactionLineItems__r.size() == 5, 'Erro-'+transact.TransactionLineItems__r.size());
        for(codaTransactionLineItem__c tranLineItem : transact.TransactionLineItems__r)
        {
            if(tranLineItem.LineType__c == LINE_TYPE_ACCOUNT)
            {
                system.assert(tranLineItem.HomeValue__c == VALUE_553_00 , 'Error-incorrect  transaction line Item  Home Value , expected '+ VALUE_553_00 +', actual'+ tranLineItem.HomeValue__c );	
                system.assert(tranLineItem.HomeTaxTotal__c == VALUE_53_00 , 'Error-incorrect  transaction line Item  Home Tax Total Value , expected '+ VALUE_53_00 +', actual'+ tranLineItem.HomeTaxTotal__c );	
                system.assert(tranLineItem.HomeTaxableValue__c == null , 'Error-incorrect  transaction line Item  Home HomeTaxableValue Value should be null, actual'+ tranLineItem.HomeTaxableValue__c );	
                system.assert(tranLineItem.GeneralLedgerAccount__c == CODATestIdMap.resolve(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD) , 'Error-incorrect  transaction line Item  Home GeneralLedgerAccount Value , expected '+ CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD +', actual'+ tranLineItem.GeneralLedgerAccount__c );	
                system.assert(tranLineItem.LineDescription__c.Contains(INVOICE_DESCRIPTION_6_of_6) , 'Error-incorrect  transaction line Item  Home LineDescription Value , expected '+ INVOICE_DESCRIPTION_6_of_6 +', actual'+ tranLineItem.LineDescription__c );	
                linetypeAcoountCount ++;
            }
            else if(tranLineItem.LineType__c == LINE_TYPE_ANALYSIS)
            {
                if(tranLineItem.HomeValue__c == VALUE_N200_00)
                {
                    system.assert(tranLineItem.HomeTaxTotal__c == VALUE_N32_00 , 'Error-incorrect  transaction line Item  Home Tax Total Value , expected '+ VALUE_N32_00 +', actual'+ tranLineItem.HomeTaxTotal__c );	
                    system.assert(tranLineItem.HomeTaxableValue__c == null , 'Error-incorrect  transaction line Item  Home HomeTaxableValue Value should be null, actual'+ tranLineItem.HomeTaxableValue__c );	
                    system.assert(tranLineItem.GeneralLedgerAccount__c == CODATestIdMap.resolve(CODABaseData.NAMEGLA_SALESPARTS) , 'Error-incorrect  transaction line Item  Home GeneralLedgerAccount Value , expected '+ CODABaseData.NAMEGLA_SALESPARTS +', actual'+ tranLineItem.GeneralLedgerAccount__c );	
                    linetypeAnalysisValue_N200_00_count ++;
                }
                else if(tranLineItem.HomeValue__c == VALUE_N300_00)
                {
                    system.assert(tranLineItem.HomeTaxTotal__c == VALUE_N21_00 , 'Error-incorrect  transaction line Item  Home Tax Total Value , expected '+ VALUE_N21_00 +', actual'+ tranLineItem.HomeTaxTotal__c );	
                    system.assert(tranLineItem.HomeTaxableValue__c == null , 'Error-incorrect  transaction line Item  Home HomeTaxableValue Value should be null, actual'+ tranLineItem.HomeTaxableValue__c );	
                    system.assert(tranLineItem.GeneralLedgerAccount__c == CODATestIdMap.resolve(CODABaseData.NAMEGLA_SALESPARTS) , 'Error-incorrect  transaction line Item  Home GeneralLedgerAccount Value , expected '+ CODABaseData.NAMEGLA_SALESPARTS +', actual'+ tranLineItem.GeneralLedgerAccount__c );	
                    linetypeAnalysisValue_N300_00_count++;
                }
            }
            else if(tranLineItem.LineType__c == LINE_TYPE_TAX)
            {
                if(tranLineItem.HomeValue__c == VALUE_N32_00)
                {
                    system.assert(tranLineItem.HomeTaxTotal__c == VALUE_ZERO , 'Error-incorrect  transaction line Item  Home Tax Total Value , expected '+ VALUE_ZERO +', actual'+ tranLineItem.HomeTaxTotal__c );	
                    system.assert(tranLineItem.HomeTaxableValue__c == VALUE_N200_00 , 'Error-incorrect  transaction line Item  Home HomeTaxableValue Value should be '+VALUE_N200_00+', actual'+ tranLineItem.HomeTaxableValue__c );	
                    system.assert(tranLineItem.GeneralLedgerAccount__c == CODATestIdMap.resolve(CODABaseData.NAMEGLA_VATOUTPUT) , 'Error-incorrect  transaction line Item  Home GeneralLedgerAccount Value , expected '+ CODABaseData.NAMEGLA_VATOUTPUT +', actual'+ tranLineItem.GeneralLedgerAccount__c );	
                    system.assert(tranLineItem.LineDescription__c == TAX_NAME_VOZ_16 , 'Error-incorrect  transaction line Item  Home LineDescription Value , expected '+ CODABaseDataExt.NAMETAXCODE_VOZ +', actual'+ tranLineItem.LineDescription__c );	
                    linetypeTaxValue_N32_00_count ++;
                }
                else if(tranLineItem.HomeValue__c == VALUE_N21_00)
                {
                    system.assert(tranLineItem.HomeTaxTotal__c == VALUE_ZERO , 'Error-incorrect  transaction line Item  Home Tax Total Value , expected '+ VALUE_ZERO +', actual'+ tranLineItem.HomeTaxTotal__c );	
                    system.assert(tranLineItem.HomeTaxableValue__c == VALUE_N300_00 , 'Error-incorrect  transaction line Item  Home HomeTaxableValue Value should be '+ VALUE_N300_00 +', actual'+ tranLineItem.HomeTaxableValue__c );	
                    system.assert(tranLineItem.GeneralLedgerAccount__c == CODATestIdMap.resolve(CODABaseData.NAMEGLA_VATOUTPUT) , 'Error-incorrect  transaction line Item  Home GeneralLedgerAccount Value , expected '+ CODABaseData.NAMEGLA_VATOUTPUT +', actual'+ tranLineItem.GeneralLedgerAccount__c );	
                    system.assert(tranLineItem.LineDescription__c == CODABaseDataExt.NAMETAXCODE_VOECSALES , 'Error-incorrect  transaction line Item  Home LineDescription Value , expected '+ CODABaseDataExt.NAMETAXCODE_VOECSALES +', actual'+ tranLineItem.LineDescription__c );	
                    linetypeTaxValue_N21_00_count ++;
                }                
            }				
            lineCount++;
        }
        system.assert(lineCount == 5, 'Error-Incorrect transaction LineItems of type Account , Analysis, and Tax, Expected 5, Actual-'+lineCount);
        system.assert(linetypeAcoountCount == 1, 'Error-Incorrect count transaction LineItems of type Account '+linetypeAcoountCount);
        system.assert(linetypeAnalysisValue_N200_00_count == 1, 'Error-Incorrect count transaction linetypeAnalysisValue_N200_00_count , Actual-'+linetypeAnalysisValue_N200_00_count);
        system.assert(linetypeAnalysisValue_N300_00_count == 1, 'Error-Incorrect count transaction linetypeAnalysisValue_N300_00_count, Actual-'+linetypeAnalysisValue_N300_00_count);
        system.assert(linetypeTaxValue_N32_00_count == 1, 'Error-Incorrect count transaction linetype linetypeTaxValue_N32_00_count, Actual-'+linetypeTaxValue_N32_00_count);
        system.assert(linetypeTaxValue_N21_00_count == 1, 'Error-Incorrect count transaction LineItems line type TaxValue -21.00 , Actual-'+linetypeTaxValue_N21_00_count);    
    }
    
    public static void SaveAndPostReccuringInvoices()
    {
        CODATestIDMapExt.load(SUFFIX);
        ffb_RecurringInvoiceTestHelper testHelper = new ffb_RecurringInvoiceTestHelper( REFERENCE2);
        testHelper.setRecurringType(CODAInvoiceController.TYPE_REVENUE);
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
    
    //Save&Post Recurring Invoices
    public static void ValidateFirstInvoiceAfterSaveAndPost()
    {
        //Test Step TST025215
        CODATestIDMapExt.load(SUFFIX);
        Id currId = CODATestIdMap.resolve(CODABaseData.CURRENCYCODE_GBP+':' +  COMPANY_NAME);
        //Validation A
        list <CODAInvoice__c> invoiceList = [Select Id,Name,InvoiceDate__c,DueDate__c,InvoiceTotal__c,InvoiceCurrency__c   
                                             from CODAInvoice__c where InvoiceStatus__c=: CODAInvoice.INVOICESTATUS_COMPLETE AND InvoiceDescription__c LIKE:REFERENCE2 + '%'  ORDER BY InvoiceDate__c ASC];
        System.assertEquals(invoiceList.size() , NUM_OF_INSTALLMENTS_6, 'Error-TST025185- Recurring Invoice Complete size is not correct Expected 6, Actual-'+invoiceList.size());
        ValidateRecurringInvoices(invoiceList,1, INVOICEDATE1, DUEDATE1, currId, VALUE_440_08);
        ValidateRecurringInvoices(invoiceList,2, INVOICEDATE2, DUEDATE2, currId, VALUE_440_08);
        ValidateRecurringInvoices(invoiceList,3, INVOICEDATE3, DUEDATE3, currId, VALUE_440_08);
        ValidateRecurringInvoices(invoiceList,4, INVOICEDATE4, DUEDATE4, currId, VALUE_440_08);
        ValidateRecurringInvoices(invoiceList,5, INVOICEDATE5, DUEDATE5, currId, VALUE_440_08);
        ValidateRecurringInvoices(invoiceList,6, INVOICEDATE6, DUEDATE6, currId, VALUE_442_40);
        
        //Test Step TST025216
        //Go to the First Invoice Check A)
        //get Invoice transaction Details
        CODATransaction__c transact = [select Id, 	Name, TransactionDate__c, Period__c, TransactionType__c, 
                                       DocumentNumber__c , OwnerCompany__c,Debits__c,Credits__c,HomeValueTotal__c,											
                                       AccountTotal__c, AccountOutstandingTotal__c, DocumentTotal__c, DocumentOutstandingTotal__c,
                                       (Select ID,HomeValue__c, HomeTaxTotal__c, HomeTaxableValue__c, GeneralLedgerAccount__c,
                                        LineType__c,LineDescription__c,DueDate__c , Dimension1__c,Dimension2__c,Dimension3__c, Dimension4__c from TransactionLineItems__r) 
                                       from CODATransaction__c WHERE SalesInvoice__c=:invoiceList[0].Id];
        
        //1)Transaction details						   
        system.assert(transact.Name != null, 'Error- transaction name /number should nut be null');
        system.assert(transact.TransactionDate__c ==  INVOICE_DATE, 'Error-incorrect  transaction INVOICE DATE  should not be null, actual'+ transact.TransactionDate__c);
        system.assert(transact.Period__c ==  PERIOD1.getDto().ID, 'Error- transaction Period  incorrect, actual'+ transact.Period__c );
        system.assert(transact.TransactionType__c ==  TRANSACTION_TYPE, 'Error-incorrect  Transaction Type, actual'+ transact.TransactionType__c );
        system.assert(transact.DocumentNumber__c == invoiceList[0].Name , 'Error-incorrect  transaction Document Number, actual'+ transact.DocumentNumber__c );
        system.assert(transact.OwnerCompany__c == CODATestIdMap.resolve( COMPANY_NAME) , 'Error-incorrect  transaction Company, actual'+ transact.OwnerCompany__c );	
        
        //a)Transaction Details
        system.assert(transact.Debits__c ==  VALUE_550_10 , 'Error-incorrect  transaction home debits, actual'+ transact.Debits__c );	
        system.assert(transact.Credits__c == VALUE_N550_10 , 'Error-incorrect  transaction home credits, actual- '+ transact.Credits__c );	
        system.assert(transact.HomeValueTotal__c ==  VALUE_ZERO , 'Error-incorrect  transaction Home Totalvalue, actual'+ transact.HomeValueTotal__c );	
        
        //b) Account Line Summary:
        system.assert(transact.AccountTotal__c ==  VALUE_440_08 , 'Error-incorrect  transaction Account Total, expected '+  VALUE_440_08 +', actual'+ transact.AccountTotal__c );	
        system.assert(transact.AccountOutstandingTotal__c == VALUE_440_08 , 'Error-incorrect  transaction Account Outstanding Total '+  VALUE_440_08 +', actual'+ transact.AccountOutstandingTotal__c );	
        system.assert(transact.DocumentTotal__c ==  VALUE_440_08 , 'Error-incorrect  transaction Document Total '+  VALUE_440_08 +', actual'+ transact.DocumentTotal__c );	
        system.assert(transact.DocumentOutstandingTotal__c ==  VALUE_440_08 , 'Error-incorrect  transaction Document outstanding Total '+  VALUE_440_08 +', actual'+ transact.DocumentOutstandingTotal__c );	
        
        //c) Transaction line items
        integer lineCount = 0;
        integer linetypeAcoountCount = 0;
        integer linetypeAnalysisValue_N197_50_count = 0;
        integer linetypeAnalysisValue_N300_00_count = 0;
        integer linetypeTaxValue_N31_00_count = 0;
        integer linetypeTaxValue_N21_00_count = 0;			
        for(codaTransactionLineItem__c tranLineItem : transact.TransactionLineItems__r)
        {
            if(tranLineItem.LineType__c ==  LINE_TYPE_ACCOUNT)
            {
                system.assert(tranLineItem.HomeValue__c ==  VALUE_550_10 , 'Error-incorrect  transaction line Item  Home Value , expected '+  VALUE_550_10 +', actual'+ tranLineItem.HomeValue__c );	
                system.assert(tranLineItem.HomeTaxTotal__c ==  VALUE_52_60 , 'Error-incorrect  transaction line Item  Home Tax Total Value , expected '+  VALUE_52_60 +', actual'+ tranLineItem.HomeTaxTotal__c );	
                system.assert(tranLineItem.HomeTaxableValue__c == null , 'Error-incorrect  transaction line Item  Home HomeTaxableValue Value should be null, actual'+ tranLineItem.HomeTaxableValue__c );	
                system.assert(tranLineItem.GeneralLedgerAccount__c == CODATestIdMap.resolve(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD) , 'Error-incorrect  transaction line Item  Home GeneralLedgerAccount Value , expected '+ CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD +', actual'+ tranLineItem.GeneralLedgerAccount__c );	
                system.assert(tranLineItem.LineDescription__c.Contains(INVOICE_DESCRIPTION_1_of_6) , 'Error-incorrect  transaction line Item  Home LineDescription Value , expected '+  INVOICE_DESCRIPTION_1_of_6 +', actual'+ tranLineItem.LineDescription__c );	
                lineCount ++;
                linetypeAcoountCount ++;
            }
            else if(tranLineItem.LineType__c ==  LINE_TYPE_ANALYSIS)
            {
                if(tranLineItem.HomeValue__c ==  VALUE_N197_50)
                {
                    system.assert(tranLineItem.HomeTaxTotal__c ==  VALUE_N31_60 , 'Error-incorrect  transaction line Item  Home Tax Total Value , expected '+  VALUE_N31_60 +', actual'+ tranLineItem.HomeTaxTotal__c );	
                    system.assert(tranLineItem.HomeTaxableValue__c == null , 'Error-incorrect  transaction line Item  Home HomeTaxableValue Value should be null, actual'+ tranLineItem.HomeTaxableValue__c );	
                    system.assert(tranLineItem.GeneralLedgerAccount__c == CODATestIdMap.resolve(CODABaseData.NAMEGLA_SALESPARTS) , 'Error-incorrect  transaction line Item  Home GeneralLedgerAccount Value , expected '+ CODABaseData.NAMEGLA_SALESPARTS +', actual'+ tranLineItem.GeneralLedgerAccount__c );	
                    lineCount ++;
                    linetypeAnalysisValue_N197_50_count ++;
                }
                else if(tranLineItem.HomeValue__c ==  VALUE_N300_00)
                {
                    system.assert(tranLineItem.HomeTaxTotal__c ==  VALUE_N21_00 , 'Error-incorrect  transaction line Item  Home Tax Total Value , expected '+  VALUE_N21_00 +', actual'+ tranLineItem.HomeTaxTotal__c );	
                    system.assert(tranLineItem.HomeTaxableValue__c == null , 'Error-incorrect  transaction line Item  Home HomeTaxableValue Value should be null, actual'+ tranLineItem.HomeTaxableValue__c );	
                    system.assert(tranLineItem.GeneralLedgerAccount__c == CODATestIdMap.resolve(CODABaseData.NAMEGLA_SALESPARTS) , 'Error-incorrect  transaction line Item  Home GeneralLedgerAccount Value , expected '+ CODABaseData.NAMEGLA_SALESPARTS +', actual'+ tranLineItem.GeneralLedgerAccount__c );	
                    lineCount ++;
                    linetypeAnalysisValue_N300_00_count++;
                }
            }
            else if(tranLineItem.LineType__c ==  LINE_TYPE_TAX)
            {
                if(tranLineItem.HomeValue__c ==  VALUE_N31_60)
                {
                    system.assert(tranLineItem.HomeTaxTotal__c ==  VALUE_ZERO , 'Error-incorrect  transaction line Item  Home Tax Total Value , expected '+  VALUE_ZERO +', actual'+ tranLineItem.HomeTaxTotal__c );	
                    system.assert(tranLineItem.HomeTaxableValue__c ==  VALUE_N197_50 , 'Error-incorrect  transaction line Item  Home HomeTaxableValue Value should be '+ VALUE_N197_50+', actual'+ tranLineItem.HomeTaxableValue__c );	
                    system.assert(tranLineItem.GeneralLedgerAccount__c == CODATestIdMap.resolve(CODABaseData.NAMEGLA_VATOUTPUT) , 'Error-incorrect  transaction line Item  Home GeneralLedgerAccount Value , expected '+ CODABaseData.NAMEGLA_VATOUTPUT +', actual'+ tranLineItem.GeneralLedgerAccount__c );	
                    system.assert(tranLineItem.LineDescription__c == TAX_NAME_VOZ_16, 'Error-incorrect  transaction line Item  Home LineDescription Value , expected '+ CODABaseDataExt.NAMETAXCODE_VOZ +', actual'+ tranLineItem.LineDescription__c );	
                    lineCount ++;
                    linetypeTaxValue_N31_00_count ++;
                }
                else if(tranLineItem.HomeValue__c ==  VALUE_N21_00)
                {
                    system.assert(tranLineItem.HomeTaxTotal__c ==  VALUE_ZERO , 'Error-incorrect  transaction line Item  Home Tax Total Value , expected '+  VALUE_ZERO +', actual'+ tranLineItem.HomeTaxTotal__c );	
                    system.assert(tranLineItem.HomeTaxableValue__c ==  VALUE_N300_00 , 'Error-incorrect  transaction line Item  Home HomeTaxableValue Value should be '+  VALUE_N300_00 +', actual'+ tranLineItem.HomeTaxableValue__c );	
                    system.assert(tranLineItem.GeneralLedgerAccount__c == CODATestIdMap.resolve(CODABaseData.NAMEGLA_VATOUTPUT) , 'Error-incorrect  transaction line Item  Home GeneralLedgerAccount Value , expected '+ CODABaseData.NAMEGLA_VATOUTPUT +', actual'+ tranLineItem.GeneralLedgerAccount__c );	
                    system.assert(tranLineItem.LineDescription__c == CODABaseDataExt.NAMETAXCODE_VOECSALES , 'Error-incorrect  transaction line Item  Home LineDescription Value , expected '+ CODABaseDataExt.NAMETAXCODE_VOECSALES +', actual'+ tranLineItem.LineDescription__c );	
                    lineCount ++;
                    linetypeTaxValue_N21_00_count ++;
                }
            }				
        }
        system.assert(lineCount == 5, 'Error-Incorrect transaction LineItems of type Account , Analysis, and Tax, Expected 5, Actual-'+lineCount);
        system.assert(linetypeAcoountCount == 1, 'Error-Incorrect count transaction LineItems of type Account '+linetypeAcoountCount);
        system.assert(linetypeAnalysisValue_N197_50_count == 1, 'Error-Incorrect count transaction linetypeAnalysisValue_N197_50_count , Actual-'+linetypeAnalysisValue_N197_50_count);
        system.assert(linetypeAnalysisValue_N300_00_count == 1, 'Error-Incorrect count transaction linetypeAnalysisValue_N300_00_count, Actual-'+linetypeAnalysisValue_N300_00_count);
        system.assert(linetypeTaxValue_N31_00_count == 1, 'Error-Incorrect count transaction linetypeTaxValue_N31_00_count, Actual-'+linetypeTaxValue_N31_00_count);
        system.assert(linetypeTaxValue_N21_00_count == 1, 'Error-Incorrect count transaction linetypeTaxValue_N21_00_count , Actual-'+linetypeTaxValue_N21_00_count);
    }
    
    
    public static codaInvoice__c CreateInvoicewithLineItem(string invoiceDescription)
    {
        //Create Invoice
        CODAPeriod period = CODAPeriodMapExt.getPeriodByDate(INVOICE_DATE);
        codaInvoice__c sInv2 = new codaInvoice__c();
        sInv2.Account__c = CODATestIdMap.resolve(CODABaseDataExt.NAMEACCOUNT_CAMBRIDGEAUTO);
        sInv2.InvoiceCurrency__c = CODATestIdMap.resolve(CODABaseData.CURRENCYCODE_GBP+':' + COMPANY_NAME);
        sInv2.InvoiceDate__c = INVOICE_DATE;
        sInv2.DueDate__c = DUE_DATE;
        sInv2.Period__c = period.getDto().Id;
        sInv2.InvoiceDescription__c = invoiceDescription;
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
        lineItem1.TaxCode1__c = CODATestIdMap.resolve(TAX_NAME_VOZ_16);
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
    
    public static void ValidateRecurringInvoices(List<CODAInvoice__c> invoiceList,integer invoiceNumber, Date invoiceDate, Date dueDate, Id currencyId, double invoicetotal  )
    {
        invoiceNumber = invoiceNumber -1; 
        System.assertEquals(invoiceList[invoiceNumber].InvoiceDate__c , invoiceDate);              
        System.assertEquals(invoiceList[invoiceNumber].DueDate__c  , dueDate );   
        System.assertEquals(invoiceList[invoiceNumber].InvoiceCurrency__c ,currencyId  , 'Error in currency, expected -'+currencyId+' - Actual-'+invoiceList[0].InvoiceCurrency__c );   
        System.assertEquals(invoiceList[invoiceNumber].InvoiceTotal__c ,invoicetotal);  
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
        
        CODATaxCode__c taxcodeVOZ16 = [Select Id from CODATaxCode__c where Name=:TAX_NAME_VOZ_16][0];
        DELETE [SELECT ID from codaTaxRate__c where TaxCode__c=:taxcodeVOZ16.Id];
        DELETE taxcodeVOZ16;
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
