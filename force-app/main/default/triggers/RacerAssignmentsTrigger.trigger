trigger RacerAssignmentsTrigger on Racer_Position__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {

    if(Trigger.isBefore){
        if(Trigger.isInsert){
            RacerAssignmentsHandler.onBeforeInsert(Trigger.new);
        }
    }
    if(Trigger.isAfter){
        if(Trigger.isUpdate || Trigger.isInsert){
            RacerAssignmentsHandler.onAfterUpdate(Trigger.newMap);
        }
    }
}