public class ConsumerAccountClass implements Schedulable
{
    
    public void execute(SchedulableContext sc)
    {
        //Id RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('consumer').getRecordTypeId();
        List<Account> accList = [Select  Id,Name FROM Account where RecordTypeId in (SELECT Id FROM RecordType WHERE Name = 'consumer') ];
        
        system.debug('accList==>' + accList);         
        System.debug('Account List' +accList);
        
        //List<Account> newList = new List<Account>();
         //Id RecordId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('consumer').getRecordTypeId();
        
        if(accList==null)
        {
            
            system.debug('printing statement');
            Account accObj = new Account(Name='Consumer Account(' + System.today().Month() + '/' + System.today().Year() + ')' );
            //accList.add(accObj);
           
            insert accObj;
            System.debug('insert -->' +accObj); 
        
        }
        
        //insert accList;
        //System.debug('Insert' +newList);
        
        
        //ScheduleContacts s = new ScheduleContacts();
        //database.executeBatch(s);
        
        
    }
    
    
    
}