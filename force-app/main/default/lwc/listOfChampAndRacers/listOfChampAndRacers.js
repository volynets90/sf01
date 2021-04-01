import { LightningElement, wire } from 'lwc';
import getRacerPosition from '@salesforce/apex/ListController.getRacerPosition';
import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';


const columns = [
     {label: 'Championat Name', fieldName: 'championatName', type: 'text',  editable: true },
     {label: 'Racer', fieldName: 'racerName', type: 'text',  editable: true },
     {label: 'Status', fieldName: 'status', type: 'text',  editable: true },
     {label: 'Date of champ', fieldName: 'champDate', type: 'date',  editable: true },
     {label: 'Years in racing', fieldName: 'yearsInRacing', type: 'text',  editable: true }
];

const DELAY = 300;
export default class ListOfChampAndRacers extends LightningElement {
    
    saveDraftValues=[];
    newdata;
    columns = columns;
    filterYear=null;
    handleSearchKeyChange(event) {
        window.clearTimeout(this.delayTimeout);
        const searchKey = event.target.value;
        this.delayTimeout = setTimeout(() => {
            this.filterYear = searchKey.length>0?searchKey:null;
            console.log(this.filterYear)
        }, DELAY);
        
    }
    @wire(getRacerPosition,{filterYear:'$filterYear'})
    list({data, error}){
        if(data){
            this.newdata = JSON.parse(data)
        }
        if(error){
            console.log(JSON.stringify(error)+' -error')
        }
    };
    handleSave(event) {
        
        console.log(this.saveDraftValues+' -from handle')
        console.log(event.detail.draftValues+' -from handle2')

        this.saveDraftValues = event.detail.draftValues;
        const recordInputs = this.saveDraftValues.slice().map(draft => {
            const fields = Object.assign({}, draft);
            return { fields };
        });

        const promises = recordInputs.map(recordInput => updateRecord(recordInput));
        Promise.all(promises).then(res => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Records Updated Successfully!!',
                    variant: 'success'
                })
            );
            this.saveDraftValues = [];
            return this.refresh();
        }).catch(error => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message: 'An Error Occured!!',
                    variant: 'error'
                })
            );
        }).finally(() => {
            this.saveDraftValues = [];
        });
    }
     async refresh() {
        await refreshApex(this.newdata);
    }
    
}