public class myCaseControllerExtension {

    private final Account myCase;
    
    public string strAccId {get;set;}
    public string strAccName {get;set;}
    // The extension constructor initializes the private member
    // variable Case by using the getRecord method from the standard
    // controller.
    public myCaseControllerExtension(ApexPages.StandardController stdController) {
        this.myCase = (Account)stdController.getRecord();
        strAccId = myCase.id;
        //strAccName = myCase.Name;
        
    }

    public String foo() {
        return 'Something interesting  (' + myCase.id + ')';
    }
}