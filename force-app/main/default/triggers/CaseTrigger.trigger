/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-06-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
trigger CaseTrigger on Case (before insert)
{
    system.debug('in trigger');
    System.debug('trigger.new size -->'+ Trigger.new.size());
  InternalEmailToCaseHandler handler = new InternalEmailToCaseHandler();
    if(Trigger.isBefore)
    {
        if(Trigger.isInsert)
        {
            handler.doBeforeInsert(trigger.new);
        }/*
        else if(Trigger.isUpdate)
        {
            handler.doBeforeUpdate(trigger.old, trigger.oldmap, trigger.new, Trigger.newmap);
        }
        else if(Trigger.isDelete)
        {
            handler.doBeforeDelete(trigger.old, trigger.oldmap);
        }*/
    }/*
    else if(Trigger.isAfter)
    {
        if(Trigger.isInsert)
        {
            handler.doAfterInsert(trigger.new, trigger.newmap);
        }
        else if(Trigger.isUpdate)
         {
            handler.doAfterUpdate(trigger.old, trigger.oldmap, trigger.new, Trigger.newmap);
         }
        else if(Trigger.isDelete)
         {
            handler.doAfterDelete(trigger.old, trigger.oldmap);
        }
        else if(Trigger.isUndelete)
        {
            handler.doAfterUndelete(trigger.new, trigger.newmap);
        }
    }*/
}