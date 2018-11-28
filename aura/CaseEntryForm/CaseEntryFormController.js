({
	 cancelCase: function(component, event, helper)
    {
        var recId = component.get("v.recordId");
		
		console.log('**recId**'+recId);
    	if (!recId) {
        var homeEvt = $A.get("e.force:navigateToObjectHome");
        homeEvt.setParams({
            "scope": "Vehicle__c"
        });
        homeEvt.fire();
    	} else {
        var navEvt = $A.get("e.force:navigateToSObject");
                	navEvt.setParams({
                    "recordId": recId, 
                    "slideDevName": "related"
                	});
                	navEvt.fire();

    	}
    }
})