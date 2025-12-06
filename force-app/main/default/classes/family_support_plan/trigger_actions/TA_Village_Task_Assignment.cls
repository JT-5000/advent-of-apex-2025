public with sharing class TA_Village_Task_Assignment implements TriggerAction.beforeInsert {

    public void beforeInsert(List<CAMPX__Village_Task__c> triggerNew) {

        for (CAMPX__Village_Task__c task : triggerNew) {
            
            if (task.CAMPX__Task_Type__c != null && task.CAMPX__Assigned_Character__c == null) {

                switch on task.CAMPX__Task_Type__c {
                    when 'Cook / Deliver Meal' {
                        task.CAMPX__Assigned_Character__c = 'Ginger Claus';
                    }
                    when 'Build / Fix' {
                        task.CAMPX__Assigned_Character__c = 'Stella Pinewood';
                    }
                    when 'Health & Safety Check' {
                        task.CAMPX__Assigned_Character__c = 'Dr. Grace Evergreen';
                    }
                    when 'Decorate' {
                        task.CAMPX__Assigned_Character__c = 'Poppy Wintergold';
                    }
                    when 'Garden / Outdoor' {
                        task.CAMPX__Assigned_Character__c = 'Ivy Evergreen';
                    }
                    when else {
                        task.CAMPX__Assigned_Character__c = '';
                    }
                }
            }
        }
    }
}