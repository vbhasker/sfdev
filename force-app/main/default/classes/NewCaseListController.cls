/**
 * Created by vinodh on 2/9/20.
 */

public with sharing class NewCaseListController {
    public List<Case> getNewCases(){
        return [SELECT Id, CaseNumber FROM Case WHERE Status = 'New'];
    }
}