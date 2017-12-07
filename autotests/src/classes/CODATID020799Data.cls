/*
 * Copyright (c) 2017 FinancialForce.com, inc. All rights reserved.
 */
 
public class CODATID020799Data
{
    public static final String SUFFIX = '#TID020799';
    public static final string COMPANY_NAME_SPAIN = CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN;
	public static final string COMPANY_NAME_USA = CODABaseData.NAMECOMPANY_MERLINAUTOUSA;
	public static final String PERIODNAME_CURRENT = CODAPeriodMapExt.getPeriodByDate(system.today()).getName();
    public static final String INTERCOMACC_SIN1 = 'SIN003';
	public static final String INTERCOMACC_SPAIN = 'Intercompany Spain Account';
	public static final String INTERCOMACC_USA = 'Intercompany USA Account';
	public static final String CURRENCY_USD = CODABaseData.CURRENCYCODE_USD;
    public static final String CURRENCY_GBP = CODABaseData.CURRENCYCODE_GBP;
	public static final String ICD_SPAIN_USA = 'Spain to USA';
	public static final String ICD_USA_SPAIN = 'USA to Spain';
	public static final String LINE_DESCRIPTION = 'Line Description';	
    
	public static void selectCompany()
    {
		switchCompany(COMPANY_NAME_SPAIN);
    }

