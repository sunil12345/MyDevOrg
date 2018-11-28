global class R3S_ClientExpScheduler implements Schedulable{
    global void execute(SchedulableContext sc){
        //String query = 'select id from Lead where LastModifiedDate != LAST_N_DAYS:180';
        String strId = 'Q7F000001dKtg';
        String query = 'select id from Lead';
        deleteSubscribers delBatch = new deleteSubscribers(query);
        Id BatchProcessId = Database.ExecuteBatch(delBatch);
    }
}