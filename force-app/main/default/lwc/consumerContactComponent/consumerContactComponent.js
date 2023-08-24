import {LightningElement,api} from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import {NavigationMixin} from 'lightning/navigation';
import lstContactFields from '@salesforce/apex/ConsumerContactController.lstContactFields';
import getRecordTypeName from '@salesforce/apex/ConsumerContactController.getRecordTypeName'


export default class ConsumerContactComponent extends NavigationMixin(LightningElement) {
	isModalShow = true;
	@api recordId;
	fields;
	recordType;

	//save
	handleSuccess(event) {
		console.log("INISDE")
		this.isModalShow = false;
		this[NavigationMixin.Navigate]({
			type: 'standard__recordPage',
			attributes: {
				recordId: event.detail.id,
				objectApiName: 'Contact',
				actionName: 'view'
			},
		});
		this.dispatchEvent(new ShowToastEvent({
			title: 'Success!',
			message: 'Record created!',
			variant: 'success'
		}))
	}

	handleError(event){
        const evt = new ShowToastEvent({
            title: 'Error!',
            message: event.detail.detail,
            variant: 'error',
            mode:'dismissable'
        });
        this.dispatchEvent(evt);
    }

	//fetching fields dynamically
	connectedCallback() {
		lstContactFields()
			.then(result => {
				this.fields = result;
				console.log('fields=>', this.fields);
			})
			.catch(error => {
				this.error = error;
			});

		//RecordTypeName
		getRecordTypeName()
			.then(result => {
				this.recordType = result;
				console.log('recordType=>', this.recordType);
			})
			.catch(error => {
				this.error = error;
			});
	}
    //cancel
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