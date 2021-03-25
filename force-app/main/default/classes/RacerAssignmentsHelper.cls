public with sharing class RacerAssignmentsHelper {
    
    public static void updateRacerPositionStatus(List<Racer_Position__c> onBeforeInsert){
        
        String waitingListStatus = 'Waiting List';
        String notificationDevName='RacerStatusNotification';
        String msgTittle='Add racer to waiting list';
        String msgBody='One more racer added to Waiting List. Check: ';
        List <Racer_Position__c> listOfInsertedRacer = new List<Racer_Position__c>();
        List <Championship__c>  champs = [ SELECT Name, Championship_Capacity__c FROM Championship__c ];
        List <Racer_Position__c> listToInsert = new  List <Racer_Position__c>();

        //Preparing notification
        PermissionSetAssignment user = [ SELECT AssigneeId FROM PermissionSetAssignment WHERE PermissionSet.Name = 'Racer_Manager'];
        Set<String> addressee = new Set<String>();
        addressee.add(user.AssigneeId);
        Messaging.CustomNotification notification = new Messaging.CustomNotification();
        CustomNotificationType notificationType = [ SELECT Id, DeveloperName FROM CustomNotificationType WHERE DeveloperName=:notificationDevName ];
        notification.setTitle(msgTittle);
        notification.setNotificationTypeId(notificationType.Id);
        notification.setTargetId(user.Id);
        
        //Prepare Map with Racers for each Championatship
        Map <Championship__c, List <Racer_Position__c>> howMuchRacersInChamp = new Map <Championship__c, List <Racer_Position__c>>();
        for (Championship__c c : champs) {
            List<Racer_Position__c> racers = new List<Racer_Position__c>();
            for (Racer_Position__c r : [ SELECT Name, Championship__c  FROM Racer_Position__c ]) {
                if (c.Id==r.Championship__c) {
                    racers.add(r);
                }
            }
            howMuchRacersInChamp.put(c, racers);
        }
       
        
        //Compare Map with Racers and new Racer
        for(Racer_Position__c r:onBeforeInsert){
           for (Championship__c c : champs) {
           
                if (r.Championship__c==c.Id && howMuchRacersInChamp.get(c).size()+1>c.Championship_Capacity__c) {

                    r.Status__c = waitingListStatus;
                    listToInsert.add(r);
                    msgBody+=r.Name;
                    notification.setBody(msgBody);
                    notification.send(addressee);
                }
           }
        }

        if (listToInsert.size() > 0) {

            //insert listToInsert; 
        }     
        
    }
}