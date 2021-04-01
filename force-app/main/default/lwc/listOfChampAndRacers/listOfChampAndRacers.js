import { LightningElement, wire, api, track } from 'lwc';
import getRacerPosition from '@salesforce/apex/ListController.getRacerPosition';
import RACER_OBJECT from '@salesforce/schema/Racer__c';
import NAME_FIELD from '@salesforce/schema/Racer__c.Name';
const columns = [
     {label: 'Championat Name', fieldName: 'championatName', type: 'text',  editable: true },
     {label: 'Racer', fieldName: 'racerName', type: 'text',  editable: true },
     {label: 'Status', fieldName: 'status', type: 'text',  editable: true },
     {label: 'Date of champ', fieldName: 'champDate', type: 'date',  editable: true },
     {label: 'Years in racing', fieldName: 'yearsInRacing', type: 'text',  editable: true }
];

let data;
const DELAY = 300;
export default class ListOfChampAndRacers extends LightningElement {
 
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
    
}