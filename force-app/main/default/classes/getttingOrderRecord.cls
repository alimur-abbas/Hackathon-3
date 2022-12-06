public with sharing class getttingOrderRecord {
    @AuraEnabled(cacheable=true)
    public static List<Order__c> getOrders(Id recordId) {
        List<Order__c> orders = [SELECT id ,Dishes__c  FROM Order__c WHERE Customer__c = :recordId];
        return orders;
    }
    @AuraEnabled(cacheable=true)
    public static List<Order__c> getOrdersFromStatus(String  status) {
        List<Order__c> orders = [SELECT id , Customer__r.Name , Resturant__r.Name,Dishes__c,Status__c  FROM Order__c WHERE Status__c = :status];
        return orders;
    }
}
