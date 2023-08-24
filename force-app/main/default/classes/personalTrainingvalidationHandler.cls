public class personalTrainingvalidationHandler 
{
    public static void personalTrainingvalidationMethod(List<Personal_Training__c> newList)
    {
        for(Personal_Training__c pak : newList)
        {
            if(pak.Platinum__c!=null && (pak.Gold__c!=null || pak.Silver__c!=null))
            {
              pak.addError('Select only one field in between in this 3 field'); 
            }
            
             if(pak.Gold__c!=null && (pak.Platinum__c!=null || pak.Silver__c!=null))
            {
              pak.addError('Select only one field in between in this 3 field'); 
            }
            
              if(pak.Silver__c!=null && (pak.Platinum__c!=null || pak.Gold__c!=null))
            {
              pak.addError('Select only one field in between in this 3 field'); 
            }
        }
    }
}