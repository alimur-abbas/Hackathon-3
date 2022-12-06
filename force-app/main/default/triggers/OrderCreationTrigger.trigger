trigger OrderCreationTrigger on Order__c (After insert,Before insert) {
    switch on Trigger.OperationType {
        when AFTER_INSERT {
            OrderCreationTriggerHandler.afterInsertUpdate(Trigger.new);
            OrderCreationTriggerHandler.afterInsert(Trigger.New);      
        }
        // when BEFORE_INSERT {
        //     OrderCreationTriggerHandler.beforeInsert(Trigger.New);      
        // }
            
       
    }

}