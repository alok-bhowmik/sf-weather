import { LightningElement,api,wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import Status_Field from '@salesforce/schema/Project__c.Status__c';

export default class ProjectProgressBar extends LightningElement {

    @api recordId;
    
    
    @wire (getRecord, 
        {recordId : '$recordId', fields : [Status_Field]})
        recordData;
           

     get statusValue() 
     {
        var status = getFieldValue(this.recordData.data, Status_Field);
        return status
     }
}