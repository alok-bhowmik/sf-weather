/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-06-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
public class InternalEmailToCaseTestClassHandler 
{
    
    @isTest
    public static void updateCaseDescIfDescNotNull(){
        
       Account  accObj  =  new Account();
       accObj.Name  = 'test';
       accObj.SLA__c  =  'Gold';
       accObj.SLAExpirationDate__c = System.Today();
       accObj.SLASerialNumber__c = '123';
       insert accObj;
       
        Contact conObj  =  new Contact();
        conObj.LastName = 'test';
        conObj.Email  =  'test@gmail.com';
        conObj.AccountId = accObj.Id;
        insert conObj;

        List<Case> caseList = new List<Case>();

        Case caseObj  =  new Case();
        caseObj.Status = 'New';
        caseObj.Origin = 'Care Rep Inbox';
        caseObj.Description  =  '-----Original Message----- From: portal <test@gmail.com> Sent: Tuesday, January 3, 2023 11:14 AM To: Joe Kolenda <joe@itedge.com> Subject: Sandbox: We received a request to change your portal account\'s email address\n Main body';
        caseList.add(caseObj);


        Case caseObj1  =  new Case();
        caseObj1.Status = 'New';
        caseObj1.Origin = 'Care Rep Inbox';
        caseObj1.Description  =  '-----Original Message----- From: portal <test@gmail.com> Sent: Tuesday, January 3, 2023 11:14 AM To: Joe Kolenda <joe@itedge.com> Subject: Sandbox: We received a request to change your portal account\'s email address Main body';
        caseObj1.Subject  =  'Sandbox: We received a request to change your portal account\'s email address' ;
        caseList.add(caseObj1);

        Case caseObj3  =  new Case();
        caseObj3.Status = 'New';
        caseObj3.Origin = 'Care Rep Inbox';
        caseObj3.Description  =  'descriptoin should not change-----Original Message----- From: portal <test@gmail.com> Sent: Tuesday, January 3, 2023 11:14 AM To: Joe Kolenda <joe@itedge.com> Subject: Sandbox: We received a request to change your portal account\'s email address Main body';
        caseObj3.Subject  =  'some test subject' ;
        caseList.add(caseObj3);

        insert caseList;

        List<case> caseEmailList  =  [Select Id,AccountId,ContactId, Description, SuppliedEmail, Original_Case_Description__c from Case Where id = : caseObj3.id];
        System.assertEquals(conObj.Id, caseEmailList[0].ContactId, 'Contact not updated');
        System.assertEquals(accObj.Id, caseEmailList[0].accountId, 'Account not updated');
        System.assertEquals(conObj.Email, caseEmailList[0].SuppliedEmail, 'Email not updated');
        System.assertEquals(caseEmailList[0].Original_Case_Description__c, caseEmailList[0].Description, 'Description not updated as expected');
    }
    

    
}