public class OpportunityAccountHandler
{
    public static void OpportunityAccountMethod(List<Opportunity> newList)
    {
      List<Account> acclist1 = new List<Account>();
        Set<Id> setId= new Set<Id>(); 
        for(Opportunity opp : newList)
        {
            if(opp.AccountId!=null)
            {
              setId.add(opp.AccountId);  
            }
        }
        
       List<Account> accList=[Select Id,Industry from Account Where Id=:setId];
        for(Account acc: accList)
        {
            for(Opportunity oppObj: newList)
            {
                if(oppObj.StageName =='Closed Won')
                {
                   acc.Industry='Banking';
                   acclist1.add(acc);  
                }
               
            }
        }
        update acclist1;
    }
}