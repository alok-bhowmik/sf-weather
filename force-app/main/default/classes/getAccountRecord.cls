/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 04-07-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class getAccountRecord {
    public List<Account> accList { get; set; }

    
    public getAccountRecord() {
        this.accList = getMerchandise();
        System.debug('this.accList-->'+this.accList);
        for (Account variable : this.accList) {
            System.debug('acc=>'+variable);
        }
    }

    public List<Schema.FieldSetMember> getFields() {
        return SObjectType.Account.FieldSets.Account_Field_set.getFields();
    }

    public List<Account> getMerchandise() {
        Map<String, Schema.SObjectType> globalDescribeMap = Schema.getGlobalDescribe(); 
        Schema.SObjectType sObjectTypeObj = globalDescribeMap.get('Account');
        Schema.DescribeSObjectResult describeSObjectResultObj = sObjectTypeObj.getDescribe();
    	Schema.FieldSet fieldSetObj = describeSObjectResultObj.FieldSets.getMap().get('Account_Field_set');

        String query = 'SELECT ';
        for(Schema.FieldSetMember f : fieldSetObj.getFields()) {
            System.debug(f.getFieldPath());
            query += f.getFieldPath() + ', ';
        }
        query += 'Id FROM Account WHERE Display_on_Website_as_Capital_Provider__c =true LIMIT 10 ';
        

        System.debug('query-->'+query);
        return Database.query(query);
    }
}