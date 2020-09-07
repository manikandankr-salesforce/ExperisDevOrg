global class DeletePriceListRecords implements
    Database.Batchable<sObject>, Database.Stateful
{
    global Integer recordsProcessed = 0;
    private String recordId;
    private String recordTypeName;

    public DeletePriceListRecords(String Id,String recordName) {
        recordId = Id;
        recordTypeName = recordName;
    }
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator(
            'SELECT Id FROM Price_List_Record__c WHERE  Price_List__c =\''+ recordId +'\''
        );
    }
    
    global void execute (Database.BatchableContext bc, List<Price_List_Record__c> scope){
        List<Price_List_Record__c> plList = new List<Price_List_Record__c>();
        for (Price_List_Record__c plrecord : scope){
            plList.add(plRecord);
            recordsProcessed = recordsProcessed + 1;
        }
        delete plList;
    }
    
    global void finish (Database.BatchableContext bc){
       // System.debug(recordsProcessed + ' records processed. Delete!');
       // System.debug(bc.getJobId() + ' Job Id. delete!');
        if (recordTypeName == 'Product Price List'){
            Database.executeBatch(new GenerateProductPriceList(recordId),1000);
        }
        /*else if (recordTypeName == 'Regional Price List'){
            //Database.executeBatch(new GenerateRegionalPriceList(recordId),1000);
        }
        else if (recordTypeName == 'Customer Price List'){
           // Database.executeBatch(new GenerateCustomerPriceList(recordId),1000);
        }*/
           
    }
}