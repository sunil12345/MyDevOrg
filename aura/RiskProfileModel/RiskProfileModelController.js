({
	navigateToURL : function(component, event, helper) {
		var urlEvent = $A.get("e.force:navigateToURL");
        console.log('***IN URL****');
        urlEvent.setParams({
          "url": '/006/o'
        });
    	urlEvent.fire();
	}
})