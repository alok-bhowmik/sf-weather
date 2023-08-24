// Name: Alok Bhowmik

public class ProjectTaskTriggerHandler
{
    public void doBeforeInsert(List<Project__c> newList)
     {
       
     }
    
    public void doBeforeUpdate(/*List<sObject> oldList, Map<Id,sObject> oldMap,*/ List<Project_Task__c> newList,
                               Map<Id, Project_Task__c> oldMap /*, Map<Id,sObject> newMap*/)
    {
      checkCompletionDateIsSelectedMethod(newList);
      checkCompletionDateIsSelectedAndTaskIsNotcompleted(newList);
      checkTypeChange(newList,oldMap);
      checkPreviousTaskChange(newList,oldMap);// need to check
    }
    /*
    public void doBeforeDelete(List<sObject> oldList, Map<Id,sObject> oldMap)
    {
    
    }
    
    public void doAfterInsert(List<Project__c> newList)
    {

    }
   */
    public void doAfterUpdate(List<Project_Task__c> newList, List<Project_Task__c> oldList, Map<Id,Project_Task__c> oldMap)
    {
      projectTaskTriggerHandlerMethod(newList,oldMap);
      checkIfNextTaskIsCompleted(newList);
      checkPreviousTaskCompleted(newList);
     // checkPreviousTaskChange(newList,oldMap);
    }
   /*    
   // public void doAfterDelete(List<sObject> oldList, Map<Id,sObject> oldMap)
    {
	
    
    }
    
  //  public void doAfterUndelete(List<sObject> newList, Map<Id,sObject> newMap)
    {
    
    }*/
    
    
    /*
   (1) Whenever any Project Task is marked as "Completed", its corresponding status will be updated to the parent
      Project object as blow mapping:

          New Task --> New
          Planning Phase -> Planning
          Construction Work --> Construction
          Completion Step -> Deployment
          Contract End -> Signoff */
    
   
  public void projectTaskTriggerHandlerMethod(List<Project_Task__c> newList, Map<Id,Project_Task__c> oldMap)
      {
        Map<Id,Project__c> projectMap = new Map<Id,Project__c>();
        Set<Id> projectRecIds = new Set<Id>();
        for(Project_Task__c eachProTask : newList)
        {
          if(eachProTask.Id!=null)
            {
              projectRecIds.add(eachProTask.Project__c);
              System.debug('(projectRecIds==>'+projectRecIds);
            }
        }
        Map<Id, Project__c> mapProject = new Map<Id,Project__c>([SELECT Id, Name, Status__c FROM Project__c where
                                                                    id in : projectRecIds]);
        System.debug('(mapProject==>'+mapProject);
        for(Project_Task__c projectTask  : newList)
          {
             Project__c project =  mapProject.get(projectTask.Project__c); 
             system.debug('Project-->' +project);
            // Project_Task__c oldProjectTask = oldMap.get(projectTask.Id);
            // system.debug('oldProjectTask-->'+oldProjectTask);
             Project_Task__c projectTasks = oldMap.get(projectTask.Id);
             system.debug('projectTasks-->'+projectTasks);
              
             if(projectTask.Type__c == 'New Task' &&  projectTask.Completed__c)
             {
                project.status__c = 'New';
                projectMap.put(Project.Id,project);
                system.debug('projectMap-->'+projectMap);
             }
              
             if(projectTask.Type__c == 'New Task' &&  !projectTask.Completed__c)
             {
                project.status__c = '';
                projectMap.put(Project.Id,project);
                system.debug('projectMap-->'+projectMap);
             }
              
             if(projectTask != null && projectTasks != null) 
             {
                if(projectTask.Completed__c)
                {
                    if(projectTask.Type__c == 'New Task' )
                    {
                        project.Status__c = 'New' ;
                    }
                    else if(projectTask.Type__c == 'Planning Phase' )
                    {
                        project.Status__c = 'Planning' ;
                    }
                    else if(projectTask.Type__c == 'Construction Work' )
                    {
                        project.Status__c = 'Construction' ;
                    }
                    else if(projectTask.Type__c == 'Completion Step' )
                    {
                        project.Status__c = 'Deployment';
                    }
                    else if(projectTask.Type__c == 'Contract End')
                    {
                        project.Status__c = 'Signoff';
                    }
                    projectMap.put(project.Id,project);
                    system.debug('projectMap-->'+projectMap);
                } 
                 
                else if(!projectTask.Completed__c && projectTasks.Completed__c)
                {
                    System.debug('projectTask.Completed__c-->'+projectTask.Completed__c);
                    System.debug('projectTasks.Completed__c-->'+projectTasks.Completed__c);
                    if(projectTasks.Type__c == 'New Task' )
                    {
                        project.Status__c = '' ;
                    }
                    else if(projectTasks.Type__c == 'Planning Phase' )
                    {
                        project.Status__c = 'New' ;
                    }
                    else if(projectTasks.Type__c == 'Construction Work' )
                    {
                        project.Status__c = 'Planning' ;
                    }
                    else if(projectTasks.Type__c == 'Completion Step' )
                    {
                        project.Status__c = 'Construction';
                    }else if(projectTasks.Type__c == 'Contract End')
                    {
                        project.Status__c = 'Deployment';
                    } 
                    projectMap.put(project.Id,project); 
                    system.debug('projectMap-->'+projectMap);
                }
             }
          }  
         if(projectMap.size()>0)
          {
            update projectMap.values();
            System.debug('projectMap update==>'+projectMap);  
          }  
      }        
       
   /* 1) Validations:
         (i)Any task cannot be marked as completed if its completion Date is empty. */

