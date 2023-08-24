trigger RouteStationTrigger on Route_Station__c (after insert,after Undelete,after delete,before delete) 
{
    Boolean isDelete = false;
    if(Trigger.isAfter && Trigger.isInsert)
    {
       
    }
}