/*
* FinancialForce.com, inc. claims copyright in this software, its screen
* display designs and supporting documentation. FinancialForce and
* FinancialForce.com are trademarks of FinancialForce.com, inc. Any
* unauthorized use, copying or sale of the above may constitute an
* infringement of copyright and may result in criminal or other legal
* proceedings.
*
* Copyright (c) 2016 FinancialForce.com, inc. All rights reserved.
*/

public class CODATID016374Data 
{
    public static String COMPANY_NAME = CODABaseData.NAMECOMPANY_MERLINAUTOUSA;
    public static String SUFFIX = '#TID016374';
    public static string SINV_DESCRIPTION = 'Test SInv';
    public static string INVLINE1_DESC = 'Invoice line 1';
    public static string INVLINE2_DESC = 'Invoice line 2';
    public static string INVLINE3_DESC = 'Invoice line 3';
    public static double INCSCHLINE1_AMOUNT = 149.00;
    public static double INCSCHLINE2_AMOUNT = 66.00;
    public static double INCSCHLINE3_AMOUNT = 210.00;
    public static string INVOICE_NAME = 'SIN_NAME_1';
    
    
    public static void switchProfile() 
    {
        Id userId = CODABaseData.getProfile(CODABaseData.SALESINVOICINGCLERK).Id;
        CODABaseData.switchCurrentCompany(COMPANY_NAME, true, false, userId);
    }
    
    public static void selectCompany()
    {              
        CODABaseData.switchCurrentCompany(COMPANY_NAME, true, true, UserInfo.getUserId());
    }

    //loadmap
    public static void createData()
    {
        CODAUnitOfWork.getCurrent();
        loadmap();
        
        // Product
        CODAProduct2 product1 = CODAProduct2Mapper.getById(CODATestIDMap.resolve(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH));
        product1.setIncomeScheduleId(CODATestIDMap.resolve(CODABaseDataExt.NAMEINCOMESCHEDULE_MONTHLYSPREAD));
        CODAProduct2 product2 = CODAProduct2Mapper.getById(CODATestIDMap.resolve(CODABaseDataExt.NAMEPRODUCT_BENDIXFRONTBRAKE));
        product2.setIncomeScheduleId(CODATestIDMap.resolve(CODABaseDataExt.NAMEINCOMESCHEDULE_QUARTERLY));
        CODAProduct2 product3 = CODAProduct2Mapper.getById(CODATestIDMap.resolve(CODABaseDataExt.NAMEPRODUCT_BOSCHOILFILTER));
        product3.setIncomeScheduleId(CODATestIDMap.resolve(CODABaseDataExt.NAMEINCOMESCHEDULE_SIXMONTHLY));
        
        CODAUnitOfWork.getCurrent().commitWork();
    }
    
    public static void createDataExt1()
    {
        CODATestIDMapExt.load(SUFFIX);
        
        codaInvoice__c sInv = new codaInvoice__c();
        sInv.Account__c = CODATestIDMap.resolve(CODABaseDataExt.NAMEACCOUNT_HOGANREPAIRS);
        sInv.InvoiceDate__c = Date.newInstance(2009, 01, 01);
        sInv.InvoiceDescription__c = SINV_DESCRIPTION;
        Insert sInv;
        codaInvoiceLineItem__c sInvLine1 = new codaInvoiceLineItem__c();
        sInvLine1.Invoice__c = sInv.Id;
        sInvLine1.LineDescription__c = INVLINE1_DESC;
        sInvLine1.Product__c = CODATestIDMap.resolve(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
        sInvLine1.Quantity__c = 20;
        sInvLine1.UnitPrice__c = 89.40;
        Insert sInvLine1;
        codaInvoiceLineItem__c sInvLine2 = new codaInvoiceLineItem__c();
        sInvLine2.Invoice__c = sInv.Id;
        sInvLine2.LineDescription__c = INVLINE2_DESC;
        sInvLine2.Product__c = CODATestIDMap.resolve(CODABaseDataExt.NAMEPRODUCT_BENDIXFRONTBRAKE);
        sInvLine2.Quantity__c = 20;
        sInvLine2.UnitPrice__c = 13.20;
        Insert sInvLine2;
        codaInvoiceLineItem__c sInvLine3 = new codaInvoiceLineItem__c();
        sInvLine3.Invoice__c = sInv.Id;
        sInvLine3.LineDescription__c = INVLINE3_DESC;
        sInvLine3.Product__c = CODATestIDMap.resolve(CODABaseDataExt.NAMEPRODUCT_BOSCHOILFILTER);
        sInvLine3.Quantity__c = 100;
        sInvLine3.UnitPrice__c = 4.20;
        Insert sInvLine3;
        
        CODATestIDMapExt.put(INVOICE_NAME, sInv.Id);
        CODATestIDMapExt.save(SUFFIX);
    }
    
    public static void destroyData()
    {   
        CODAUnitOfWork.createAndSetCurrent();
        Set<String> prodNames = new Set<String>{CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH,CODABaseDataExt.NAMEPRODUCT_BENDIXFRONTBRAKE,CODABaseDataExt.NAMEPRODUCT_BOSCHOILFILTER};
        Map<String, ID> prodMap = CODAProduct2Mapper.getIDsByNames(prodNames);
        List<CODAProduct2> productList = CODAProduct2Mapper.getByIDs(prodMap.values());
        for (CODAProduct2 prod : productList)
        {
            prod.setIncomeScheduleId(null);
        }
        CODAUnitOfWork.getCurrent().commitWork();
        CODAContext.enableSupportAccess();
        CODAPaymentData.destroyPaymentData(SUFFIX);
    }
    
    public static void loadMap()
    {
        // Company
        CODACompany company = CODACompanyMapExt.getCurrentCompany();
        Id compId = company.getId();
        
        CODATestIDMapExt.put(company.getName(), compId);
        
        // Periods for Merlin Auto USA
        for (codaPeriod__c period : [Select Id, Name, OwnerCompany__r.Name from codaPeriod__c where OwnerCompany__c = :compId])
        {
            CODATestIDMapExt.put(period.Name + ':' + period.OwnerCompany__r.Name, period.id);
        }
        // Accounts
        Set<String> accNames = new Set<String>();
        accNames.add(CODABaseDataExt.NAMEACCOUNT_HOGANREPAIRS);       
        for (Account accId : [Select Id, Name from Account where MirrorName__c in :accNames])
        {
            CODATestIDMapExt.put(accId.Name, accId.id);
        }
        // Currencies for Merlin Auto USA
        for (codaAccountingCurrency__c accCurr : [Select Id, Name, OwnerCompany__r.Name from codaAccountingCurrency__c where OwnerCompany__c  = :compId])
        {
            CODATestIDMapExt.put(accCurr.Name + ':' + accCurr.OwnerCompany__r.Name, accCurr.id);
        }     
        
        //For Products
        Set<String> prodNames = new Set<String>();
        prodNames.add(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
        prodNames.add(CODABaseDataExt.NAMEPRODUCT_BENDIXFRONTBRAKE);
        prodNames.add(CODABaseDataExt.NAMEPRODUCT_BOSCHOILFILTER);
        for (Product2  item : [Select Id, Name from Product2 WHERE Name in :prodNames])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }
        
        // Tax Codes
        for (codaTaxCode__c item : [Select Id, Name from codaTaxCode__c])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }
        
        // Income schedules
        for (codaIncomeScheduleDefinition__c item : [Select Id, Name from codaIncomeScheduleDefinition__c])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }
                
        CODATestIDMapExt.save(SUFFIX);
    }
}
