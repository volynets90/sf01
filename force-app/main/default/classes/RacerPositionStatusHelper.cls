public with sharing class RacerPositionStatusHelper {
    
    public static void updateRacerPositionStatus(Map<Id, Racer_Position__c> racers) {
        
        String checkingStatus = 'Rejected';
        String serchingStatus = 'Waiting List';
       
        List <Racer_Position__c>  racersInWaiting = [ SELECT Name, Championship__c, Creation_Date__c FROM Racer_Position__c WHERE Status__c=:serchingStatus ORDER BY Creation_Date__c];
        List <Championship__c>  champs = [ SELECT Name, Championship_Capacity__c FROM Championship__c ];

        List<Racer_Position__c> rejectedRacers = new List<Racer_Position__c>();

        Map <Championship__c, List <Racer_Position__c>> howMuchRacersInChamp = new Map <Championship__c, List <Racer_Position__c>>();
        for (Championship__c c : champs) {
            List<Racer_Position__c> listOfRacers = new List<Racer_Position__c>();
            for (Racer_Position__c r : [ SELECT Name, Championship__c  FROM Racer_Position__c ]) {
                if (c.Id==r.Championship__c) {
                    listOfRacers.add(r);
                }
            }
            howMuchRacersInChamp.put(c, listOfRacers);
        }
        //System.debug('In wait: ' + racersInWaiting);

        List <Racer_Position__c> forUpdate = new List<Racer_Position__c>();
        
        for (Racer_Position__c waitingRacer : racersInWaiting) {
            for (Racer_Position__c rejected : racers.values()) {
                if(rejected.Status__c==checkingStatus && rejected.Championship__c==waitingRacer.Championship__c){
                    for (Championship__c c : champs) {
                        if(howMuchRacersInChamp.get(c).size()+1>c.Championship_Capacity__c){
                            waitingRacer.Status__c='Approved';
                            forUpdate.add(waitingRacer);
                            System.debug('RW '+ waitingRacer.Name);
                        }
                    }
                }
            }
        }
        update forUpdate;        
    }
    
}
 