public with sharing class RacerStatusHelper {
    
    public static void updateRacerStatus(Map<Id, Racer__c> racers) {

        
        PermissionSetAssignment user = [ SELECT AssigneeId FROM PermissionSetAssignment WHERE PermissionSet.Name = 'Racer_Manager'];
        String notificationDevName='RacerStatusNotification';
        String msgTittle='Racer status';
        String msgBody='Racer status become not active: ';
        String recordUrl;
        Set<String> addressee = new Set<String>();
        addressee.add(user.AssigneeId);
        Messaging.CustomNotification notification = new Messaging.CustomNotification();
        CustomNotificationType notificationType = [ SELECT Id, DeveloperName FROM CustomNotificationType WHERE DeveloperName=:notificationDevName ];
        notification.setTitle(msgTittle);
        notification.setNotificationTypeId(notificationType.Id);
        notification.setTargetId(user.Id);

        for (Racer__c r : racers.values()) {
            if(!r.Racer_Status__c){
                recordUrl=URL.getSalesforceBaseUrl().toExternalForm()+'/'+r.Id;
                notification.setBody(msgBody+recordUrl);
                notification.send(addressee);

                //System.debug('My racers: '+r);
                //System.debug('My url val: '+recordUrl);
            }
            
        }
    }
}
