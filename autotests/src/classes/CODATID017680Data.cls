/*
 * FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 * supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 * Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 * result in criminal or other legal proceedings.
 *
 * Copyright (c) 2016 FinancialForce.com, inc. All rights reserved.
 */

public class CODATID017680Data
{
    public static String COMPANY_SPA = CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN;
    public static String COMPANY_USA = CODABaseData.NAMECOMPANY_MERLINAUTOUSA;
    public static String COMPANY_GB = CODABaseData.NAMECOMPANY_MERLINAUTOGB;
    public static String SUFFIX = '#TID017680#';
    public static String ACCOUNT_SPA = 'Merlin Spain Account';
    public static String ACCOUNT_USA = 'Merlin USA Account';
    public static String ACCOUNT_AUDI = 'Audi';
    public static String CURRENCY_EUR = COMPANY_SPA + ':EUR';
    public static String CURRENCY_USD = COMPANY_USA + ':USD';
    public static String GLA_ACCOUNTS_RECEIVABLE_CONTROL_EUR = CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLEUR;
    public static String GLA_ACCOUNTS_RECEIVABLE_CONTROL_USD = CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD;
    public static String GLA_ACCOUNTS_PAYABLE_CONTROL_EUR = CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLEUR;
    public static String GLA_ACCOUNTS_PAYABLE_CONTROL_USD = CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLUSD;
    public static String JRN_REF = 'JRN_REF';
    public static String JRN_REF1 = 'JRN_REF1';
    public static String CE_REF = 'CE_REF';
    public static String PRODUCT_A4PAPER = 'A4 Paper';
    public static String BANK_ACCOUNT_SANTANDER_CURRENT = COMPANY_SPA + ':Santander Current Account';
    public static String BANK_ACCOUNT_BRISTOL_DEPOSIT = COMPANY_USA + ':Bristol Deposit Account';
    public static String PAYMENTMETHOD_CASH = CODACashEntry.PAYMENTMETHOD_CASH;
	public static final String INTERCOMACC_SPAIN = 'Intercompany Spain Account';
	public static final String INTERCOMACC_USA = 'Intercompany USA Account';
    public static void selectCompany()
    {
        CODABaseData.switchCurrentCompany(COMPANY_SPA, true, true, UserInfo.getUserId());
    }

    public static void switchProfile()
    {
        Id userId = CODABaseData.getProfile(CODABaseData.ACCOUNTANT).Id;
        CODABaseData.switchCurrentCompany(COMPANY_SPA, true, false, userId);
        CODABaseData.switchCurrentCompany(COMPANY_USA, true, false, userId);
        CODABaseData.switchCurrentCompany(COMPANY_GB, true, false, userId);
    }

    public static void createData()
    {
        loadmap();
        CODAUnitOfWork.createAndSetCurrent();
        CODADataTestHelper.setSystemTestDate(SUFFIX);

        CODAAccount account = new CODAAccount();
        account.setName(ACCOUNT_SPA);
        account.setAccountTradingCurrency('EUR');

        CODAUnitOfWork.getCurrent().commitWork();
        CODATestIDMapExt.put(ACCOUNT_SPA, account.getId());

        CODACompany merlinCOM = CODACompanyMapper.getByName(COMPANY_SPA)[0];
        merlinCOM.setIntercompanyAccountId(CODATestIDMap.resolve(ACCOUNT_SPA));

        CODAUnitOfWork.getCurrent().commitWork();
        CODATestIDMapExt.save(SUFFIX);
    }

    public static void createDataExt1()
    {
        CODAUnitOfWork.createAndSetCurrent();

        CODAAccount account = new CODAAccount();
        account.setName(ACCOUNT_USA);
        account.setAccountTradingCurrency('USD');

        CODAUnitOfWork.getCurrent().commitWork();
        CODATestIDMapExt.put(ACCOUNT_USA, account.getId());

        CODACompany merlinCOM = CODACompanyMapper.getByName(COMPANY_USA)[0];
        merlinCOM.setIntercompanyAccountId(CODATestIDMap.resolve(ACCOUNT_USA));

        CODAUnitOfWork.getCurrent().commitWork();
        CODATestIDMapExt.save(SUFFIX);
    }

