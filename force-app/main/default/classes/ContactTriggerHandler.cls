public class ContactTriggerHandler 
{  
  
   // public void doBeforeInsert(List<sObject> newList)
     {
        
     }
    
   // public void doBeforeUpdate(List<sObject> oldList, Map<Id,sObject> oldMap, List<sObject> newList, Map<Id,sObject> newMap)
   // {
    
   // }
    
   // public void doBeforeDelete(List<sObject> oldList, Map<Id,sObject> oldMap)
    {
    
    }
    
    public void doAfterInsert(List<Contact> newList,  Map<Id,Contact> newMap)
    {
        Id recordId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Consumer').getRecordTypeId();
        List<Contact> contactListForConsumerContactSolution = new List<Contact>();
        for(Contact each : newList)
        {
            if(each.recordTypeId == recordId)
            {
                contactListForConsumerContactSolution.add(each);
            }
        }
        if(contactListForConsumerContactSolution.size() > 0){
       	ConsumarContactHandlerMethod(contactListForConsumerContactSolution);            
        }

    }
	
   
   // public void doAfterUpdate(List<sObject> oldList, Map<Id,sObject> oldMap, List<sObject> newList, Map<Id,sObject> newMap)
    {
    
    }
    
   // public void doAfterDelete(List<sObject> oldList, Map<Id,sObject> oldMap)
    {
	
    
    }
    
  //  public void doAfterUndelete(List<sObject> newList, Map<Id,sObject> newMap)
    {
    
    }
   

    public void ConsumarContactHandlerMethod(List<Contact> newList)
    { 
        List<Consumer_Contact__c> conList= new  List<Consumer_Contact__c>(); 
        List<Contact> contactToUpdate = new LIst<Contact>();
        list<contact> contactLIst = new List<contact>();
        
        //Account Variable
        List<Account> accList;
        
       // Account accObjj;
        String filter = 'Consumer Account(' + System.today().Month() + '/' + System.today().Year() + ')';
        
        Set<Id> contactIdSet = new Set<Id>();
        for(Contact conObj : newList)
        {
            if(conObj.Id!=null)
            {
                contactIdSet.add(conObj.Id);  
            }
        }
        List<Contact> lstInsertedCon = [SELECT LastName,Id , Name,RecordTypeId,Account.Name,AccountId FROM Contact WHERE Id IN : contactIdSet];
       
        //Account List
        List<Account> accountList=[Select Id, Name from Account where Name=:filter];
        system.debug('Account Contains'+accountList); 
         Id recordId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Consumer').getRecordTypeId();
      // for(Contact conObj: newList)
      //  {
       //   if(conObj.RecordTypeId==recordId)
        //    {
        
           Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('consumer').getRecordTypeId();
           if(accountList.size()==0 || accountList==null)
             {
               system.debug('Account RecordType'+recordTypeId); 
               Account accObjj= new Account(RecordTypeId=recordTypeId,Name='Consumer Account(' + System.today().Month() + '/' + System.today().Year() + ')');
               insert accObjj;    
               system.debug('Creation Consumer Account'+accObjj);
            
               accList=[Select Id,Name from Account where Id =: accObjj.Id]; 
               system.debug('Collect Consumer Account'+accObjj);
             }
            else
            {
              accList=[Select Id, Name from Account where Name=:filter]; 
              system.debug('Consumer Account Contain'+accList);  
            }
                
                
         // }
       // }
        Id recId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Consumer').getRecordTypeId();
        
        for(Contact conObj: lstInsertedCon)
        {  
          if(conObj.Id!=null && conObj.RecordTypeId==recId)
            {  
                if(conObj.Account.Name!= null && !conObj.Account.Name.contains('Consumer Account'))
                {
                  
                   for(Account acc: accList)
                    {
                      conObj.AccountId=acc.Id;          
                      system.debug('Account Exchange1'+conObj);
                      contactToUpdate.add(conObj);
                    }
                }   
            }
        }
        if(contactToUpdate.size() > 0)
        {
          update contactToUpdate;
          system.debug('Account Update'+contactToUpdate);
        }

        for(Contact conOld: newList)
        { 
          if(conOld.Id!=null && conOld.RecordTypeId==recId)
            {
                Consumer_Contact__c consumerObj= new  Consumer_Contact__c();
                consumerObj.Contact__c =conOld.Id;
                consumerObj.Account__c=conOld.AccountId;
                consumerObj.Name=conOld.LastName;
                conList.add(consumerObj);
                system.debug('Consumer Contact1'+conList);
            }           
        }
        if(conList.size()>0)
        insert conList; 
        system.debug('Insert Consumer Contact'+conList);
        
    } 
}