public with sharing class RacerExperienceOnTrackHelper {
    public static void checkExperienceOnTrack(Map<Id, Racer_Position__c> racers) {
        List <Racer_Position__c> allRacers =  [ SELECT Name, Racer__c, Championship__c, Creation_Date__c FROM Racer_Position__c ];
        List <Championship__c>  champs = [ SELECT Name, Track__c, Championship_Capacity__c FROM Championship__c ];
        List<Racer_Position__c> forUpdate = new List<Racer_Position__c>();

        Map <String, Racer_Position__c> trackRacer = new Map <String, Racer_Position__c>();
        Map <String, Racer_Position__c> incomingTackRacer = new Map <String, Racer_Position__c>();

        for (Championship__c c : champs) {
            for (Racer_Position__c r : allRacers) {
                if(c.Id==r.Championship__c){
                    //System.debug('Racer: '+r);
                    trackRacer.put(c.Track__c, r);
                }
                
            }
        }
        
        //System.debug('TRACK:'+trackRacer);
        for (Racer_Position__c r : racers.values()) {
            for (Championship__c c : champs) {
                if(c.Id==r.Championship__c){
                    incomingTackRacer.put(c.Track__c, r);
                }
            }
        }
       
        for (String r : incomingTackRacer.keySet()) {
            for (String r2 : trackRacer.keySet()) {
                if (r==r2) {
                    System.debug('Inc '+incomingTackRacer.get(r));
                    Racer_Position__c updRacer=incomingTackRacer.get(r);
                    updRacer.Experience_in_championship_track__c=true;
                    forUpdate.add(updRacer);
             
                }
            }
        }
   
        update forUpdate;
    }
}
