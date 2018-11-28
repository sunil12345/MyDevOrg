({
	init: function(cmp, event, helper){        
        //Load the case object
        var action = cmp.get("c.grabCase");
        action.setParams({csid : cmp.get("v.recordId")});
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                cmp.set("v.caseObj", response.getReturnValue());
				helper.isMuleApprovable(cmp, event);                
            }
            else{
                console.log("Load Case Error - Component Client Controller callback failure");
            }
        });
        $A.enqueueAction(action);
        
    },
    
    
	openModal: function(cmp, evt, helper){ 
        helper.openModal(cmp,evt);
    },

    clickCancel : function(cmp, evt, helper) {
        helper.closeModal(cmp,evt);
    },

       
    onEditFormLoad : function(cmp, event, helper) {
        //debugger;
        helper.isMuleApprovable(cmp, event);
    },
    
    onEditFormSubmit : function(cmp, event, helper) {
        //debugger;
    },
    
    onEditFormError : function(cmp, event, helper) {
        //debugger;
    }
})