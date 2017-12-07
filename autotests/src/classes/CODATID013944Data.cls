/*
*  Copyright (c) 2016 FinancialForce.com, inc.  All rights reserved.
*/ 
public class CODATID013944Data
{
    public static final String SUFFIX = '#TID013944';
    public static final String COMPANY_NAME = CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN;
    public static final string ACCOUNT_NAME = CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES;
    public static final string PRODUCT_NAME = CODABaseDataExt.NAMEPRODUCT_AUTO1COMCLUTCH;
    public static final string BANK_ACCOUNT_NAME = CODABaseDataExt.NAMEBANKACC_SANTANDERCURRENTACCOUNT;
    public static string VENDOR_INVOICE_NUM_1 = SUFFIX + '_1';
    public static string VENDOR_INVOICE_NUM_2 = SUFFIX + '_2';
    public static string VENDOR_INVOICE_NUM_3 = SUFFIX + '_3';
    public static string CREDIT_NOTE_1 = SUFFIX + 'CRN_1';
    public static string CREDIT_NOTE_2 = SUFFIX + 'CRN_2';
    public static string CREDIT_NOTE_3 = SUFFIX + 'CRN_3';
    public static string SORT_CODE = '1111';
    public static string SWIFT_NUMBER = '2222';
    public static string IBAN_NUMBER = '3333';
    public static string DBO_REFERENCE = '4444';
    public static string PRODUCT_UNIT_PRICE = '200';
    public static string PRODUCT_QUANTITY = '1';
    public static Date invoiceDate = System.today();    
    public static string REF_PAY1 = 'REF_PAY1';    
    public static string REF_PART_PAY = 'REF_PART_PAY';
    public static final string PAYMENTSTATUS_PAID = 'Paid';
    public static final string PAYMENTSTATUS_PART_PAID = 'Part Paid';
    public static final string PAYMENTSTATUS_UN_PAID = 'Unpaid';
    public static final string PAYMENTSTATUS_NOT_APPLICABLE = 'Not Applicable';
    public static final string PAYMENT_METHOD_ELECTRONIC = 'Electronic';
    public static string STANDARD_USER_ALIAS = 'stan';
    
    // Select current company for the current user
    public static void selectCompany()
    {
        CODABaseData.switchCurrentCompany(CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN, true, true, UserInfo.getUserId());
        CODAUnitOfWork.getCurrent().clearWork();
    }
    
    // switch Profile and select current company
    public static void switchProfile()
    {
        Id standardUser = [Select Id from User where alias=:CODATID013944Data.STANDARD_USER_ALIAS][0].id;        
        CODABaseData.switchCurrentCompany(CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN, true, false, standardUser);
    }
    
    /* Update Bank details and Account details. */
    public static void createData()
    {
        loadMap();
        CODAUnitOfWork.createAndSetCurrent();
        
        CODABankAccount bankAcc_SantanderCurrentAccount = CODABankAccountMapper.getByName(CODATID013944Data.BANK_ACCOUNT_NAME)[0];
        bankAcc_SantanderCurrentAccount.setSortCode(CODATID013944Data.SORT_CODE);
        bankAcc_SantanderCurrentAccount.setSWIFTNumber(CODATID013944Data.SWIFT_NUMBER);
        bankAcc_SantanderCurrentAccount.setIBANNumber(CODATID013944Data.IBAN_NUMBER);
        bankAcc_SantanderCurrentAccount.setDirectDebitOriginatorReference(CODATID013944Data.DBO_REFERENCE);
        
        CODACheckRange cRange = new CODACheckRange();
        cRange.setCheckRangeName('SANTANDER$');
        cRange.setBankAccount(bankAcc_SantanderCurrentAccount);
        cRange.setBankAccountId(bankAcc_SantanderCurrentAccount.getId());
        cRange.setStartCheckNumber('000001');
        cRange.setLastCheckNumber('000101');
        cRange.setActivated(true);
        
        account acc = [select id,SystemModstamp,CODABankAccountName__c, CODABankAccountNumber__c,CODABankSortCode__c,
                       CODABankSWIFTNumber__c, CODABankIBANNumber__c from account where MirrorName__c =:CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES];
        CODAGeneralLedgerAccount__c glaItem = [Select Id, Name from CODAGeneralLedgerAccount__c where Name =:CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLEUR];
        CODAAccount accBMWAutomobiles = new CODAAccount(acc);        
        accBMWAutomobiles.setBankAccountName(bankAcc_SantanderCurrentAccount.getName());
        accBMWAutomobiles.setBankAccountNumber(bankAcc_SantanderCurrentAccount.getAccountNumber());
        accBMWAutomobiles.setBankSortCode(bankAcc_SantanderCurrentAccount.getSortCode());
        accBMWAutomobiles.setBankSWIFTNumber(bankAcc_SantanderCurrentAccount.getSWIFTNumber());
        accBMWAutomobiles.setBankIBANNumber(bankAcc_SantanderCurrentAccount.getIBANNumber());
        accBMWAutomobiles.setAccountsPayableControlId(glaItem.Id);
        
        CODAUnitOfWork.getCurrent().commitWork();        
    }
	
