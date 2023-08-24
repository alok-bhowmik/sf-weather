/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 11-24-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class paginationApexHandler 
{
    @AuraEnabled(cacheable=true)
    public static List<Contact> paginationApexMethod(String searchKey)
     {
       // String query = 'SELECT Id, Name,Phone,Type FROM Account';            
       if (String.isNotEmpty(searchKey))
        {
          String key = '%' + searchKey + '%';
          return[select Id,Name,Phone,Email from Contact where Name like :key OR Email like:key];
        }
        else
        {
          return[select id,Name,Phone from Contact ORDER BY Name];
        }         
     }
}