public class DisplayCaseController {

    @AuraEnabled
    public static Case fetchCase(Id caseID) {
    
    system.debug('**caseID**'+caseID);
        if(caseID == null) {
            return [SELECT ID, Subject, Description, STATUS from Case LIMIT 1];
        }
        
        List<Case> cases = [ SELECT Id, Subject, Description, Status from CASE where ID = :caseID ];
        
        if(cases.size() == 0) {
        
        system.debug('**cases **'+cases );
        
            return [SELECT ID, Subject, Description, STATUS from Case LIMIT 1];
        } else {
        
        system.debug('**cases1 **'+cases );
            return cases[0];
        }        
    }
    
    
}