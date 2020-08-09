public with sharing class AccountUpdatePromise {
    private List<Account> updateAccounts;

    public AccountUpdatePromise(List<Account> updateAccounts){
        this.updateAccounts = updateAccounts;
    }

    public void execute() {
        if (updateAccounts != null) {
            new Promise(new AccountLocationUpdate())
                .then(new AccountLocationUpdate())
//                .error(new Demo_PromiseError())
                .done(new AccountUpdateDone())
                .execute(this.updateAccounts);
        }
    }

    public class AccountLocationUpdate implements Promise.Deferred {

        // this is the required method for a PromiseStep class.
        public Object resolve(Object incoming) {
            List<Account> updateAccounts = new List<Account>();
            if (incoming != null){
                List<Account> incomingAccounts = (List<Account>) incoming;
                if (incomingAccounts.size() > 0){
                    Account account = incomingAccounts.remove(0);
                    System.debug('@ Account Id => ' + account.Id);
                    account.NumberofLocations__c = 99;
                    updateAccounts.add(account);
                    update updateAccounts;
                } else {
                    incomingAccounts = null;
                }
                return incomingAccounts;
            } else {
                return null;
            }
        }
    }

    public class AccountUpdateDone implements Promise.Done {
        // This is used to demonstrate the use of a class instance var populated by a constructor
        // Because this is an installable package i'm using an account.
        @TestVisible
        private Account internalAccount;
        @TestVisible
        private String completed;

        // Constructors
        public AccountUpdateDone() {
        } // No op constructor

        public AccountUpdateDone(Account incomingAccount) {
            this.internalAccount = incomingAccount;
        }

        // This is the main method that the Promise.done interface requires.
        // you could use this to persist a record, or to write a log.
        public void done(Object incomingObject) {
            // we could do nothing here - NOOP but we could also do something with the incomingObject
            if (incomingObject == null) {
                System.debug('@ Queueable finished the job!!');
            } else {
                System.debug(incomingObject);
                System.debug(((List <Account>)incomingObject).size());
                AccountUpdatePromise acctUpdatePromise = new AccountUpdatePromise((List<Account>)incomingObject);
                acctUpdatePromise.execute();
            }
        }
    }

    public class AccountUpdateError implements Promise.Error {
        @TestVisible
        private String errorMessage;

        public AccountUpdateError() {
        }
        // This is the main interface method that you must implement
        // note that it does have a return type, and in this case I'm using the
        // promise.serializableData type. This will pass the 'error occured' string to the done handler
        public Object error(Exception e) {
            //for now, just dump it to the logs
            system.debug('Error Handler received the following exception ' + e.getmessage() + '\n\n' + e.getStackTraceString());
            //Make the error available for testing.
            this.errorMessage = e.getMessage();
            //Alternatively, you could do any number of things with this exception like:
            // 1. retry the promise chain. For instance, if an external service returns a temp error, retry
            // 1a. Use the flow control object to cap the retry's
            // 2. log the error to a UI friendly reporting object or audit log
            // 3. Email the error report, and related objects to the affected users
            // 4. post something to chatter.

            return e;
        }
    }
}