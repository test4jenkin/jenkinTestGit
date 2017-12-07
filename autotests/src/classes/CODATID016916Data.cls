/* FinancialForce.com, inc. claims copyright in this software, its screen display designs and 
* supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc. 
* Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may 
* result in criminal or other legal proceedings. 
*
* Copyright (c) 2016 FinancialForce.com, inc.  All rights reserved.
*/
public class CODATID016916Data
{
    public static String suffix = 'TID016916';
    public static string REFERENCE = 'REFERENCE';
    public static String COMPANY_NAME = CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN; 
    public static String namePeriod = CODAPeriodMapExt.getPeriodByDate(system.today()).getName();
    public static String invoiceDescription = 'TID016916-Invoice Description';
    
    // select current company
    public static void selectCompany()
    {
        CODABaseData.switchCurrentCompany(COMPANY_NAME, true, true, UserInfo.getUserId());
    }
    
    // Switch profile for the user
    public static void switchProfile()
    {
        Id userId = CODABaseData.getProfile(CODABaseData.SYSADMIN).Id;
        CODABaseData.switchCurrentCompany(CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN, true, false, userId);
    }
    
    // Create data Sales Invoice with complete status
    public static void createData()
    {
        loadMap();
        CODAUnitOfWork.createAndSetCurrent();
        
        // update Allow Revaluation for GLA
        CODAGeneralLedgerAccount accountGLA = CODAGeneralLedgerAccountMapper.getById(CODATestIDMap.resolve(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD));
        accountGLA.setAllowRevaluation(true);
        
        CODAUnitOfWork.getCurrent().commitWork();
        
        // Sales Invoice 1
        CODAInvoiceTestHelper invoice = new CODAInvoiceTestHelper();
        invoice.setAccount(CODABaseDataExt.NAMEACCOUNT_CAMBRIDGEAUTO);
        invoice.setInvoiceDate(Date.newInstance(2010,1,10));
        invoice.setInvoiceCurrency(CODABaseData.CURRENCYCODE_EUR);
        invoice.setPeriod(namePeriod + ':' + CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN);
        invoice.setInvoiceDescription(invoiceDescription);
        invoice.setCustomerReference('MATCH9999');
        
        CODAInvoiceTestHelper.LineItem line = invoice.newLine();
        line.setProduct(CODABaseDataExt.NAMEPRODUCT_AUTO1COMCLUTCH);
        line.setUnitPrice(40);
        line.setQuantity(1);
        line.setTaxCode1(CODABaseDataExt.NAMETAXCODE_VOSTDSALES);           
        
        invoice.save();
        invoice.reload();
        invoice.post();
        CODATestIDMapExt.put(REFERENCE, invoice.getId());
        CODATestIDMapExt.save(suffix);
    }  
    
    // Destroy data created in createData method
    public static void destroyData()
    {
        CODAUnitOfWork.createAndSetCurrent();
        CODATestIDMapExt.load(SUFFIX);
        // update Allow Revaluation for GLA
        CODAGeneralLedgerAccount accountGLA = CODAGeneralLedgerAccountMapper.getById(CODATestIDMap.resolve(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD));
        accountGLA.setAllowRevaluation(false);
        
        CODAUnitOfWork.getCurrent().commitWork();
        
        CODAContext.enableSupportAccess();
        for(codaTransaction__c [] stuff : [select Id from codaTransaction__c])
            delete stuff;
        for(codaInvoice__c [] stuff : [select Id from codaInvoice__c])
            delete stuff;
        CODATestIDMapExt.purge(suffix);
    }
    
    // this method is used to load test data into CODATestIDMapExt
    public static void loadMap()
    {
        // Accounts
        Set<String> accNames = new Set<String>();
        accNames.add(CODABaseDataExt.NAMEACCOUNT_CAMBRIDGEAUTO);
        accNames.add(CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO);
        for(Account item : [Select Id, Name from Account where MirrorName__c in :accNames])
        {
            CODATestIDMapExt.put(item.Name, item.Id);
        }
        
        // Bank Accounts
        Set<String> baccNames = new Set<String>();
        baccNames.add(CODABaseDataExt.NAMEBANKACC_SANTANDERCURRENTACCOUNT);
        for(codaBankAccount__c item : [Select Id, Name from codaBankAccount__c where Name in :baccNames])
        {
            CODATestIDMapExt.put(item.Name, item.Id);
        }
        
        // Product
        Set<String> prodNames = new Set<String>();
        prodNames.add(CODABaseDataExt.NAMEPRODUCT_AUTO1COMCLUTCH);
        prodNames.add(CODABaseDataExt.NAMEPRODUCT_BBKFUELPUMP);
        for(Product2 item : [Select Id, Name from Product2 where Name in :prodNames])
        {
            CODATestIDMapExt.put(item.Name, item.Id);
        }
        
        // general ledger accounts
        Set<String> glaNames = new Set<String>();
        glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD);
        for(codaGeneralLedgerAccount__c gla : [select Id, Name from codaGeneralLedgerAccount__c where Name in :glaNames])
        {
            CODATestIDMapExt.put(gla.Name, gla.Id);
        }
        
        // Period for Merlin Auto Spain
        codaPeriod__c period = [Select Id, Name, OwnerCompany__r.Name from codaPeriod__c where Name = :namePeriod and OwnerCompany__r.Name = :CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN];
        CODATestIDMapExt.put(period.Name + ':' + period.OwnerCompany__r.Name, period.Id);
        
        // Currencies for Merlin Auto Spain
        for (codaAccountingCurrency__c accCurr : [Select Id, Name, OwnerCompany__r.Name from codaAccountingCurrency__c where OwnerCompany__r.Name  = :CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN])
        {
            CODATestIDMapExt.put(accCurr.Name + ':' + accCurr.OwnerCompany__r.Name, accCurr.Id);
        }
        
        // Tax Code
        Set<String> taxCodes = new Set<String>();
        taxCodes.add(CODABaseDataExt.NAMETAXCODE_VOSTDSALES);
        taxCodes.add(CODABaseDataExt.NAMETAXCODE_VOZ);
        for ( codaTaxCode__c item : [Select Id, Name from  codaTaxCode__c where Name in :taxCodes])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }
        
        // Dimension 1s
        Set<String> dim1Names = new Set<String>();
        dim1Names.add(CODABaseDataExt.NAMEDIM1_EUR);
        for (codaDimension1__c item : [Select Id, Name from codaDimension1__c where Name in :dim1Names])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }
        
        CODATestIDMapExt.save(suffix);
    }
}
