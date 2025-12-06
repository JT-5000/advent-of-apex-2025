public with sharing class TA_Update_Village_Task_Support_Phase implements TriggerAction.AfterUpdate {
    
    public static void afterUpdate(List<CAMPX__Family_Support_Plan__c> triggerNew, List<CAMPX__Family_Support_Plan__c> triggerOld) {

        Map<Id, CAMPX__Family_Support_Plan__c> idToFamilySupportPlan = new Map<Id, CAMPX__Family_Support_Plan__c>(triggerOld);

        Set<Id> newSupportPlanIdSet = new Set<Id>();

        //::::This section checks to see if the phase has changed by comparing the old and new versions of the family support plan.:::://
        for (CAMPX__Family_Support_Plan__c newSupportPlan : triggerNew) {
            CAMPX__Family_Support_Plan__c oldSupportPlan = idToFamilySupportPlan.get(newSupportPlan.Id);

            if (newSupportPlan.CAMPX__Phase__c != oldSupportPlan.CAMPX__Phase__c) {
                newSupportPlanIdSet.add(newSupportPlan.Id);
            }
        }

        //::::This section gets all village tasks that have a parent family support plan where the phase has been changed and the Id is in our new newSupportPlanIdSet.:::://
        List<CAMPX__Village_Task__c> villageTaskToUpdateList = [    SELECT Id, CAMPX__Support_Phase__c, CAMPX__Family_Support_Plan__r.CAMPX__Phase__c
                                                                    FROM CAMPX__Village_Task__c
                                                                    WHERE CAMPX__Family_Support_Plan__r.Id IN :newSupportPlanIdSet ];

        for (CAMPX__Village_Task__c taskToUpdate : villageTaskToUpdateList) {
            taskToUpdate.CAMPX__Support_Phase__c = taskToUpdate.CAMPX__Family_Support_Plan__r.CAMPX__Phase__c;
        }

        if (!villageTaskToUpdateList.isEmpty()) {
            Database.update(villageTaskToUpdateList, false);
        }   
    }
}