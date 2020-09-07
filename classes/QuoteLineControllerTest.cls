@isTest(SeeAllData=true)
public class QuoteLineControllerTest {
@isTest
    static void QLCTest(){
        Test.startTest();
        SBQQ__QuoteLine__c qLItem = [SELECT Id,SBQQ__ProductName__c
                    FROM SBQQ__QuoteLine__c Order by CreatedDate desc LIMIT 1];
        Id qLID = qLItem.Id;
        QuoteLineController qlC =new QuoteLineController();
        qlC.qid = qLID;
        qlC.quoteLine = qLItem;
        qlC.getQuoteLine();
        qlC.save();
        Test.stopTest();
    }
}