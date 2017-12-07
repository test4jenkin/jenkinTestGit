/*
 * Copyright (c) 2017 FinancialForce.com, inc. All rights reserved.
 */

public class CODATID021242Data
{
    public static final String SUFFIX = '#TID021242';
    private static String ICD_SPAIN = 'Intercompany Definition Spain To USA';
    private static String ICD_USA = 'Intercompany Definition USA To Spain';
    private static final Date DATE_TODAY = System.today();
    private static String BANK_ACCOUNT_SANTANDER_CURRENT_ACCOUNT = CODABaseDataExt.NAMEBANKACC_SANTANDERCURRENTACCOUNT + ':' + CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN;
    private static String BANK_ACCOUNT_BRISTOL_DEPOSIT_ACCOUNT = CODABaseDataExt.NAMEBANKACC_BRISTOLDEPOSITACCOUNT + ':' + CODABaseData.NAMECOMPANY_MERLINAUTOUSA;
    private static String PRODUCT_A4PAPER = CODABaseDataExt.NAMEPRODUCT_A4PAPE;
    private static String VENDOR_INVOICE_NUMBER ='VIN#' + SUFFIX;
    private static String VENDOR_CREDIT_NUMBER ='VCN#' + SUFFIX;
    private static String CREDIT_DESCRIPTION ='Intercompany Payable Credit Note';
    private static String PRODUCT_LINE_DESCRIPTION ='Product Line Description';
    private static String EXPENSE_LINE_DESCRIPTION ='Expense Line Description';
    private static String INVOICE_DESCRIPTION = 'Invoice Description' + SUFFIX;
    private static String CREDITNOTE_DESCRIPTION = 'Credit Note Descritpion' + SUFFIX;
    public static final String PURCHASE_INVOICE = 'PINV';
    public static final String PURCHASE_CREDITNOTE = 'PCRN';

    public static void selectCompany()
    {
        CODABaseData.switchCurrentCompany(CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN, true, true, UserInfo.getUserId());
        CODAUnitOfWork.getCurrent().clearWork();
    }

