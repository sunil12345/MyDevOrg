public class AccountPageController {



    public ApexPages.StandardSetController setCon 
    {
        get {
            if(setCon == null) 
            {
                setCon = new ApexPages.StandardSetController(Database.getQueryLocator([SELECT Id, Status__c ,Name FROM Account Where Id='0017F00000agfgV']));
            }
            return setCon;
        }
        set;
    }

    public List<Account> getAccounts() 
    {
        return (List<Account>) setCon.getRecords();
    }

    public PageReference SaveRecord() 
    {
        update setCon.getRecords();
        PageReference pageRefer = new PageReference('/0017F00000agfgV');
        pageRefer.setRedirect(true);
        return pageRefer;
    }
}