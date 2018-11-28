({
 saveContactRecord : function(cmp,event) {
 var fName = cmp.get("v.firstName");
 var lName = cmp.get("v.lastName");
 var accId = cmp.get("v.recordId");
 console.log('---selected Account RecordId--'+accId);
 // Create an Apex action
 var createAction = cmp.get("c.createRecord");
 // Set the parameters
 createAction.setParams({ "fName" : fName, "lName" : lName, "accountId" : accId});
 // Define the callback
 createAction.setCallback(this, function(response) {
 var state = response.getState();
 
 // Callback succeeded
 if (cmp.isValid() &amp;amp;&amp;amp; state === "SUCCESS")
 {
 console.log('Contaxt Record Created-Successfully-'+response.getReturnValue());
 cmp.set('v.contId', response.getReturnValue());
 }
 else{
 console.log('Contaxt Record Created Failure--');
 cmp.set('v.contId', null);
 }
 });
 
 // Enqueue the action 
 $A.enqueueAction(createAction); 
 
 }
})