    public void checkCompletionDateIsSelectedMethod(List<Project_Task__c> newList) 
    {
        for(Project_Task__c projectTask : newList)
        {
            if(projectTask.Completed__c==true && projectTask.Completion_Date__c==null)
            {
                projectTask.Completion_Date__c.addError('Any task cannot be marked as completed if its completion Date is empty');
            }
        }
    }
    
   /* 2) Validations:
         (i)If the task is not yet completed Completion date cannot be selected.*/
    
     public void checkCompletionDateIsSelectedAndTaskIsNotcompleted(List<Project_Task__c> newList)
     {
        for(Project_Task__c projectTask : newList) 
        {
            if(projectTask.Completion_Date__c != Null && projectTask.Completed__c!=true)
            {
                projectTask.Completion_Date__c.addError('If the task is not yet completed Completion date cannot be selected');
            }
        }
     }
    
    /* 3) Validations:
         (i)Any task cannot be marked as completed if its previous task is not completed*/
    
     public void checkPreviousTaskCompleted(List<Project_Task__c> newList)
     {
         Set<String> stringSet= new Set<String>();
         for(Project_Task__c projectTask : newList) 
         {
             if(projectTask.Id!=null)
             {
               stringSet.add(projectTask.Id); 
              // System.debug('(stringSet==>'+stringSet);
             }
         }
         Map<Boolean,Project_Task__c> completedMap = new Map<Boolean,Project_Task__c>();
         List<Project_Task__c> proList=[Select Id,Name,Previous_Task__c,Previous_Task__r.Completed__c,Completed__c,
                                           Completion_Date__c from Project_Task__c where Id IN :stringSet];
        // System.debug('(proList==>'+proList);
         for(Project_Task__c projectTsk : proList)
         {
           completedMap.put(projectTsk.Previous_Task__r.Completed__c, projectTsk); 
            // System.debug('(projectTsk.Previous_Task__r.Completed__c==>'+projectTsk.Previous_Task__r.Completed__c); 
            // System.debug('(completedMap==>'+completedMap); 
         }
         
         for(Project_Task__c proObj : newList)
         {
          // System.debug('(proObj==>'+proObj); 
           if(proObj.Completed__c==true && completedMap.containsKey((proObj.Previous_Task__r.Completed__c)) && proObj.Previous_Task__c!=null)
            {
              proObj.addError('Any task cannot be marked as completed if its previous task is not completed');      
              // System.debug('( proObj.Previous_Task__c==>'+ proObj.Previous_Task__c); 
            }
         }
     }
    
     /* 4) Validations:
         (i)You Cannot uncheck if next task is already checked*/
    
    public void checkIfNextTaskIsCompleted(List<Project_Task__c> newList)
    {
        Set<String> stringSet= new Set<String>();
        for(Project_Task__c proTskCheck : newList) 
        {
           if(proTskCheck.Id!=null)
             {
               stringSet.add(proTskCheck.Id); 
              // System.debug('(proTskCheck==>'+proTskCheck);
             }
        }
        
         Map<boolean, Project_Task__c> nextProjectTaskMap = new Map<boolean, Project_Task__c>();
         List<Project_Task__c> nextProjectTaskList = new List<Project_Task__c>();
         if(stringSet.size() > 0) 
         {
            nextProjectTaskList = [Select Id, Name, Completed__c , Previous_Task__c From Project_Task__c Where 
                                   Previous_Task__c IN : stringSet AND Completed__c = True];
          //  System.debug('(nextProjectTaskList==>'+nextProjectTaskList);
         }
        
         for(Project_Task__c projectTask : nextProjectTaskList)
          {
            nextProjectTaskMap.put(projectTask.Completed__c, projectTask);
            // System.debug('(nextProjectTaskMap==>'+nextProjectTaskMap);
          }
        
         for(Project_Task__c proObj : newList)
         {
         // System.debug('(proObj==>'+proObj);
           if(proObj.Completed__c!=true && nextProjectTaskMap.containsKey((proObj.Completed__c==false)) && proObj.Previous_Task__c!=null)
            {
             // if(proObj.Type__c != 'Contract End' && !proObj.Completed__c)
                proObj.Completed__c.addError('Cannot uncheck if the next task is already checked');
              //  System.debug('( proObj.Completed__c==>'+ proObj.Completed__c);  
            }
         }
    
    }
    
     /* 5) Validations:
         (i)You Cannot change Type in Project Task*/
      
      public void checkTypeChange(List<Project_Task__c> newList, Map<Id, Project_Task__c> oldMap)
      {
        for(Project_Task__c projectTask : newList)
         {
            if(oldMap.get(projectTask.Id).Type__c != projectTask.Type__c)
            {
                projectTask.Type__c.addError('You Cannot update type');
            }
         }
      }
    
      /* 6) Validations:
         (i)You Cannot change Previous Task in Project Task*/
    
     public void checkPreviousTaskChange(List<Project_Task__c> newList, Map<Id, Project_Task__c> oldMap)
      {
        for(Project_Task__c projectTask : newList)
         {
          // System.debug('(projectTask==>'+projectTask); 
           Project_Task__c  projectTask1 = oldMap.get(projectTask.Id);
           if(projectTask1.Previous_Task__c != null && projectTask.Type__c != 'New Task')
           {
             if(projectTask.Previous_Task__c!=projectTask1.Previous_Task__c)
              {
              //  System.debug('(oldMap.get(projectTask.Id).Previous_Task__c==>'+oldMap.get(projectTask.Id).Previous_Task__c);
                projectTask.Previous_Task__c.addError('You Cannot Change Previous Task');
              }
           }
         }
     }
}