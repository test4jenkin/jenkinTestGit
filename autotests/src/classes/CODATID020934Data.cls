/*
 * Copyright (c) 2017 FinancialForce.com, inc. All rights reserved.
 */
public class CODATID020934Data
{
    public static String SUFFIX = '#TID020934';    
    public static String COMPANY_NAME = CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN; 
    public static String ACCOUNT_NAME= 'ACC_GBP_1';
    public static String INVOICE_REF= 'PIN1';
    public static String CREDITNOTE_REF= 'PCN1';
    public static String DOCUMENT_CURRENCY=CODABaseData.CURRENCYCODE_GBP+ ':' +COMPANY_NAME;
    public static String PROD_NAME= 'PROD_VAT_';
    public static String GLA_NAME= 'VAT_GLA_';
    public static String USD_CURRENCY= CODABaseData.CURRENCYCODE_USD;
    public static String GBP_CURRENCY= CODABaseData.CURRENCYCODE_GBP;
    public static String AUD_CURRENCY= CODABaseData.CURRENCYCODE_AUD;
    public static String JPY_CURRENCY= CODABaseData.CURRENCYCODE_JPY;
    public static String EUR_CURRENCY= CODABaseData.CURRENCYCODE_EUR;
    public static String DIMENSION1_NAME= 'Dim 1-GBP-';
    public static String DIMENSION2_NAME= 'Dim 2-GBP-';
    public static String DIMENSION3_NAME= 'Dim 3-GBP-';
    public static String DIMENSION4_NAME= 'Dim 4-GBP-';
    public static Decimal LINEITEM_QUANTITY=1;
    public static Decimal UNITPRICE = 100;
    public static String TAX_CODE = CODABaseDataExt.NAMETAXCODE_VOECPURCHASE;
    public static String INVOICE_NAME='PIN_NAME';
    public static String INVOICE_NUMBER='PIN00000';
    public static String CREDITNOTE_NAME='PCN_NAME';
    public static String CREDITNOTE_NUMBER='PCR00000';
    public static final Integer TOTAL_EXP_LINE_ITEMS = 200;
    public static final Integer TOTAL_PROD_LINE_ITEMS = 800;
    public static final Integer LINE_LIMIT = 1000;
    private static Integer m_payableLinesToCreate = TOTAL_PROD_LINE_ITEMS < 200 ? TOTAL_PROD_LINE_ITEMS : 200;
    private static Integer m_remainingPayableLinesToCreate = TOTAL_PROD_LINE_ITEMS - m_payableLinesToCreate;

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
        codaAccountingSettings__c accSet = new codaAccountingSettings__c();
		accSet.ConvertToPCRLinesThreshold__c = LINE_LIMIT;
		accSet.PayableCreditNoteLinesThreshold__c = LINE_LIMIT;
		accSet.PayableInvoiceLinesThreshold__c = LINE_LIMIT;
        insert accSet;
    }

    public static void createDataExt1()
    {
        CODAVolumeBaseData.createData();
    }

    public static void createDataExt2()
    {
        CODAVolumeBaseData.createVATData();
    }

    public static void createDataExt3()
    {
        CODAVolumeBaseData.createVATDataExt();
		loadMap();
    }

    //Update Account to AP Control GLA
    public static void createDataExt4()
    {
        CODATestIDMapExt.load(SUFFIX);

        List<Account> AccountList = new List<Account>();
        Id  glaId = CODAGeneralLedgerAccountMapper.getByName(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLGBP)[0].getId();
        for (Account  item : [Select Id, Name from Account where MirrorName__c = :ACCOUNT_NAME])
        {
            item.CODAAccountsPayableControl__c = glaId;
            AccountList.add(item);
        }
        update AccountList;

        CODATestIDMapExt.save(SUFFIX);
    }

    public static void createDataExt5()
    {
        createGla(1, 60);
    }

	public static void createDataExt6()
    {
        createGla(61, 120);
    }

	public static void createDataExt7()
    {
        createGla(121, 180);
    }

	public static void createDataExt8()
    {
        createGla(181, 200);
    }

    public static void createDataExt9()
    {
        CODATestIDMapExt.load(SUFFIX);
        //New GLAs
        for (CODAGeneralLedgerAccount__c item : [Select Id, Name from CODAGeneralLedgerAccount__c where Name like :GLA_NAME + '%' ORDER BY Id])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }
        CODATestIDMapExt.save(SUFFIX);
    }


    public static void createDataExt10()
    {
        createProducts(1,80);
    }

    public static void createDataExt11()
    {
        createProducts(81,160);
    }

    // Create Products 161 - 240
    public static void createDataExt12()
    {
        createProducts(161,240);
    }

	// Create Products 241 - 320
    public static void createDataExt13()
    {
        createProducts(241,320);
    }

	// Create Products 321 - 400
    public static void createDataExt14()
    {
        createProducts(321,400);
    }

	// Create Products 401 - 480
    public static void createDataExt15()
    {
        createProducts(401,480);
    }

	// Create Products 481 - 560
    public static void createDataExt16()
    {
        createProducts(481,560);
    }

	// Create Products 561 - 640
    public static void createDataExt17()
    {
        createProducts(561,640);
    }

	// Create Products 161 - 240
    public static void createDataExt18()
    {
        createProducts(641,720);
    }

	// Create Products 161 - 240
    public static void createDataExt19()
    {
        createProducts(721,800);
    }

    public static void createDataExt20()
    {
        CODAUnitOfWork.getCurrent();

        CODATestIDMapExt.load(SUFFIX);
        //loading Map after commiting products
        for(Product2  item : [SELECT Id, Name FROM Product2  WHERE Name LIKE :PROD_NAME + '%' ORDER BY Id])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }
        CODATestIDMapExt.save(SUFFIX);
    }

    //Create PIN 1
    public static void createDataExt21()
    {
        CODAContext.SetService(true);
        CODATestIDMapExt.load(SUFFIX);
        CODAUnitOfWork.getCurrent();

        Date invoiceDate= System.date.today();
        CODAPurchaseInvoice invoice = CODAVolumeDataTestHelper.createPurchaseInvoice(ACCOUNT_NAME,invoiceDate,DOCUMENT_CURRENCY,INVOICE_NUMBER + '1',INVOICE_REF);
        CODAUnitOfWork.getCurrent().commitWork();
        CODATestIDMapExt.put(INVOICE_NAME + 1, invoice.getId());

        CODAUnitOfWork.getCurrent();
        CODAVolumeDataTestHelper.addPurchaseInvoiceExpenseLineItems(INVOICE_NAME + 1,GLA_NAME,UNITPRICE,TAX_CODE,null,null,DIMENSION1_NAME,DIMENSION2_NAME,DIMENSION3_NAME,DIMENSION4_NAME,1,TOTAL_EXP_LINE_ITEMS ,false,false,10);
        CODAVolumeDataTestHelper.addPurchaseInvoiceLineItems(INVOICE_NAME + 1,PROD_NAME,LINEITEM_QUANTITY,UNITPRICE,null,TAX_CODE,null,DIMENSION1_NAME,DIMENSION2_NAME,DIMENSION3_NAME,DIMENSION4_NAME,1,m_payableLinesToCreate ,false,false,10);

        CODAUnitOfWork.getCurrent().commitWork();
        CODATestIDMapExt.save(SUFFIX);
    }

    //Create PIN 1 remaining product lines
    public static void createDataExt22()
    {
        if(m_remainingPayableLinesToCreate > 0)
        {
            CODAContext.SetService(true);
            CODATestIDMapExt.load(SUFFIX);
            CODAUnitOfWork.getCurrent();

            CODAVolumeDataTestHelper.addPurchaseInvoiceLineItems(INVOICE_NAME + 1,PROD_NAME,LINEITEM_QUANTITY,UNITPRICE,null,TAX_CODE,null,DIMENSION1_NAME,DIMENSION2_NAME,DIMENSION3_NAME,DIMENSION4_NAME,201,(m_remainingPayableLinesToCreate + 200) ,false,false,10);

            CODAUnitOfWork.getCurrent().commitWork();
            CODATestIDMapExt.save(SUFFIX);
        }
    }

    //Create PIN 2
    public static void createDataExt23()
    {
        CODAContext.SetService(true);
        CODATestIDMapExt.load(SUFFIX);
        CODAUnitOfWork.getCurrent();

        Date invoiceDate= System.date.today();
        CODAPurchaseInvoice invoice = CODAVolumeDataTestHelper.createPurchaseInvoice(ACCOUNT_NAME,invoiceDate,DOCUMENT_CURRENCY,INVOICE_NUMBER + '2',INVOICE_REF);
        CODAUnitOfWork.getCurrent().commitWork();
        CODATestIDMapExt.put(INVOICE_NAME + 2, invoice.getId());

        CODAUnitOfWork.getCurrent();
        CODAVolumeDataTestHelper.addPurchaseInvoiceExpenseLineItems(INVOICE_NAME + 2,GLA_NAME,UNITPRICE,TAX_CODE,null,null,DIMENSION1_NAME,DIMENSION2_NAME,DIMENSION3_NAME,DIMENSION4_NAME,1,TOTAL_EXP_LINE_ITEMS,false,false,10);
        CODAVolumeDataTestHelper.addPurchaseInvoiceLineItems(INVOICE_NAME + 2,PROD_NAME,LINEITEM_QUANTITY,UNITPRICE,null,TAX_CODE,null,DIMENSION1_NAME,DIMENSION2_NAME,DIMENSION3_NAME,DIMENSION4_NAME,1,m_payableLinesToCreate,false,false,10);

        CODAUnitOfWork.getCurrent().commitWork();
        CODATestIDMapExt.save(SUFFIX);
    }

    //Create PIN 2 remaining product lines
    public static void createDataExt24()
    {
        if(m_remainingPayableLinesToCreate > 0)
        {
            CODAContext.SetService(true);
            CODATestIDMapExt.load(SUFFIX);
            CODAUnitOfWork.getCurrent();

            CODAVolumeDataTestHelper.addPurchaseInvoiceLineItems(INVOICE_NAME + 2,PROD_NAME,LINEITEM_QUANTITY,UNITPRICE,null,TAX_CODE,null,DIMENSION1_NAME,DIMENSION2_NAME,DIMENSION3_NAME,DIMENSION4_NAME,201,(m_remainingPayableLinesToCreate + 200),false,false,10);

            CODAUnitOfWork.getCurrent().commitWork();
            CODATestIDMapExt.save(SUFFIX);
        }
    }
    
    //Create PCN 1
    public static void createDataExt25()
    {   
        CODAContext.SetService(true);
        CODATestIDMapExt.load(SUFFIX);
        CODAUnitOfWork.getCurrent();
        
        Date creditNoteDate=system.date.today();
        Date dueDate=system.date.today() + 30;
        CODAPurchaseCreditNote creditnote = CODAVolumeDataTestHelper.createPurchaseCreditNote(ACCOUNT_NAME,creditNoteDate,dueDate,DOCUMENT_CURRENCY,CREDITNOTE_NUMBER + '1',CREDITNOTE_REF);
        CODAUnitOfWork.getCurrent().commitWork();
        CODATestIDMapExt.put(CREDITNOTE_NAME + 1, creditnote.getId()); 

        CODAUnitOfWork.getCurrent();
        CODAVolumeDataTestHelper.addPurchaseCreditNoteExpLineItems(CREDITNOTE_NAME + 1,GLA_NAME,UNITPRICE,TAX_CODE,null,null,DIMENSION1_NAME,DIMENSION2_NAME,DIMENSION3_NAME,DIMENSION4_NAME,1,TOTAL_EXP_LINE_ITEMS ,false,false,10);
        CODAVolumeDataTestHelper.addPurchasecreditNoteLineItems(CREDITNOTE_NAME + 1,PROD_NAME,LINEITEM_QUANTITY,UNITPRICE,null,TAX_CODE,null,DIMENSION1_NAME,DIMENSION2_NAME,DIMENSION3_NAME,DIMENSION4_NAME,1,TOTAL_PROD_LINE_ITEMS ,false,false,10);
        
        CODAUnitOfWork.getCurrent().commitWork();
        
        CODATestIDMapExt.save(SUFFIX);
    }
    
    //Create PCN 2
    public static void createDataExt26()
    {   
        CODAContext.SetService(true);
        CODATestIDMapExt.load(SUFFIX);
        CODAUnitOfWork.getCurrent();
        
        Date creditNoteDate=system.date.today();
        Date dueDate=system.date.today() + 30;
        CODAPurchaseCreditNote creditnote = CODAVolumeDataTestHelper.createPurchaseCreditNote(ACCOUNT_NAME,creditNoteDate,dueDate,DOCUMENT_CURRENCY,CREDITNOTE_NUMBER + '2',CREDITNOTE_REF);
        CODAUnitOfWork.getCurrent().commitWork();
        CODATestIDMapExt.put(CREDITNOTE_NAME + 2, creditnote.getId()); 

        CODAUnitOfWork.getCurrent();
        CODAVolumeDataTestHelper.addPurchaseCreditNoteExpLineItems(CREDITNOTE_NAME + 2,GLA_NAME,UNITPRICE,TAX_CODE,null,null,DIMENSION1_NAME,DIMENSION2_NAME,DIMENSION3_NAME,DIMENSION4_NAME,1,TOTAL_EXP_LINE_ITEMS,false,false,10);
        CODAVolumeDataTestHelper.addPurchasecreditNoteLineItems(CREDITNOTE_NAME + 2,PROD_NAME,LINEITEM_QUANTITY,UNITPRICE,null,TAX_CODE,null,DIMENSION1_NAME,DIMENSION2_NAME,DIMENSION3_NAME,DIMENSION4_NAME,1,TOTAL_PROD_LINE_ITEMS,false,false,10);
        
        CODAUnitOfWork.getCurrent().commitWork();
        
        CODATestIDMapExt.save(SUFFIX);
    }

    //Destroy the data.
    public static void destroyData()
    {
        CODAUnitOfWork.createAndSetCurrent();
        CODAContext.enableSupportAccess(); 

        CODAPaymentData.destroyPaymentData(SUFFIX);
        delete[select id from codaAccountingSettings__c ];

        List<Account> accs = [Select Id, Name from Account where MirrorName__c = :ACCOUNT_NAME];
        if(!accs.isEmpty())
        {
            Account acc = accs[0];
            acc.CODAAccountsPayableControl__c = null;
            update acc;
        }

        delete [Select Id, Name,CODAPurchaseAnalysisAccount__c from Product2  where Name like :PROD_NAME + '%'];
        delete[Select Id, Name from CODAGeneralLedgerAccount__c where Name like :GLA_NAME + '%'];
        CODAVolumeBaseData.destroyVolumeData();
        CODAContext.disableSupportAccess();
    }
    
    public static void loadMap()
    {
        // GLAs
        Set<String> glaNames = new Set<String>();
        glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLGBP);
        glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLGBP);
        for (CODAGeneralLedgerAccount__c item : [Select Id, Name from CODAGeneralLedgerAccount__c where Name in :glaNames])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }
        
        // Company
        CODACompany company = CODACompanyMapExt.getCurrentCompany();
        Id compId = company.getId();
        
        // Periods for Merlin Auto Spain
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
        accNames.add(ACCOUNT_NAME);
        for (Account accId : [Select Id, Name from Account where MirrorName__c in :accNames])
        {
            CODATestIDMapExt.put(accId.Name, accId.id);
        }
        
        // Tax Codes
        Set<String> taxNames = new Set<String>();
        taxNames.add(TAX_CODE);
        for (codaTaxCode__c item : [Select Id, Name from codaTaxCode__c where Name in :taxNames])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }

        //Dimension1
        Set<String> dimNames1 = new Set<String>();
        dimNames1.add(CODABaseDataExt.NAMEDIM1_GBP);
        for (codaDimension1__c  item : [Select Id, Name from codaDimension1__c  where Name in :dimNames1])
        {
            CODATestIDMapExt.put(item.Name , item.id);
        }
        
        //New Dimension1
        for (codaDimension1__c  item : [Select Id, Name from codaDimension1__c  where Name like 'Dim 1-GBP-%'])
        {
            CODATestIDMapExt.put(item.Name , item.id);
        }
        
        //Dimension2
        Set<String> dimNames2 = new Set<String>();
        dimNames2.add(CODABaseDataExt.NAMEDIM2_GBP);
        for (codaDimension2__c  item : [Select Id, Name from codaDimension2__c  where Name in :dimNames2])
        {
            CODATestIDMapExt.put(item.Name , item.id);
        }
        
        //New Dimension2
        for (codaDimension2__c  item : [Select Id, Name from codaDimension2__c  where Name like 'Dim 2-GBP-%'])
        {
            CODATestIDMapExt.put(item.Name , item.id);
        }
        
        //Dimension3
        Set<String> dimNames3 = new Set<String>();
        dimNames3.add(CODABaseDataExt.NAMEDIM3_GBP);
        for (codaDimension3__c  item : [Select Id, Name from codaDimension3__c  where Name in :dimNames3])
        {
            CODATestIDMapExt.put(item.Name , item.id);
        }
        
        //New Dimension3
        for (codaDimension3__c  item : [Select Id, Name from codaDimension3__c  where Name like 'Dim 3-GBP-%'])
        {
            CODATestIDMapExt.put(item.Name , item.id);
        }
        
        //Dimension4
        Set<String> dimNames4 = new Set<String>();
        dimNames4.add(CODABaseDataExt.NAMEDIM4_GBP);
        for (codaDimension4__c  item : [Select Id, Name from codaDimension4__c  where Name in :dimNames4])
        {
            CODATestIDMapExt.put(item.Name , item.id);
        }
        
        //New Dimension4
        for (codaDimension4__c  item : [Select Id, Name from codaDimension4__c  where Name like 'Dim 4-GBP-%'])
        {
            CODATestIDMapExt.put(item.Name , item.id);
        }
        CODATestIDMapExt.save(SUFFIX);
    }

    public static void createGla(Integer startNum, Integer endNum)
    {
        CODAUnitOfWork.getCurrent();
        for(Integer i = startNum ; i <= endNum ;i += 20)
        {
            //Create GLAs.
            Integer j = i + 15;
            CODAVolumeBaseData.createGLAs(GLA_NAME, 'SEUR11', CODAGeneralLedgerAccount.TYPE_PROFITANDLOSS , EUR_CURRENCY, i , j);
            CODAVolumeBaseData.createGLAs(GLA_NAME, 'SUSD11' , CODAGeneralLedgerAccount.TYPE_PROFITANDLOSS , USD_CURRENCY ,j+1,j+1);
            CODAVolumeBaseData.createGLAs(GLA_NAME, 'SGBP11', CODAGeneralLedgerAccount.TYPE_PROFITANDLOSS , GBP_CURRENCY , j+2,j+2);
            CODAVolumeBaseData.createGLAs(GLA_NAME, 'SAUD11', CODAGeneralLedgerAccount.TYPE_PROFITANDLOSS , AUD_CURRENCY , j+3,j+3 );
            CODAVolumeBaseData.createGLAs(GLA_NAME, 'SJPY11', CODAGeneralLedgerAccount.TYPE_PROFITANDLOSS , JPY_CURRENCY , j+4,j+4);
        }
        CODAUnitOfWork.getCurrent().commitWork();
    }
    
    //Method for creating product
    private static void createProducts(Integer startNum, Integer endNum) 
    {
        CODAUnitOfWork.getCurrent();
        for(Integer i = startNum ; i <= endNum; i = i + 20)
        {
            Integer j = i + 15;
            createProduct(PROD_NAME, 'GLA_EUR_',i,j,true);
            createProduct(PROD_NAME, 'GLA_USD_1',j+1,j+1,false);
            createProduct(PROD_NAME, 'GLA_GBP_1',j+2,j+2,false);
            createProduct(PROD_NAME, 'GLA_AUD_1',j+3,j+3,false);
            createProduct(PROD_NAME, 'GLA_JPY_1',j+4,j+4,false);
        }
        CODAUnitOfWork.getCurrent().commitWork();
    }

    //Create Products
    public static void createProduct(String ProductName, String PurchaseAnalysisAccount,Integer startnum,Integer endnum,boolean differentPAAccount)
    {
        integer glaCount=1;
        Set<String> productNames = new Set<String>();
        for(Integer count=startnum;count<=endnum;count++)        
        {
            CODAProduct2 newProduct= CODAProduct2.create();
            String prodName=ProductName+count;
            newProduct.setName(prodName);
            if(differentPAAccount)
            {
                string newPAAccount=PurchaseAnalysisAccount+glaCount;
                Id glaId = CODAGeneralLedgerAccountMapper.getByName(newPAAccount)[0].getId();
                newProduct.setPurchaseAnalysisAccountId(glaId);
                glaCount++;
            }
            else
            {
                Id glaId = CODAGeneralLedgerAccountMapper.getByName(PurchaseAnalysisAccount)[0].getId();
                newProduct.setPurchaseAnalysisAccountId(glaId);
            }
            
            productNames.add(prodName);
        }
    }
}
