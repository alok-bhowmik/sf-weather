public with sharing class ApexAccountlookup {
    public ApexAccountlookup() {

    }
    // Method to fetch lookup search result   
    @AuraEnabled(cacheable=true)
    public static list<sObject> fetchLookupData(string searchKey , string sObjectApiName) {    
        List < sObject > returnList = new List < sObject > ();
        string sWildCardText = '%' + searchKey + '%';
        string sQuery = 'Select Id,Name From ' + sObjectApiName + ' Where Name Like : sWildCardText order by createdDate DESC LIMIT 5';
        for (sObject obj: database.query(sQuery)) {
            returnList.add(obj);
        }
        return returnList;
    }
    
    // Method to fetch lookup default value 
    @AuraEnabled
    public static sObject fetchDefaultRecord(string recordId , string sObjectApiName) {
        string sRecId = recordId;    
        string sQuery = 'Select Id,Name From ' + sObjectApiName + ' Where Id = : sRecId LIMIT 1';
        for (sObject obj: database.query(sQuery)) {
            return obj;
        }
        return null;
    }
    @AuraEnabled
    public static List<Contact> retrieveContact(string keySearch){
        try {
            List<Contact> contactList = [Select Id, FirstName, LastName, Email, Phone, Account.Name From Contact Where Account.Name=:keySearch];
             return contactList;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static List<String> lstContactFields(){
        Map<String, Schema.SObjectField> fields = Schema.getGlobalDescribe().get('Contact').getDescribe().fields.getMap();
        List<String> editableFields = new List<String>();
        for(Schema.SObjectField fieldRef : fields.values()) {
            Schema.DescribeFieldResult fieldResult = fieldRef.getDescribe();
            if(fieldResult.isUpdateable() == true && String.valueOf(fieldRef) != 'RecordTypeId' && String.valueOf(fieldRef) !='CleanStatus' &&  String.valueOf(fieldRef) !='Jigsaw' && String.valueOf(fieldRef) !='IndividualId'
            && String.valueOf(fieldRef) != 'EmailBouncedReason' && String.valueOf(fieldRef) != 'EmailBouncedDate') {
                editableFields.add(fieldResult.getname());
            }
        }
        return editableFields;
}

}