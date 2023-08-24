/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 11-25-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class ContactPaginationLwcHandler 
{
    @AuraEnabled(cacheable=true)
    public static List<Contact> ContactPaginationLwcMethod() 
    {
       
      //  String strKey = '%' + searchKey + '%';  
        return [SELECT Id, Name,FirstName,LastName,Email,Phone,Profile_Image__c,Description,MailingStreet,MailingCity,MailingState,MailingPostalCode,MailingCountry FROM Contact LIMIT 5];  
    }

    @AuraEnabled(cacheable=true)
    public static List<Contact> returnSearchResult(String searchKey) 
    {
       try {
      String strKey = '%' + searchKey + '%';  
      System.debug('searchKey  = '+strKey);
        return [SELECT Id, FirstName,LastName,Email,Phone,Name,Profile_Image__c,MailingStreet,MailingCity,MailingState,MailingPostalCode,MailingCountry FROM Contact WHERE Name LIKE : strKey LIMIT 5];  
    }
    catch(Exception e){

        throw new AuraHandledException(e.getMessage());
    }
}

}