	/* Assign permission set to Accountant user */
    public static void createDataExt1()
    {
        User standardUser = [Select Id from User where alias=:CODATID013944Data.STANDARD_USER_ALIAS][0];
        Set<String> permissionSets = new Set<String>{'AccountingPayableInvoiceCreditNote','AccountingPayableInvoicePost', 'AccountingandBillingSelectCompany', 'AccountingandBillingUserCompanies', 'AccountingandBillingStandard'};
            Map<Id, PermissionSet> psList = new Map<Id, PermissionSet>([Select id, Label from PermissionSet where Name in : permissionSets]);
        List<PermissionSetAssignment> psAssignLst = [Select id,PermissionSetId from PermissionSetAssignment where PermissionSetId in :psList.keySet() and AssigneeId=:standardUser.Id];
        Map<Id, PermissionSetAssignment> psAssignedMap = new Map<Id, PermissionSetAssignment>();
        for(PermissionSetAssignment psAssign : psAssignLst)
            psAssignedMap.put(psAssign.PermissionSetId, psAssign);
        List<PermissionSetAssignment> newPs = new List<PermissionSetAssignment>();
        for(Id permissionSetId : psList.keyset())
        {
            if(psAssignedMap.get(permissionSetId) == null) 
                newPs.add(new PermissionSetAssignment(PermissionSetId = permissionSetId, AssigneeId = standardUser.id));
        }
        if(newPs.size()>0)
        {
            insert newPs;
        }
    }
    
    //Switch Profile to admin
    public static void switchProfileToAdmin()
    {
        Id Admin = CODABaseData.getProfile(CODABaseData.SYSADMIN ).Id;
        CODABaseData.switchCurrentCompany(CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN, true, false, Admin);
    }
    /* Create and Post Purchase Invoice */
    public static void createAndPostPurchaseInvoice_1()
    {
        CODATestIDMapExt.load(SUFFIX);
        String currentPeriod = CODAPeriodMapExt.getPeriodByDate(system.Date.today()).getName() + ':' + CODAPeriodMapExt.getPeriodByDate(system.Date.today()).getOwnerCompany().getName();
        
        CODAPurchaseInvoiceTestHelper pInvoice1 = new CODAPurchaseInvoiceTestHelper();
        pInvoice1.setAccount(CODATID013944Data.ACCOUNT_NAME);
        pInvoice1.setInvoiceDate(CODATID013944Data.invoiceDate);        
        pInvoice1.setVendorInvoiceNumber(CODATID013944Data.VENDOR_INVOICE_NUM_1);
        pInvoice1.setInvoiceCurrency(CODABaseData.CURRENCYCODE_EUR+ ':' + CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN);
        pInvoice1.setPeriod(currentPeriod);
        
        //product line
        {
            CODAPurchaseInvoiceTestHelper.ProductLineItem productLine = pInvoice1.newProductLine(CODATID013944Data.PRODUCT_NAME);
            productLine.setQuantity(CODATID013944Data.PRODUCT_QUANTITY);
            productLine.setUnitPrice(CODATID013944Data.PRODUCT_UNIT_PRICE);            
        }
        pInvoice1.setAccountInvoiceTotal(pInvoice1.getInvoiceTotal());        
        try
        {
        	pInvoice1.saveAndPost();
            pInvoice1.reload();
        }
        catch(Exception ex)
        {
            System.assert(false, 'Error: Exception in post operation for Invoice. Error Message:' + ex.getMessage());
        }
		
        CODATestIDMapExt.put(VENDOR_INVOICE_NUM_1,pInvoice1.getId());        
        CODATestIDMapExt.save(SUFFIX);
    }
    // Get the status of Purchase Invoice
    public static void verifyPayableInvoiceStatus(String vendorInvoice, String paymentStatus)
    {
        CODATestIDMapExt.load(SUFFIX);
        CODAPurchaseInvoiceTestHelper pInvoice1 = new CODAPurchaseInvoiceTestHelper(vendorInvoice);
        System.assert(pInvoice1.getPurchaseInvoiceStatus()==CODAPurchaseInvoice.INVOICESTATUS_COMPLETE,'Error:invoice should be in '+CODAPurchaseInvoice.INVOICESTATUS_COMPLETE+' status, Actual status is - '+pInvoice1.getPurchaseInvoiceStatus());
        codaPurchaseInvoice__c pin = [select id, name, PaymentStatus__c from codaPurchaseInvoice__c where AccountInvoiceNumber__c  = :vendorInvoice];
        System.assert(pin.PaymentStatus__c==paymentStatus,'Error:invoice payment status should be in '+ paymentStatus +' status, Actual status is - '+pin.PaymentStatus__c);
    }
    
