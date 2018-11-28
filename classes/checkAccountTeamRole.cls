public class checkAccountTeamRole
{
    @InvocableMethod
    public static void checkAccntMeamber(List<Id> AccountIds)
    {
        List<AccountTeamMember> lstAccountTeamMember=[select id from AccountTeamMember
                          where AccountId IN :AccountIds
                       ];
       
       system.debug('*lstAccountTeamMember***'+lstAccountTeamMember);
   }
}