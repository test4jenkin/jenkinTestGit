/*
 * FinancialForce.com, inc. claims copyright in this software, its screen
 * display designs and supporting documentation. FinancialForce and
 * FinancialForce.com are trademarks of FinancialForce.com, inc. Any
 * unauthorized use, copying or sale of the above may constitute an
 * infringement of copyright and may result in criminal or other legal
 * proceedings.
 *
 * Copyright (c) 2015 FinancialForce.com, inc. All rights reserved.
 */

public class CODATID014831Data
{
	public static final String SUFFIX = 'TID014831#';
	public static final String CSH_REF1 = 'CSH_1';
	public static final String CSH_REF2 = 'CSH_2';
	public static final String CSH_REF3 = 'CSH_3';
	public static final String CSH_REF4 = 'CSH_4';
	public static final String CSH_REF5 = 'CSH_5';
	public static final String CSH_REF6 = 'CSH_6';
	public static final String MERLIN_SPAIN_ACCOUNT ='Merlin Spain Account';
	public static final String MERLIN_GB_ACCOUNT ='Merlin GB Account';

	public static void selectCompany()
	{
		CODABaseData.switchCurrentCompany(CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN, true, true, UserInfo.getUserId());
	}

	public static void switchProfile()
	{
		Id userId = CODABaseData.getProfile(CODABaseData.ACCOUNTANT).Id;
		CODABaseData.switchCurrentCompany(CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN, true, true, userId);
		CODABaseData.switchCurrentCompany(CODABaseData.NAMECOMPANY_MERLINAUTOGB, true, false, userId);
		CODABaseData.switchCurrentCompany(CODABaseData.NAMECOMPANY_MERLINAUTOAUS, true, false, userId);
	}

