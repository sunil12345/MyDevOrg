@IsTest global with sharing class  testCreatePortalUser {    
@IsTest(SeeAllData=true) global static void testCreatePortalUserRecord () {
 
 //Insert The accounts
        List<Account> accts = new List<Account>();

            for(Integer i=0;i<10;i++)
             {
                Account a = new Account(Name='TestAccount' + i, 
                                        BillingCity ='Kolkata',
                                        BillingCountry ='India',
                                        BillingPostalCode='560048',
                                        BillingState='Kolkata',
                                        Phone='8904145771',
                                        BillingStreet='Starlit Housing Complex');

                accts.add(a);
            }
    insert accts;
    
   //Insert The corresponding Contacts

    List<Contact> cons = new List<Contact>();
    for (Integer j=0;j<10;j++) {
        Account acct = accts[j];            
        // For each account just inserted, add contacts
        for (Integer k=2*j;k<2*(j+1);k++) {
            cons.add(new Contact(firstname='Test'+k,
                                 lastname='Test'+k,
                                 AccountId=acct.Id));
        }
    }
    // Insert all contacts for all accounts
    insert cons;
    
    system.debug('**1*cons***'+cons);
    //Insert the test user
    Profile p = [SELECT Id FROM Profile WHERE Name='High Volume Customer Portal User'];
    
    system.debug('****p**'+p);
    
    
    User u = new User(Alias = 'standt', Email='Testuserportal@atos.net', 
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
        LocaleSidKey='en_US', ProfileId = p.Id, ContactId=cons[0].id,
        TimeZoneSidKey='America/Los_Angeles', UserName='Testuserportal1989@atos.net');
        
        system.debug('**1*u1212***'+u);
        
        insert u;
         //u.IsPortalEnabled = true;
         //u.ContactId=cons[0].id;
         
         system.debug('**1*u*'+u.IsPortalEnabled);
         
         //update u;
    
    system.debug('***u*'+[Select Id, IsPortalEnabled From User where Id =: u.Id]);
        //return u;
     //Insert the test user
   

       
}
}