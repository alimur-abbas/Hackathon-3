global with sharing class ScheduleBatch implements System.Schedulable {
    global void execute(SchedulableContext sc) {
        BatchClassForCase batchClassForCase= new BatchClassForCase();
        Database.executeBatch(batchClassForCase);
    }
}
