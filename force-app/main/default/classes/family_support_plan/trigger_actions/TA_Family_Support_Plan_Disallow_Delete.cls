public with sharing class TA_Family_Support_Plan_Disallow_Delete implements TriggerAction.BeforeDelete {
    
    public static void beforeDelete(List<CAMPX__Family_Support_Plan__c> triggerOld) {
        
        Map<Id,CAMPX__Family_Support_Plan__c> familySupportPlanMap = new Map<Id,CAMPX__Family_Support_Plan__c>(triggerOld);

        List<CAMPX__Family_Support_Plan__c> familySupportPlansWithTasks = [
                SELECT Id, CAMPX__Priority__c,
                    (SELECT Id FROM CAMPX__Village_Tasks__r)
                FROM CAMPX__Family_Support_Plan__c
                WHERE Id IN :familySupportPlanMap.keySet() ];

        System.debug(JSON.serializePretty(familySupportPlansWithTasks));

        for (CAMPX__Family_Support_Plan__c supportPlan : familySupportPlansWithTasks) {
            
            if (supportPlan.CAMPX__Priority__c == 'High' && !supportPlan.CAMPX__Village_Tasks__r.isEmpty()) {
                
                familySupportPlanMap.get(supportPlan.Id).addError('Cannot delete a high-priority plan that has related tasks. Please remove all tasks first.');
            }
        }



        // //Family Support Plan map is created so we can use the keySet() in our villageTaskList Query below.
        // Map<Id,CAMPX__Family_Support_Plan__c> familySupportPlanMap = new Map<Id,CAMPX__Family_Support_Plan__c>(triggerOld);

        // //This query provides all village tasks that have a parent family support plan. We are using this list to build the familySupportPlanIdToVillage Task map below.
        // List<CAMPX__Village_Task__c> villageTaskList = [    SELECT Id, CAMPX__Family_Support_Plan__c
        //                                                     FROM CAMPX__Village_Task__c
        //                                                     WHERE CAMPX__Family_Support_Plan__c IN :familySupportPlanMap.keySet() ];

        // //The purpose of this map is to proivde access to a village task from within our for loop below.
        // Map<Id, CAMPX__Village_Task__c> familySupportPlanIdToVillageTaskMap = new Map<Id, CAMPX__Village_Task__c>();

        // for (CAMPX__Village_Task__c villageTask : villageTaskList) {
        //     familySupportPlanIdToVillageTaskMap.put(villageTask.CAMPX__Family_Support_Plan__c, villageTask);
        // }

        // //This for loop allows us to check the family support plan priority while also determining if there is a related village task.
        // for (CAMPX__Family_Support_Plan__c familySupportPlan : familySupportPlanMap.values()) {
        //     System.debug(JSON.serializePretty(familySupportPlan));
        //     CAMPX__Village_Task__c relatedVillageTask = familySupportPlanIdToVillageTaskMap.get(familySupportPlan.Id);

        //     if (familySupportPlan.CAMPX__Priority__c == 'High' && relatedVillageTask != null) {
                
        //         familySupportPlan.addError('Cannot delete a high-priority plan that has related tasks. Please remove all tasks first.');
        //     }
        // }
    }
}