    public static void createDataExt2()
    {
        CODATestIDMapExt.load(SUFFIX);
        CODAUnitOfWork.createAndSetCurrent();

        CODAIntercompanyDefinition interCompany2 = new CODAIntercompanyDefinition();
        interCompany2.setRelatedCompanyId(CODATestIDMap.resolve(COMPANY_USA));
        interCompany2.setSendingControlAccountId(CODATestIDMap.resolve(GLA_ACCOUNTS_RECEIVABLE_CONTROL_EUR));
        interCompany2.setReceivingControlAccountId(CODATestIDMap.resolve(GLA_ACCOUNTS_PAYABLE_CONTROL_EUR));
        interCompany2.setOwnerCompanyId(CODATestIDMap.resolve(COMPANY_SPA));

        CODAUnitOfWork.getCurrent().commitWork();

        CODATestIDMapExt.put('ICD_SPAIN_USA', interCompany2.getId());
        CODATestIDMapExt.save(SUFFIX);
    }

    public static void createDataExt3()
    {
        CODABaseData.switchCurrentCompany(COMPANY_USA, true, true, UserInfo.getUserId());
    }

    public static void createDataExt4()
    {
        CODATestIDMapExt.load(SUFFIX);
        CODAUnitOfWork.createAndSetCurrent();

        CODAIntercompanyDefinition interCompany2 = new CODAIntercompanyDefinition();
        interCompany2.setRelatedCompanyId(CODATestIDMap.resolve(COMPANY_SPA));
        interCompany2.setSendingControlAccountId(CODATestIDMap.resolve(GLA_ACCOUNTS_RECEIVABLE_CONTROL_USD));
        interCompany2.setReceivingControlAccountId(CODATestIDMap.resolve(GLA_ACCOUNTS_PAYABLE_CONTROL_USD));
        interCompany2.setOwnerCompanyId(CODATestIDMap.resolve(COMPANY_USA));

        CODAUnitOfWork.getCurrent().commitWork();

        CODATestIDMapExt.put('ICD_USA_SPAIN', interCompany2.getId());
        CODATestIDMapExt.save(SUFFIX);
    }

    public static void createDataExt5()
    {
        CODABaseData.switchCurrentCompany(COMPANY_SPA, true, true, UserInfo.getUserId());
    }

    public static void createDataExt6()
    {
        CODATestIDMapExt.load(SUFFIX);

        CODAUnitOfWork.getCurrent();

        Date journalDate = CODADataTestHelper.getSystemTestDate(SUFFIX);
        String journalPeriod = CODAPeriodMapExt.getPeriodByDate(CODADataTestHelper.getSystemTestDate(SUFFIX)).getName() + ':' + COMPANY_SPA;

        CODAJournalTestHelper journal = CODADataTestHelper.journalHeader(journalDate, CURRENCY_EUR, JRN_REF, journalPeriod, 'JRN header');
        CODADataTestHelper.journalLine(journal, CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, GLA_ACCOUNTS_RECEIVABLE_CONTROL_EUR, GLA_ACCOUNTS_RECEIVABLE_CONTROL_EUR, '100.23', '');
        CODADataTestHelper.journalLine(journal, CODAJournalLineItem.LINETYPE_PRODUCTSALES, PRODUCT_A4PAPER, GLA_ACCOUNTS_RECEIVABLE_CONTROL_EUR, '10', 'JRN Line 3');
        CODADataTestHelper.journalLine(journal, CODAJournalLineItem.LINETYPE_ACCOUNTCUSTOMER, ACCOUNT_AUDI, GLA_ACCOUNTS_RECEIVABLE_CONTROL_EUR, '-110.23', 'JRN Line 4 with very long description. This text should make an ellipsis appear and we\'ll be able to see the rest of the text by hovering the field.');

        journal.save();
        journal.reload();
        journal.post();

        CODATestIDMapExt.put(JRN_REF, journal.getId());
        CODATestIDMapExt.save(SUFFIX);
    }

