/*
 * Copyright (c) 2017 FinancialForce.com, inc. All rights reserved.
 */
 
public class CODATID020947Data
{
    public static final String SUFFIX = '#TID020947';
    public static final string VAT_COMPANY_NAME = CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN;
    public static final String PERIODNAME_CURRENT = CODAPeriodMapExt.getPeriodByDate(system.today()).getName();
    public static final string PIN001 = 'PIN001';
    public static final string PIN002 = 'PIN002';
    public static final string VENDOR_INV_NUMBER_1 = 'VIN001';
    public static final string VENDOR_INV_NUMBER_2 = 'VIN002';
    
    public static void selectCompany()
    {
        CODABaseData.switchCurrentCompany(VAT_COMPANY_NAME, true, true, UserInfo.getUserId());
    }

    public static void switchProfile()
    {
        Id accountant = CODABaseData.getProfile(CODABaseData.ACCOUNTANT).Id;
        CODABaseData.switchCurrentCompany(VAT_COMPANY_NAME, true, false, accountant);
    }

    public static void createData()
    {
        loadMap();
        CODAUnitOfWork.createAndSetCurrent();

        CODACompany company= CODACompanyMapper.getByName(VAT_COMPANY_NAME)[0];
        
        //Creating a purchase Invoice 1 as in TID020947.
        CODAPurchaseInvoiceTestHelper pInvoice = new CODAPurchaseInvoiceTestHelper();
        pInvoice.setAccount(CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES);
        pInvoice.setInvoiceCurrency(CODABaseData.CURRENCYCODE_EUR + ':' + CODATID020947Data.VAT_COMPANY_NAME);
        pInvoice.setInvoiceDate(system.today());
        pInvoice.setVendorInvoiceNumber(CODATID020947Data.VENDOR_INV_NUMBER_1);
        pInvoice.setPeriod(CODATID020947Data.PERIODNAME_CURRENT + ':' + CODATID020947Data.VAT_COMPANY_NAME);
        
        //Expense Line
        {
            CODAPurchaseInvoiceTestHelper.ExpenseLineItem expLine1 = pInvoice.newExpenseLine(CODABaseData.NAMEGLA_POSTAGEANDSTATIONERY);
            expLine1.setNetValue(50);
            expLine1.setTaxCode(CODABaseDataExt.NAMETAXCODE_VORPURCHASE);
            expLine1.setTaxValue1('2.50');
        }
        
        //Product Line
        {
            CODAPurchaseInvoiceTestHelper.ProductLineItem Line1 = pInvoice.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
            Line1.setUnitPrice(400);
            Line1.setQuantity(1);
            Line1.setTaxCode(CODABaseDataExt.NAMETAXCODE_VOSTDPURCHASE);  
            Line1.setTaxValue1('70.00');
        }
        
        pInvoice.setAccountInvoiceTotal(pInvoice.getInvoiceTotal());
        pInvoice.saveAndPost();

        //Creating a purchase Invoice 2 as in TID020947.
        CODAPurchaseInvoiceTestHelper pInvoice1 = new CODAPurchaseInvoiceTestHelper();
        pInvoice1.setAccount(CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES);
        pInvoice1.setInvoiceCurrency(CODABaseData.CURRENCYCODE_EUR + ':' + CODATID020947Data.VAT_COMPANY_NAME);
        pInvoice1.setInvoiceDate(system.today());
        pInvoice1.setVendorInvoiceNumber(CODATID020947Data.VENDOR_INV_NUMBER_2);
        pInvoice1.setPeriod(CODATID020947Data.PERIODNAME_CURRENT + ':' + CODATID020947Data.VAT_COMPANY_NAME);
        
        //Expense Line
        {
            CODAPurchaseInvoiceTestHelper.ExpenseLineItem expLine2 = pInvoice1.newExpenseLine(CODABaseData.NAMEGLA_POSTAGEANDSTATIONERY);
            expLine2.setNetValue(450);
            expLine2.setTaxCode(null);
            expLine2.setTaxValue1(null);
        }   
        
        pInvoice1.setAccountInvoiceTotal(pInvoice1.getInvoiceTotal());
        pInvoice1.saveAndPost();
        
        CODATestIDMapExt.put(CODATID020947Data.PIN001, pInvoice.getId());
        CODATestIDMapExt.put(CODATID020947Data.PIN002, pInvoice1.getId());
        CODATestIDMapExt.save(CODATID020947Data.SUFFIX);
    }
    
    public static void destroyData()
    {
        CODATestIDMapExt.load(SUFFIX);
        CODAContext.enableSupportAccess();
        delete[Select Id from CODAPurchaseInvoice__c];
        delete[Select id from CODATransaction__c];
        delete[select id from TransactionReconciliation__c];
        CODAContext.disableSupportAccess();
        CODATestIDMapExt.purge(SUFFIX);
    }
    
    public static void loadMap()
    {
        //Company Spain
        CODACompany compVAT = CODACompanyMapExt.getCurrentCompany();
        Id compId = compVAT.getId();
        CODATestIDMapExt.put(VAT_COMPANY_NAME, compId);
        
        //Spain Period
        codaPeriod__c periodSpain = [Select Id, Name, OwnerCompany__r.Name from codaPeriod__c where Name = :PERIODNAME_CURRENT AND OwnerCompany__c = :compId limit 1];
        CODATestIDMapExt.put(PERIODNAME_CURRENT + ':' + compVAT.getName(), periodSpain.id);
        
        //Currencies for Merlin Auto Spain
        for (codaAccountingCurrency__c accCurrSpain : [Select Id, Name, OwnerCompany__r.Name from codaAccountingCurrency__c where OwnerCompany__c  = :compId])
        {
            CODATestIDMapExt.put(accCurrSpain.Name + ':' + accCurrSpain.OwnerCompany__r.Name, accCurrSpain.id);
        }
         
        //Accounts
        Account accId = [Select Id, Name from Account where MirrorName__c =:CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES];
        CODATestIDMapExt.put(accId.Name, accId.id);
        
        // Products
        Set<String> productList = new Set<String>();
        productList.add(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
        productList.add(CODABaseDataExt.NAMEPRODUCT_BBKFUELPUMP); 
        for (Product2 product : [Select Id, Name from Product2 where Name in :productList])    
        {                                                                                               
            CODATestIDMapExt.put(product.Name, product.id);
        }
        
        //Tax Codes
        Set<String> taxNames = new Set<String>();
        taxNames.add(CODABaseDataExt.NAMETAXCODE_VOSTDPURCHASE);
        taxNames.add(CODABaseDataExt.NAMETAXCODE_VORPURCHASE);
        for (codaTaxCode__c item : [Select Id, Name from codaTaxCode__c where Name in :taxNames])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }
        
        //GLAs
        Set<String> glaNames = new Set<String>();
        glaNames.add(CODABaseData.NAMEGLA_POSTAGEANDSTATIONERY);
        for(CODAGeneralLedgerAccount__c gla: [Select Id, Name from CODAGeneralLedgerAccount__c where Name in :glaNames])
        {
            CODATestIDMapExt.put(gla.Name, gla.id);
        }
       
        CODATestIDMapExt.save(SUFFIX);
    }
}