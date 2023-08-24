/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 03-09-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public class AccountContactNo_ofLocationHandler 
{
    public static void AccountContactNo_ofLocationMethod(List<Account> newList)
    {
      List<Contact> conList = new  List<Contact> ();
        for(Account acc: newList)
        {
            if(acc.Id!=null && acc.NumberofLocations__c>0)
            {
                for(Integer i=1; i<=acc.NumberofLocations__c; i++)
                {
                   Contact con = new Contact();
                    con.AccountId=acc.Id;
                    con.LastName=acc.Name+'NumberofLocations__c'+i;
                    conList.add(con); 
                    //Salesforce
                }
            }
        }
        insert conList;
    }
}