    public static void createDataExt7()
    {
        CODATestIDMapExt.load(SUFFIX);

        CODAUnitOfWork.createAndSetCurrent();

        Date ceDate = CODADataTestHelper.getSystemTestDate(SUFFIX);
        String cePeriod = CODAPeriodMapExt.getPeriodByDate(CODADataTestHelper.getSystemTestDate(SUFFIX)).getName() + ':' + COMPANY_SPA;

        CODACashEntryTestHelper cashEntry = new CODACashEntryTestHelper();
        cashEntry.setType(CODACashEntry.TYPE_RECEIPT);
        cashEntry.setBankAccount(BANK_ACCOUNT_SANTANDER_CURRENT);
        cashEntry.setDate(ceDate);
        cashEntry.setCurrency(CURRENCY_EUR);
        cashEntry.setPeriod(cePeriod);
        cashEntry.setReference(CE_REF);
        cashEntry.setPaymentMethod(PAYMENTMETHOD_CASH);
        cashEntry.setAccount(ACCOUNT_USA);

        CODACashEntryTestHelper.LineItem cashEntryLine1 = cashEntry.newLine();
        cashEntryLine1.setLineAccount(ACCOUNT_USA);
        cashEntryLine1.setLineDescription('CE IC Line 1');
        cashEntryLine1.setAccountReference(ACCOUNT_USA);
        cashEntryLine1.setAccountPaymentMethod(PAYMENTMETHOD_CASH);
        cashEntryLine1.setCashEntryValue('100.23');

        cashEntry.saveAndPost();

        CODATestIDMapExt.put(CE_REF, cashEntry.getId());
        CODATestIDMapExt.save(SUFFIX);
    }

    public static void createDataExt8()
    {
        CODABaseData.switchCurrentCompany(COMPANY_USA, true, true, UserInfo.getUserId());
    }

    public static void createDataExt9()
    {
        CODATestIDMapExt.load(SUFFIX);

        codaIntercompanyTransfer__c ict = [SELECT Id FROM codaIntercompanyTransfer__c LIMIT 1];
        ict.DestinationDocumentBankAccount__c = CODATestIDMap.resolve(BANK_ACCOUNT_BRISTOL_DEPOSIT);
        update ict;

        ict = [SELECT Id FROM codaIntercompanyTransfer__c LIMIT 1];
        IntercompanyTransferService.process(new List<Id> {ict.Id});

        ict = [SELECT DestinationCashEntry__c FROM codaIntercompanyTransfer__c LIMIT 1];
        codaCashEntry__c ce = [SELECT Id FROM codaCashEntry__c WHERE Id = :ict.DestinationCashEntry__c];
        CODACashEntryTestHelper cashEntry = new CODACashEntryTestHelper(ce);
        cashEntry.saveAndPost();
    }
    
    public static void createDataExt10()
    {
        CODATestIDMapExt.load(SUFFIX);

        CODAUnitOfWork.getCurrent();

        Date journalDate = CODADataTestHelper.getSystemTestDate(SUFFIX);
        String journalPeriod = CODAPeriodMapExt.getPeriodByDate(CODADataTestHelper.getSystemTestDate(SUFFIX)).getName() + ':' + COMPANY_USA;

        CODAJournalTestHelper journal = CODADataTestHelper.journalHeader(journalDate, CURRENCY_EUR, JRN_REF, journalPeriod, 'JRN header');
        CODADataTestHelper.journalLine(journal, CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, GLA_ACCOUNTS_RECEIVABLE_CONTROL_EUR, GLA_ACCOUNTS_RECEIVABLE_CONTROL_EUR, '100.23', '');
        CODADataTestHelper.journalLine(journal, CODAJournalLineItem.LINETYPE_PRODUCTSALES, PRODUCT_A4PAPER, GLA_ACCOUNTS_RECEIVABLE_CONTROL_EUR, '10', 'JRN Line 3');
        CODADataTestHelper.journalLine(journal, CODAJournalLineItem.LINETYPE_ACCOUNTCUSTOMER, ACCOUNT_AUDI, GLA_ACCOUNTS_RECEIVABLE_CONTROL_EUR, '-110.23', 'JRN Line 4 with very long description. This text should make an ellipsis appear and we\'ll be able to see the rest of the text by hovering the field.');

        journal.save();
        journal.reload();
        journal.post();

        CODATestIDMapExt.put(JRN_REF1, journal.getId());
        CODATestIDMapExt.save(SUFFIX);
    }

