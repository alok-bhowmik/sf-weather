trigger ContactTrigger on Contact (after insert /*Before Insert, Before Update, Before Delete ,After Update, After Delete, After Undelete*/) 
{
  ContactTriggerHandler handler = new ContactTriggerHandler();
    if(Trigger.isBefore)
    {
      //  if(Trigger.isInsert)
        {
       //  handler.doBeforeInsert(trigger.new);
        }
     //   else if(Trigger.isUpdate)
        {
      //   handler.doBeforeUpdate(trigger.old, trigger.oldmap, trigger.new, Trigger.newmap);
        }
     //   else if(Trigger.isDelete)
        {
      //   handler.doBeforeDelete(trigger.old, trigger.oldmap);
        }
    }
    else if(Trigger.isAfter)
    {
        if(Trigger.isInsert)
        {
            handler.doAfterInsert(trigger.new, trigger.newmap);
        }
        
     
      //  Datetime executeTime = (System.now()).addMonths(1); 
      //  String cronExpression ='';

      //  System.schedule('ScheduledJob ' ,cronExpression,new ConsumerAccountCreation ());
        
        
      //  else if(Trigger.isUpdate)
        {
      //      handler.doAfterUpdate(trigger.old, trigger.oldmap, trigger.new, Trigger.newmap);
        }
       // else if(Trigger.isDelete)
        {
       //     handler.doAfterDelete(trigger.old, trigger.oldmap);
        }
      //  else if(Trigger.isUndelete)
        {
      //      handler.doAfterUndelete(trigger.new, trigger.newmap);
        }
    }
}