public class editRecordSimulationController1 {

    @AuraEnabled
    public static string getTypeFromAccount(string recordId)
    {
        Account acc = [select Type from Account Where Id = :recordId limit 1];
        return acc.Type;
    }
}