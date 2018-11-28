@IsTest 
global with sharing class  csTest{

    @IsTest(SeeAllData=false) 
    global static void cstestM() {
    
    
   List<TestCustomsettings__c> lstCS= new List<TestCustomsettings__c>();
    Test.startTest();
    For(integer i=0; i<3; i++){
    
    TestCustomsettings__c objCs = new TestCustomsettings__c(TESTCSFILED__c= 'TestNewGetwewewsdsdses'+i, Name='CheckgetNowTessdsdtwewewes'+i);
     lstCS.add(objCs);   
    
        }

    //insert lstCS;
    Test.stopTest();
    
    }

}