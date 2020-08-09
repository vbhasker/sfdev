@IsTest
private class TestOpportunityChangeTrigger {
    
    @IsTest
    static void testCreateAndUpdateOpportunity(){
        Test.enableChangeDataCapture();
        insert new Opportunity(Name = 'Sell 100 Widgets', StageName = 'Prospecting', CloseDate = Date.today().addMonths(3));
        Test.getEventBus().deliver();
        
        Opportunity[] oppRecords = [SELECT Id, Name, StageName FROM Opportunity];
        Opportunity opp = oppRecords[0];
        
        opp.StageName = 'Closed Won';
        update opp;
        
        Test.getEventBus().deliver();
         Task[] taskList1 = [SELECT Id,Subject FROM Task];
    	System.assertEquals(1, taskList1.size(),
      		'The change event trigger did not create the expected task.');
    }
}