public class MuleForwardTool3 {
    
    @AuraEnabled
    public static Case grabCase(Id csid){ 
        List<Case> c = new List<Case>();
        try{
            c = [Select Product__c, Product1__c, CaseNumber 
                 FROM Case WHERE Id=:csid LIMIT 1];
            return c[0];
        }
        
        catch(Exception e){return(null);} 
    }    
    
    @AuraEnabled public static boolean  isMuleApprovable(Case thisCase) {  // Can this mule be approved?
        boolean mule2isApprovable = false;
        if (thisCase != null ) {
                mule2isApprovable = true;
            }
        return mule2isApprovable;
    }
    
}