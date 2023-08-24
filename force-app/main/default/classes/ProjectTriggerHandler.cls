public class ProjectTriggerHandler 
{
   public void doBeforeInsert(List<Project__c> newList)
    {
      statusReadonlyInsertingTime(newList);
    }
    
    public void doBeforeUpdate(List<Project__c> newList, Map<Id,Project__c> oldMap)
    {
     // statusReadonlyUpdatingTime(newList,oldMap);
    }
    /*
    public void doBeforeDelete(List<sObject> oldList, Map<Id,sObject> oldMap){
    
    }
    */
    public void doAfterInsert(List<Project__c> newList)
    { 
      projectTriggerHandlerMethod(newList);
    }
    
    public void doAfterUpdate(Map<Id,Project__c> oldMap, List<Project__c> newList)
    {
     // statusReadonlyUpdatingTime(newList,oldMap);
    }
    /*
    public void doAfterDelete(List<sObject> oldList, Map<Id,sObject> oldMap)
    {
	   
    }
    
    public void doAfterUndelete(List<sObject> newList, Map<Id,sObject> newMap)
    {
    
    }
    */
      /*  1) On project creation, 5 Project Tasks child records should be created, each with a single diff type. 
       Each task will contain the relation with its previous task by self lookup. The only first task (New),
       will not have any previous task.*/

    
   public void projectTriggerHandlerMethod(List<Project__c> newList)
    {
      List<Project_Task__c> proTskList = new List<Project_Task__c>();
      Schema.DescribeFieldResult fieldResult = Project_Task__c.Type__c.getDescribe();
       // System.debug('fieldResult==>'+fieldResult);
      List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
       // System.debug('ple==>'+ple);
        
         for(Schema.PicklistEntry s:ple){
            
          //  System.debug('value: '+s.getLabel());
        }
      
        for(Project__c proObj : newList)
        {
            if(proObj.Id!=null)
            {
                for(Integer i=0; i<=4; i++)
                {  
                  Project_Task__c proTsk = new Project_Task__c();
                     proTsk.Project__c=proObj.Id;
                     proTsk.Type__c=ple[i].getLabel();
                    // System.debug('ple==>'+ple[i].getLabel());
                     proTskList.add(proTsk);
                }
            }
        }
         if(proTskList.size()>0)
         insert proTskList;
        // System.debug('proTskList==>'+proTskList);
      
       for(Integer i=1; i<proTskList.size(); i++)
        {
          Project_Task__c currentTask= proTskList[i];
         //  System.debug('currentTask==>'+currentTask); 
            if(currentTask.Type__c!=null)
            {
              currentTask.Previous_Task__c= proTskList[i-1].Id;
          //    System.debug('currentTask.Previous_Task__c==>'+currentTask.Previous_Task__c);  
            }
        }
        if(proTskList.size()>0)
        update proTskList;
      //  System.debug('Update proTskList==>'+proTskList); 
        
     }
    
     /* 1) Validations:
         (i) You cannot select status inserting time. */
    
       public void statusReadonlyInsertingTime(List<Project__c> newList)
        {
         for(Project__c proObj : newList)
          {
             if(proObj.Name!=null && proObj.Status__c!=null)
              {
               proObj.Status__c.addError('By creation of project you cannot select status'); 
              }  
          }
        }
    
        /* 
         (ii) You cannot select status updating time. Not Working */
    
        public void statusReadonlyUpdatingTime(List<Project__c> newList, Map<Id, Project__c> oldMap)
         {
           for(Project__c projectTask : newList) 
            {
             Project__c projectOldMap= oldMap.get(projectTask.Id);
                if(projectOldMap!=null)
                {
                  if(projectTask.Status__c!=projectOldMap.Status__c) 
                   {
                    projectTask.Status__c.addError('Cannot update Status');
                   } 
                }
            }
         }
}