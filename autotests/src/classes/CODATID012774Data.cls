/*
 * FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 * supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 * Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 * result in criminal or other legal proceedings.
 *
 * Copyright FinancialForce.com, inc. All rights reserved.
 */

public with sharing class CODATID012774Data
{
	public static String SUFFIX = '#TID012774#';
	public static String COMPANYUSA = CODABaseData.NAMECOMPANY_MERLINAUTOUSA;
	public static String SCHED1 = 'Schedule 1';
	public static String TEMPLATE1 = 'Template 1';
	public static String TEMPLATE2 = 'Template 2';
	public static String GLA_ARIS = CODABaseDataExt.NAMEGLA_ACCOUNTSRECEIVABLEIS;
	public static String DIM_1_EUR = CODABaseDataExt.NAMEDIM1_EUR;
	public static String CURRENCYEUR = 'EUR';
	public static String PRODUCT_AUTOCOMCLUTCH = CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH;

	public static void selectcompany()
	{
		CODABaseData.switchCurrentcompany(COMPANYUSA, true, true, UserInfo.getUserId());
	}

	public static void switchProfile()
	{
		Id userId = CODABaseData.getProfile(CODABaseData.ACCOUNTANT).Id;
		CODABaseData.switchCurrentCompany(COMPANYUSA, true, false, userId);
	}

	// Create sales invoice
	public static void createData()
	{
		loadMap();

		codaInvoice__c sinv = new codaInvoice__c();
		sinv.Account__c = CODATestIDMap.resolve(CODABaseDataExt.NAMEACCOUNT_UNIT4);
		sinv.InvoiceCurrency__c = CODATestIDMap.resolve(COMPANYUSA + ':' + CURRENCYEUR);
		sinv.InvoiceDate__c = System.today();
		sinv.CustomerReference__c = 'SINVREF';

		insert sinv;

		codaInvoiceLineItem__c line1 = new codaInvoiceLineItem__c();
		line1.Invoice__c = sinv.Id;
		line1.Product__c = CODATestIDMap.resolve(PRODUCT_AUTOCOMCLUTCH);
		line1.Quantity__c = 1;
		line1.UnitPrice__c = 100.00;
		insert line1;

		CODATestIDMapExt.put('SINV', sinv.Id);
		CODATestIDMapExt.save(SUFFIX);

		CODAInvoiceTestHelper wrappedSinv = new CODAInvoiceTestHelper('SINV');
		wrappedSinv.post();
	}

	// Create Template 1 and include it in a schedule
	public static void createDataExt1()
	{
		CODATestIDMapExt.load(SUFFIX);

		// Template header
		AllocationTemplate__c allocTemplate = new AllocationTemplate__c();
		allocTemplate.name = TEMPLATE1;
		allocTemplate.Description__c = TEMPLATE1;
		insert allocTemplate;

		// Template filters
		List<AllocationFilterStructure__c> filterStructureList = new List<AllocationFilterStructure__c>();

		AllocationFilterStructure__c filterStructure = new AllocationFilterStructure__c();
		filterStructure.FilterPosition__c = 1;
		filterStructure.FilterStructureType__c = AllocationFilterStructures.FILTERSTRUCTURETYPE_CODAGENERALLEDGERACCOUNT;
		filterStructure.AllocationTemplate__c = allocTemplate.id;
		filterStructureList.add(filterStructure);

		AllocationFilterStructure__c filterStructure2 = new AllocationFilterStructure__c();
		filterStructure2.FilterPosition__c = 1;
		filterStructure2.FilterStructureType__c = AllocationFilterStructures.FILTERSTRUCTURETYPE_CODADIMENSION1;
		filterStructure2.AllocationTemplate__c = allocTemplate.id;
		filterStructureList.add(filterStructure2);

		insert filterStructureList;

		List<AllocationFilter__c> filterValueList = new List<AllocationFilter__c>();

		AllocationFilter__c filterValue = new AllocationFilter__c();
		filterValue.AllocationFilterStructure__c = filterStructure.id;
		filterValue.FilterCriteria__c = AllocationFilters.FILTERCRITERIA_MULTISELECT;
		filterValue.GeneralLedgerAccount__c = CODATestIDMap.resolve(GLA_ARIS);
		filterValueList.add(filterValue);

		AllocationFilter__c filterValue2 = new AllocationFilter__c();
		filterValue2.AllocationFilterStructure__c = filterStructure2.id;
		filterValue2.FilterCriteria__c = AllocationFilters.FILTERCRITERIA_MULTISELECT;
		filterValue2.Dimension1__c = CODATestIDMap.resolve(DIM_1_EUR);
		filterValueList.add(filterValue2);

		insert filterValueList;

		// Template split
		AllocationSplitTemplate__c split = new AllocationSplitTemplate__c();
		split.AllocationTemplate__c = allocTemplate.id;
		split.GeneralLedgerAccount__c = CODATestIDMap.resolve(GLA_ARIS);
		split.PercentageSplit__c = 100;

		insert split;

		// Schedule
		List<AllocationScheduleService.AllocationTemplate> templates = AllocationScheduleService.getAllSchedulableTemplates();

		AllocationScheduleService.AllocationScheduleTemplate newScheduleTemplate = new AllocationScheduleService.AllocationScheduleTemplate();
		newScheduleTemplate.allocationTemplate = templates[0];
		newScheduleTemplate.sequence = 1;

		List<AllocationScheduleService.AllocationScheduleTemplate> scheduletemplates = new List<AllocationScheduleService.AllocationScheduleTemplate>();
		scheduletemplates.add(newScheduleTemplate);

		AllocationScheduleTestHelper.AllocationSchedule testHelper = new AllocationScheduleTestHelper.AllocationSchedule();
		AllocationScheduleService.AllocationSchedule schedule = testHelper.withBasicDetails(SCHED1, SCHED1, true)
			.withAllocationScheduleTemplates(scheduletemplates)
			.withRunDetails(CronSpec.createDailyCron('9'))
			.withEndDateDetails('Never', null, null)
			.withRetrieveTransactionsDetails('RetrieveTransactionsFromFirstTransaction', null, null, null, null, 0, null, 0)
			.withPostingDateDetails('OffsetDate',null,2)
			.withTransactionPeriodDetails('RunDate', null)
			.withTransactionDescription(SCHED1)
			.getAllocationSchedule();

		Set<AllocationScheduleService.AllocationSchedule> allscheds = new Set <AllocationScheduleService.AllocationSchedule>();
		allscheds.add(schedule);

		AllocationScheduleService.save(allscheds);

		CODATestIDMapExt.put(TEMPLATE1, allocTemplate.Id);
		CODATestIDMapExt.save(SUFFIX);
	}

	// Create Template 2
	public static void createDataExt2()
	{
		CODATestIDMapExt.load(SUFFIX);

		// Template header
		AllocationTemplate__c allocTemplate = new AllocationTemplate__c();
		allocTemplate.name = TEMPLATE2;
		allocTemplate.Description__c = TEMPLATE2;
		insert allocTemplate;

		// Template filters
		List<AllocationFilterStructure__c> filterStructureList = new List<AllocationFilterStructure__c>();

		AllocationFilterStructure__c filterStructure = new AllocationFilterStructure__c();
		filterStructure.FilterPosition__c = 1;
		filterStructure.FilterStructureType__c = AllocationFilterStructures.FILTERSTRUCTURETYPE_CODAGENERALLEDGERACCOUNT;
		filterStructure.AllocationTemplate__c = allocTemplate.id;
		filterStructureList.add(filterStructure);

		AllocationFilterStructure__c filterStructure2 = new AllocationFilterStructure__c();
		filterStructure2.FilterPosition__c = 1;
		filterStructure2.FilterStructureType__c = AllocationFilterStructures.FILTERSTRUCTURETYPE_CODADIMENSION1;
		filterStructure2.AllocationTemplate__c = allocTemplate.id;
		filterStructureList.add(filterStructure2);

		insert filterStructureList;

		List<AllocationFilter__c> filterValueList = new List<AllocationFilter__c>();

		AllocationFilter__c filterValue = new AllocationFilter__c();
		filterValue.AllocationFilterStructure__c = filterStructure.id;
		filterValue.FilterCriteria__c = AllocationFilters.FILTERCRITERIA_MULTISELECT;
		filterValue.GeneralLedgerAccount__c = CODATestIDMap.resolve(GLA_ARIS);
		filterValueList.add(filterValue);

		AllocationFilter__c filterValue2 = new AllocationFilter__c();
		filterValue2.AllocationFilterStructure__c = filterStructure2.id;
		filterValue2.FilterCriteria__c = AllocationFilters.FILTERCRITERIA_MULTISELECT;
		filterValue2.Dimension1__c = CODATestIDMap.resolve(DIM_1_EUR);
		filterValueList.add(filterValue2);

		insert filterValueList;

		CODATestIDMapExt.put(allocTemplate.Name, allocTemplate.Id);
		CODATestIDMapExt.save(SUFFIX);
	}

	public static void destroyData()
	{
		CODAContext.enableSupportAccess();

		for (AllocScheduleRunTransaction__c[] ascht : [SELECT id FROM AllocScheduleRunTransaction__c])
		{
			delete ascht;
		}

		for (allocScheduleTemplate__c[] ascht : [SELECT id FROM allocScheduleTemplate__c])
		{
			delete ascht;
		}

		for (allocScheduleCompany__c[] aschc : [SELECT id FROM allocScheduleCompany__c])
		{
			delete aschc;
		}

		for (allocationTemplate__c[] atmp : [SELECT id FROM allocationTemplate__c])
		{
			delete atmp;
		}

		for(codaTransaction__c[] trans : [SELECT Id FROM codaTransaction__c])
		{
			delete trans;
		}

		for (codaInvoice__c[] cpi : [SELECT id FROM codaInvoice__c])
		{
			delete cpi;
		}

		CODATestIDMapExt.purge(SUFFIX);
	}

	public static void loadMap()
	{
		CODAUnitOfWork.createAndSetCurrent();

		// Companies
		Set<String> companyNames = new set<String>{COMPANYUSA};
		for (codaCompany__c comp : [Select Id, Name from codaCompany__c where Name in :companyNames])
		{
			CODATestIDMapExt.put(comp.Name, comp.id);
		}

		// Bank Accounts
		for (codaBankAccount__c bankAcc : [Select Id, Name, OwnerCompany__r.name from codaBankAccount__c where OwnerCompany__r.Name in :companyNames])
		{
			CODATestIDMapExt.put(bankAcc.OwnerCompany__r.name + ':' + bankAcc.Name, bankAcc.id);
		}

		// Accounts
		set<String> accNames = new set<String>();
		accNames.add(CODABaseDataExt.NAMEACCOUNT_UNIT4);
		for (Account acc : [Select Id, Name from Account where MirrorName__c in :accNames])
		{
			CODATestIDMapExt.put(acc.Name, acc.id);
		}

		// Periods
		for (codaPeriod__c period : [Select Id, Name, OwnerCompany__c, OwnerCompany__r.Name from codaPeriod__c where OwnerCompany__r.Name = :COMPANYUSA])
		{
			CODATestIDMapExt.put(period.OwnerCompany__r.name + ':' + period.Name, period.id);
		}

		// Currencies
		for (codaAccountingCurrency__c accCurr : [Select Id, Name, OwnerCompany__r.name from codaAccountingCurrency__c where OwnerCompany__r.name = :COMPANYUSA])
		{
			CODATestIDMapExt.put(accCurr.OwnerCompany__r.name + ':' + accCurr.Name, accCurr.id);
		}

		// General Ledger Account
		set<String> glaNames = new set<String>();
		glaNames.add(CODABaseDataExt.NAMEGLA_ACCOUNTSRECEIVABLEIS);
		glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLEUR);

		for (codaGeneralLedgerAccount__c gla : [Select Id, Name from codaGeneralLedgerAccount__c where Name in :glaNames])
		{
			CODATestIDMapExt.put(gla.Name, gla.id);
		}

		// Products
		set<String> productNames = new set<String>();
		productNames.add(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);

		for (Product2 prod : [Select Id, Name from Product2 where Name in :productNames])
		{
			CODATestIDMapExt.put(prod.Name, prod.id);
		}

		// Dimension1
		set<String> dim1Names = new set<String>();
		dim1Names.add(CODABaseDataExt.NAMEDIM1_EUR);
		for (codaDimension1__c item : [Select Id, Name from codaDimension1__c where Name in :dim1Names])
		{
			CODATestIDMapExt.put(item.Name, item.id);
		}

		CODATestIDMapExt.save(SUFFIX);
	}
}

