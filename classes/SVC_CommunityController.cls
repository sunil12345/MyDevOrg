public with sharing class SVC_CommunityController
{
    /**
     * Wrapper class for menu item result
     */
    public class NavigationItem
    {
        /**
         * Tile label
         */
        @AuraEnabled
        public String Label {get; set;}
        /**
         * Access restriction (logged in users only or public)
         */
        @AuraEnabled
        public String AccessRestriction {get; set;}
        /**
         * Default list view id for list view pages
         */
        @AuraEnabled
        public String DefaultListViewId {get; set;}
        /**
         * Tile position
         */
        @AuraEnabled
        public Integer Position {get; set;}
        /**
         * Target link / page / etc
         */
        @AuraEnabled
        public String Target {get; set;}
        /**
         * Type of the target (external / internal link, etc)
         */
        @AuraEnabled
        public String Type {get; set;}
        /**
         * Image url
         */
        @AuraEnabled
        public String ImageUrl {get; set;}

        /**
         * Class constructor
         *
         * @param  nmi      Menu item element
         * @param  imageMap Image path to extract image path
         */
        public NavigationItem(NavigationMenuItem nmi, Map<String, String> imageMap) {
            Label             = nmi.Label;
            AccessRestriction = nmi.AccessRestriction;
            DefaultListViewId = nmi.DefaultListViewId;
            Position          = nmi.Position;
            Target            = nmi.Target;
            Type              = nmi.Type;

            // setup image url
            String imageKey   = String.isBlank(Label) ? 'default' : Label.toLowerCase('en');
            ImageUrl          = imageMap.containsKey(imageKey) ? imageMap.get(imageKey) : imageMap.get('default');
        }
    }
    /**
     * Method returns list of available menu items / tiles for community landing page
     *
     * @return Lits of menu items / tiles
     */
    @AuraEnabled
    public static List<NavigationItem> getMenuItems()
    {
        return processMenuItems(
            getItemsList()
        );
    }

    /**
     * Method converts NavigationMenuItem objects to NavigationItem wrappers
     * @param  menuItems List of defined menu items
     * @return           Wrapped menu items
     */
    @TestVisible
    private static List<NavigationItem> processMenuItems(List<NavigationMenuItem> menuItems)
    {
        List<NavigationItem> result  = new List<NavigationItem>();

        if(!menuItems.isEmpty()) {
            Map<String, String> imageMap = getImageMap();

            for (NavigationMenuItem nmi : menuItems) {
                result.add(
                    convertToNavigationItem(nmi, imageMap)
                );
            }
        }

        return result;
    }
    /**
     * Method converts NavigationMenuItem to NavigationItem
     * @param  nmi      Navigation Menu item
     * @param  imageMap Image map
     * @return          NavigationItem
     */
    private static NavigationItem convertToNavigationItem(NavigationMenuItem nmi, Map<String, String> imageMap)
    {
        if (nmi.Target == 'Account' && nmi.Type == 'SalesforceObject') {
            String recordId = getRelatedAccountId();
            if (!String.isBlank(recordId)) {
                nmi.Type              = 'sObject';
                nmi.Target            = recordId;
                nmi.DefaultListViewId = null;
            }
        }
        return new NavigationItem(nmi, imageMap);
    }

    /**
     * Method returns list of available menu items defined for community
     *
     * @return available menu items
     */
    @TestVisible
    private static List<NavigationMenuItem> getItemsList()
    {
        Set<String> AccessRestrictions = new Set<String>{'None'};

        if ([SELECT Id FROM User WHERE Id = :Userinfo.getUserId() AND UserType = 'Guest'].isEmpty()) {
            AccessRestrictions.add('LoginRequired');
        }

        return [
            SELECT
                AccessRestriction, DefaultListViewId, Id, Label,
                NavigationLinkSetId, Position, Target, Type
            FROM
                NavigationMenuItem
            WHERE
                NavigationLinkSetId IN (
                    SELECT
                        Id
                    FROM
                        NavigationLinkSet
                    WHERE
                        NetworkId = :Network.getNetworkId()
                    AND
                        Language = :UserInfo.getLanguage()
                )
            AND
                AccessRestriction IN :AccessRestrictions
            ORDER BY
                Position ASC
        ];
    }
    /**
     * Method returns a map of images that will be applied to tiles
     *
     * @return Map indexed with lower case menu item label and image path as values
     */
    @TestVisible
    private static Map<String, String> getImageMap()
    {
        
        return null;
    }

    /**
     * Method returns account id if user is linked to exactly one account,
     * otherwise null
     *
     * @return Account Id or null
     */
    @AuraEnabled
    public static String getRelatedAccountId()
    {
        return null;
    }

    /**
     * Wrapper class for problem list request response
     */
    public class ProblemListWrapper {
        /**
         * Problem list / data
         */
        @AuraEnabled
        public List<Account> data {get; set;}
        /**
         * Columns / list view definition
         */
        @AuraEnabled
        public String definition {get; set;}
        /**
         * Total size of the full data set (number of records)
         */
        @AuraEnabled
        public Integer totalSize {get; set;}
        /**
         * Number of pages full result has
         */
        @AuraEnabled
        public Integer pagesCount {get; set;}
        /**
         * Class constructor
         * @param  ctl           Standard Set controller used to fetch data
         * @param  definitionStr JSON encoded list view definition
         */
        public ProblemListWrapper(ApexPages.StandardSetController ctl, String definitionStr)
        {
            totalSize  = ctl.getResultSize();
            data       = ctl.getRecords();
            pagesCount = ctl.getResultSize() != 0 ? Integer.valueOf(Math.ceil(Decimal.valueOf(ctl.getResultSize()) / ctl.getPageSize())) : 0;

            definition = definitionStr;
        }
    }

    
    
}