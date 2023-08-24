/* Quering the Contact With this month and with Record Type Name as Consumer and checking  where the consumer contact is related to the records if not create a 
   consumer contact record for the query*/


public class Consumer_ContactCreation implements Database.Batchable<Sobject>
{
    
        public Database.queryLocator start(Database.BatchableContext bc)
        {
            system.debug('inside start');
            Id recordId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Consumer').getRecordTypeId();
            return Database.getQueryLocator([Select Id,RecordTypeId, accountId ,LastName from Contact where RecordTypeId=:recordId And CreatedDate=THIS_MONTH]);
           
         }
    
    
         public void execute(Database.BatchableContext bc, List<Contact> contactListFromStartMethod)
         {
             system.debug('inside execute'+contactListFromStartMethod);
             
             List<Consumer_Contact__c> conList= new List<Consumer_Contact__c>();
             
             // Checking whether the realted record is present or not 
             for(Contact conObj : [Select Id,AccountId,LastName,RecordTypeId,(Select Id,Name,Account__c,Contact__c  from Consumer_Contacts__r ) from Contact where RecordType.Name='Consumer' AND CreatedDate=THIS_MONTH and id in :  contactListFromStartMethod ])
             {
                 system.debug('conObj.Id ->'+ conObj.Id);
                 if(!(conObj.Consumer_Contacts__r.size() > 0))
                 {
                     Consumer_Contact__c consumerObj = new Consumer_Contact__c();
                     
                     consumerObj.Contact__c =conObj.Id;
                     consumerObj.Account__c=conObj.AccountId;
                     consumerObj.Name=conObj.LastName;
                     
                     system.debug('consumerObj==>' +consumerObj);
                     
                     conList.add(consumerObj); 
                 }
              }
             
             insert conList;
             
             system.debug('conList==>' +conList);
         
         }
    
    
         public void finish(Database.BatchableContext bc)
         {
             system.debug('Finish==>' +bc);
         }
    
}