trigger OpportunityAccountTrigger on Opportunity (after insert, after update) 
{
   OpportunityAccountHandler.OpportunityAccountMethod(Trigger.new);
}