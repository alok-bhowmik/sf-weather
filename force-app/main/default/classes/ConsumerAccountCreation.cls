/* Create a Consumer Account if not present on 6th of every month at 10AM With record type as Consumer */



public class ConsumerAccountCreation  implements Schedulable 
{
    
      public void execute(SchedulableContext sc)
      {
          String Filter = 'Consumer Account(' + System.today().Month() + '/' + System.today().Year() + ')';
          
          List<Account> accountList = [Select  Id,Name FROM Account where  Name=:Filter and  recordtype.name = 'consumer'];
        
          system.debug('accountList==>' + accountList);         

          Id RecordId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('consumer').getRecordTypeId();
        
          Integer currentMonth = Date.today().month();
          
          // Checking the List is empty and creating the record with Name Consumer Account(With Current Month)
          
          
          if(accountList.isempty())
          {
            
              system.debug('printing statement');
              
              Account accountObj = new Account(Name='Consumer Account(' + System.today().Month() + '/' + System.today().Year() + ')',RecordTypeId=RecordId );
              insert accountObj;
              
              System.debug('insert -->' +accountObj); 
        
          }
          
        
          // Calling the Batch Apex Class
          
          Consumer_ContactCreation s = new Consumer_ContactCreation();
          database.executeBatch(s);
        
        
      }
    
    
    
}