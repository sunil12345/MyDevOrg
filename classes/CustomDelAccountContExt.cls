public with sharing class CustomDelAccountContExt {

    public Contact a;
    
    public CustomDelAccountContExt(ApexPages.StandardController stdController) {
        a = (Contact ) stdController.getRecord();
    }
    
    
    public PageReference checkForDelete() {
        // TODO logic

        return null;
    }
    
}