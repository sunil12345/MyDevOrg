public class ContentController {
    public blob file { get; set; }

    public PageReference upload() {
        ContentVersion v = new ContentVersion();
        v.versionData = file;
        v.title = 'testing upload1';
        v.pathOnClient ='/somepath.txt';
        //v.PublishStatus = 'public';
        insert v;
        return new PageReference('/' + v.id);
    }
}