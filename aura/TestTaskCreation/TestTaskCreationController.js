({
    doInit : function(component, event, helper) {
        //alert("Record  ID:  " + component.get("v.recordId"));
              
        var oppRecordId = component.get("v.recordId"); 
        
		var evt = $A.get("e.force:createRecord");
         evt.setParams({
   'entityApiName':'Task',
   'defaultFieldValues': {
      'Status':'In Progress',
       'WhatId':oppRecordId,
       'Subject':'Test1233'
   }
});
            
            evt.fire();
        
    }
    
})