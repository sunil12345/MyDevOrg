/**
@ name            mapdemocontroller
@ author          http://www.aslambari.com
@ date            03 April, 2011
@ description     The controller for demo page, contains logic for fetching address data and makes model
*/
public class mapdemocontroller{
    public AddressModel addressmodel {get;set;}
    public mapdemocontroller(){
        addressmodel = new AddressModel();
        for(Account acc: [Select billingcity, billingstate, billingcountry, billingpostalcode,billingstreet, id, phone, name, website from Account where billingcountry != null and website != null and phone != null]){
            string address = acc.billingstreet != null ? acc.billingstreet.replaceall('\n','') :  '';
            if(address.trim().length() > 0 )
                address += ',';       
            address += acc.billingcity != null ? acc.billingcity : '';
            
            if(address.trim().length() > 0 )
                address += ',';       
            address += acc.billingstate != null ? acc.billingstate : '';

            if(address.trim().length() > 0 )
                address += ',';       
            address += acc.billingpostalcode != null ? acc.billingpostalcode : '';

            if(address.trim().length() > 0 )
                address += ',';       
            address += acc.billingcountry != null ? acc.billingcountry : '';
            
            addressmodel.add(address,
                             '',
                             '',
                             '<h3><a href=/' + acc.id + ' target=_blank>' + acc.name + '</a></h3>' +
                             '<br/>' + acc.phone + 
                             '<br /><a href=/' + acc.website + ' target=_blank>' + acc.website + '</a>');
        }
    
    }
}