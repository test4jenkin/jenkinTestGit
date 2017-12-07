/*
 * Copyright (c) 2017 FinancialForce.com, inc. All rights reserved.
 */
 
public class CODATID020900Data
{
    public static final String SUFFIX = '#TID020900';
    public static final string COMPANY_NAME = CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN;
    public static final string CSH001 = 'CSH001';
    public static final String PERIODNAME_CURRENT = CODAPeriodMapExt.getPeriodByDate(system.today()).getName();
    
	public static void selectCompany()
    {
        CODABaseData.switchCurrentCompany(COMPANY_NAME, true, true, UserInfo.getUserId());
    }

    public static void createData()
    {
        loadMap();
        CODAUnitOfWork.createAndSetCurrent();
        
        //Cash Entry Header  
        CODACashEntryTestHelper cashEntry = new CODACashEntryTestHelper();
        cashEntry.setType(CODACashEntry.TYPE_RECEIPT);
        cashEntry.setBankAccount(CODABaseDataExt.NAMEBANKACC_SANTANDERCURRENTACCOUNT+':'+COMPANY_NAME);
        cashEntry.setDate(system.today());
        cashEntry.setCurrency(CODABaseData.CURRENCYCODE_EUR+':'+COMPANY_NAME);
        cashEntry.setPeriod(PERIODNAME_CURRENT + ':' + COMPANY_NAME);
        cashEntry.setChargesGLA(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLEUR);
        cashEntry.setChargesDimension2(CODABaseDataExt.NAMEDIM2_EUR);
        cashEntry.setReference(SUFFIX);
        cashEntry.setAccount(CODABaseDataExt.NAMEACCOUNT_CAMBRIDGEAUTO);
            
        CODACashEntryTestHelper.LineItem cashEntryLine1 = cashEntry.newLine();
        cashEntryLine1.setLineAccount(CODABaseDataExt.NAMEACCOUNT_CAMBRIDGEAUTO);
        cashEntryLine1.setCashEntryValue(CODAFormatter.decimalToString(10.00));
        cashEntryLine1.setCharges(10.00);
        cashEntryLine1.calculateBankAccountValue();
        cashEntryLine1.assertBankAccountValue(CODAFormatter.decimalToString(10.00));
        cashEntryLine1.setAccountDimension4(CODABaseDataExt.NAMEDIM4_EUR);

        cashEntry.saveAndPost();
        cashEntry.reload();
            
        CODATestIDMapExt.put(CSH001, cashEntry.getId());
        CODATestIDMapExt.put(CSH001 +'TRN', cashEntry.getTransactionId());
        CODATestIDMapExt.save(suffix);
    }
    
    public static void destroyData()
    {
        CODATestIDMapExt.load(SUFFIX);
        CODAContext.enableSupportAccess();
        delete[Select ID from codaCashEntry__c];
        delete[Select ID from CODATransaction__c];
        CODAContext.disableSupportAccess();
        CODATestIDMapExt.purge(SUFFIX);
    }
    
    public static void loadMap()
    {
        //Company
        CODACompany compVAT = CODACompanyMapExt.getCurrentCompany();
        Id compId = compVAT.getId();
        CODATestIDMapExt.put(COMPANY_NAME, compId);
        
        //Spain Period
        codaPeriod__c periodSpain = [Select Id, Name, OwnerCompany__r.Name from codaPeriod__c where Name = :PERIODNAME_CURRENT AND OwnerCompany__c = :compId limit 1];
        CODATestIDMapExt.put(PERIODNAME_CURRENT + ':' + compVAT.getName(), periodSpain.id);
        
        //Currencies for Merlin Auto Spain
        for (codaAccountingCurrency__c accCurrSpain : [Select Id, Name, OwnerCompany__r.Name from codaAccountingCurrency__c where OwnerCompany__c  = :compId])
        {
            CODATestIDMapExt.put(accCurrSpain.Name + ':' + accCurrSpain.OwnerCompany__r.Name, accCurrSpain.id);
        }
        
        //Bank Account
        codaBankAccount__c bankAccount = [Select Id, Name, OwnerCompany__r.Name from codaBankAccount__c where Name =:CODABaseDataExt.NAMEBANKACC_SANTANDERCURRENTACCOUNT limit 1];
        CODATestIDMapExt.put(bankAccount.Name + ':' + bankAccount.OwnerCompany__r.Name, bankAccount.id);
        
        //Accounts
        Set<String> accNames = new Set<String>();
        accNames.add(CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES);
        accNames.add(CODABaseDataExt.NAMEACCOUNT_CAMBRIDGEAUTO);
        
        for (Account accId : [Select Id, Name from Account where MirrorName__c in :accNames])
        {
            CODATestIDMapExt.put(accId.Name, accId.id);
        }
        
        //Product
        Product2  item = [Select Id, Name from Product2  where Name =: CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH];
        CODATestIDMapExt.put(item.Name, item.id);
        
        //Tax Codes
        Set<String> taxNames = new Set<String>();
        taxNames.add(CODABaseData.s_apexCountyCode);
        taxNames.add(CODABaseDataExt.NAMETAXCODE_VOSTDPURCHASE);
        taxNames.add(CODABaseDataExt.NAMETAXCODE_VOECPURCHASE);
        taxNames.add(CODABaseDataExt.NAMETAXCODE_VORPURCHASE);
        taxNames.add(CODABaseDataExt.NAMETAXCODE_VOSTDSALES);
        for (codaTaxCode__c tax : [Select Id, Name from codaTaxCode__c where Name in :taxNames])
        {
            CODATestIDMapExt.put(tax.Name, tax.id);
        }
        
        //GLAs
        Set<String> glaNames = new Set<String>();
        glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD);
        glaNames.add(CODABaseData.NAMEGLA_BANKACCOUNTEUROSUS);
        glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLEUR);
        
        for(CODAGeneralLedgerAccount__c gla: [Select Id, Name from CODAGeneralLedgerAccount__c where Name in :glaNames])
        {
            CODATestIDMapExt.put(gla.Name, gla.id);
        }
        
        //Dimension 1
        for (codaDimension1__c dim1 : [select id, name from codaDimension1__c])
        {
            CODATestIDMapExt.put(dim1.Name, dim1.id);
        }
        
        //Dimension 2
        for (codaDimension2__c dim2 : [select id, name from codaDimension2__c])
        {
            CODATestIDMapExt.put(dim2.Name, dim2.id);
        }
        
        //Dimension 3
        for (codaDimension3__c dim3 : [select id, name from codaDimension3__c])
        {
            CODATestIDMapExt.put(dim3.Name, dim3.id);
        }
        
        //Dimension 4
        for (codaDimension4__c dim4 : [select id, name from codaDimension4__c])
        {
            CODATestIDMapExt.put(dim4.Name, dim4.id);
        }
       
        CODATestIDMapExt.save(SUFFIX);
    }
}