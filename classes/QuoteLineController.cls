public class QuoteLineController {
    
    @TestVisible private SBQQ__QuoteLine__c quoteLine;
    public ID qid {get;set;}

    
    public QuoteLineController() {
        qid= ApexPages.currentPage().getparameters().get('id');
      	List<SBQQ__QuoteLine__c> qteLineList = [SELECT SBQQ__ProductName__c
                    FROM SBQQ__QuoteLine__c WHERE Id = :ApexPages.currentPage().getParameters().get('id')
                  ];
        if(qteLineList.size()>0){
        	quoteLine = qteLineList.get(0);
        }
        
                 
    }
    
    public SBQQ__QuoteLine__c getQuoteLine() {
        return quoteLine;
    }
    
    public PageReference save() {
        update quoteLine;
        return null;
    }
    
    //public String getURL() {
     // String URL = ApexPages.CurrentPage().GetURL();
      // return URL.substring(0,URL.indexOf('?'));
   // }
    
   // public PageReference Cancel(){
    //   return null;
   // }
}