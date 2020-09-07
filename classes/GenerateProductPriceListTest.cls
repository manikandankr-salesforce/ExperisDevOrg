@isTest(SeeAllData=true)
public class GenerateProductPriceListTest {
    @isTest
    static void GeneratePPTest(){
        ExperisPricing__Price_List__c priceBook = new ExperisPricing__Price_List__c(Name ='PBookTest',RecordTypeId = '0125w000001Q1tMAAS',ExperisPricing__Generated_Status__c = 'Draft',ExperisPricing__Start_Date__c = Date.newInstance(2020, 01, 01),ExperisPricing__End_Date__c = Date.newInstance(2020, 12, 9));
        insert priceBook;
        String recordId = priceBook.Id;
        
        List<Product2> prodRec = [Select Id,Family from Product2 LIMIT 1];
        String prodId = '';
        String family = '';
        for(Product2 product : prodRec){
            prodId = product.Id;
            family = product.Family;
        }
        List<Price_List_Record__c> plList = new List<Price_List_Record__c>();
        for(Integer i=0 ;i <200;i++)
        {
            ExperisPricing__Price_List_Record__c plRecord = new ExperisPricing__Price_List_Record__c();
            plRecord.Name ='Name'+i;
            plRecord.ExperisPricing__Price_List__c = recordId;
            plList.add(plRecord);
        }
        insert plList;
        Test.startTest();
        GenerateProductPriceList obj = new GenerateProductPriceList(recordId);
        DataBase.executeBatch(obj);
        Test.stopTest();
    }
}