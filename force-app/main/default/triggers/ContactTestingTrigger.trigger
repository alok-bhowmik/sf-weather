trigger ContactTestingTrigger on Contact (before insert) {
    if(Trigger.isInsert){
        ContactRecordTypeHandler.contactRecordTypeMethod(Trigger.new);
    }
}