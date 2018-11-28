({
    doInit: function(component,record,callback) {
        
        var recId = component.get("v.recordId");
        console.log('**1***'+ recId);
        
        var action = component.get("c.fetchCase");
        action.setParams({ 
            "caseID": recId
        });
        
        action.setCallback(this, function(response) {
            
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log(response.getReturnValue());
                component.set("v.record", response.getReturnValue());

            }
            else if (state === "INCOMPLETE") {
                console.log('====incomplete====');
            }
                else if (state === "ERROR") {
                    var errors = response.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            console.log("Error message: " + 
                                        errors[0].message);
                        }
                    } else {
                        console.log("Unknown error");
                    }
                }
        });
        
        $A.enqueueAction(action);

        
    }
})