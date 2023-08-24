/**
* @description       : 
* @author            : ChangeMeIn@UserSettingsUnder.SFDoc
* @group             : 
* @last modified on  : 01-27-2023
* @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public class InternalEmailToCaseHandler {
    public void doBeforeInsert(List<Case> newList)
    {
        List<Case> caseListForInternalEmailToCase = new List<Case>();
        for(Case caseObj : newList)
        {
            if(caseObj.Origin=='Care Rep Inbox' )
            {
                caseListForInternalEmailToCase.add(caseObj);
            }
        }
        if(caseListForInternalEmailToCase.size() > 0)
        {
            internalEmailToCase(caseListForInternalEmailToCase);            
        }  
    }
    /*
public void doBeforeUpdate(List<sObject> oldList, Map<Id,sObject> oldMap, List<Case> newList, Map<Id,sObject> newMap)
{

}

public void doBeforeDelete(List<sObject> oldList, Map<Id,sObject> oldMap)
{

}

public void doAfterInsert(List<sObject> newList, Map<Id,sObject> newMap)
{ 

}

public void doAfterUpdate(List<sObject> oldList, Map<Id,sObject> oldMap, List<sObject> newList, Map<Id,sObject> newMap)
{

}

public void doAfterDelete(List<sObject> oldList, Map<Id,sObject> oldMap)
{

}

public void doAfterUndelete(List<sObject> newList, Map<Id,sObject> newMap)
{

}

private void updateAccountName(List<sObject> newList)
{

} 
*/ 
    
    /* updateCaseDescription method is updating the description to remove all of the text that was added from the rep forwarding the email 
* This method will accept list<case> and check all the conditions for Description and subject 
* created by srivignesh on Janauary 05th 2023
* @param newCaseList list of cases 
* @return null
*/
  /*  public void updateCaseDescription(List<Case> newCaseList){
        for(Case caseObj : newCaseList){
            if(caseObj.Description != null && caseObj.Original_Case_Description__c == null) {
                caseObj.Original_Case_Description__c = caseObj.Description;
                system.debug('caseObj.Descirpiton -->' +caseObj.Description);
                system.debug('caseObj.Subject-->'+ caseObj.Subject);*/
                /*if(caseObj.Subject != null){
String fwReplaced = caseObj.subject.replace('FW:','').trim();
Integer indexOfSubject = caseObj.description.indexOf(fwReplaced);
if(indexOfSubject != -1){
caseObj.description = caseObj.description.substringAfter(caseObj.subject.replace('FW:','').trim());  
System.debug('caseObj.description after trimming -->'+ caseObj.description);
}
}else if(caseObj.Description.contains('Subject')){
Integer indexOfSubject = caseObj.description.indexOf('Subject', 0);
if(indexOfSubject != -1){
Integer indexOfNewLine = caseObj.description.indexOf('\n', indexOfSubject);
system.debug('indexOfSubject -->'+ indexOfSubject);
system.debug('indexOfNewLine -->'+ indexOfNewLine); 
if(indexOfNewLine != -1){
caseObj.description = caseObj.description.substring(indexOfNewLine).trim();
system.debug('caseObj.description -->'+ caseObj.Description);  
}
}
} */
        /*         if(caseObj.Description.contains('Forwarded message')){
                Integer indexOfSubject = caseObj.description.indexOf('Forwarded message', 0);
                if(indexOfSubject != -1){
                Integer indexOfNewLine = caseObj.description.indexOf('\n', indexOfSubject);
                    if(indexOfNewLine != -1){
                        system.debug('indexOfSubject -->'+ indexOfSubject);
                        system.debug('indexOfNewLine -->'+ indexOfNewLine); 
                caseObj.description = caseObj.description.substring(indexOfNewLine).trim();
                        system.debug('Final Discription -->'+ caseObj.description);
                }
                }
                }*/
                /*if(caseObj.Description.contains('forwarded message'))
                {
                    String removedFwd=caseObj.Description.remove('Forwarded message');
                    caseObj.Description=removedFwd;
                    system.debug('caseObj.Description-->'+caseObj.Description);
                    if(caseObj.Description.contains('From')){
                        String removedFrom=caseObj.Description.remove('From');
                        caseObj.Description=removedFrom;
                    }
                }          
            }      
        } 
    }*/ 

    public void updateCaseDescription(List<Case> newCaseList)
    {
        System.debug('in updateCaseDescription method' + newCaseList.size());
        for(Case caseObj : newCaseList)
        {   
            system.debug('caseObject in update description method -->'+ caseObj);
            system.debug('caseObj.description -->'+ caseObj.description);
            system.debug('caseObj.Original_Case_Description__c -->'+ caseObj.Original_Case_Description__c);

            if(caseObj.Description != null && caseObj.Original_Case_Description__c == null)
            {
                caseObj.Original_Case_Description__c = caseObj.Description;
             
                List<String> removedList = new List<String>{'Forwarded message:','From:','Date:','Subject:','To:','cc:','BCC:','Sent:','Original Message:'};
                system.debug('removedList -->'+ removedList);
                for(String each :removedList ){
                    if(caseObj.description.containsIgnoreCase(each)){
                        system.debug('in if');
                        caseObj.Description =removeLineFromDescription(caseObj.description,each);
                        system.debug('caseObj.Description -->'+caseObj.Description);
                        
                        if(caseObj.Subject!=null){
                        caseObj.Subject=caseObj.subject.replace('FW:','');
                        system.debug('caseObj.Subject -->'+caseObj.Subject);
                        }
                        else{
                            continue;
                        }
                    }
                }
            }      
        } 
    }

    public  String removeLineFromDescription(String description, String lineToRemove){
        if(description.containsIgnoreCase(lineToRemove)){
            Integer indexOfLineToRemove = description.indexOf(lineToRemove, 0);
            system.debug('indexOfLineToRemove -->'+indexOfLineToRemove);
            if(indexOfLineToRemove != -1){
                Integer indexOfNewLine = description.indexOf('\n', indexOfLineToRemove);
                system.debug('indexOfNewLine -->'+indexOfNewLine);
                if(indexOfNewLine != -1){
                    description = description.substring(indexOfNewLine).trim();
                    system.debug('description -->'+description);
                }
            }
        }
        return description;
       // system.debug('description -->'+description);
    }
    
    
    public void internalEmailToCase(List<Case> newList){
        List<String> emailList = new List<String>();
        Map<String, Case> emailAndCaseMap = new Map<String, Case>();
        
        for(Case caseObj : newList){
            if(caseObj.Description != null){
                String description = caseObj.Description;
                Integer indexOfFrom = description.indexOf('From', 0);
                if(indexOfFrom != -1){
                    Integer indexofTo = description.indexOf('To',0);
                    if(indexofTo != -1){
                        String descriptionAfterFrom = description.substring(indexOfFrom,indexofTo);
                        System.debug('descriptionAfterFrom --> '+descriptionAfterFrom);
                        Matcher m = Pattern.compile('[a-zA-Z0-9-_.]+@[a-zA-Z0-9-_.]+').matcher(descriptionAfterFrom);
                        System.debug('Matcher==>'+m);
                        while (m.find()){
                            String parsedEmail = m.group();
                            if(String.isNotBlank(parsedEmail)){
                                System.debug('parsedEmail -->'+ parsedEmail);
                                emailList.add(parsedEmail);
                                emailAndCaseMap.put(parsedEmail, caseObj);
                                break;       
                            }
                        } 
                    }
                }
            }
        }
        If(!emailList.isEmpty()){
            Map<Id, Contact> contactMap = new Map<Id,Contact>([SELECT Id,AccountId,Email FROM Contact WHERE Email IN :emailList ORDER BY CreatedDate DESC]);
            System.debug('contactMap -->'+ contactMap);
            for(Contact eachCon : contactMap.values()) {
                if(String.isNotBlank(eachCon.Email) && emailAndCaseMap.containsKey(eachCon.Email)){
                    Case caseTemp = emailAndCaseMap.get(eachCon.Email);
                    caseTemp.SuppliedEmail = eachCon.Email;
                    if(eachCon.AccountId != null){
                        caseTemp.AccountId= eachCon.AccountId;
                    }
                    caseTemp.ContactId=eachCon.Id;
                    emailAndCaseMap.remove(eachCon.Email);
                }
            }
        }
        updateCaseDescription(newList);
    }
}