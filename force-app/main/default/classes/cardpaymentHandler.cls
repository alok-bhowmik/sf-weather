public class cardpaymentHandler
{
    public Payment pay{get; set;}
    
    public cardpaymentHandler()
    {
       Payment payment= new Payment();
    }
    
     public static void paymentcardHandler(List<Contact> newList)
    {
        List<Payment> payList= new  List<Payment>();
        
        for(Contact con : newlist)
            
        {
            if(con.Id!=null && con.Email!=null)
            {
                for(Integer i=1 ; i<=1 ;i++)
                {
                    Payment pay= new Payment();
                    
                    pay.Id=con.id;
                    pay.Email=con.Email;
                    pay.Card_Holder_Name__c=con.Name;
                
                    
                   
                    payList.add(pay);
                }
            }
            if(payList.size() > 0)
                insert payList;
        }    
    }
    
    public pageReference Save(){
        Payment pay1= new Payment();
        if(pay1.id!=null){
        pay1.Card_Holder_Name__c=pay.Card_Holder_Name__c;
        pay1.Card_Number__c=pay.Card_Number__c;
        pay1.CVV__c=pay.CVV__c;
        pay1.Expiray_Date__c=pay.Expiray_Date__c;
        }
        insert pay1;
        
        return(new pageReference ('/'+pay.id));
    }
}