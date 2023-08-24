public class ConsumerContactClass implements Database.Batchable<Sobject>
{
     public Database.queryLocator start(Database.BatchableContext bc)
        {
            system.debug('inside start');
            return Database.getQueryLocator([Select Id,RecordTypeId, accountId ,LastName from Contact where RecordType.Name = 'Consumer' And CreatedDate=THIS_MONTH]);
           
        }
    
    
         public void execute(Database.BatchableContext bc, List<Contact> conListFromStartMethod)
         {
            system.debug('inside execute'+conListFromStartMethod);
            
            //List<Consumer_Contact__c> consumerconList = [Select Name,Account__c,Contact__c from Consumer_Contact__c where contact__r.RecordType.Name='Consumer'  And CreatedDate=THIS_MONTH and Id IN : contactIdSet];
        
            // List<Contact> conList =[Select Id,RecordTypeId, accountId ,LastName from Contact where RecordType.Name = 'Consumer' And CreatedDate=THIS_MONTH];

             
        Set<Id> contactIdSet = new Set<Id>();
             
        for(Contact conObj : conListFromStartMethod)
        {
            if(conObj.Id!=null)
            {
                contactIdSet.add(conObj.Id);  
            }
        }
         
             
        List<Consumer_Contact__c> consumerconList = [Select Name,Account__c,Contact__c from Consumer_Contact__c where contact__r.RecordType.Name='Consumer'  And CreatedDate=THIS_MONTH and Consumer_Contact__c.Contact__c IN : contactIdSet];
        
        List<Consumer_Contact__c> consumerList=new list<Consumer_Contact__c>();
             
        Id recordId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Consumer').getRecordTypeId(); 
             
             for(Contact con : conListFromStartMethod)
             {
                
              if(consumerconList==null)
                {
                  

                    System.debug('isempty');
                     Consumer_Contact__c consumerObj= new  Consumer_Contact__c();
                    
                     system.debug('inside for' +consumerObj);
                    
                     consumerObj.Name=con.LastName;
                     consumerObj.Contact__c=con.Id;
                     consumerObj.Account__c = con.AccountId;
                    
                     system.debug('inside');
                    
                     consumerList.add(consumerObj);
                    
                     system.debug('Consumer Contact'+consumerObj);
                    
                   }
         }
             insert consumerList;
  

                
                //if(consumerList.size()>0)
                //{
                   
                  // system.debug('ConsumerList' +consumerList);
                //}
         }
    
         public void finish(Database.BatchableContext bc)
         {
             
         }
}