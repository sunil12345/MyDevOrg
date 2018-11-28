@isTest(SeeAllData=false)
private class testVehicleTrackerBaseController {


 static testMethod void ProjectTracker_Tree_VO_tree() {
    Vehicle__c vh = new Vehicle__c();
    vh.License_Plate__c = 'Multi-Market';
    vh.Make__c = 'USA';
    vh.Name= 'Multi-Market, USA';
    insert vh;
    

}

}