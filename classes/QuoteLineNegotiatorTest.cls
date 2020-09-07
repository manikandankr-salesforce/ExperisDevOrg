@isTest(SeeAllData=true)
public class QuoteLineNegotiatorTest {
    @istest static string testQuoteId() {
         SBQQ__Quote__c q = new SBQQ__Quote__c();
            q.SBQQ__Type__c ='Amendment';
            insert(q);  
            SBQQ__QuoteLine__c line = new SBQQ__QuoteLine__c();
            System.debug('@@@@@@@@@@@@@@@@@@@@ Inside confirm method @@@@@@@@@@@@@@@@@@@@@@@@@@'+line);
            line.SBQQ__Quote__c = 'Q-00101';
            line.SBQQ__PricebookEntryId__c='01u2w000001155dAAA';
            line.SBQQ__Quantity__c=1;
            line.SBQQ__ListPrice__c=1000;
            line.SBQQ__NetPrice__c=1000;
            insert (line);
         SBQQ__QuoteLine__c qLItem = [SELECT Id,SBQQ__ProductName__c
                    FROM SBQQ__QuoteLine__c Order by CreatedDate desc LIMIT 1];
        Id recordId = qLItem.Id;
        String qID = [SELECT SBQQ__Quote__c FROM SBQQ__QuoteLine__c WHERE  Id = :recordId].SBQQ__Quote__c;     
        return qID;
    }
}