public class GetContactDetails {
    
    @auraenabled
    public static List<FieldDefinition> getFieldApi()
    {
        return [SELECT  QualifiedApiName FROM FieldDefinition WHERE EntityDefinition.QualifiedApiName = 'Contact'];
    }
    @AuraEnabled
    public static List<String> lstContactFields(){
        
        List<String> lstFields = new List<String>();
        
        for(Schema.FieldSetMember fieldSetMemberObj : SObjectType.Contact.FieldSets.conatct_fieldSet.getFields())
        {
            lstFields.add(fieldSetMemberObj.getFieldPath());
            system.debug(fieldSetMemberObj.getFieldPath());
        }
        return lstFields;
    }
}