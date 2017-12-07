/*
* Copyright (c) 2016 FinancialForce.com, inc.  All rights reserved.
*/
@isTest(SeeAllData=true) 
private class CODATID016689DataSystemTest 
{ 
    /* Static initialiser for the test class */ 
    static string expectedMessage = 'LineDescription__c';
    static 
    { 
        CODAContext.setSystemTest(false); 
        CODAUnitOfWork.getCurrent();
        CODATestIDMapExt.load(CODATID016689Data.SUFFIX);
    }
    
    /* payable invoice Line Item, Verify Line_description is mandatory */ 
    static testMethod void TST024108_A()
    {
        User Accountant = CODABaseData.getProfile(CODABaseData.ACCOUNTANT);
        System.runAs(Accountant)
        {
            CODAPeriod period = CODAPeriodMapExt.getPeriodByDate(CODATID016689Data.INVOICE_DATE);
            CODAPurchaseInvoice__c pinv = new CODAPurchaseInvoice__c();
            pinv.Account__c = CODATestIdMap.resolve(CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO);
            pinv.InvoiceCurrency__c = CODATestIdMap.resolve(CODABaseData.CURRENCYCODE_GBP+':' + CODATID016689Data.COMPANY_NAME);
            pinv.AccountInvoiceNumber__c = '12345';
            pinv.InvoiceDate__c = CODATID016689Data.INVOICE_DATE;
            pinv.DueDate__c = CODATID016689Data.DUE_DATE;
            pinv.Period__c = period.getDto().Id;
            INSERT pinv;			
            CODATestIDMapExt.put(CODATID016689Data.INVOICE_REF1, pinv.id);
            
            Test.setCurrentPage(Page.payableinvoicemanageprd);
            PayableInvoiceManagePrdTestHelper pinProductLines = new PayableInvoiceManagePrdTestHelper(CODATID016689Data.INVOICE_REF1);
            List<PayableInvoiceManagePrdTestHelper.LineItem> lineItems = pinProductLines.getPayableInvoiceVisibleProductLines();
            
            lineItems[0].setProduct(CODABaseDataExt.NAMEPRODUCT_AUTO1COMCLUTCH, false);
            lineItems[0].setUnitPrice(CODATID016689Data.UNIT_PRICE_6_64583333);
            lineItems[0].setQuantity(CODATID016689Data.QUANTITY_12);
            lineItems[0].setLineDescription(null);
            pinProductLines.save();            
            boolean messageFound = false;
            for(ApexPages.Message errmsg : ApexPages.getMessages())
            {               
                if(errmsg.getSummary().contains(expectedMessage))
                    messageFound = true;               
            }
            system.assert(messageFound, 'Error-Validtion failed, expected Message-'+expectedMessage + ', Actual Message-'+ApexPages.getMessages());
        }
    }    
    
     /* payable credit Note Line Item, Verify Line_description is mandatory */ 
    static testMethod void TST024108_B()
    {
        User Accountant = CODABaseData.getProfile(CODABaseData.ACCOUNTANT);
        System.runAs(Accountant)
        {
            CODAPeriod period = CODAPeriodMapExt.getPeriodByDate(CODATID016689Data.INVOICE_DATE);
            CODAPurchaseCreditNote__c pcrn = new CODAPurchaseCreditNote__c();
            pcrn.Account__c = CODATestIdMap.resolve(CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO);
            pcrn.CreditNoteCurrency__c = CODATestIdMap.resolve(CODABaseData.CURRENCYCODE_GBP+':' + CODATID016689Data.COMPANY_NAME);
            pcrn.AccountCreditNoteNumber__c = '12345';
            pcrn.CreditNoteDate__c = CODATID016689Data.INVOICE_DATE;
            pcrn.DueDate__c = CODATID016689Data.DUE_DATE;
            pcrn.Period__c = period.getDto().Id;
            INSERT pcrn;
            
            CODATestIDMapExt.put(CODATID016689Data.CREDIT_NOTE_REF1, pcrn.id);
            
            //A)Select "Manage lines" button 
            Test.setCurrentPage(Page.payablecreditnotemanageprd);
            PayableCreditNoteManagePrdTestHelper testHelper = new PayableCreditNoteManagePrdTestHelper(CODATID016689Data.CREDIT_NOTE_REF1);	
            PayableCreditNoteManagePrdTestHelper.LineItem prdItem = testHelper.createNewLine();
            prdItem.setProduct(CODABaseDataExt.NAMEPRODUCT_AUTO1COMCLUTCH);
            prdItem.setUnitPrice(CODATID016689Data.UNIT_PRICE_6_64583333);
            prdItem.setQuantity(CODATID016689Data.QUANTITY_12);
            prdItem.setLineDescription(null);
            testHelper.save(); 
            
            boolean messageFound = false;
            for(ApexPages.Message errmsg : ApexPages.getMessages())
            {               
                if(errmsg.getSummary().contains(expectedMessage))
                    messageFound = true;               
            }
            system.assert(messageFound, 'Error-Validtion failed, expected Message-'+expectedMessage + ', Actual Message-'+ApexPages.getMessages());
        }
    }
    
