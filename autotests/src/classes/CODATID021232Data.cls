/*
 *  Copyright (c) 2017 FinancialForce.com, inc. All rights reserved
 */

public class CODATID021232Data
{
    public static String COMPANY_SPAIN = CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN;
    public static String COMPANY_GB = CODABaseData.NAMECOMPANY_MERLINAUTOGB;
    public static final string COMPANY_USA = CODABaseData.NAMECOMPANY_MERLINAUTOUSA;
    public static String SUFFIX = '#TID021232#';
    public static final String PERIODNAME_CURRENT = CODAPeriodMapExt.getPeriodByDate(system.today()).getName();
    public static final String INTERCOMACC_USA = 'Intercompany USA Account';
    public static final String INTERCOMACC_SPAIN = 'Intercompany SPAIN Account';
    public static String SINV1 = 'SIN001';
    public static String SINV2 = 'SIN002';
    public static String FixedAR1 = 'FixedAR1';
    public static String FixedAR2 = 'FixedAR2';
    public static final String INTERCOMACC_SIN1 = 'SIN003';
    public static final String ICD_SPAIN_USA = 'Spain to USA';
    public static final String ICD_USA_SPAIN = 'USA to Spain';
    public static String ALLOCATION_RULE_NAME_1 = 'FixedAR_1';
    public static String ALLOCATION_RULE_NAME_2 = 'FixedAR_2';
    public static String ALLOCATION_RULE_DESCRIPTION_1 = 'Active allocation rule 1';
    public static String ALLOCATION_RULE_DESCRIPTION_2 = 'Inactive allocation rule 2';
	public static final Date ALLOCATIONSDATE = System.today();
    public static Double PERCENTAGE_1 = 20.00;
    public static Double PERCENTAGE_2 = 30.00;
    public static Double PERCENTAGE_3 = 40.00;
    public static Double PERCENTAGE_4 = 10.00;
    public static Double PERCENTAGE_5 = 50.00;
	public static String DOCUMENT_DESC = 'Fixed Allocation single company mode';
    
    public static void selectCompany()
    {
        CODABaseData.switchCurrentCompany(COMPANY_SPAIN, true, true, UserInfo.getUserId());
    }

    public static void switchProfile()
    {
        Id userId = CODABaseData.getProfile(CODABaseData.ACCOUNTANT).Id;
        CODABaseData.switchCurrentCompany(COMPANY_SPAIN, true, false, userId);
    }

    public static void createData()
    {
        loadmap();
        CODAUnitOfWork.createAndSetCurrent();
       
        //Sales Invoice header          
        CODAInvoiceTestHelper salesInv = new CODAInvoiceTestHelper();
        salesInv.setAccount(CODABaseDataExt.NAMEACCOUNT_CAMBRIDGEAUTO);
        salesInv.setInvoiceDate(system.today());
        salesInv.setDueDate(system.today()+60);
        salesInv.setPeriod(PERIODNAME_CURRENT+ ':' +COMPANY_SPAIN);
        salesInv.setInvoiceCurrency(CODABaseData.CURRENCYCODE_GBP);
         
        //Product line 1
        CODAInvoiceTestHelper.LineItem line1 = salesInv.newLine();
        line1.setProduct(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
        line1.setQuantity(1);
        line1.setUnitPrice(74.5);
        line1.setTaxCode1(CODABaseDataExt.NAMETAXCODE_VOSTDSALES);
        line1.setTaxValue1(13.04);
        line1.setDimension1(CODABaseDataExt.NAMEDIM1_EUR);
        line1.setDimension2(null);
        line1.setDimension3(CODABaseDataExt.NAMEDIM3_EUR);
        line1.setDimension4(null);
        
        salesInv.saveAndPost();
        
        CODATestIDMapExt.put(SINV1, salesInv.getId());
        CODATestIDMapExt.save(SUFFIX);
    }
    
    // Create intercompany definition SPAIN to USA
    public static void createDataExt1()
    {
        CODATestIDMapExt.load(SUFFIX);
        CODAUnitOfWork.createAndSetCurrent();

        //Create Intercompany Definition
        CODAIntercompanyDefinition icd = new CODAIntercompanyDefinition();
        icd.setRelatedCompanyId(CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOUSA));
        icd.setSendingControlAccountId(CODATestIDMap.resolve(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLUSD));
        icd.setReceivingControlAccountId(CODATestIDMap.resolve(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLEUR));
        icd.setOwnerCompanyId(CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN));
        icd.setAutoPost(true);
        icd.setAutoProcess(true);
        CODAUnitOfWork.getCurrent().commitWork();
        CODATestIDMapExt.put(ICD_SPAIN_USA, icd.getId());
        
