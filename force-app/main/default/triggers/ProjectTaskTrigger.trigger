trigger ProjectTaskTrigger on Project_Task__c (/*after insert, Before Insert, Before Delete ,*/Before Update,After Update /*, After Delete, After Undelete*/) 
{
  ProjectTaskTriggerHandler handler = new ProjectTaskTriggerHandler();
  if(Trigger.isBefore)
    {
      /*if(Trigger.isInsert)
        {
          handler.doBeforeInsert(trigger.new);
        }
        else*/ if(Trigger.isUpdate)
        {
         handler.doBeforeUpdate(trigger.new, trigger.oldmap);
        }
      /*   else if(Trigger.isDelete)
        {
      //   handler.doBeforeDelete(trigger.old, trigger.oldmap);
        }*/
    }
    else if(Trigger.isAfter)
    {
      /* if(Trigger.isInsert)
        {
          handler.doAfterInsert(trigger.new, trigger.newmap);
        }
        else */ if(Trigger.isUpdate)
        {
            handler.doAfterUpdate(Trigger.new, trigger.old, trigger.oldmap);
        }
       /* else if(Trigger.isDelete)
        {
       //     handler.doAfterDelete(trigger.old, trigger.oldmap);
        }
      //  else if(Trigger.isUndelete)
        {
      //      handler.doAfterUndelete(trigger.new, trigger.newmap);
        }*/
    }
}