trigger ConsumerAccountTrigger on Consumer_Contact__c (after insert) 
{
    if(trigger.isInsert && trigger.isAfter)
    {
        for(Consumer_Contact__c c : trigger.new)
        {
         //ConsumerAccountScheduledMonthly st = new ConsumerAccountScheduledMonthly();

        // database.executeBatch(st);
        }

    }

}