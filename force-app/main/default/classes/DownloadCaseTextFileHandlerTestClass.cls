@isTest
public class DownloadCaseTextFileHandlerTestClass 
{
    @isTest
    public static void DownloadCaseTextFileTestClassMethod()
    {
        Case newCase= new Case();
        newCase.Origin='Phone';
        newCase.Status='New';
        insert newCase;
        Case thisMatter = [select Id, CaseNumber, Origin from Case  limit 1];
        
        string before = 'Testing base 64 encode';            
        Blob beforeblob = Blob.valueOf(before);
        
        ContentVersion cv = new ContentVersion();
        cv.title = 'test content trigger';      
        cv.PathOnClient ='test'; 
        cv.VersionData =beforeblob;     
        insert cv;    
        
        ContentDocument cdRec = [SELECT Id FROM ContentDocument];
        
        ContentDocumentLink contentlink = new ContentDocumentLink();
        contentlink.LinkedEntityId = thisMatter.Id;
        contentlink.contentdocumentid =cdRec.Id;
        insert contentlink; 

        
        DownloadCaseTextFileHandler.getRelatedFilesByRecordId(thisMatter.id);
    }
}