import { LightningElement,api,wire } from 'lwc';
import { CloseActionScreenEvent } from 'lightning/actions';
import getRelatedFilesByRecordId from '@salesforce/apex/DownloadCaseTextFileHandler.getRelatedFilesByRecordId';


export default class DownloadCaseTextFile extends LightningElement {

    @api recordId;
    filesList =[]
    @wire(getRelatedFilesByRecordId, {recordId: '$recordId'})
    wiredResult({data, error}){ 
        if(data){ 
            console.log(data)
            this.filesList = Object.keys(data).map(item=>({"label":data[item],
             "value": item,
             "url":`/sfc/servlet.shepherd/document/download/${item}`
            }))
            console.log(this.filesList)
        }
        if(error){ 
            console.log(error)
        }
    }
   
    connectedCallback(){}
   
    handleClose() { 
        this.dispatchEvent(new CloseActionScreenEvent());          
    }
}