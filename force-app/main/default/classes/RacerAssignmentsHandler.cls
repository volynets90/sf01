public with sharing class RacerAssignmentsHandler {
    
    public static void onBeforeInsert(List<Racer_Position__c> onBeforeInsert) {
        RacerAssignmentsHelper.updateRacerPositionStatus(onBeforeInsert);
    }
    public static void onAfterUpdate(Map<Id, Racer_Position__c> onAfterUpdate){
        RacerPositionStatusHelper.updateRacerPositionStatus(onAfterUpdate);
        RacerExperienceOnTrackHelper.checkExperienceOnTrack(onAfterUpdate);
    }
}
