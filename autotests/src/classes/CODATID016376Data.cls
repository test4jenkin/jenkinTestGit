/*  
* Copyright (c) 2016 FinancialForce.com, inc. All rights reserved.
*/
 
public class CODATID016376Data  
{
    // Suffix
    public static String SUFFIX = '#TID016376#';
    public static String CUST_REF = SUFFIX + 'SINV1';
    public static String STATUS_TAXABLE = 'Taxable';
    //New GLAs
    public static String GLA_AccOctGBPIS = 'AccOctGBPIS';
    public static String GLA_ProductOctGBPIS = 'ProductOctGBPIS';
    public static String GLA_ProductOctGBPBS = 'ProductOctGBPBS';
    // New Account
    public static String ACC_OctGBPIS = 'OctGBPIS';
    //New Product
    public static String PROD_OctGBPIS = 'OctGBPIS'+SUFFIX;
    public static String PROD_OctGBPBS = 'OctGBPBS'+SUFFIX;
    //Periods
    public static string period_2015_010 = '2015/010';

    //Select Merlin Auto USA
    public static void switchProfile()
    {
        Id userId = CODABaseData.getProfile(CODABaseData.ACCOUNTANT).Id;
        CODABaseData.switchCurrentCompany(CODABaseData.NAMECOMPANY_MERLINAUTOUSA, true, true, userId);
    }
    //Select Merlin Auto USA
    public static void selectCompany()
    {
        CODABaseData.switchCurrentCompany(CODABaseData.NAMECOMPANY_MERLINAUTOUSA, true, true, userinfo.getUserId()); 
    }
    
	// create GLAs
    public static void createData()
    {
        CODAUnitOfWork.createAndSetCurrent();
        // Create GLAs
        CODAGeneralLedgerAccount newgla_AccOctGBPIS=new CODAGeneralLedgerAccount();
        newgla_AccOctGBPIS.setName(GLA_AccOctGBPIS);
        newgla_AccOctGBPIS.setReportingCode(GLA_AccOctGBPIS);
        newgla_AccOctGBPIS.setType(CODAGeneralLedgerAccount.TYPE_PROFITANDLOSS);
        newgla_AccOctGBPIS.setAllowRevaluation(true);
        
        CODAGeneralLedgerAccount newgla_ProductOctGBPIS=new CODAGeneralLedgerAccount();
        newgla_ProductOctGBPIS.setName(GLA_ProductOctGBPIS);
        newgla_ProductOctGBPIS.setReportingCode(GLA_ProductOctGBPIS);
        newgla_ProductOctGBPIS.setType(CODAGeneralLedgerAccount.TYPE_PROFITANDLOSS);
        newgla_ProductOctGBPIS.setAllowRevaluation(true);
        
        CODAGeneralLedgerAccount newgla_ProductOctGBPBS=new CODAGeneralLedgerAccount();
        newgla_ProductOctGBPBS.setName(GLA_ProductOctGBPBS);
        newgla_ProductOctGBPBS.setReportingCode(GLA_ProductOctGBPBS);
        newgla_ProductOctGBPBS.setType(CODAGeneralLedgerAccount.TYPE_BALANCESHEET);
        newgla_ProductOctGBPBS.setAllowRevaluation(true);
        
        CODAUnitOfWork.getCurrent().commitWork();
        loadmap();
    }
    
