public class AccountLookUpController {
 
/**
 * Aura enabled method to search a specified SObject for a specific string
 */
 @AuraEnabled
 public static Id createRecord(String fName, String lName, ID accountId )
 {
 try{
 Contact con = new Contact();
 con.FirstName = fName;
 con.LastName= lName;
 con.accountId = accountId;
 Insert con;
 return con.Id;
 }catch(Exception e){
 return null;
 }
 }
}