        CODATestIDMapExt.save(SUFFIX);
    }
    
    // Switch current company to Merlin Auto USA
    public static void createDataExt2()
    {
        switchCompany(COMPANY_USA);
    }
    
    // Create intercompany definition for Merlin Auto USA to Merlin Auto Spain
    public static void createDataExt3()
    {
        CODATestIDMapExt.load(SUFFIX);
        CODAUnitOfWork.createAndSetCurrent();

        CODAIntercompanyDefinition interCompany2 = new CODAIntercompanyDefinition();
        interCompany2.setRelatedCompanyId(CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN));
        interCompany2.setSendingControlAccountId(CODATestIDMap.resolve(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLEUR));
        interCompany2.setReceivingControlAccountId(CODATestIDMap.resolve(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD));
        interCompany2.setOwnerCompanyId(CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOUSA));
        interCompany2.setAutoPost(true);
        interCompany2.setAutoProcess(true);
        CODAUnitOfWork.getCurrent().commitWork();
        CODATestIDMapExt.put(ICD_USA_SPAIN, interCompany2.getId());
        CODATestIDMapExt.save(SUFFIX);
    }

    //Switch current company to Merlin Auto Spain
    public static void createDataExt4()
    {
        switchCompany(COMPANY_SPAIN);
    }
    
    // Create sales invoices Intercompany Account
    public static void createDataExt5()
    {
        CODATestIDMapExt.load(SUFFIX);
        //Sales Invoice header          
        CODAInvoiceTestHelper salesInv = new CODAInvoiceTestHelper();
        salesInv.setAccount(INTERCOMACC_USA);
        salesInv.setInvoiceDate(system.today());
        salesInv.setDueDate(system.today()+60);
        salesInv.setPeriod(PERIODNAME_CURRENT+ ':' +COMPANY_SPAIN);
        salesInv.setInvoiceCurrency(CODABaseData.CURRENCYCODE_GBP);
        salesInv.setInvoiceDescription(SUFFIX);
         
        //Product line without override Local GLA
        CODAInvoiceTestHelper.LineItem line1 = salesInv.newLine();
        line1.setProduct(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
        line1.setQuantity(1);
        line1.setUnitPrice(350);
        line1.setTaxCode1(null);
        line1.setDimension1(CODABaseDataExt.NAMEDIM1_EUR);
        line1.setDimension2(null);
        line1.setDimension3(CODABaseDataExt.NAMEDIM3_EUR);
        line1.setDimension4(null);
        salesInv.saveAndPost();
        salesInv.reload();
        CODATestIDMapExt.put(INTERCOMACC_SIN1, salesInv.getId());
        CODATestIDMapExt.save(SUFFIX);
    }   
    
    //Switch current company to Merlin Auto GB
    public static void createDataExt6()
    {
        switchCompany(COMPANY_GB);
    }
    
    public static void createDataExt7()
    {
        CODATestIDMapExt.load(SUFFIX);
        CODAUnitOfWork.createAndSetCurrent();
       
        //Sales Invoice header          
        CODAInvoiceTestHelper salesInv = new CODAInvoiceTestHelper();
        salesInv.setAccount(CODABaseDataExt.NAMEACCOUNT_CAMBRIDGEAUTO);
        salesInv.setInvoiceDate(system.today());
        salesInv.setDueDate(system.today()+60);
        salesInv.setPeriod(PERIODNAME_CURRENT+ ':' +COMPANY_GB);
        salesInv.setInvoiceCurrency(CODABaseData.CURRENCYCODE_GBP);
         
        //Product line 1
        CODAInvoiceTestHelper.LineItem line1 = salesInv.newLine();
        line1.setProduct(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
        line1.setQuantity(1);
        line1.setUnitPrice(120);
        line1.setTaxCode1(CODABaseDataExt.NAMETAXCODE_VOSTDSALES);
        line1.setTaxValue1(21.00);
        line1.setDimension1(CODABaseDataExt.NAMEDIM1_EUR);
        line1.setDimension2(null);
        line1.setDimension3(CODABaseDataExt.NAMEDIM3_EUR);
        line1.setDimension4(null);
        
        salesInv.saveAndPost();
        
        CODATestIDMapExt.put(SINV2, salesInv.getId());
        CODATestIDMapExt.save(SUFFIX);
    }
    
    // Create an active Fixed Allocation rule 
    public static void CreateDataExt8()
    {
        CODATestIDMapExt.load(SUFFIX);
        CODAUnitOfWork.createAndSetCurrent();
        
        AllocationRule__c allocRule = new AllocationRule__c();
        allocRule.Type__c = Label.allocationTypeFixed;
        allocRule.Name = ALLOCATION_RULE_NAME_1;
        allocRule.Active__c = false;
        allocRule.Description__c = ALLOCATION_RULE_DESCRIPTION_1;
        insert allocRule;
        
        List<FixedAllocationRuleLine__c> allocFixedRuleLines = new List<FixedAllocationRuleLine__c>();
        FixedAllocationRuleLine__c fixedallocRuleLine = new FixedAllocationRuleLine__c();
        fixedallocRuleLine.GeneralLedgerAccount__c = CODATestIDMap.resolve(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD);
        fixedallocRuleLine.Dimension1__c = CODATestIDMap.resolve(CODABaseDataExt.NAMEDIM1_USD);
        fixedallocRuleLine.Dimension2__c = CODATestIDMap.resolve(CODABaseDataExt.NAMEDIM2_USD);
        fixedallocRuleLine.Dimension3__c = CODATestIDMap.resolve(CODABaseDataExt.NAMEDIM3_USD);
        fixedallocRuleLine.Dimension4__c = CODATestIDMap.resolve(CODABaseDataExt.NAMEDIM4_USD);
        fixedallocRuleLine.Split__c = PERCENTAGE_1;
        fixedallocRuleLine.AllocationRule__c = allocRule.Id;
        allocFixedRuleLines.add(fixedallocRuleLine);
        
        FixedAllocationRuleLine__c fixedallocRuleLine1 = new FixedAllocationRuleLine__c();
        fixedallocRuleLine1.GeneralLedgerAccount__c = CODATestIDMap.resolve(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLEUR);
        fixedallocRuleLine1.Dimension1__c = CODATestIDMap.resolve(CODABaseData.s_apexEurDim001_name);
        fixedallocRuleLine1.Split__c = PERCENTAGE_2;
        fixedallocRuleLine1.AllocationRule__c = allocRule.Id;
        allocFixedRuleLines.add(fixedallocRuleLine1);
        
        FixedAllocationRuleLine__c fixedallocRuleLine2 = new FixedAllocationRuleLine__c();
        fixedallocRuleLine2.GeneralLedgerAccount__c = CODATestIDMap.resolve(CODABaseData.s_APEXTaxGLA_name);
        fixedallocRuleLine2.Dimension2__c = CODATestIDMap.resolve(CODABaseData.s_apexEurDim002_name);
        fixedallocRuleLine2.Split__c = PERCENTAGE_3;
        fixedallocRuleLine2.AllocationRule__c = allocRule.Id;
        allocFixedRuleLines.add(fixedallocRuleLine2);
        
        FixedAllocationRuleLine__c fixedallocRuleLine3 = new FixedAllocationRuleLine__c();
        fixedallocRuleLine3.GeneralLedgerAccount__c = CODATestIDMap.resolve(CODABaseData.NAMEGLA_BANKACCOUNTEUROSUS);
        fixedallocRuleLine3.Dimension3__c = CODATestIDMap.resolve(CODABaseData.s_apexEurDim003_name);
        fixedallocRuleLine3.Split__c = PERCENTAGE_4;
        fixedallocRuleLine3.AllocationRule__c = allocRule.Id;
        allocFixedRuleLines.add(fixedallocRuleLine3);
        insert allocFixedRuleLines;
        
        AllocationRule__c getAllocationRule = [SELECT Active__c FROM AllocationRule__c WHERE Id = :allocRule.Id];
        getAllocationRule.Active__c = true;
        update getAllocationRule;
        
        CODATestIDMapExt.put(FixedAR1, allocRule.Id);
        CODATestIDMapExt.save(SUFFIX);
    }
    
    // Create an inactive Fixed Allocation rule 
    public static void CreateDataExt9()
    {
        CODATestIDMapExt.load(SUFFIX);
        CODAUnitOfWork.createAndSetCurrent();
        
        AllocationRule__c allocRule2 = new AllocationRule__c();
        allocRule2.Type__c = Label.allocationTypeFixed;
        allocRule2.Name = ALLOCATION_RULE_NAME_2;
        allocRule2.Active__c = false;
        allocRule2.Description__c = ALLOCATION_RULE_DESCRIPTION_2;
        insert allocRule2;
        
        List<FixedAllocationRuleLine__c> allocFixedRuleLines1 = new List<FixedAllocationRuleLine__c>();
        FixedAllocationRuleLine__c fixedallocRuleLine2 = new FixedAllocationRuleLine__c();
        fixedallocRuleLine2.GeneralLedgerAccount__c = CODATestIDMap.resolve(CODABaseData.s_APEXWriteOffGLA_EUR_name);
        fixedallocRuleLine2.Split__c = PERCENTAGE_5;
        fixedallocRuleLine2.AllocationRule__c = allocRule2.Id;
        allocFixedRuleLines1.add(fixedallocRuleLine2);
        
        FixedAllocationRuleLine__c fixedallocRuleLine3 = new FixedAllocationRuleLine__c();
        fixedallocRuleLine3.GeneralLedgerAccount__c = CODATestIDMap.resolve(CODABaseData.s_APEXAccountGLA_name);
        fixedallocRuleLine3.Split__c = PERCENTAGE_5;
        fixedallocRuleLine3.AllocationRule__c = allocRule2.Id;
        allocFixedRuleLines1.add(fixedallocRuleLine3);
        insert allocFixedRuleLines1;
        
        CODATestIDMapExt.put(FixedAR2, allocRule2.Id);
        CODATestIDMapExt.save(SUFFIX);
    }
	
	public static void assertions_TST036743()
    {
		CODACompany company = CODACompanyMapExt.getCurrentCompany();
		codaTransaction__c transAllocation = [select Id, Name, TransactionDate__c, Period__c, TransactionType__c, DocumentNumber__c,DocumentDescription__c, OwnerCompany__c from codaTransaction__c where TransactionType__c = :CODATransaction.TRANSACTIONTYPE_ALLOCATION];
		System.assertEquals(ALLOCATIONSDATE, transAllocation.TransactionDate__c);
		System.assertEquals(CODATransaction.TRANSACTIONTYPE_ALLOCATION, transAllocation.TransactionType__c);
		System.assertEquals(null, transAllocation.DocumentNumber__c);
		System.assertEquals(company.getId(), transAllocation.OwnerCompany__c);
		System.assertEquals(DOCUMENT_DESC,transAllocation.DocumentDescription__c);
		
		List<CODATransactionLineItem> transLineList = CODATransactionLineItemMapper.getByTransactionId(transAllocation.Id);
            Integer count = 0;
            for(CODATransactionLineItem transLine: transLineList)
            {
                System.assertEquals(CODATransactionLineItem.LINETYPE_ANALYSIS, transLine.getLineType());
                System.assertEquals(CODATransactionLineItem.MATCHINGSTATUS_NOTMATCHABLE, transLine.getMatchingStatus());
                System.assertEquals(CODATransactionLineItem.PROCESSSTATUS_NOTPROCESSED, transLine.getProcessStatus());
                System.assertEquals(ALLOCATIONSDATE, transLine.getDueDate());
                System.assertEquals(CODABaseData.CURRENCYCODE_GBP, transLine.getHomeCurrency().getName());
                System.assertEquals(CODABaseData.CURRENCYCODE_GBP, transLine.getDocumentCurrency().getName());
                System.assertEquals(CODABaseData.CURRENCYCODE_EUR, transLine.getDualCurrency().getName());
                if (transLine.getGeneralLedgerAccountId() == CODATestIDMap.resolve(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD))
				{	
					if(transLine.getHomeValue() == -141.00)
					{	
						System.assertEquals(-141.00, transLine.getHomeValue());
                        System.assertEquals(-141.00, transLine.getDocumentValue());
                        System.assertEquals(-169.20, transLine.getDualValue());
                        System.assertEquals(-282.00, transLine.getGeneralLedgerAccountValue());
                        System.assertEquals(null, transLine.getDimension1Value());
                        System.assertEquals(null, transLine.getDimension2Value());
                        System.assertEquals(null, transLine.getDimension3Value());
                        System.assertEquals(null, transLine.getDimension4Value());
                        count++;
					}
					
					if(transLine.getHomeValue() == 28.20)
					{	
						System.assertEquals(28.20, transLine.getHomeValue());
                        System.assertEquals(28.20, transLine.getDocumentValue());
                        System.assertEquals(33.84, transLine.getDualValue());
                        System.assertEquals(56.40, transLine.getGeneralLedgerAccountValue());
                        System.assertEquals(56.40, transLine.getDimension1Value());
                        System.assertEquals(56.40, transLine.getDimension2Value());
                        System.assertEquals(56.40, transLine.getDimension3Value());
                        System.assertEquals(56.40, transLine.getDimension4Value());
                        count++;
					}
				}
				
				else if(transLine.getGeneralLedgerAccountId() == CODATestIDMap.resolve(CODABaseData.NAMEGLA_BANKACCOUNTEUROSUS))
				{
					System.assertEquals(14.10, transLine.getHomeValue());
					System.assertEquals(14.10, transLine.getDocumentValue());
					System.assertEquals(16.92, transLine.getDualValue());
					System.assertEquals(16.92, transLine.getGeneralLedgerAccountValue());
					System.assertEquals(null, transLine.getDimension1Value());
					System.assertEquals(null, transLine.getDimension2Value());
					System.assertEquals(16.92, transLine.getDimension3Value());
					System.assertEquals(null, transLine.getDimension4Value());
					count++;	
				}
				
				else if(transLine.getGeneralLedgerAccountId() == CODATestIDMap.resolve(CODABaseData.s_APEXTaxGLA_name))
				{
					System.assertEquals(56.40, transLine.getHomeValue());
					System.assertEquals(56.40, transLine.getDocumentValue());
					System.assertEquals(67.68, transLine.getDualValue());
					System.assertEquals(112.80, transLine.getGeneralLedgerAccountValue());
					System.assertEquals(null, transLine.getDimension1Value());
					System.assertEquals(67.68, transLine.getDimension2Value());
					System.assertEquals(null, transLine.getDimension3Value());
					System.assertEquals(null, transLine.getDimension4Value());
					count++;	
				}
				
				else if(transLine.getGeneralLedgerAccountId() == CODATestIDMap.resolve(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLEUR))
				{
					System.assertEquals(42.30, transLine.getHomeValue());
					System.assertEquals(42.30, transLine.getDocumentValue());
					System.assertEquals(50.76, transLine.getDualValue());
					System.assertEquals(50.76, transLine.getGeneralLedgerAccountValue());
					System.assertEquals(50.76, transLine.getDimension1Value());
					System.assertEquals(null, transLine.getDimension2Value());
					System.assertEquals(null, transLine.getDimension3Value());
					System.assertEquals(null, transLine.getDimension4Value());
					count++;	
				}
			}
		System.assertEquals(5, count);
	}
    
    // Switch current company
    public static void switchCompany(String companyName)
    {
        CODABaseData.switchCurrentCompany(companyName, true, true, UserInfo.getUserId());
        CODACompanyMapExt.resetCompanyCache();
    }
    
    public static void destroyData()
    {
        CODATestIDMapExt.load(SUFFIX);
        CODAContext.enableSupportAccess();
        delete[SELECT Id FROM codaInvoice__c];
        delete[SELECT Id FROM codaTransaction__c];
        delete[SELECT Id FROM codaTransactionLineItem__c];
        delete[select Id from codaPurchaseInvoice__c];
        delete[select Id from codaIntercompanyDefinition__c];
        delete[select Id from codaIntercompanyTransfer__c];
        delete[Select Id from AllocationRule__c];
        CODAContext.disableSupportAccess();
        CODATestIDMapExt.purge(SUFFIX);
    }

    public static void loadMap()
    {
        //Company
        CODACompany compSpain = CODACompanyMapper.getByName(COMPANY_SPAIN)[0];
        Id compId = compSpain.getId();
        CODATestIDMapExt.put(COMPANY_SPAIN, compId);
        
        CODACompany compUSA = CODACompanyMapper.getByName(COMPANY_USA)[0];
        Id compIdUSA = compUSA.getId();
        CODATestIDMapExt.put(COMPANY_USA, compIdUSA);
        
        CODACompany compGB = CODACompanyMapper.getByName(COMPANY_GB)[0];
        Id compIdGB = compGB.getId();
        CODATestIDMapExt.put(COMPANY_GB, compIdGB);
        
        //Spain Period
        codaPeriod__c periodSpain = [Select Id, Name, OwnerCompany__r.Name from codaPeriod__c where Name = :PERIODNAME_CURRENT AND OwnerCompany__c = :compId limit 1];
        CODATestIDMapExt.put(PERIODNAME_CURRENT + ':' +  COMPANY_SPAIN, periodSpain.id);
        
        //GB Period
        codaPeriod__c periodGB = [Select Id, Name, OwnerCompany__r.Name from codaPeriod__c where Name = :PERIODNAME_CURRENT AND OwnerCompany__c = :compIdGB limit 1];
        CODATestIDMapExt.put(PERIODNAME_CURRENT + ':' +  COMPANY_GB, periodGB.id);
        
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
        
        //Currencies for Merlin Auto GB
        for (codaAccountingCurrency__c accCurrGB : [Select Id, Name, OwnerCompany__r.Name from codaAccountingCurrency__c where OwnerCompany__c  = :compIdGB])
        {
            CODATestIDMapExt.put(accCurrGB.Name + ':' + accCurrGB.OwnerCompany__r.Name, accCurrGB.id);
        }
        
        //Accounts
        Set<String> accNames = new Set<String>();
        accNames.add(INTERCOMACC_USA);
        accNames.add(INTERCOMACC_SPAIN);
        accNames.add(CODABaseDataExt.NAMEACCOUNT_CAMBRIDGEAUTO);
        for (Account accId : [Select Id, Name from Account where MirrorName__c in :accNames])
        {
            CODATestIDMapExt.put(accId.Name, accId.id);
        }
        
        //GLAs
        Set<String> glaNames = new Set<String>();
        glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLEUR);
        glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLEUR);
        glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD);
        glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLUSD);
        glaNames.add(CODABaseData.s_APEXTaxGLA_name);
        glaNames.add(CODABaseData.NAMEGLA_BANKACCOUNTEUROSUS);
        glaNames.add(CODABaseData.s_APEXWriteOffGLA_EUR_name);
        glaNames.add(CODABaseData.s_APEXAccountGLA_name);
        for(CODAGeneralLedgerAccount__c gla: [Select Id, Name from CODAGeneralLedgerAccount__c where Name in :glaNames])
        {
            CODATestIDMapExt.put(gla.Name, gla.id);
        }
        
        //Product
        Product2  item = [Select Id, Name from Product2  where Name =: CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH];
        CODATestIDMapExt.put(item.Name, item.id);
        
        // Dimensions
        for (codaDimension1__c  item1 : [Select Id, Name from codaDimension1__c ])
        {
            CODATestIDMapExt.put(item1.Name , item1.id);
        }
        
        for (codaDimension2__c  item2 : [Select Id, Name from codaDimension2__c ])
        {
            CODATestIDMapExt.put(item2.Name , item2.id);
        }
        
        for (codaDimension3__c  item3 : [Select Id, Name from codaDimension3__c ])
        {
            CODATestIDMapExt.put(item3.Name , item3.id);
        }
        
        for (codaDimension4__c  item4 : [Select Id, Name from codaDimension4__c ])
        {
            CODATestIDMapExt.put(item4.Name , item4.id);
        }
        
        //Tax code
        codaTaxCode__c taxcode= [Select Id, Name from codaTaxCode__c where Name =:CODABaseDataExt.NAMETAXCODE_VOSTDSALES];
        CODATestIDMapExt.put(taxcode.Name, taxcode.id);
      
        CODATestIDMapExt.save(SUFFIX);
    }
}