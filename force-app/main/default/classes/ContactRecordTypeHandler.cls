public class ContactRecordTypeHandler {
    public static void contactRecordTypeMethod (List<Contact> newList){
        Set<Id> idSet = new Set<Id>();
        for(Contact con : newList){
            if(con.LastName != null){
                idSet.add(con.RecordTypeId);
                
            }
        }
        Map<Id, Contact> contactMap = new Map<Id,Contact>();
        List<Contact> conList = [Select Id, Name, RecordTypeId from Contact WHERE RecordTypeId =: idSet];
        for(Contact conObj : conList){
            contactMap.put(conObj.RecordTypeId, conObj);
        }
    }

}