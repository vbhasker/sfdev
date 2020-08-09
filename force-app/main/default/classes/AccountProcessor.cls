public with sharing class AccountProcessor {

    public static void countContacts(List<Id> accountIds){
        Integer cpuTime = Limits.getCpuTime();
        Integer heapSize = Limits.getHeapSize();
        List<Account> accts = [SELECT Id, Number_of_Contacts__c FROM Account WHERE Id IN :accountIds];
        
        for (Account acct : accts){
            acct.Number_of_Contacts__c = [SELECT count() FROM contact WHERE account.Id = :acct.Id];
        }
        update accts;
        System.debug(LoggingLevel.ERROR, 'Total DML Statements: '+Limits.getDmlStatements());
        System.debug(LoggingLevel.ERROR, 'Total CPU Time:'+(Limits.getCpuTime() - cpuTime));
        System.debug(LoggingLevel.ERROR, 'Total heap size'+(Limits.getHeapSize() - heapSize));
    }
}