public class ConsumerAccount implements Database.Batchable<Sobject>
{
     //public String query;
        public Database.queryLocator start(Database.BatchableContext bc)
        {
            system.debug('inside start');
            String query = 'Select Id,Name,RecordType.Name FROM Account' ;
            return Database.getQueryLocator([Select  Id,Name FROM Account where RecordTypeId in (SELECT Id FROM RecordType WHERE Name = 'consumer')]);
        }
    
    
    
        public void execute(Database.BatchableContext bc, List<Account> accListFromStartMethod)
        {
            //String filterdate = System.today().Month() + '/' + System.today().Year();
            system.debug('inside execute');
            //List<Account> filter = [Select  Id,Name FROM Account where RecordTypeId in (SELECT Id FROM RecordType WHERE Name = 'consumer')] ;
            List<Account> newList = new List<Account>();
            //system.debug('inside for');
            for(Account eachList : accListFromStartMethod)
            {
                //system.debug('inside for');
                if(!eachList.Name.contains('('))
                {
                    system.debug('inside if');
                    //eachList.Name = eachList.Name +'(' +(System.today().Month() + '/' + System.today().Year())+')';
                    eachList.Name = 'Consumer Account(' + System.today().Month() + '/' + System.today().Year() + ')';
                    //insert eachList;
                    newList.add(eachlist);
                    
                }
            }
            insert newList;
            //update newList;
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
            
            
            //for quering contact
           
        }
      
         public void finish(Database.BatchableContext bc)
         {
        
         }
}