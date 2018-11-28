@isTest(SeeAllData=false)
private class testProjectTrackerBaseController {


 static testMethod void ProjectTracker_Tree_VO_tree() {
     String mktTitle = 'Multi-Market';
     String mktScope = 'USA';
     Market__c mkt =  new Market__c ();    
      mkt.Market_Title__c = mktTitle.substring(0,Math.min(mktTitle.length(), 64));
      mkt.Market_Scope__c = mktScope.substring(0,Math.min(mktScope.length(), 14));
          
      mkt.Name = mktTitle+', '+ mktScope;
      
      insert mkt;
    

}

}