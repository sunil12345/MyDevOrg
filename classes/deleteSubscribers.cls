global class deleteSubscribers implements Database.Batchable<sObject>{
    global final String Query;
    global deleteSubscribers(String q){
        Query=q;
    }

    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC,List<Lead> scope){
        delete scope;
    }

    global void finish(Database.BatchableContext BC){}
}