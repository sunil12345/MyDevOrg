public class AssignToOrphanRecord {
    public static void execute(){
       
        for(Event appointment : (List<Event>)trigger.new){
            system.debug('***appointment ***'+appointment );
            if(appointment.WhatId == null && appointment.WhoId == null){
            system.debug('***whatId***'+appointment.WhatId);
            
               
            }
        }
    }
}