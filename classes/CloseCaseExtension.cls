public without sharing class CloseCaseExtension
{
      
      @AuraEnabled
    public static Case updateCaseRecord(Id recordId){
        Case mycase = [SELECT Id, isClosed, Status FROM Case WHERE id=:recordId];
        mycase.Status  = 'Closed';
        
        Update mycase;
        return mycase;
    }
    
    public pageReference redirectPage(){
    
    
        PageReference pr = new PageReference('/');
       // pr.setRedirect(true);
        
    
        //return null;
         return new pageReference('/');
     
    }
    
    final ApexPages.StandardController controller;
    public CloseCaseExtension(ApexPages.StandardController controller)
    {
        this.controller = controller;
    }

    public PageReference closeCase()
    {
       Case  record = (Case)controller.getRecord();      
        record.Status = 'Closed';
        try
        {
            update record;
        }
        catch (DmlException dmx)
        {
            ApexPages.addMessages(dmx);
            return null;
        }
    PageReference pr = new PageReference('/'+record.Id);
    pr.setRedirect(true);
    

    //return null;
     return new pageReference('/'+record.Id);
    
}
}