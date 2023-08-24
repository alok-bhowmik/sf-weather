public class Demo implements Database.Batchable<Sobject>
{

     //public String query;
        public Database.queryLocator start(Database.BatchableContext bc)
        {
            system.debug('inside start');
            String query = 'Select Id,Name,RecordType.Name FROM Account' ;
            return Database.getQueryLocator([Select  Id,Name FROM Account where RecordTypeId in (SELECT Id FROM RecordType WHERE Name = 'consumer') limit 1]);
        }
    
    
    
        public void execute(Database.BatchableContext bc, List<Account> accListFromStartMethod)
        {
            
            system.debug('inside execute'); 
            List<Account> newList = new List<Account>();
            for(Account acc : accListFromStartMethod) 
            {
                system.debug('inside for');
                System.debug('inside if ==>' + !acc.Name.contains('Consumer Account(' + System.today().Month() + '/' + System.today().Year() + ')'));

                
               if(!acc.Name.contains('Consumer Account(' + System.today().Month() + '/' + System.today().Year() + ')'))
               {
                   //system.debug('acc.Name==>'+acc.Name);
                    Account accObj = new Account(Name='Consumer Account(' + System.today().Month() + '/' + System.today().Year() + ')');
                    newList.add(accObj);
                    System.debug('Consumer Account'+newList);
                
               }
                insert newList;
            }
            
        } 
      
         public void finish(Database.BatchableContext bc)
         {
             //ScheduleContacts schedule = new ScheduleContacts();
             //database.executeBatch(schedule);
         }
}