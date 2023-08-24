public class demoConsumer implements Database.Batchable<Sobject>
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
             
           
          
             
             for(Contact conObj : [Select Id,AccountId,LastName,RecordTypeId,(Select Id,Name,Account__c,Contact__c  from Consumer_Contacts__r ) from Contact where RecordType.Name='Consumer' AND CreatedDate=THIS_MONTH and id in :  contactListFromStartMethod ])
             {
                 if(!(conObj.Consumer_Contacts__r.size() > 0)){
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
             
             
             
        /*    //List<Consumer_Contact__c> consumercontactList = [Select Name,Account__c,Contact__c from Consumer_Contact__c where contact__r.RecordType.Name='Consumer'  And CreatedDate=THIS_MONTH and Id IN : duplicateMap.keyset()];
            //system.debug('consumercontactList' +consumercontactList);
             List<Consumer_Contact__c> conList= new List<Consumer_Contact__c>();
             
             
             system.debug('consumercontactList.isempty()' +consumercontactList.isempty());
             if(!consumercontactList.isempty())
             {
                 for(Consumer_Contact__c consumer : consumercontactList)
                 {
                     //system.debug('consumer' +consumer);
                     system.debug('duplicateMap.containskey(consumer.id)' +duplicateMap.containskey(consumer.id));
                     if(duplicateMap.containskey(consumer.id))
                     {
                         Consumer_Contact__c  consumerObj = new Consumer_Contact__c(Name='Consumer');
                         insert consumerObj;
                         
                     }
                 }
             }
     */             
             
         
         
         }
    
    
    
    
    public void finish(Database.BatchableContext bc)
         {
             system.debug('Finish==>' +bc);
         }
    
}