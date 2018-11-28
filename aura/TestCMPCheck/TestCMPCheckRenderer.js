({ 
render: function(component, helper) { 
//grab attributes from the component markup 
var classname = component.get("v.class"); 
var xlinkhref = component.get("v.xlinkHref"); 
var ariaHidden = component.get("v.ariaHidden"); 
var name = component.get("v.name"); 
var id = component.get("v.id"); 

//return an svg element w/ the attributes 
var svg = document.createElementNS("http://www.w3.org/2000/svg", "svg"); 
svg.setAttribute('class', classname); 
svg.setAttribute('aria-hidden', ariaHidden); 
svg.setAttribute("name", name); 
svg.setAttribute('data-olb-id', 'svg_'+id); 
svg.innerHTML = '<use xlink:href="'+xlinkhref+'"></use>'; 

var domElms = [svg]; 

// Only add the assistive text span if provided 
var assistText = component.get("v.assistiveText"); 
if(typeof assistText !=='undefined' && typeof assistText.length !=='undefined' && assistText.length > 0){ 
var assist = document.createElement("span"); 
assist.setAttribute("class", "slds-assistive-text"); 
assist.textContent = assistText; 
domElms.push(assist); 
} 

var ret = this.superRender(); 
return ret.concat(domElms); 
} 
})