public class accountTriggerHandler{

public void afterUpdate(List<Account> originalAccount, 
                          Map<ID, Account>  originalAccountMap,
                          List<Account>updatedAccount, 
                          Map<ID, Account>  updatedAccountMap) {
                          
                          
                          List<Account> Acclist = new List<Account>();
    Set<Id> AccIds = new Set<Id>();
    
    
    Account objAccount = new Account();
    system.debug('*****updatedAccountMap****'+updatedAccountMap);
    for(Id accid : updatedAccountMap.keySet())
    {
    
    System.debug('****Check before*****' + originalAccountMap.get(accid).IsCustomerPortal+'---'+updatedAccountMap.get(accid).IsCustomerPortal );
    
        system.debug('***check Query****'+[Select Id,IsCustomerPortal From Account Where Id =: accid ]);
        objAccount = [Select Id,IsCustomerPortal From Account Where Id =: accid ];
        
        Account newac = updatedAccountMap.get(accid);
        
        system.debug('*****newac ****'+objAccount.IsCustomerPortal);
        
        System.debug('acc trigger&&&&' + originalAccountMap.get(newac.id).IsCustomerPortal+'---'+newac.IsCustomerPortal );
        
        if(originalAccountMap.get(newac.id).IsCustomerPortal != objAccount.IsCustomerPortal){
        
        
        system.debug('******I M HERE******');
        }
        
    }
   }


}