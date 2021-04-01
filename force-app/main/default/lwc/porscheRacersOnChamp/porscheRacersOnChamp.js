import { LightningElement, wire } from 'lwc';
import getRacerPosition from '@salesforce/apex/PorscheTeamListController.getRacersByRecordType';

const columns = [
     {label: 'Championat Name', fieldName: 'championatName', type: 'text',  editable: true, sortable: true },
     {label: 'Racer', fieldName: 'racerName', type: 'text',  editable: true },
     {label: 'Status', fieldName: 'status', type: 'text',  editable: true },
     {label: 'Date of champ', fieldName: 'champDate', type: 'date',  editable: true, sortable: true },
     {label: 'Years in racing', fieldName: 'yearsInRacing', type: 'text',  editable: true, sortable: true },
     {label: 'Start position', fieldName: 'startPosition', type: 'text',  editable: true, sortable: true }
];
const DELAY = 300;
export default class PorscheRacersOnChamp extends LightningElement {
    newdata;
    columns = columns;
    filterYear=null;
    recordType='0121j000002NYiaAAG'
    defaultSortDirection = 'asc';
    sortDirection = 'asc';
    sortedBy;
    @wire(getRacerPosition,{recordType:'$recordType'})
    list({data, error}){
        if(data){
            this.newdata = JSON.parse(data)
        }
        if(error){
            console.log(JSON.stringify(error)+' -error')
        }
    };
    sortBy(field, reverse, primer) {
        const key = primer
            ? function(x) {
                  return primer(x[field]);
              }
            : function(x) {
                  return x[field];
              };

        return function(a, b) {
            a = key(a);
            b = key(b);
            return reverse * ((a > b) - (b > a));
        };
    }
    onHandleSort(event) {
        const { fieldName: sortedBy, sortDirection } = event.detail;
        const cloneData = [...this.newdata];

        cloneData.sort(this.sortBy(sortedBy, sortDirection === 'asc' ? 1 : -1));
        this.newdata = cloneData;
        this.sortDirection = sortDirection;
        this.sortedBy = sortedBy;
    }
}