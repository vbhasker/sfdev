public with sharing class AccountService {

    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(){
        return [SELECT Id, Name, Type, AccountNumber, Website, Industry FROM Account LIMIT 10];
    }
}