import { LightningElement,track,wire,api} from 'lwc';
import paginationApexMethod from '@salesforce/apex/paginationApexHandler.paginationApexMethod';

const columns = [
    { label: 'Name', fieldName: 'Name'},
    { label: 'Phone', fieldName: 'Phone' },
    { label: 'Email', fieldName: 'Email' }
];

export default class PaginationLwc extends LightningElement 
{
    @track value;
    @track error;
    @track data;
   
    @api searchKey = '';
    result;
    
    @track page = 1;
    @track items = [];
    @track data = [];
    @track columns;
    @track startingRecord = 1;
    @track endingRecord = 0;
    @track pageSize = '5';
    @track totalRecountCount = 0;
    @track totalPage = 0;
   
    get options() {
        return [
            { label: '5', value: '5' },
            { label: '10', value: '10' },
            { label: '20', value: '20' },
            { label: '50', value: '50' },
           
        ];
    }

    handleChange(event) {
        this.pageSize = event.detail.value;
        this.page=1;
       
        this.processRecords(this.items);
        this.displayRecordPerPage(this.page);
    }

    @wire(paginationApexMethod, { searchKey: '$searchKey' })
    wiredAccounts({ error, data }) {
     
        if (data) {
        
            this.processRecords(data);
            this.error = undefined;
        } else if (error) {
         
            this.error = error;
            this.data = undefined;
        }
    }

    processRecords(data) {
        this.items = data;
        this.totalRecountCount = data.length;
        this.totalPage = Math.ceil(this.totalRecountCount / this.pageSize);
        this.data = this.items.slice(0, this.pageSize);
       // this.endingRecord = this.pageSize;
        this.columns = columns;
    }

    //clicking on previous button this method will be called
    previousHandler() {
     //   this.isPageChanged = true;
        // if (this.page > 1) {
            this.page = this.page - 1; //decrease page by 1
            this.displayRecordPerPage(this.page);
        // }
       
    }

    //clicking on next button this method will be called
    nextHandler() {
        // this.isPageChanged = true;
        // if ((this.page < this.totalPage) && this.page !== this.totalPage) {
            this.page = this.page + 1; //increase page by 1
            this.displayRecordPerPage(this.page);
        // }
        
    }
    firstHandler(){
        // if (this.page > 1){
            this.page=1;
            this.displayRecordPerPage(this.page);
        // }
    }
    lastHandler(){
        // if ((this.page < this.totalPage) && this.page !== this.totalPage) {
            this.page=this.totalPage;
            this.displayRecordPerPage(this.page);
        // }
    }

    //Method to displays records page by page
    displayRecordPerPage(page) {
        this.startingRecord = ((page - 1) * this.pageSize);
        this.endingRecord = (this.pageSize * page);
       // this.endingRecord = (this.endingRecord > this.totalRecountCount) ? this.totalRecountCount : this.endingRecord;
        this.data = this.items.slice(this.startingRecord, this.endingRecord);
        this.startingRecord = this.startingRecord + 1;
    }
    
    handleKeyChange(event) {
        this.searchKey = event.target.value;
        this.page=1;
        var data = [];
        for (var i = 0; i < this.items.length; i++) {
            // if (this.items[i] != undefined && this.items[i].Name.includes(this.searchKey)) {
                data.push(this.items[i]);
           // }
        }
        this.processRecords(data);
    }
}