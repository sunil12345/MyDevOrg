public with sharing class PersonAccountFlowExtension {
    public final Flow.Interview.CallPageNameFlow createContractFromAccount {get; set;}
    public PersonAccountFlowExtension(ApexPages.StandardController stdController) {}
    public String getFinishLoc() { 
         return createContractFromAccount==null? 'home/home.jsp': createContractFromAccount.AccountId; 
    }
     Public PageReference getFinishPageRef(){
        PageReference pageRef = new PageReference('/' + getfinishLoc());
        pageRef.setRedirect(true);
        return pageRef;
    }
}