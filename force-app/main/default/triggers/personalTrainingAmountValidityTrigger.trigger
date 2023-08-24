trigger personalTrainingAmountValidityTrigger on Personal_Training__c (before insert) 
{
  personalTrainingAmountValidityHandler.personalTrainingAmountValidityMethod(Trigger.new);
}