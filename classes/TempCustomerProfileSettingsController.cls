public with sharing class TempCustomerProfileSettingsController {
    //Member Variables
    public Map<String,List<String>> caseReasonSubReasonMap{get;set;}
    public String reason{get;set;}
    public List<SelectOption> caseReasonList {get; set;}
    public List<SelectOption> availableSubReasonList {get; set;}
    public List<SelectOption> selectedSubReasonList {get; set;}
    
    public String editMapKey {get; set;}
    public boolean displayPopUp {get; set;}
    private String userAction;
    public boolean hasKeyFlag {get; set;}
    public String errorTitle {get; set;}
    public String errorSummary {get; set;}
    //Wrapper class object
    

    //getter method 1
    private Set<String> getSelectOptionsInStringSet(){
        Set<String> selectedSubReasonSet = new Set<String>();
        if(selectedSubReasonList!=null && selectedSubReasonList.size()>0){
            for(SelectOption s :selectedSubReasonList){
                selectedSubReasonSet.add(s.getvalue());
          }
        }
        return selectedSubReasonSet;
    }
    //getter method 2
    public List<SelectOption> getCategoryValues(){
        List<SelectOption> buckValList = new List<SelectOption>();
        buckValList.add(new SelectOption('None', 'None'));
        buckValList.add(new SelectOption('Product', 'Product'));
        buckValList.add(new SelectOption('Billing & Finance', 'Billing & Finance'));
        buckValList.add(new SelectOption('Service & Support', 'Service & Support'));
        return buckValList;
    }
    //getter method 3
    public List<SelectOption> getTimeFrameValues(){
        List<SelectOption> timeFrameList = new List<SelectOption>();
        timeFrameList.add(new SelectOption('0', 'None'));
        timeFrameList.add(new SelectOption('365', 'Last 365 days'));
        timeFrameList.add(new SelectOption('183', 'Last 183 days'));
        return timeFrameList;
    }

   
    
   
    //Constructor
    public TempCustomerProfileSettingsController(ApexPages.StandardController controller){
        displayPopUp = false;
        userAction = '';
        hasKeyFlag = false;

       
        init();
        System.debug('***IN*Controller**'+availableSubReasonList);   
    }
    
    //Init method
    private void init(){
        caseReasonList = new List<SelectOption>();
        caseReasonSubReasonMap=new Map<String,List<String>>();
        reason = 'None';
        system.debug('****reason ****'+reason );
        caseReasonSubReasonMap=DependentOptions.GetDependentOptions('Case', 'PotentialLiability__c','Product__c');
        
        system.debug('****caseReasonSubReasonMap****'+caseReasonSubReasonMap);
        caseReasonList.add(new SelectOption('None', 'None'));
        for(String cReason: caseReasonSubReasonMap.keySet()){
            caseReasonList.add(new SelectOption(cReason, cReason));
            system.debug('****caseReasonList****'+caseReasonList);
        }
        system.debug('****caseReasonListOut****'+caseReasonList);
        fetchSubReasons();
    }
    
    //Method to fetch the Case Sub-Reasons based on the Case reason
    public void fetchSubReasons(){
        availableSubReasonList = new List<SelectOption>();
        selectedSubReasonList = new List<SelectOption>();
        system.debug('****reason****'+reason);
        system.debug('***caseReasonSubReasonMap**test**'+caseReasonSubReasonMap);
        if(reason!='None' ){
            List<String> s1 = caseReasonSubReasonMap.get(reason);
            system.debug('****s1****'+s1);
            
            for(String s2: s1){
                availableSubReasonList.add(new SelectOption(s2,s2));
                system.debug('****availableSubReasonList*'+availableSubReasonList);
                
            }
        }  
        
        system.debug('****availableSubReasonListOut*'+availableSubReasonList);            
    }
public void newRow(){
        //reset values
        displayPopUp = true;
        userAction = 'New';
        reason = 'None';
        
        fetchSubReasons();
        System.debug(availableSubReasonList); 
    }
    
}