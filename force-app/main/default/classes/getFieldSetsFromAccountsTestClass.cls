@isTest
public class getFieldSetsFromAccountsTestClass {
   public static testMethod void TestGetFieldSetsFromAccountMethod(){

        Account acc1 = new Account(Name='Test Acc1',Display_on_Website_as_Capital_Provider__c =true,Display_on_Website__c ='MD');
        insert acc1;
        Account acc2 = new Account(Name='Test Acc2',Display_on_Website_as_Capital_Provider__c =true,Display_on_Website__c ='PA');
        insert acc2;
 
        
        Test.startTest();
        getFieldSetsFromAccount objgetFieldSetsFromAccount = new getFieldSetsFromAccount();
        List<Schema.FieldSetMember> fieldSetMembers = objgetFieldSetsFromAccount.getFields();
        Test.stopTest();
        System.assertNotEquals(null, fieldSetMembers, 'FieldSetMembers should not be null');
        System.assertEquals(true, fieldSetMembers.size() > 0, 'FieldSetMembers should contain records');    
        System.assertEquals(objgetFieldSetsFromAccount.accList.size(),1);
        System.assertEquals(objgetFieldSetsFromAccount.accList1.size(),1);

    }


}