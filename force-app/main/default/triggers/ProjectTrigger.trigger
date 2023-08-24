trigger ProjectTrigger on Project__c (after insert, Before Insert , Before Update,After Update/*, Before Delete ,, After Delete, After Undelete*/) 
{
  ProjectTriggerHandler handler = new ProjectTriggerHandler();
   if(Trigger.isBefore)
    {
       if(Trigger.isInsert)
        {
         handler.doBeforeInsert(trigger.new);
        } 
       else if(Trigger.isUpdate)
        {
         handler.doBeforeUpdate(Trigger.new,trigger.oldmap);
        } /*
     //   else if(Trigger.isDelete)
        {
      //   handler.doBeforeDelete(trigger.old, trigger.oldmap);
        }*/
    }  
    else if(Trigger.isAfter)
    {
        if(Trigger.isInsert)
        {
            handler.doAfterInsert(trigger.new);
        }
        else if(Trigger.isUpdate)
        {
            handler.doAfterUpdate(trigger.oldmap, trigger.new);
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