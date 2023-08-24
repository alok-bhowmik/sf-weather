public class ContactUsmappingLeadsHandler
{
    public static void ContactUsmappingLeadsMethod(List<Contact_Us__c> newList)
    {
        List<Lead> leadList= new  List<Lead>();
        
        for(Contact_Us__c con : newlist)
            
        {
            if(con.Id!=null && con.Last_Name__c!=null)
            {
                for(Integer i=1 ; i<=1 ;i++)
                {
                    Lead ld= new Lead();
                    
                   ld.Contact_Us__c=con.Id;
                    ld.LastName=con.Last_Name__c;
                    ld.FirstName=con.Name;
                    ld.Age__c=con.Age__c;
                    ld.Email=con.Email__c;
                    ld.Company=con.Company__c;
                 
                    ld.Weight__c=con.Weight__c;
                    ld.Height__c=con.Height__c;
                    ld.Phone=con.Phone__c;
                    ld.LeadSource=con.Lead_Status__c;
                    ld.Gender__c=con.Gender__c;
                   
                    leadList.add(ld);
                }
            }
            if(leadList.size() > 0)
                insert leadList;
        }    
    } 
}