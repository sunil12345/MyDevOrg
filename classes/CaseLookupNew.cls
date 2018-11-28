public class CaseLookupNew {
    
    
    @AuraEnabled
    public static Case getCaseData(Id caseId){
        
        //String strRecordTypeId = [SELECT Id, RecordTypeId From Case where Id =:caseId].RecordTypeId;
            
       // system.debug('****strRecordTypeId***'+strRecordTypeId);
        
        return [select id,ContactId, Origin, Status, Reason from Case 
                where Id =:caseId
               
               ];
    }
    
    
    
}