import { LightningElement,track,api } from 'lwc';
import getObjectsFromCustomSettings from '@salesforce/apex/DataLoaderToolHandler.getObjectsFromCustomSettings';
import insertrecord from '@salesforce/apex/DataLoaderToolHandler.insertObjectRecord';
import updateData from '@salesforce/apex/DataLoaderToolHandler.updateData';
import getAllFields from '@salesforce/apex/DataLoaderToolHandler.getAllFields';
import getPapaPerseStaticResource from '@salesforce/resourceUrl/papaparse1';
import { loadScript } from 'lightning/platformResourceLoader';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import {NavigationMixin} from 'lightning/navigation';

// const actions = [
//     { label: 'View', name: 'view' },
    
// ];


// const columns=[
//     {label:'ID', fieldName:'Id'},
//     {label:'Name', fieldName:'Name'},
//     {label:'Description', fieldName:'Description'},
    
//     {
//         type: 'button',
    
//         typeAttributes: { label : 'View' , name : 'view'}
//     }
// ]

export default class DataLoaderTool extends NavigationMixin (LightningElement) {
   
    @api allObjectCustomSetting = [];
    @track value='';
    loading = false;
    @api column=[];
    @api columns=[];
    uploadedFiles=[];
    datacolumns;
    rows = false;
    @track displayFile= true;
    showReadOnlyDataTable= false;
    showDataTable=false;
    //  uploadedFiles;
     get;
     recordId;
    //  columns=columns;
     data=[];
     papa;

    get options(){
        return this.allObjectCustomSetting;
    }
   