    //create ICD for Merlin Auto Spain
    public static void createData()
    {
        loadmap();
        CODAUnitOfWork.createAndSetCurrent();
        
        //Create Intercompany Definition 1
        CODAIntercompanyDefinition interCompany1 = new CODAIntercompanyDefinition();
        interCompany1.setRelatedCompanyId(CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOUSA));
        interCompany1.setSendingControlAccountId(CODATestIDMap.resolve(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLEUR));
        interCompany1.setReceivingControlAccountId(CODATestIDMap.resolve(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLEUR));
        interCompany1.setOwnerCompanyId(CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN));
        interCompany1.setDestinationDocumentBankAccountId(CODATestIDMap.resolve(BANK_ACCOUNT_SANTANDER_CURRENT_ACCOUNT));
        interCompany1.setAutoProcess(true);
        interCompany1.setAutoPost(false);
        CODAUnitOfWork.getCurrent().commitWork();

        //Save to Map
        CODATestIDMapExt.put(ICD_SPAIN, interCompany1.getId());
        CODATestIDMapExt.save(SUFFIX);
    }

    //create Payable Invoice
    public static void createDataExt1()
    {
        CODATestIDMapExt.load(SUFFIX);
        CODAUnitOfWork.createAndSetCurrent();
        
        //create Payable Invoice
        CODAPurchaseInvoiceTestHelper pinv = new CODAPurchaseInvoiceTestHelper();
        pinv.setAccount(CODABaseData.s_apexEURAccountName);
        pinv.setInvoiceDate(DATE_TODAY);
        pinv.setDueDate(DATE_TODAY + 1);
        pinv.setVendorInvoiceNumber(VENDOR_INVOICE_NUMBER);
        pinv.setInvoiceDescription(INVOICE_DESCRIPTION);
        pinv.setEnableReverseCharge(true);
        
        CODAPurchaseInvoiceTestHelper.ExpenseLineItem pExpline = pinv.newExpenseLine(CODABaseData.NAMEGLA_SALESPARTS);
        pExpline.setNetValue(200);
        pExpline.setDestinationNetValue(CODAFormatter.decimalToString(200.00));
        pExpline.setLineDescription(EXPENSE_LINE_DESCRIPTION);
        pExpline.setDestinationCompany(CODABaseData.NAMECOMPANY_MERLINAUTOUSA);
        pExpline.setDimension1(CODABaseDataExt.NAMEDIM1_EUR);
        pExpline.setDimension2(CODABaseDataExt.NAMEDIM2_EUR);
        pExpline.setTaxCode(CODABaseDataExt.NAMETAXCODE_VOECSALES);
        pExpline.setIsReverseChargeTax(true);
        pExpline.setOutputTaxCode(CODABaseDataExt.NAMETAXCODE_VOSTDSALES);
        
        CODAPurchaseInvoiceTestHelper.ProductLineItem pline = pinv.newProductLine(PRODUCT_A4PAPER);
        pline.setQuantity(1);
        pline.setUnitPrice(300);
        pline.setDestinationQuantity('1');
        pline.setDestinationUnitPrice(CODAFormatter.decimalToString(300.00));
        pline.setLineDescription(PRODUCT_LINE_DESCRIPTION);
        pline.setDestinationCompany(CODABaseData.NAMECOMPANY_MERLINAUTOUSA);
        pline.setDimension1(CODABaseDataExt.NAMEDIM1_EUR);
        pline.setDimension2(CODABaseDataExt.NAMEDIM2_EUR);
        pline.setTaxCode(CODABaseDataExt.NAMETAXCODE_VOECSALES);
        pline.setIsReverseChargeTax(true);
        pline.setOutputTaxCode(CODABaseDataExt.NAMETAXCODE_VOSTDSALES);
        
        pinv.setAccountInvoiceTotal(pinv.getInvoiceTotal());
        pinv.save();
        pinv.reload();
        CODATestIDMapExt.put(PURCHASE_INVOICE, pinv.getId());
        CODATestIDMapExt.save(SUFFIX);
    }

    //create Payable Credit Note
    public static void createDataExt2()
    {
        CODATestIDMapExt.load(SUFFIX);
        CODAUnitOfWork.createAndSetCurrent();
        
        //create Payable Credit Note
        CODAPurchaseCreditNoteTestHelper pcr = new CODAPurchaseCreditNoteTestHelper();
        pcr.setAccount(CODABaseData.s_apexEURAccountName);
        pcr.setInvoiceDate(DATE_TODAY);
        pcr.setCreditNoteDate(DATE_TODAY);
        pcr.setDueDate(DATE_TODAY + 1);
        pcr.setVendorCreditNoteNumber(VENDOR_CREDIT_NUMBER);
        pcr.setCreditNoteDescription(CREDITNOTE_DESCRIPTION);
        pcr.setEnableReverseCharge(true);

        CODAPurchaseCreditNoteTestHelper.ExpenseLineItem pline1 = pcr.newExpenseLine(CODABaseData.NAMEGLA_SALESPARTS);
        pline1.setNetValue(200);
        pline1.setDestinationNetValue(CODAFormatter.decimalToString(200.00));
        pline1.setLineDescription(EXPENSE_LINE_DESCRIPTION);
        pline1.setDestinationCompany(CODABaseData.NAMECOMPANY_MERLINAUTOUSA);
        pline1.setDimension1(CODABaseDataExt.NAMEDIM1_EUR);
        pline1.setDimension2(CODABaseDataExt.NAMEDIM2_EUR);
        pline1.setTaxCode(CODABaseDataExt.NAMETAXCODE_VOECSALES);
        pline1.setIsReverseChargeTax(true);
        pline1.setOutputTaxCode(CODABaseDataExt.NAMETAXCODE_VOSTDSALES);
        
        CODAPurchaseCreditNoteTestHelper.ProductLineItem pline = pcr.newProductLine(PRODUCT_A4PAPER);
        pline.setQuantity(1);
        pline.setUnitPrice(300);
        pline.setDestinationQuantity('1');
        pline.setDestinationUnitPrice(CODAFormatter.decimalToString(300.00));
        pline.setLineDescription(PRODUCT_LINE_DESCRIPTION);
        pline.setDestinationCompany(CODABaseData.NAMECOMPANY_MERLINAUTOUSA);
        pline.setDimension1(CODABaseDataExt.NAMEDIM1_EUR);
        pline.setDimension2(CODABaseDataExt.NAMEDIM2_EUR);
        pline.setTaxCode(CODABaseDataExt.NAMETAXCODE_VOECSALES);
        pline.setIsReverseChargeTax(true);
        pline.setOutputTaxCode(CODABaseDataExt.NAMETAXCODE_VOSTDSALES);
        pcr.setAccountCreditNoteTotal('447.50');
        pcr.save();
        pcr.reload();
        CODATestIDMapExt.put(PURCHASE_CREDITNOTE, pcr.getId());
        CODATestIDMapExt.save(SUFFIX);
    }
    
    //switch to Merlin Auto USA
    public static void createDataExt3()
    {
        CODABaseData.switchCurrentCompany(CODABaseData.NAMECOMPANY_MERLINAUTOUSA, true, true, UserInfo.getUserId());
        CODAUnitOfWork.getCurrent().clearWork();
    }

    //create ICD for Merlin Auto USA
    public static void createDataExt4()
    {
        CODATestIDMapExt.load(SUFFIX);
        CODAUnitOfWork.createAndSetCurrent();

        //Create Intercompany Definition
        CODAIntercompanyDefinition interCompany2 = new CODAIntercompanyDefinition();
        interCompany2.setRelatedCompanyId(CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN));
        interCompany2.setSendingControlAccountId(CODATestIDMap.resolve(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLUSD));
        interCompany2.setReceivingControlAccountId(CODATestIDMap.resolve(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD));
        interCompany2.setOwnerCompanyId(CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOUSA));
        interCompany2.setDestinationDocumentBankAccountId(CODATestIDMap.resolve(BANK_ACCOUNT_BRISTOL_DEPOSIT_ACCOUNT));
        interCompany2.setAutoProcess(false);
        interCompany2.setAutoPost(true);
        CODAUnitOfWork.getCurrent().commitWork();
        
        //Save to Map
        CODATestIDMapExt.put(ICD_USA, interCompany2.getId());
        CODATestIDMapExt.save(SUFFIX);
    }
    
    // delete data
    public static void destroyData()
    {
        CODATestIDMapExt.load(SUFFIX);
        CODAContext.enableSupportAccess();
        
        //delete icd
        List<codaIntercompanyDefinition__c> interCompanyDef = [SELECT Id FROM codaIntercompanyDefinition__c];
        delete interCompanyDef;
        List<codaIntercompanyTransfer__c> interCompanyTransfer = [SELECT Id FROM codaIntercompanyTransfer__c];
        delete interCompanyTransfer;
        CODAPaymentData.destroyPaymentData(SUFFIX);
    }

    // Change company
    public static void switchCompany(String company)
    {
        CODABaseData.switchCurrentCompany(company, true, true, UserInfo.getUserId());
        CODAUnitOfWork.getCurrent().clearWork();
    }
    
    // Load the data in the Map
    public static void loadMap()
    {
        // Companies used
        ID companySource = CODACompanyMapper.getByName(CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN)[0].getId();
        CODATestIDMapExt.put(CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN, companySource);
        Id companyDest = CODACompanyMapper.getByName(CODABaseData.NAMECOMPANY_MERLINAUTOUSA)[0].getId();
        CODATestIDMapExt.put(CODABaseData.NAMECOMPANY_MERLINAUTOUSA, companyDest);
        Set<Id> companiesIDs = new Set<Id>{companySource, companyDest};

        // Currencies for the company
        for (codaAccountingCurrency__c accCurr : [SELECT Id, Name, OwnerCompany__r.Name FROM codaAccountingCurrency__c WHERE OwnerCompany__c IN :companiesIDs])
        {
            CODATestIDMapExt.put(accCurr.Name + ':' + accCurr.OwnerCompany__r.Name, accCurr.id);
        }

        //Accounts
        Set<String> accNames = new Set<String>();
        accNames.add(CODABaseDataExt.NAMEACCOUNT_BOLINGER);
        accNames.add(CODABaseData.s_apexEURAccountName);
        for (Account accId : [Select Id, Name from Account where MirrorName__c in :accNames])
        {
            CODATestIDMapExt.put(accId.Name, accId.id);
        }

        //Tax Codes
        Set<String> taxCodes = new Set<String>();
        taxCodes.add(CODABaseDataExt.NAMETAXCODE_VOECSALES);
        taxCodes.add(CODABaseDataExt.NAMETAXCODE_VOSTDSALES);
        for (codaTaxCode__c taxCode : [Select Id, Name from codaTaxCode__c where Name in :taxCodes])
        {
            CODATestIDMapExt.put(taxCode.Name, taxCode.Id);
        }

        // GLAs
        Set<String> glaNames = new Set<String>();
        glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLEUR);
        glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLEUR);
        glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLUSD);
        glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD);
        glaNames.add(CODABaseData.NAMEGLA_SALESPARTS);

        for (CODAGeneralLedgerAccount__c item : [SELECT Id, Name FROM CODAGeneralLedgerAccount__c WHERE Name IN :glaNames])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }

        // Bank Accounts
        for (codaBankAccount__c bankAcc : [SELECT Id, Name, OwnerCompany__r.name FROM codaBankAccount__c WHERE OwnerCompany__c IN :companiesIDs])
        {
            CODATestIDMapExt.put(bankAcc.Name + ':' + bankAcc.OwnerCompany__r.name, bankAcc.id);
        }

        // Products
        for (Product2 prod : [SELECT Id, Name FROM Product2 WHERE name = :PRODUCT_A4PAPER])
        {
            CODATestIDMapExt.put(prod.Name, prod.id);
        }

        //Dimension1
        for (codaDimension1__c  item : [Select Id, Name from codaDimension1__c])
        {
            CODATestIDMapExt.put(item.Name , item.id);
        }
        
        //Dimension2
        for (codaDimension2__c  item : [Select Id, Name from codaDimension2__c])
        {
            CODATestIDMapExt.put(item.Name , item.id);
        }
        
        //Dimension3
        for (codaDimension3__c  item : [Select Id, Name from codaDimension3__c])
        {
            CODATestIDMapExt.put(item.Name , item.id);
        }
        
        //Dimension4
        for (codaDimension4__c  item : [Select Id, Name from codaDimension4__c])
        {
            CODATestIDMapExt.put(item.Name , item.id);
        }

        // Save the Mappings
        CODATestIDMapExt.save(SUFFIX);
    }
}