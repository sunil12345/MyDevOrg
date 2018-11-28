({
    onSaveClick: function(component) {
        const accountName = component.find('accountInput').get('v.value');
        
        const action = component.get('c.saveAccount');
        action.setParams({ accountName : accountName });
        action.setCallback(this, function(response)  {
            if (response.getState() === 'SUCCESS') {
                component.set('v.onlySetAfterSave', 'You shouldn\'t see this');
                
                const accountId = response.getReturnValue();
                alert("now navagating to new page");
                component.find('navService').navigate({
                    type: 'standard__recordPage',
                    attributes: {
                        actionName: 'view',
                        recordId: accountId
                    }
                },true);
                
               /* var navEvt = $A.get("e.force:navigateToSObject");
                
                navEvt.setParams({
                    recordId: accountId,
                    slideDevName: "detail",
                    isredirect: true
                    
                });
                
                navEvt.fire(); */
                
            }
            // component.find('accountInput').set('v.value', "");
            // component.set('v.onlySetAfterSave', "");
        });
        $A.enqueueAction(action);
    },
    doInit : function(component, event, helper){
        alert("component loaded");
        component.find('accountInput').set('v.value', "");
        component.set('v.onlySetAfterSave', "");
    },
    pageReferenceChanged : function(component, event, helper){
        alert("PGR changed");
    }
})