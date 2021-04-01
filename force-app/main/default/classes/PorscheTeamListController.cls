public with sharing class PorscheTeamListController {
    @AuraEnabled(cacheable=true)
    public static String getRacersByRecordType(String recordType) {

        List<Racer_Position__c> racersPos =  [ SELECT  Name, Championship__r.Name, Championship__r.Championship_Date__c, 
            Racer__r.Name, Racer__r.Years_in_Racing__c, Status__c, Starting_position__c  
            FROM Racer_Position__c WHERE Racer__r.RecordTypeId=:recordType];
        
        List<ListCommonObject> finalList = new List<ListCommonObject>();
        for (Racer_Position__c r : racersPos) {
       
            ListCommonObject lh = new ListCommonObject();
            lh.championatName=r.Championship__r.Name;
            lh.racerName=r.Racer__r.Name;
            lh.status=r.Status__c;
            lh.champDate=r.Championship__r.Championship_Date__c;
            lh.yearsInRacing = r.Racer__r.Years_in_Racing__c;
            lh.startPosition=r.Starting_Position__c;
            finalList.add(lh);
        }
        
        //system.debug(finalList);
        system.debug(JSON.serialize(racersPos));
        system.debug(racersPos+' RPOS');
        return JSON.serialize(finalList);
    }
}
