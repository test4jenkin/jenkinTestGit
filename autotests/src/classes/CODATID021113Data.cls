/*
* Copyright (c) 2016 FinancialForce.com, inc.  All rights reserved.
*/
public class CODATID021113Data
{
	public static String SUFFIX = 'TID021113#';
	public static Integer ACTUAL_YEAR = System.today().year();

	public static void switchProfile() 
	{
	}

	public static void selectCompany()
	{
		CODABaseData.switchCurrentCompany(CODABaseData.NAMECOMPANY_MERLINAUTOUSA, true, true, UserInfo.getUserId());
	}

	public static void createData() 
	{
		CODADataTestHelper.setSystemTestDate(SUFFIX);
		loadMap();

		list<codaAccountingSettings__c> accountingsetting = [select id from codaAccountingSettings__c];
		if (accountingsetting.size()>0) {
			accountingsetting[0].GLAFilteringInPaymentSelection__c = 'NO FILTERING';
			update accountingsetting;
		}
		else {
			codaAccountingSettings__c accsetting = new codaAccountingSettings__c();
			accsetting.GLAFilteringInPaymentSelection__c = 'NO FILTERING';
			insert accsetting;
		}

		Account acc= [select id, Name, CODAPaymentMethod__c  from Account where MirrorName__c= :CODABaseDataExt.NAMEACCOUNT_CHRYSLERMOTORSLLC][0];
		acc.CODAPaymentMethod__c = CODAPayment.PAYMENTMETHOD_ELECTRONIC;
		update acc;

		CODAPurchaseInvoiceTestHelper purchaseInvoice = new CODAPurchaseInvoiceTestHelper();

		purchaseInvoice.setAccount(CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES);
		purchaseInvoice.setInvoiceDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX) + 10);
		purchaseInvoice.setVendorInvoiceNumber('PIN1');
		purchaseInvoice.setAccountInvoiceTotal('149');

		CODAPurchaseInvoiceTestHelper.ProductLineItem lineItem = purchaseInvoice.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		lineItem.setQuantity(1.00);
		lineItem.setUnitPrice(149.00);
		purchaseInvoice.saveAndPost();

		CODAPurchaseCreditNoteTestHelper purchaseCreditNote = new CODAPurchaseCreditNoteTestHelper();
		purchaseCreditNote.setAccount(CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES);
		purchaseCreditNote.setCreditNoteDate(CODADataTestHelper.getSystemTestDate(SUFFIX));

		purchaseCreditNote.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX)+20);
		purchaseCreditNote.setAccountCreditNoteTotal('149');

		purchaseCreditNote.setVendorCreditNoteNumber('PCR1');

		CODAPurchaseCreditNoteTestHelper.ProductLineItem productLine = purchaseCreditNote.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		productLine.setUnitPrice(149.00);
		productLine.setQuantity(1);
		purchaseCreditNote.saveAndPost();
	}

	public static void createDataExt1()
	{
		CODATestIDMapExt.load(SUFFIX);
		CODAPurchaseInvoiceTestHelper purchaseInvoice = new CODAPurchaseInvoiceTestHelper();

		purchaseInvoice.setAccount(CODABaseDataExt.NAMEACCOUNT_AUDI);
		purchaseInvoice.setInvoiceDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX) + 10);
		purchaseInvoice.setVendorInvoiceNumber('PIN2');
		purchaseInvoice.setAccountInvoiceTotal('300');

		CODAPurchaseInvoiceTestHelper.ProductLineItem lineItem = purchaseInvoice.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		lineItem.setQuantity(1.00);
		lineItem.setUnitPrice(300.00);
		purchaseInvoice.saveAndPost();

		CODAPurchaseCreditNoteTestHelper purchaseCreditNote = new CODAPurchaseCreditNoteTestHelper();
		purchaseCreditNote.setAccount(CODABaseDataExt.NAMEACCOUNT_AUDI);
		purchaseCreditNote.setCreditNoteDate(CODADataTestHelper.getSystemTestDate(SUFFIX));

		purchaseCreditNote.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX)+20);
		purchaseCreditNote.setAccountCreditNoteTotal('149');

		purchaseCreditNote.setVendorCreditNoteNumber('PCR2');

		CODAPurchaseCreditNoteTestHelper.ProductLineItem productLine = purchaseCreditNote.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		productLine.setUnitPrice(149.00);
		productLine.setQuantity(1);

		purchaseCreditNote.saveAndPost();
		
	}

	public static void createDataExt2()
	{
		CODATestIDMapExt.load(SUFFIX);
		CODAPurchaseInvoiceTestHelper purchaseInvoice = new CODAPurchaseInvoiceTestHelper();

		purchaseInvoice.setAccount(CODABaseDataExt.NAMEACCOUNT_CHRYSLERMOTORSLLC);
		purchaseInvoice.setInvoiceDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX) + 10);
		purchaseInvoice.setVendorInvoiceNumber('PIN3');
		purchaseInvoice.setAccountInvoiceTotal('149');
		purchaseInvoice.setInvoiceCurrency(CODABaseData.CURRENCYCODE_EUR);

		CODAPurchaseInvoiceTestHelper.ProductLineItem lineItem = purchaseInvoice.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		lineItem.setQuantity(1.00);
		lineItem.setUnitPrice(149.00);
		purchaseInvoice.saveAndPost();
	}

	public static void createDataExt3()
	{
		CODAContext.SetService(true); 
		CODAUnitOfWork.getCurrent();
		CODABankAccount bankAccount = CODABankAccountMapper.getByName(CODABaseDataExt.NAMEBANKACC_BRISTOLEUROSACCOUNT)[0];
		CODACheckRange cRange = new CODACheckRange();
		cRange.setCheckRangeName('CHR001');
		cRange.setBankAccount(bankAccount);
		cRange.setStartCheckNumber('000001');
		cRange.setLastCheckNumber('000100');
		cRange.setActivated(true);
		CODAUnitOfWork.getCurrent().commitWork();
	}

	public static void createDataExt4()
	{
		CODAContext.SetService(true); 
		CODAUnitOfWork.getCurrent();
		CODABankAccount bankAccount = CODABankAccountMapper.getByName(CODABaseDataExt.NAMEBANKACC_BRISTOLEUROSACCOUNT)[0];

		CODACheckRange cRange2 = new CODACheckRange();
		cRange2.setCheckRangeName('CHR002');
		cRange2.setBankAccount(bankAccount);
		cRange2.setStartCheckNumber('000101');
		cRange2.setLastCheckNumber('000101');
		cRange2.setActivated(false);
		CODAUnitOfWork.getCurrent().commitWork();
	}

	public static void createDataExt5()
	{
		CODATestIDMapExt.load(SUFFIX);
		CODAPurchaseInvoiceTestHelper purchaseInvoice = new CODAPurchaseInvoiceTestHelper();

		purchaseInvoice.setAccount(CODABaseDataExt.NAMEACCOUNT_MERCEDESBENZINC);
		purchaseInvoice.setInvoiceDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice.setVendorInvoiceNumber('PIN4');
		purchaseInvoice.setAccountInvoiceTotal('149');
		purchaseInvoice.setInvoiceCurrency(CODABaseData.CURRENCYCODE_EUR);

		CODAPurchaseInvoiceTestHelper.ProductLineItem lineItem = purchaseInvoice.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		lineItem.setQuantity(1.00);
		lineItem.setUnitPrice(149.00);
		purchaseInvoice.saveAndPost();
	}

	public static void createDataExt8()
	{
		CODATestIDMapExt.load(SUFFIX);
		CODAPurchaseInvoiceTestHelper purchaseInvoice = new CODAPurchaseInvoiceTestHelper();

		purchaseInvoice.setAccount(CODABaseDataExt.NAMEACCOUNT_CHRYSLERMOTORSLLC);
		purchaseInvoice.setInvoiceDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX) + 10);
		purchaseInvoice.setVendorInvoiceNumber('PINV3');
		purchaseInvoice.setAccountInvoiceTotal('149');
		purchaseInvoice.setInvoiceCurrency(CODABaseData.CURRENCYCODE_EUR);

		CODAPurchaseInvoiceTestHelper.ProductLineItem lineItem = purchaseInvoice.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		lineItem.setQuantity(1.00);
		lineItem.setUnitPrice(149.00);
		purchaseInvoice.saveAndPost();
	}

	public static void createDataExt9()
	{
		CODATestIDMapExt.load(SUFFIX);
		CODAPurchaseInvoiceTestHelper purchaseInvoice = new CODAPurchaseInvoiceTestHelper();

		purchaseInvoice.setAccount(CODABaseDataExt.NAMEACCOUNT_MERCEDESBENZINC);
		purchaseInvoice.setInvoiceDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice.setVendorInvoiceNumber('PINV4');
		purchaseInvoice.setAccountInvoiceTotal('149');
		purchaseInvoice.setInvoiceCurrency(CODABaseData.CURRENCYCODE_EUR);

		CODAPurchaseInvoiceTestHelper.ProductLineItem lineItem = purchaseInvoice.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		lineItem.setQuantity(1.00);
		lineItem.setUnitPrice(149.00);
		purchaseInvoice.saveAndPost();
	}


	public static void createDataExt10() 
	{
		CODATestIDMapExt.load(SUFFIX);
		CODAPurchaseInvoiceTestHelper purchaseInvoice = new CODAPurchaseInvoiceTestHelper();

		purchaseInvoice.setAccount(CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES);
		purchaseInvoice.setInvoiceDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX) + 10);
		purchaseInvoice.setVendorInvoiceNumber('PINVOICE1');
		purchaseInvoice.setAccountInvoiceTotal('149');

		CODAPurchaseInvoiceTestHelper.ProductLineItem lineItem = purchaseInvoice.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		lineItem.setQuantity(1.00);
		lineItem.setUnitPrice(149.00);
		purchaseInvoice.saveAndPost();

		CODAPurchaseCreditNoteTestHelper purchaseCreditNote = new CODAPurchaseCreditNoteTestHelper();
		purchaseCreditNote.setAccount(CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES);
		purchaseCreditNote.setCreditNoteDate(CODADataTestHelper.getSystemTestDate(SUFFIX));

		purchaseCreditNote.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX)+20);
		purchaseCreditNote.setAccountCreditNoteTotal('149');

		purchaseCreditNote.setVendorCreditNoteNumber('PCRNOTE1');

		CODAPurchaseCreditNoteTestHelper.ProductLineItem productLine = purchaseCreditNote.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		productLine.setUnitPrice(149.00);
		productLine.setQuantity(1);
		purchaseCreditNote.saveAndPost();
	}

	public static void createDataExt11()
	{
		CODATestIDMapExt.load(SUFFIX);
		CODAPurchaseInvoiceTestHelper purchaseInvoice = new CODAPurchaseInvoiceTestHelper();

		purchaseInvoice.setAccount(CODABaseDataExt.NAMEACCOUNT_AUDI);
		purchaseInvoice.setInvoiceDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX) + 10);
		purchaseInvoice.setVendorInvoiceNumber('PINVOICE2');
		purchaseInvoice.setAccountInvoiceTotal('300');

		CODAPurchaseInvoiceTestHelper.ProductLineItem lineItem = purchaseInvoice.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		lineItem.setQuantity(1.00);
		lineItem.setUnitPrice(300.00);
		purchaseInvoice.saveAndPost();

		CODAPurchaseCreditNoteTestHelper purchaseCreditNote = new CODAPurchaseCreditNoteTestHelper();
		purchaseCreditNote.setAccount(CODABaseDataExt.NAMEACCOUNT_AUDI);
		purchaseCreditNote.setCreditNoteDate(CODADataTestHelper.getSystemTestDate(SUFFIX));

		purchaseCreditNote.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX)+20);
		purchaseCreditNote.setAccountCreditNoteTotal('149');

		purchaseCreditNote.setVendorCreditNoteNumber('PCRNOTE2');

		CODAPurchaseCreditNoteTestHelper.ProductLineItem productLine = purchaseCreditNote.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		productLine.setUnitPrice(149.00);
		productLine.setQuantity(1);

		purchaseCreditNote.saveAndPost();
		
	}

	public static void createDataExt12()
	{
		CODATestIDMapExt.load(SUFFIX);
		CODAPurchaseInvoiceTestHelper purchaseInvoice = new CODAPurchaseInvoiceTestHelper();

		purchaseInvoice.setAccount(CODABaseDataExt.NAMEACCOUNT_CHRYSLERMOTORSLLC);
		purchaseInvoice.setInvoiceDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX) + 10);
		purchaseInvoice.setVendorInvoiceNumber('PINVOICE3');
		purchaseInvoice.setAccountInvoiceTotal('149');
		purchaseInvoice.setInvoiceCurrency(CODABaseData.CURRENCYCODE_EUR);

		CODAPurchaseInvoiceTestHelper.ProductLineItem lineItem = purchaseInvoice.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		lineItem.setQuantity(1.00);
		lineItem.setUnitPrice(149.00);
		purchaseInvoice.saveAndPost();
	}

	public static void createDataExt13() 
	{
		CODATestIDMapExt.load(SUFFIX);
		CODAPurchaseInvoiceTestHelper purchaseInvoice = new CODAPurchaseInvoiceTestHelper();

		purchaseInvoice.setAccount(CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES);
		purchaseInvoice.setInvoiceDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX) + 10);
		purchaseInvoice.setVendorInvoiceNumber('PINV71');
		purchaseInvoice.setAccountInvoiceTotal('149');

		CODAPurchaseInvoiceTestHelper.ProductLineItem lineItem = purchaseInvoice.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		lineItem.setQuantity(1.00);
		lineItem.setUnitPrice(149.00);
		purchaseInvoice.saveAndPost();

		CODAPurchaseCreditNoteTestHelper purchaseCreditNote = new CODAPurchaseCreditNoteTestHelper();
		purchaseCreditNote.setAccount(CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES);
		purchaseCreditNote.setCreditNoteDate(CODADataTestHelper.getSystemTestDate(SUFFIX));

		purchaseCreditNote.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX)+20);
		purchaseCreditNote.setAccountCreditNoteTotal('149');

		purchaseCreditNote.setVendorCreditNoteNumber('PCRN71');

		CODAPurchaseCreditNoteTestHelper.ProductLineItem productLine = purchaseCreditNote.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		productLine.setUnitPrice(149.00);
		productLine.setQuantity(1);
		purchaseCreditNote.saveAndPost();
	}

	public static void createDataExt14()
	{
		CODATestIDMapExt.load(SUFFIX);
		CODAPurchaseInvoiceTestHelper purchaseInvoice = new CODAPurchaseInvoiceTestHelper();

		purchaseInvoice.setAccount(CODABaseDataExt.NAMEACCOUNT_AUDI);
		purchaseInvoice.setInvoiceDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX) + 10);
		purchaseInvoice.setVendorInvoiceNumber('PINV72');
		purchaseInvoice.setAccountInvoiceTotal('300');

		CODAPurchaseInvoiceTestHelper.ProductLineItem lineItem = purchaseInvoice.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		lineItem.setQuantity(1.00);
		lineItem.setUnitPrice(300.00);
		purchaseInvoice.saveAndPost();

		CODAPurchaseCreditNoteTestHelper purchaseCreditNote = new CODAPurchaseCreditNoteTestHelper();
		purchaseCreditNote.setAccount(CODABaseDataExt.NAMEACCOUNT_AUDI);
		purchaseCreditNote.setCreditNoteDate(CODADataTestHelper.getSystemTestDate(SUFFIX));

		purchaseCreditNote.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX)+20);
		purchaseCreditNote.setAccountCreditNoteTotal('149');

		purchaseCreditNote.setVendorCreditNoteNumber('PCRN72');

		CODAPurchaseCreditNoteTestHelper.ProductLineItem productLine = purchaseCreditNote.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		productLine.setUnitPrice(149.00);
		productLine.setQuantity(1);

		purchaseCreditNote.saveAndPost();
		
	}

	public static void createDataExt15()
	{
		CODATestIDMapExt.load(SUFFIX);
		CODAPurchaseInvoiceTestHelper purchaseInvoice = new CODAPurchaseInvoiceTestHelper();

		purchaseInvoice.setAccount(CODABaseDataExt.NAMEACCOUNT_CHRYSLERMOTORSLLC);
		purchaseInvoice.setInvoiceDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX) + 10);
		purchaseInvoice.setVendorInvoiceNumber('PINV73');
		purchaseInvoice.setAccountInvoiceTotal('149');
		purchaseInvoice.setInvoiceCurrency(CODABaseData.CURRENCYCODE_EUR);

		CODAPurchaseInvoiceTestHelper.ProductLineItem lineItem = purchaseInvoice.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		lineItem.setQuantity(1.00);
		lineItem.setUnitPrice(149.00);
		purchaseInvoice.saveAndPost();
	}

	public static void createDataExt16()
	{
		CODATestIDMapExt.load(SUFFIX);
		CODAPurchaseInvoiceTestHelper purchaseInvoice = new CODAPurchaseInvoiceTestHelper();

		purchaseInvoice.setAccount(CODABaseDataExt.NAMEACCOUNT_MERCEDESBENZINC);
		purchaseInvoice.setInvoiceDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice.setVendorInvoiceNumber('PINV74');
		purchaseInvoice.setAccountInvoiceTotal('149');
		purchaseInvoice.setInvoiceCurrency(CODABaseData.CURRENCYCODE_EUR);

		CODAPurchaseInvoiceTestHelper.ProductLineItem lineItem = purchaseInvoice.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		lineItem.setQuantity(1.00);
		lineItem.setUnitPrice(149.00);
		purchaseInvoice.saveAndPost();
	}

	public static void createDataExt17() 
	{
		CODATestIDMapExt.load(SUFFIX);
		CODAPurchaseInvoiceTestHelper purchaseInvoice = new CODAPurchaseInvoiceTestHelper();

		purchaseInvoice.setAccount(CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES);
		purchaseInvoice.setInvoiceDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX) + 10);
		purchaseInvoice.setVendorInvoiceNumber('PINV81');
		purchaseInvoice.setAccountInvoiceTotal('149');

		CODAPurchaseInvoiceTestHelper.ProductLineItem lineItem = purchaseInvoice.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		lineItem.setQuantity(1.00);
		lineItem.setUnitPrice(149.00);
		purchaseInvoice.saveAndPost();

		CODAPurchaseCreditNoteTestHelper purchaseCreditNote = new CODAPurchaseCreditNoteTestHelper();
		purchaseCreditNote.setAccount(CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES);
		purchaseCreditNote.setCreditNoteDate(CODADataTestHelper.getSystemTestDate(SUFFIX));

		purchaseCreditNote.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX)+20);
		purchaseCreditNote.setAccountCreditNoteTotal('149');

		purchaseCreditNote.setVendorCreditNoteNumber('PCRN81');

		CODAPurchaseCreditNoteTestHelper.ProductLineItem productLine = purchaseCreditNote.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		productLine.setUnitPrice(149.00);
		productLine.setQuantity(1);
		purchaseCreditNote.saveAndPost();
	}

	public static void createDataExt18()
	{
		CODATestIDMapExt.load(SUFFIX);
		CODAPurchaseInvoiceTestHelper purchaseInvoice = new CODAPurchaseInvoiceTestHelper();

		purchaseInvoice.setAccount(CODABaseDataExt.NAMEACCOUNT_AUDI);
		purchaseInvoice.setInvoiceDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX) + 10);
		purchaseInvoice.setVendorInvoiceNumber('PINV82');
		purchaseInvoice.setAccountInvoiceTotal('300');

		CODAPurchaseInvoiceTestHelper.ProductLineItem lineItem = purchaseInvoice.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		lineItem.setQuantity(1.00);
		lineItem.setUnitPrice(300.00);
		purchaseInvoice.saveAndPost();

		CODAPurchaseCreditNoteTestHelper purchaseCreditNote = new CODAPurchaseCreditNoteTestHelper();
		purchaseCreditNote.setAccount(CODABaseDataExt.NAMEACCOUNT_AUDI);
		purchaseCreditNote.setCreditNoteDate(CODADataTestHelper.getSystemTestDate(SUFFIX));

		purchaseCreditNote.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX)+20);
		purchaseCreditNote.setAccountCreditNoteTotal('149');

		purchaseCreditNote.setVendorCreditNoteNumber('PCRN82');

		CODAPurchaseCreditNoteTestHelper.ProductLineItem productLine = purchaseCreditNote.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		productLine.setUnitPrice(149.00);
		productLine.setQuantity(1);

		purchaseCreditNote.saveAndPost();
		
	}

	public static void createDataExt19()
	{
		CODATestIDMapExt.load(SUFFIX);
		CODAPurchaseInvoiceTestHelper purchaseInvoice = new CODAPurchaseInvoiceTestHelper();

		purchaseInvoice.setAccount(CODABaseDataExt.NAMEACCOUNT_CHRYSLERMOTORSLLC);
		purchaseInvoice.setInvoiceDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX) + 10);
		purchaseInvoice.setVendorInvoiceNumber('PINV83');
		purchaseInvoice.setAccountInvoiceTotal('149');
		purchaseInvoice.setInvoiceCurrency(CODABaseData.CURRENCYCODE_EUR);

		CODAPurchaseInvoiceTestHelper.ProductLineItem lineItem = purchaseInvoice.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		lineItem.setQuantity(1.00);
		lineItem.setUnitPrice(149.00);
		purchaseInvoice.saveAndPost();
	}

	public static void createDataExt20()
	{
		CODATestIDMapExt.load(SUFFIX);
		CODAPurchaseInvoiceTestHelper purchaseInvoice = new CODAPurchaseInvoiceTestHelper();

		purchaseInvoice.setAccount(CODABaseDataExt.NAMEACCOUNT_MERCEDESBENZINC);
		purchaseInvoice.setInvoiceDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice.setDueDate(CODADataTestHelper.getSystemTestDate(SUFFIX));
		purchaseInvoice.setVendorInvoiceNumber('PINV84');
		purchaseInvoice.setAccountInvoiceTotal('149');
		purchaseInvoice.setInvoiceCurrency(CODABaseData.CURRENCYCODE_EUR);

		CODAPurchaseInvoiceTestHelper.ProductLineItem lineItem = purchaseInvoice.newProductLine(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		lineItem.setQuantity(1.00);
		lineItem.setUnitPrice(149.00);
		purchaseInvoice.saveAndPost();
	}

	public static void createDataExt21()
	{
		createPaymentInProposal('PPLUS-PROPOSED_1', new List<String>{'PIN2', 'PCR2', 'PIN1', 'PCR1', 'PIN3'});
	}

	public static void createDataExt22()
	{
		createPaymentInProposal('PPLUS-PROPOSED_2', new List<String>{'PINV3', 'PIN4'});
	}

	public static void createDataExt23()
	{
		createPaymentInProposal('PPLUS-PROPOSED_3', new List<String>{'PINVOICE2','PCRNOTE2','PINVOICE1','PCRNOTE1', 'PINVOICE3'});
	}

	public static void createDataExt24()
	{
		createPaymentInProposal('PPLUS-PROPOSED_4', new List<String>{'PINV72','PCRN72','PINV71','PCRN71', 'PINV73', 'PINV74'});
	}

	public static void createDataExt25()
	{
		createPaymentInProposal('PPLUS-PROPOSED_5', new List<String>{'PINV82','PCRN82','PINV81','PCRN81', 'PINV83', 'PINV84'});
	}

	public static void deactivateCheckRange(String checkRangeName)
	{
		codaCheckRange__c checkrange = [select Id, Activated__c from codaCheckRange__c where CheckRangeName__c =:checkRangeName and BankAccount__r.Name =:CODABaseDataExt.NAMEBANKACC_BRISTOLEUROSACCOUNT][0];
		checkrange.Activated__c = false;
		update checkrange;
	}

	public static void activateCheckRange(String checkRangeName)
	{
		codaCheckRange__c checkrange = [select Id, Activated__c from codaCheckRange__c where CheckRangeName__c =:checkRangeName and BankAccount__r.Name =:CODABaseDataExt.NAMEBANKACC_BRISTOLEUROSACCOUNT][0];
		checkrange.Activated__c = true;
		update checkrange;
	}

	private static void createPaymentInProposal(String description, List<String> tliNames)
	{
		CODATestIDMapExt.load(SUFFIX);
		Set<String> specialPeriods = new Set<String> {'000', '100', '101'};
		codaPeriod__c period = [Select id, EndDate__c from codaPeriod__c where StartDate__c <= :CODADataTestHelper.getSystemTestDate(SUFFIX) and EndDate__c >= :CODADataTestHelper.getSystemTestDate(SUFFIX) and OwnerCompany__r.Name = :CODABaseData.NAMECOMPANY_MERLINAUTOUSA and Closed__c = false and PeriodNumber__c not in :specialPeriods];

		List<codaPayment__c> payList = new List<codaPayment__c>();
		codaPayment__c pay = new codaPayment__c();
		pay.PaymentCurrency__c = CODATestIDMap.resolve(CODABaseData.CURRENCYCODE_EUR);
		pay.BankAccount__c = CODATestIDMap.resolve(CODABaseDataExt.NAMEBANKACC_BRISTOLEUROSACCOUNT);
		pay.OwnerCompany__c = CODATestIDMap.resolve(CODABaseData.NAMECOMPANY_MERLINAUTOUSA);
		pay.CurrencyMode__c = 'Document';
		pay.CurrencyWriteOff__c = CODATestIDMap.resolve(CODABaseData.NAMEGLA_WRITEOFFUS);
		pay.Description__c = description;
		pay.DocumentCurrency__c = CODATestIDMap.resolve(CODABaseData.CURRENCYCODE_EUR);
		pay.PaymentDate__c = system.today();
		pay.PaymentMediaTypes__c = 'Check';
		pay.PaymentTypes__c = 'Payments';
		pay.SettlementDiscountReceived__c = CODATestIDMap.resolve(CODABaseData.NAMEGLA_SETTLEMENTDISCOUNTSALLOWEDUS);
		pay.Status__c = 'New';
		pay.CreatedByPaymentsPlus__c = true;
		pay.DiscountDate__c = system.today() + 10;
		pay.period__c = period.Id;
		payList.add(pay);

		insert payList;

		pay = [select id, Name from codaPayment__c where Description__c =:description];

		List<Id> transLineIDList = new List<Id>();
		for (String tliName : tliNames)
			transLineIDList.add(getTLIId(tliName));
		
		PaymentsPlusService.addToProposal(pay.Id, transLineIDList);
	}

	public static void destroyData()
	{
		CODATestIDMapExt.load(SUFFIX);
		CODAContext.enableSupportAccess();
		CODADataTestHelper.deleteSystemTestDate(SUFFIX);
		restoreChryslerGLA();
		Account acc= [select id, Name, CODAPaymentMethod__c  from Account where MirrorName__c= :CODABaseDataExt.NAMEACCOUNT_CHRYSLERMOTORSLLC][0];
		acc.CODAPaymentMethod__c = CODAPayment.PAYMENTMETHOD_CHECK;
		update acc;
		delete [select Id from PaymentsPlusErrorLog__c];
		delete [select Id from codaCashEntry__c];
		delete [select Id from codaJournal__c];
		delete [select Id from codaCashMatchingHistory__c];
		delete [select Id from codaPurchaseCreditNote__c];
		delete [select Id from codaPurchaseInvoice__c];
		delete [select Id from codaTransaction__c];
		delete [select Id from codaAccountingSettings__c];
		delete [select Id from codaPayment__c];
		delete [select Id from codaPaymentMediaDetail__c];
		delete [select Id from codaPaymentMediaSummary__c];
		delete [select Id from codaPaymentMediaControl__c];
		delete [select Id from codaCheckRange__c];
		delete [select Id from codaCheckNumber__c];
		CODATestIDMapExt.purge(SUFFIX);
		
	}

	public static void changeChryslerGLA()
	{
		Account accChrysler = [select Id, CODAAccountsPayableControl__c from Account where MirrorName__c=:CODABaseDataExt.NAMEACCOUNT_CHRYSLERMOTORSLLC][0];
		codaGeneralLedgerAccount__c glaAPCEUR = [select id from codaGeneralLedgerAccount__c where Name =:CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLEUR][0];
		accChrysler.CODAAccountsPayableControl__c =glaAPCEUR.Id;
		update accChrysler;
	}

	public static void restoreChryslerGLA()
	{
		Account accChrysler = [select Id, CODAAccountsPayableControl__c from Account where MirrorName__c=:CODABaseDataExt.NAMEACCOUNT_CHRYSLERMOTORSLLC][0];
		codaGeneralLedgerAccount__c glaAPCUSD = [select id from codaGeneralLedgerAccount__c where Name =:CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLUSD][0];
		accChrysler.CODAAccountsPayableControl__c = glaAPCUSD.Id;
		update accChrysler;
	}

	public static void loadMap()
	{
		// Company
		CODACompany company = CODACompanyMapExt.getCurrentCompany();
		Id compID = company.getId();
		CODATestIDMapExt.put(CODABaseData.NAMECOMPANY_MERLINAUTOUSA, compID);

		// Currencies for Merlin Auto USA
		for (codaAccountingCurrency__c accCurr : [SELECT Id, Name FROM codaAccountingCurrency__c WHERE OwnerCompany__c  = :compId])
		{
			CODATestIDMapExt.put(accCurr.Name, accCurr.id);
		}

		// Periods for Merlin Auto Spain
		for (codaPeriod__c period : [SELECT Id, Name FROM codaPeriod__c WHERE YearName__r.Name = :String.valueof(ACTUAL_YEAR) AND OwnerCompany__c = :compId])
		{
			CODATestIDMapExt.put(period.Name, period.id);
		}

		// General Ledger Account
		Set<String> glaNames = new Set<String>();
		glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLUSD);
		glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLEUR);
		glaNames.add(CODABaseData.NAMEGLA_SALESPARTS);
		glaNames.add(CODABaseData.NAMEGLA_WRITEOFFUS);
		glaNames.add(CODABaseData.NAMEGLA_SETTLEMENTDISCOUNTSALLOWEDUS);

		for (CODAGeneralLedgerAccount__c item : [SELECT Id, Name FROM CODAGeneralLedgerAccount__c WHERE Name in :glaNames])
		{
			CODATestIDMapExt.put(item.Name, item.id);
		}

		// Products
		Set<String> productNames = new Set<String>();
		productNames.add(CODABaseDataExt.NAMEPRODUCT_AUTOCOMCLUTCH);
		Map<String, Id> CODAProduct2Map = CODAProduct2Mapper.getIDsByNames(productNames);

		for(String key : CODAProduct2Map.keyset())
		{
			CODATestIDMapExt.put(key, CODAProduct2Map.get(key));
		}

		// Accounts
		Set<String> accNames = new Set<String>();
		accNames.add(CODABaseDataExt.NAMEACCOUNT_CHRYSLERMOTORSLLC);
		accNames.add(CODABaseDataExt.NAMEACCOUNT_AUDI);
		accNames.add(CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES);
		accNames.add(CODABaseDataExt.NAMEACCOUNT_MERCEDESBENZINC);

		for (Account accId : [SELECT Id, Name FROM Account WHERE MirrorName__c in :accNames])
		{
			CODATestIDMapExt.put(accId.Name, accId.id);
		}
		
		// Bank Accounts
		Set<String> bankAccouns = new Set<String>();
		bankAccouns.add(CODABaseDataExt.NAMEBANKACC_BRISTOLEUROSACCOUNT);

		for (CODABankAccount__c account : [SELECT Id, Name FROM codaBankAccount__c WHERE Name in :bankAccouns and OwnerCompany__c = :compID])
		{
			CODATestIDMapExt.put(account.Name, account.id);
		}

		CODATestIDMapExt.save(SUFFIX);
	}

	private static Id getTLIId(String vendorDocumentNumber)
	{
		return[select id from codaTransactionLineItem__c where Transaction__r.VendorDocumentNumber__c = :vendorDocumentNumber and LineType__c = 'Account'][0].Id;
	}
}