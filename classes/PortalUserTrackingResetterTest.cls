@isTest(seeAlldata = true)
public class PortalUserTrackingResetterTest 
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
        Account portalAccount1 = new Account(
        OwnerId = adminu.id,
        Name = '123456@TestAccount',
        BillingState  = 'ON',
        BillingCountry = 'CA'
        );
        insert portalAccount1; 
        system.debug('Acc Name   ------'+ portalAccount1.Name);
        system.debug('portalAccount1'+ portalAccount1.IsCustomerPortal);

        //Create contact1
        Contact contact1 = new Contact(
        FirstName = 'gayathri',
        Lastname = 'maniam',
        AccountId = portalAccount1.Id,
        Email = '32423gayathri.maniam1234453@gmail.com'
        
        );
        insert contact1;

        User User1;
         User Us;
         Account Acc;
        //Get the Profile and Role Id's for Customer portal user and Customer portal Admin user user//
        Profile CommUserProf = [SELECT Id FROM profile WHERE name='Customer Community User' limit 1][0];  
        System.runAs(adminu) 
        {
            User1 = new user(
            Username = contact1.email+'testportaluser2342' ,
            Email = contact1.Email,
            Alias = 'testu423',
            LastName = contact1.LastName,
            ContactId = contact1.Id,
            CommunityNickname = contact1.lastname,
            ProfileId = CommUserProf.Id,
            IsActive = true,TimeZoneSidKey= 'GMT',
            LanguageLocaleKey = 'en_US',EmailEncodingKey  = 'UTF-8',
            LocaleSidKey = 'en_US'); 

            insert User1;
            system.debug('User1 type****'+ User1.IsPortalEnabled + User1 +'8888');
            Us = [select Id,IsPortalEnabled from User where Id =: User1.id][0];
            
            Us.IsPortalEnabled = false;
            
            update Us;
            system.debug('update user***'+ Us);
            
            system.debug('*****account check***'+[Select Id, name ,IsCustomerPortal From Account where Id=:portalAccount1.Id ]);
            system.debug('*******portalAccount1******'+ portalAccount1.IsCustomerPortal);
            Acc = [Select Id, name ,IsCustomerPortal From Account where Id=:portalAccount1.Id ][0];
            system.debug('*******portalAccount2******'+ Acc.IsCustomerPortal);
            //Us.IsPortalEnabled = false;
            //update Us;
            Acc.IsCustomerPortal = false;
            update Acc;
            system.debug('*******portalAccount3******'+ Us.IsPortalEnabled+ [Select Id, name ,IsCustomerPortal From Account where Id=: Acc.id]);
             //acclist.add(portalAccount1);
        }
        Us = [select Id,IsPortalEnabled from User where Id =: User1.id][0];

         Us.IsPortalEnabled = false;
        update Us;
        
        system.debug('update usercheck ***'+ Us);
        
        Account Acc2 = [Select Id, name ,IsCustomerPortal From Account where Id=: Acc.id][0];
        Acc2.IsCustomerPortal = false;
        update Acc2;
        system.debug('*******portalAccount4******'+ Us.IsPortalEnabled+ [Select Id, name ,IsCustomerPortal From Account where Id=: Acc2.id]);

            Test.stopTest();
  }

}