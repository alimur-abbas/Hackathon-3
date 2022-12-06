import { LightningElement, wire, api,track } from 'lwc';
import getValue from '@salesforce/apex/getttingOrderRecord.getOrders';

export default class OrderDetail extends LightningElement {
    @api recordId;
    @track record;
    @track error;
    len;

    // @wire(getValue,{recordId:'$recordId'}) orders;
    // size= this.orders.data.length;
   
        @wire (getValue, { recordId: '$recordId'})
            wiredAccount({ error, data }) {
        if (data) {
            this.record = data;
            this.len=this.record.length;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.record = undefined;
        }
        // console.log(this.orders.data);
        // console.log(this.size);
    
    }
        
}