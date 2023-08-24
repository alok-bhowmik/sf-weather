@isTest
public class ConsumerAccountCreationTest 
{
    @isTest
    public static void ConsumerScheduledtest()  
    {  
        String schedule = '00 42 15 ? NOV *'; 
        String filter = 'Consumer Account(' + System.today().Month() + '/' + System.today().Year() + ')';
        
        Id recordTypeIdContact = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Consumer').getRecordTypeId();
        Id recordTypeIdAccount = Schema.SObjectType.Account.getRecordTypeInfosByName().get('consumer').getRecordTypeId();
        
        
        Account accountObj =  new Account(RecordTypeId=recordTypeIdaccount);
        accountObj.Name='Consumer Account(' + System.today().Month() + '/' + System.today().Year() + ')';    
       
        insert accountObj;
        
        
       
        Contact contactObj = new Contact(RecordTypeId=recordTypeIdcontact); 
        contactObj.AccountId=accountObj.Id;
        contactObj.LastName=accountObj.Name;
        insert contactObj;   
            
        List<Consumer_Contact__c> consumerList = new List<Consumer_Contact__c>(); 
      
        Consumer_Contact__c consumerObj = new  Consumer_Contact__c();
        consumerObj.Name=contactObj.LastName;
        consumerObj.Contact__c=contactObj.Id;
        consumerObj.Account__c = contactObj.AccountId;
       
        consumerList.add(consumerObj); 
        
        insert consumerList;
    
       
        
        Test.startTest();
        String jobId = System.schedule('ScheduleAccountTest',  schedule, new ConsumerAccountCreation());
        Consumer_ContactCreation consumer = new Consumer_ContactCreation();
        database.executeBatch(consumer);
        Test.stopTest();  
    }   
    
    
    @isTest
    public static void ConsumerScheduledtestNxt()  
    {  
        
        String schedule = '00 42 15 ? NOV *'; 
        String filter = 'Consumer Account(' + System.today().Month() + '/' + System.today().Year() + ')';
        
    /*  Id recordTypeIdcontact = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Consumer').getRecordTypeId();
        Id recordTypeIdaccount = Schema.SObjectType.Account.getRecordTypeInfosByName().get('consumer').getRecordTypeId();
        
        Account accountObj =  new Account(RecordTypeId=recordTypeIdaccount);
        accountObj.Name='Consumer Account(' + System.today().Month() + '/' + System.today().Year() + ')';    
       
        insert accountObj;
        
       
        Contact contactObj = new Contact(RecordTypeId=recordTypeIdcontact); 
        contactObj.AccountId=accountObj.Id;
        contactObj.LastName=accountObj.Name;
        insert contactObj;   
          
        
        List<Consumer_Contact__c> consumerList = new List<Consumer_Contact__c>(); 
      
        Consumer_Contact__c consumerObj = new  Consumer_Contact__c();
        consumerObj.Name=contactObj.LastName;
        consumerObj.Contact__c=contactObj.Id;
        consumerObj.Account__c = contactObj.AccountId;
       
        consumerList.add(consumerObj); 
        
        insert consumerList;
    */
       
        
        Test.startTest();
        String jobId = System.schedule('ScheduleAccountTest',  schedule, new ConsumerAccountCreation());
        Consumer_ContactCreation consumer = new Consumer_ContactCreation();
        database.executeBatch(consumer);
        Test.stopTest();  
    }   
   
    
    @isTest()
    public static void ConsumerScheduledtestNxtOne()  
    {  
        
        String schedule = '00 42 15 ? NOV *'; 
        String filter = 'Consumer Account(' + System.today().Month() + '/' + System.today().Year() + ')';
        
        Id recordTypeIdcontact = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Consumer').getRecordTypeId();
        Id recordTypeIdaccount = Schema.SObjectType.Account.getRecordTypeInfosByName().get('consumer').getRecordTypeId();
        
        Account accountObj =  new Account(RecordTypeId=recordTypeIdaccount);
        accountObj.Name='Consumer Account(' + System.today().Month() + '/' + System.today().Year() + ')';    
       
        insert accountObj;
        
       
        Contact contactObj = new Contact(RecordTypeId=recordTypeIdcontact); 
        contactObj.AccountId=accountObj.Id;
        contactObj.LastName=accountObj.Name;
        insert contactObj;   
        system.debug('contactobj.id -->'+ contactObj.Id);
          
       
     /*   List<Consumer_Contact__c> consumerList = new List<Consumer_Contact__c>(); 
      
        Consumer_Contact__c consumerObj = new  Consumer_Contact__c();
        consumerObj.Name=contactObj.LastName;
        consumerObj.Contact__c=contactObj.Id;
        consumerObj.Account__c = contactObj.AccountId;
       
        consumerList.add(consumerObj); 
        
        insert consumerList;
    
      */ 
        List<Consumer_contact__c> consumerContacts = [select id from consumer_contact__c where contact__c = : contactObj.Id];
        delete consumercontacts;
        
        
        Test.startTest();
        String jobId = System.schedule('ScheduleAccountTest',  schedule, new ConsumerAccountCreation());
        Consumer_ContactCreation consumer = new Consumer_ContactCreation();
        database.executeBatch(consumer);
        Test.stopTest();  
    }     
    
}