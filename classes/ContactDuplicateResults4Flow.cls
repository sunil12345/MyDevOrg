/*****************************************************************
 * Created By: Dmitri Goncharov                   *
 * Date: 6/13/2017                         *
 * Jira Ticket: https://jira.cnvrmedia.net/browse/MISSF-530     *
 * Test Class: ContactDuplicateResults4FlowTest           *          
 *****************************************************************/
global class ContactDuplicateResults4Flow {

    @InvocableMethod
    global static List<list<String>> getDuplicateContacts(List<Contact> cntcts){ // because this class is called out of a flow, it has to return a list of lists
        
        List<Contact> matchedContacts = ContactDuplicateResults.getDuplicateContacts(cntcts[0]); // get duplicate accounts out of a generic class (null if not account matches were found)
        
        System.debug(loggingLevel.INFO, 'Matched contacts: ' + matchedContacts);
        
        // check if any duplicates were returned
        if(matchedContacts != null){
          
            List<String> contactToStrList = new List<String>(); // holds value of a matched account in a string format
          List<List<String>> listOfListOfCntctsStrings = new List<List<String>>(); // holds a return List of list of strings back to the flow
            
            // loop through account matches, if any
            for(Contact c : matchedContacts) {
                String matchedCntcts = '<p><a href="' + URL.getSalesforceBaseUrl().toExternalForm() + '/' + c.Id +'">' + c.Name + '</a></p>';
                contactToStrList.add(matchedCntcts);
            }
            
            System.debug(loggingLevel.INFO, 'contactToStrList: ' + contactToStrList);
            
            // create list of lists to pass to a flow (the flow will see it just a list)
            if(contactToStrList.size() > 0) listOfListOfCntctsStrings.add(contactToStrList);
            
            // pass list of lists of strings to the flow
            if (listOfListOfCntctsStrings.size() > 0) return listOfListOfCntctsStrings;
        } 
        
        return null;
        
    }
}