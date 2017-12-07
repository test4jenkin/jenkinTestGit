/*
 * Copyright (c) 2017 FinancialForce.com, inc. All rights reserved.
 */

public class CODATID021088Data {
    
    public static String SUFFIX = '#TID021088';
    public static String COMPANY_NAME = CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN;
	public static String COMPANY_NAME_GB = CODABaseData.NAMECOMPANY_MERLINAUTOGB;
    
    /**
    * select the current company
    */
    public static void selectCompany()
    {
        CODABaseData.switchCurrentCompany(COMPANY_NAME, true, true, userinfo.getUserId());
		CODACompanyMapExt.resetCompanyCache();
    }
    
    /*Create General Ledger Accounts*/
    public static void createData()
    {        
        loadMap();
        CODAUnitOfWork.createAndSetCurrent(); 
        createGLA();
        CODATestIDMapExt.save(SUFFIX);  
    }
    
    /*Create Accounts*/
    public static void createDataExt1()
    {        
        CODAUnitOfWork.createAndSetCurrent(); 
        createAccounts();
        CODATestIDMapExt.save(SUFFIX);  
    }
    
    /*Create Products*/
    public static void createDataExt2()
    {        
        CODAUnitOfWork.createAndSetCurrent(); 
        createProduct();
        CODATestIDMapExt.save(SUFFIX);  
    }
	
	/*Switch Current Company*/
    public static void createDataExt3()
    {        
       switchCompany(COMPANY_NAME_GB);
    }
    
    public static void createGLA()
    {
        //create GLAs
        list<CodaGeneralLedgerAccount__c> glaAccountList = new list<CodaGeneralLedgerAccount__c>();
        for(Integer i = 1; i< =60; i++)
        {
            glaAccountList.add(new codaGeneralLedgerAccount__c(Name = 'VolumeAccGLA'+i, 
                ReportingCode__c = 'AccGLA'+i, Type__c = 'Profit and Loss', AllowRevaluation__c = True));
            
        }
        insert glaAccountList; 
        
        list<CodaGeneralLedgerAccount__c> glaProductList = new list<CodaGeneralLedgerAccount__c>();
        for(Integer i = 1; i< =4740; i++)
        {
            glaProductList.add(new codaGeneralLedgerAccount__c(Name = 'VolumeProdGLA'+i, 
                ReportingCode__c = 'ProGLA'+i, Type__c = 'Profit and Loss', AllowRevaluation__c = True));
            
        }
        insert glaProductList ;
    }    
    
    public static void createAccounts()
    {
        //Create Accounts
        String accName;
        list<CodaGeneralLedgerAccount__c> accGlaList = [Select Id, Name from CodaGeneralLedgerAccount__c where Name like 'VolumeAccGLA%'];
        list<Account> accList1 = new list<Account>();
        list<Account> accList2 = new list<Account>();
        for(Integer i = 1; i<=30; i++)
        {
            accList1.add(new Account(Name = 'TRVolumeAcc - '+ i, CODAAccountTradingCurrency__c = 'EUR', 
                    CODAAccountsReceivableControl__c = accGlaList[i-1].Id, CODADescription1__c = 'SVolumeAccountIS - ', CODADiscount1__c = 0, CODADaysOffset1__c = 10, CODABaseDate1__c = 'Invoice Date'));
        }
        insert accList1;
        
        for(Integer j = 31; j<=60; j++)
        {
            accList2.add(new Account(Name = 'TRVolumeAcc - '+ j, CODAAccountTradingCurrency__c = 'EUR', 
                    CODAAccountsPayableControl__c = accGlaList[j-1].Id, CODADescription1__c = 'SVolumeAccountIS - ', CODADiscount1__c = 0, CODADaysOffset1__c = 10, CODABaseDate1__c = 'Invoice Date'));
        }
        insert accList2;
    }
    
    public static void createProduct()
    {
        //Create Products
        list<CodaGeneralLedgerAccount__c> proGlalist = [Select Id, Name from CodaGeneralLedgerAccount__c where Name like 'VolumeProdGLA%'];
        list<Product2> productList1 = new list<Product2>();
        for(Integer i=1; i<=2370; i++)
        {
            productList1.add(new Product2(Name = 'TRVolumePro - ' + i, ProductCode = 'SVolumeProductIS' + i, CODASalesRevenueAccount__c = proGlalist[i-1].Id, IsActive = true));
        }
        insert productList1;
        
        list<Product2> productList2 = new list<Product2>();
        for(Integer j=2371; j<=4740; j++)
        {
            productList2.add(new Product2(Name = 'TRVolumePro - ' + j, ProductCode = 'SVolumeProductIS' + j, IsActive = true, CODAPurchaseAnalysisAccount__c = proGlalist[j-1].Id));
        }
        insert productList2;
    }
    
