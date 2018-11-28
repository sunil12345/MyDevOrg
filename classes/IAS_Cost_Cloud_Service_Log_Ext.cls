public without sharing class IAS_Cost_Cloud_Service_Log_Ext {       
    
    
     
     public IAS_Cost_Cloud_Service_Log_Ext(ApexPages.StandardController controller) { } //This is for assigning the standard page controller 
    
    public ApexPages.StandardSetController costservicelogRecords {
        get {
            if(costservicelogRecords == null) 
            {
                List<Account> logs = Database.query('SELECT Id, Name, Status__c From Account Where Id=\''+ '0017F00000agfgV' + '\'  limit 1');
                
                List<Account> costs = new List<Account>(); 
             
            //This for loop will set the Approver and Approval Date field before setting the records for the controller page records
            for(Account log : logs){
                log.Type= 'Prospect';
                
                costs.add(log);             
            }//End of the for loop setting each records for the controller page
            
                costservicelogRecords= new ApexPages.StandardSetController(costs );
            }
            return costservicelogRecords;
        }
        set;
    }
    
    
    
    //This is for returning a list of records in the custom force page to display the records that need to be edit
    public List<Account> getCostServiceLogs() {
    
    system.debug('****costservicelogRecords.getRecords()1***'+costservicelogRecords.getRecords());     
        return (List<Account>) costservicelogRecords.getRecords();
    }
    
    
    //This page reference is used for saving the changes to the cost service log record and redirecting the pages to anoter page
    public PageReference saveCostServiceLogs(){
                   
            system.debug('*****costservicelogRecords.getRecords()2****'+costservicelogRecords.getRecords());
            update costservicelogRecords.getRecords();
            
            system.debug('***save***'+costservicelogRecords.getRecords());
            
            
            PageReference pageVeiw = new PageReference('/0017F00000agfgV'); //= ApexPages.currentPage(); //new PageReference('/apex/Cost_Cloud_Service_Log_Approval');  
            pageVeiw.setRedirect(false);
            
            return pageVeiw; 
          
    }
    //This page reference is for cancelling the page view and redirect them to a different page
    public PageReference cancel(){
        PageReference pageVeiw = new PageReference('/0017F00000agfgV');       
        pageVeiw.setRedirect(false);
        return pageVeiw;
    }
}