({
	doInit: function(component) {

    var action = component.get("c.getCase");
    action.setParams({ caseId : component.get("v.recordId") });
    action.setCallback(this, function(actionResult) {
        var infos = actionResult.getReturnValue();
        component.set("v.caseObj", infos);             
    });
    $A.enqueueAction(action);
        
       
},
})