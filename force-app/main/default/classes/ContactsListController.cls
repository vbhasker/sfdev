/**
 * Created by vinodh on 2/9/20.
 */

public with sharing class ContactsListController {
    private String sortOrder = 'LastName';

    public void sortByLastName() {
        this.sortOrder = 'LastName';
    }

    public void sortByFirstName() {
        this.sortOrder = 'FirstName';
    }

    public List<Contact> getAccountContacts() {
        List<Contact> results = Database.query(
                'SELECT Id, FirstName, LastName, Title, Email ' +
                        'FROM Contact ' +
                        'ORDER BY ' + sortOrder + ' ASC ' +
                        'LIMIT 10'
        );
        return results;
    }
}