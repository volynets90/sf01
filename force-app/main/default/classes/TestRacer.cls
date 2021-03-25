@istest
public class TestRacer {
    @istest public static void TestRacer() {

        //Racer_Position__c r = new Racer_Position__c(Name='Jihn', Championship__c='Test Champ', Racer__c='Afony Men',Starting_Position__c=2);
        //Racer_Position__c r = new Racer_Position__c();
        List <Racer_Position__c> testList = new List<Racer_Position__c>();
        for (Integer i=0; i<220; i++) {
            Racer_Position__c r = new Racer_Position__c(Name='TestC'+i, Championship__c='a001j000007Qg5WAAS', Racer__c='a041j00000DNie8AAD',Starting_Position__c=12);
            testList.add(r);
        }
        Test.startTest();
        insert testList;
        Test.stopTest();
        //System.assert(!result.isSuccess());
        //System.assert(result.getErrors().size() > 0);
    }
  
}
/*@isTest
public class TestShareTerr {
  static testMethod void testShareTerritories() {
    // Principle #1: Create records from scratch!
    
    // Insert 20 Users
    List<User> users = new List<User>();
    for (Integer i = 0; i < 20; i++) {
      User u = new User();
      u.FirstName         = 'Elsa';
      u.LastName          = 'of Arendelle';
      u.Email             = 'elsa@disney.com';
      u.Alias             = 'elsa' + i;
      u.Username          = 'elsa' + i + '@disney.com';
      u.LocaleSidKey      = 'en_US';
      u.TimeZoneSidKey    = 'GMT';
      u.ProfileID         = '00ei0000000rTfz';
      u.LanguageLocaleKey = 'en_US';
      u.EmailEncodingKey  = 'UTF-8';
      users.add(u);
    }
    insert users;
    
    // Insert 200 Territories
    List<Territory__c> terrs = new List<Territory__c>();
    for (Integer i = 0; i < 200; i++) {
      Territory__c t = new Territory__c();
      t.Zip_Code__c  = String.valueOf(1000 + i);
      terrs.add(t);
    }
    insert terrs;
    
    // Insert up to 20 Members per Territory
    List<Territory_Member__c> tms = 
        new List<Territory_Member__c>();
    for (Integer i = 0; i < 200; i++) {
      // Here we "cast", aka transform the Double into an Integer
      Integer count = Integer.valueOf(Math.random() * 20);
      for (Integer j = 0; j < count; j++) {
        Territory_Member__c tm = new Territory_Member__c();
        tm.Territory__c        = terrs[i].Id;
        tm.User__c             = users[j].Id;
        tms.add(tm);
      }
    }
    insert tms;
    
    // "Setup" data has been entered, begin testing
    // This trick gives us a new set of Governor Limits!
    Test.startTest();
    
    // Principle #4: Test in bulk (200+ records)!
    
    // Test #1: 200 new Accounts with Zip Codes
    List<Account> accs = new List<Account>();
    for (Integer i = 0; i < 200; i++) {
      Account a           = new Account();
      a.Name              = 'Disney';      
      String zip          = String.valueOf(1000 + i);
      a.BillingPostalCode = zip;
      accs.add(a);
    }
    insert accs;
    
    // Principle #2: Assert your results!
    
    // Get all Accounts and their AccountShares
    accs = [SELECT Id, BillingPostalCode,
           (SELECT Id, AccountId,
                   AccountAccessLevel,
                   OpportunityAccessLevel,
                   UserOrGroupId
              FROM Shares
             WHERE RowCause = 'Manual')
              FROM Account];
                            
    // Create a Map of all Territories and their Members                        
    Map<String, Territory__c> terrMap = 
        new Map<String, Territory__c>();                        
    terrs = [SELECT Id, Zip_Code__c,
            (SELECT Id, User__c
               FROM Territory_Members__r)
               FROM Territory__c];
    for (Territory__c t : terrs) {
      terrMap.put(t.Zip_Code__c, t);
    }                                       
    
    // Assert each Account has the right AccountShare count
    for (Account a : accs) {
      Territory__c t      = terrMap.get(a.BillingPostalCode);
      Integer shareCount  = a.Shares.size();
      Integer memberCount = t.Territory_Members__r.size();
      System.assertEquals(shareCount, memberCount);
    }               
    
    // Principle #3: Test things that shouldn't work!
    
    // Test #2: 200 updated Accounts without Zip Codes
    for (Account a : accs) {
      a.BillingPostalCode = null;
    }
    update accs;
    
    // Assert that each Account has no Account Shares!
    accs = [SELECT Id, BillingPostalCode,
           (SELECT Id, AccountId,
                   AccountAccessLevel,
                   OpportunityAccessLevel,
                   UserOrGroupId
              FROM Shares
             WHERE RowCause = 'Manual')
              FROM Account];    
    for (Account a : accs) {
      Integer shareCount = a.Shares.size();
      System.assertEquals(0, shareCount);
    }                                
                            
    // Test #3: 200 updated Accounts with Zip Codes
    for (Integer i = 0; i < 200; i++) {
      String zip = String.valueOf(1000 + i);
      accs[i].BillingPostalCode = zip; 
    }
    update accs;
    
    // Assert each Account has the right AccountShare count
    accs = [SELECT Id, BillingPostalCode,
           (SELECT Id, AccountId,
                   AccountAccessLevel,
                   OpportunityAccessLevel,
                   UserOrGroupId
              FROM Shares
             WHERE RowCause = 'Manual')
              FROM Account];
    for (Account a : accs) {
      Territory__c t      = terrMap.get(a.BillingPostalCode);
      Integer shareCount  = a.Shares.size();
      Integer memberCount = t.Territory_Members__r.size();
      System.assertEquals(shareCount, memberCount);
    }                                      
    
    Test.stopTest();
  }
}*/