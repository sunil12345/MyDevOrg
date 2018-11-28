@isTest
private class testConcept1 {
	
    static testMethod void validateHelloWorld() {
		
        List<Contact> lstContact = new List<Contact>();
        
        Account objAcc= new Account(Name='Test Account New', Phone='123344');
        insert objAcc;
        
        system.debug('***QYERY1***'+[Select Id, Name, Phone From Account Where Id =: objAcc.Id]); 
        
        Contact objContact = new Contact();
        objContact.LastName= 'TESTLAST';
        objContact.AccountId = objAcc.Id;
		objContact.AccountNewField__c = objAcc.Id;          
        lstContact.add(objContact);
        
        insert lstContact; 
        System.assertNotEquals(lstContact[0].Id, null);
        
        
        
       system.debug('******'+[Select Id, Name, AccountId, AccountNewField__r.Phone From Contact Where  Contact.Id IN: lstContact]); 
       
        
        List <Contact> listCon = new LIst<Contact>([Select Id, Name, AccountId, AccountNewField__r.Phone From Contact Where Id = :lstContact[0].Id]);   
       system.debug('***listCon****'+listCon[0].AccountNewField__r.Phone);
        system.debug('test response toString: '+string.valueof(listCon[0].AccountNewField__r.Phone));
        
    }
}