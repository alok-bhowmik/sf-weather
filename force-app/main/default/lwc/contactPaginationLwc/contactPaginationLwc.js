import { LightningElement,track, wire } from 'lwc';
import ContactPaginationLwcMethod from '@salesforce/apex/ContactPaginationLwcHandler.ContactPaginationLwcMethod';
import returnSearchResult from '@salesforce/apex/ContactPaginationLwcHandler.returnSearchResult';
 
 
export default class ContactPaginationLwc extends LightningElement {

   // @track contactRecords=ContactPaginationLwcMethod;

   @track Records=[];
   searchKey;
    
   @wire(ContactPaginationLwcMethod)
   wiredAccounts({ error, data }) {
    
       if (data) {
       
        console.log('data--> ',data)
         this.Records=data;
       } else if (error) {
        
           this.error = error;
           this.Records = undefined;
       }
   }

   searchHandle(event){

    console.log('value --> ',event.target.value)

    returnSearchResult({searchKey:event.target.value})
    .then(res=>{

        console.log('res--> ',res)
        this.Records = res;
    })
    .catch(err=>{



    })

   }

    view(event)
    {
        console.log('target--> ',JSON.stringify(event.target.value));


        this.template.querySelector('c-contact-pagination-child').getSelectedRecId(event.target.value);
    }

}