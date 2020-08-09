@IsTest
private with sharing class LeadProcessorTest {

    @TestSetup
    static void createTestData(){
        List<Lead> lds = new List<Lead>();
        
        for (Integer i=0; i<10; i++){
            Lead ld = new Lead(LastName = 'lastname'+String.valueOf(i),
                            Company = 'company'+String.valueOf(i),
                            Status = 'Open');
            lds.add(ld);
        }
        insert lds;
    }

    @IsTest
    static void testLeadSource(){
        LeadProcessor batch = new LeadProcessor();
        Test.startTest();
            Database.executeBatch(batch);
        Test.stopTest();
        System.assertEquals(0, [SELECT count() FROM Lead WHERE LeadSource != 'Dreamforce'], 
                                        'Some leads does not have lead source as Dreamforce');
    }
}