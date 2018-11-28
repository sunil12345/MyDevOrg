({
	init : function(component, event, helper) {
		var action = component.get("c.updateCaseRecord");
        action.setParams({"recordId": component.get("v.recordId")});
        
		action.setCallback(this, function(response) {
            var state = response.getState();
            
            console.log('***state****'+state);
            
            if(component.isValid() && state == "SUCCESS"){
                
                console.log('**	*isValid****'+component.isValid());
                
                //$A.get('e.force:refreshView').fire();
                
                
            } else {
                console.log('There was a problem : '+response.getError());
            }
        });
        $A.enqueueAction(action);
        
	}
})