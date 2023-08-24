trigger personalTrainingvalidationTrigger on Personal_Training__c (before insert) 
{
  personalTrainingvalidationHandler.personalTrainingvalidationMethod(Trigger.new);
}