<aura:application >
	
<aura:attribute name="ol" type="List" default="[{v: '1'}]"/>
<h2>FILTERED LIST ITERATION SHOWING oi.t == 'a'</h2>
<aura:iteration items="{!v.ol}" var="oi">
	
		<lightning:input value="{!oi.v}" label="Changes to this input does not re-render values outside this aura:iteration."/>
	
    </aura:iteration>
    
   
    <lightning:input value="{!v.ol[0].v}" label="Changes to this input re-renders value at index 0 in the list."/>
    
</aura:application>