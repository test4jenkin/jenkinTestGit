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


public with sharing class CODATID013132Data
{
    public static String SUFFIX = '#TID013132'; 
	public static String REFERENCE1 = 'BMW001';
	public static String REFERENCE2 = 'BMW002';
	public static String REFERENCE3 = 'BMW003';
	public static String REFERENCE4 = 'BMW004';
	public static String COMPANY_NAME = CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN;
	public static Integer LINEITEM_QUANTITY =1;
    public static Decimal UNITPRICE = 89.40;
    public static String INVOICE_TOTAL = '105.05';
    public static String TAX_VALUE = '15.65';
    
	public static void switchProfile() 
    { 
        Id userId = CODABaseData.getProfile(CODABaseData.ACCOUNTANT).Id;
        CODABaseData.switchCurrentCompany(COMPANY_NAME, true, false, userId);            
    }
    
    public static void selectCompany()
    {
        CODABaseData.switchCurrentCompany(COMPANY_NAME, true, true, UserInfo.getUserId());
    }
    
    public static void createData()
    {
        loadmap();
        
        Date invoiceDate= System.today();
        string currentPeriodName = CODAPeriodMapExt.getPeriodByDate(invoiceDate).getName() + ':' + COMPANY_NAME;
		
        // Create PINV1
        CODAPurchaseInvoiceTestHelper purchaseInvoice1 = new CODAPurchaseInvoiceTestHelper();
        purchaseInvoice1.setAccount(CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES);
        purchaseInvoice1.setInvoiceCurrency(CODABaseData.CURRENCYCODE_EUR+':'+COMPANY_NAME);
        purchaseInvoice1.setPeriod(currentPeriodName); 
        purchaseInvoice1.setInvoiceDate(invoiceDate);
        purchaseInvoice1.setVendorInvoiceNumber(REFERENCE1);
        purchaseInvoice1.setAccountInvoiceTotal(INVOICE_TOTAL);
        
        CODAPurchaseInvoiceTestHelper.ProductLineItem pinvLine = purchaseInvoice1.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTO1COMCLUTCH);
        pinvLine.setQuantity(LINEITEM_QUANTITY);
        pinvLine.setUnitPrice(UNITPRICE);
        pinvLine.setTaxValue1(TAX_VALUE);
        purchaseInvoice1.saveAndPost();
		
		CODATestIDMapExt.put(REFERENCE1, purchaseInvoice1.getId());
    }
    public static void createDataExt1()
	{
		CODATestIDMapExt.load(SUFFIX);
		Date invoiceDate= System.today();
        string currentPeriodName = CODAPeriodMapExt.getPeriodByDate(invoiceDate).getName() + ':' + COMPANY_NAME;
        
		// Create PINV2
		CODAPurchaseInvoiceTestHelper purchaseInvoice2 = new CODAPurchaseInvoiceTestHelper();
        purchaseInvoice2.setAccount(CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES);
        purchaseInvoice2.setInvoiceCurrency(CODABaseData.CURRENCYCODE_EUR+':'+COMPANY_NAME);
        purchaseInvoice2.setPeriod(currentPeriodName); 
        purchaseInvoice2.setInvoiceDate(invoiceDate);
        purchaseInvoice2.setVendorInvoiceNumber(REFERENCE2);
        purchaseInvoice2.setAccountInvoiceTotal(INVOICE_TOTAL);
        
        CODAPurchaseInvoiceTestHelper.ProductLineItem pinvLine2 = purchaseInvoice2.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTO1COMCLUTCH);
        pinvLine2.setQuantity(LINEITEM_QUANTITY);
        pinvLine2.setUnitPrice(UNITPRICE);
        pinvLine2.setTaxValue1(TAX_VALUE);
        purchaseInvoice2.saveAndPost();
        purchaseInvoice2.reload();
		purchaseInvoice2.paymentOnHold();
		CODATestIDMapExt.put(REFERENCE2, purchaseInvoice2.getId());
        
        CODATestIDMapExt.save(SUFFIX);
	}
	
	public static void createDataExt2()
	{
		CODATestIDMapExt.load(SUFFIX);
		Date invoiceDate= System.today();
        string currentPeriodName = CODAPeriodMapExt.getPeriodByDate(invoiceDate).getName() + ':' + COMPANY_NAME;
        
		// Create PINV3
		CODAPurchaseInvoiceTestHelper purchaseInvoice3 = new CODAPurchaseInvoiceTestHelper();
        purchaseInvoice3.setAccount(CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES);
        purchaseInvoice3.setInvoiceCurrency(CODABaseData.CURRENCYCODE_EUR+':'+COMPANY_NAME);
        purchaseInvoice3.setPeriod(currentPeriodName); 
        purchaseInvoice3.setInvoiceDate(invoiceDate);
        purchaseInvoice3.setVendorInvoiceNumber(REFERENCE3);
        purchaseInvoice3.setAccountInvoiceTotal(INVOICE_TOTAL);
        
        CODAPurchaseInvoiceTestHelper.ProductLineItem pinvLine3 = purchaseInvoice3.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTO1COMCLUTCH);
        pinvLine3.setQuantity(LINEITEM_QUANTITY);
        pinvLine3.setUnitPrice(UNITPRICE);
        pinvLine3.setTaxValue1(TAX_VALUE);
        purchaseInvoice3.save();
		
		CODATestIDMapExt.put(REFERENCE3, purchaseInvoice3.getId());
		
		// Create PINV4
		CODAPurchaseInvoiceTestHelper purchaseInvoice4 = new CODAPurchaseInvoiceTestHelper();
        purchaseInvoice4.setAccount(CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES);
        purchaseInvoice4.setInvoiceCurrency(CODABaseData.CURRENCYCODE_EUR+':'+COMPANY_NAME);
        purchaseInvoice4.setPeriod(currentPeriodName); 
        purchaseInvoice4.setInvoiceDate(invoiceDate);
        purchaseInvoice4.setVendorInvoiceNumber(REFERENCE4);
        purchaseInvoice4.setAccountInvoiceTotal(INVOICE_TOTAL);
        
        CODAPurchaseInvoiceTestHelper.ProductLineItem pinvLine4 = purchaseInvoice4.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTO1COMCLUTCH);
        pinvLine4.setQuantity(LINEITEM_QUANTITY);
        pinvLine4.setUnitPrice(UNITPRICE);
        pinvLine4.setTaxValue1(TAX_VALUE);
        purchaseInvoice4.save();
		CODATestIDMapExt.put(REFERENCE4, purchaseInvoice4.getId());
		purchaseInvoice4.reload();
		
		CODAPurchaseInvoiceTestHelper pInv = new CODAPurchaseInvoiceTestHelper(REFERENCE4);
        try
        {
			pInv.goToDiscard();
            pInv.setDiscardReason('Test discard');
            pInv.discard();
        }
        catch(Exception ex)
        {
            System.assert(ex.getMessage()==null, 'The exception was thrown: ' +ex.getMessage());
        }
		CODATestIDMapExt.save(SUFFIX);
	}
    
	public static void destroyData()
    {
        CODAContext.enableSupportAccess(); 
        CODAPaymentData.destroyPaymentData(SUFFIX);
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
		
		// Currencies for the companies
		for (codaAccountingCurrency__c accCurr : [Select Id, Name, OwnerCompany__r.Name from codaAccountingCurrency__c where OwnerCompany__c = :compId])
		{
			CODATestIDMapExt.put(accCurr.Name + ':' + accCurr.OwnerCompany__r.Name, accCurr.Id);
		}
		
		// Account
		Set<String> accNames = new Set<String>();
		accNames.add(CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES);
		for (Account accId : [Select Id, Name from Account where MirrorName__c in :accNames])
		{
			CODATestIDMapExt.put(accId.Name, accId.Id);
		}

        // GLAs
        Set<String> glaNames = new Set<String>();
        glaNames.add(CODABaseData.s_APEXBankGLA_name);
        for (CODAGeneralLedgerAccount__c item : [Select Id, Name from CODAGeneralLedgerAccount__c where Name in :glaNames])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }
		
        // Bank Accounts
		Set<String> bankNames = new Set<String>();
		bankNames.add(CODABaseData.s_bankAccNameEUR);
		for (codaBankAccount__c item : [Select Id, Name, OwnerCompany__r.Name from codaBankAccount__c where Name in :bankNames])
		{
			CODATestIDMapExt.put(item.Name + ':' + item.OwnerCompany__r.Name, item.Id);
		}
        
        // Product
        CODAProduct2 product2 = CODAProduct2Mapper.getByName(CODABaseDataExt.NAMEPRODUCT_AUTO1COMCLUTCH)[0];
        CODATestIDMapExt.put(CODABaseDataExt.NAMEPRODUCT_AUTO1COMCLUTCH, product2.getId());
        
        // Tax Code
        Set<String> taxNames = new Set<String>();
        taxNames.add(CODABaseDataExt.NAMETAXCODE_VOS);
        for (codaTaxCode__c item : [Select Id, Name from codaTaxCode__c where Name in :taxNames])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }
		
		CODATestIDMapExt.save(SUFFIX);
    }
}
