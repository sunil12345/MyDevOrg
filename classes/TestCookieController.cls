global class TestCookieController {

    global PageReference TestCookie()
    {
        Cookie sfcookie = ApexPages.currentPage().getCookies().get('sfCookie');
        if (sfcookie != null)
        {
      system.debug('sfcookie value:'+ sfcookie);            
            system.debug('sfCookie :' +sfcookie.getValue());
        
            Map<String, Object> sfCookieValueMap = (Map<String, Object>)JSON.deserializeUntyped(sfcookie.getValue());  
            system.debug('sfCookieValueMap:'+ sfCookieValueMap);
            string uid = String.valueOf(sfCookieValueMap.get('testUID'));
        }
        
        return null;
    }
}