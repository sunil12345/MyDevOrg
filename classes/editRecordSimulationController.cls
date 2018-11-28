public class editRecordSimulationController{

    @AuraEnabled
public static Account getTypeFromAccount(Id recordId) {
    
    List<Account> lstAccount= new List<Account>();
    
    return ([Select Id, Type From  Account where Id =: recordId]);
    
    //return lstAccount;
}


}