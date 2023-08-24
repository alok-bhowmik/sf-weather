public with sharing class ConsumerContactController {
    public ConsumerContactController() {

    }
    @AuraEnabled
    public static List<String> lstContactFields()
    {
        Map<String, Schema.SObjectField> fields = Schema.getGlobalDescribe().get('Contact').getDescribe().fields.getMap();
        List<String> editableFields = new List<String>();
        for(Schema.SObjectField fieldRef : fields.values()) 
        {
            Schema.DescribeFieldResult fieldResult = fieldRef.getDescribe();
            if(fieldResult.isUpdateable() == true && String.valueOf(fieldRef) != 'RecordTypeId' && String.valueOf(fieldRef) !='CleanStatus' &&  String.valueOf(fieldRef) !='Jigsaw' && String.valueOf(fieldRef) !='IndividualId'
            && String.valueOf(fieldRef) != 'EmailBouncedReason' && String.valueOf(fieldRef) != 'EmailBouncedDate') 
            {
                editableFields.add(fieldResult.getname());
            }
        }
        return editableFields;
    }
    @AuraEnabled
    public static Id getRecordTypeName(){
       
            return Schema.getGlobalDescribe().get('Contact').getDescribe().getRecordTypeInfosByName().get('Consumer').getRecordTypeId();
        
    }
}