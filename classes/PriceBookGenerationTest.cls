@isTest(SeeAllData=true)
public class PriceBookGenerationTest {
@isTest
    static void PLGTest(){
        Pricebook2 priceBook = new Pricebook2(Name ='PBookTest', Product_Family__c ='Olefines');
        insert priceBook;
        List<Product2> prodRec = [Select Id,Family from Product2 LIMIT 1];
        String prodId = '';
        String family = '';
        String recordId = priceBook.Id;
        for(Product2 product : prodRec){
            prodId = product.Id;
            family = product.Family;
        }
        //PriceBookEntry pBookId = new PriceBookEntry(Product2Id=prodId);
        //insert pBookId;
        Test.startTest();
        PriceBookGeneration.getInitResult(recordId);
        PriceBookGeneration.getProductRecords(recordId);
        //PriceBookGeneration.setProductRevenue(pBookId,prodId);
        Test.stopTest();
    }
}