@IsTest
private class AccountProcessorTest {
    
    @IsTest
    private static void testCountContacts(){
        Account acct = new Account(Name = 'Test 1');
        insert acct;

        Integer contactCounts = 4;
        List<Contact> conts = new List<Contact>();
        for (Integer i = 0; i < contactCounts; i++) {
            Contact con = new Contact(LastName = 'Test'+String.valueOf(i), AccountId = acct.Id);
            conts.add(con);
        }
        insert conts;

        Test.startTest();
            List<Id> acctIds = new List<Id>();
            acctIds.add(acct.Id);

            AccountProcessor.countContacts(acctIds);
        Test.stopTest();

        System.assertEquals(contactCounts, [SELECT count() FROM contact WHERE account.Id = :acct.Id], 'The contact counts does not match account contacts.');
    }
}