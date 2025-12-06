public with sharing class TA_Auto_Set_Village_Task_Due_Date implements TriggerAction.BeforeInsert {
    
    public void beforeInsert(List<CAMPX__Village_Task__c> triggerNew) {

        for (CAMPX__Village_Task__c task : triggerNew) {
            if (task.CAMPX__Support_Phase__c == 'Before Baby Arrives' && task.CAMPX__Due_Date__c == null) {
                task.CAMPX__Due_Date__c = Date.today().addDays(14);
            }
        }
    }
}