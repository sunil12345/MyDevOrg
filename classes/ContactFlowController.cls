public class ContactFlowController {

public Flow.Interview.CallPageNameFlow mySetupInstalments {get; set;}

public ContactFlowController(ApexPages.StandardController controller) {
}



public PageReference getFinishPage(){

system.debug('**mySetupInstalments**'+mySetupInstalments);
String str = mySetupInstalments.AccountId;
        //system.debug('Expected is ' + str.substringAfter('id='));
String strId = str.substringAfter('id=');

PageReference p = new PageReference('/' + strId );
p.setRedirect(true);
return p;
}
}