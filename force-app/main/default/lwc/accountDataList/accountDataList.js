import { LightningElement, wire, track } from 'lwc';
import getAccountList from '@salesforce/apex/AccountService.getAccounts'

const columns = [
    { label: 'Customer', fieldName: 'Name', sortable:true },
    { label: 'Account Number', fieldName: 'AccountNumber' },
    { label: 'SIC', fieldName: 'Industry', sortable:true },
    { label: 'Website', fieldName: 'Website', type: 'url' },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' },
];

export default class accountDataList extends LightningElement {
    @track columns = columns;
    @wire(getAccountList) accounts;

    updateColumnSorting(event) {
        const fieldName = event.detail.fieldName;
        const sortDirection = event.detail.sortDirection;
        // assign the latest attribute with the sorted column fieldName and sorted direction TODO: This is something that
        this.sortedBy = fieldName;
        this.sortedDirection = sortDirection;
        this.data = this.sortData(fieldName, sortDirection);
   }
}