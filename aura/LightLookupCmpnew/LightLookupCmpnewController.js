({
 /**
 * Search an SObject for a match
 */
 search : function(cmp, event, helper) {
 console.log('--Inside Search method of Controller---' + event.getSource());
 helper.doSearch(cmp); 
 },
 
 /**
 * Select an SObject from a list
 */
 select: function(cmp, event, helper) {
 console.log('--Inside selection method of Controller---' + event.currentTarget.id);
 helper.doSelection(cmp, event);
 },
 
 /**
 * Clear the currently selected SObject
 */
 clear: function(cmp, event, helper) {
 helper.clearSelection(cmp); 
 }
})