trigger countContact on Contact (after insert, after update, after delete, after undelete) {

List<Account> lstAccount = new List<Account>();
Set<Id> setId = new Set<Id>();

If(Trigger.isDelete){
    
    For(Contact objContact : Trigger.Old){
        
        setId.add(objContact.AccountId);
    }
}

else If(Trigger.isUpdate){
    
    for(Contact objContact: Trigger.New){
        
        setId.add(objContact.AccountId);
        
    }
    for(Contact objContact: Trigger.Old){
        
        setId.add(objContact.AccountId);
        
    }
}

else {
for(Contact objContact: Trigger.New){
        
        setId.add(objContact.AccountId);
       
}
}

 AggregateResult[] groupedResults = [SELECT COUNT(Id), AccountId FROM Contact where AccountId IN :setId GROUP BY AccountId ];
 
 for(AggregateResult ar:groupedResults) {
     
     
     Account objAccount = new Account(Id = (Id)ar.get('AccountId'));
     
     objAccount.CountContact__c = (INTEGER)ar.get('expr0');

     
     lstAccount.add(objAccount);
     
 }
 
 update lstAccount; 

}