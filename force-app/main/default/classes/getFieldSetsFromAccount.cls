/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 04-07-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class getFieldSetsFromAccount {

    public List<Account> accList { get; set; }
    public List<Account> accList1 { get; set; }


    public getFieldSetsFromAccount() {
     this.accList = getMerchandiseMd();
     this.accList1 = getMerchandisePA();
        System.debug('this.accList-->'+this.accList);
        for (Account variable : this.accList) {
            System.debug('acc=>'+variable);
          
        }
    }

    public List<Schema.FieldSetMember> getFields() {
        return SObjectType.Account.FieldSets.Account_Field_set.getFields();
    }

    public List<Account> getMerchandiseMd() {
        Map<String, Schema.SObjectType> globalDescribeMap = Schema.getGlobalDescribe(); 
        Schema.SObjectType sObjectTypeObj = globalDescribeMap.get('Account');
        Schema.DescribeSObjectResult describeSObjectResultObj = sObjectTypeObj.getDescribe();
    	Schema.FieldSet fieldSetObj = describeSObjectResultObj.FieldSets.getMap().get('Account_Field_set');

        String query = 'SELECT ';
       // List<String> strList = new List<String> { 'MD', 'PA' };
        for(Schema.FieldSetMember f : fieldSetObj.getFields()) {
            System.debug(f.getFieldPath());
            query += f.getFieldPath() + ', ';
            System.debug('query12==>'+query);
        }
        query += 'Id, Display_Contact__r.Name FROM Account Where Display_on_Website_as_Capital_Provider__c =true AND Display_on_Website__c =\'MD\' LIMIT 10';
        // query = [Id, Display_Contact__r.Name FROM Account Where Display_on_Website__c = 'MD' LIMIT 10 ];
        System.debug('query-->'+query);


        
        return Database.query(query);
    }


    public List<Account> getMerchandisePA() {
        Map<String, Schema.SObjectType> globalDescribeMap = Schema.getGlobalDescribe(); 
        Schema.SObjectType sObjectTypeObj = globalDescribeMap.get('Account');
        Schema.DescribeSObjectResult describeSObjectResultObj = sObjectTypeObj.getDescribe();
    	Schema.FieldSet fieldSetObj = describeSObjectResultObj.FieldSets.getMap().get('Account_Field_set');

        String query = 'SELECT ';
       // List<String> strList = new List<String> { 'MD', 'PA' };
        for(Schema.FieldSetMember f : fieldSetObj.getFields()) {
            System.debug(f.getFieldPath());
            query += f.getFieldPath() + ', ';
            System.debug('query12==>'+query);
        }
        query += 'Id, Display_Contact__r.Name FROM Account Where Display_on_Website_as_Capital_Provider__c =true AND Display_on_Website__c =\'PA\' LIMIT 10';
        // query = [Id, Display_Contact__r.Name FROM Account Where Display_on_Website__c = 'MD' LIMIT 10 ];
        System.debug('query-->'+query);


        
        return Database.query(query);
    }


}