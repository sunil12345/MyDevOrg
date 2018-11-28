public with sharing class DisplayCaseController1 {

    @AuraEnabled
    public static Case fetchCase(String caseID) {
        
        
        system.debug('**caseID*****'+ caseID);
        return New Case(subject= 'test');
    }
    
    
}