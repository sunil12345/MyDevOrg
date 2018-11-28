/*--------------------------------------------------------------------------
   Class: ActivityPageCtrl 
    
   Description: 
     controller class for Activity vf page
      
      Date          Whom        Change #    
   ===========    ========    ============ 
   19-Jan-2017    marco.schmit@cognizant.com    
     
     Comments:                                 
--------------------------------------------------------------------------*/
public class ActivityPageCtrl {

    public ActivityPageCtrl(ApexPages.StandardController stdController){}

    public PageReference init(){
        String activityRecTypeId    = [SELECT Id FROM RecordType WHERE DeveloperName = 'New_Activity' LIMIT 1].Id;
        activityRecTypeId           = activityRecTypeId.substring(0, 15);
        String recType              = ApexPages.currentPage().getParameters().get('RecordType');
        String retUrl               = ApexPages.currentPage().getParameters().get('retURL');
        String activityId           = ApexPages.currentPage().getParameters().get('id');
        String whatId               = ApexPages.currentPage().getParameters().get('what_id');
        String whoId                = ApexPages.currentPage().getParameters().get('who_id');
        String userAgent            = ApexPages.currentPage().getHeaders().get('USER-AGENT');
        String anm                  = ApexPages.currentPage().getParameters().get('anm');
        String aid                  = ApexPages.currentPage().getParameters().get('aid');
        String evt5                 = ApexPages.currentPage().getParameters().get('evt5');
        String evt12                 = ApexPages.currentPage().getParameters().get('evt12');
        String whoWhatId            = whatId != null ? '&what_id='+whatId : (whoId != null ? '&who_id='+whoId : '');
        String themeDisplayed       =UserInfo.getUiTheme();
        System.debug('@@@@themeDisplayed'+themeDisplayed);
        // standard new
        if(activityId == null && themeDisplayed=='Theme3'){
            if((recType!=null && recType!='')  && activityRecTypeId != recType){
                String paramString='/00U/e?retURL='+retUrl+'&RecordType='+recType+'&ent=Event&nooverride=1';
                if(whoId!=null && whoId!=''){
                    paramString+='&who_id='+whoId;
                }
                if(whatId!=null && whatId!=''){
                    paramString+='&what_id='+whatId;
                }
                if(evt5!=null && evt5!=''){
                    paramString+='&evt5='+evt5;
                }
                if(evt12!=null && evt12!=''){
                    paramString+='&evt12='+evt12;
                }
                if(aid!=null && aid!=''){
                    paramString+='&aid='+aid;
                }
                if(anm!=null && anm!=''){
                    paramString+='&anm='+anm;
                }
                return new PageReference(paramString);
            }
            else
                return  null;
        }
        
        //standard edit
        else if(activityId != null && themeDisplayed=='Theme3'){
            List<Event> evt = [SELECT RecordTypeId FROM Event WHERE Id = :activityId LIMIt 1];

            if(evt!=null && evt.size()>0 && activityRecTypeId != evt[0].RecordTypeId){
                return new PageReference('/'+activityId+'/e?retURL='+retUrl+'&nooverride=1'+whoWhatId);
            }
        }
        // custom page in sf 1
        if(themeDisplayed=='Theme4t' || themeDisplayed=='Theme4d' || Test.isRunningTest()){
            List<Event> evt = [SELECT RecordTypeId FROM Event WHERE Id = :activityId LIMIt 1];
         if((recType!=null && recType!='')  && activityRecTypeId != recType){
                String paramString='/00U/e?retURL='+retUrl+'&RecordType='+recType+'&ent=Event&nooverride=1';
                if(whoId!=null && whoId!=''){
                    paramString+='&who_id='+whoId;
                }
                if(whatId!=null && whatId!=''){
                    paramString+='&what_id='+whatId;
                }
                if(evt5!=null && evt5!=''){
                    paramString+='&evt5='+evt5;
                }
                if(evt12!=null && evt12!=''){
                    paramString+='&evt12='+evt12;
                }
                if(aid!=null && aid!=''){
                    paramString+='&aid='+aid;
                }
                if(anm!=null && anm!=''){
                    paramString+='&anm='+anm;
                }
                return new PageReference(paramString);
          }   
         else if(evt!=null && evt.size()>0 && activityRecTypeId != evt[0].RecordTypeId){
                return new PageReference('/'+activityId+'/e?retURL='+retUrl+'&nooverride=1'+whoWhatId);
            }
          else
            return null;
        }
        

        // custom page
        return null;
    }
}