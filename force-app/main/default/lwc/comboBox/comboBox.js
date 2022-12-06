import { LightningElement,track } from 'lwc';
import orderRecord from '@salesforce/apex/getttingOrderRecord.getOrdersFromStatus';

export default class ComboBox extends LightningElement {
    view=false;
    @track data;
    @track error;
    get options() {
        return [
            { label: 'Ordered', value: 'Ordered' },
            { label: 'Preparing food	', value: 'Preparing food' },
            { label: 'Cancelled', value: 'Cancelled' },
            { label: 'Out to delivery', value: 'Out to delivery' },
            { label: 'Delay', value: 'Delay' },
            { label: 'Delivered', value: 'Delivered' }
        ];
    }
    columns = [
        { label: 'Order Id', fieldName: 'Id' },
        { label: 'Customer Name', fieldName: 'Name' },
        { label: 'Resturant Name', fieldName: 'ResturantName' },
        { label: 'Dishes', fieldName: 'Dishes__c' },
        { label: 'Status', fieldName: 'Status__c' }
    ];
    
    handleChange(event) {
        var status = event.detail.value;
        console.log(status);
        orderRecord({status:status})
        .then(result => {
            this.data = result;
            var partial = this.data.map(row=>{
                return{...row,Name:row.Customer__r.Name,ResturantName:row.Resturant__r.Name};
            })
            this.data = partial;
            
           
            if(this.data.length>0){
                this.view=true;
            }
        })
        .catch(error => {
            this.error = error;
            console.log(this.error);
        });
    }
}
//https://www.infallibletechie.com/2021/03/how-to-display-parent-field-value-in.html