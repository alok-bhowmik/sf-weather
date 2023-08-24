public class ContactDemo12345678 implements Database.Batchable<Sobject> {

     public Database.queryLocator start(Database.BatchableContext bc)
        {
            system.debug('inside start');
            List<Consumer_Contact__c> cons= new  List<Consumer_Contact__c>();
            List<Contact> newList = new List<Contact>();
            Integer this_month=Date.today().month();
            return Database.getQueryLocator([Select Id from Contact where RecordType.Name = 'Consumer' And CreatedDate=this_month Limit 1]);
            //return Database.getQueryLocator([Select AccountId From Contact where RecordTypeId in (SELECT Id FROM RecordType WHERE Name = 'consumer')]);
            
        }
    
    
         public void execute(Database.BatchableContext bc, List<Consumer_Contact__c> conListFromStartMethod)
        {
            system.debug('inside execute'+conListFromStartMethod);
            List<Contact> newList = new List<Contact>();
            List<Consumer_Contact__c> consumerList=new list<Consumer_Contact__c>();
           
            for(Consumer_Contact__c con : conListFromStartMethod)
            {
                system.debug('inside for==>'+con);
                //List<Consumer_Contact__c> conss= new  List<Consumer_Contact__c>();
                      
                      List<Contact> conList = [Select Id from Contact where RecordType.Name = 'Consumer' And CreatedDate=this_month];
                      List<Consumer_Contact__c> cons = [Select Name,Contact__c  from Consumer_Contact__c ];
                
                for(Consumer_Contact__c consumer : cons)
                {
                    system.debug('inside for===>' +consumer); 
                    system.debug('consumer.contact__c ->'+ consumer.contact__c);
                    system.debug('consumer.name ->'+ consumer.Name);
                    Boolean temp = String.valueOf(consumer.Contact__c) <> String.valueOf(consumer.Name);
                    system.debug('test');
                    system.debug('con.AccountId != consumer.Name==> test '+ temp);
                    
                   if(String.valueOf(consumer.Contact__c) != String.valueOf(consumer.Name))
                   {  
                       system.debug('inside if');
                       Consumer_Contact__c conObj = new Consumer_Contact__c(Name='Consumer Account(' + System.today().Month() + '/' + System.today().Year() + ')');
                       consumerList.add(conObj);
                       insert consumerList;
                     
                       //Account accObj= new  Account();
                       //List<Account> accList = new List<Account>();
                       //Account accObj = [Select Id from Account where Name='Consumer Account(' ];
                       //accObj.Id = conObj.Name;
                    
                   }
                    
                   else 
                   {
                       system.debug('in else');
                   } 
                }
            }
         }           
    
    
         public void finish(Database.BatchableContext bc)
         {
               
         }
}