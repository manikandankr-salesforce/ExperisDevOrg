@isTest(SeeAllData=true)
public class ProductPriceListGenerationTest {
    @isTest
    static void PLGTest(){
        ExperisPricing__Price_List__c priceBook = new ExperisPricing__Price_List__c(Name ='PBookTest',RecordTypeId = '0125w000001Q1tMAAS',ExperisPricing__Generated_Status__c = 'Draft',ExperisPricing__Start_Date__c = Date.newInstance(2020, 01, 01),ExperisPricing__End_Date__c = Date.newInstance(2020, 12, 9));
        insert priceBook;
        String recordId = priceBook.Id;
        Test.startTest();
        ProductPriceListGeneration.getInitResult(recordId);
        ProductPriceListGeneration.generatePriceListRecords(recordId);
        Test.stopTest();
    }
}