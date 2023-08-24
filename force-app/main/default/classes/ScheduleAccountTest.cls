@isTest
public class ScheduleAccountTest
{
   @isTest 
    public static void ConsumerScheduledtest()  
    {  
        String schedule = '00 42 15 ? NOV *'; 
        String filter = 'Consumer Account(' + System.today().Month() + '/' + System.today().Year() + ')';
        List<Account> newList = new List<Account>();
        
        Id recordIdcontact = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Consumer').getRecordTypeId();
        Id RecordIdaccount = Schema.SObjectType.Account.getRecordTypeInfosByName().get('consumer').getRecordTypeId();
        
        Account accObj =  new Account(RecordTypeId=RecordIdaccount);
        accObj.Name='Consumer Account(' + System.today().Month() + '/' + System.today().Year() + ')'; 
        insert accObj;
        
        
        Contact conObj = new Contact(RecordTypeId=recordIdcontact); 
        conObj.AccountId=accObj.Id;
        conObj.LastName=accObj.Name;
        insert conObj;   
            
        List<Consumer_Contact__c> consumerList = new List<Consumer_Contact__c>(); 
      
        Consumer_Contact__c consumerObj = new  Consumer_Contact__c();
        consumerObj.Name=conObj.LastName;
        consumerObj.Contact__c=conObj.Id;
        consumerObj.Account__c = conObj.AccountId;
       
        consumerList.add(consumerObj); 
        
        insert consumerList;
    
       
        
        Test.startTest();
        String jobId = System.schedule('ScheduleAccountTest',  schedule, new ConsumerAccountCreation());
        
        Consumer_ContactCreation consumer = new Consumer_ContactCreation();
        database.executeBatch(consumer);
        
        Test.stopTest();  
    }     
    
    
   
}