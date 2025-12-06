trigger VillageTaskTrigger on CAMPX__Village_Task__c (
        before insert,
        after insert,
        before update,
        after update,
        before delete,
        after delete,
        after undelete
) {
        new MetadataTriggerHandler().run();
}