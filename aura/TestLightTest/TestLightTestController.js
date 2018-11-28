({
	doInit : function(component, event, helper) {
		//alert("method called");
        
        var recordId = component.get("v.recordId");
        //alert(recordId);
        
        var action = component.get("c.requestOrderSchedule");
        
        action.setParams({strRecordId : recordId});

        // Create a callback that is executed after 
        // the server-side action returns
        action.setCallback(this, function(response) {
            var state = response.getState();
             if (state === "SUCCESS") {
                // Alert the user with the value returned 
                // from the server
                //alert(response.getReturnValue());
                var strReturnValue = response.getReturnValue();
                if (strReturnValue == "Success")
                {
                    
                    var resultsToast = $A.get("e.force:showToast");
                    resultsToast.setParams({
                    "title": "Saved",
                    "message": "The record was updated."
                    });
                    resultsToast.fire();
 
                    // Close the action panel
                    var dismissActionPanel = $A.get("e.force:closeQuickAction");
                    dismissActionPanel.fire();
                    
                }
                else
                {
                    
                    //alert("Entered Error");
                    component.set("v.OutputText", strReturnValue);
                    
                }
                // You would typically fire a event here to trigger 
                // client-side notification that the server-side 
                // action is complete
            }
            else if (state === "INCOMPLETE") {
                // do something
            }
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) 
                {
                    if (errors[0] && errors[0].message) 
                    {
                        console.log("Error message: " + 
                                 errors[0].message);
                    }
                } else 
                {
                    console.log("Unknown error");
                }
                
                alert("An error was returned.  "+response.getReturnValue());

            }
            
        }
        );

        // optionally set storable, abortable, background flag here

        // A client-side action could cause multiple events, 
        // which could trigger other events and 
        // other server-side action calls.
        // $A.enqueueAction adds the server-side action to the queue.
        $A.enqueueAction(action);
        

	},
})