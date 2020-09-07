public with sharing class ApplySpecificFilterController {
    private static final String accQuery = 'Select Id,Name from Account order by Name asc';
    private static final String countryQuery = 'Select Id,Name from Country__c order by Name asc';
    private static final String prodFamilyQuery = 'Select Id,Family from Product2 where Family != null';
    private static final String divisionQuery = 'Select Id,Division__c from Product2 where Division__c != null';
    private static final String prodQuery = 'Select Id,Name from Product2 order by Name asc';
    private static final String accChannelQuery = 'Select Id,Account_Channel__c from Account where Account_Channel__c!=null';
    private static final String accClassQuery = 'Select Id,Customer_Classification__c from Account where Customer_Classification__c!=null';


    public ApplySpecificFilterController() {

    }

    @AuraEnabled
    public static List<Account> getAccountList(){
        List<Account> accList = Database.query(accQuery);
        return accList;
    }
    @AuraEnabled
    public static List<Country__c> getRegionList(){
        List<Country__c> countryList = Database.query(countryQuery);
        return countryList;
    }
    @AuraEnabled
    public static List<Product2> getProdFamilyList(){
       List<Product2> prodFamilyList = Database.query(prodFamilyQuery);
        System.debug('prodFamilyList------------'+prodFamilyList);
        return prodFamilyList;
    }
    @AuraEnabled
    public static List<Product2> getDivisionList(){
        List<Product2> divisionList = Database.query(divisionQuery);
        System.debug('divisionList------------'+divisionList);
        return divisionList;
    }
   
    @AuraEnabled
    public static List<Product2> getProductList(){
        List<Product2> prodList = Database.query(prodQuery);
        return prodList;
    }
    @AuraEnabled
    public static List<Account> getAccChannelList(){
        List<Account> accChannelList = Database.query(accChannelQuery);
        return accChannelList;
    }
    @AuraEnabled
    public static List<Account> getAccClassList(){
        List<Account> accClassList = Database.query(accClassQuery);
        return accClassList;
    }
}