@isTest(SeeAllData=true)
public class LineNegotiatorTest {
@isTest
    static void LNTest(){
        Test.startTest();
        	String recordId = [SELECT Id,SBQQ__Quote__c FROM SBQQ__QuoteLine__c LIMIT 1].Id;
        	LineNegotiator.getQuoteId(recordId);
        Test.stopTest();
    }
}