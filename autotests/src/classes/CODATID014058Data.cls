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

public class CODATID014058Data
{
	public static String SUFFIX = '#TID014058#';
	public static final String COMPANYCO1 = 'CUSTOMCO1';
	public static final String COMPANYCO2 = 'CUSTOMCO2';
	public static final String COMPANYCO3 = 'CUSTOMCO3';
	public static final String COMPANYCO4 = 'CUSTOMCO4';
	public static final String COMPANYCO5 = 'CUSTOMCO5';
	public static final String COMPANYCO6 = 'CUSTOMCO6';
	public static final String COMPANYCO7 = 'CUSTOMCO7';
	public static final String COMPANYCO8 = 'CUSTOMCO8';
	public static final String CURRENCYCODE_EUR ='EUR';
	public static final String CURRENCYCODE_USD ='USD';

	public static void selectCompany()
	{
		// not required
	}

	public static void switchProfile()
	{
		// not required
	}

	public static void createData()
	{
		try
		{
			CODAUnitOfWork.getCurrent();
			setupCompanies();
			CODAUnitOfWork.getCurrent().commitWork();
		}
		catch(Exception e)
		{
			throw CODAExceptionHelper.compact(e);
		}
	}

	public static void createDataExt1()
	{
		loadMap();
		createOwnership(COMPANYCO1, COMPANYCO2, 60);
		createOwnership(COMPANYCO1, COMPANYCO3, 60);
		createOwnership(COMPANYCO3, COMPANYCO4, 60);
		createOwnership(COMPANYCO3, COMPANYCO5, 60);
		createOwnership(COMPANYCO6, COMPANYCO7, 60);
		createOwnership(COMPANYCO5, COMPANYCO7, 40);
		createOwnership(COMPANYCO1, COMPANYCO4, 40);

		CODACompany owned = CODACompanyMapper.getById(CODATestIDMap.resolve(COMPANYCO8));
		companyOwnership__c ownership = new companyOwnership__c();
		ownership.externalCompany__c = 'External Company 1';
		ownership.company__c = owned.getId();
		ownership.percentageOwnership__c = 100;
		insert ownership;
	}

	public static void destroyData()
	{
		CODAContext.enableSupportAccess();

		CODAUnitOfWork.createAndSetCurrent();
		for(companyOwnership__c[] companies : [select Id from companyOwnership__c])
			delete companies;
		for(codaCompany__c[] companies : [select Id from codaCompany__c WHERE Name like 'CUSTOMCO%'])
			delete companies;

		CODATestIDMapExt.purge(SUFFIX);
		CODAUnitOfWork.getCurrent().commitWork();
	}

	private static void setupCompanies()
	{
		CODABaseData.createCompany(COMPANYCO1, CODARecordType.COMPANY_VAT, CURRENCYCODE_EUR, '123456', CODACompany.ECCOUNTRYCODE_ES, 'Spain', 'Granada',
									'info@merlinautosp.es', '(+34)-958-100589', '(+34)-958-100588', 'Granada',
									'Aixa la Horra, s/n', '54321', 'www.merlinautosp.es', '18008',
									CODACompany.CASHMATCHINGCURRENCYMODE_ACCOUNT, null,
									null, null);
		CODABaseData.createCompany(COMPANYCO2, CODARecordType.COMPANY_SUT, CURRENCYCODE_USD, null, null, 'US', 'Cambridge',
									null, '(800)-320-8919', '(800)-320-8918', 'MA',
									'52 Maple Avenue', '04-3145967', null, '02139-1128',
									CODACompany.CASHMATCHINGCURRENCYMODE_ACCOUNT, null,
									null, null);
		CODABaseData.createCompany(COMPANYCO3, CODARecordType.COMPANY_GST, CURRENCYCODE_EUR, '123456', CODACompany.ECCOUNTRYCODE_ES, 'Spain', 'Granada',
									'info@merlinautosp.es', '(+34)-958-100589', '(+34)-958-100588', 'Granada',
									'Aixa la Horra, s/n', '54321', 'www.merlinautosp.es', '18008',
									CODACompany.CASHMATCHINGCURRENCYMODE_ACCOUNT, null,
									null, null);
		CODABaseData.createCompany(COMPANYCO4, CODARecordType.COMPANY_SUT, CURRENCYCODE_USD, null, null, 'US', 'Cambridge',
									null, '(800)-320-8919', '(800)-320-8918', 'MA',
									'52 Maple Avenue', '04-3145967', null, '02139-1128',
									CODACompany.CASHMATCHINGCURRENCYMODE_ACCOUNT, null,
									null, null);
		CODABaseData.createCompany(COMPANYCO5, CODARecordType.COMPANY_VAT, CURRENCYCODE_EUR, '123456', CODACompany.ECCOUNTRYCODE_ES, 'Spain', 'Granada',
									'info@merlinautosp.es', '(+34)-958-100589', '(+34)-958-100588', 'Granada',
									'Aixa la Horra, s/n', '54321', 'www.merlinautosp.es', '18008',
									CODACompany.CASHMATCHINGCURRENCYMODE_ACCOUNT, null,
									null, null);
		CODABaseData.createCompany(COMPANYCO6, CODARecordType.COMPANY_GST, CURRENCYCODE_USD, null, null, 'US', 'Cambridge',
									null, '(800)-320-8919', '(800)-320-8918', 'MA',
									'52 Maple Avenue', '04-3145967', null, '02139-1128',
									CODACompany.CASHMATCHINGCURRENCYMODE_ACCOUNT, null,
									null, null);
		CODABaseData.createCompany(COMPANYCO7, CODARecordType.COMPANY_VAT, CURRENCYCODE_EUR, '123456', CODACompany.ECCOUNTRYCODE_ES, 'Spain', 'Granada',
									'info@merlinautosp.es', '(+34)-958-100589', '(+34)-958-100588', 'Granada',
									'Aixa la Horra, s/n', '54321', 'www.merlinautosp.es', '18008',
									CODACompany.CASHMATCHINGCURRENCYMODE_ACCOUNT, null,
									null, null);
		CODABaseData.createCompany(COMPANYCO8, CODARecordType.COMPANY_SUT, CURRENCYCODE_USD, null, null, 'US', 'Cambridge',
									null, '(800)-320-8919', '(800)-320-8918', 'MA',
									'52 Maple Avenue', '04-3145967', null, '02139-1128',
									CODACompany.CASHMATCHINGCURRENCYMODE_ACCOUNT, null,
									null, null);
	}

	private static void createOwnership(String ownerName, String ownedName, Decimal percentage)
	{
		CODACompany owner = CODACompanyMapper.getById(CODATestIDMap.resolve(ownerName));
		CODACompany owned = CODACompanyMapper.getById(CODATestIDMap.resolve(ownedName));

		companyOwnership__c ownership = new companyOwnership__c();
		ownership.internalCompany__c = owner.getId();
		ownership.company__c = owned.getId();
		ownership.percentageOwnership__c = percentage;

		insert ownership;
	}

	public static void loadMap()
	{
		for (codaCompany__c companyName : [Select Id, Name From codaCompany__c])
		{
			CODATestIDMapExt.put(companyName.Name, companyName.id);
		}
		CODATestIDMapExt.save(SUFFIX);
	}
}
