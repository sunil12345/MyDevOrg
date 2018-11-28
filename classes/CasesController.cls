public with sharing class CasesController 
{
private ApexPages.StandardSetController standardController;

public CasesController(ApexPages.StandardSetController standardController)
{
this.standardController = standardController;
}
public PageReference bumpCases()
{ 
// Get the selected records (optional, you can use getSelected to obtain ID's and do your own SOQL)
List<Case> selectedCases = (List<Case>) standardController.getSelected();
return null; 
}
public PageReference bumpWithDefaultValue()
{ 
// Get the selected records (optional, you can use getSelected to obtain ID's and do your own SOQL)
List<Case> selectedCases = (List<Case>) standardController.getSelected();
// Update records 
for(Case selectedCase : selectedCases)
{
selectedCase.Status = 'Closed';
selectedCase.Type = 'Spam';
} 
return null; 
}
public PageReference updateCases()
{ 
// Call StandardSetController 'save' method to update (optional, you can use your own DML)
return standardController.save(); 
}
}