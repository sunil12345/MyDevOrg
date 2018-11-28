/*****************************************************************
 * Created By: Dmitri Goncharov                   *
 * Date: 6/12/2017                         *
 * Jira Ticket: https://jira.cnvrmedia.net/browse/MISSF-530     *
 * Test Class: ContactDuplicateResults4FlowTest          *          
 *****************************************************************/
public class ContactDuplicateResults {
    
    public static List<Contact> getDuplicateContacts(Contact c){
        
        // variable to hold matched accounts
        List<Contact> matchedContacts = new List<Contact>();
        
        c.AccountId = null;
                
        // perform database save to see if an account can be created
        Database.SaveResult result = Database.insert(c, false);
        
        System.debug(loggingLevel.INFO, 'Contact Id: ' + c.Id + '; Contact Name: ' + c.Name);
        System.debug(loggingLevel.INFO, 'Result: ' + result);
                
        // if error, there were duplicate accounts based on matching rules
        if(!result.isSuccess()){
            for(Database.Error error : result.getErrors()){
                
                // only go through duplicate errors
                if(error instanceof Database.DuplicateError){
                    Database.DuplicateError duplicateError = (Database.DuplicateError) error;
                    Datacloud.DuplicateResult duplicateResult = duplicateError.getDuplicateResult();
                    
                    Datacloud.MatchResult[] matchResults = duplicateResult.getMatchResults();
                    
                    for(Datacloud.MatchResult duplicateMatchResult : matchResults){
                        List<Datacloud.MatchRecord> matchRecords = duplicateMatchResult.getMatchRecords();
                        
                        for(Datacloud.MatchRecord mr : matchRecords) matchedContacts.add((Contact)mr.getRecord());                             
                    }
                }
            }
                        
        } else { // there were no duplicate accounts and the account was successfully created in the database
            delete c;
        }
        
        System.debug(loggingLevel.INFO, 'Matched contacts: ' + matchedContacts);
        
        if(matchedContacts.size() > 0 ) return matchedContacts;
        else return null;
    }

}