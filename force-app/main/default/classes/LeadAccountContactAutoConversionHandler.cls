public class LeadAccountContactAutoConversionHandler 
{
    public static void LeadAccountContactAutoConversionMethod(List<Lead> newList){
       List<Account> accountList = new List<Account>(); 
       List<Contact> contactList = new List<Contact>();
        for(Lead leadObj : newList){
            if(leadObj.Account_Contact__c=='Account'){
                Account accObj = new Account();
                //accObj.Id=leadObj.PartnerAccountId;
                accObj.Name= leadObj.Company;
                accountList.add(accObj);
                System.debug('accountList==>'+accountList);
            }
            
            if(leadObj.Account_Contact__c=='Contact'){
                Contact conObj = new Contact();
                //conObj.Id=leadObj.PartnerAccountId;
                conObj.LastName= leadObj.LastName;
                contactList.add(conObj);
                System.debug('contactList==>'+contactList);
            }
            
        }
        if(accountList.size()>0)
            insert accountList;
           
        if(contactList.size()>0)
            insert contactList;      
    }
}