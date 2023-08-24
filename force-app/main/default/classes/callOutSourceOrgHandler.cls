public class callOutSourceOrgHandler {
  
   // @AuraEnabled(cacheable=true)
    public static Account getAccount(String AccountPhone)
    {
       // system.debug('casenumber==>'+casenumber);
         HttpRequest req = new HttpRequest();
         req.setEndpoint('callout:Salesforce_Org/services/apexrest/Account?Phone='+AccountPhone);
         req.setMethod('GET');
         Http http = new Http();
         HttpResponse res = new HttpResponse();
         res = http.send(req);
         System.debug('res=='+res);
         system.debug(res.getBody());
         System.debug(JSON.deserializeUntyped(res.getBody()));
         Account acc = (Account)JSON.deserialize(res.getBody(), Account.Class);
         //case c = [SELECT Id,CaseNumber,Status,Priority,Description FROM Case WHERE CaseNumber=:casenumber];
         // system.debug(c);
         return acc;
    }
   // @AuraEnabled(cacheable=true)
    public static Account updateAccount(Account accObj)
    {
        System.debug('in updateCase');
        String accountToUpdate = JSON.serialize(accObj);
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:Salesforce_Org/services/apexrest/Account');
        system.debug('req.setEndpoint -->'+ req.getEndpoint());
        req.setMethod('PATCH');//When case is updated that time used PATCH
        req.setBody(accountToUpdate);
        Http http = new Http();
        HttpResponse res = new HttpResponse();
        res = http.send(req);
        Account acc = (Account)JSON.deserialize(res.getBody(), Account.Class);
        return acc;

    }

 //   @AuraEnabled(cacheable=true)
    public static String deleteAccount(Id accObj)
    {
        system.debug('inside delete method');
        System.debug('in deleteCase'+accObj);
        //String caseToDelete = JSON.serialize(caseObj);
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:Salesforce_Org/services/apexrest/Account?CaseNumber='+accObj);
        system.debug('req.setEndpoint -->'+ req.getEndpoint());
        req.setMethod('DELETE');
       // req.setBody(caseToDelete);
        Http http = new Http();
        HttpResponse res = new HttpResponse();
        res = http.send(req);
        return 'deleted';
    }
}