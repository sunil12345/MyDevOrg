public class childClass2handler{


    public void onAfterInsert(List<ChildOpp2__c> lstChildInsert){
        
        system.debug('*****lstChildInsert*****'+lstChildInsert);
        
        set<ID> oppIDSet = new set<ID>();
        
        list<Opportunity> opplist = new list<Opportunity>();
        map<ID , Opportunity> oppMap = new map<ID , Opportunity>();
        list<Opportunity> updateOpplist = new list<Opportunity>();
        
        for(ChildOpp2__c CO : lstChildInsert){
            if(CO.Name != Null){
                oppIDSet.add(CO.Oppt2__c);
                
            }
        } 
        if(oppIDSet.size() > 0){
            opplist = [ SELECT Id , Name FROM Opportunity WHERE ID IN: oppIDSet];
        }
        
        for(Opportunity opp : opplist ){
            if(oppMap.get(opp.Id) == Null){
                oppMap.put(opp.Id , opp);
            }
        }
         
         for(ChildOpp2__c cust : lstChildInsert){
            if(cust.Name!= Null){
                Opportunity acc = oppMap.get(cust.Oppt2__c);
                acc.Name= cust.Name;
                acc.CloseDate = date.today();   
                acc.StageName = 'Prospecting';
                acc.ForecastCategoryName = 'Pipeline';
                
                updateOpplist.add(acc);
            }
        }
         update updateOpplist ;
         
         
            
    }
}