    // Create intercompany definition SPAIN to USA
	public static void createData()
	{
		loadMap();
		CODAUnitOfWork.createAndSetCurrent();

		//Create Intercompany Definition
		CODAIntercompanyDefinition icd = new CODAIntercompanyDefinition();
		icd.setRelatedCompanyId(CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOUSA));
		icd.setSendingControlAccountId(CODATestIDMap.resolve(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLEUR));
		icd.setReceivingControlAccountId(CODATestIDMap.resolve(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLEUR));
		icd.setOwnerCompanyId(CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN));
		icd.setAutoPost(true);
		icd.setAutoProcess(true);
		CODAUnitOfWork.getCurrent().commitWork();
		CODATestIDMapExt.put(ICD_SPAIN_USA, icd.getId());
		
		CODATestIDMapExt.save(SUFFIX);
	}
    
	// Switch current company to Merlin Auto USA
	public static void createDataExt1()
	{
		switchCompany(COMPANY_NAME_USA);
	}

	// Create intercompany definition for Merlin Auto USA to Merlin Auto USA
	public static void createDataExt2()
	{
		CODATestIDMapExt.load(SUFFIX);
		CODAUnitOfWork.createAndSetCurrent();

		CODAIntercompanyDefinition interCompany2 = new CODAIntercompanyDefinition();
		interCompany2.setRelatedCompanyId(CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN));
		interCompany2.setSendingControlAccountId(CODATestIDMap.resolve(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLUSD));
		interCompany2.setReceivingControlAccountId(CODATestIDMap.resolve(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD));
		interCompany2.setOwnerCompanyId(CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOUSA));
		interCompany2.setAutoPost(true);
		interCompany2.setAutoProcess(true);
		CODAUnitOfWork.getCurrent().commitWork();
		CODATestIDMapExt.put(ICD_USA_SPAIN, interCompany2.getId());

		CODATestIDMapExt.save(SUFFIX);
	}

	//Switch current company to Merlin Auto Spain
	public static void createDataExt3()
	{
		switchCompany(COMPANY_NAME_SPAIN);
	}
	
	// Create sales invoices Intercompany Account
	public static void createDataExt4()
	{
		CODATestIDMapExt.load(SUFFIX);
		//Sales Invoice header          
		CODAInvoiceTestHelper salesInv = new CODAInvoiceTestHelper();
		salesInv.setAccount(INTERCOMACC_USA);
		salesInv.setInvoiceDate(system.today());
		salesInv.setDueDate(system.today()+60);
		salesInv.setPeriod(PERIODNAME_CURRENT+ ':' +COMPANY_NAME_SPAIN);
		salesInv.setInvoiceCurrency(CODABaseData.CURRENCYCODE_GBP);
		salesInv.setInvoiceDescription(SUFFIX);
		 
		//Product line without override Local GLA
		CODAInvoiceTestHelper.LineItem line1 = salesInv.newLine();
		line1.setProduct(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		line1.setQuantity(1);
		line1.setUnitPrice(100);
		line1.setTaxCode1(null);
		line1.setLineDescription(INTERCOMACC_SIN1+LINE_DESCRIPTION+'1');
		salesInv.save();
		salesInv.reload();
		CODATestIDMapExt.put(INTERCOMACC_SIN1, salesInv.getId());
		CODATestIDMapExt.save(SUFFIX);
	}	
	
	// Post sales invoice
	public static void createDataExt5()
	{
		CODATestIDMapExt.load(SUFFIX);
		CODAInvoiceTestHelper invoice = new CODAInvoiceTestHelper(INTERCOMACC_SIN1);
		system.assertEquals(CODAInvoice.INVOICESTATUS_INPROGRESS, invoice.getInvoiceStatus());
		invoice.post();
		invoice.reload();
	}
	// Switch current company
	public static void switchCompany(String companyName)
	{
		CODABaseData.switchCurrentCompany(companyName, true, true, UserInfo.getUserId());
		CODACompanyMapExt.resetCompanyCache();
	}
	
	// Destroy data
	public static void destroyData()
    {
        CODATestIDMapExt.load(SUFFIX);
        CODAUnitOfWork.createAndSetCurrent();
        CODAContext.enableSupportAccess();
        delete[select Id from codaTransaction__c];
		delete[select Id from CodaInvoice__c];
		delete[select Id from codaPurchaseInvoice__c];
		delete[select Id from codaIntercompanyDefinition__c];
		delete[select Id from codaIntercompanyTransfer__c];
        CODAContext.disableSupportAccess();
        CODATestIDMapExt.purge(SUFFIX);
    }
    
	// LoadMap method to load base data into Coda Test Id Map
    public static void loadMap()
    {
        //Company
        CODACompany compVAT = CODACompanyMapper.getByName( COMPANY_NAME_SPAIN)[0];
        Id compId = compVAT.getId();
        CODATestIDMapExt.put(COMPANY_NAME_SPAIN, compId);
        
		CODACompany compUSA = CODACompanyMapper.getByName( COMPANY_NAME_USA)[0];
        Id compIdUSA = compUSA.getId();
        CODATestIDMapExt.put(COMPANY_NAME_USA, compIdUSA);
		
        //Spain Period
        codaPeriod__c periodSpain = [Select Id, Name, OwnerCompany__r.Name from codaPeriod__c where Name = :PERIODNAME_CURRENT AND OwnerCompany__c = :compId limit 1];
        CODATestIDMapExt.put(PERIODNAME_CURRENT + ':' +  COMPANY_NAME_SPAIN, periodSpain.id);
        
        //Currencies for Merlin Auto Spain
        for (codaAccountingCurrency__c accCurrSpain : [Select Id, Name, OwnerCompany__r.Name from codaAccountingCurrency__c where OwnerCompany__c  = :compId])
        {
            CODATestIDMapExt.put(accCurrSpain.Name + ':' + accCurrSpain.OwnerCompany__r.Name, accCurrSpain.id);
        }
        //Currencies for Merlin Auto USA
        for (codaAccountingCurrency__c accCurrUSA : [Select Id, Name, OwnerCompany__r.Name from codaAccountingCurrency__c where OwnerCompany__c  = :compIdUSA])
        {
            CODATestIDMapExt.put(accCurrUSA.Name + ':' + accCurrUSA.OwnerCompany__r.Name, accCurrUSA.id);
        }
        //Accounts
        Set<String> accNames = new Set<String>();
        accNames.add(INTERCOMACC_USA);
        accNames.add(INTERCOMACC_SPAIN);
        for (Account accId : [Select Id, Name from Account where MirrorName__c in :accNames])
        {
            CODATestIDMapExt.put(accId.Name, accId.id);
        }
        
        //Product
        Product2  item = [Select Id, Name from Product2  where Name =: CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH];
        CODATestIDMapExt.put(item.Name, item.id);
        
		//GLAs
        Set<String> glaNames = new Set<String>();
        glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLEUR);
        glaNames.add(CODABaseData.NAMEGLA_SALESPARTS);
        glaNames.add(CODABaseData.NAMEGLA_STOCKPARTS);
        glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLEUR);
        glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD);
        glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLUSD);
        for(CODAGeneralLedgerAccount__c gla: [Select Id, Name from CODAGeneralLedgerAccount__c where Name in :glaNames])
        {
            CODATestIDMapExt.put(gla.Name, gla.id);
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
       
        CODATestIDMapExt.save(SUFFIX);
    }
}