public with sharing class TA_Family_Support_Plan_Village_Task implements TriggerAction.AfterInsert {
    
    final String PRIORITY = 'High';
    final String FOCUS_AREA = 'Health & Safety';
    
    public void afterInsert(List<CAMPX__Family_Support_Plan__c> triggerNew) {

        List<CAMPX__Village_Task__c> listOfTasksToCreate = new List<CAMPX__Village_Task__c>();

        for (CAMPX__Family_Support_Plan__c plan : triggerNew) {
            System.debug('Plan Priority: ' + plan.CAMPX__Priority__c);
            System.debug('Plan Focus Area: ' + plan.CAMPX__Focus_Area__c);
            System.debug('Plan Phase: ' + plan.CAMPX__Phase__c);
            if (plan.CAMPX__Priority__c == PRIORITY && plan.CAMPX__Focus_Area__c == FOCUS_AREA) {
                CAMPX__Village_Task__c villageTask = new CAMPX__Village_Task__c(
                    CAMPX__Assigned_Character__c = 'Dr. Grace Evergreen',
                    CAMPX__Status__c = 'Not Started',
                    CAMPX__Is_Baby_Safety_Critical__c = true,
                    CAMPX__Task_Type__c = 'Health & Safety Check',
                    CAMPX__Support_Phase__c = plan.CAMPX__Phase__c,
                    CAMPX__Family_Support_Plan__c = plan.Id
                );
                listOfTasksToCreate.add(villageTask);
            }
        }
        if (!listOfTasksToCreate.isEmpty()) {
            Database.SaveResult[] results = Database.insert(listOfTasksToCreate, false);
            System.debug(JSON.serializePretty(results));
        }
    }
}