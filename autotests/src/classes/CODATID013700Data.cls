/*
* FinancialForce.com, inc. claims copyright in this software, its screen display designs and 
* supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc. 
* Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may 
* result in criminal or other legal proceedings. 
*
* Copyright FinancialForce.com, inc. All rights reserved. 
*/
public class CODATID013700Data 
{
    public static String COMPANY_NAME = CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN;
    public static String SUFFIX = '#CODATID013700';
    public static string EXTERNAL_ID_FOR_PAYMENT = 'PAY00001';
    public static String CHECK_RANGE_NAME = 'CHR001';
    public static integer LINEITEM_QUANTITY =1;
    public static decimal UNITPRICE = 89.40;
    public static string INVOICE_TOTAL = '105.05';
    public static string TAX_VALUE = '15.65';
    
   
    
    public static void switchProfile() 
    {
        Id userId = CODABaseData.getProfile(CODABaseData.ACCOUNTANT).Id;
        CODABaseData.switchCurrentCompany(COMPANY_NAME, true, false, userId);
    }
    
    public static void selectCompany()
    {              
        CODABaseData.switchCurrentCompany(COMPANY_NAME, true, true, UserInfo.getUserId());
    }
    //Load map prerequistics
    public static void createData()
    {
        loadmap();          
    }

     //Create and POST payable Invoices
    public static void createPurchaseInvoiceSaveAndPost(string accountName)
    {
        Date invoiceDate= System.today();
        string currentPeriodName = CODAPeriodMapExt.getPeriodByDate(invoiceDate).getName() + ':' + COMPANY_NAME;
        
        CODAContext.SetService(true); 
        CODAUnitOfWork.getCurrent();
        CODATestIDMapExt.load(SUFFIX);
        
        CODAPurchaseInvoiceTestHelper purchaseInvoice = new CODAPurchaseInvoiceTestHelper();
        purchaseInvoice.setAccount(accountName);
        purchaseInvoice.setInvoiceCurrency(CODABaseData.CURRENCYCODE_EUR+':'+COMPANY_NAME);
        purchaseInvoice.setPeriod(currentPeriodName); 
        purchaseInvoice.setInvoiceDate(invoiceDate);
		purchaseInvoice.setVendorInvoiceNumber('PINV1'+datetime.now());
     	purchaseInvoice.setAccountInvoiceTotal(INVOICE_TOTAL);

		CODAPurchaseInvoiceTestHelper.ProductLineItem pinvLine = purchaseInvoice.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		pinvLine.setQuantity(LINEITEM_QUANTITY);
		pinvLine.setUnitPrice(UNITPRICE);
		pinvLine.setTaxValue1(TAX_VALUE);
		purchaseInvoice.saveAndPost();
    }
    
    //Create a Check Range for 'Santander current account' Bank Account
    public static void createCheckRange()
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
        payment.setBankAccount(CODABaseDataExt.NAMEBANKACC_SANTANDERCURRENTACCOUNT + ':' + CODATID013700Data.COMPANY_NAME);
        payment.setPaymentTypes(CODAPaymentExt.PAYMENT_TYPE_PAYMENTS);
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
	
	//Update Account payable of Account
	public static void ChangeAccountPayableControl(string glaName)
	{
		CODAContext.enableSupportAccess(); 
        ID acctPayableControl = null;
		if(!string.isEmpty(glaName))
			acctPayableControl = [Select Id, Name from CODAGeneralLedgerAccount__c where Name =:glaName][0].Id;
		Account bmwAcct = [Select Id from Account where MirrorName__c=:CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES][0];		
		bmwAcct.CODAAccountsPayableControl__c = acctPayableControl;
		update bmwAcct;
		CODAContext.disableSupportAccess();
	}
    
    public static void destroyData()
    {
        CODAUnitOfWork.createAndSetCurrent();
        CODAContext.enableSupportAccess(); 
        CODAPaymentData.destroyPaymentData(SUFFIX);
        List<codaCheckRange__c> checkRange= [SELECT Id, Name FROM codaCheckRange__c WHERE Name =:CHECK_RANGE_NAME];
        CODATestIDMapExt.purge(SUFFIX);
		CODAContext.disableSupportAccess();
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
        accNames.add(CODABaseDataExt.NAMEACCOUNT_AUDI);  
        accNames.add(CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES);     
        for (Account accId : [Select Id, Name from Account where MirrorName__c in :accNames])
        {
            CODATestIDMapExt.put(accId.Name, accId.id);
        }
        
        // Product
        Set<String> prodNames = new Set<String>();
        prodNames.add(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
        prodNames.add(CODABaseDataExt.NAMEPRODUCT_AUTO1COMCLUTCH);
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
