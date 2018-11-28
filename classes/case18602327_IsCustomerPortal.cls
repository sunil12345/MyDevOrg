@isTest(seeAlldata = true)
public class case18602327_IsCustomerPortal
{
  
  public static testmethod void insertTestdata()
  {    
         
        List<Account> acclist = new List<Account>();   
        Profile p = [select id from profile where name='System Administrator'];
        UserRole r = [Select id from userrole where name='CEO'];
        
      
        User u = new User(alias = 'standt', email='amrita.sidhu@soti.net',
        emailencodingkey='UTF-8', lastname='Testing', 
        languagelocalekey='en_US', 
        localesidkey='en_US', profileid = p.Id, userroleid = r.Id,
        timezonesidkey='America/Los_Angeles', 
        username='1112amrita.sidhu@soti.net');

        User adminu = [select id from user where UserRole.name = 'CEO'][0];
        System.debug('adminu'+adminu);  
          
        Test.startTest();
        //Create account
        Account Acc1 = new Account(
        OwnerId = adminu.id,
        Name = '123456@TestAccount',
        BillingState  = 'ON',
        BillingCountry = 'CA'
        );
        insert Acc1; 
        
        system.debug('Acc Name   ------'+ Acc1.Name);
        system.debug('Acc1'+ Acc1.IsCustomerPortal);

        Account Acc2 = [Select Id, name ,IsCustomerPortal From Account where Id=:Acc1.Id ];
        system.debug('Acc2******'+ Acc2.IsCustomerPortal);
          
            Acc2.IsCustomerPortal = false;
            Acc2.Name='123456@TestAccountUpdated';
            update Acc2;
            System.debug('Acc2 IsCustomerPortal+++++++'+Acc2.IsCustomerPortal);
            Test.stopTest();
                
        }
        
            
  }