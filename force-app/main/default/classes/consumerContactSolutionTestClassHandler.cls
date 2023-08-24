@isTest
public class consumerContactSolutionTestClassHandler
{
    @isTest
    public static void consumerContactSolutionTestClassMethod()
    {
        String filter = 'Consumer Account(' + System.today().Month() + '/' + System.today().Year() + ')';
        Id recordId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Consumer').getRecordTypeId();
       // Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('consumer').getRecordTypeId();
        
        Account accObj = new Account(Name=filter);
        insert accObj; 

        Contact conObj= new Contact(LastName='Test Class',AccountId=accObj.Id, RecordTypeId=recordId);
        insert conObj;

        
      //  List<Contact> updatedConList = [Select Id, Name,AccountId,LastName from Contact Where id=: conObj.id];
       // System.assertEquals('Consumer Account', updatedConList[0].AccountId); 
       
    }
    
    @isTest
    public static void consumerContactSolutionTestClassMethodNegative()
    {
        String filter = 'Consumer Account(' + System.today().Month() + '/' + System.today().Year() + ')';
        Id recordId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Consumer').getRecordTypeId();
       // Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('consumer').getRecordTypeId();
        
        Account accObj = new Account(Name='filter');
        insert accObj; 

        Contact conObj= new Contact(LastName='Test Class',AccountId=accObj.Id, RecordTypeId=recordId);
        insert conObj;

        
      //  List<Contact> updatedConList = [Select Id, Name,AccountId,LastName from Contact Where id=: conObj.id];
       // System.assertEquals('Consumer Account', updatedConList[0].AccountId); 
       
    }
}