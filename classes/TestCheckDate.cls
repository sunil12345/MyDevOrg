public with sharing class TestCheckDate{

    public static String checkMap() {
    
        Datetime dt        = Datetime.NOW();
        String   starttime = dt.hour() + '';
        System.debug('-dt--' + dt);
        System.debug('-starttime--' + starttime);
        return null;
        
        
    }
}