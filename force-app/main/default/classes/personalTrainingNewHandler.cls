public class personalTrainingNewHandler
{
      public Personal_Training__c pak{get; set;}
  //  Public Boolean insertmethod{get;set;}
  //  Public Boolean updatemethod{get;set;}
  // Public Boolean refresh{get;set;}
   // Public Boolean insertx{get;set;}
    
     public boolean show{get;set;}
     public boolean Hide{get;set;}
    
    public personalTrainingNewHandler()
    {
      pak =new Personal_Training__c(); 
        
        show= true;
        Hide=false;
    }
    
     public void Save()
    {
        if(pak.Id==null)
        {
      
           
        Insert pak; 
        show=false;
         Hide=true;
        pak=[select id, Name, Validity__c,Silver__c,Platinum__c,Gold__c,Amount__c from Personal_Training__c where id =: pak.id]; 
        }
        if(pak.Id!=null)
        {
          update pak;
          show=false;
         Hide=true; 
        }
    }
    
     public void Edit()
    {   
        Update pak;
          show=true;
         Hide=false;
   //  pak=[select id, Name, Validity__c,Silver__c,Platinum__c,Gold__c,Amount__c from Personal_Training__c where id =: pak.id];  
    }
}