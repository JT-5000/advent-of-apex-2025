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
    }
}