    /* Create and Post Purchase Invoice */
    public static void createAndPostPurchaseInvoice_2()
    {
        CODAUnitOfWork.getCurrent();
        CODATestIDMapExt.load(SUFFIX);
        String currentPeriod = CODAPeriodMapExt.getPeriodByDate(system.Date.today()).getName() + ':' + CODAPeriodMapExt.getPeriodByDate(system.Date.today()).getOwnerCompany().getName();
        /*Second Purchase invoice*/
        CODAPurchaseInvoiceTestHelper pInvoice2 = new CODAPurchaseInvoiceTestHelper();       
        pInvoice2.setAccount(CODATID013944Data.ACCOUNT_NAME);
        pInvoice2.setInvoiceDate(CODATID013944Data.invoiceDate);
        pInvoice2.setVendorInvoiceNumber(CODATID013944Data.VENDOR_INVOICE_NUM_2);
        pInvoice2.setInvoiceCurrency(CODABaseData.CURRENCYCODE_EUR+ ':' + CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN);
        pInvoice2.setPeriod(currentPeriod);        
        
        //product line
        {
            CODAPurchaseInvoiceTestHelper.ProductLineItem productLine = pInvoice2.newProductLine(CODATID013944Data.PRODUCT_NAME);
            productLine.setQuantity(CODATID013944Data.PRODUCT_QUANTITY);
            productLine.setUnitPrice(CODATID013944Data.PRODUCT_UNIT_PRICE);            
        }
        pInvoice2.setAccountInvoiceTotal(pInvoice2.getInvoiceTotal());        
         try
        {
        	pInvoice2.saveAndPost();
            pInvoice2.reload();
        }
        catch(Exception ex)
        {
            System.assert(false, 'Error: Exception in post operation for Invoice. Error Message:' + ex.getMessage());
        }
        
        CODATestIDMapExt.put(VENDOR_INVOICE_NUM_2,pInvoice2.getId());        
        CODATestIDMapExt.save(SUFFIX);
    }      
    
    /* Create and Post Purchase Invoice */
    public static void createAndPostPurchaseInvoice_3()
    {
        CODAUnitOfWork.getCurrent();
        CODATestIDMapExt.load(SUFFIX);
        String currentPeriod = CODAPeriodMapExt.getPeriodByDate(system.Date.today()).getName() + ':' + CODAPeriodMapExt.getPeriodByDate(system.Date.today()).getOwnerCompany().getName();
        /*Third Purchase invoice*/
        CODAPurchaseInvoiceTestHelper pInvoice3 = new CODAPurchaseInvoiceTestHelper();
        pInvoice3.setAccount(CODATID013944Data.ACCOUNT_NAME);
        pInvoice3.setInvoiceDate(CODATID013944Data.invoiceDate);
        pInvoice3.setVendorInvoiceNumber(CODATID013944Data.VENDOR_INVOICE_NUM_3);
        pInvoice3.setInvoiceCurrency(CODABaseData.CURRENCYCODE_EUR+ ':' + CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN);
        pInvoice3.setPeriod(currentPeriod);
        
        //product line
        {
            CODAPurchaseInvoiceTestHelper.ProductLineItem productLine = pInvoice3.newProductLine(CODATID013944Data.PRODUCT_NAME);
            productLine.setQuantity(CODATID013944Data.PRODUCT_QUANTITY);
            productLine.setUnitPrice(CODATID013944Data.PRODUCT_UNIT_PRICE);            
        }
        pInvoice3.setAccountInvoiceTotal(pInvoice3.getInvoiceTotal());        
         try
        {
        	pInvoice3.saveAndPost();
            pInvoice3.reload();
        }
        catch(Exception ex)
        {
            System.assert(false, 'Error: Exception in post operation for Invoice. Error Message:' + ex.getMessage());
        }
        
        CODATestIDMapExt.put(VENDOR_INVOICE_NUM_3,pInvoice3.getId());
        CODATestIDMapExt.save(SUFFIX);
    }
    
