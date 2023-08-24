public class RouthStationTriggerHandler 
{
    public static void routeStationMethod(List<Route_Station__c> newList,Boolean isDelete)
    {
      List<Route_Station__c> routeStationList = new List<Route_Station__c>();
      Set<Id> routeStationSet = new Set<Id>();
        for(Route_Station__c routeStationObj : newList)
        {
            if(routeStationObj.Main_Route__c!=null)
            {
              routeStationList.add(routeStationObj);  
              routeStationSet.add(routeStationObj.Main_Route__c);
            }
        }
        List<Route__c> finalRouteList= new List<Route__c>(); 
        Map<Id,Route__c> routeMap = new Map<Id,Route__c>(); 
        List<Route__c> routeList =[Select Id,Name,Total_Distance__c from Route__c where Id=:routeStationSet];
        for(Route__c routeObj : routeList)
        {
          routeMap.put(routeObj.Id,routeObj);  
        }
        for(Route_Station__c routeStationObj : routeStationList)
        {
          Route__c routeObjj = routeMap.get(routeStationObj.Id);
            if(!isDelete)
            {
              routeObjj.Total_Distance__c= routeStationObj.Distance__c+routeObjj.Total_Distance__c;
            }
            else
            {
              routeObjj.Total_Distance__c=routeObjj.Total_Distance__c-routeStationObj.Distance__c;
            }
            finalRouteList.add(routeObjj);
        }
        if(finalRouteList.size()>0)
            update finalRouteList;
    }
}