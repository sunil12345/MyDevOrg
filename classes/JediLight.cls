public with sharing class JediLight { 
@AuraEnabled 
public static User getUser() { 
return [select Id, Name from User Limit 1]; 
} 
}