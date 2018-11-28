public class myControllerExtension {

    private final Opportunity acct;
    
    List<Child_Opp__c> lstCHildOpp {get;set;}
    List<ChildOpp2__c> lstCHildOpp2 {get;set;}
    // The extension constructor initializes the private member
    // variable acct by using the getRecord method from the standard
    // controller.
    public myControllerExtension(ApexPages.StandardController stdController) {
        this.acct = (Opportunity)stdController.getRecord();
    }

   
}