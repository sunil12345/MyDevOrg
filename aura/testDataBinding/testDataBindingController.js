({
	update : function(component, event, helper) {
        
        console.log('******IN**8');
     var testAtr = component.get("v.test1");
        console.log('**testAtr**'+testAtr);
    component.set("v.testAtr", testAtr);
 }
})