({
    isMuleApprovable:function(cmp, evt){
		//debugger;
        var action = cmp.get("c.isMuleApprovable");
        var caseObj = cmp.get("v.caseObj");
        action.setParams({thisCase : caseObj});
        action.setCallback(this, function(response){
            
            console.log('**response.getState()**'+response.getState());
            var state = response.getState();
            if (state === "SUCCESS") {
                cmp.set("v.isMuleApprovable", response.getReturnValue());                
            }
            else{
                console.log("Load Case Error - Component Client Controller callback failure");
            }
        });
		$A.enqueueAction(action);
    },
    
    closeModal: function(component,event){ 
        console.log('Executing in closeModal...'); 
        var cmpTarget = component.find('Modalbox');
        var cmpBack = component.find('Modalbackdrop');
        $A.util.removeClass(cmpBack,'slds-backdrop_open');
        $A.util.removeClass(cmpTarget, 'slds-fade-in-open');
    },
    
    openModal:function(cmp,evt) {
        console.log('Executing in openmodal...');
        var cmpTarget = cmp.find('Modalbox');
        var cmpBack = cmp.find('Modalbackdrop');
        $A.util.addClass(cmpTarget, 'slds-fade-in-open');
        $A.util.addClass(cmpBack, 'slds-backdrop_open');
    },
})