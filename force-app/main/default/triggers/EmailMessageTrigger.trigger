trigger EmailMessageTrigger on EmailMessage (before insert) {
    system.debug('email is getting triggered');
    for(EmailMessage a : Trigger.New) {
        a.FromAddress = 'store123@hotmail.com';
        a.subject = 'updated from the trigger';
        a.BccAddress = 'store123@hotmail.com';
    }

}