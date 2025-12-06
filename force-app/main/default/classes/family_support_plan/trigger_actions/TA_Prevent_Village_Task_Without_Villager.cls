public with sharing class TA_Prevent_Village_Task_Without_Villager implements TriggerAction.BeforeUpdate, TriggerAction.BeforeInsert {

    private static final String COMPLETED_STATUS = 'Completed';
    
    public void beforeInsert(List<CAMPX__Village_Task__c> triggerNew) {
        
        evaluateTaskForCompletedStatusAndAssignedCharacter(triggerNew);
    }
    
    public void beforeUpdate(List<CAMPX__Village_Task__c> triggerNew, List<CAMPX__Village_Task__c> triggerOld) {
        
        evaluateTaskForCompletedStatusAndAssignedCharacter(triggerNew);
    }

    @TestVisible
    private void evaluateTaskForCompletedStatusAndAssignedCharacter(List<CAMPX__Village_Task__c> listOfTasksToEvaluate) {
        
        for (CAMPX__Village_Task__c task : listOfTasksToEvaluate) {
            if (task.CAMPX__Status__c == COMPLETED_STATUS && String.isBlank(task.CAMPX__Assigned_Character__c)) {
                task.addError('Cannot complete a task without assigning it to a villager first.');
            }
        }
    }
}