({
	doInit: function(component) {
	
    var action = component.get("c.getCaseData");
    action.setParams({ caseId : component.get("v.recordId") });
    action.setCallback(this, function(actionResult) {
        var infos = actionResult.getReturnValue();
        component.set("v.caseObj", infos);             
    });
    $A.enqueueAction(action);
        
       
},
    
})