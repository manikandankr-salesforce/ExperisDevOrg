public with sharing class LineNegotiator {

    @AuraEnabled
    public static String getQuoteId(String recordId)
    {
        String qID = [SELECT SBQQ__Quote__c FROM SBQQ__QuoteLine__c WHERE  Id = :recordId].SBQQ__Quote__c;
        return qID;
    }
    
}