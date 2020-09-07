@isTest(SeeAllData=true)
private class QuoteExtControllerTests {
    
   testMethod static void testSubmit() {
        SBQQ__Quote__c quote = new SBQQ__Quote__c(ExperisPricing__Quote_Name__c = 'Test Quote');
        insert quote;
        Test.startTest();
        QuoteExtController con = new QuoteExtController(new ApexPages.StandardController(quote));
        con.onSubmit();
        quote = [SELECT ExperisPricing__ApprovalStatus__c FROM SBQQ__Quote__c WHERE Id = :quote.Id LIMIT 1];
        Test.stopTest();
        
       // System.assertEquals('Approved', quote.ExperisPricing__ApprovalStatus__c);
    }
    
    testMethod static void testRecall() {
        SBQQ__Quote__c quote = new SBQQ__Quote__c(ExperisPricing__Quote_Name__c = 'Test Quote');
        insert quote;
        
        Test.startTest();
        QuoteExtController con = new QuoteExtController(new ApexPages.StandardController(quote));
        con.onRecall();
        quote = [SELECT ExperisPricing__ApprovalStatus__c FROM SBQQ__Quote__c WHERE Id = :quote.Id LIMIT 1];
        Test.stopTest();
        
        //System.assertEquals('Recalled', quote.ExperisPricing__ApprovalStatus__c);
    }
    
}