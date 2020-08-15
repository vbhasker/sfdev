public with sharing class AddPrimaryContact implements Queueable {
  Contact contact;
  String stateCode;

  public AddPrimaryContact(Contact contact, String stateCode) {
    this.contact = contact;
    this.stateCode = stateCode;
  }

  public void execute(QueueableContext context) {
    List<Contact> newContacts = new List<Contact>();
    Contact copiedContact;
    for (Account account : [SELECT Id, Name FROM Account LIMIT 200]) {
      copiedContact = contact.clone(false, true, false, false);
      copiedContact.accountId = account.Id;
      newContacts.add(copiedContact);
    }
    insert newContacts;
  }
}