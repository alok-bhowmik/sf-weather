/**
* @description       : 
* @author            : ChangeMeIn@UserSettingsUnder.SFDoc
* @group             : 
* @last modified on  : 11-23-2022
* @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class DownloadCaseTextFileHandler {
    @AuraEnabled(cacheable=true)
    public static Map<ID, String> getRelatedFilesByRecordId(String recordId) {
        // Get record file IDs        
        List<ContentDocumentLink> files = [SELECT ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId = :recordId];
        List<ID> fileIDs = new List<ID>();
        for (ContentDocumentLink docLink : files) 
        {
            fileIDs.add(docLink.ContentDocumentId);
        }
        
        List<ContentVersion> docs = [SELECT ContentDocumentId, FileExtension, Title, FileType FROM ContentVersion WHERE ContentDocumentId IN : fileIDs];
        Map<ID, String> mapIdTitle = new Map<ID, String>();
        
        for (ContentVersion docLink : docs) 
        {
            System.debug('fileType ->'+docLink.FileType);
            System.debug('file extenstion ->'+ docLink.FileExtension);
            if(docLink.FileExtension=='txt')
            {
                mapIdTitle.put(docLink.ContentDocumentId, docLink.Title);
            }
        }
        return mapIdTitle;
    }
}