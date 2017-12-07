/*
* FinancialForce.com, inc. claims copyright in this software, its screen display designs and 
* supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc. 
* Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may 
* result in criminal or other legal proceedings. 
*
* Copyright FinancialForce.com, inc. All rights reserved. 
*/
public class CODATID013701Data {
    
    public static string ACCOUNT_CAMBRIDGE_AUTO = 'Cambridge Auto';
    public static string ACCOUNT_CAMBRIDGE1_AUTO = 'Cambridge1 Auto';
    public static String COMPANY_NAME = CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN;
    public static String SUFFIX = '#CODATID013701';
    public static string EXTERNAL_ID_FOR_PAYMENT = 'PAY00001';
    public static String CHECK_RANGE_NAME = 'CHR001';
    public static integer LINEITEM_QUANTITY =1;
    public static integer UNITPRICE = 10;
   
    
    public static void switchProfile() 
    {
        Id userId = CODABaseData.getProfile(CODABaseData.ACCOUNTANT).Id;
        CODABaseData.switchCurrentCompany(COMPANY_NAME, true, false, userId);
    }
    
    public static void selectCompany()
    {              
        CODABaseData.switchCurrentCompany(COMPANY_NAME, true, true, UserInfo.getUserId());
    }
    //Load prerequistics
    public static void createData()
    {
        loadmap();        
    }

     //Create and POST sales Invoices
    public static void createSalesInvoiceSaveAndPost(string accountName)
    {
        CODAContext.SetService(true); 
        CODAUnitOfWork.getCurrent();
        CODATestIDMapExt.load(SUFFIX);
        
        Date invoiceDate= System.today();
        string currentPeriodName = CODAPeriodMapExt.getPeriodByDate(invoiceDate).getName() + ':' + COMPANY_NAME;
        CODAInvoiceTestHelper sinv1 = new CODAInvoiceTestHelper();
        sinv1.setAccount(accountName);
        sinv1.setInvoiceCurrency(CODABaseData.CURRENCYCODE_EUR);
        sinv1.setPeriod(currentPeriodName); 
        sinv1.setCustomerReference('SINV1');
        sinv1.setInvoiceDate(invoiceDate);
        CODAInvoiceTestHelper.LineItem sinv1Line = sinv1.newLine();
        sinv1Line.setProduct(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
        sinv1Line.setUnitPrice(150);
        sinv1Line.setQuantity(1);
        sinv1Line.setTaxCode1(CODABaseDataExt.NAMETAXCODE_VOSTDSALES); 
        sinv1Line.setTaxValue1(26.25);
        sinv1.saveAndPost();        
    }
    
    //Create a Check Range for 'Santander current account' Bank Account
    public static void CreateCheckRange()
    {
        CODAContext.SetService(true); 
        CODAUnitOfWork.getCurrent();
        CODATestIDMapExt.load(SUFFIX);
        CODABankAccount santanderCurrAccount = CODABankAccountMapper.getByName(CODABaseDataExt.NAMEBANKACC_SANTANDERCURRENTACCOUNT)[0];
        CODACheckRange checkRange = new CODACheckRange();
        checkRange.setCheckRangeName(CHECK_RANGE_NAME);
        checkRange.setBankAccount(santanderCurrAccount);
        checkRange.setStartCheckNumber('000001');
        checkRange.setLastCheckNumber('000100');
        CODAUnitOfWork.getCurrent().commitWork();   
        CODATestIDMapExt.put(CHECK_RANGE_NAME, checkRange.getId());
        CODATestIDMapExt.save(SUFFIX);
    }
    
    //Create a payment and retrieve accounts 
    public static void createPaymentAndRerieveAccounts()
    {
        CODAContext.SetService(true); 
        CODAUnitOfWork.getCurrent();
        CODATestIDMapExt.load(SUFFIX);
        
       	CODAQuickPaymentTestHelper payment = new CODAQuickPaymentTestHelper();
		payment.setBankAccount(CODABaseDataExt.NAMEBANKACC_SANTANDERCURRENTACCOUNT + ':' + CODATID013701Data.COMPANY_NAME);
        payment.setPaymentTypes(CODAPaymentExt.PAYMENT_TYPE_COLLECTIONS);
        payment.setPaymentMediaTypes(CODAQuickPaymentService.PAYMENTMEDIATYPES_CHECK);
        payment.setSettlementDiscountReceived(CODABaseData.NAMEGLA_SETTLEMENTDISCOUNTSALLOWEDUS);
        payment.setCurrencyWriteOff(CODABaseData.NAMEGLA_WRITEOFFUS);
        payment.setPaymentDate(System.today());
        payment.setDueDate(System.today().addDays(60));
        payment.retrieveAccounts();
        CODAUnitOfWork.getCurrent().commitWork();       
        CODATestIDMapExt.put(EXTERNAL_ID_FOR_PAYMENT, payment.getId());
        CODATestIDMapExt.save(SUFFIX);        
    }
    
    public static void destroyData()
    {
        CODAUnitOfWork.createAndSetCurrent();
        CODAContext.enableSupportAccess(); 
        CODAPaymentData.destroyPaymentData(SUFFIX);
        List<codaCheckRange__c> checkRange= [SELECT Id, Name FROM codaCheckRange__c WHERE Name =:CHECK_RANGE_NAME];
        CODAContext.disableSupportAccess();
        CODATestIDMapExt.purge(SUFFIX);
    }
     
    // put prerequistics values in map
    public static void loadMap()
    {        
        //Company
        CODACompany company = CODACompanyMapExt.getCurrentCompany();
        Id compId = company.getId();
        
        //Load Multiples Companies
        Set<String> companyNames = new Set<String>();
        companyNames.add(COMPANY_NAME);        
        for (codaCompany__c companyName : [Select Id, Name From codaCompany__c where Name in :companyNames])
        {
            CODATestIDMapExt.put(companyName.Name, companyName.id);
        }
        
        // Period for Merlin Auto Spain
        for (codaPeriod__c period : [Select Id, Name, OwnerCompany__r.Name from codaPeriod__c where OwnerCompany__c = :compId])
        {
            CODATestIDMapExt.put(period.Name + ':' + period.OwnerCompany__r.Name, period.id);
        }
        
        // Currencies for Merlin Auto Spain
        for (codaAccountingCurrency__c accCurr : [Select Id, Name, OwnerCompany__r.Name from codaAccountingCurrency__c where OwnerCompany__c  = :compId])
        {
            CODATestIDMapExt.put(accCurr.Name + ':' + accCurr.OwnerCompany__r.Name, accCurr.id);
        }
        
        // Accounts
        Set<String> accNames = new Set<String>();
        accNames.add(CODABaseDataExt.NAMEACCOUNT_CAMBRIDGE1AUTO);  
        accNames.add(CODABaseDataExt.NAMEACCOUNT_CAMBRIDGEAUTO);     
        for (Account accId : [Select Id, Name from Account where MirrorName__c in :accNames])
        {
            CODATestIDMapExt.put(accId.Name, accId.id);
        }
        
        // Product
        Set<String> prodNames = new Set<String>();
        prodNames.add(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
        prodNames.add(CODABaseDataExt.NAMEPRODUCT_DELLPC);
        for(Product2 item : [Select Id, Name from Product2 where Name in :prodNames])
        {
            CODATestIDMapExt.put(item.Name, item.Id);
        }
        
         // GLAs
        Set<String> glaNames = new Set<String>();
        glaNames.add(CODABaseData.NAMEGLA_WRITEOFFUK);
        glaNames.add(CODABaseData.NAMEGLA_SETTLEMENTDISCOUNTSALLOWEDUK);
        glaNames.add(CODABaseData.NAMEGLA_WRITEOFFUS);
        glaNames.add(CODABaseData.NAMEGLA_SETTLEMENTDISCOUNTSALLOWEDUS);
        glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLEUR);
        glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLUSD);		
        glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD);
        glaNames.add(CODABaseData.NAMEGLA_POSTAGEANDSTATIONERY);
        
