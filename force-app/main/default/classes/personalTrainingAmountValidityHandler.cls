public class personalTrainingAmountValidityHandler
{
    public static void personalTrainingAmountValidityMethod(List<Personal_Training__c> newList)
    {
        for(Personal_Training__c pak : newList)
        {
            if(pak.Platinum__c =='Platinum 35')
            {
               pak.Validity__c= '60 Days';
               pak.Amount__c = '42000'; 
            }
            if(pak.Platinum__c =='Platinum 20')
            {
               pak.Validity__c= '40 Days';
               pak.Amount__c = '24000'; 
            }
            if(pak.Platinum__c =='Platinum 12')
            {
               pak.Validity__c= '20 Days';
               pak.Amount__c = '14400'; 
            }
            
            if(pak.Gold__c=='Gold 35')
            {
               pak.Validity__c= '60 Days';
               pak.Amount__c = '33250'; 
            }
            if(pak.Gold__c =='Gold 20')
            {
               pak.Validity__c= '40 Days';
               pak.Amount__c = '19000'; 
            }
            if(pak.Gold__c =='Gold 12')
            {
               pak.Validity__c= '20 Days';
               pak.Amount__c = '11400'; 
            }
            
             if(pak.Silver__c =='Silver 35')
            {
               pak.Validity__c= '60 Days';
               pak.Amount__c = '26250'; 
            }
            if(pak.Silver__c =='Silver 20')
            {
               pak.Validity__c= '40 Days';
               pak.Amount__c = '11000'; 
            }
            if(pak.Silver__c =='Silver 12')
            {
               pak.Validity__c= '20 Days';
               pak.Amount__c = '9000'; 
            }
        }
    }
}