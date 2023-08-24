trigger ContactUsmappingLeadsTrigger on Contact_Us__c (after insert)
{
    if(Trigger.isInsert)
    {
      ContactUsmappingLeadsHandler.ContactUsmappingLeadsMethod(Trigger.new);
    }
}