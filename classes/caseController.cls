public with sharing class caseController {
    @AuraEnabled
    public static Case getCase(string caseId) {
        return [select Id, Status from Case where Id = : caseId];
    }
}