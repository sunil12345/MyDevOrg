public with sharing class DFPresentationController1
{

  public Flow.Interview.CallPageNameFlow dfFlow {get; set;}
  
   
   
  public DFPresentationController1(ApexPages.StandardController stdController) {
    }
   
   public String getAccountId() {
        if (dfFlow==null) {
        system.debug('**dfFlow*IN*'+dfFlow);
        return '/006';
        
        }
        else 
        
        {
        system.debug('**dfFlow*OUT*'+dfFlow);
            return dfFlow.varAccountID;
        
        }
  }

 
  public PageReference getFinishPage()
  {
  system.debug('*dfFlow***'+dfFlow);
  String strId;
  if(dfFlow != null){
  system.debug('*******'+(String) dfFlow.getVariableValue('Accountid'));
  strId = (String) dfFlow.getVariableValue('Accountid');
  
  
  }
  else{
   system.debug('== null==');
   
   //PageReference p = new PageReference('/'+'home/home.jsp');
       // p.setRedirect(true);
       // return p;
   
   }
   
   system.debug('**strId *'+strId );
       PageReference p = new PageReference('/'+'006');
        p.setRedirect(true);
        return p;
  
    
  }
 
}