    public static void destroyData()
    {
        CODATestIDMapExt.load(SUFFIX);
        CODAContext.enableSupportAccess();

        CODADataTestHelper.deleteSystemTestDate(SUFFIX);

        List<String> accountNames = new List<String>();
        accountNames.add(ACCOUNT_SPA);
        accountNames.add(ACCOUNT_USA);
		
        delete [Select Id From codaIntercompanyDefinition__c];
        delete [Select Id From codaIntercompanyTransfer__c];
        delete [Select Id From Account where MirrorName__c in :accountNames];
        delete [SELECT Id FROM codaJournal__c];
        delete [SELECT Id FROM codaJournalLineItem__c];
        delete [SELECT Id FROM codaCashEntry__c];
        delete [SELECT Id FROM codaCashEntryLineItem__c];
        delete [SELECT Id FROM codaTransaction__c];
        delete [SELECT Id FROM codaTransactionLineItem__c];
		CODAContext.disableSupportAccess();
		CODACompany merlinCOM = CODACompanyMapper.getByName(COMPANY_SPA)[0];
		merlinCOM.setIntercompanyAccountId(CODATestIDMap.resolve(INTERCOMACC_SPAIN));
		CODACompany merlinCOMUSA = CODACompanyMapper.getByName(COMPANY_USA)[0];
		merlinCOMUSA.setIntercompanyAccountId(CODATestIDMap.resolve(INTERCOMACC_USA));
        CODAUnitOfWork.getCurrent().commitWork();

        CODATestIDMapExt.purge(SUFFIX);
    }

    public static void loadMap()
    {
        Set<String> glaNames = new Set<String>();
        glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLEUR);
        glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLUSD);
        glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD);
        glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLEUR);

        for (CODAGeneralLedgerAccount__c item : [Select Id, Name from CODAGeneralLedgerAccount__c where Name in :glaNames])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }

        CODACompany company = CODACompanyMapExt.getCurrentCompany();
        Id compId = company.getId();

        Set<String> companyNames = new Set<String>();
        companyNames.add(CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN);
        companyNames.add(CODABaseData.NAMECOMPANY_MERLINAUTOGB);
        companyNames.add(CODABaseData.NAMECOMPANY_MERLINAUTOUSA);

        for (codaCompany__c companyName : [Select Id, Name From codaCompany__c where Name in :companyNames])
        {
            CODATestIDMapExt.put(companyName.Name, companyName.id);

            for (codaPeriod__c period : [Select Id, Name, OwnerCompany__r.Name from codaPeriod__c where OwnerCompany__c = :companyName.id])
            {
                CODATestIDMapExt.put(period.Name + ':' + companyName.Name, period.id);
            }
        }

        Set<String> accNames = new Set<String>();
        accNames.add(CODABaseDataExt.NAMEACCOUNT_AUDI);
		accNames.add(INTERCOMACC_USA);
        accNames.add(INTERCOMACC_SPAIN);
        for (Account accId : [Select Id, Name from Account where MirrorName__c in :accNames])
        {
            CODATestIDMapExt.put(accId.Name, accId.id);
        }

        Set<String> prodNames = new Set<String>();
        prodNames.add(CODABaseDataExt.NAMEPRODUCT_A4PAPE);

        for(Product2 item : [Select Id, Name from Product2 where Name in :prodNames])
        {
            CODATestIDMapExt.put(item.Name, item.Id);
        }

        Set<String> bankNames = new Set<String>();
        bankNames.add(CODABaseDataExt.NAMEBANKACC_SANTANDERCURRENTACCOUNT);
        bankNames.add(CODABaseDataExt.NAMEBANKACC_BRISTOLDEPOSITACCOUNT);

        for (codaBankAccount__c item : [Select Id, Name, OwnerCompany__r.Name from codaBankAccount__c where Name in :bankNames])
        {
            CODATestIDMapExt.put(item.OwnerCompany__r.Name + ':' + item.Name, item.id);
        }

        for (codaAccountingCurrency__c item : [Select Id, Name, OwnerCompany__r.Name from codaAccountingCurrency__c])
        {
            CODATestIDMapExt.put(item.OwnerCompany__r.Name + ':' + item.Name, item.id);
        }

        CODATestIDMapExt.save(SUFFIX);
    }
}
