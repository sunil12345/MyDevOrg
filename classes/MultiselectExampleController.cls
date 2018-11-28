public with sharing class MultiselectExampleController {
    
    public String state {get;set;}
    public String city {get;set;}
    
    public SelectOption[] selectedContacts { get; set; }
    public SelectOption[] allContacts { get; set; }
    
    public String message { get; set; }
    
    public MultiselectExampleController() {
        selectedContacts = new List<SelectOption>();
        
        List<Contact> contacts = [SELECT Name, Id FROM Contact];    
        allContacts = new List<SelectOption>();
        for ( Contact c : contacts ) {
            //allContacts.add(new SelectOption(c.Id, c.Name));
        }
    }

    public PageReference save() {
        message = 'Selected Contacts: ';
        Boolean first = true;
        for ( SelectOption so : selectedContacts ) {
            if (!first) {
                message += ', ';
            }
            message += so.getLabel() + ' (' + so.getValue() + ')';
            first = false;
        }
        
        return null;       
    }
    
     public List<SelectOption> getStates()
    {
        List<SelectOption> options = new List<SelectOption>();
        
   Schema.DescribeFieldResult fieldResult =
 Contact.Level__c.getDescribe();
   List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        
   for( Schema.PicklistEntry f : ple)
   {
      options.add(new SelectOption(f.getLabel(), f.getValue()));
   }       
   
   system.debug('****options***'+options);
   return options;
    } 
    
    public List<SelectOption> getCities()
    {
       system.debug('****IN***state **'+state );
                allContacts= new List<SelectOption>();
        if(state == 'TN')
        {       
            allContacts.add(new SelectOption('CHE','Chennai'));
            allContacts.add(new SelectOption('CBE','Coimbatore'));
            system.debug('****IF***state **'+allContacts);
        }
        else if(state == 'KL')
        {       
        allContacts.add(new SelectOption('COA','Coachin'));
            allContacts.add(new SelectOption('MVL','Mavelikara'));
            
            system.debug('****elseIF***state **'+allContacts);
        }
        else
        {
            
            allContacts.add(new SelectOption('None','--- None ---'));
            system.debug('****else***state **'+allContacts);
        }     
        return allContacts; 
    }       
    
}