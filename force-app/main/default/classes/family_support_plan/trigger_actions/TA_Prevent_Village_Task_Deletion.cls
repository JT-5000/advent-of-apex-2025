public with sharing class TA_Prevent_Village_Task_Deletion implements TriggerAction.BeforeDelete {
    
    public void beforeDelete(List<CAMPX__Village_Task__c> triggerOld) {
        
        for (CAMPX__Village_Task__c task : triggerOld) {

            if (task.CAMPX__Is_Baby_Safety_Critical__c && task.CAMPX__Status__c != 'Completed') {
                task.addError('Cannot delete safety-critical tasks that are not completed. Please complete the task first or contact your administrator.');
            }
        }
    }
}