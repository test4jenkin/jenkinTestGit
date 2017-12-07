/*
 * Copyright (c) 2017 FinancialForce.com, inc. All rights reserved.
 */
public class CODATID021168Data 
{
    //SUFFIX
    public static String SUFFIX = '#TID021168';
    private static Date DATE_TODAY = System.today();
    private static String PRODUCT_A4PAPER = CODABaseDataExt.NAMEPRODUCT_A4PAPE;
    private static String VENDOR_INVOICE_NUMBER ='VIN';
    private static String PRODUCT_LINE_DESCRIPTION ='Product Line Description';
    private static String EXPENSE_LINE_DESCRIPTION ='Expense Line Description';
    public static final String PURCHASE_INVOICE = 'PINV';    
    private static String INVOICE_DESCRIPTION = 'Payable Invoice';    
        
    public static void selectCompany()
    {
        CODABaseData.switchCurrentCompany(CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN, true, true, UserInfo.getUserId());
    } 
    
    public static void createData()
    {
        loadMap();
        CODAUnitOfWork.createAndSetCurrent();
        
        //create Payable Invoice
        CODAPurchaseInvoiceTestHelper pinv = new CODAPurchaseInvoiceTestHelper();
        pinv.setAccount(CODABaseData.s_apexEURAccountName);
        pinv.setInvoiceDate(DATE_TODAY);
        pinv.setVendorInvoiceNumber(VENDOR_INVOICE_NUMBER+SUFFIX);
        pinv.setAccountInvoiceTotal(CODAFormatter.decimalToString(500.00));
        pinv.setInvoiceDescription(INVOICE_DESCRIPTION);
        
        CODAPurchaseInvoiceTestHelper.ExpenseLineItem pExpline1 = pinv.newExpenseLine(CODABaseData.NAMEGLA_SALESPARTS);
        pExpline1.setNetValue(100);
        pExpline1.setLineDescription(EXPENSE_LINE_DESCRIPTION);
        pExpline1.setDimension1(CODABaseDataExt.NAMEDIM1_EUR);
        pExpline1.setDimension2(CODABaseDataExt.NAMEDIM2_EUR);
        pExpline1.setTaxCode(CODABaseDataExt.NAMETAXCODE_VOSTDPURCHASE);        
                        
        CODAPurchaseInvoiceTestHelper.ExpenseLineItem pExpline2 = pinv.newExpenseLine(CODABaseData.NAMEGLA_SALESPARTS);
        pExpline2.setNetValue(200);
        pExpline2.setLineDescription(EXPENSE_LINE_DESCRIPTION);
        pExpline2.setDimension1(CODABaseDataExt.NAMEDIM1_EUR);
        pExpline2.setDimension2(CODABaseDataExt.NAMEDIM2_EUR);
        pExpline2.setTaxCode(CODABaseDataExt.NAMETAXCODE_VOSTDPURCHASE);
        
        CODAPurchaseInvoiceTestHelper.ExpenseLineItem pExpline3 = pinv.newExpenseLine(CODABaseData.NAMEGLA_SALESPARTS);
        pExpline3.setNetValue(300);
        pExpline3.setLineDescription(EXPENSE_LINE_DESCRIPTION);
        pExpline3.setDimension1(CODABaseDataExt.NAMEDIM1_EUR);
        pExpline3.setDimension2(CODABaseDataExt.NAMEDIM2_EUR);
        pExpline3.setTaxCode(CODABaseDataExt.NAMETAXCODE_VOSTDPURCHASE);
                                
        CODAPurchaseInvoiceTestHelper.ProductLineItem pline1 = pinv.newProductLine(PRODUCT_A4PAPER);
        pline1.setQuantity(1);
        pline1.setUnitPrice(100);
        pline1.setLineDescription(PRODUCT_LINE_DESCRIPTION);
        pline1.setDimension1(CODABaseDataExt.NAMEDIM1_EUR);
        pline1.setDimension2(CODABaseDataExt.NAMEDIM2_EUR);
        pline1.setTaxCode(CODABaseDataExt.NAMETAXCODE_VOSTDPURCHASE);
        
        CODAPurchaseInvoiceTestHelper.ProductLineItem pline2 = pinv.newProductLine(PRODUCT_A4PAPER);
        pline2.setQuantity(1);
        pline2.setUnitPrice(200);
        pline2.setLineDescription(PRODUCT_LINE_DESCRIPTION);
        pline2.setDimension1(CODABaseDataExt.NAMEDIM1_EUR);
        pline2.setDimension2(CODABaseDataExt.NAMEDIM2_EUR);
        pline2.setTaxCode(CODABaseDataExt.NAMETAXCODE_VOSTDPURCHASE);
        
        CODAPurchaseInvoiceTestHelper.ProductLineItem pline3 = pinv.newProductLine(PRODUCT_A4PAPER);
        pline3.setQuantity(1);
        pline3.setUnitPrice(300);
        pline3.setLineDescription(PRODUCT_LINE_DESCRIPTION);
        pline3.setDimension1(CODABaseDataExt.NAMEDIM1_EUR);
        pline3.setDimension2(CODABaseDataExt.NAMEDIM2_EUR);
        pline3.setTaxCode(CODABaseDataExt.NAMETAXCODE_VOSTDPURCHASE);
                
        pinv.setAccountInvoiceTotal(pinv.getInvoiceTotal());
        pinv.save();
        pinv.reload();
        CODATestIDMapExt.put(PURCHASE_INVOICE, pinv.getId());
        CODATestIDMapExt.save(SUFFIX);                
    } 
    
    public static void destroyData()
    {
        CODAUnitOfWork.createAndSetCurrent();
        CODAContext.enableSupportAccess(); 
        CODAPaymentData.destroyPaymentData(SUFFIX);        
        CODAContext.disableSupportAccess();         
    }
    
    // Load the data in the Map
    public static void loadMap()
    {
        // Companies used
        ID company = CODACompanyMapper.getByName(CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN)[0].getId();
        CODATestIDMapExt.put(CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN, company);
        
        // Currencies for the company
        for (codaAccountingCurrency__c accCurr : [SELECT Id, Name, OwnerCompany__r.Name FROM codaAccountingCurrency__c WHERE OwnerCompany__c = :company])
        {
            CODATestIDMapExt.put(accCurr.Name + ':' + accCurr.OwnerCompany__r.Name, accCurr.id);
        }

        //Accounts
        Set<String> accNames = new Set<String>();
        accNames.add(CODABaseData.s_apexEURAccountName);
        for (Account accId : [Select Id, Name from Account where MirrorName__c in :accNames])
        {
            CODATestIDMapExt.put(accId.Name, accId.id);
        }

        // GLAs
        Set<String> glaNames = new Set<String>();
        glaNames.add(CODABaseData.NAMEGLA_SALESPARTS);
        for (CODAGeneralLedgerAccount__c item : [SELECT Id, Name FROM CODAGeneralLedgerAccount__c WHERE Name IN :glaNames])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }

        // Products
        for (Product2 prod : [SELECT Id, Name FROM Product2 WHERE name = :PRODUCT_A4PAPER])
        {
            CODATestIDMapExt.put(prod.Name, prod.id);
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
        
        // Tax Codes
        Set<String> taxNames = new Set<String>();
        taxNames.add(CODABaseDataExt.NAMETAXCODE_VOSTDPURCHASE);
        for (codaTaxCode__c tax : [Select Id, Name from codaTaxCode__c where Name in :taxNames])
        {
            CODATestIDMapExt.put(tax.Name, tax.id);
        }
        
        // Save the Mappings
        CODATestIDMapExt.save(SUFFIX);
    }
}