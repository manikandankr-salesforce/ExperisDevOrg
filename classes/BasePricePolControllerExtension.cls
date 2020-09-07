public with sharing class BasePricePolControllerExtension{
    private ApexPages.StandardSetController setController;

    public BasePricePolControllerExtension(ApexPages.StandardSetController setController) {
       /*  this.setController = setController;
        
       Base_Price_Policy__c [] records = [SELECT Id, Name FROM Base_Price_Policy__c LIMIT 30];
        setController.setSelected(records);*/
    }
}