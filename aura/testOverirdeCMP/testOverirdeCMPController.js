({
    init : function(component, event, helper) {
       // $A.get('e.force:refreshView').fire();
     component.set("v.fieldsList",component.get("v.fields").replace(' ','').split(','));
    }
})