	public static void createData()
	{
		loadMap();

		CODAUnitOfWork.getCurrent().commitWork();

		CODAIntercompanyDefinition interCompany2 = new CODAIntercompanyDefinition();
		interCompany2.setRelatedCompanyId(CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOGB));
		interCompany2.setSendingControlAccountId(CODATestIDMap.resolve(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLEUR));
		interCompany2.setReceivingControlAccountId(CODATestIDMap.resolve(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLGBP));
		interCompany2.setOwnerCompanyId(CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN));

		CODAAccount account=new CODAAccount();
		account.setName(MERLIN_SPAIN_ACCOUNT);
		account.setAccountTradingCurrency(CODABaseData.CURRENCYCODE_EUR);

		CODAAccount account1=new CODAAccount();
		account1.setName(MERLIN_GB_ACCOUNT);
		account1.setAccountTradingCurrency(CODABaseData.CURRENCYCODE_GBP);

		CODAUnitOfWork.getCurrent().commitWork();
		CODATestIDMapExt.put(MERLIN_SPAIN_ACCOUNT, account.getId());
		CODATestIDMapExt.put(MERLIN_GB_ACCOUNT, account1.getId());

		CODACompany merlinSpain=CODACompanyMapper.getByName(CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN)[0];
		merlinSpain.setIntercompanyAccountId(account.getId());

		CODACompany merlinGB=CODACompanyMapper.getByName(CODABaseData.NAMECOMPANY_MERLINAUTOGB)[0];
		merlinGB.setIntercompanyAccountId(account1.getId());

		CODAUnitOfWork.getCurrent().commitWork();

		CODADataTestHelper.setSystemTestDate(SUFFIX);

		Date cashEntryDate = CODADataTestHelper.getSystemTestDate(SUFFIX);

		CODAPeriod period = CODAPeriodMapExt.getPeriodByDate(cashEntryDate);

		CODACashEntryTestHelper cashEntry = new CODACashEntryTestHelper();
		cashEntry.setType(CODACashEntry.TYPE_RECEIPT);
		cashEntry.setBankAccount(CODABaseDataExt.NAMEBANKACC_SANTANDERCURRENTACCOUNT + ':' + CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN);
		cashEntry.setDate(cashEntryDate);
		cashEntry.setPeriod(period.getName() + ':' + CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN);
		cashEntry.setReference(CSH_REF1);
		cashEntry.setCurrency(CODABaseData.CURRENCYCODE_USD + ':' + CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN);
		cashEntry.setAccount(CODABaseDataExt.NAMEACCOUNT_CWOERMANNGMBHCOKG);
		CODACashEntryTestHelper.LineItem cashEntryLine1 = cashEntry.newLine();
		cashEntryLine1.setLineAccount(CODABaseDataExt.NAMEACCOUNT_CWOERMANNGMBHCOKG);
		cashEntryLine1.setCashEntryValue('10.33');
		cashEntry.setAccount(CODABaseDataExt.NAMEACCOUNT_CWOERMANNGMBHCOKG);
		CODACashEntryTestHelper.LineItem cashEntryLine2 = cashEntry.newLine();
		cashEntryLine2.setLineAccount(CODABaseDataExt.NAMEACCOUNT_CWOERMANNGMBHCOKG);
		cashEntryLine2.setCashEntryValue('10.25');
		cashEntryLine2.setAccountDimension1(CODABaseDataExt.NAMEDIM1_EUR);
		cashEntry.setAccount(CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO);
		CODACashEntryTestHelper.LineItem cashEntryLine3 = cashEntry.newLine();
		cashEntryLine3.setLineAccount(CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO);
		cashEntryLine3.setCashEntryValue('10.14');
		cashEntryLine3.setAccountDimension2(CODABaseDataExt.NAMEDIM2_EUR);
		cashEntry.setAccount(CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO);
		CODACashEntryTestHelper.LineItem cashEntryLine4 = cashEntry.newLine();
		cashEntryLine4.setLineAccount(CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO);
		cashEntryLine4.setCashEntryValue('10.05');
		cashEntryLine4.setAccountDimension3(CODABaseDataExt.NAMEDIM3_EUR);
		cashEntry.setAccount(CODABaseDataExt.NAMEACCOUNT_FASTFIT1LTD);
		CODACashEntryTestHelper.LineItem cashEntryLine5 = cashEntry.newLine();
		cashEntryLine5.setLineAccount(CODABaseDataExt.NAMEACCOUNT_FASTFIT1LTD);
		cashEntryLine5.setCashEntryValue('10.00');
		cashEntryLine5.setAccountDimension4(CODABaseDataExt.NAMEDIM4_EUR);
		cashEntry.saveandpost();
		cashEntry.reload();

		CODATestIDMapExt.put(CSH_REF1, cashEntry.getId());
		CODATestIDMapExt.save(SUFFIX);
	}

	public static void createDataExt1()
	{
		CODATestIDMapExt.load(SUFFIX);

		Date cashEntryDate = CODADataTestHelper.getSystemTestDate(SUFFIX);
		cashEntryDate = cashEntryDate.addMonths(1);
		CODAPeriod period = CODAPeriodMapExt.getPeriodByDate(cashEntryDate);

		{
			CODACashEntryTestHelper cashEntry = new CODACashEntryTestHelper();
			cashEntry.setType(CODACashEntry.TYPE_RECEIPT);
			cashEntry.setBankAccount(CODABaseDataExt.NAMEBANKACC_SANTANDERCURRENTACCOUNT + ':' + CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN);
			cashEntry.setDate(cashEntryDate);
			cashEntry.setPeriod(period.getName() + ':' + CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN);
			cashEntry.setReference(CSH_REF2);
			cashEntry.setCurrency(CODABaseData.CURRENCYCODE_USD + ':' + CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN);
			cashEntry.setAccount(CODABaseDataExt.NAMEACCOUNT_CWOERMANNGMBHCOKG);
			CODACashEntryTestHelper.LineItem cashEntryLine1 = cashEntry.newLine();
			cashEntryLine1.setLineAccount(CODABaseDataExt.NAMEACCOUNT_CWOERMANNGMBHCOKG);
			cashEntryLine1.setCashEntryValue('10.34');
			cashEntry.setAccount(CODABaseDataExt.NAMEACCOUNT_CWOERMANNGMBHCOKG);
			CODACashEntryTestHelper.LineItem cashEntryLine2 = cashEntry.newLine();
			cashEntryLine2.setLineAccount(CODABaseDataExt.NAMEACCOUNT_CWOERMANNGMBHCOKG);
			cashEntryLine2.setCashEntryValue('10.26');
			cashEntryLine2.setAccountDimension1(CODABaseDataExt.NAMEDIM1_EUR);
			cashEntry.setAccount(CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO);
			CODACashEntryTestHelper.LineItem cashEntryLine3 = cashEntry.newLine();
			cashEntryLine3.setLineAccount(CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO);
			cashEntryLine3.setCashEntryValue('10.15');
			cashEntryLine3.setAccountDimension2(CODABaseDataExt.NAMEDIM2_EUR);
			cashEntry.setAccount(CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO);
			CODACashEntryTestHelper.LineItem cashEntryLine4 = cashEntry.newLine();
			cashEntryLine4.setLineAccount(CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO);
			cashEntryLine4.setCashEntryValue('10.06');
			cashEntryLine4.setAccountDimension3(CODABaseDataExt.NAMEDIM3_EUR);
			cashEntry.setAccount(CODABaseDataExt.NAMEACCOUNT_FASTFIT1LTD);
			CODACashEntryTestHelper.LineItem cashEntryLine5 = cashEntry.newLine();
			cashEntryLine5.setLineAccount(CODABaseDataExt.NAMEACCOUNT_FASTFIT1LTD);
			cashEntryLine5.setCashEntryValue('10.01');
			cashEntryLine5.setAccountDimension4(CODABaseDataExt.NAMEDIM4_EUR);
			cashEntry.saveandpost();
			cashEntry.reload();
			CODATestIDMapExt.put(CSH_REF2, cashEntry.getId());
		}
		{
			CODACashEntryTestHelper cashEntry = new CODACashEntryTestHelper();
			cashEntry.setType(CODACashEntry.TYPE_RECEIPT);
			cashEntry.setBankAccount(CODABaseDataExt.NAMEBANKACC_SANTANDERCURRENTACCOUNT + ':' + CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN);
			cashEntry.setDate(cashEntryDate);
			cashEntry.setPeriod(period.getName() + ':' + CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN);
			cashEntry.setReference(CSH_REF6);
			cashEntry.setCurrency(CODABaseData.CURRENCYCODE_USD + ':' + CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN);
			cashEntry.setAccount(MERLIN_GB_ACCOUNT);
			CODACashEntryTestHelper.LineItem cashEntryLine1 = cashEntry.newLine();
			cashEntryLine1.setLineAccount(MERLIN_GB_ACCOUNT);
			cashEntryLine1.setCashEntryValue('100.00');
			cashEntry.saveandpost();
			cashEntry.reload();
			CODATestIDMapExt.put(CSH_REF6, cashEntry.getId());
		}
		CODATestIDMapExt.save(SUFFIX);
	}

	public static void createDataExt2()
	{
		CODABaseData.switchCurrentCompany(CODABaseData.NAMECOMPANY_MERLINAUTOAUS, true, true, UserInfo.getUserId());
	}

	public static void createDataExt3()
	{
		CODATestIDMapExt.load(SUFFIX);

		Date cashEntryDate = CODADataTestHelper.getSystemTestDate(SUFFIX);
		CODAPeriod period = CODAPeriodMapExt.getPeriodByDate(cashEntryDate);

		{
			CODACashEntryTestHelper cashEntry = new CODACashEntryTestHelper();
			cashEntry.setType(CODACashEntry.TYPE_RECEIPT);
			cashEntry.setBankAccount(CODABaseDataExt.NAMEBANKACC_COMMONWEALTHCURRENTACCOUNT + ':' + CODABaseData.NAMECOMPANY_MERLINAUTOAUS);
			cashEntry.setDate(cashEntryDate);
			cashEntry.setPeriod(period.getName() + ':' + CODABaseData.NAMECOMPANY_MERLINAUTOAUS);
			cashEntry.setReference(CSH_REF3);
			cashEntry.setCurrency(CODABaseData.CURRENCYCODE_USD + ':' + CODABaseData.NAMECOMPANY_MERLINAUTOAUS);
			cashEntry.setAccount(CODABaseDataExt.NAMEACCOUNT_CWOERMANNGMBHCOKG);
			CODACashEntryTestHelper.LineItem cashEntryLine1 = cashEntry.newLine();
			cashEntryLine1.setLineAccount(CODABaseDataExt.NAMEACCOUNT_CWOERMANNGMBHCOKG);
			cashEntryLine1.setCashEntryValue('10.33');
			cashEntry.setAccount(CODABaseDataExt.NAMEACCOUNT_CWOERMANNGMBHCOKG);
			CODACashEntryTestHelper.LineItem cashEntryLine2 = cashEntry.newLine();
			cashEntryLine2.setLineAccount(CODABaseDataExt.NAMEACCOUNT_CWOERMANNGMBHCOKG);
			cashEntryLine2.setCashEntryValue('10.25');
			cashEntryLine2.setAccountDimension1(CODABaseDataExt.NAMEDIM1_EUR);
			cashEntry.setAccount(CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO);
			CODACashEntryTestHelper.LineItem cashEntryLine3 = cashEntry.newLine();
			cashEntryLine3.setLineAccount(CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO);
			cashEntryLine3.setCashEntryValue('10.14');
			cashEntryLine3.setAccountDimension2(CODABaseDataExt.NAMEDIM2_EUR);
			cashEntry.setAccount(CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO);
			CODACashEntryTestHelper.LineItem cashEntryLine4 = cashEntry.newLine();
			cashEntryLine4.setLineAccount(CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO);
			cashEntryLine4.setCashEntryValue('10.05');
			cashEntryLine4.setAccountDimension3(CODABaseDataExt.NAMEDIM3_EUR);
			cashEntry.setAccount(CODABaseDataExt.NAMEACCOUNT_FASTFIT1LTD);
			CODACashEntryTestHelper.LineItem cashEntryLine5 = cashEntry.newLine();
			cashEntryLine5.setLineAccount(CODABaseDataExt.NAMEACCOUNT_FASTFIT1LTD);
			cashEntryLine5.setCashEntryValue('10.00');
			cashEntryLine5.setAccountDimension4(CODABaseDataExt.NAMEDIM4_EUR);
			cashEntry.saveandpost();
			cashEntry.reload();
			CODATestIDMapExt.put(CSH_REF3, cashEntry.getId());
		}
		{
			cashEntryDate = cashEntryDate.addMonths(1);
			period = CODAPeriodMapExt.getPeriodByDate(cashEntryDate);
			CODACashEntryTestHelper cashEntry = new CODACashEntryTestHelper();
			cashEntry.setType(CODACashEntry.TYPE_RECEIPT);
			cashEntry.setBankAccount(CODABaseDataExt.NAMEBANKACC_COMMONWEALTHCURRENTACCOUNT + ':' + CODABaseData.NAMECOMPANY_MERLINAUTOAUS);
			cashEntry.setDate(cashEntryDate);
			cashEntry.setPeriod(period.getName() + ':' + CODABaseData.NAMECOMPANY_MERLINAUTOAUS);
			cashEntry.setReference(CSH_REF4);
			cashEntry.setCurrency(CODABaseData.CURRENCYCODE_USD + ':' + CODABaseData.NAMECOMPANY_MERLINAUTOAUS);
			cashEntry.setAccount(CODABaseDataExt.NAMEACCOUNT_CWOERMANNGMBHCOKG);
			CODACashEntryTestHelper.LineItem cashEntryLine1 = cashEntry.newLine();
			cashEntryLine1.setLineAccount(CODABaseDataExt.NAMEACCOUNT_CWOERMANNGMBHCOKG);
			cashEntryLine1.setCashEntryValue('10.34');
			cashEntry.setAccount(CODABaseDataExt.NAMEACCOUNT_CWOERMANNGMBHCOKG);
			CODACashEntryTestHelper.LineItem cashEntryLine2 = cashEntry.newLine();
			cashEntryLine2.setLineAccount(CODABaseDataExt.NAMEACCOUNT_CWOERMANNGMBHCOKG);
			cashEntryLine2.setCashEntryValue('10.26');
			cashEntryLine2.setAccountDimension1(CODABaseDataExt.NAMEDIM1_EUR);
			cashEntry.setAccount(CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO);
			CODACashEntryTestHelper.LineItem cashEntryLine3 = cashEntry.newLine();
			cashEntryLine3.setLineAccount(CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO);
			cashEntryLine3.setCashEntryValue('10.15');
			cashEntryLine3.setAccountDimension2(CODABaseDataExt.NAMEDIM2_EUR);
			cashEntry.setAccount(CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO);
			CODACashEntryTestHelper.LineItem cashEntryLine4 = cashEntry.newLine();
			cashEntryLine4.setLineAccount(CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO);
			cashEntryLine4.setCashEntryValue('10.06');
			cashEntryLine4.setAccountDimension3(CODABaseDataExt.NAMEDIM3_EUR);
			cashEntry.setAccount(CODABaseDataExt.NAMEACCOUNT_FASTFIT1LTD);
			CODACashEntryTestHelper.LineItem cashEntryLine5 = cashEntry.newLine();
			cashEntryLine5.setLineAccount(CODABaseDataExt.NAMEACCOUNT_FASTFIT1LTD);
			cashEntryLine5.setCashEntryValue('10.01');
			cashEntryLine5.setAccountDimension4(CODABaseDataExt.NAMEDIM4_EUR);
			cashEntry.saveandpost();
			cashEntry.reload();
			CODATestIDMapExt.put(CSH_REF4, cashEntry.getId());
		}

		CODATestIDMapExt.save(SUFFIX);
	}

	public static void createDataExt4()
	{
		CODABaseData.switchCurrentCompany(CODABaseData.NAMECOMPANY_MERLINAUTOGB, true, true, UserInfo.getUserId());
	}

	public static void createDataExt5()
	{
		CODATestIDMapExt.load(SUFFIX);

		CODAUnitOfWork.getCurrent().commitWork();
		CODAIntercompanyDefinition interCompany2 = new CODAIntercompanyDefinition();
		interCompany2.setRelatedCompanyId(CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN));
		interCompany2.setSendingControlAccountId(CODATestIDMap.resolve(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLGBP));
		interCompany2.setReceivingControlAccountId(CODATestIDMap.resolve(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLEUR));
		interCompany2.setOwnerCompanyId(CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOGB));
		CODAUnitOfWork.getCurrent().commitWork();

		Date cashEntryDate = CODADataTestHelper.getSystemTestDate(SUFFIX);
		CODAPeriod period = CODAPeriodMapExt.getPeriodByDate(cashEntryDate);

		CODACashEntryTestHelper cashEntry = new CODACashEntryTestHelper();
		cashEntry.setType(CODACashEntry.TYPE_RECEIPT);
		cashEntry.setBankAccount(CODABaseDataExt.NAMEBANKACC_BARCLAYSCURRENTACCOUNT + ':' + CODABaseData.NAMECOMPANY_MERLINAUTOGB);
		cashEntry.setDate(cashEntryDate);
		cashEntry.setPeriod(period.getName() + ':' + CODABaseData.NAMECOMPANY_MERLINAUTOGB);
		cashEntry.setReference(CSH_REF5);
		cashEntry.setCurrency(CODABaseData.CURRENCYCODE_GBP + ':' + CODABaseData.NAMECOMPANY_MERLINAUTOGB);
		cashEntry.setAccount(CODABaseDataExt.NAMEACCOUNT_CWOERMANNGMBHCOKG);
		CODACashEntryTestHelper.LineItem cashEntryLine1 = cashEntry.newLine();
		cashEntryLine1.setLineAccount(CODABaseDataExt.NAMEACCOUNT_CWOERMANNGMBHCOKG);
		cashEntryLine1.setCashEntryValue('10.33');
		cashEntry.setAccount(CODABaseDataExt.NAMEACCOUNT_CWOERMANNGMBHCOKG);
		CODACashEntryTestHelper.LineItem cashEntryLine2 = cashEntry.newLine();
		cashEntryLine2.setLineAccount(CODABaseDataExt.NAMEACCOUNT_CWOERMANNGMBHCOKG);
		cashEntryLine2.setCashEntryValue('10.25');
		cashEntryLine2.setAccountDimension1(CODABaseDataExt.NAMEDIM1_EUR);
		cashEntry.saveandpost();
		cashEntry.reload();

		CODATestIDMapExt.put(CSH_REF5, cashEntry.getId());
		CODATestIDMapExt.save(SUFFIX);
	}

	public static void createDataExt6()
	{
		CODATestIDMapExt.load(SUFFIX);
		codaIntercompanyTransfer__c ict = [SELECT Id, DestinationDocumentBankAccount__c FROM codaIntercompanyTransfer__c LIMIT 1];
		ict.DestinationDocumentBankAccount__c = CODATestIDMap.resolve(CODABaseDataExt.NAMEBANKACC_BARCLAYSCURRENTACCOUNT + ':' + CODABaseData.NAMECOMPANY_MERLINAUTOGB);
		update ict;

		ict = [SELECT Id FROM codaIntercompanyTransfer__c LIMIT 1];
		IntercompanyTransferService.process(new List<Id> {ict.Id});

		ict = [SELECT DestinationCashEntry__c, ProcessingStatus__c FROM codaIntercompanyTransfer__c LIMIT 1];
		codaCashEntry__c ce = [SELECT Id FROM codaCashEntry__c WHERE Id = :ict.DestinationCashEntry__c];
		CODACashEntryTestHelper cashEntry = new CODACashEntryTestHelper(ce);
		cashEntry.saveAndPost();
	}

	public static void destroyData()
	{
		CODATestIDMapExt.load(SUFFIX);
		CODAContext.enableSupportAccess();

		CODADataTestHelper.deleteSystemTestDate(SUFFIX);

		List<String> accountNames = new List<String>();
		accountNames.add(MERLIN_SPAIN_ACCOUNT);
		accountNames.add(MERLIN_GB_ACCOUNT);

		delete [Select Id From codaIntercompanyDefinition__c];
		delete [Select Id From codaIntercompanyTransfer__c];
		delete [Select Id From Account where MirrorName__c in :accountNames];
		delete [SELECT Id FROM codaCashEntry__c];
		delete [SELECT Id FROM codaCashEntryLineItem__c];
		delete [SELECT Id FROM codaTransaction__c];
		delete [SELECT Id FROM codaTransactionLineItem__c];

		CODAUnitOfWork.getCurrent().commitWork();
		CODAPaymentData.destroyPaymentData(SUFFIX);
		CODATestIDMapExt.purge(SUFFIX);
	}

	public static void loadMap()
	{
		Set<String> companyNames = new Set<String>();
		companyNames.add(CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN);
		companyNames.add(CODABaseData.NAMECOMPANY_MERLINAUTOAUS);
		companyNames.add(CODABaseData.NAMECOMPANY_MERLINAUTOGB);

		for (codaCompany__c companyName : [Select Id, Name From codaCompany__c where Name in :companyNames])
		{
			CODATestIDMapExt.put(companyName.Name, companyName.id);
		}

		Set<String> glaNames = new Set<String>();
		glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLGBP);
		glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLEUR);
		glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLEUR);
		glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLGBP);
		glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD);
		glaNames.add(CODABaseData.NAMEGLA_BANKACCOUNTEUROSUS);

		for (codaGeneralLedgerAccount__c item : [Select Id, Name From codaGeneralLedgerAccount__c where Name in :glaNames])
		{
			CODATestIDMapExt.put(item.Name, item.id);
		}

		for (codaPeriod__c period : [Select Id, Name, OwnerCompany__r.Name from codaPeriod__c where OwnerCompany__r.Name in :companyNames])
		{
			CODATestIDMapExt.put(period.Name + ':' + period.OwnerCompany__r.Name, period.id);
		}

		for (codaAccountingCurrency__c item : [Select Id, Name, OwnerCompany__r.Name from codaAccountingCurrency__c where OwnerCompany__r.Name in :companyNames])
		{
			CODATestIDMapExt.put(item.Name + ':' + item.OwnerCompany__r.Name, item.id);
		}

		Set<String> accNames = new Set<String>();
		accNames.add(CODABaseDataExt.NAMEACCOUNT_CWOERMANNGMBHCOKG);
		accNames.add(CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO);
		accNames.add(CODABaseDataExt.NAMEACCOUNT_FASTFIT1LTD);
		for (Account accId : [Select Id, Name from Account where MirrorName__c in :accNames])
		{
			CODATestIDMapExt.put(accId.Name, accId.id);
		}

		Set<String> bankNames = new Set<String>();
		bankNames.add(CODABaseDataExt.NAMEBANKACC_SANTANDERCURRENTACCOUNT);
		bankNames.add(CODABaseDataExt.NAMEBANKACC_BARCLAYSCURRENTACCOUNT);
		bankNames.add(CODABaseDataExt.NAMEBANKACC_COMMONWEALTHCURRENTACCOUNT);
		for (codaBankAccount__c item : [Select Id, Name, OwnerCompany__r.Name from codaBankAccount__c where Name in :bankNames])
		{
			CODATestIDMapExt.put(item.Name + ':' + item.OwnerCompany__r.Name, item.id);
		}

		for (codaDimension1__c dim1 : [select id, name from codaDimension1__c])
		{
			CODATestIDMapExt.put(dim1.Name, dim1.id);
		}

		for (codaDimension2__c dim2 : [select id, name from codaDimension2__c])
		{
			CODATestIDMapExt.put(dim2.Name, dim2.id);
		}

		for (codaDimension3__c dim3 : [select id, name from codaDimension3__c])
		{
			CODATestIDMapExt.put(dim3.Name, dim3.id);
		}

		for (codaDimension4__c dim4 : [select id, name from codaDimension4__c])
		{
			CODATestIDMapExt.put(dim4.Name, dim4.id);
		}
		CODATestIDMapExt.save(SUFFIX);
	}
}