    // create Product,Account and post Sales Invoice
    public static void createDataExt1()
    {
        CODATestIDMapExt.load(SUFFIX);
        CODAUnitOfWork.createAndSetCurrent();   
        CODAGeneralLedgerAccount GLA_ACC_OCTGBPIS=CODAGeneralLedgerAccountMapper.getByName(GLA_AccOctGBPIS)[0];
        CODAGeneralLedgerAccount GLA_GBPIS=CODAGeneralLedgerAccountMapper.getByName(GLA_ProductOctGBPIS)[0];
        CODAGeneralLedgerAccount GLA_GBPBS=CODAGeneralLedgerAccountMapper.getByName(GLA_ProductOctGBPBS)[0];
        // Create Account
        CODAAccount newACC_OctGBPIS = new CODAAccount();
        newACC_OctGBPIS.setName(ACC_OctGBPIS);
        newACC_OctGBPIS.setAccountTradingCurrency(CODABaseData.CURRENCYCODE_GBP);
        newACC_OctGBPIS.setReportingCode(ACC_OctGBPIS);
        newACC_OctGBPIS.setAccountsReceivableControl(GLA_ACC_OCTGBPIS);
        
        // Create Product
        CODAProduct2 newprod_OctGBPIS = new CODAProduct2();
        newprod_OctGBPIS.setName(PROD_OctGBPIS);
        newprod_OctGBPIS.setSalesTaxStatus(STATUS_TAXABLE);
        newprod_OctGBPIS.setSalesRevenueAccount(GLA_GBPIS);
        newprod_OctGBPIS.getDto().IsActive=true;
        CODAProduct2 newprod_OctGBPBS = new CODAProduct2();
        newprod_OctGBPBS.setName(PROD_OctGBPBS);
        newprod_OctGBPBS.setSalesTaxStatus(STATUS_TAXABLE);
        newprod_OctGBPBS.setSalesRevenueAccount(GLA_GBPBS);
        newprod_OctGBPBS.getDto().IsActive=true;
        
        CODAUnitOfWork.getCurrent().commitWork();
        CODATestIDMapExt.put(PROD_OctGBPIS, newprod_OctGBPIS.getId());
        CODATestIDMapExt.put(PROD_OctGBPBS, newprod_OctGBPBS.getId());
        CODATestIDMapExt.put(ACC_OctGBPIS, newACC_OctGBPIS.getId());
        CODATestIDMapExt.save(SUFFIX);
        
        /* SINV1 */
        CODAInvoiceTestHelper sinv1 = new CODAInvoiceTestHelper();
        sinv1.setAccount(ACC_OctGBPIS);
        sinv1.setInvoiceCurrency(CODABaseData.CURRENCYCODE_GBP);
        sinv1.setPeriod(period_2015_010); 
        sinv1.setCustomerReference(CUST_REF);
        sinv1.setInvoiceDate(date.newinstance(2015, 10, 10));
        //Add line 1
        CODAInvoiceTestHelper.LineItem sinv1Line = sinv1.newLine();
        sinv1Line.setProduct(PROD_OctGBPIS);
        sinv1Line.setQuantity(1);
        sinv1Line.setUnitPrice(10);
        //Add line 2
        CODAInvoiceTestHelper.LineItem sinv2Line = sinv1.newLine();
        sinv2Line.setProduct(PROD_OctGBPBS);
        sinv2Line.setQuantity(1);
        sinv2Line.setUnitPrice(20);
        sinv1.saveAndPost();
        sinv1.reload();
        CODATestIDMapExt.put(sinv1.getCustomerReference(), sinv1.getId());
        CODATestIDMapExt.save(SUFFIX);
    }
    
  	// Destroy Data and new Data created for this TID.
    public static void destroyData()
    {
        CODAContext.enableSupportAccess();
        delete [select Id from CODAGeneralLedgerAccount__c where Name =:GLA_AccOctGBPIS];
        delete [select Id from CODAGeneralLedgerAccount__c where Name =:GLA_ProductOctGBPIS];
        delete [select Id from CODAGeneralLedgerAccount__c where Name =:GLA_ProductOctGBPBS];
        delete [select Id from Account where MirrorName__c =:ACC_OctGBPIS];
        delete [select Id from Product2 where Name =:PROD_OctGBPIS];
        delete [select Id from Product2 where Name =:PROD_OctGBPBS];
        CODAPaymentData.destroyPaymentData(SUFFIX);	
    }
    
