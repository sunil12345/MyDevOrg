public with sharing class ctrlRequestOrderSchedule  {
  //Use @AuraEnabled to enable client- and server-side access to the method
    @AuraEnabled
    public static String requestOrderSchedule(String strRecordId) {
        string strReturnValue = '';
        try
        {
            List<Contact> lstUpdate = new List<Contact>();
            System.debug('strRecordId: '+strRecordId);
            Contact quot = [Select Id,From_Process__c, From_Button__c from Contact where Id = :strRecordId limit 1 ];
            
                Contact updatedQuote = new Contact(Id = quot.Id, From_Button__c = true);
                
                
                update updatedQuote;
                
  
                  strReturnValue = 'Success';
            
        }
        catch (Exception ex)
        {
            strReturnValue = ex.getMessage();
        }
            
        return strReturnValue;
    }
}