({
    /*afterScriptsLoaded : function(component, event, helper) {
        var jquery = jQuery.noConflict();
		var cmpElemenet = component.find("someDiv"); 
        alert("cmpElemenet: " + cmpElemenet);
        var stickyEl = jquery(cmpElemenet); 
        var elTop = stickyEl.offset().top; 
        alert("elTop: " + elTop);
	}*/
     
    doInit : function(component, event, helper) {
        //console.log("current window href: " + window.location.href);
        //console.log("current window href: check" , window.location.href);
        //alert("current window closed: " + window.closed);

        var sendWindow = window.open( "https://www.google.com" );
		
        //alert("current window href: check new --alert" + sendWindow); 
        console.log("current window href: check new" , sendWindow); 
        console.log("new window href: 2nd -" , sendWindow.location);
        console.log("new window href: 3rd -" , sendWindow.location.href);
        //alert("new window href: " + sendWindow.location.href);
        alert("new window closed1: " + sendWindow.closed);
    }
})