    //Retrieve Payments
    public static void retreivePayableInvoice(String paymentRef)
    {
        CODAContext.SetService(true);
        CODAUnitOfWork.getCurrent();
        CODATestIDMapExt.load(SUFFIX);
        CODAAccountingCurrency curr = CODAAccountingCurrencyMapper.getByNameInCurrentCompanies(CODABaseData.CURRENCYCODE_EUR)[0];
        CODAQuickPaymentTestHelper payment = new CODAQuickPaymentTestHelper();
        payment.setPaymentTypes(CODAPaymentExt.PAYMENT_TYPE_PAYMENTS);
        payment.setPaymentMediaTypes(CODAQuickPaymentService.PAYMENTMEDIATYPES_CHECK);
        payment.setPaymentDate(System.today());
        payment.setDueDate(System.today().addDays(60));
        payment.setBankAccount(CODABaseDataExt.NAMEBANKACC_SANTANDERCURRENTACCOUNT+ ':' + CODATID013944Data.COMPANY_NAME);
        payment.setSettlementDiscountReceived(CODABaseData.NAMEGLA_SETTLEMENTDISCOUNTSALLOWEDUS);
        payment.setCurrencyWriteOff(CODABaseData.NAMEGLA_WRITEOFFUS);
        payment.setPaymentMethod(CODATID013944Data.PAYMENT_METHOD_ELECTRONIC);
        payment.retrieveAccounts();
        
        CODATestIDMapExt.put(paymentRef, payment.getId());
        CODATestIDMapExt.save(SUFFIX);
    }
    
    /* Making payment for Payable Invoice */
    public static void payableInvoicePay(String paymentRef)
    {	
        CODAContext.setSystemTest(true);
        CODAUnitOfWork.getCurrent();
        CODATestIDMapExt.load(SUFFIX);
        CODAQuickPaymentTestHelper payment = new CODAQuickPaymentTestHelper(paymentRef);        
        List<CODAQuickPaymentTestHelper.AccountLineItem> accountsLine = payment.getAccountLineItems();       
        payment.pay();
    }
    
    /* Confirm payment for Payable Invoice.*/
    public static void payableInvoiceConfirmPay(String paymentRef)
    {
        CODAContext.setSystemTest(true);		
        CODAUnitOfWork.getCurrent();
        CODATestIDMapExt.load(suffix);
        CODAQuickPaymentTestHelper payment = new CODAQuickPaymentTestHelper(paymentRef);
        payment.confirmAndPay();
    }
    
    //Verify Converted Credit Note properties
    public static void verifyTST018550()
    {
        CODATestIDMapExt.load(SUFFIX);
        CODAPurchaseInvoiceTestHelper purchaseInvoice = new CODAPurchaseInvoiceTestHelper(CODATID013944Data.VENDOR_INVOICE_NUM_1);
        codaPurchaseCreditNote__c convertedId = [select id, CreditNoteStatus__c, CreditNoteTotal__c, PaymentStatus__c,
                                                 OutstandingValue__c,  AccountCreditNoteNumber__c from codaPurchaseCreditNote__c where AccountCreditNoteNumber__c =:CODATID013944Data.CREDIT_NOTE_1];
        CODATestIDMapExt.put(CODATID013944Data.CREDIT_NOTE_1,convertedId.id);
        CODATestIDMapExt.save(CODATID013944Data.SUFFIX);
        
        CODAPurchaseCreditNoteTestHelper creditNote1 = new CODAPurchaseCreditNoteTestHelper(CODATID013944Data.CREDIT_NOTE_1);
        System.assert(convertedId.CreditNoteStatus__c == CODAPurchaseCreditNote.CREDITNOTESTATUS_INPROGRESS,'Error: Purchase Credit Note should be in ' + CODAPurchaseCreditNote.CREDITNOTESTATUS_INPROGRESS+ ' status, Actual status is - '+ convertedId.CreditNoteStatus__c);           
        System.assert(convertedId.PaymentStatus__c ==CODATID013944Data.PAYMENTSTATUS_NOT_APPLICABLE, 'Error: Purchase Credit Note payment should be - Not Applicable status, Actual status is ' + convertedId.PaymentStatus__c);
        System.assert(convertedId.OutstandingValue__c == 0.0, 'Error: Outstanding value should be 0.0. Actual found is ' + convertedId.OutstandingValue__c);
        System.assert(CODAFormatter.decimalToString(convertedId.CreditNoteTotal__c)== purchaseInvoice.getInvoiceTotal(), 'Error: CreditNote total should be ' + purchaseInvoice.getInvoiceTotal() + '. Actual Total is: ' + convertedId.CreditNoteTotal__c);         	
        System.assert(creditNote1.getMatchedPayments()==null, 'Error: There should be no matched value. Actual found is ' + creditNote1.getMatchedPayments());
    }
    
