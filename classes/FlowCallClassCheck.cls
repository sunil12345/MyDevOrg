global class FlowCallClassCheck {

    @InvocableMethod
    global static List<String> getCheckCallMethod(List<String> strName){ 
    
    system.debug('***STEP -1 ***');
    String strPage = '/apex/TestCloneVFInline';
        //PageReference pageRef = Page.TestCloneVFInline  ;
getPageRefMeth(strPage );
system.debug('***STEP -3 ***');
        PageReference pageRef = new PageReference('/apex/TestCloneVFInline');
        
        return null;
        
    }
    
    public static PageReference getPageRefMeth(String strNmae){
        system.debug('***STEP -2 ***');
        PageReference pageRef = new PageReference('/apex/TestCloneVFInline');
        pageRef.setRedirect(true);
        system.debug('***STEP -4 ***'+pageRef);
        return pageRef;
    }
}