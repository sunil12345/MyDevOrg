public with sharing class TestFieldMap {
    public static String checkMap() {
        Map<String, Schema.SobjectField> fields = Schema.SObjectType.AVSFQB__Invoices__c.fields.getMap(); 
        System.debug('Map--33--' + json.serialize(fields.keySet()));
        System.debug('KeySetSize: ' + fields.keySet().size());
        System.debug(fields.get('Payments__c')); // (a) 
        System.debug(fields.get('AVSFQB__Payments__c')); // (b) 
        
        return 'Map';
    }
}