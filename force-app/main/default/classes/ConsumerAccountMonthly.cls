public class ConsumerAccountMonthly implements Database.Batchable<Sobject>
{
     //public String query;
        public Database.queryLocator start(Database.BatchableContext bc)
        {
            system.debug('inside start');
            String query = 'Select Id,Name,RecordType.Name FROM Account' ;
            return Database.getQueryLocator(query);
        }
    
    
    
        public void execute(Database.BatchableContext bc, List<Account> accListFromStartMethod)
        {
            String filterdate = System.today().Month() + '/' + System.today().Year();
            system.debug('inside execute');
            List<Account> filter = [Select  Id,Name FROM Account where RecordTypeId in (SELECT Id FROM RecordType WHERE Name = 'consumer')] ;
            List<Account> newList = new List<Account>();
            for(Account eachList : filter)
            {
                system.debug('inside for');
                if(!eachList.Name.contains('('))
                {
                    system.debug('inside if');
                    eachList.Name = eachList.Name +'(' +(System.today().Month() + '/' + System.today().Year())+')';
                    newList.add(eachlist);
                    
                }
            }
            update newList;
            for(Account acc : accListFromStartMethod)
            {
            
            for(Account eachElement : newList )
            {
                if(acc.Name != eachElement.Name)
                {
                    acc.Name = acc.Name + 'Parent';
                }
            }
            }
        }
      
         public void finish(Database.BatchableContext bc)
         {
        
         }
}