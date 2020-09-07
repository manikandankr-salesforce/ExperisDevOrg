@isTest(SeeAllData=true)
public class ApplySpecificFilterControllerTest {
    //MPUController testCont = new MPUController();
    //testCont.createQuote();
    /*SBQQ__QuoteLine__c qteLine = [Select Id from SBQQ__QuoteLine__c LIMIT 1];
    SBQQ__QuoteLine__c qteLineValue = MPUController.findQuoteLineById(qteLine.Id);
    String recordId = [Select Id from Mass_Price_Update__c LIMIT 1].Id;
    List <MPUProductUpdateWrapper> mpuProdWrapper = MPUController.getQuoteLinesByRecordId(recordId,'');*/
    static testmethod void myTest(){
        Account a = new Account(name='accountmember1');
        insert a;
        ApplySpecificFilterController.getAccountList();
        Country__c c = new ExperisPricing__Country__c(name='TestCountry');
        insert c;
        ApplySpecificFilterController.getRegionList();
        Product_Family__c pf = new ExperisPricing__Product_Family__c(name='TestProductFamily');
        insert pf;
        ApplySpecificFilterController.getProdFamilyList();
        Division__c div = new Division__c(name='TestDivision');
        insert div;
        ApplySpecificFilterController.getDivisionList();
        Product2 prod = new Product2(name='TestProductName');
        insert prod;
        ApplySpecificFilterController.getProductList();
        
       // String recordId = [Select Id from Mass_Price_Update__c LIMIT 1].Id;
       // MPUProductUpdateWrapper mpuProdWrapper =  new MPUProductUpdateWrapper();
       // MPUController.getQuoteLinesByRecordId(recordId,'');       
    }
}