    //Verify Converted Credit Note properties
    public static void verifyTST018551()
    {
        CODATestIDMapExt.load(SUFFIX);
        CODAPurchaseInvoiceTestHelper purchaseInvoice = new CODAPurchaseInvoiceTestHelper(CODATID013944Data.VENDOR_INVOICE_NUM_2);
        codaPurchaseCreditNote__c convertedId = [select id,CreditNoteStatus__c, PaymentStatus__c, OutstandingValue__c, 
                                                 AccountCreditNoteNumber__c,CreditNoteTotal__c from codaPurchaseCreditNote__c where AccountCreditNoteNumber__c =:CODATID013944Data.CREDIT_NOTE_2];
        CODATestIDMapExt.put(CODATID013944Data.CREDIT_NOTE_2, convertedId.Id);            
        CODAPurchaseCreditNoteTestHelper creditNote = new CODAPurchaseCreditNoteTestHelper(CODATID013944Data.CREDIT_NOTE_2);
        
        System.assert(convertedId.CreditNoteStatus__c == CODAPurchaseCreditNote.CREDITNOTESTATUS_INPROGRESS,'Error: Purchase Credit Note should be in ' + CODAPurchaseCreditNote.CREDITNOTESTATUS_INPROGRESS+ ' status, Actual status is - '+ convertedId.CreditNoteStatus__c);           
        System.assert(convertedId.PaymentStatus__c ==CODATID013944Data.PAYMENTSTATUS_NOT_APPLICABLE, 'Error: Purchase Credit Note payment should be - Not Applicable status, Actual status is ' + convertedId.PaymentStatus__c);
        System.assert(convertedId.OutstandingValue__c == 0.0, 'Error: Outstanding value should be 0.0. Actual found is ' + convertedId.OutstandingValue__c);
        System.assert(CODAFormatter.decimalToString(convertedId.CreditNoteTotal__c)== purchaseInvoice.getInvoiceTotal(), 'Error: CreditNote total should be ' + purchaseInvoice.getInvoiceTotal() + '. Actual Total is: ' + convertedId.CreditNoteTotal__c);
        System.assert(creditNote.getMatchedPayments()==null, 'Error: There should be no matched value. Actual found is ' + creditNote.getMatchedPayments());
    }
    
    //Verify Converted Credit Note properties
    public static void verifyTST018553()
    {
        CODATestIDMapExt.load(SUFFIX);
        CODAPurchaseInvoiceTestHelper purchaseInvoice = new CODAPurchaseInvoiceTestHelper(CODATID013944Data.VENDOR_INVOICE_NUM_3);
        codaPurchaseCreditNote__c convertedId = [select id,CreditNoteStatus__c, PaymentStatus__c, OutstandingValue__c, 
                                                     AccountCreditNoteNumber__c,CreditNoteTotal__c from codaPurchaseCreditNote__c where AccountCreditNoteNumber__c =:CODATID013944Data.CREDIT_NOTE_3];
        CODATestIDMapExt.put(CODATID013944Data.CREDIT_NOTE_3, convertedId.Id);        
        CODAPurchaseCreditNoteTestHelper creditNote = new CODAPurchaseCreditNoteTestHelper(CODATID013944Data.CREDIT_NOTE_3);
        
        System.assert(convertedId.CreditNoteStatus__c == CODAPurchaseCreditNote.CREDITNOTESTATUS_INPROGRESS,'Error: Purchase Credit Note should be in ' + CODAPurchaseCreditNote.CREDITNOTESTATUS_INPROGRESS+ ' status, Actual status is - '+ convertedId.CreditNoteStatus__c);           
        System.assert(convertedId.PaymentStatus__c ==CODATID013944Data.PAYMENTSTATUS_NOT_APPLICABLE, 'Error: Purchase Credit Note payment should be - Not Applicable status, Actual status is ' + convertedId.PaymentStatus__c);
        System.assert(convertedId.OutstandingValue__c == 0.0, 'Error: Outstanding value should be 0.0. Actual found is ' + convertedId.OutstandingValue__c);
        System.assert(CODAFormatter.decimalToString(convertedId.CreditNoteTotal__c)== purchaseInvoice.getInvoiceTotal(), 'Error: CreditNote total should be ' + purchaseInvoice.getInvoiceTotal() + '. Actual Total is: ' + convertedId.CreditNoteTotal__c);
        System.assert(creditNote.getMatchedPayments()==null, 'Error: There should be no matched value. Actual found is ' + creditNote.getMatchedPayments());    
    }
    
