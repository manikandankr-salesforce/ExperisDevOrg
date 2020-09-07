public class DeleteTest {
    public DeleteTest(){
        
    }
    public void  Test(){
          List<Mass_Price_Update__c> ids = [select Id from Mass_Price_Update__c];
         delete ids;
        
        List<MPU_Filter_Criteria__c> idss = [select Id from MPU_Filter_Criteria__c];
        delete idss;
          List<Quote_Line_Change_Detail__c> chids = [select Id from Quote_Line_Change_Detail__c];
		 delete chids;
          //  system.debug('Change Detail '+chids);
		 // List<SBQQ__Quote__c> ids = [select Id from SBQQ__Quote__c];
         	//  List<Account> ids = [select Id from Account where Name = 'Quote MPU New'];
			//delete ids;		
            
        //  List<SBQQ__ContractedPrice__c> cids = [select Id from SBQQ__ContractedPrice__c where SBQQ__Product__r.Name = 'MPU Product'];
         //delete cids;
              //        List<Quote_Line_Change_Detail__c> chids = [select Id from Quote_Line_Change_Detail__c];
  			//delete chids;
    }

}