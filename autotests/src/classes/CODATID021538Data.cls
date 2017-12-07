/*
 * Copyright (c) 2017 FinancialForce.com, inc. All rights reserved.
 */
public with sharing class CODATID021538Data
{
    //SUFFIX
    public static String SUFFIX = '#TID021538';

    // GLAs that payable invoices will have lines for
    public static final String GLA2S_NAME = 'GLA2S';

    // GLAs that allocations will post to
    public static final String GLA_OUT1S_NAME = 'GLAOut1S';
    public static final String GLA_OUT2S_NAME = 'GLAOut2S';
    public static final String GLA_OUT3S_NAME = 'GLAOut3S';

    private static final String GLA_TYPE_BALANCE_SHEET = 'Balance Sheet';

    // name of the templates
    public static final String TEMPLATE1_NAME = 'Single 1';
    public static final String TEMPLATE2_NAME = 'Multico 1';
    public static final String TEMPLATE3_NAME = 'Multico 2';
    public static final String TEMPLATE4_NAME = 'Multico 3';
    public static final String TEMPLATE5_NAME = 'Multico Now';

    // name of statistical basis
    public static final String STATISTICAL_BASIS_NAME = 'Headcount';

    public static void switchProfile()
    {
        Id userId = CODABaseData.getProfile(CODABaseData.ACCOUNTANT).Id;    
        CODABaseData.switchCurrentCompany(CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN, true, true, userId);
    }
    
    public static void selectCompany()
    {
        CODABaseData.switchCurrentCompany(CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN, true, true, UserInfo.getUserId());
    } 
    
    public static void createData()
    {
        CODADataTestHelper.setSystemTestDate(SUFFIX);
        loadMap();
    }

    public static void createDataExt1()
    {
        CODATestIDMapExt.load(SUFFIX);

        Id companyId = CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN);

        Date todaysDate = CODADataTestHelper.getSystemTestDate(SUFFIX);

        // need to go back to the end of the 3rd previous month
        Date dateToUse = todaysDate.addMonths(-3).toStartOfMonth().addDays(-1);

        String OPENING_PERIOD = CODAPeriodExt.PERIOD_000;
        String ADJUSTMENT_PERIOD = CODAPeriodExt.PERIOD_100;
        String CLOSING_PERIOD = CODAPeriodExt.PERIOD_101;
        codaPeriod__c period = [Select Id, Name, OwnerCompany__r.Name from codaPeriod__c where StartDate__c <= :dateToUse and EndDate__c >= :dateToUse and OwnerCompany__c = :companyId and PeriodNumber__c != :OPENING_PERIOD and PeriodNumber__c != :ADJUSTMENT_PERIOD and PeriodNumber__c != :CLOSING_PERIOD];

        CODAJournalTestHelper journalHeader = CODADataTestHelper.journalHeader(dateToUse, CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN + ':EUR', '111', CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN + ':' +period.Name, 'Journal 1');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.DESTINATIONLINETYPE_ACCOUNTCUSTOMER, CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO, CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLEUR, '-1000.00', 'line 1');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO, CODABaseDataExt.NAMEGLA_RATES, '1000.00', 'line 2', CODABaseDataExt.NAMEDIM1_EUR, null, null, null);
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.DESTINATIONLINETYPE_ACCOUNTCUSTOMER, CODABaseDataExt.NAMEACCOUNT_HOGANREPAIRS, CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLEUR, '-1000.00', 'line 3');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseDataExt.NAMEGLA_RENT, CODABaseDataExt.NAMEGLA_RENT, '1000.00', 'line 4', CODABaseDataExt.NAMEDIM1_EUR, null, null, null);
        journalHeader.save();
        journalHeader.post();


        // second journal on the first of the following month
        dateToUse = dateToUse.addDays(1);
        period = [Select Id, Name, OwnerCompany__r.Name from codaPeriod__c where StartDate__c <= :dateToUse and EndDate__c >= :dateToUse and OwnerCompany__c = :companyId and PeriodNumber__c != :OPENING_PERIOD and PeriodNumber__c != :ADJUSTMENT_PERIOD and PeriodNumber__c != :CLOSING_PERIOD];

        journalHeader = CODADataTestHelper.journalHeader(dateToUse, CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN + ':EUR', '112', CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN + ':' +period.Name, 'Journal 2');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.DESTINATIONLINETYPE_ACCOUNTCUSTOMER, CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO, CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLEUR, '-1000.00', 'line 1');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO, CODABaseDataExt.NAMEGLA_RATES, '1000.00', 'line 2', CODABaseDataExt.NAMEDIM1_EUR, null, null, null);
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.DESTINATIONLINETYPE_ACCOUNTCUSTOMER, CODABaseDataExt.NAMEACCOUNT_HOGANREPAIRS, CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLEUR, '-1000.00', 'line 3');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseDataExt.NAMEGLA_RENT, CODABaseDataExt.NAMEGLA_RENT, '1000.00', 'line 4', CODABaseDataExt.NAMEDIM1_EUR, null, null, null);
        journalHeader.save();
        journalHeader.post();
    }

    public static void createDataExt2()
    {
        CODATestIDMapExt.load(SUFFIX);

        Id companyId = CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN);

        Date todaysDate = CODADataTestHelper.getSystemTestDate(SUFFIX);

        // third journal on the first of the previous month
        Date dateToUse = todaysDate.addMonths(-2).toStartOfMonth();

        String OPENING_PERIOD = CODAPeriodExt.PERIOD_000;
        String ADJUSTMENT_PERIOD = CODAPeriodExt.PERIOD_100;
        String CLOSING_PERIOD = CODAPeriodExt.PERIOD_101;
        codaPeriod__c period = [Select Id, Name, OwnerCompany__r.Name from codaPeriod__c where StartDate__c <= :dateToUse and EndDate__c >= :dateToUse and OwnerCompany__c = :companyId and PeriodNumber__c != :OPENING_PERIOD and PeriodNumber__c != :ADJUSTMENT_PERIOD and PeriodNumber__c != :CLOSING_PERIOD];

        CODAJournalTestHelper journalHeader = CODADataTestHelper.journalHeader(dateToUse, CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN + ':EUR', '113', CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN + ':' +period.Name, 'Journal 3');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.DESTINATIONLINETYPE_ACCOUNTCUSTOMER, CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO, CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLEUR, '-1000.00', 'line 1');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO, CODABaseDataExt.NAMEGLA_RATES, '1000.00', 'line 2', CODABaseDataExt.NAMEDIM1_EUR, null, null, null);
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.DESTINATIONLINETYPE_ACCOUNTCUSTOMER, CODABaseDataExt.NAMEACCOUNT_HOGANREPAIRS, CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLEUR, '-1000.00', 'line 3');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseDataExt.NAMEGLA_RENT, CODABaseDataExt.NAMEGLA_RENT, '1000.00', 'line 4', CODABaseDataExt.NAMEDIM1_EUR, null, null, null);
        journalHeader.save();
        journalHeader.post();


        // fourth journal on the first of the previous month
        dateToUse = todaysDate.addMonths(-1).toStartOfMonth();
        period = [Select Id, Name, OwnerCompany__r.Name from codaPeriod__c where StartDate__c <= :dateToUse and EndDate__c >= :dateToUse and OwnerCompany__c = :companyId and PeriodNumber__c != :OPENING_PERIOD and PeriodNumber__c != :ADJUSTMENT_PERIOD and PeriodNumber__c != :CLOSING_PERIOD];

        journalHeader = CODADataTestHelper.journalHeader(dateToUse, CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN + ':EUR', '114', CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN + ':' +period.Name, 'Journal 4');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.DESTINATIONLINETYPE_ACCOUNTCUSTOMER, CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO, CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLEUR, '-1000.00', 'line 1');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO, CODABaseDataExt.NAMEGLA_RATES, '1000.00', 'line 2', CODABaseDataExt.NAMEDIM1_EUR, null, null, null);
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.DESTINATIONLINETYPE_ACCOUNTCUSTOMER, CODABaseDataExt.NAMEACCOUNT_HOGANREPAIRS, CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLEUR, '-1000.00', 'line 3');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseDataExt.NAMEGLA_RENT, CODABaseDataExt.NAMEGLA_RENT, '1000.00', 'line 4', CODABaseDataExt.NAMEDIM1_EUR, null, null, null);
        journalHeader.save();
        journalHeader.post();
    }

    public static void createDataExt3()
    {
        CODABaseData.switchCurrentCompany(CODABaseData.NAMECOMPANY_MERLINAUTOUSA, true, true, UserInfo.getUserId());
        CODACompanyMapExt.resetCompanyCache();
    }

    public static void createDataExt4()
    {
        CODATestIDMapExt.load(SUFFIX);

        Id companyId = CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOUSA);

        Date todaysDate = CODADataTestHelper.getSystemTestDate(SUFFIX);

        // need to go back to the end of the 3rd previous month
        Date dateToUse = todaysDate.addMonths(-3).toStartOfMonth().addDays(-1);

        String OPENING_PERIOD = CODAPeriodExt.PERIOD_000;
        String ADJUSTMENT_PERIOD = CODAPeriodExt.PERIOD_100;
        String CLOSING_PERIOD = CODAPeriodExt.PERIOD_101;
        codaPeriod__c period = [Select Id, Name, OwnerCompany__r.Name from codaPeriod__c where StartDate__c <= :dateToUse and EndDate__c >= :dateToUse and OwnerCompany__c = :companyId and PeriodNumber__c != :OPENING_PERIOD and PeriodNumber__c != :ADJUSTMENT_PERIOD and PeriodNumber__c != :CLOSING_PERIOD];

        CODAJournalTestHelper journalHeader = CODADataTestHelper.journalHeader(dateToUse, CODABaseData.NAMECOMPANY_MERLINAUTOUSA + ':USD', '115', CODABaseData.NAMECOMPANY_MERLINAUTOUSA + ':' +period.Name, 'Journal 5');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.DESTINATIONLINETYPE_ACCOUNTCUSTOMER, CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO, CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD, '-1000.00', 'line 1');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO, CODABaseDataExt.NAMEGLA_RATES, '1000.00', 'line 2', CODABaseDataExt.NAMEDIM1_USD, null, null, null);
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.DESTINATIONLINETYPE_ACCOUNTCUSTOMER, CODABaseDataExt.NAMEACCOUNT_HOGANREPAIRS, CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD, '-1000.00', 'line 3');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseDataExt.NAMEGLA_RENT, CODABaseDataExt.NAMEGLA_RENT, '1000.00', 'line 4', CODABaseDataExt.NAMEDIM1_USD, null, null, null);
        journalHeader.save();
        journalHeader.post();


        // second journal on the first of the following month
        dateToUse = dateToUse.addDays(1);
        period = [Select Id, Name, OwnerCompany__r.Name from codaPeriod__c where StartDate__c <= :dateToUse and EndDate__c >= :dateToUse and OwnerCompany__c = :companyId and PeriodNumber__c != :OPENING_PERIOD and PeriodNumber__c != :ADJUSTMENT_PERIOD and PeriodNumber__c != :CLOSING_PERIOD];

        journalHeader = CODADataTestHelper.journalHeader(dateToUse, CODABaseData.NAMECOMPANY_MERLINAUTOUSA + ':USD', '116', CODABaseData.NAMECOMPANY_MERLINAUTOUSA + ':' +period.Name, 'Journal 6');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.DESTINATIONLINETYPE_ACCOUNTCUSTOMER, CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO, CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD, '-1000.00', 'line 1');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO, CODABaseDataExt.NAMEGLA_RATES, '1000.00', 'line 2', CODABaseDataExt.NAMEDIM1_USD, null, null, null);
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.DESTINATIONLINETYPE_ACCOUNTCUSTOMER, CODABaseDataExt.NAMEACCOUNT_HOGANREPAIRS, CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD, '-1000.00', 'line 3');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseDataExt.NAMEGLA_RENT, CODABaseDataExt.NAMEGLA_RENT, '1000.00', 'line 4', CODABaseDataExt.NAMEDIM1_USD, null, null, null);
        journalHeader.save();
        journalHeader.post();
    }

    public static void createDataExt5()
    {
        CODATestIDMapExt.load(SUFFIX);

        Id companyId = CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOUSA);

        Date todaysDate = CODADataTestHelper.getSystemTestDate(SUFFIX);

        // third journal on the first of the previous month
        Date dateToUse = todaysDate.addMonths(-2).toStartOfMonth();

        String OPENING_PERIOD = CODAPeriodExt.PERIOD_000;
        String ADJUSTMENT_PERIOD = CODAPeriodExt.PERIOD_100;
        String CLOSING_PERIOD = CODAPeriodExt.PERIOD_101;
        codaPeriod__c period = [Select Id, Name, OwnerCompany__r.Name from codaPeriod__c where StartDate__c <= :dateToUse and EndDate__c >= :dateToUse and OwnerCompany__c = :companyId and PeriodNumber__c != :OPENING_PERIOD and PeriodNumber__c != :ADJUSTMENT_PERIOD and PeriodNumber__c != :CLOSING_PERIOD];

        CODAJournalTestHelper journalHeader = CODADataTestHelper.journalHeader(dateToUse, CODABaseData.NAMECOMPANY_MERLINAUTOUSA + ':USD', '117', CODABaseData.NAMECOMPANY_MERLINAUTOUSA + ':' +period.Name, 'Journal 7');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.DESTINATIONLINETYPE_ACCOUNTCUSTOMER, CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO, CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD, '-1000.00', 'line 1');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO, CODABaseDataExt.NAMEGLA_RATES, '1000.00', 'line 2', CODABaseDataExt.NAMEDIM1_USD, null, null, null);
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.DESTINATIONLINETYPE_ACCOUNTCUSTOMER, CODABaseDataExt.NAMEACCOUNT_HOGANREPAIRS, CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD, '-1000.00', 'line 3');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseDataExt.NAMEGLA_RENT, CODABaseDataExt.NAMEGLA_RENT, '1000.00', 'line 4', CODABaseDataExt.NAMEDIM1_USD, null, null, null);
        journalHeader.save();
        journalHeader.post();


        // fourth journal on the first of the previous month
        dateToUse = todaysDate.addMonths(-1).toStartOfMonth();
        period = [Select Id, Name, OwnerCompany__r.Name from codaPeriod__c where StartDate__c <= :dateToUse and EndDate__c >= :dateToUse and OwnerCompany__c = :companyId and PeriodNumber__c != :OPENING_PERIOD and PeriodNumber__c != :ADJUSTMENT_PERIOD and PeriodNumber__c != :CLOSING_PERIOD];

        journalHeader = CODADataTestHelper.journalHeader(dateToUse, CODABaseData.NAMECOMPANY_MERLINAUTOUSA + ':USD', '118', CODABaseData.NAMECOMPANY_MERLINAUTOUSA + ':' +period.Name, 'Journal 8');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.DESTINATIONLINETYPE_ACCOUNTCUSTOMER, CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO, CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD, '-1000.00', 'line 1');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO, CODABaseDataExt.NAMEGLA_RATES, '1000.00', 'line 2', CODABaseDataExt.NAMEDIM1_USD, null, null, null);
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.DESTINATIONLINETYPE_ACCOUNTCUSTOMER, CODABaseDataExt.NAMEACCOUNT_HOGANREPAIRS, CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD, '-1000.00', 'line 3');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseDataExt.NAMEGLA_RENT, CODABaseDataExt.NAMEGLA_RENT, '1000.00', 'line 4', CODABaseDataExt.NAMEDIM1_USD, null, null, null);
        journalHeader.save();
        journalHeader.post();
    }

    public static void createDataExt6()
    {
        CODABaseData.switchCurrentCompany(CODABaseData.NAMECOMPANY_MERLINAUTOAUS, true, true, UserInfo.getUserId());
        CODACompanyMapExt.resetCompanyCache();
    }

    public static void createDataExt7()
    {
        CODATestIDMapExt.load(SUFFIX);

        Id companyId = CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOAUS);

        Date todaysDate = CODADataTestHelper.getSystemTestDate(SUFFIX);

        // need to go back to the end of the 3rd previous month
        Date dateToUse = todaysDate.addMonths(-3).toStartOfMonth().addDays(-1);

        String OPENING_PERIOD = CODAPeriodExt.PERIOD_000;
        String ADJUSTMENT_PERIOD = CODAPeriodExt.PERIOD_100;
        String CLOSING_PERIOD = CODAPeriodExt.PERIOD_101;
        codaPeriod__c period = [Select Id, Name, OwnerCompany__r.Name from codaPeriod__c where StartDate__c <= :dateToUse and EndDate__c >= :dateToUse and OwnerCompany__c = :companyId and PeriodNumber__c != :OPENING_PERIOD and PeriodNumber__c != :ADJUSTMENT_PERIOD and PeriodNumber__c != :CLOSING_PERIOD];

        CODAJournalTestHelper journalHeader = CODADataTestHelper.journalHeader(dateToUse, CODABaseData.NAMECOMPANY_MERLINAUTOAUS + ':AUD', '119', CODABaseData.NAMECOMPANY_MERLINAUTOAUS + ':' +period.Name, 'Journal 9');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.DESTINATIONLINETYPE_ACCOUNTCUSTOMER, CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO, CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLAUD, '-1000.00', 'line 1');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO, CODABaseDataExt.NAMEGLA_RATES, '1000.00', 'line 2', CODABaseDataExt.NAMEDIM1_QUEENSLAND, null, null, null);
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.DESTINATIONLINETYPE_ACCOUNTCUSTOMER, CODABaseDataExt.NAMEACCOUNT_HOGANREPAIRS, CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLAUD, '-1000.00', 'line 3');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseDataExt.NAMEGLA_RENT, CODABaseDataExt.NAMEGLA_RENT, '1000.00', 'line 4', CODABaseDataExt.NAMEDIM1_QUEENSLAND, null, null, null);
        journalHeader.save();
        journalHeader.post();


        // second journal on the first of the following month
        dateToUse = dateToUse.addDays(1);
        period = [Select Id, Name, OwnerCompany__r.Name from codaPeriod__c where StartDate__c <= :dateToUse and EndDate__c >= :dateToUse and OwnerCompany__c = :companyId and PeriodNumber__c != :OPENING_PERIOD and PeriodNumber__c != :ADJUSTMENT_PERIOD and PeriodNumber__c != :CLOSING_PERIOD];

        journalHeader = CODADataTestHelper.journalHeader(dateToUse, CODABaseData.NAMECOMPANY_MERLINAUTOAUS + ':AUD', '120', CODABaseData.NAMECOMPANY_MERLINAUTOAUS + ':' +period.Name, 'Journal 10');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.DESTINATIONLINETYPE_ACCOUNTCUSTOMER, CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO, CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLAUD, '-1000.00', 'line 1');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO, CODABaseDataExt.NAMEGLA_RATES, '1000.00', 'line 2', CODABaseDataExt.NAMEDIM1_QUEENSLAND, null, null, null);
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.DESTINATIONLINETYPE_ACCOUNTCUSTOMER, CODABaseDataExt.NAMEACCOUNT_HOGANREPAIRS, CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLAUD, '-1000.00', 'line 3');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseDataExt.NAMEGLA_RENT, CODABaseDataExt.NAMEGLA_RENT, '1000.00', 'line 4', CODABaseDataExt.NAMEDIM1_QUEENSLAND, null, null, null);
        journalHeader.save();
        journalHeader.post();
    }

    public static void createDataExt8()
    {
        CODATestIDMapExt.load(SUFFIX);

        Id companyId = CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOAUS);

        Date todaysDate = CODADataTestHelper.getSystemTestDate(SUFFIX);

        // third journal on the first of the previous month
        Date dateToUse = todaysDate.addMonths(-2).toStartOfMonth();

        String OPENING_PERIOD = CODAPeriodExt.PERIOD_000;
        String ADJUSTMENT_PERIOD = CODAPeriodExt.PERIOD_100;
        String CLOSING_PERIOD = CODAPeriodExt.PERIOD_101;
        codaPeriod__c period = [Select Id, Name, OwnerCompany__r.Name from codaPeriod__c where StartDate__c <= :dateToUse and EndDate__c >= :dateToUse and OwnerCompany__c = :companyId and PeriodNumber__c != :OPENING_PERIOD and PeriodNumber__c != :ADJUSTMENT_PERIOD and PeriodNumber__c != :CLOSING_PERIOD];

        CODAJournalTestHelper journalHeader = CODADataTestHelper.journalHeader(dateToUse, CODABaseData.NAMECOMPANY_MERLINAUTOAUS + ':AUD', '121', CODABaseData.NAMECOMPANY_MERLINAUTOAUS + ':' +period.Name, 'Journal 11');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.DESTINATIONLINETYPE_ACCOUNTCUSTOMER, CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO, CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLAUD, '-1000.00', 'line 1');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO, CODABaseDataExt.NAMEGLA_RATES, '1000.00', 'line 2', CODABaseDataExt.NAMEDIM1_QUEENSLAND, null, null, null);
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.DESTINATIONLINETYPE_ACCOUNTCUSTOMER, CODABaseDataExt.NAMEACCOUNT_HOGANREPAIRS, CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLAUD, '-1000.00', 'line 3');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseDataExt.NAMEGLA_RENT, CODABaseDataExt.NAMEGLA_RENT, '1000.00', 'line 4', CODABaseDataExt.NAMEDIM1_QUEENSLAND, null, null, null);
        journalHeader.save();
        journalHeader.post();


        // fourth journal on the first of the previous month
        dateToUse = todaysDate.addMonths(-1).toStartOfMonth();
        period = [Select Id, Name, OwnerCompany__r.Name from codaPeriod__c where StartDate__c <= :dateToUse and EndDate__c >= :dateToUse and OwnerCompany__c = :companyId and PeriodNumber__c != :OPENING_PERIOD and PeriodNumber__c != :ADJUSTMENT_PERIOD and PeriodNumber__c != :CLOSING_PERIOD];

        journalHeader = CODADataTestHelper.journalHeader(dateToUse, CODABaseData.NAMECOMPANY_MERLINAUTOAUS + ':AUD', '122', CODABaseData.NAMECOMPANY_MERLINAUTOAUS + ':' +period.Name, 'Journal 12');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.DESTINATIONLINETYPE_ACCOUNTCUSTOMER, CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO, CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLAUD, '-1000.00', 'line 1');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO, CODABaseDataExt.NAMEGLA_RATES, '1000.00', 'line 2', CODABaseDataExt.NAMEDIM1_QUEENSLAND, null, null, null);
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.DESTINATIONLINETYPE_ACCOUNTCUSTOMER, CODABaseDataExt.NAMEACCOUNT_HOGANREPAIRS, CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLAUD, '-1000.00', 'line 3');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseDataExt.NAMEGLA_RENT, CODABaseDataExt.NAMEGLA_RENT, '1000.00', 'line 4', CODABaseDataExt.NAMEDIM1_QUEENSLAND, null, null, null);
        journalHeader.save();
        journalHeader.post();
    }

    public static void createDataExt9()
    {
        CODABaseData.switchCurrentCompany(CODABaseData.NAMECOMPANY_MERLINAUTOGB, true, true, UserInfo.getUserId());
        CODACompanyMapExt.resetCompanyCache();
    }

    // Change the dual currency of the company Merlin Auto GB
    public static void createDataExt10()
    {
        CODATestIDMapExt.load(SUFFIX);
        changeDualCurrency('USD', CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOGB));
    }

    public static void createDataExt11()
    {
        CODATestIDMapExt.load(SUFFIX);

        Id companyId = CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOGB);

        Date todaysDate = CODADataTestHelper.getSystemTestDate(SUFFIX);

        // need to go back to the end of the 3rd previous month
        Date dateToUse = todaysDate.addMonths(-3).toStartOfMonth().addDays(-1);

        String OPENING_PERIOD = CODAPeriodExt.PERIOD_000;
        String ADJUSTMENT_PERIOD = CODAPeriodExt.PERIOD_100;
        String CLOSING_PERIOD = CODAPeriodExt.PERIOD_101;
        codaPeriod__c period = [Select Id, Name, OwnerCompany__r.Name from codaPeriod__c where StartDate__c <= :dateToUse and EndDate__c >= :dateToUse and OwnerCompany__c = :companyId and PeriodNumber__c != :OPENING_PERIOD and PeriodNumber__c != :ADJUSTMENT_PERIOD and PeriodNumber__c != :CLOSING_PERIOD];

        CODAJournalTestHelper journalHeader = CODADataTestHelper.journalHeader(dateToUse, CODABaseData.NAMECOMPANY_MERLINAUTOGB + ':GBP', '123', CODABaseData.NAMECOMPANY_MERLINAUTOGB + ':' +period.Name, 'Journal 13');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.DESTINATIONLINETYPE_ACCOUNTCUSTOMER, CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO, CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLGBP, '-1000.00', 'line 1');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO, CODABaseDataExt.NAMEGLA_RATES, '1000.00', 'line 2', CODABaseDataExt.NAMEDIM1_NORTH, null, null, null);
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.DESTINATIONLINETYPE_ACCOUNTCUSTOMER, CODABaseDataExt.NAMEACCOUNT_HOGANREPAIRS, CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLGBP, '-1000.00', 'line 3');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseDataExt.NAMEGLA_RENT, CODABaseDataExt.NAMEGLA_RENT, '1000.00', 'line 4', CODABaseDataExt.NAMEDIM1_NORTH, null, null, null);
        journalHeader.save();
        journalHeader.post();


        // second journal on the first of the following month
        dateToUse = dateToUse.addDays(1);
        period = [Select Id, Name, OwnerCompany__r.Name from codaPeriod__c where StartDate__c <= :dateToUse and EndDate__c >= :dateToUse and OwnerCompany__c = :companyId and PeriodNumber__c != :OPENING_PERIOD and PeriodNumber__c != :ADJUSTMENT_PERIOD and PeriodNumber__c != :CLOSING_PERIOD];

        journalHeader = CODADataTestHelper.journalHeader(dateToUse, CODABaseData.NAMECOMPANY_MERLINAUTOGB + ':GBP', '124', CODABaseData.NAMECOMPANY_MERLINAUTOGB + ':' +period.Name, 'Journal 14');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.DESTINATIONLINETYPE_ACCOUNTCUSTOMER, CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO, CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLGBP, '-1000.00', 'line 1');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO, CODABaseDataExt.NAMEGLA_RATES, '1000.00', 'line 2', CODABaseDataExt.NAMEDIM1_NORTH, null, null, null);
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.DESTINATIONLINETYPE_ACCOUNTCUSTOMER, CODABaseDataExt.NAMEACCOUNT_HOGANREPAIRS, CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLGBP, '-1000.00', 'line 3');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseDataExt.NAMEGLA_RENT, CODABaseDataExt.NAMEGLA_RENT, '1000.00', 'line 4', CODABaseDataExt.NAMEDIM1_NORTH, null, null, null);
        journalHeader.save();
        journalHeader.post();
    }

    public static void createDataExt12()
    {
        CODATestIDMapExt.load(SUFFIX);

        Id companyId = CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOGB);

        Date todaysDate = CODADataTestHelper.getSystemTestDate(SUFFIX);

        // third journal on the first of the previous month
        Date dateToUse = todaysDate.addMonths(-2).toStartOfMonth();

        String OPENING_PERIOD = CODAPeriodExt.PERIOD_000;
        String ADJUSTMENT_PERIOD = CODAPeriodExt.PERIOD_100;
        String CLOSING_PERIOD = CODAPeriodExt.PERIOD_101;
        codaPeriod__c period = [Select Id, Name, OwnerCompany__r.Name from codaPeriod__c where StartDate__c <= :dateToUse and EndDate__c >= :dateToUse and OwnerCompany__c = :companyId and PeriodNumber__c != :OPENING_PERIOD and PeriodNumber__c != :ADJUSTMENT_PERIOD and PeriodNumber__c != :CLOSING_PERIOD];

        CODAJournalTestHelper journalHeader = CODADataTestHelper.journalHeader(dateToUse, CODABaseData.NAMECOMPANY_MERLINAUTOGB + ':GBP', '125', CODABaseData.NAMECOMPANY_MERLINAUTOGB + ':' +period.Name, 'Journal 15');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.DESTINATIONLINETYPE_ACCOUNTCUSTOMER, CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO, CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLGBP, '-1000.00', 'line 1');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO, CODABaseDataExt.NAMEGLA_RATES, '1000.00', 'line 2', CODABaseDataExt.NAMEDIM1_NORTH, null, null, null);
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.DESTINATIONLINETYPE_ACCOUNTCUSTOMER, CODABaseDataExt.NAMEACCOUNT_HOGANREPAIRS, CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLGBP, '-1000.00', 'line 3');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseDataExt.NAMEGLA_RENT, CODABaseDataExt.NAMEGLA_RENT, '1000.00', 'line 4', CODABaseDataExt.NAMEDIM1_NORTH, null, null, null);
        journalHeader.save();
        journalHeader.post();


        // fourth journal on the first of the previous month
        dateToUse = todaysDate.addMonths(-1).toStartOfMonth();
        period = [Select Id, Name, OwnerCompany__r.Name from codaPeriod__c where StartDate__c <= :dateToUse and EndDate__c >= :dateToUse and OwnerCompany__c = :companyId and PeriodNumber__c != :OPENING_PERIOD and PeriodNumber__c != :ADJUSTMENT_PERIOD and PeriodNumber__c != :CLOSING_PERIOD];

        journalHeader = CODADataTestHelper.journalHeader(dateToUse, CODABaseData.NAMECOMPANY_MERLINAUTOGB + ':GBP', '126', CODABaseData.NAMECOMPANY_MERLINAUTOGB + ':' +period.Name, 'Journal 16');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.DESTINATIONLINETYPE_ACCOUNTCUSTOMER, CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO, CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLGBP, '-1000.00', 'line 1');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO, CODABaseDataExt.NAMEGLA_RATES, '1000.00', 'line 2', CODABaseDataExt.NAMEDIM1_NORTH, null, null, null);
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.DESTINATIONLINETYPE_ACCOUNTCUSTOMER, CODABaseDataExt.NAMEACCOUNT_HOGANREPAIRS, CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLGBP, '-1000.00', 'line 3');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseDataExt.NAMEGLA_RENT, CODABaseDataExt.NAMEGLA_RENT, '1000.00', 'line 4', CODABaseDataExt.NAMEDIM1_NORTH, null, null, null);
        journalHeader.save();
        journalHeader.post();
    }

    public static void createDataExt13()
    {
        CODABaseData.switchCurrentCompany(CODABaseData.NAMECOMPANY_MERLINTECHUS, true, true, UserInfo.getUserId());
        CODACompanyMapExt.resetCompanyCache();
    }

    // Change the dual currency of the company Merlin Tech US
    public static void createDataExt14()
    {
        CODATestIDMapExt.load(SUFFIX);
        changeDualCurrency('USD', CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINTECHUS));
    }

    public static void createDataExt15()
    {
        CODATestIDMapExt.load(SUFFIX);

        Id companyId = CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINTECHUS);

        Date todaysDate = CODADataTestHelper.getSystemTestDate(SUFFIX);

        // need to go back to the end of the 3rd previous month
        Date dateToUse = todaysDate.addMonths(-3).toStartOfMonth().addDays(-1);

        String OPENING_PERIOD = CODAPeriodExt.PERIOD_000;
        String ADJUSTMENT_PERIOD = CODAPeriodExt.PERIOD_100;
        String CLOSING_PERIOD = CODAPeriodExt.PERIOD_101;
        codaPeriod__c period = [Select Id, Name, OwnerCompany__r.Name from codaPeriod__c where StartDate__c <= :dateToUse and EndDate__c >= :dateToUse and OwnerCompany__c = :companyId and PeriodNumber__c != :OPENING_PERIOD and PeriodNumber__c != :ADJUSTMENT_PERIOD and PeriodNumber__c != :CLOSING_PERIOD];

        CODAJournalTestHelper journalHeader = CODADataTestHelper.journalHeader(dateToUse, CODABaseData.NAMECOMPANY_MERLINTECHUS + ':USD', '127', CODABaseData.NAMECOMPANY_MERLINTECHUS + ':' +period.Name, 'Journal 17');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.DESTINATIONLINETYPE_ACCOUNTCUSTOMER, CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO, CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD, '-1000.00', 'line 1');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO, CODABaseDataExt.NAMEGLA_RATES, '1000.00', 'line 2', CODABaseDataExt.NAMEDIM1_NEWYORK, null, null, null);
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.DESTINATIONLINETYPE_ACCOUNTCUSTOMER, CODABaseDataExt.NAMEACCOUNT_HOGANREPAIRS, CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLGBP, '-1000.00', 'line 3');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseDataExt.NAMEGLA_RENT, CODABaseDataExt.NAMEGLA_RENT, '1000.00', 'line 4', CODABaseDataExt.NAMEDIM1_NEWYORK, null, null, null);
        journalHeader.save();
        journalHeader.post();


        // second journal on the first of the following month
        dateToUse = dateToUse.addDays(1);
        period = [Select Id, Name, OwnerCompany__r.Name from codaPeriod__c where StartDate__c <= :dateToUse and EndDate__c >= :dateToUse and OwnerCompany__c = :companyId and PeriodNumber__c != :OPENING_PERIOD and PeriodNumber__c != :ADJUSTMENT_PERIOD and PeriodNumber__c != :CLOSING_PERIOD];

        journalHeader = CODADataTestHelper.journalHeader(dateToUse, CODABaseData.NAMECOMPANY_MERLINTECHUS + ':USD', '128', CODABaseData.NAMECOMPANY_MERLINTECHUS + ':' +period.Name, 'Journal 18');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.DESTINATIONLINETYPE_ACCOUNTCUSTOMER, CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO, CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD, '-1000.00', 'line 1');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO, CODABaseDataExt.NAMEGLA_RATES, '1000.00', 'line 2', CODABaseDataExt.NAMEDIM1_NEWYORK, null, null, null);
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.DESTINATIONLINETYPE_ACCOUNTCUSTOMER, CODABaseDataExt.NAMEACCOUNT_HOGANREPAIRS, CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD, '-1000.00', 'line 3');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseDataExt.NAMEGLA_RENT, CODABaseDataExt.NAMEGLA_RENT, '1000.00', 'line 4', CODABaseDataExt.NAMEDIM1_NEWYORK, null, null, null);
        journalHeader.save();
        journalHeader.post();
    }

    public static void createDataExt16()
    {
        CODATestIDMapExt.load(SUFFIX);

        Id companyId = CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINTECHUS);

        Date todaysDate = CODADataTestHelper.getSystemTestDate(SUFFIX);

        // third journal on the first of the previous month
        Date dateToUse = todaysDate.addMonths(-2).toStartOfMonth();

        String OPENING_PERIOD = CODAPeriodExt.PERIOD_000;
        String ADJUSTMENT_PERIOD = CODAPeriodExt.PERIOD_100;
        String CLOSING_PERIOD = CODAPeriodExt.PERIOD_101;
        codaPeriod__c period = [Select Id, Name, OwnerCompany__r.Name from codaPeriod__c where StartDate__c <= :dateToUse and EndDate__c >= :dateToUse and OwnerCompany__c = :companyId and PeriodNumber__c != :OPENING_PERIOD and PeriodNumber__c != :ADJUSTMENT_PERIOD and PeriodNumber__c != :CLOSING_PERIOD];

        CODAJournalTestHelper journalHeader = CODADataTestHelper.journalHeader(dateToUse, CODABaseData.NAMECOMPANY_MERLINTECHUS + ':USD', '129', CODABaseData.NAMECOMPANY_MERLINTECHUS + ':' +period.Name, 'Journal 19');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.DESTINATIONLINETYPE_ACCOUNTCUSTOMER, CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO, CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD, '-1000.00', 'line 1');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO, CODABaseDataExt.NAMEGLA_RATES, '1000.00', 'line 2', CODABaseDataExt.NAMEDIM1_NEWYORK, null, null, null);
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.DESTINATIONLINETYPE_ACCOUNTCUSTOMER, CODABaseDataExt.NAMEACCOUNT_HOGANREPAIRS, CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD, '-1000.00', 'line 3');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseDataExt.NAMEGLA_RENT, CODABaseDataExt.NAMEGLA_RENT, '1000.00', 'line 4', CODABaseDataExt.NAMEDIM1_NEWYORK, null, null, null);
        journalHeader.save();
        journalHeader.post();


        // fourth journal on the first of the previous month
        dateToUse = todaysDate.addMonths(-1).toStartOfMonth();
        period = [Select Id, Name, OwnerCompany__r.Name from codaPeriod__c where StartDate__c <= :dateToUse and EndDate__c >= :dateToUse and OwnerCompany__c = :companyId and PeriodNumber__c != :OPENING_PERIOD and PeriodNumber__c != :ADJUSTMENT_PERIOD and PeriodNumber__c != :CLOSING_PERIOD];

        journalHeader = CODADataTestHelper.journalHeader(dateToUse, CODABaseData.NAMECOMPANY_MERLINTECHUS + ':USD', '130', CODABaseData.NAMECOMPANY_MERLINTECHUS + ':' +period.Name, 'Journal 20');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.DESTINATIONLINETYPE_ACCOUNTCUSTOMER, CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO, CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD, '-1000.00', 'line 1');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO, CODABaseDataExt.NAMEGLA_RATES, '1000.00', 'line 2', CODABaseDataExt.NAMEDIM1_NEWYORK, null, null, null);
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.DESTINATIONLINETYPE_ACCOUNTCUSTOMER, CODABaseDataExt.NAMEACCOUNT_HOGANREPAIRS, CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD, '-1000.00', 'line 3');
        CODADataTestHelper.journalLine(journalHeader, CODAJournalLineItem.LINETYPE_GENERALLEDGERACCOUNT, CODABaseDataExt.NAMEGLA_RENT, CODABaseDataExt.NAMEGLA_RENT, '1000.00', 'line 4', CODABaseDataExt.NAMEDIM1_NEWYORK, null, null, null);
        journalHeader.save();
        journalHeader.post();
    }

    public static void createDataExt17()
    {
        CODATestIDMapExt.load(SUFFIX);

        StatisticalBasis__c statisticalBasis = new StatisticalBasis__c();
        statisticalBasis.Name = STATISTICAL_BASIS_NAME;
        statisticalBasis.UnitOfMeasure__c = 'People';
        statisticalBasis.Date__c = Date.newInstance(2017, 1, 1);
        insert statisticalBasis;

        CODATestIDMapExt.put(STATISTICAL_BASIS_NAME, statisticalBasis.Id);

        StatisticalBasisLineItem__c lineItem1 = new StatisticalBasisLineItem__c();
        lineItem1.StatisticalBasis__c = statisticalBasis.Id;
        lineItem1.Company__c = CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN);
        lineItem1.Dimension1__c = CODATestIDMap.resolve(CODABaseDataExt.NAMEDIM1_EUR);
        lineItem1.Value__c = 86;
        insert lineItem1;

        StatisticalBasisLineItem__c lineItem2 = new StatisticalBasisLineItem__c();
        lineItem2.StatisticalBasis__c = statisticalBasis.Id;
        lineItem2.Company__c = CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOUSA);
        lineItem2.Dimension1__c = CODATestIDMap.resolve(CODABaseDataExt.NAMEDIM1_USD);
        lineItem2.Value__c = 26;
        insert lineItem2;

        CODATestIDMapExt.save(SUFFIX);
    }

    public static void createDataExt18()
    {
        // single company template for Merlin Tech US
        CODATestIDMapExt.load(SUFFIX);

        List<AllocationsService.FilterStructure> filterStructureList = new List<AllocationsService.FilterStructure>();
        AllocationsService.Filter filter1 = new AllocationsService.Filter();
        filter1.FilterCriteria = AllocationsService.FilterCriteria.MultiselectValue;
        filter1.Values = new List<Object> {CODATestIDMap.resolve(CODABaseDataExt.NAMEGLA_RENT)};
        AllocationsService.FilterStructure filterStr1 = new AllocationsService.FilterStructure();
        filterStr1.FilterPosition = 1;
        filterStr1.FilterStructureType = AllocationsService.FilterStructureType.GeneralLedgerAccount;
        filterStr1.DefaultFilterCriteria = AllocationsService.DefaultFilterCriteria.MultiselectValue;
        filterStr1.FilterList = new List<AllocationsService.Filter>{filter1};
        filterStructureList.add(filterStr1);

        AllocationsService.Filter filter2 = new AllocationsService.Filter();
        filter2.FilterCriteria = AllocationsService.FilterCriteria.MultiselectValue;
        filter2.Values = new List<Object> {CODATestIDMap.resolve(CODABaseDataExt.NAMEDIM1_NEWYORK)};
        AllocationsService.FilterStructure filterStr2 = new AllocationsService.FilterStructure();
        filterStr2.FilterPosition = 1;
        filterStr2.FilterStructureType = AllocationsService.FilterStructureType.Dimension1;
        filterStr2.DefaultFilterCriteria = AllocationsService.DefaultFilterCriteria.MultiselectValue;
        filterStr2.FilterList = new List<AllocationsService.Filter>{filter2};
        filterStructureList.add(filterStr2);

        List<AllocationsService.SplitStructure> splitStructureList = new List<AllocationsService.SplitStructure>();
        AllocationsService.SplitStructure split1 = new AllocationsService.SplitStructure(CODATestIDMap.resolve(CODABaseDataExt.NAMEGLA_RENT), CODATestIDMap.resolve(CODABaseDataExt.NAMEDIM1_NEWYORK), null, null, null, 70);
        splitStructureList.add(split1);
        AllocationsService.SplitStructure split2 = new AllocationsService.SplitStructure(CODATestIDMap.resolve(CODABaseDataExt.NAMEGLA_RENT), CODATestIDMap.resolve(CODABaseDataExt.NAMEDIM1_MASSACHUSETTS), null, null, null, 30);
        splitStructureList.add(split2);

        AllocationsService.Template template = new AllocationsService.Template(null, TEMPLATE1_NAME, null, filterStructureList, splitStructureList);
        template.DestinationItem = AllocationsService.DestinationType.Transactions;

        AllocationsService.saveTemplates(new List<AllocationsService.Template>{template});
    }

    public static void createDataExt19()
    {
        CODABaseData.switchCurrentCompany(CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN, true, false, UserInfo.getUserId());
        CODABaseData.switchCurrentCompany(CODABaseData.NAMECOMPANY_MERLINAUTOUSA, true, false, UserInfo.getUserId());
        CODABaseData.switchCurrentCompany(CODABaseData.NAMECOMPANY_MERLINAUTOAUS, true, false, UserInfo.getUserId());
        CODABaseData.switchCurrentCompany(CODABaseData.NAMECOMPANY_MERLINAUTOGB, true, false, UserInfo.getUserId());
        CODACompanyMapExt.resetCompanyCache();
    }

    public static void createDataExt20()
    {
        // multi company template 1
        CODATestIDMapExt.load(SUFFIX);

        List<AllocationsService.FilterStructure> filterStructureList = new List<AllocationsService.FilterStructure>();
        AllocationsService.Filter filter1 = new AllocationsService.Filter();
        filter1.FilterCriteria = AllocationsService.FilterCriteria.MultiselectValue;
        filter1.Values = new List<Object> {CODATestIDMap.resolve(CODABaseDataExt.NAMEGLA_RENT)};
        AllocationsService.FilterStructure filterStr1 = new AllocationsService.FilterStructure();
        filterStr1.FilterPosition = 1;
        filterStr1.FilterStructureType = AllocationsService.FilterStructureType.GeneralLedgerAccount;
        filterStr1.DefaultFilterCriteria = AllocationsService.DefaultFilterCriteria.MultiselectValue;
        filterStr1.FilterList = new List<AllocationsService.Filter>{filter1};
        filterStructureList.add(filterStr1);

        AllocationsService.Filter filter2 = new AllocationsService.Filter();
        filter2.FilterCriteria = AllocationsService.FilterCriteria.MultiselectValue;
        filter2.Values = new List<Object> {CODATestIDMap.resolve(CODABaseDataExt.NAMEDIM1_EUR)};
        AllocationsService.FilterStructure filterStr2 = new AllocationsService.FilterStructure();
        filterStr2.FilterPosition = 1;
        filterStr2.FilterStructureType = AllocationsService.FilterStructureType.Dimension1;
        filterStr2.DefaultFilterCriteria = AllocationsService.DefaultFilterCriteria.MultiselectValue;
        filterStr2.FilterList = new List<AllocationsService.Filter>{filter2};
        filterStructureList.add(filterStr2);

        AllocationsService.Filter filter3 = new AllocationsService.Filter();
        filter3.FilterCriteria = AllocationsService.FilterCriteria.MultiselectValue;
        filter3.Values = new List<Object> {CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN)};
        AllocationsService.FilterStructure filterStr3 = new AllocationsService.FilterStructure();
        filterStr3.FilterPosition = 1;
        filterStr3.FilterStructureType = AllocationsService.FilterStructureType.Company;
        filterStr3.DefaultFilterCriteria = AllocationsService.DefaultFilterCriteria.MultiselectValue;
        filterStr3.FilterList = new List<AllocationsService.Filter>{filter3};
        filterStructureList.add(filterStr3);

        AllocationsService.Filter filter4 = new AllocationsService.Filter();
        filter4.FilterCriteria = AllocationsService.FilterCriteria.MultiselectValue;
        filter4.Values = new List<Object> {CODATestIDMap.resolve(CODABaseDataExt.NAMEGLA_RENT)};
        AllocationsService.FilterStructure filterStr4 = new AllocationsService.FilterStructure();
        filterStr4.FilterPosition = 2;
        filterStr4.FilterStructureType = AllocationsService.FilterStructureType.GeneralLedgerAccount;
        filterStr4.DefaultFilterCriteria = AllocationsService.DefaultFilterCriteria.MultiselectValue;
        filterStr4.FilterList = new List<AllocationsService.Filter>{filter4};
        filterStructureList.add(filterStr4);

        AllocationsService.Filter filter5 = new AllocationsService.Filter();
        filter5.FilterCriteria = AllocationsService.FilterCriteria.MultiselectValue;
        filter5.Values = new List<Object> {CODATestIDMap.resolve(CODABaseDataExt.NAMEDIM1_USD)};
        AllocationsService.FilterStructure filterStr5 = new AllocationsService.FilterStructure();
        filterStr5.FilterPosition = 2;
        filterStr5.FilterStructureType = AllocationsService.FilterStructureType.Dimension1;
        filterStr5.DefaultFilterCriteria = AllocationsService.DefaultFilterCriteria.MultiselectValue;
        filterStr5.FilterList = new List<AllocationsService.Filter>{filter5};
        filterStructureList.add(filterStr5);

        AllocationsService.Filter filter6 = new AllocationsService.Filter();
        filter6.FilterCriteria = AllocationsService.FilterCriteria.MultiselectValue;
        filter6.Values = new List<Object> {CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOUSA)};
        AllocationsService.FilterStructure filterStr6 = new AllocationsService.FilterStructure();
        filterStr6.FilterPosition = 2;
        filterStr6.FilterStructureType = AllocationsService.FilterStructureType.Company;
        filterStr6.DefaultFilterCriteria = AllocationsService.DefaultFilterCriteria.MultiselectValue;
        filterStr6.FilterList = new List<AllocationsService.Filter>{filter6};
        filterStructureList.add(filterStr6);

        AllocationsService.Template template = new AllocationsService.Template(null, TEMPLATE2_NAME, null, filterStructureList, null);
        template.DestinationItem = AllocationsService.DestinationType.Journals;
        template.DestinationCompanyId = CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOAUS);
        template.BasisType = AllocationsService.BasisType.Statistical;
        template.AllocationMethod = AllocationsService.AllocationMethod.Variable;
        template.CopyGla = AllocationsService.CopyGla.Source;
        template.StatisticalBasis = CODATestIDMap.resolve(STATISTICAL_BASIS_NAME);

        AllocationsService.saveTemplates(new List<AllocationsService.Template>{template});
    }

    public static void createDataExt21()
    {
        // multi company template 2
        CODATestIDMapExt.load(SUFFIX);

        List<AllocationsService.FilterStructure> filterStructureList = new List<AllocationsService.FilterStructure>();
        AllocationsService.Filter filter1 = new AllocationsService.Filter();
        filter1.FilterCriteria = AllocationsService.FilterCriteria.MultiselectValue;
        filter1.Values = new List<Object> {CODATestIDMap.resolve(CODABaseDataExt.NAMEGLA_RATES)};
        AllocationsService.FilterStructure filterStr1 = new AllocationsService.FilterStructure();
        filterStr1.FilterPosition = 1;
        filterStr1.FilterStructureType = AllocationsService.FilterStructureType.GeneralLedgerAccount;
        filterStr1.DefaultFilterCriteria = AllocationsService.DefaultFilterCriteria.MultiselectValue;
        filterStr1.FilterList = new List<AllocationsService.Filter>{filter1};
        filterStructureList.add(filterStr1);

        AllocationsService.Filter filter2 = new AllocationsService.Filter();
        filter2.FilterCriteria = AllocationsService.FilterCriteria.MultiselectValue;
        filter2.Values = new List<Object> {CODATestIDMap.resolve(CODABaseDataExt.NAMEDIM1_NEWYORK)};
        AllocationsService.FilterStructure filterStr2 = new AllocationsService.FilterStructure();
        filterStr2.FilterPosition = 1;
        filterStr2.FilterStructureType = AllocationsService.FilterStructureType.Dimension1;
        filterStr2.DefaultFilterCriteria = AllocationsService.DefaultFilterCriteria.MultiselectValue;
        filterStr2.FilterList = new List<AllocationsService.Filter>{filter2};
        filterStructureList.add(filterStr2);

        AllocationsService.Filter filter3 = new AllocationsService.Filter();
        filter3.FilterCriteria = AllocationsService.FilterCriteria.MultiselectValue;
        filter3.Values = new List<Object> {CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINTECHUS)};
        AllocationsService.FilterStructure filterStr3 = new AllocationsService.FilterStructure();
        filterStr3.FilterPosition = 1;
        filterStr3.FilterStructureType = AllocationsService.FilterStructureType.Company;
        filterStr3.DefaultFilterCriteria = AllocationsService.DefaultFilterCriteria.MultiselectValue;
        filterStr3.FilterList = new List<AllocationsService.Filter>{filter3};
        filterStructureList.add(filterStr3);

        AllocationsService.Filter filter4 = new AllocationsService.Filter();
        filter4.FilterCriteria = AllocationsService.FilterCriteria.MultiselectValue;
        filter4.Values = new List<Object> {CODATestIDMap.resolve(CODABaseDataExt.NAMEGLA_RATES)};
        AllocationsService.FilterStructure filterStr4 = new AllocationsService.FilterStructure();
        filterStr4.FilterPosition = 2;
        filterStr4.FilterStructureType = AllocationsService.FilterStructureType.GeneralLedgerAccount;
        filterStr4.DefaultFilterCriteria = AllocationsService.DefaultFilterCriteria.MultiselectValue;
        filterStr4.FilterList = new List<AllocationsService.Filter>{filter4};
        filterStructureList.add(filterStr4);

        AllocationsService.Filter filter5 = new AllocationsService.Filter();
        filter5.FilterCriteria = AllocationsService.FilterCriteria.MultiselectValue;
        filter5.Values = new List<Object> {CODATestIDMap.resolve(CODABaseDataExt.NAMEDIM1_NORTH)};
        AllocationsService.FilterStructure filterStr5 = new AllocationsService.FilterStructure();
        filterStr5.FilterPosition = 2;
        filterStr5.FilterStructureType = AllocationsService.FilterStructureType.Dimension1;
        filterStr5.DefaultFilterCriteria = AllocationsService.DefaultFilterCriteria.MultiselectValue;
        filterStr5.FilterList = new List<AllocationsService.Filter>{filter5};
        filterStructureList.add(filterStr5);

        AllocationsService.Filter filter6 = new AllocationsService.Filter();
        filter6.FilterCriteria = AllocationsService.FilterCriteria.MultiselectValue;
        filter6.Values = new List<Object> {CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOGB)};
        AllocationsService.FilterStructure filterStr6 = new AllocationsService.FilterStructure();
        filterStr6.FilterPosition = 2;
        filterStr6.FilterStructureType = AllocationsService.FilterStructureType.Company;
        filterStr6.DefaultFilterCriteria = AllocationsService.DefaultFilterCriteria.MultiselectValue;
        filterStr6.FilterList = new List<AllocationsService.Filter>{filter6};
        filterStructureList.add(filterStr6);

        List<AllocationsService.SplitStructure> splitStructureList = new List<AllocationsService.SplitStructure>();
        AllocationsService.SplitStructure split1 = new AllocationsService.SplitStructure(CODATestIDMap.resolve(CODABaseDataExt.NAMEGLA_RATES), CODATestIDMap.resolve(CODABaseDataExt.NAMEDIM1_NEWYORK), null, null, null, 70);
        splitStructureList.add(split1);
        AllocationsService.SplitStructure split2 = new AllocationsService.SplitStructure(CODATestIDMap.resolve(CODABaseDataExt.NAMEGLA_RATES), CODATestIDMap.resolve(CODABaseDataExt.NAMEDIM1_MASSACHUSETTS), null, null, null, 30);
        splitStructureList.add(split2);

        AllocationsService.Template template = new AllocationsService.Template(null, TEMPLATE3_NAME, null, filterStructureList, splitStructureList);
        template.DestinationItem = AllocationsService.DestinationType.Transactions;
        template.DestinationCompanyId = CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOGB);

        AllocationsService.saveTemplates(new List<AllocationsService.Template>{template});
    }

    public static void createDataExt22()
    {
        // multi company template 3
        CODATestIDMapExt.load(SUFFIX);

        List<AllocationsService.FilterStructure> filterStructureList = new List<AllocationsService.FilterStructure>();
        AllocationsService.Filter filter1 = new AllocationsService.Filter();
        filter1.FilterCriteria = AllocationsService.FilterCriteria.MultiselectValue;
        filter1.Values = new List<Object> {CODATestIDMap.resolve(CODABaseDataExt.NAMEGLA_RATES)};
        AllocationsService.FilterStructure filterStr1 = new AllocationsService.FilterStructure();
        filterStr1.FilterPosition = 1;
        filterStr1.FilterStructureType = AllocationsService.FilterStructureType.GeneralLedgerAccount;
        filterStr1.DefaultFilterCriteria = AllocationsService.DefaultFilterCriteria.MultiselectValue;
        filterStr1.FilterList = new List<AllocationsService.Filter>{filter1};
        filterStructureList.add(filterStr1);

        AllocationsService.Filter filter2 = new AllocationsService.Filter();
        filter2.FilterCriteria = AllocationsService.FilterCriteria.MultiselectValue;
        filter2.Values = new List<Object> {CODATestIDMap.resolve(CODABaseDataExt.NAMEDIM1_EUR)};
        AllocationsService.FilterStructure filterStr2 = new AllocationsService.FilterStructure();
        filterStr2.FilterPosition = 1;
        filterStr2.FilterStructureType = AllocationsService.FilterStructureType.Dimension1;
        filterStr2.DefaultFilterCriteria = AllocationsService.DefaultFilterCriteria.MultiselectValue;
        filterStr2.FilterList = new List<AllocationsService.Filter>{filter2};
        filterStructureList.add(filterStr2);

        AllocationsService.Filter filter3 = new AllocationsService.Filter();
        filter3.FilterCriteria = AllocationsService.FilterCriteria.MultiselectValue;
        filter3.Values = new List<Object> {CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN)};
        AllocationsService.FilterStructure filterStr3 = new AllocationsService.FilterStructure();
        filterStr3.FilterPosition = 1;
        filterStr3.FilterStructureType = AllocationsService.FilterStructureType.Company;
        filterStr3.DefaultFilterCriteria = AllocationsService.DefaultFilterCriteria.MultiselectValue;
        filterStr3.FilterList = new List<AllocationsService.Filter>{filter3};
        filterStructureList.add(filterStr3);

        AllocationsService.Filter filter4 = new AllocationsService.Filter();
        filter4.FilterCriteria = AllocationsService.FilterCriteria.MultiselectValue;
        filter4.Values = new List<Object> {CODATestIDMap.resolve(CODABaseDataExt.NAMEGLA_RATES)};
        AllocationsService.FilterStructure filterStr4 = new AllocationsService.FilterStructure();
        filterStr4.FilterPosition = 2;
        filterStr4.FilterStructureType = AllocationsService.FilterStructureType.GeneralLedgerAccount;
        filterStr4.DefaultFilterCriteria = AllocationsService.DefaultFilterCriteria.MultiselectValue;
        filterStr4.FilterList = new List<AllocationsService.Filter>{filter4};
        filterStructureList.add(filterStr4);

        AllocationsService.Filter filter5 = new AllocationsService.Filter();
        filter5.FilterCriteria = AllocationsService.FilterCriteria.MultiselectValue;
        filter5.Values = new List<Object> {CODATestIDMap.resolve(CODABaseDataExt.NAMEDIM1_USD)};
        AllocationsService.FilterStructure filterStr5 = new AllocationsService.FilterStructure();
        filterStr5.FilterPosition = 2;
        filterStr5.FilterStructureType = AllocationsService.FilterStructureType.Dimension1;
        filterStr5.DefaultFilterCriteria = AllocationsService.DefaultFilterCriteria.MultiselectValue;
        filterStr5.FilterList = new List<AllocationsService.Filter>{filter5};
        filterStructureList.add(filterStr5);

        AllocationsService.Filter filter6 = new AllocationsService.Filter();
        filter6.FilterCriteria = AllocationsService.FilterCriteria.MultiselectValue;
        filter6.Values = new List<Object> {CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOUSA)};
        AllocationsService.FilterStructure filterStr6 = new AllocationsService.FilterStructure();
        filterStr6.FilterPosition = 2;
        filterStr6.FilterStructureType = AllocationsService.FilterStructureType.Company;
        filterStr6.DefaultFilterCriteria = AllocationsService.DefaultFilterCriteria.MultiselectValue;
        filterStr6.FilterList = new List<AllocationsService.Filter>{filter6};
        filterStructureList.add(filterStr6);

        AllocationsService.Filter filter7 = new AllocationsService.Filter();
        filter7.FilterCriteria = AllocationsService.FilterCriteria.MultiselectValue;
        filter7.Values = new List<Object> {CODATestIDMap.resolve(CODABaseDataExt.NAMEGLA_RATES)};
        AllocationsService.FilterStructure filterStr7 = new AllocationsService.FilterStructure();
        filterStr7.FilterPosition = 3;
        filterStr7.FilterStructureType = AllocationsService.FilterStructureType.GeneralLedgerAccount;
        filterStr7.DefaultFilterCriteria = AllocationsService.DefaultFilterCriteria.MultiselectValue;
        filterStr7.FilterList = new List<AllocationsService.Filter>{filter7};
        filterStructureList.add(filterStr7);

        AllocationsService.Filter filter8 = new AllocationsService.Filter();
        filter8.FilterCriteria = AllocationsService.FilterCriteria.MultiselectValue;
        filter8.Values = new List<Object> {CODATestIDMap.resolve(CODABaseDataExt.NAMEDIM1_QUEENSLAND)};
        AllocationsService.FilterStructure filterStr8 = new AllocationsService.FilterStructure();
        filterStr8.FilterPosition = 3;
        filterStr8.FilterStructureType = AllocationsService.FilterStructureType.Dimension1;
        filterStr8.DefaultFilterCriteria = AllocationsService.DefaultFilterCriteria.MultiselectValue;
        filterStr8.FilterList = new List<AllocationsService.Filter>{filter8};
        filterStructureList.add(filterStr8);

        AllocationsService.Filter filter9 = new AllocationsService.Filter();
        filter9.FilterCriteria = AllocationsService.FilterCriteria.MultiselectValue;
        filter9.Values = new List<Object> {CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOAUS)};
        AllocationsService.FilterStructure filterStr9 = new AllocationsService.FilterStructure();
        filterStr9.FilterPosition = 3;
        filterStr9.FilterStructureType = AllocationsService.FilterStructureType.Company;
        filterStr9.DefaultFilterCriteria = AllocationsService.DefaultFilterCriteria.MultiselectValue;
        filterStr9.FilterList = new List<AllocationsService.Filter>{filter9};
        filterStructureList.add(filterStr9);

        AllocationsService.Filter filter10 = new AllocationsService.Filter();
        filter10.FilterCriteria = AllocationsService.FilterCriteria.MultiselectValue;
        filter10.Values = new List<Object> {CODATestIDMap.resolve(CODABaseDataExt.NAMEGLA_RATES)};
        AllocationsService.FilterStructure filterStr10 = new AllocationsService.FilterStructure();
        filterStr10.FilterPosition = 4;
        filterStr10.FilterStructureType = AllocationsService.FilterStructureType.GeneralLedgerAccount;
        filterStr10.DefaultFilterCriteria = AllocationsService.DefaultFilterCriteria.MultiselectValue;
        filterStr10.FilterList = new List<AllocationsService.Filter>{filter10};
        filterStructureList.add(filterStr10);

        AllocationsService.Filter filter11 = new AllocationsService.Filter();
        filter11.FilterCriteria = AllocationsService.FilterCriteria.MultiselectValue;
        filter11.Values = new List<Object> {CODATestIDMap.resolve(CODABaseDataExt.NAMEDIM1_NORTH)};
        AllocationsService.FilterStructure filterStr11 = new AllocationsService.FilterStructure();
        filterStr11.FilterPosition = 4;
        filterStr11.FilterStructureType = AllocationsService.FilterStructureType.Dimension1;
        filterStr11.DefaultFilterCriteria = AllocationsService.DefaultFilterCriteria.MultiselectValue;
        filterStr11.FilterList = new List<AllocationsService.Filter>{filter11};
        filterStructureList.add(filterStr11);

        AllocationsService.Filter filter12 = new AllocationsService.Filter();
        filter12.FilterCriteria = AllocationsService.FilterCriteria.MultiselectValue;
        filter12.Values = new List<Object> {CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOGB)};
        AllocationsService.FilterStructure filterStr12 = new AllocationsService.FilterStructure();
        filterStr12.FilterPosition = 4;
        filterStr12.FilterStructureType = AllocationsService.FilterStructureType.Company;
        filterStr12.DefaultFilterCriteria = AllocationsService.DefaultFilterCriteria.MultiselectValue;
        filterStr12.FilterList = new List<AllocationsService.Filter>{filter12};
        filterStructureList.add(filterStr12);

        AllocationsService.Filter filter13 = new AllocationsService.Filter();
        filter13.FilterCriteria = AllocationsService.FilterCriteria.MultiselectValue;
        filter13.Values = new List<Object> {CODATestIDMap.resolve(CODABaseDataExt.NAMEGLA_RATES)};
        AllocationsService.FilterStructure filterStr13 = new AllocationsService.FilterStructure();
        filterStr13.FilterPosition = 5;
        filterStr13.FilterStructureType = AllocationsService.FilterStructureType.GeneralLedgerAccount;
        filterStr13.DefaultFilterCriteria = AllocationsService.DefaultFilterCriteria.MultiselectValue;
        filterStr13.FilterList = new List<AllocationsService.Filter>{filter13};
        filterStructureList.add(filterStr13);

        AllocationsService.Filter filter14 = new AllocationsService.Filter();
        filter14.FilterCriteria = AllocationsService.FilterCriteria.MultiselectValue;
        filter14.Values = new List<Object> {CODATestIDMap.resolve(CODABaseDataExt.NAMEDIM1_NEWYORK)};
        AllocationsService.FilterStructure filterStr14 = new AllocationsService.FilterStructure();
        filterStr14.FilterPosition = 5;
        filterStr14.FilterStructureType = AllocationsService.FilterStructureType.Dimension1;
        filterStr14.DefaultFilterCriteria = AllocationsService.DefaultFilterCriteria.MultiselectValue;
        filterStr14.FilterList = new List<AllocationsService.Filter>{filter14};
        filterStructureList.add(filterStr14);

        AllocationsService.Filter filter15 = new AllocationsService.Filter();
        filter15.FilterCriteria = AllocationsService.FilterCriteria.MultiselectValue;
        filter15.Values = new List<Object> {CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINTECHUS)};
        AllocationsService.FilterStructure filterStr15 = new AllocationsService.FilterStructure();
        filterStr15.FilterPosition = 5;
        filterStr15.FilterStructureType = AllocationsService.FilterStructureType.Company;
        filterStr15.DefaultFilterCriteria = AllocationsService.DefaultFilterCriteria.MultiselectValue;
        filterStr15.FilterList = new List<AllocationsService.Filter>{filter15};
        filterStructureList.add(filterStr15);

        List<AllocationsService.SplitStructure> splitStructureList = new List<AllocationsService.SplitStructure>();
        AllocationsService.SplitStructure split1 = new AllocationsService.SplitStructure(CODATestIDMap.resolve(CODABaseDataExt.NAMEGLA_RENT), CODATestIDMap.resolve(CODABaseDataExt.NAMEDIM1_TASMANIA), null, null, null, 99);
        splitStructureList.add(split1);
        AllocationsService.SplitStructure split2 = new AllocationsService.SplitStructure(CODATestIDMap.resolve(CODABaseDataExt.NAMEGLA_RENT), CODATestIDMap.resolve(CODABaseDataExt.NAMEDIM1_SOUTH), null, null, null, 1);
        splitStructureList.add(split2);

        AllocationsService.Template template = new AllocationsService.Template(null, TEMPLATE4_NAME, null, filterStructureList, splitStructureList);
        template.DestinationItem = AllocationsService.DestinationType.Journals;
        template.DestinationCompanyId = CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOAUS);

        AllocationsService.saveTemplates(new List<AllocationsService.Template>{template});
    }

    public static void createDataExt23()
    {
        // multi company template 4
        CODATestIDMapExt.load(SUFFIX);

        List<AllocationsService.FilterStructure> filterStructureList = new List<AllocationsService.FilterStructure>();
        AllocationsService.Filter filter1 = new AllocationsService.Filter();
        filter1.FilterCriteria = AllocationsService.FilterCriteria.MultiselectValue;
        filter1.Values = new List<Object> {CODATestIDMap.resolve(CODABaseDataExt.NAMEGLA_RATES)};
        AllocationsService.FilterStructure filterStr1 = new AllocationsService.FilterStructure();
        filterStr1.FilterPosition = 1;
        filterStr1.FilterStructureType = AllocationsService.FilterStructureType.GeneralLedgerAccount;
        filterStr1.DefaultFilterCriteria = AllocationsService.DefaultFilterCriteria.MultiselectValue;
        filterStr1.FilterList = new List<AllocationsService.Filter>{filter1};
        filterStructureList.add(filterStr1);

        AllocationsService.Filter filter2 = new AllocationsService.Filter();
        filter2.FilterCriteria = AllocationsService.FilterCriteria.MultiselectValue;
        filter2.Values = new List<Object> {CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN)};
        AllocationsService.FilterStructure filterStr2 = new AllocationsService.FilterStructure();
        filterStr2.FilterPosition = 1;
        filterStr2.FilterStructureType = AllocationsService.FilterStructureType.Company;
        filterStr2.DefaultFilterCriteria = AllocationsService.DefaultFilterCriteria.MultiselectValue;
        filterStr2.FilterList = new List<AllocationsService.Filter>{filter2};
        filterStructureList.add(filterStr2);

        AllocationsService.Filter filter3 = new AllocationsService.Filter();
        filter3.FilterCriteria = AllocationsService.FilterCriteria.MultiselectValue;
        filter3.Values = new List<Object> {CODATestIDMap.resolve(CODABaseDataExt.NAMEGLA_RATES)};
        AllocationsService.FilterStructure filterStr3 = new AllocationsService.FilterStructure();
        filterStr3.FilterPosition = 2;
        filterStr3.FilterStructureType = AllocationsService.FilterStructureType.GeneralLedgerAccount;
        filterStr3.DefaultFilterCriteria = AllocationsService.DefaultFilterCriteria.MultiselectValue;
        filterStr3.FilterList = new List<AllocationsService.Filter>{filter3};
        filterStructureList.add(filterStr3);

        AllocationsService.Filter filter4 = new AllocationsService.Filter();
        filter4.FilterCriteria = AllocationsService.FilterCriteria.MultiselectValue;
        filter4.Values = new List<Object> {CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOUSA)};
        AllocationsService.FilterStructure filterStr4 = new AllocationsService.FilterStructure();
        filterStr4.FilterPosition = 2;
        filterStr4.FilterStructureType = AllocationsService.FilterStructureType.Company;
        filterStr4.DefaultFilterCriteria = AllocationsService.DefaultFilterCriteria.MultiselectValue;
        filterStr4.FilterList = new List<AllocationsService.Filter>{filter4};
        filterStructureList.add(filterStr4);

        AllocationsService.Filter filter5 = new AllocationsService.Filter();
        filter5.FilterCriteria = AllocationsService.FilterCriteria.MultiselectValue;
        filter5.Values = new List<Object> {CODATestIDMap.resolve(CODABaseDataExt.NAMEGLA_RENT)};
        AllocationsService.FilterStructure filterStr5 = new AllocationsService.FilterStructure();
        filterStr5.FilterPosition = 3;
        filterStr5.FilterStructureType = AllocationsService.FilterStructureType.GeneralLedgerAccount;
        filterStr5.DefaultFilterCriteria = AllocationsService.DefaultFilterCriteria.MultiselectValue;
        filterStr5.FilterList = new List<AllocationsService.Filter>{filter5};
        filterStructureList.add(filterStr5);

        AllocationsService.Filter filter6 = new AllocationsService.Filter();
        filter6.FilterCriteria = AllocationsService.FilterCriteria.MultiselectValue;
        filter6.Values = new List<Object> {CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOUSA)};
        AllocationsService.FilterStructure filterStr6 = new AllocationsService.FilterStructure();
        filterStr6.FilterPosition = 3;
        filterStr6.FilterStructureType = AllocationsService.FilterStructureType.Company;
        filterStr6.DefaultFilterCriteria = AllocationsService.DefaultFilterCriteria.MultiselectValue;
        filterStr6.FilterList = new List<AllocationsService.Filter>{filter6};
        filterStructureList.add(filterStr6);

        List<AllocationsService.SplitStructure> splitStructureList = new List<AllocationsService.SplitStructure>();
        AllocationsService.SplitStructure split1 = new AllocationsService.SplitStructure(CODATestIDMap.resolve(CODABaseDataExt.NAMEGLA_RENT), CODATestIDMap.resolve(CODABaseDataExt.NAMEDIM1_TASMANIA), null, null, null, 50);
        splitStructureList.add(split1);
        AllocationsService.SplitStructure split2 = new AllocationsService.SplitStructure(CODATestIDMap.resolve(CODABaseDataExt.NAMEGLA_RENT), CODATestIDMap.resolve(CODABaseDataExt.NAMEDIM1_SOUTH), null, null, null, 50);
        splitStructureList.add(split2);

        AllocationsService.Template template = new AllocationsService.Template(null, TEMPLATE5_NAME, null, filterStructureList, splitStructureList);
        template.DestinationItem = AllocationsService.DestinationType.Transactions;
        template.DestinationCompanyId = CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOAUS);

        AllocationsService.saveTemplates(new List<AllocationsService.Template>{template});
    }




    public static void destroyData()
    {
        CODAUnitOfWork.createAndSetCurrent();
        CODAContext.enableSupportAccess(); 

        //TODO make sure this correct

        delete[SELECT Id FROM CODATransaction__c];

        delete[SELECT Id FROM CODAJournal__c];

        // need to call delete on the service to remove the scheduled job
        List<AllocSchedule__c> schedules = [SELECT Id FROM AllocSchedule__c];
        Set<Id> scheduleIds = new Set<Id>();
        for (AllocSchedule__c schedule : schedules)
        {
        	scheduleIds.add(schedule.Id);
        }

        // TODO need to have a look at changing company around each schedule
        //AllocationScheduleService.deleteAllocationSchedules(scheduleIds);

        delete schedules;

        delete[SELECT Id FROM AllocationTemplate__c];

        delete[SELECT Id FROM Allocation__c];

        delete[SELECT Id FROM StatisticalBasis__c];


        CODACompany gbCompany = CODACompanyMapper.getByName(CODABaseData.NAMECOMPANY_MERLINAUTOGB)[0];
        changeDualCurrency('EUR', gbCompany.getId());

        CODACompany techCompany = CODACompanyMapper.getByName(CODABaseData.NAMECOMPANY_MERLINTECHUS)[0];
        changeDualCurrency('GBP', techCompany.getId());

        CODATestIDMapExt.purge(SUFFIX);
        CODAContext.disableSupportAccess(); 
    }

    // Load the data in the Map
    public static void loadMap()
    {
        Date dateToUse = CODADataTestHelper.getSystemTestDate(SUFFIX);

        // glas used
        Id accRecControlEurId = CODAGeneralLedgerAccountMapper.getByName(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLEUR)[0].getId();
        CODATestIDMapExt.put(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLEUR, accRecControlEurId);

        Id accRecControlUsdId = CODAGeneralLedgerAccountMapper.getByName(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD)[0].getId();
        CODATestIDMapExt.put(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLUSD, accRecControlUsdId);

        Id accRecControlAudId = CODAGeneralLedgerAccountMapper.getByName(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLAUD)[0].getId();
        CODATestIDMapExt.put(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLAUD, accRecControlAudId);

        Id accRecControlGbpId = CODAGeneralLedgerAccountMapper.getByName(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLGBP)[0].getId();
        CODATestIDMapExt.put(CODABaseData.NAMEGLA_ACCOUNTSRECEIVABLECONTROLGBP, accRecControlGbpId);

        Id ratesId = CODAGeneralLedgerAccountMapper.getByName(CODABaseDataExt.NAMEGLA_RATES)[0].getId();
        CODATestIDMapExt.put(CODABaseDataExt.NAMEGLA_RATES, ratesId);

        Id rentId = CODAGeneralLedgerAccountMapper.getByName(CODABaseDataExt.NAMEGLA_RENT)[0].getId();
        CODATestIDMapExt.put(CODABaseDataExt.NAMEGLA_RENT, rentId);

        // dimensions used
        Id dim1Id = CODADimension1Mapper.getByName(CODABaseDataExt.NAMEDIM1_EUR)[0].getId();
        CODATestIDMapExt.put(CODABaseDataExt.NAMEDIM1_EUR, dim1Id);

        dim1Id = CODADimension1Mapper.getByName(CODABaseDataExt.NAMEDIM1_USD)[0].getId();
        CODATestIDMapExt.put(CODABaseDataExt.NAMEDIM1_USD, dim1Id);

        dim1Id = CODADimension1Mapper.getByName(CODABaseDataExt.NAMEDIM1_QUEENSLAND)[0].getId();
        CODATestIDMapExt.put(CODABaseDataExt.NAMEDIM1_QUEENSLAND, dim1Id);

        dim1Id = CODADimension1Mapper.getByName(CODABaseDataExt.NAMEDIM1_NORTH)[0].getId();
        CODATestIDMapExt.put(CODABaseDataExt.NAMEDIM1_NORTH, dim1Id);

        dim1Id = CODADimension1Mapper.getByName(CODABaseDataExt.NAMEDIM1_SOUTH)[0].getId();
        CODATestIDMapExt.put(CODABaseDataExt.NAMEDIM1_SOUTH, dim1Id);

        dim1Id = CODADimension1Mapper.getByName(CODABaseDataExt.NAMEDIM1_NEWYORK)[0].getId();
        CODATestIDMapExt.put(CODABaseDataExt.NAMEDIM1_NEWYORK, dim1Id);

        dim1Id = CODADimension1Mapper.getByName(CODABaseDataExt.NAMEDIM1_MASSACHUSETTS)[0].getId();
        CODATestIDMapExt.put(CODABaseDataExt.NAMEDIM1_MASSACHUSETTS, dim1Id);

        dim1Id = CODADimension1Mapper.getByName(CODABaseDataExt.NAMEDIM1_TASMANIA)[0].getId();
        CODATestIDMapExt.put(CODABaseDataExt.NAMEDIM1_TASMANIA, dim1Id);

        // Companies used
        ID spainCompanyId = CODACompanyMapper.getByName(CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN)[0].getId();
        CODATestIDMapExt.put(CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN, spainCompanyId);

        ID usaCompanyId = CODACompanyMapper.getByName(CODABaseData.NAMECOMPANY_MERLINAUTOUSA)[0].getId();
        CODATestIDMapExt.put(CODABaseData.NAMECOMPANY_MERLINAUTOUSA, usaCompanyId);

        ID gbCompanyId = CODACompanyMapper.getByName(CODABaseData.NAMECOMPANY_MERLINAUTOGB)[0].getId();
        CODATestIDMapExt.put(CODABaseData.NAMECOMPANY_MERLINAUTOGB, gbCompanyId);

        ID ausCompanyId = CODACompanyMapper.getByName(CODABaseData.NAMECOMPANY_MERLINAUTOAUS)[0].getId();
        CODATestIDMapExt.put(CODABaseData.NAMECOMPANY_MERLINAUTOAUS, ausCompanyId);

        ID techCompanyId = CODACompanyMapper.getByName(CODABaseData.NAMECOMPANY_MERLINTECHUS)[0].getId();
        CODATestIDMapExt.put(CODABaseData.NAMECOMPANY_MERLINTECHUS, techCompanyId);

        // accounts used
        Id acc_algernonPartnersCo = CODAAccountHelperForTests.getCodaAccountByName(CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO)[0].getId();
        CODATestIDMapExt.put(CODABaseDataExt.NAMEACCOUNT_ALGERNONPARTNERSCO, acc_algernonPartnersCo);

        Id acc_hoganRepairs = CODAAccountHelperForTests.getCodaAccountByName(CODABaseDataExt.NAMEACCOUNT_HOGANREPAIRS)[0].getId();
        CODATestIDMapExt.put(CODABaseDataExt.NAMEACCOUNT_HOGANREPAIRS, acc_hoganRepairs);

        // periods used
        // get a year before and year after the current year
        String year1 = String.valueof(dateToUse.year() - 1);
        String year2 = String.valueof(dateToUse.year());
        String year3 = String.valueof(dateToUse.year() + 1);

        List<String> years = new List<String>{year1, year2, year3};
        String OPENING_PERIOD = CODAPeriodExt.PERIOD_000;
        String ADJUSTMENT_PERIOD = CODAPeriodExt.PERIOD_100;
        String CLOSING_PERIOD = CODAPeriodExt.PERIOD_101;

        List<String> companyNames = new List<String> {CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN, CODABaseData.NAMECOMPANY_MERLINAUTOUSA, CODABaseData.NAMECOMPANY_MERLINAUTOAUS, CODABaseData.NAMECOMPANY_MERLINAUTOGB, CODABaseData.NAMECOMPANY_MERLINTECHUS};
        List<codaPeriod__c> periods = [select id, name, ownercompany__r.Name from codaPeriod__c where YearName__r.Name in :years and ownercompany__r.Name in :companyNames and PeriodNumber__c != :OPENING_PERIOD and PeriodNumber__c != :ADJUSTMENT_PERIOD and PeriodNumber__c != :CLOSING_PERIOD];       
        for ( codaPeriod__c p : periods )
        {
            CODATestIDMapExt.put(p.ownercompany__r.Name+':'+p.Name, p.id);  
        }
		
        List<codaAccountingCurrency__c> cs = [select id, name, ownercompany__r.Name from codaAccountingCurrency__c where ownercompany__r.Name in :companyNames];
        for ( codaAccountingCurrency__c c : cs )
        {
        	CODATestIDMapExt.put(c.ownercompany__r.Name+':'+c.Name, c.id);  
        }
		
        // Save the Mappings
        CODATestIDMapExt.save(SUFFIX);
    }

    private static void changeDualCurrency(String newDualCurrency, Id companyId)
    {
        codaAccountingCurrency__c dualCurrency = [select id, name, dual__c from codaAccountingCurrency__c where ownercompany__c = :companyId and dual__c=true];
        dualCurrency.dual__c = false;
        update dualCurrency;

        dualCurrency = [select id, name, dual__c from codaAccountingCurrency__c where ownercompany__c = :companyId and name=:newDualCurrency];

        dualCurrency.dual__c = true;
        update dualCurrency;
    } 


}

