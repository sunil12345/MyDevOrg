trigger EventTrigger on Event (before insert)  {

 if(trigger.isBefore ){
        AssignToOrphanRecord.execute();
    }
    
    }