     /* payable Sales Invoice Line Item, Verify Line_description is mandatory */
    static testMethod void TST024108_C()
    {
        codaInvoice__c sInv1 = new codaInvoice__c();
        sInv1.Account__c = CODATestIdMap.resolve(CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO);
        sInv1.InvoiceDescription__c = CODATID016689Data.INVOICE_NAME1;
        sInv1.InvoiceDate__c = Date.today();
        insert sInv1;
        CODATestIDMapExt.put(CODATID016689Data.INVOICE_NAME1, sInv1.id);
        
        //Add products to an invoice
        codaInvoiceLineItem__c invLine2 = new codaInvoiceLineItem__c();
        invLine2.Invoice__c = CODATestIdMap.resolve(CODATID016689Data.INVOICE_NAME1);
        invLine2.Product__c = CODATestIdMap.resolve(CODABaseDataExt.NAMEPRODUCT_AUTO1COMCLUTCH);
        invLine2.Quantity__c = CODATID016689Data.QUANTITY_12;
        invLine2.UnitPrice__c = CODATID016689Data.UNIT_PRICE_6_64583333;
        invLine2.TaxCode1__c = CODATestIdMap.resolve(CODABaseDataExt.NAMETAXCODE_VORSALES);
        invLine2.DeriveUnitPriceFromProduct__c = false;
        invLine2.LineDescription__c = CODATID016689Data.INVOICE_NAME1;
        insert invLine2;
        
        ffb_SalesInvoiceManageLinesTestHelper manageLines = new ffb_SalesInvoiceManageLinesTestHelper(CODATID016689Data.INVOICE_NAME1);
        manageLines.SetLineDescription(invLine2.Id , null);
        
        try
        {
            manageLines.Save();   
            System.assert(False, 'Error-Save should failed, Line description is mandatory');
        }
        catch(Exception ex)
        {
            system.assert(ex.getMessage().contains(expectedMessage), 'Error-Validtion failed, expected Message-'+expectedMessage + ', Actual Message-'+ex.getMessage());
        }
    }
    
    /* payable Sales credit Note Line Item, Verify Line_description is mandatory */
    static testMethod void TST024108_D()
    {
        CODAPeriod period2010_001 = CODAPeriodMapper.getByNameInCurrentCompanies(CODABaseData.YEAR1+'/003')[0];
        codaCreditNote__c creditNote = new codaCreditNote__c();
        creditNote.Account__c = CODATestIdMap.resolve(CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO);
        creditNote.CreditNoteDate__c = period2010_001.getStartDate();
        creditNote.DueDate__c = period2010_001.getStartDate();
        creditNote.Period__c = period2010_001.getID();
        insert creditNote;
        CODATestIDMapExt.put(CODATID016689Data.SCRN_NAME1, creditNote.id);       
        
        ffb_SalesCreditNoteLineItemTestHelper testHelper = new ffb_SalesCreditNoteLineItemTestHelper(CODATID016689Data.SCRN_NAME1);
        ffb_SalesCreditNoteLineItemTestHelper.LineItem prdItem = testHelper.createNewLine();
        prdItem.setProduct(CODABaseDataExt.NAMEPRODUCT_AUTO1COMCLUTCH);
        prdItem.setUnitPrice(CODATID016689Data.UNIT_PRICE_6_64583333);
        prdItem.setQuantity(CODATID016689Data.QUANTITY_12);
        prdItem.setLineDescription(null);            
        
        try
        {
            testHelper.save();              
            System.assert(False, 'Error-Save should failed, Line description is mandatory');
        }    
        catch(Exception ex)
        {
             system.assert(ex.getMessage().contains(expectedMessage), 'Error-Sales Credit Note Validtion failed, expected Message-'+expectedMessage + ', Actual Message-'+ex.getMessage());
        }
    }    
    
    /* payable Journal Line Item, Verify Line_description is mandatory */
    static testMethod void TST024108_E()
    {
        User Accountant = CODABaseData.getProfile(CODABaseData.ACCOUNTANT);
        System.runAs(Accountant)
        {
            CODAPeriod period = CODAPeriodMapExt.getPeriodByDate(CODATID016689Data.INVOICE_DATE);
            CODAJournal__c jrnl = new CODAJournal__c();
            jrnl.JournalDate__c = CODATID016689Data.INVOICE_DATE;
            jrnl.JournalDescription__c = 'Desc';
            jrnl.Period__c = period.getDto().Id;
            INSERT jrnl;            
            CODATestIDMapExt.put(CODATID016689Data.JOURNAL_REF1, jrnl.id);
            
            //A)Select "Manage lines" button 
            Test.setCurrentPage(Page.journalmanagelines);
            JournalManageLinesTestHelper testHelper = new JournalManageLinesTestHelper(CODATID016689Data.JOURNAL_REF1);	
            JournalManageLinesTestHelper.LineItem prdItem = testHelper.createNewLine();
            prdItem.setGLA(CODABaseData.NAMEGLA_SALESPARTS);            
            prdItem.setLineType(CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT);
            prdItem.setValue(500);
            prdItem.setDebitCredit(CODAJournalLineItem.DEBITCREDIT_DEBIT);
            prdItem.setLineDescription(null);
			testHelper.save(); 
            
            string errorMessage = ''+ testHelper.getPageErrorMessages();
            system.assert(errorMessage.contains(expectedMessage), 'Error-Validtion failed, expected Message-'+expectedMessage + ', Actual Message-'+errorMessage);
        }
    }  
}