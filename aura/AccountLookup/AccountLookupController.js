({
 
 /**
 * receiving the clearLookupIdEvent event
 */
 handleAccountIdClear : function(cmp, event, helper) {
 // Clear the Id bound to the View
 cmp.set('v.recordId', null);
 cmp.set('v.contId', null);
 },
 
 saveContact : function(cmp,event,helper){
 
 helper.saveContactRecord(cmp, event);
 }
})