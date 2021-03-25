public with sharing class RacerStatusHandler {

    public static void onAfterInsertOrUpdate(Map<Id, Racer__c> onAfterInserOrUpdate) {
       
        RacerStatusHelper.updateRacerStatus(onAfterInserOrUpdate);

    }
}
