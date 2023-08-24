import { LightningElement, api } from 'lwc';
import sendTamplateMessage from '@salesforce/apex/WhatsappController.sendTamplateMessage';

export default class SalesforceWhatsappIntegration extends LightningElement {

    @api recordId;

    onSendMessageTamplate(){

        sendTamplateMessage({contactId : this.recordId}) 

        .then(result => {
            console.log('result-->', result);
            window.alert('Message Send Successfully');
    })
    .catch(error => {
        console.log('error-->', error);
        window.alert('Message Failed');
    });
    }
}