    connectedCallback(){
      getObjectsFromCustomSettings()
        .then(result=>{
            console.log('result1 ->', result)
            let arr= [];
            for(var i=0; i<result.length; i++){
                arr.push({label : result[i].Name, value : result[i].Name})
                console.log('arr ->', arr)
            }
            this.allObjectCustomSetting=arr ;
            this.allObjectCustomSetting.unshift({label:'---Select---',value:''})
            console.log('accOption ->', accOption)
        })
        .catch(error=>{
            //  window.alert("error :"+error)
          })

            Promise.all([
                loadScript(this, getPapaPerseStaticResource + '/papaparse.min.js')
            ])
                .then((message) => {
                    console.log(message);
                    this.papa = Papa;
                    console.log('Inside Of papa==>',this.papa)
                })
                .catch(error => {
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Error loading Importing',
                            message: error.message,
                            variant: 'error'
                        })
                    );
                }); 
       
      
    }
    handleChange(event){
        this.value=event.detail.value;
        this.displayFile= true;
        console.log('value --->:', this.value);

        const select = event.detail.value;
       getAllFields({
         objectname: select
       })
         .then((result) => {
           let data = JSON.parse(JSON.stringify(result));
           let lstOption = [];
         for (var i = 0;i < data.length;i++) {
             lstOption.push({value: data[i].QualifiedApiName,label: data[i].DeveloperName
             });
           }
           this.data1 = lstOption;
           this.showLoadingSpinner = false;
         })
         .catch((error) => {
           error;
         });
    }


    // parserInitialized = false;
    // renderedCallback() {
    //     if(!this.parserInitialized){
    //         loadScript(this, getPapaPerseStaticResource  + '/papaparse.min.js')
    //             .then(() => {
    //                 this.parserInitialized = true;
    //             })
    //             .catch(error => console.error(error));
    //     }
    // }

    uploadFileHandler(event) 
    {
       console.log('in upload method')
       console.log('event.target-->' ,event.target)
       console.log('event.target.files -->' ,event.target.files)
       console.log('event.target.files.length -->' ,event.target.files.length)
       
       if(event.target.files.length > 0){
        console.log('in if')
        let files = event.target.files;
        console.log('files-->', files);
        let self = this;
        console.log('self-->', self);

      //  this.loading = true;
        //console.log('file==>', files)
        this.papa.parse(files[0], {
            
            complete: function (results) {
                console.log('results ->', results)
                let columnList = results?.data[0];
                console.log('columnList----',columnList);

                columnList.forEach(element => {                 
                    self.columns.push({ label: element, fieldName: element });
                    self.column.push({label: element, fieldName: element,editable:true});
                    console.log('element==>' ,element);
                 
               
              });
                    console.log('self.columns-->',self.columns);            
                    console.log('self.column-->',self.column);
                self.column.push({
                      type: 'button',
                      typeAttributes: { label: 'View', name: 'view' }
              })

             for (let index = 1; index < results?.data?.length; index++) {
                const element = results.data[index];
                let recordData = {};                   
                for (let innerIndex = 0; innerIndex < element.length; innerIndex++) {
                    recordData[columnList[innerIndex]] = element[innerIndex];
                 }
                console.log('eachAccount-->',recordData);
                self.uploadedFiles.push(recordData);
                console.log('self.uploadedFiles-->',self.uploadedFiles);
            } 
         
            //    this.uploadedFiles = JSON.parse(JSON.stringify(results.data));
            //    this.loading = false;

            //    let uploadedFiles = JSON.parse(JSON.stringify(results.data));
            //    this.uploadedFiles11=uploadedFiles;
              // this.uploadedFiles11 = JSON.parse(JSON.stringify(results.data));
               //console.log('uploadedFiles==>', uploadedFiles);
               console.log('this.uploadedFiles==>', this.uploadedFiles);
            //    console.log('uploadedFiles====>', JSON.stringify(results.data));
            //    console.log('uploadedFiles123==>', this.uploadedFiles11);
            },
            error: (error) => {
                console.error(error);
                // this.loading = false;
            }
        })
        console.log('in after parse')
    }

    }
    nextButton(event){
        this.rows = true;

        let self=this
        console.log('this.uploadedFiles ->',this.uploadedFiles)
        console.log('this.value ->',this.value);
        console.log('self.value ->',self.value);
        console.log(' this.columns ->', this.columns);


        if(this.uploadedFiles!= undefined){
            console.log('inside the button')
            this.get=this.uploadedFiles;
            console.log( 'Get the value-->', this.get);
            
     insertrecord({objToInsert: this.get, objectname:  self.value, inserting : false })
        .then(result => {
            if(this.value==self.value){
                this.datacolumns = this.columns;
                this.data = result;
                console.log('Result in button-->',result);
                console.log('Result in button this.datacolumns-->',this.datacolumns);
                console.log('Result in button this.data-->',this.data);
                //console.log('Result assign to recordId-->',this.recordId);
            
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: this.value + 'Records display Sucessfully ',
                    variant: 'success',
                }),
            
            );
            }
        })
        .catch(error => {
            console.log(error);
            this.error = error;
            const event=new ShowToastEvent({
                title:'Error',
                variant:'error',
                message:'Error while displaying Records',
                mode:'dismissible'
             })
             this.dispatchEvent(event);
        });
        }
       this.showReadOnlyDataTable=true;
    }

    handleCreate(){
        this.showReadOnlyDataTable=false;
        let self=this
        console.log('this.uploadedFiles1 ->',this.uploadedFiles)
        console.log('this.value1 ->',this.value);
        console.log('self.value1 ->',self.value);
        console.log(' this.columns1 ->', this.columns);


        if(this.uploadedFiles!= undefined){
            console.log('inside the button to create')
            this.get=this.uploadedFiles;
            
            console.log( 'Get the value to create-->', this.get);
            
     insertrecord({objToInsert: this.get, objectname:  self.value, inserting : true })
        .then(result => {
            if(this.value==self.value){
                this.datacolumns = this.column;
                console.log('Result in button-->',this.datacolumns);
                this.data = result;
                console.log('inside the data to create', this.data)
                console.log('Result in button-->',result);
                //console.log('Result assign to recordId-->',this.recordId);
            
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: this.value + 'Records Created Sucessfully ',
                    variant: 'success',
                }),
            
            );
            }
        })
        .catch(error => {
            console.log(error);
            this.error = error;
            const event=new ShowToastEvent({
                title:'Error',
                variant:'error',
                message:'Error while creating Records',
                mode:'dismissible'
             })
             this.dispatchEvent(event);
        });
        }
        this.showDataTable=true;
    }

    handleSave(event){
        let self=this
    const updatedFields = event.detail.draftValues;
    console.log('updatedFields---->',JSON.stringify(updatedFields))

    try {
       
        updateData({data:updatedFields,objectname:self.value}).then(result=>{
            console.log('result----->',(result));
        })

        this.showFooter=true;
       
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: self.value + ' updated',
                variant: 'success'
            })
        );
    }
    catch(error) {
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Error updating or refreshing records',
                message: error.body.message,
                variant: 'error'
            })
      );
    };
    console.log('last line in handle save')
    }

    onRowActionAllObject(event){
        let self=this
        console.log('self last-->:', self);
        this[NavigationMixin.Navigate]({
            type :'standard__recordPage',
            attributes:{
             recordId:event.detail.row.Id,
             objectApiName: self.value,
             actionName:'view'
            }
         });
    }

}