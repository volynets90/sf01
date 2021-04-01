public with sharing class ListController {
    
    @AuraEnabled(cacheable=true)
    public static String  getRacerPosition(Decimal filterYear) {
       system.debug(filterYear+' -value');
       List<Racer_Position__c> racersPos = new List<Racer_Position__c>();
       
       if(filterYear==null){
            
            racersPos = [ SELECT  Name, Championship__r.Name, Championship__r.Championship_Date__c, 
            Racer__r.Name, Racer__r.Years_in_Racing__c, Status__c, Starting_position__c  
            FROM Racer_Position__c];
       }
       else{
            racersPos = [ SELECT  Name, Championship__r.Name, Championship__r.Championship_Date__c, 
            Racer__r.Name, Racer__r.Years_in_Racing__c, Status__c, Starting_position__c  
            FROM Racer_Position__c WHERE Racer__r.Years_in_Racing__c=:filterYear ];
       }
       /*List<Racer_Position__c> racersPos = [ SELECT  Name, Championship__r.Name, Championship__r.Championship_Date__c, 
       Racer__r.Name, Racer__r.Years_in_Racing__c, Status__c, Starting_position__c  
       FROM Racer_Position__c WHERE Racer__r.Years_in_Racing__c=:filterYear ];*/
        
        List<ListCommonObject> finalList = new List<ListCommonObject>();
        //finalList.clear();
        for (Racer_Position__c r : racersPos) {
       
            ListCommonObject lh = new ListCommonObject();
            lh.championatName=r.Championship__r.Name;
            lh.racerName=r.Racer__r.Name;
            lh.status=r.Status__c;
            lh.champDate=r.Championship__r.Championship_Date__c;
            lh.yearsInRacing = r.Racer__r.Years_in_Racing__c;
            finalList.add(lh);
        }
        
        system.debug(finalList);
        return JSON.serialize(finalList);
    }
}