    //Create Sales Invoice with Line Items
    public static void createSalesInvoice(Integer startProduct,Integer startAccount,Integer lastAccount, Date myDate)
    {
        Integer k=startProduct;
        Integer t=startProduct;
        integer j=0;
        List<Product2> prodList = [Select id, Name from Product2 where Name like 'TRVolumePro%'and CODASalesRevenueAccount__c != null];
        List<Account> acc = [select Id, Name from Account where MirrorName__c  like 'TRVolumeAcc%' and CODAAccountsReceivableControl__c != null];
        List<CODAAPIInvoiceTypes_9_0.Invoice> invList = new List<CODAAPIInvoiceTypes_9_0.Invoice>();
        String productName;
        for (integer i =startAccount; i <lastAccount; i++)
        {
            CODAAPIInvoiceTypes_9_0.Invoice inv = new CODAAPIInvoiceTypes_9_0.Invoice();
            CODAAPICommon.Reference ref = new CODAAPICommon.Reference();
            ref.Id = acc[i].Id;
            inv.Account = ref;
            inv.InvoiceDate = myDate;
            ref = new CODAAPICommon.Reference();
            inv.InvoiceStatus = CODAAPIInvoiceTypes_9_0.enumInvoiceStatus.InProgress;
            inv.LineItems = new CODAAPIInvoiceLineItemTypes_9_0.InvoiceLineItems();
            inv.LineItems.LineItemList = new List<CODAAPIInvoiceLineItemTypes_9_0.InvoiceLineItem>();
            for (j = 0; j <79 && t<79+k; j++)
            {
                CODAAPIInvoiceLineItemTypes_9_0.InvoiceLineItem lineItem = new CODAAPIInvoiceLineItemTypes_9_0.InvoiceLineItem();
                ref = new CODAAPICommon.Reference();
                ref.Name = prodList[t].Name;
                t++;
                lineItem.Product = ref;
                lineItem.Quantity = 1;
                lineItem.UnitPrice = 100;
                inv.LineItems.LineItemList.add(lineItem);
            }
            invList.add(inv);
            myDate = mydate.addDays(31);
            k=t;
        }
        
        List<CODAAPICommon.Reference> references = CODAAPISalesInvoice_9_0.BulkCreateInvoice(null, invList);
    }
    
    //Post Sales Invoices
    public static void postSalesInvoices(Integer numOfInvoice)
    {
        //CODAContext.SetService(true); 
        CODAUnitOfWork.getCurrent();
        CODATestIDMapExt.load(SUFFIX);     
        CODAAPICommon_9_0.Context context = new CODAAPICommon_9_0.Context();
        context.token = getAPIToken();
        List<CODAAPICommon.Reference> invoiceRefList = new List<CODAAPICommon.Reference>();
        List<codaInvoice__c> invoicelist = [Select Id,Name from codaInvoice__c where InvoiceStatus__c = :CODAInvoice.INVOICESTATUS_INPROGRESS limit :numOfInvoice];
        
        for (codaInvoice__c invoice: invoicelist)
        {
            CODAAPICommon.Reference ref = CODAAPICommon.getRef(invoice.Id, invoice.Name);
            invoiceRefList.add(ref);
            System.debug('IN INVOICE LIST - '+invoice);
        }
        
        CODAAPISalesInvoice_9_0.BulkPostInvoice(context, invoiceRefList);
        System.debug('POSTING COMPLETED of size- '+invoiceRefList.size());
    }
    
    public static void createPinvs(Integer startProduct,Integer startAccount,Integer lastAccount, Date myDate)
    {
        Integer k=startProduct,t=startProduct;
        integer j=0;
        List<CODAAPIPurchaseInvoiceTypes_9_0.PurchaseInvoice> invoiceLst = new List<CODAAPIPurchaseInvoiceTypes_9_0.PurchaseInvoice>();
        List<Product2> prodList = [Select id, Name from Product2 where Name like 'TRVolumePro%' and CODAPurchaseAnalysisAccount__c != null];
        List<Account> acc = [select Id, Name from Account where MirrorName__c  like 'TRVolumeAcc%' and CODAAccountsPayableControl__c !=null];
        for(integer i=startAccount; i<lastAccount;i++)
        {
            CODAAPIPurchaseInvoiceTypes_9_0.PurchaseInvoice inv = new CODAAPIPurchaseInvoiceTypes_9_0.PurchaseInvoice();

            CODAAPICommon.Reference ref = new CODAAPICommon.Reference();
            ref.Id = acc[i].Id;
            inv.Account = ref;
            inv.DueDate = myDate;
            ref = new CODAAPICommon.Reference();
            ref.Name = 'EUR';
            inv.InvoiceCurrency = ref;
            inv.InvoiceDate = myDate;
            inv.AccountInvoiceNumber = 'PIN'+i;
            inv.InvoiceStatus = CODAAPIPurchaseInvoiceTypes_9_0.enumInvoiceStatus.InProgress;
            inv.LineItems = new CODAAPIPurchaseInvoiceLineItemTypes_9_0.PurchaseInvoiceLineItems();
            inv.LineItems.LineItemList = new List<CODAAPIPurchaseInvoiceLineItemTypes_9_0.PurchaseInvoiceLineItem>();

            for (j = 0; j < 79 && t<79+k; j++)
            {
                CODAAPIPurchaseInvoiceLineItemTypes_9_0.PurchaseInvoiceLineItem lineItem = new CODAAPIPurchaseInvoiceLineItemTypes_9_0.PurchaseInvoiceLineItem();
                ref = new CODAAPICommon.Reference();
                ref.Name = prodList[t].Name;
                t++;
                lineItem.Product = ref;
                lineItem.Quantity = 1;
                lineItem.UnitPrice = 100;
                inv.LineItems.LineItemList.add(lineItem);
            } 
            invoiceLst.add(inv);
            myDate = mydate.addDays(31);
           k=t;
        }
        List<CODAAPICommon.Reference> referLst = CODAAPIPurchaseInvoice_9_0.BulkCreatePurchaseInvoice(null, invoiceLst);
    }
    
