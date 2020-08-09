public inherited sharing class AccountsSelector extends ApplicationSelector
                                                implements IAccountsSelector {

    public static IAccountsSelector newInstance() {
        return (IAccountsSelector) Application.Selector.newInstance(Account.SObjectType);
    }

    public Schema.SObjectType getSObjectType() {
        return Account.SObjectType;
    }

    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
                Account.Id, Account.Name
        };
    }
}