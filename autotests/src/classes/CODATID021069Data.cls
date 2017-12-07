/*
 * Copyright (c) 2017 FinancialForce.com, inc. All rights reserved.
 */
 
public class CODATID021069Data
{
    public static final String SUFFIX = '#TID021069';
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
        cashEntry.setReference(SUFFIX);
        cashEntry.setAccount(CODABaseDataExt.NAMEACCOUNT_CAMBRIDGEAUTO);
        //Cash Entry Line    
        CODACashEntryTestHelper.LineItem cashEntryLine1 = cashEntry.newLine();
        cashEntryLine1.setLineAccount(CODABaseDataExt.NAMEACCOUNT_CAMBRIDGEAUTO);
        cashEntryLine1.setCashEntryValue(CODAFormatter.decimalToString(10.00));
                
        cashEntry.save();
        cashEntry.reload();
        CODATestIDMapExt.put(CSH001, cashEntry.getId());
        CODATestIDMapExt.save(suffix);
    }
    
    public static void destroyData()
    {
        CODATestIDMapExt.load(SUFFIX);
        CODAContext.enableSupportAccess();
        delete[Select ID from codaCashEntry__c];
        CODAContext.disableSupportAccess();
        CODATestIDMapExt.purge(SUFFIX);
    }
    
    public static void loadMap()
    {
        //Company
        CODACompany compVAT = CODACompanyMapExt.getCurrentCompany();
        Id compId = compVAT.getId();
        CODATestIDMapExt.put(COMPANY_NAME, compId);
        
        //Period 
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
        
        //GLAs
        Set<String> glaNames = new Set<String>();
        glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD);
        glaNames.add(CODABaseData.NAMEGLA_BANKACCOUNTEUROSUS);
        glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLEUR);
        
        for(CODAGeneralLedgerAccount__c gla: [Select Id, Name from CODAGeneralLedgerAccount__c where Name in :glaNames])
        {
            CODATestIDMapExt.put(gla.Name, gla.id);
        }
                      
        CODATestIDMapExt.save(SUFFIX);
    }
}