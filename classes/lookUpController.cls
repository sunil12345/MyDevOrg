public class lookUpController {
    
   public static Map<String, Schema.SObjectType> GLOBAL_DESCRIBE = Schema.getGlobalDescribe();
    
    
   @AuraEnabled
 public static List < account > fetchAccount(String searchKeyWord) {
     
     system.debug('****GLOBAL_DESCRIBE****'+GLOBAL_DESCRIBE);
  String searchKey = searchKeyWord + '%';
  List < Account > returnList = new List < Account > ();
  List < Account > lstOfAccount = [select id, Name from account where Name LIKE: searchKey];
 
  for (Account acc: lstOfAccount) {
     returnList.add(acc);
     }  
  return returnList;
 }
}