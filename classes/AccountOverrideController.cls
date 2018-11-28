public with sharing class AccountOverrideController {
    @AuraEnabled
    public static Id saveAccount(String accountName) {
        Account newAccount = new Account(Name = accountName);
        upsert newAccount;
        return newAccount.Id;
    }
}