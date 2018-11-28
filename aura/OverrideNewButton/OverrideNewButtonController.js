({
doInit : function(component, event, helper) {
	
    system.debug('****component.get("v.recordId")***'+component.get("v.recordId"));
    var action = component.get("c.getContacts");
    action.setParams({
    "aid": component.get("v.recordId")
    });
    action.setCallback(this, function(a) {
    component.set("v.contacts", a.getReturnValue());
    });
    $A.enqueueAction(action);
    }
})