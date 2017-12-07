/*
 * Copyright (c) 2017 FinancialForce.com, inc. All rights reserved.
 */
public class CODATID021175Data 
{
    //SUFFIX
    public static String SUFFIX = '#TID021175';
    public static String ALLOCATION_RULE_NAME = 'Fixed Allocation Rule 1a';
    public static String ALLOCATION_RULE_DESCRITPION = 'Test Fixed Allocation Rule';
    public static String ALLOCATION_TEMPLATE_NAME = 'Allocation Template 1';
    public static String ALLOCATION_TEMPLATE_DESC = 'Allocation Template Description';
    public static Double PERCENTAGE = 100;
      
    public static void switchProfile()
    {
        //No Code Here
    }
    
    public static void selectCompany()
    {
        CODABaseData.switchCurrentCompany(CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN, true, true, UserInfo.getUserId());
    } 
    
    public static void createData()
    {
        loadMap();
        AllocationRule__c allocRule = new AllocationRule__c();
        allocRule.Type__c = Label.allocationTypeFixed;
        allocRule.Name = ALLOCATION_RULE_NAME;
        allocRule.Active__c = false;
        allocRule.Description__c = ALLOCATION_RULE_DESCRITPION;
        insert allocRule;
        
        List<FixedAllocationRuleLine__c> allocFixedRuleLines = new List<FixedAllocationRuleLine__c>();
        FixedAllocationRuleLine__c fixedallocRuleLine = new FixedAllocationRuleLine__c();
        fixedallocRuleLine.GeneralLedgerAccount__c = CODATestIDMap.resolve(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLUSD);
        fixedallocRuleLine.Dimension1__c = CODATestIDMap.resolve(CODABaseDataExt.NAMEDIM1_USD);
        fixedallocRuleLine.Dimension2__c = CODATestIDMap.resolve(CODABaseDataExt.NAMEDIM2_USD);
        fixedallocRuleLine.Dimension3__c = CODATestIDMap.resolve(CODABaseDataExt.NAMEDIM3_USD);
        fixedallocRuleLine.Dimension4__c = CODATestIDMap.resolve(CODABaseDataExt.NAMEDIM4_USD);
        fixedallocRuleLine.Split__c = PERCENTAGE;
        fixedallocRuleLine.AllocationRule__c = allocRule.Id;
        allocFixedRuleLines.add(fixedallocRuleLine);
        insert allocFixedRuleLines;
        CODATestIDMapExt.put(ALLOCATION_RULE_NAME, allocRule.Id);
		
		AllocationRule__c getAllocationRule = [SELECT Active__c FROM AllocationRule__c WHERE Id = :allocRule.Id];
        getAllocationRule.Active__c = true;
        update getAllocationRule;

        AllocationTemplate__c template = new AllocationTemplate__c();
        template.Name = ALLOCATION_TEMPLATE_NAME;
        template.Description__c = ALLOCATION_TEMPLATE_DESC;
        template.AllocationRule__c = allocRule.Id;
        insert template;
        CODATestIDMapExt.put(ALLOCATION_TEMPLATE_NAME, template.Id);
        CODATestIDMapExt.save(SUFFIX);
    }

    public static void destroyData()
    {
        CODAUnitOfWork.createAndSetCurrent();
        CODAContext.enableSupportAccess(); 
        AllocationTemplate__c template = [SELECT Id,AllocationRule__c FROM AllocationTemplate__c][0];
        template.AllocationRule__c = null;
        update template;

        delete[SELECT Id FROM AllocationRule__c];
        delete[SELECT Id FROM FixedAllocationRuleLine__c];
        delete[SELECT Id FROM AllocationTemplate__c];
        CODATestIDMapExt.purge(SUFFIX);
        CODAContext.disableSupportAccess(); 
    }
    
    // Load the data in the Map
    public static void loadMap()
    {
        // Companies used
        ID company = CODACompanyMapper.getByName(CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN)[0].getId();
        CODATestIDMapExt.put(CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN, company);

        // GLAs
        Set<String> glaNames = new Set<String>();
        glaNames.add(CODABaseData.NAMEGLA_ACCOUNTSPAYABLECONTROLUSD);
        for (CODAGeneralLedgerAccount__c item : [SELECT Id, Name FROM CODAGeneralLedgerAccount__c WHERE Name IN :glaNames])
        {
            CODATestIDMapExt.put(item.Name, item.id);
        }

        //Dimension1
        for (codaDimension1__c  item : [Select Id, Name from codaDimension1__c])
        {
            CODATestIDMapExt.put(item.Name , item.id);
        }
        
        //Dimension2
        for (codaDimension2__c  item : [Select Id, Name from codaDimension2__c])
        {
            CODATestIDMapExt.put(item.Name , item.id);
        }
        
        //Dimension3
        for (codaDimension3__c  item : [Select Id, Name from codaDimension3__c])
        {
            CODATestIDMapExt.put(item.Name , item.id);
        }
        
        //Dimension4
        for (codaDimension4__c  item : [Select Id, Name from codaDimension4__c])
        {
            CODATestIDMapExt.put(item.Name , item.id);
        }
        
        // Save the Mappings
        CODATestIDMapExt.save(SUFFIX);
    }
}