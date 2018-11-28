trigger createOpp on ChildOpp2__c (before insert) {
    
    childClass2handler objHandler = new childClass2handler();
    
    objHandler.onAfterInsert(Trigger.new);
    
    
}