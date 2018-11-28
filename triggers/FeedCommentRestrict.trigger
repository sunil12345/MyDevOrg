trigger FeedCommentRestrict on FeedComment (before insert) {
    for(FeedComment fc : trigger.new){
        //if(fc.CommentType== 'ContentComment')
            fc.addError('Cannot Upload Files');
	}
}