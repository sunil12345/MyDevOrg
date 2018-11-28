trigger FeedItemRestrict on FeedItem (before insert) {
 
    
        for(feedItem tmp : trigger.new){           
                tmp.addError('API Unable to Post');
            }
}