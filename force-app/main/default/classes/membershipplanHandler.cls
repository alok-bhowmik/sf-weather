public class membershipplanHandler 

{
    
    public Package_Information__c pak{get; set;}
  //  Public Boolean insertmethod{get;set;}
  //  Public Boolean updatemethod{get;set;}
  // Public Boolean refresh{get;set;}
   // Public Boolean insertx{get;set;}
    
     public boolean show{get;set;}
     public boolean Hide{get;set;}
    
    public membershipplanHandler()
    {
      pak =new Package_Information__c(); 
        
        show= true;
        Hide=false;
    }
    
     public void Save()
    {
        if(pak.Id==null)
        {
        System.debug('pak'+pak.Name);
            pak.Name__c = 'Te';
        Insert pak; 
        show=false;
         Hide=true;
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
       
    }
    
}