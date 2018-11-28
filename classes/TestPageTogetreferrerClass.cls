public with sharing class TestPageTogetreferrerClass{

PageReference pg1 = new PageReference('null');
    public TestPageTogetreferrerClass(ApexPages.StandardController controller) {
    
        PageReference pr = ApexPages.currentPage();
               system.debug('****pr*****'+pr); 
               
               system.debug('****get Id*****'+pr.getParameters().get('id'));
               
        }
    }