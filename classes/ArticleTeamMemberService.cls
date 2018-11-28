public class ArticleTeamMemberService {

   // public static final String UNDER_REVIEW = 'Under Review';
    Public Static List<Messaging.SingleEmailMessage> messages;
    
    Public static void SetStatusChangeTime(List<Article_Team_Member__c> old, List<Article_Team_Member__c> updated){
        map<id, Article_Team_Member__c> oldMap = new map<id, Article_Team_Member__c>();
        
        // before insert handling
        if(old ==null){
            if(!updated.isEmpty()){
                for(Article_Team_Member__c atm: updated){
                    atm.Status_Change_Time__c = System.now();
                }
            } 
        } else if(old.isEmpty()){       
            if(!updated.isEmpty()){
                for(Article_Team_Member__c atm: updated){
                    atm.Status_Change_Time__c = System.now();
                }
            }
        }else{
            for(Article_Team_Member__c a: old){
                oldMap.put(a.id, a);
            }
            for(Article_Team_Member__c atm: updated){
                if(oldMap.get(atm.id) !=null){
                    if(atm.Status__c != oldMap.get(atm.id).Status__c){
                        atm.Status_Change_Time__c = System.now();
                    }
                }
            }
        }
    }
    
    /*
     * Concen-172
     * 
     */ 
    
    public static void SendNotification(){
       
        System.debug(messages);
        messaging.sendEmail(messages);
       
    }
    /*
     * Concen-172 
     * filter article team member based on criteria from the story to build email messages
     * 
     */ 
    public static void statusNotifications(map<id, Article_Team_Member__c> oldMap,map<id, Article_Team_Member__c> newMap){
        
        List<Article_Team_Member__c> publisherTeamstoUpdate = new List<Article_team_member__c>();
        List<Article_Team_Member__c> reviewerTeamstoUpdate = new List<Article_team_member__c>();
        List<Article_Team_Member__c> creatorstoNotify = new List<Article_Team_Member__c>();
        for(id i : newMap.keySet()){
            if(oldMap.get(i) !=null && oldMap.get(i).status__c !=newMap.get(i).status__c){
                creatorstoNotify.add(newMap.get(i)); 
                if( newMap.get(i).role__c == 'Reviewer'&& newMap.get(i).Status__c == 'Ready for Review'){
                    reviewerTeamstoUpdate.add(newMap.get(i));
                }
                if( newMap.get(i).role__c == 'Publisher'&& newMap.get(i).Status__c == 'Ready to be Published'){
                    publisherTeamstoUpdate.add(newMap.get(i));
                }
            }
        }
    
        
        if(!publisherTeamstoUpdate.isEmpty()){
            system.debug('Publisher that need update');
            statusUpdate(publisherTeamstoUpdate);
            messages.clear();
        }
        if(!reviewerTeamstoUpdate.isEmpty()){
            system.debug('reviewers that need update');
            statusUpdate(reviewerTeamstoUpdate);
            messages.clear();
        }
        
        system.debug('ready to notify');
        system.debug(creatorstoNotify);
        notifyCreators(creatorstoNotify);
        
       
    }
    
/*
 * Concen-172 process a list of Atricle Team members and check to see if the 
 * Status has updated for notification purposes  
 */    
    public static void statusUpdate(List<Article_Team_Member__c> Members){
        messages = new List<Messaging.SingleEmailMessage>();
        List<User> UsersFromQueues = new List<User>();
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
       
        List<id> users = new List<id>();
        List<Group> groups = new List<Group>();
        List<GroupMember> gmems = new LIst<GroupMember>();
        List<id> Sender = new List<id>();
        list<String> emails = new List<string>();
        List<String> groupNames = new List<string>();
        
        for(Article_Team_Member__c member:Members){   
            users.clear();
            if(member.type__c =='Queue' ){
               groupNames.add(member.Team_Picklist__c); 
            } 
            if(member.type__c == 'Individual'){
                system.debug(member.type__c);
                users.add(member.UserName__c);
                system.debug(member.UserName__c);
                
            }
        }
        system.debug('groupNames: '+ groupNames);
            
        groups = [Select id from Group where name = :groupNames];
        system.debug('groups: '+groups);
        gmems = [Select userorGroupId from GroupMember where Group.id in:groups];
        for(GroupMember g:gmems){
            users.add(g.userOrgroupid);
        }
        List<User> Temp = [Select id, email from user where id in: users];
        system.debug(temp);
        for(User u: temp){
            system.debug(u.email);
            emails.add(u.email);
        }
        for(Article_Team_Member__c member:Members){
            system.debug(emails);
           // message.setSenderDisplayName(member.Knowledge_Article_Admin__r.CreatedBy.name);
            message.setSenderDisplayName(UserInfo.getName());
            // message.setToAddresses(users);
            message.setToAddresses(emails);
            message.setSubject('An Article has Been Assigned to You');
            String Body ='An Article has Been Assigned to you. Please see below for more details';
            body+= '<br> Role: '+member.role__c;
            Body +='<br> Status: '+member.status__c;
            Body +='<br>'+URL.getSalesforceBaseUrl().toExternalForm()+'/'+member.knowledge_Article_admin__c;
            message.setHTMLBody(body);
            messages.add(message);
            system.debug(message);
        }
       
        SendNotification();
    }
    
    /*
     * CONCEN-172
     * Notify the Creators of a Knowledge article when an update has occured on one of their articles
     * includes 
     *
     */   
    public static void notifyCreators(List<Article_Team_Member__C> members){
        system.debug('Notifying creator');
        
        messages = new List<Messaging.SingleEmailMessage>();
        List<id> admins = new List<id>();
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        Map<id, Article_team_Member__C> creatorsMap = new Map<id, Article_team_Member__c>();
        list<id> creatorUserIds = new List<id>();
        list<String> emails = new List<string>();
        for(Article_team_Member__c atm: members){
          admins.add(atm.Knowledge_Article_Admin__c);
        }
        List<Article_Team_Member__c> Creators = [SELECT id, userName__c,Knowledge_Article_Admin__c FROM Article_team_Member__c 
                                                WHERE Knowledge_Article_Admin__c in :admins and Role__c = 'Creator'];
        for(Article_Team_Member__c atm: creators){
            
            CreatorsMap.put(atm.Knowledge_Article_Admin__c, atm);
            system.debug(creatorsMap);
        }
        integer i =0;
        system.debug(members);
        system.debug('Members.size='+members.size());
        for(Article_Team_Member__c atm: members){
            creatorUserIds.clear();
            system.debug(atm);
            creatorUserIds.add(creatorsMap.get(atm.Knowledge_Article_Admin__c).username__c);
            List<User> Temp = [Select id, email from user where id in: creatorUserIds];
            System.debug('List of Creators '+temp);
            emails.clear();
            for(User u: temp){
                system.debug('user '+u);
                system.debug('user email '+u.email);
                System.debug('i='+i);
               emails.add(u.email);
                i++;
            }
            
            System.debug('Emails List '+emails);
            system.debug('Emails size:'+emails.size());
            message.setSenderDisplayName(atm.UserName__r.name);
            message.setToAddresses(emails);
            message.setSubject('Your Article has been updated');
            String Body ='There has been an update on your Article, please see below for details';
            body+= '<br> Role: '+atm.role__c;
            Body +='<br> Status has been updated to '+atm.status__c;
            Body +='<br> '+URL.getSalesforceBaseUrl().toExternalForm()+'/'+atm.knowledge_Article_admin__c;
            message.setHTMLBody(body);
            messages.add(message);
            system.debug(message);
        }
        if(!Creators.isEmpty()){// Igor made this. There was an internal error trying to send null email messages
            SendNotification();
        }
        
    }
    
    public void onAfterUpdate(Map<Id, Article_Team_Member__c> newMap, Map<Id, Article_Team_Member__c> oldMap ){

        List<Article_Team_Member__c> atmsToHandle = new List<Article_Team_Member__c>();
        Set<String> atmsToResetRatings = new Set<String>();
        List<Article_Team_Member__c> atmsToNotifyCC = new List<Article_Team_Member__c>();

        for(Article_Team_Member__c atmItem:newMap.values()){
            if(atmItem.Status__c != oldMap.get(atmItem.Id).Status__c){
                atmsToHandle.add(atmItem);
            }

            if(atmItem.ResetCountForRatings__c == true){
                atmsToResetRatings.add(atmItem.ArticleId__c);
            }

            if(atmItem.NotifyTeam__c == true){
                atmsToNotifyCC.add(atmItem);
            }

        }

        if(!atmsToHandle.isEmpty()){
            handleStatusChange(atmsToHandle);
        }

        if(!atmsToResetRatings.isEmpty()){
            // Delete Vote object records, realated to these articles
            resetRatings(atmsToResetRatings);
        }

        if(!atmsToNotifyCC.isEmpty()){
            //Notify Contact Center team System.Label.Contact_Center_notify_queue_id 
            try{
                //notifyCCTeam(atmsToNotifyCC);
            }catch(Exception e){
                system.debug('ERROR OCCURED //' + e);
            }    
        }

    }

    private void handleStatusChange(List<Article_Team_Member__c> atmList){

        List<Article_Team_Member__c> underReview = new List<Article_Team_Member__c>();
        List<Article_Team_Member__c> toPublish = new List<Article_Team_Member__c>();
        List<Article_Team_Member__c> toSchedulePublish = new List<Article_Team_Member__c>();
        Map<String,Article_Team_Member__c> knldgToPublishMap = new Map<String,Article_Team_Member__c>();
        Map<String,Article_Team_Member__c> knldgToSchdlPublishMap = new Map<String,Article_Team_Member__c>();
        Set<String> knldgToPublish = new Set<String>();
        Set<String> knldgToSchdlPublish = new Set<String>();

        for(Article_Team_Member__c atmItem:atmList){
            if(atmItem.Status__c == 'Under Review'){
                underReview.add(atmItem);
            } else if(atmItem.Status__c == 'Published'){
                toPublish.add(atmItem);
                knldgToPublish.add(atmItem.ArticleId__c);
                knldgToPublishMap.put(atmItem.ArticleId__c,atmItem);
            } else if(atmItem.Status__c == 'Scheduled publication'){
                toSchedulePublish.add(atmItem);
                knldgToSchdlPublish.add(atmItem.ArticleId__c);
                knldgToSchdlPublishMap.put(atmItem.ArticleId__c,atmItem);
            }
        }

        if(!underReview.isEmpty()){
            setParentStatus(underReview,'Under Review');
        }

        if(!toPublish.isEmpty()){
            setParentStatus(toPublish,'Published');
            publish(knldgToPublishMap);
        }

        if(!toSchedulePublish.isEmpty()){
            setParentStatus(toSchedulePublish,'Scheduled publication');
            publish(knldgToSchdlPublishMap);

        }
    }

    private void setParentStatus(List<Article_Team_Member__c> atmList, String statusParam){

        List<Knowledge_Article_Admin__c> parentAdmins = new List<Knowledge_Article_Admin__c>();
        List<Knowledge__kav> parentKnowledge = new List<Knowledge__kav>();
        Set<String> admIds = new Set<String>();
        Set<String> knldgIds = new Set<String>();

        for(Article_Team_Member__c atmItem:atmList){
            admIds.add(atmItem.Knowledge_Article_Admin__c);
            knldgIds.add(atmItem.ArticleId__c);
        }

        parentAdmins = [select Id, Article_Status__c from Knowledge_Article_Admin__c where Id IN: admIds];
        parentKnowledge = [select Id, Status__c from Knowledge__kav where Id IN: knldgIds];

        system.debug('parentAdmins // ' + parentAdmins);
        system.debug('parentKnowledge // ' + parentKnowledge);

        for(Knowledge_Article_Admin__c kaaItem:parentAdmins){
            kaaItem.Article_Status__c = statusParam;
        }

        for(Knowledge__kav knldgItem:parentKnowledge){
            knldgItem.Status__c = statusParam;
        }

        update parentAdmins;
        //update parentKnowledge;

    }

    private void publish(Map<String,Article_Team_Member__c> artIdMap){

        system.debug('artIdMap // ' + artIdMap);

        Set<String> kaIds = new Set<String>();
        List<Knowledge__kav> kavs = new List<Knowledge__kav>();
        List<Knowledge__kav> KavsToUpdate = new List<Knowledge__kav>();
        date currDate = date.today();
        date reviewDate = currDate.addDays(365);
        kavs = [select Id, KnowledgeArticleId from Knowledge__kav where Id IN: artIdMap.keySet() ];
        for(Knowledge__kav kavItem:kavs){
            kaIds.add(kavItem.KnowledgeArticleId);
        }    

      //  kavArts = [select Id , (select Id, Status from Knowledge__kav  ) from Knowledge__ka where Id IN: kaIds];

        for(Knowledge__kav kavItem:kavs){
/*            Sreekanth - concen -193 */

            Kavitem.Review_Due_Date__c = reviewDate  ;
            KavsToUpdate.add(Kavitem);            
        }
        if(!KavsToUpdate.isEmpty()){
           try{  
             update KavsToUpdate ;
           } catch(Exception e){           
             system.debug('ERROR OCCURED // ' + e);
           } 

        }
 /*            Sreekanth - concen -193 */  
         
        for(Knowledge__kav kavItem:kavs){
            if(!Test.isRunningTest()){
                try{
                system.debug('***artIdMap0****'+artIdMap.get(kavItem.Id).ScheduledDate__c);
                    if(artIdMap.get(kavItem.Id).ScheduledDate__c==null){
                        KbManagement.PublishingService.publishArticle(kavItem.KnowledgeArticleId, true); 
                    } else {
                    
                        system.debug('***artIdMap****'+artIdMap.get(kavItem.Id).ScheduledDate__c);
                        KbManagement.PublishingService.scheduleForPublication(kavItem.KnowledgeArticleId, artIdMap.get(kavItem.Id).ScheduledDate__c); 
                    }
                }catch(Exception e){
                    system.debug('ERROR OCCURED // ' + e);
                    artIdMap.get(kavItem.Id).addError('Article was already published, please, check the Draft');
                }    
                                 
            }
       
        }
   
    }


    private void resetRatings(Set<String> atmIdList){

        Set<String> artIds = new Set<String>();
        List<Vote> ratings = new List<Vote>();
        List<Vote> ratingsToReset = new List<Vote>();
        List<Knowledge__kav> parentKnowledge = new List<Knowledge__kav>();
        parentKnowledge = [select Id, KnowledgeArticleId from Knowledge__kav where Id IN: atmIdList];
        for(Knowledge__kav kavItem:parentKnowledge){
            artIds.add(kavItem.KnowledgeArticleId);
        }

        ratings = [select Id, Type, ParentId from Vote where Parent.Type = 'Knowledge__ka'];

        //system.debug('ratings // ' + ratings);

        for(Vote vItem:ratings){
            if(artIds.contains(vItem.ParentId)){
                ratingsToReset.add(vItem);
            }
        }

        system.debug('ratingsToReset // ' + ratingsToReset);

        if(!ratingsToReset.isEmpty()){
            delete ratingsToReset;
        }


    }

    
    
}