    //Post PurchaseInvoices
    public static void postPurchaseInvoices(Integer numOfPurchaseInvoice)
    {
        //CODAContext.SetService(true); 
        CODAUnitOfWork.getCurrent();
        CODATestIDMapExt.load(SUFFIX);     
        CODAAPICommon_9_0.Context context = new CODAAPICommon_9_0.Context();
        context.token = getAPIToken();
        List<CODAAPICommon.Reference> pinRefList = new List<CODAAPICommon.Reference>();
        List<codaPurchaseInvoice__c> pinlist = [Select Id,Name from codaPurchaseInvoice__c where InvoiceStatus__c = :CODAPurchaseInvoice.INVOICESTATUS_INPROGRESS limit :numOfPurchaseInvoice];
        
        for (codaPurchaseInvoice__c purchaseInvoice: pinlist)
        {
            CODAAPICommon.Reference ref = CODAAPICommon.getRef(purchaseInvoice.Id, purchaseInvoice.Name);
            pinRefList.add(ref);
            System.debug('IN INVOICE LIST - '+purchaseInvoice);
        }
        
        CODAAPIPurchaseInvoice_9_0.BulkPostPurchaseInvoice(context,pinRefList);
        System.debug('POSTING COMPLETED of size- '+pinRefList.size());
    }
	
	// Switch current company
	public static void switchCompany(String companyName)
	{
		CODABaseData.switchCurrentCompany(companyName, true, true, UserInfo.getUserId());
		CODACompanyMapExt.resetCompanyCache();
	}
    
    //Get API Token
    public static string getAPIToken() 
    {
        return EncodingUtil.convertToHex(Crypto.generateDigest('SHA1',Blob.valueOf('0000000000000000C000000000000046' + UserInfo.getUserId() + 'PROBABLEMENTE EL MEJOR SOFTWARE DE CONTABILIDAD EN EL MUNDO')));
    }  
	
    // Delete Transaction Line Items
    public static void destroyData()
    {
		CODATestIDMapExt.load(SUFFIX);
        CODAUnitOfWork.createAndSetCurrent();
        CODAContext.enableSupportAccess();
        delete [select Id from CODAInvoice__c];
        delete [select Id from CODATransaction__c];
        delete [select Id from CODAPurchaseInvoice__c];
        delete [select Id from Account where MirrorName__c like 'TRVolume%'];
        delete [select Id from CodaGeneralLedgerAccount__c where Name like 'Volume%'];
        delete [select Id from Product2 where Name like 'TRVolume%'];
        CODAContext.disableSupportAccess();
		CODATestIDMapExt.purge(SUFFIX);
    }
	
	public static void destroyDataExt1()
    {
	    CODAUnitOfWork.createAndSetCurrent();
        CODAContext.enableSupportAccess();
        delete [select Id from TransactionReconciliation__c];
        CODAContext.disableSupportAccess();
	}
    
    public static void loadMap()
    {
        // Company
        CODACompany company = CODACompanyMapExt.getCurrentCompany();
        Id compId = company.getId();
        CODATestIDMapExt.put(company.getName(), compId);
		
		CODACompany compGB = CODACompanyMapper.getByName( COMPANY_NAME_GB)[0];
        Id compIdGB = compGB.getId();
        CODATestIDMapExt.put(COMPANY_NAME_GB, compIdGB);
        
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

		//Currencies for Merlin Auto GB
        for (codaAccountingCurrency__c accCurrGB : [Select Id, Name, OwnerCompany__r.Name from codaAccountingCurrency__c where OwnerCompany__c  = :compIdGB])
        {
            CODATestIDMapExt.put(accCurrGB.Name + ':' + accCurrGB.OwnerCompany__r.Name, accCurrGB.id);
        }
        
        for (CODAGeneralLedgerAccount__c item : [Select Id, Name from CODAGeneralLedgerAccount__c])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }
        
        CODATestIDMapExt.save(SUFFIX);
    } 
}