@isTest(SeeAllData=true)
public class DeletePriceListRecordsTest {
    @isTest
    static void deletePLTest(){
        ExperisPricing__Price_List__c priceBook = new ExperisPricing__Price_List__c(Name ='PBookTest',RecordTypeId = '0125w000001Q1tMAAS',ExperisPricing__Generated_Status__c = 'Draft',ExperisPricing__Start_Date__c = Date.newInstance(2020, 01, 01),ExperisPricing__End_Date__c = Date.newInstance(2020, 12, 9));
        insert priceBook;
        String recordId = priceBook.Id;
        
        List<ExperisPricing__Price_List_Record__c> plList = new List<ExperisPricing__Price_List_Record__c>();
        for(Integer i=0 ;i <200;i++)
        {
            ExperisPricing__Price_List_Record__c plRecord = new ExperisPricing__Price_List_Record__c();
            plRecord.Name ='Name'+i;
            plRecord.ExperisPricing__Price_List__c = recordId;
            plList.add(plRecord);
        }
        insert plList;
        delete plList;
        
        Test.startTest();
        DeletePriceListRecords obj = new DeletePriceListRecords(recordId,'Product Price List');
        DataBase.executeBatch(obj);
        Test.stopTest();
    }
}