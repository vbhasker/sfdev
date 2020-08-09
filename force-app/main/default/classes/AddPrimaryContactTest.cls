@IsTest
private class AddPrimaryContactTest {
    @TestSetup
    static void createAccounts(){
        List<Account> newAccounts = new List<Account>();
        for (Integer i=0; i<50; i++) {
            newAccounts.add(new Account(Name = 'Account ' + i, BillingStateCode = 'NY'));
            newAccounts.add(new Account(Name = 'Account ' + i, BillingStateCode = 'CA'));
        }
        insert newAccounts;
    }

    @IsTest
    static void testPrimaryContactAddition(){
        List<Account> accounts = [SELECT Id FROM Account];
        System.assertEquals(100, accounts.size(), 'Not found enough accounts for testing!');
        Test.startTest();
            AddPrimaryContact addContactQueueable = new AddPrimaryContact(new Contact(LastName = 'QueueLastName'), 'NY');
            System.enqueueJob(addContactQueueable);
        Test.stopTest();
        System.assertEquals(50, [SELECT Id FROM Contact WHERE AccountId IN (SELECT Id FROM Account WHERE BillingStateCode = 'NY')].size(), 'Contacts are not created');
    }
}
