@RestResource(urlMapping='/Account/*')
global with sharing class AccountTargetOrgAPIHandler {
    @HttpGet
    global static List<Account> doGet(){
      RestRequest req= RestContext.request;
      //String urlId = RestContext.request.params.get('Phone');
      System.debug('req==>'+req);
        //system.debug('urlId--> '+urlId);
      RestResponse res = RestContext.response;
        
      //String accountName = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
      //System.debug('accountName==>'+accountName);
      List<Account> result = [SELECT Id,Name,Phone,Type,Industry FROM Account];
      System.debug('result==>'+result);
      return null;
    }
    
    @HttpPost
    global static string doPost(String canName,String canPhone){
       Account acc= new Account();
       acc.Name=canName;
       acc.Phone=canPhone;
       insert acc;
       System.debug('acc==>'+acc);
       return acc.Id;
    }
    @HttpPatch
    global static void doUpdate(String canName,String canPhone){
       RestRequest req= RestContext.request;
       RestResponse res = RestContext.response; 
        
       Account result = [SELECT Id,Name,Phone,Type,Industry FROM Account WHERE Name=:canName];
       result.Phone=canPhone;
       update result;
       System.debug('result==>'+result);
        
       List<Contact> conList=[SELECT Id,AccountId,Phone FROM Contact WHERE AccountId=:result.Id];
        for(Contact con : conList){
            con.Phone=canPhone;
        }
        update conList;
        System.debug('conList==>'+conList);
    }
    @HttpDelete
    global static void doDelete(){
       RestRequest req= RestContext.request;
       RestResponse res = RestContext.response; 
       String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
       System.debug('accountId==>'+accountId);
       Account result=[SELECT Id,Name FROM Account WHERE Id=:accountId];
       System.debug('result==>'+result);
       delete result;
    }
}