/**
 * @description       : 
 * @author            : Mr Md Alimur Rehman Abbas
 * @group             : 
 * @last modified on  : 11-17-2022
 * @last modified by  : Mr Md Alimur Rehman Abbas
**/
public with sharing class SalesforceConnect {
    public static void getCases(){
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:learning_integration/services/apexrest/Cases');
         req.setMethod('GET');
        // req.setHeader('Authorization','Bearer !AQUAQMZXuJIASupnzvfYGSJW7AX7xlQs7OD6C7UUtnadD8gxATwdmkkpgTaihM.zxKIo3K884Ya3WB3usZTx1zx1UCCPjHGs');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        // Deserialize the JSON string into collections of primitive data types.
        List<Object> results = (List<Object>) JSON.deserializeUntyped(res.getBody());
        for(Object obj : results){
            Map<String, Object> caseProps = (Map<String, Object>)obj;
            System.debug(caseProps);
            System.debug(caseProps.get('CaseNumber')+'-'+caseProps.get('Subject'));
        }
        System.debug(res.getBody());
    }
}
