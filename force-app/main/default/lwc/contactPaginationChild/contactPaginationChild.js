import { api, LightningElement,wire } from 'lwc';
import ContactPaginationLwcMethod from '@salesforce/apex/ContactPaginationLwcHandler.ContactPaginationLwcMethod';

export default class ContactPaginationChild extends LightningElement {

// @api conRecords=[];

viewRec;

// @wire(ContactPaginationLwcMethod)
// wiredAccounts({ error, data }) {
    
//     if (data) {
    
//         console.log('data--> ',data)
//         this.conRecords=data;
//     } else if (error) {
        
//         this.error = error;
//         this.conRecords = undefined;
//     }
// }


@api getSelectedRecId(data){

    console.log('view rec--> ',JSON.stringify(data))

    this.viewRec = data;


}
}