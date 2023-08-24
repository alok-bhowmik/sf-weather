import { LightningElement ,api,wire} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import {NavigationMixin} from 'lightning/navigation';
import LastName from '@salesforce/schema/Contact.LastName';
import Email from '@salesforce/schema/Contact.Email';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import MY_OBJECT from '@salesforce/schema/Contact';

export default class RecordEditFormComponent extends NavigationMixin(LightningElement) {
    
        isModalShow=true;
        @api recordTypeId;
         @api objectInfo;

    @wire(getObjectInfo, { objectApiName: MY_OBJECT })
    objectInfo;

    get recordTypeId() {
        console.log('get recordtypeid');
        // Returns a map of record type Ids 
        const rtis = this.objectInfo.data.recordTypeInfos;
        return Object.keys(rtis).find(rti => rtis[rti].name === 'record type 1');
    }
        handleSuccess(event) {
            console.log("INISDE")
            this.isModalShow=false;
                    this[NavigationMixin.Navigate]({
                        type: 'standard__recordPage',
                        attributes: {
                            recordId:event.detail.id,
                            objectApiName:'Contact',
                            actionName:'view'
                        },
                    });
                    this.dispatchEvent( new ShowToastEvent({
                        title: 'Success!',
                        message: event.detail.id+' Record created!',
                        variant: 'success'
                    }))              
                    if(LastName==''){
                        this.dispatchEvent( new ShowToastEvent({
                                title: 'Error!',
                                message: 'Record cannot be created please enter lastname',
                                variant: 'Error'
                            }))  
                    }
    }
    handleCancel() {

        this.isModalShow = false;

             this[NavigationMixin.Navigate]({
               type: 'standard__objectPage',
               attributes: {
                   objectApiName: 'Contact',
                   actionName: 'list'
               },
               state: {
                   filterName: 'Recent'
               },
           });
    }
}