        for (CODAGeneralLedgerAccount__c item : [Select Id, Name from CODAGeneralLedgerAccount__c where Name in :glaNames])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }
        
        // Tax Codes
        Set<String> taxNames = new Set<String>();
        taxNames.add(CODABaseDataExt.NAMETAXCODE_VOSTDSALES);
        taxNames.add(CODABaseDataExt.NAMETAXCODE_VOSTDPURCHASE);
        taxNames.add(CODABaseDataExt.NAMETAXCODE_VOECPURCHASE);
        taxNames.add(CODABaseDataExt.NAMETAXCODE_VOS);
        taxNames.add(CODABaseDataExt.NAMETAXCODE_STATETAXCODESUT);
        taxNames.add(CODABaseDataExt.NAMETAXCODE_COUNTRYTAXCODESUT);
        taxNames.add(CODABaseDataExt.NAMETAXCODE_CITYTAXCODESUT);
        for (codaTaxCode__c item : [Select Id, Name from codaTaxCode__c where Name in :taxNames])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }
        
        // Bank Accounts
        Set<String> bankNames = new Set<String>();
        bankNames.add(CODABaseDataExt.NAMEBANKACC_SANTANDERCURRENTACCOUNT);     
        for (codaBankAccount__c item : [Select Id, Name, OwnerCompany__r.Name from codaBankAccount__c ])
        {
            CODATestIDMapExt.put(item.Name + ':' + item.OwnerCompany__r.Name, item.id);
        } 
        
        // Dimension 1
        for (codaDimension1__c dim1 : [select id, name from codaDimension1__c])
        {
            CODATestIDMapExt.put(dim1.Name, dim1.id);           
        }
        
        // Dimension 2
        for (codaDimension2__c dim2 : [select id, name from codaDimension2__c])
        {
            CODATestIDMapExt.put(dim2.Name, dim2.id);           
        }
        
        // Dimension 3
        for (codaDimension3__c dim3 : [select id, name from codaDimension3__c])
        {
            CODATestIDMapExt.put(dim3.Name, dim3.id);           
        }
        
        // Dimension 4
        for (codaDimension4__c dim4 : [select id, name from codaDimension4__c])
        {
            CODATestIDMapExt.put(dim4.Name, dim4.id);           
        } 
        
        // VAT Product Dim 1-GBP-
        for (Product2 item1 : [Select Id, Name from Product2 where Name like 'SUT_PROD_%'])
        {
            CODATestIDMapExt.put(item1.Name, item1.id);
        }
        
        CODATestIDMapExt.save(SUFFIX);      
    }
}
