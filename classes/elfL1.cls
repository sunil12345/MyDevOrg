public class elfL1{ 
 
 @AuraEnabled 
 public static Account getAccount(){
        return (Account) Database.query( 'SELECT Name, AccountLook__c, AccountLook__r.Name, Type,Rating, ParentId FROM Account where AccountLook__c != null LIMIT 1' )[0];
    }
    @AuraEnabled 
    public static Account saveAccount(Account account){
        upsert account;
        return account;
    }
}