    public static void destroyData()
    {
        CODAContext.enableSupportAccess();
        CODAUnitOfWork.createAndSetCurrent();
        
        Id userId = [Select Id from User where alias=:CODATID013944Data.STANDARD_USER_ALIAS][0].id;        
        List<PermissionSet> permissionSetRecords = [Select ID from PermissionSet WHERE NAME in ('AccountingPayableInvoiceCreditNote','AccountingPayableInvoicePost', 'AccountingandBillingSelectCompany', 'AccountingandBillingUserCompanies', 'AccountingandBillingStandard')];
        List<PermissionSetAssignment> permissionSetAssignmentList;
        for(PermissionSet permissionSetRecord: permissionSetRecords)
            permissionSetAssignmentList = [select Id from PermissionSetAssignment where AssigneeId=:userId and PermissionSetId= :permissionSetrecord.Id];            
        
        delete permissionSetAssignmentList; 
    }
    
    public static void destroyDataExt1()
    {
        CODAContext.enableSupportAccess();
        CODAUnitOfWork.createAndSetCurrent();
        
        final CODAGeneralLedgerAccount accountPayableControlEUR = CODAGeneralLedgerAccountMapper.getByName(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLEUR).get(0);        
        final CODABankAccount santanderCurrentBankAccount= CODAPaymentData.clearBankAccountByName(CODABaseDataExt.NAMEBANKACC_SANTANDERCURRENTACCOUNT);
        final CODAAccount bmwAutoAccount = CODAPaymentData.clearAccountByName(CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES, accountPayableControlEUR, null);
        CODAUnitOfWork.getCurrent().commitWork();
        CODAPaymentData.destroyPaymentData(SUFFIX);        
    }
        
    public static void loadMap()
    {
        //Account
        for (Account acc : [SELECT Id, Name FROM Account WHERE  MirrorName__c = :CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES])
        {
            CODATestIDMapExt.put(acc.Name, acc.id); 
        }	
        //Product
        for (Product2 item : [Select Id, Name from Product2 where Name = :CODABaseDataExt.NAMEPRODUCT_AUTO1COMCLUTCH])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }
        
        // Company
        CODACompany company = CODACompanyMapExt.getCurrentCompany();
        Id compId = company.getId();
        
        // Years for Merlin Auto Spain
        for (codaPeriod__c period : [Select Id, Name, OwnerCompany__r.Name from codaPeriod__c where OwnerCompany__c = :compId])
        {
            CODATestIDMapExt.put(period.Name + ':' + period.OwnerCompany__r.Name, period.id);
        }
        
        // Bank Accounts
        Set<String> bankNames = new Set<String>();
        bankNames.add(CODABaseDataExt.NAMEBANKACC_SANTANDERCURRENTACCOUNT);	
        for (codaBankAccount__c item : [Select Id, Name, OwnerCompany__r.Name from codaBankAccount__c ])
        {
            CODATestIDMapExt.put(item.Name + ':' + item.OwnerCompany__r.Name, item.id);
        } 
        
        // Periods for Merlin Auto Spain
        for (codaYear__c year : [Select Id, Name, OwnerCompany__r.Name from codaYear__c where OwnerCompany__c = :compId])
        {
            CODATestIDMapExt.put(year.Name + ':' + year.OwnerCompany__r.Name, year.id);
        }
        
        // Currencies for Merlin Auto spain
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
        
        //GLA
        Set<String> glaNames = new Set<String>();
        glaNames.add(CODABaseData.NAMEGLA_WRITEOFFUS);
        glaNames.add(CODABaseData.NAMEGLA_SETTLEMENTDISCOUNTSALLOWEDUS);
        
        for (CODAGeneralLedgerAccount__c item : [Select Id, Name from CODAGeneralLedgerAccount__c where Name in :glaNames])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }
        
        CODATestIDMapExt.save(SUFFIX);        
    }
}