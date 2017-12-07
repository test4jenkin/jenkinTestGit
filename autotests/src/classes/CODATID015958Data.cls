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

public class CODATID015958Data
{
	public static final String SUFFIX = 'TID015958#';
	public static final String CSH_REF1 = 'CSH_1';
	public static final String CSH_REF2 = 'CSH_2';
	public static final String CSH_REF3 = 'CSH_3';

	public static void selectCompany()
	{
		CODABaseData.switchCurrentCompany(CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN, true, true, UserInfo.getUserId());
	}

	public static void switchProfile()
	{
		Id userId = CODABaseData.getProfile(CODABaseData.ACCOUNTANT).Id;
		CODABaseData.switchCurrentCompany(CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN, true, true, userId);
		CODABaseData.switchCurrentCompany(CODABaseData.NAMECOMPANY_MERLINAUTOAUS, true, false, userId);
	}

	public static void createData()
	{
		loadMap();

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

		CODATestIDMapExt.put(CSH_REF2, cashEntry.getId());
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

		CODATestIDMapExt.put(CSH_REF3, cashEntry.getId());

		CODATestIDMapExt.save(SUFFIX);
	}

	public static void destroyData()
	{
		CODATestIDMapExt.load(SUFFIX);
		CODAContext.enableSupportAccess();

		CODADataTestHelper.deleteSystemTestDate(SUFFIX);

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

		for (codaCompany__c companyName : [Select Id, Name From codaCompany__c where Name in :companyNames])
		{
			CODATestIDMapExt.put(companyName.Name, companyName.id);
		}

		Set<String> glaNames = new Set<String>();
		glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLEUR);
		glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLGBP);
		glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD);
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
