trigger RacerStatusTrigger on Racer__c (before insert, after update) {
    for(Racer__c r : Trigger.New) {
        if(!r.Racer_Status__c){
            System.debug('False operation');
            CustomNotificationType notificationType = 
            [SELECT Id, DeveloperName 
             FROM CustomNotificationType 
             WHERE DeveloperName='Custom_Notification'];
            Messaging.CustomNotification notification = new Messaging.CustomNotification();
           
            // Set the contents for the notification
            notification.setTitle('Apex Custom Notification');
            notification.setBody('The notifications are coming from INSIDE the Apex!');
    
            // Set the notification type and target
            notification.setNotificationTypeId(notificationType.Id);
            //notification.setTargetId(targetId);
            Set<String> addressee = new Set<String>();
            addressee.add('cv1@dsv.com');
            // Actually send the notification
            try {
                notification.send(addressee);
            }
            catch (Exception e) {
                System.debug('Problem sending notification: ' + e.getMessage());
            }
        }
    }   
}