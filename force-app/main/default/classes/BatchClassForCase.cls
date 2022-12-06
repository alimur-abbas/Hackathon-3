public with sharing class BatchClassForCase  implements Database.Batchable<SObject>  {
   
   Public Database.QueryLocator start(Database.BatchableContext bc) {
   
      return Database.getQueryLocator('SELECT Id,CaseNumber,Origin,Reason,Case_Subtype__c,OwnerId,ContactId,Description,Priority,Status FROM Case WHERE Status = \'On progress\'limit 10');
   }

   public void execute(Database.BatchableContext bc, List<Case> scope) {
    System.debug('scope'+scope);
     String htmlBody = '';

    
    
    //open table..
    htmlBody = '<table border="1" style="border-collapse: collapse"><caption>Request Summary Data</caption><tr><th>Case Number</th><th>Case origin</th><th>Case Reason</th><th>SubType</th><th>Owner</th><th>Case Raised By</th><th>Case origin</th><th>Description</th><th>Priority</th><th>Status</th></tr>';

      for(Case c:scope){
        System.debug(scope);
      
        htmlBody += '<tr><td>' + c.CaseNumber + '</td><td>' + c.origin + '</td><td>' + c.Reason+ '</td><td>' + c.Case_Subtype__c + '</td><td>' + c.OwnerId + '</td><td>' + c.ContactId + '</td><td>' + c.Description+ '</td><td>' + c.Priority + '</td><td>' + c.Status + '</td></tr>';
      }
      htmlBody += '</table>';
      User users = [SELECT Id,Name,Email FROM User WHERE profile.Name='Case Manager'];
        //send email
        List<Messaging.Email> emailList = new List<Messaging.Email>();
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[]{'vkantkurre@gmail.com'};
        mail.setToAddresses(toAddresses);
        mail.setSubject('Case Summary');
        mail.setHtmlBody(htmlBody);
        emailList.add(mail);
        Messaging.sendEmail(emailList);
      System.debug('htmlBody: ' + htmlBody);
      
   }
    public void finish(Database.BatchableContext bc) {
        System.debug('finish');
       // Profile p = [SELECT Id,Name FROM Profile WHERE Name = 'Case Manager'];
        // User users = [SELECT Id,Name,Email FROM User WHERE profile.Name='Case Manager'];
        // //send email
        // List<Messaging.Email> emailList = new List<Messaging.Email>();
        // Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        // String[] toAddresses = new String[]{users.Email};
        // mail.setToAddresses(toAddresses);
        // mail.setSubject('Case Summary');
        // mail.setHtmlBody(htmlBody);
        // emailList.add(mail);
        // Messaging.sendEmail(emailList);
}

}
