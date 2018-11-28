trigger ArticleTeamMemberTrigger on Article_Team_Member__c (before insert, before update, after Insert, After update) {
 Enable_Triggers__c et = Enable_Triggers__c.getInstance('default');
    if(et == null || et.Enabled__c == true){
        ArticleTeamMemberService service = new ArticleTeamMemberService();
        if(Trigger.isbefore){
            if(Trigger.isinsert || Trigger.isupdate){
                ArticleTeamMemberService.SetStatusChangeTime(trigger.old, trigger.new);
            }
            
        }
        if(Trigger.isAfter){
            if(Trigger.isInsert){

            }
            if(Trigger.isUpdate){
                service.onAfterUpdate(Trigger.newMap, Trigger.oldMap);
                ArticleTeamMemberService.statusNotifications(trigger.oldmap, trigger.newMap);
            }
        }
        
        
    }
}