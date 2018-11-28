public with sharing class EditRelationshipFormController {


ApexPages.standardController retBack= null;

public EditRelationshipFormController(ApexPages.StandardController stdController) {
    
   
    retBack= stdController;
    
}



public PageReference cancel() {
        
        return retBack.cancel();
        
    }
    
    

}