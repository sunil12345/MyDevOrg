trigger TestOppProduct on Opportunity (before insert, before update) { 

if( Trigger.isBefore){ 
for(Opportunity opp : Trigger.new){ 
//opp.StageName = 'Perception Analysis'; 
opp.probability=70;
} 
} 

}