trigger UpdateAmount on Child_Opp__c (after insert) {

    Map<ID, Opportunity> parentOpps = new Map<ID, Opportunity>(); //Making it a map instead of list for easier lookup
  List<Id> listIds = new List<Id>();

  for (Child_Opp__c  childObj : Trigger.new) {
    listIds.add(childObj.Opportunity__c);
  }


  parentOpps = new Map<Id, Opportunity>([SELECT id, amount FROM Opportunity WHERE ID IN :listIds]);

  for (Child_Opp__c quote: Trigger.new){
     Opportunity myParentOpp = parentOpps.get(quote.Opportunity__c);
     myParentOpp.Amount = 8888;
  }

  update parentOpps.values();
}