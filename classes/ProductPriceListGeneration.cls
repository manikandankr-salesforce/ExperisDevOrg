public with sharing class ProductPriceListGeneration {
    //private Id pricebookId;
    //public static sbaa__Approval__c[] approvals {get; set;} 

    /*public PriceListGeneration(ApexPages.StandardController stdController) {
        pricebookId = stdController.getId();
    }*/
    
    @AuraEnabled
    public static List<Price_List_Record__c> getInitResult(String recordId)
    {
        List<Price_List_Record__c> pbEntryList = [SELECT Product2Id__c,Name,Product_Family_Name__c,Density__c,Base_Price__c,Family_Adj_Amt__c,Product_Adj_Amt__c,Manual_Override_Amt__c,UnitPrice__c,Past_Revenue__c,Quantity__c,Start_Date__c,End_date__c,Status__c FROM Price_List_Record__c WHERE  Price_List__c = :recordId];
        return pbEntryList;
    }
   
    @AuraEnabled
    public static void generatePriceListRecords(String recordId){
       
        String recordTypeName = [SELECT RecordType.Name FROM Price_List__c WHERE Id = :recordId].RecordType.Name;
        Id batchId = Database.executeBatch(new DeletePriceListRecords(recordId,recordTypeName),1000);
    }
   /* 
    private static PricebookEntry setProductRevenue(PricebookEntry pbEntry,String productName){
        List <Product_Revenue__c> prList = [SELECT Past_Revenue__c,Quantity__c FROM Product_Revenue__c WHERE Name = :productName];
        if (prList.size()>0){
            for(Product_Revenue__c prRecord : prList){
                pbEntry.Past_Revenue__c = prRecord.Past_Revenue__c;
                pbEntry.Quantity__c = prRecord.Quantity__c;
            }
            
        }
        return pbEntry;
    }*/

   
/*
    

    @AuraEnabled
    public static void onSubmit(String recordId) {
        if (recordId != null) {
            sbaa.ApprovalAPI.submit(recordId, sbaa__Approval__c.Price_Book__c);
        }
    }
    
    public void onPreview() {
        if (pricebookId != null) {
            approvals = sbaa.ApprovalAPI.preview(pricebookId, sbaa__Approval__c.Price_Book__c);
        }
    }*/
}