trigger RacerStatusTrigger on Racer__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
  
    if(Trigger.isAfter){
        if(Trigger.isInsert || Trigger.isUpdate){
            RacerStatusHandler.onAfterInsertOrUpdate(Trigger.newMap);
        }
    }
}