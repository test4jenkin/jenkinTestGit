public class CODATID004545Data {
    
    public static String SUFFIX = '#TID004545';
    public static string ACCOUNT_NAME = 'VEND0001';
    public static string VAT_REGISTRATION_NUM = 'FR987987987';
    public static string BANK_NAME = 'Barclays Bank';
    public static string BANK_SORT_CODE = 'HO1234';
    public static string BANK_ACCOUNT_NUMBER = '50012345';
    public static string BANK_ACCOUNT_REFERENCE = 'BARC874588567';
    public static string BANK_SWIFT_NUMBER = 'BARCUKTAMA3';
    public static string Bank_IBAN_Number = 'GBkk BARC';
    public static string BANK_STREET = 'Street Name';
    public static string BANK_ZIP_POSTAL_CODE = '18008';
    public static string BANK_CITY = 'Granada';
    public static string BANK_STATE_PROVINCE = 'Granada';
    public static string BANK_COUNTRY = 'Spain';
    public static string BANK_FAX = '123456';
    public static string BANK_PHONE = '654321';
    public static string CREDIT_STATUS_ALLOWED = 'Credit Allowed';
    public static string PAYMENT_METHOD_ELECTRONIC = 'Electronic';
    public static string DESCRIPTION_1 = 'Standard Terms';
    public static string BASE_DATE_1 = 'Invoice Date';
    public static Decimal DAYS_OFFSET_1 = 5;
    public static Decimal DISCOUNT_1 = 10;
    public static string DESCRIPTION_2 = 'Optional Terms';
    public static string BASE_DATE_2 = 'End of Next Month';
    public static Decimal DAYS_OFFSET_2 = 5;
    public static Decimal DISCOUNT_2 = 3;      
    public static Decimal LINEITEM_QUANTITY=1;
    public static String COMPANY_NAME = CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN;
    public static Decimal UNITPRICE=189.43;
    public static decimal INVOICE_TOTAL = 222.58;
    public static decimal TAX_VALUE = 33.15;
    public static string TAX_CODE = CODABaseDataExt.NAMETAXCODE_VOSTDPURCHASE ;
    public static string SAVE = 'SAVE';
    public static Date CURRENTDATE = System.today();
    public static string PURCHASEINVOICE1 ='VIN_123_';
    public static string CURRENCY_CODE = CODABaseData.CURRENCYCODE_EUR + ':' +  COMPANY_NAME;
    public static string UNIQUE_PAYMENT_ID = 'TID004545PAYMENT2';
    
    /**
	* select the current company
	*/
    public static void selectCompany()
    {
        CODABaseData.switchCurrentCompany(COMPANY_NAME, true, true, userinfo.getUserId());
    }
    
    public static void switchProfile()
    {
        Id userId = CODABaseData.getProfile(CODABaseData.ACCOUNTANT).Id;
        CODABaseData.switchCurrentCompany(COMPANY_NAME, true, false, userId);
    }
    
    /*Create Account Data for Payable Invoice*/
    public static void createData()
    {        
        loadMap();
        CODAUnitOfWork.createAndSetCurrent(); 
        CreateAccount();
        CODATestIDMapExt.save(SUFFIX);	
    }
    
    //Create Account with necessary parameters
    static void createAccount()
    {        
        codaGeneralLedgerAccount__c glaAcctReceivable = [Select Id, Name from codaGeneralLedgerAccount__c Where Name =: CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD][0];
        codaGeneralLedgerAccount__c glaAcctPayable = [Select Id, Name from  codaGeneralLedgerAccount__c Where Name =: CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLEUR][0];
        codaGeneralLedgerAccount__c glaPostageStationary  =  [Select Id, Name  from codaGeneralLedgerAccount__c Where Name =: CODABaseData.NAMEGLA_POSTAGEANDSTATIONERY][0];
        codaTaxCode__c taxCodeInput = [SELECT ID from codaTaxCode__c WHERE Name=:CODABaseDataExt.NAMETAXCODE_VOSTDSALES];
        codaTaxCode__c taxCodeOutput = [SELECT ID from codaTaxCode__c WHERE Name=:CODABaseDataExt.NAMETAXCODE_VOSTDPURCHASE];
        
        Account acct = new Account(Name=ACCOUNT_NAME, 
                                   CODAAccountsReceivableControl__c = glaAcctReceivable.Id,
                                   CODAAccountsPayableControl__c=glaAcctPayable.Id,   
                                   CODADefaultExpenseAccount__c= glaPostageStationary.id, 
                                   CODASalesTaxStatus__c = CODAAccount.SALESTAXSTATUS_TAXABLE,
                                   CurrencyIsoCode=CODaBaseData.CURRENCYCODE_GBP,                   					 	
                                   CODAAccountTradingCurrency__c = CODaBaseData.CURRENCYCODE_GBP,
                                   CODAECCountryCode__c=CODAAccount.ECCOUNTRYCODE_FR,   
                                   CODAInputVATCode__c=taxCodeInput.Id, 
                                   CODAOutputVATCode__c=taxCodeInput.Id,   
                                   CODATaxCalculationMethod__c=CODAAccount.TAXCALCULATIONMETHOD_GROSS,   
                                   CODAVATRegistrationNumber__c=VAT_REGISTRATION_NUM,                                            	
                                   CODABankName__c=BANK_NAME,   
                                   CODABankAccountName__c=CODABaseDataExt.NAMEBANKACC_BARCLAYSEUROSACCOUNT,   
                                   CODABankAccountNumber__c=BANK_ACCOUNT_NUMBER,   
                                   CODABankSWIFTNumber__c=BANK_SWIFT_NUMBER,   
                                   CODABankAccountReference__c=BANK_ACCOUNT_REFERENCE,   
                                   CODABankIBANNumber__c=Bank_IBAN_Number,   
                                   CODABankSortCode__c=BANK_SORT_CODE,   
                                   CODABankStreet__c = BANK_STREET ,
                                   CODABankZipPostalCode__c = BANK_ZIP_POSTAL_CODE , 
                                   CODABankStateProvince__c = Bank_State_Province,
                                   CODABankCity__c =BANK_CITY,
                                   CODABankCountry__c =BANK_COUNTRY,
                                   CODABankFax__c =BANK_FAX, 
                                   CODABankPhone__c = BANK_PHONE,
                                   CODACreditStatus__c = CREDIT_STATUS_ALLOWED,
                                   CODAPaymentMethod__c=PAYMENT_METHOD_ELECTRONIC,   
                                   CODADescription1__c=DESCRIPTION_1,   
                                   CODABaseDate1__c=BASE_DATE_1,   
                                   CODADaysOffset1__c=DAYS_OFFSET_1,   
                                   CODADiscount1__c=DISCOUNT_1,   
                                   CODADescription2__c=DESCRIPTION_2,   
                                   CODABaseDate2__c=BASE_DATE_2,   
                                   CODADaysOffset2__c=DAYS_OFFSET_2,   
                                   CODADiscount2__c=DISCOUNT_2);
        insert acct;
        CODATestIDMapExt.put(ACCOUNT_NAME , acct.Id); 
    }
    
    //Create Payable invoice with Line Item data Item
    public static void CreatePayableInvoices(Integer numberOfInvoices , Integer numberOfProductLineItems, string invoicePrefix)
    {
        CODAUnitOfWork.getCurrent();
        CODATestIDMapExt.load(SUFFIX);
        string currentPeriodName = CODAPeriodMapExt.getPeriodByDate(CURRENTDATE).getName() + ':' + COMPANY_NAME;
        
        // Purchase Invoices
        List <CODAAPIPurchaseInvoiceTypes_9_0.PurchaseInvoice> pinvList = new List <CODAAPIPurchaseInvoiceTypes_9_0.PurchaseInvoice>();
      
            for (Integer i=1; i<=numberOfInvoices; i++)
            {
                CODAAPIPurchaseInvoiceTypes_9_0.PurchaseInvoice pinv = new CODAAPIPurchaseInvoiceTypes_9_0.PurchaseInvoice();
                pinv.Account = CODAAPICommon.getRef(CODATestIDMap.resolve(ACCOUNT_NAME), null);
                pinv.InvoiceCurrency = CODAAPICommon.getRef(CODATestIDMap.resolve(CURRENCY_CODE), null);
                pinv.OwnerCompany = CODAAPICommon.getRef(CODATestIDMap.resolve(COMPANY_NAME), null);
                pinv.AccountInvoiceNumber = invoicePrefix+i;
                pinv.InvoiceDate = CURRENTDATE;
                pinv.DueDate= CURRENTDATE+5;
                pinv.Period = CODAAPICommon.getRef(CODATestIDMap.resolve(currentPeriodName), null);
                pinv.InvoiceTotal = INVOICE_TOTAL;
                    
                pinv.LineItems = new CODAAPIPurchaseInvoiceLineItemTypes_9_0.PurchaseInvoiceLineItems();
                pinv.LineItems.LineItemList = new List<CODAAPIPurchaseInvoiceLineItemTypes_9_0.PurchaseInvoiceLineItem>();
                
                for (Integer k=1; k<=numberOfProductLineItems; k++)
                {
                    CODAAPIPurchaseInvoiceLineItemTypes_9_0.PurchaseInvoiceLineItem lineItem = new CODAAPIPurchaseInvoiceLineItemTypes_9_0.PurchaseInvoiceLineItem();
                    lineItem.Product = CODAAPICommon.getRef(CODATestIDMap.resolve(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH),null);
                    lineItem.Quantity = LINEITEM_QUANTITY;
                    lineItem.UnitPrice = UNITPRICE;
                    lineItem.InputVATCode = CODAAPICommon.getRef(CODATestIDMap.resolve(TAX_CODE),null);
                    lineItem.TaxValue1 = TAX_VALUE;
                    pinv.LineItems.LineItemList.add(lineItem);
                }
                pinvList.add(pinv);
            }        
        // Create
        List<CODAAPICommon.Reference> refInvCreate = CODAAPIPurchaseInvoice_9_0.BulkCreatePurchaseInvoice(null, pinvList);           	
    }
    
    //Post Purchase Invoices
    public static void postPurchaseInvoices(Integer numOfInvoice)
    {
        //CODAContext.SetService(true); 
        CODAUnitOfWork.getCurrent();
        CODATestIDMapExt.load(SUFFIX);     
        CODAAPICommon_9_0.Context context = new CODAAPICommon_9_0.Context();
        context.token = getAPIToken();
        List<CODAAPICommon.Reference> invoiceRefList = new List<CODAAPICommon.Reference>();
        List<codaPurchaseInvoice__c> invoicelist = [Select Id,Name from codaPurchaseInvoice__c where InvoiceStatus__c = :CODAPurchaseInvoice.INVOICESTATUS_INPROGRESS limit :numOfInvoice];
        
        for (codaPurchaseInvoice__c purchaseInvoice: invoicelist)
        {
            CODAAPICommon.Reference ref = CODAAPICommon.getRef(purchaseInvoice.Id, purchaseInvoice.Name);
            invoiceRefList.add(ref);
            System.debug('IN INVOICE LIST - '+purchaseInvoice);
        }
        
        CODAAPIPurchaseInvoice_9_0.BulkPostPurchaseInvoice(context,invoiceRefList);
        System.debug('POSTING COMPLETED of size- '+invoiceRefList.size());
    } 
    
    //Get API Token
    public static string getAPIToken() 
    {
        return EncodingUtil.convertToHex(Crypto.generateDigest('SHA1',Blob.valueOf('0000000000000000C000000000000046' + UserInfo.getUserId() + 'PROBABLEMENTE EL MEJOR SOFTWARE DE CONTABILIDAD EN EL MUNDO')));
    }    
    
    public static void loadMap()
    {
        // Company
        CODACompany company = CODACompanyMapExt.getCurrentCompany();
        Id compId = company.getId();
        
        CODATestIDMapExt.put(company.getName(), compId);
        
        // Periods for Merlin Auto Spain
        for (codaPeriod__c period : [Select Id, Name, OwnerCompany__r.Name from codaPeriod__c where OwnerCompany__c = :compId])
        {
            CODATestIDMapExt.put(period.Name + ':' + period.OwnerCompany__r.Name, period.id);
        }
        // Accounts
        Set<String> accNames = new Set<String>();
        accNames.add(CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO);
        accNames.add(CODABaseDataExt.NAMEACCOUNT_AUDI);        
        for (Account accId : [Select Id, Name from Account where MirrorName__c in :accNames])
        {
            CODATestIDMapExt.put(accId.Name, accId.id);
        }
        // Currencies for Merlin Auto Spain
        for (codaAccountingCurrency__c accCurr : [Select Id, Name, OwnerCompany__r.Name from codaAccountingCurrency__c where OwnerCompany__c  = :compId])
        {
            CODATestIDMapExt.put(accCurr.Name + ':' + accCurr.OwnerCompany__r.Name, accCurr.id);
        }     
        
        //For Products
        for (Product2  item : [Select Id, Name from Product2  where Name = :CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }
        
        Set<String> taxNames = new Set<String>();
        taxNames.add(CODABaseDataExt.NAMETAXCODE_VOSTDPURCHASE);
        for (codaTaxCode__c item : [Select Id, Name from codaTaxCode__c])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }
        
        for (codaBankAccount__c item : [Select Id, Name,OwnerCOmpany__r.name from codaBankAccount__c where Name ='Santander Current Account'])
        {
            CODATestIDMapExt.put(item.Name+':'+item.OwnerCompany__r.name, item.id);
        }
        
        for (CODAGeneralLedgerAccount__c item : [Select Id, Name from CODAGeneralLedgerAccount__c])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }
        
        CODATestIDMapExt.save(SUFFIX);
    } 
    
     // Delete Transaction Line Items
    public static void destroyData()
    {
        CODAContext.enableSupportAccess();
        CODAVolumeDataDestroy.updateAndDeleteTransactionLineItems(3000);
    }
    
    // Delete Transaction Line Items
    public static void destroyDataExt1()
    {
		CODAContext.enableSupportAccess();
        CODAVolumeDataDestroy.updateAndDeleteTransactionLineItems(3000);
    }
    
    // Delete Transaction Line Items
    public static void destroyDataExt2()
    {
		CODAContext.enableSupportAccess();
        CODAVolumeDataDestroy.updateAndDeleteTransactionLineItems(4000);
    }
    
    // Delete Transaction Entity
    public static void destroyDataExt3()
    {
		CODAContext.enableSupportAccess();
        CODAVolumeDataDestroy.updateAndDeleteTransactionEntity(3500);
    }
    
    //Delete Payament Line Items
    public static void destroyDataExt4()
    {
		CODAContext.enableSupportAccess();
        CODAVolumeDataDestroy.updateAndDeletePaymentLineItem(3500);
    }
    
    //Delete Payment batch Line Items
    public static void destroyDataExt5()
    {
        CODAContext.enableSupportAccess();
        DELETE [Select Id from codaPaymentBatchLineItem__c ];
    }    
    
    //Delete Payament Media Details
    public static void destroyDataExt6()
    {
		CODAContext.enableSupportAccess();
        CODAVolumeDataDestroy.updateAndDeletePaymentMediaDetail(3500);
    }
    //Delete Payment Entity
    public static void destroyDataExt7()
    {
		CODAContext.enableSupportAccess();
        CODAVolumeDataDestroy.updateAndDeletePaymentEntity(5);
    }
    
    //Delete Payable Invoice line Items   
    public static void destroyDataExt8()
    {
		CODAContext.enableSupportAccess();
        CODAVolumeDataDestroy.updateAndDeletePayableInvoiceLineItems(4500);
    }   
    
    //Delete Payable Invoice Entity
    public static void destroyDataExt9()
    {
		CODAContext.enableSupportAccess();
        CODAVolumeDataDestroy.updateAndDeletePayableInvoiceEntity(3500);
    }
    
    /**
	* Destroy the data created by createData
	*/
    public static void destroyDataExt10()
    {   
        CODATestIDMapExt.load(SUFFIX);
        CODAContext.enableSupportAccess();
        CODAPaymentData.destroyPaymentData(SUFFIX);
        delete [SELECT ID, NAME from Account WHERE MirrorName__c= :ACCOUNT_NAME];
        CODATestIDMapExt.purge(SUFFIX);      
    }
}
