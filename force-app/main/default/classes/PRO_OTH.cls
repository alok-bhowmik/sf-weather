public class PRO_OTH { // Name of the controller

List<Account> pro = [ Select Name, AccountNumber, AnnualRevenue, Industry, Type from Account where Type ='Prospect'];
List<Account> oth = [ Select Name, AccountNumber, AnnualRevenue, Industry, Type from Account where Type ='Other'];
 
 public List<Account> getpro()
       { return pro;
       }
       
 public List<Account> getoth ()
       { return oth;
       }
 /*public PageReference tab(){ // Page Reference Implementation return Page.Tab_View;
}
public PageReference section(){ // Page Reference Implementation return Page.List_View;
} */      
 }