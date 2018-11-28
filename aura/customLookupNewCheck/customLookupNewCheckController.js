({
	 init : function(component, event, helper) {
    var action2 = component.get("c.getAccount");        
    action2.setCallback(this, function(response) {
        console.log(response.getReturnValue());
        component.set("v.account", response.getReturnValue());
    });
    $A.enqueueAction(action2);
}, 

})