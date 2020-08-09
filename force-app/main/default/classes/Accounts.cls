public with sharing class Accounts extends ApplicationDomain
                                                    implements IAccounts {

    public class AccountException extends Exception {}

    public Accounts(List<Account> sObjectList) {
        super(sObjectList);
    }

    public static IAccounts newInstance(List<Account> recordList) {
        return (IAccounts) Application.Domain.newInstance(recordList);
    }

    public static IAccounts newInstance(Set<Id> recordIds) {
        return (IAccounts) Application.Domain.newInstance(recordIds);
    }

    //standard constructor for SObject Domain Class
    public class Constructor implements fflib_SObjectDomain.IConstructable2 {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new Accounts(sObjectList);
        }

        public fflib_SObjectDomain construct(List<SObject> sObjectList, SObjectType sObjectType) {
            return new Accounts(sObjectList);
        }
    }
}