    public static void loadMap()
    {
        // Company
        CODACompany company = CODACompanyMapExt.getCurrentCompany();
        Id compUSAId = company.getId();
        CODATestIDMapExt.put(CODABaseData.NAMECOMPANY_MERLINAUTOUSA, compUSAId); 
        
        // Currencies for Merlin Auto Spain
        for (codaAccountingCurrency__c accCurr : [Select Id, Name from codaAccountingCurrency__c where OwnerCompany__c  = :compUSAId])
        {
            CODATestIDMapExt.put(accCurr.Name, accCurr.id);
        }
        
        // Years for Merlin Auto Spain
        for (codaYear__c year : [Select Id, Name  from codaYear__c where OwnerCompany__c = :compUSAId])
        {
            CODATestIDMapExt.put(year.Name, year.id);
        }
        
        // General Ledger Account
        for (CODAGeneralLedgerAccount__c item : [Select Id, Name from CODAGeneralLedgerAccount__c ])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }
        
        // Tax Codes
        Set<String> taxNames = new Set<String>();
        taxNames.add(CODABaseDataExt.NAMETAXCODE_VOSTDSALES);
        taxNames.add(CODABaseDataExt.NAMETAXCODE_VORSALES);
        taxNames.add(CODABaseDataExt.NAMETAXCODE_VORPURCHASE);
        taxNames.add(CODABaseDataExt.NAMETAXCODE_VOSTDPURCHASE);
        
        for (codaTaxCode__c item : [Select Id, Name from codaTaxCode__c where Name in :taxNames])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }
        
        // Products
        Set<String> productNames = new Set<String>();
        productNames.add(CODABaseDataExt.NAMEPRODUCT_BBKFUELPUMP);
        productNames.add(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
        Map<String, Id> CODAProduct2Map = CODAProduct2Mapper.getIDsByNames(productNames);
        
        for(String key : CODAProduct2Map.keyset())
        {
            CODATestIDMapExt.put(key, CODAProduct2Map.get(key));
        }
        
        // Accounts
        Set<String> accNames = new Set<String>();
        accNames.add(CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO);
        accNames.add(CODABaseDataExt.NAMEACCOUNT_CAMBRIDGEAUTO);
        accNames.add(CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES);
        
        for (Account accId : [Select Id, Name from Account where MirrorName__c in :accNames])
        {
            CODATestIDMapExt.put(accId.Name, accId.id);
        }
        
        // Periods for Merlin Auto Spain
        for (codaPeriod__c period : [Select Id, Name from codaPeriod__c where OwnerCompany__c = :compUSAId])
        {
            CODATestIDMapExt.put(period.Name, period.id);
        }
        
        // Dimensions 1
        Set<String> dim1Names = new Set<String>();
        dim1Names.add(CODABaseDataExt.NAMEDIM1_NORTH);
        dim1Names.add(CODABaseDataExt.NAMEDIM1_SOUTH);
        
        for (codaDimension1__c item : [Select Id, Name from codaDimension1__c where Name in :dim1Names])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }
        
        // Dimensions 2
        Set<String> dim2Names = new Set<String>();
        dim2Names.add(CODABaseDataExt.NAMEDIM2_DODGEUK);
        dim2Names.add(CODABaseDataExt.NAMEDIM2_FORDUK);
        
        for (codaDimension2__c item : [Select Id, Name from codaDimension2__c where Name in :dim2Names])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }
        
        // Dimensions 3
        Set<String> dim3Names = new Set<String>();
        dim3Names.add(CODABaseDataExt.NAMEDIM3_SALESEUR);
        dim3Names.add(CODABaseDataExt.NAMEDIM3_BILLYRAY);
        
        for (codaDimension3__c item : [Select Id, Name from codaDimension3__c where Name in :dim3Names])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }
        
        // Dimensions 4
        Set<String> dim4Names = new Set<String>();
        dim4Names.add(CODABaseDataExt.NAMEDIM4_ROGERSCARLATTI);
        dim4Names.add(CODABaseDataExt.NAMEDIM4_HARROGATE);
        
        for (codaDimension4__c item : [Select Id, Name from codaDimension4__c where Name in :dim4Names])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }
        
        CODATestIDMapExt.save(SUFFIX);
    }  
}