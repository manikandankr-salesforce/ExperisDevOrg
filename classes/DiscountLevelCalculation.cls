public class DiscountLevelCalculation {
    @InvocableMethod
    public static void updateDiscountLevel(List<ID> ids){
        Decimal discount = 0;
        Date startDate;
        Date endDate;
        String productName = '';
        Integer discountLevel = 0;
        List<SBQQ__QuoteLine__c> updateqlList = new List<SBQQ__QuoteLine__c>();
        List<SBQQ__QuoteLine__c> qlList = [Select Id,SBQQ__ProductName__c,SBQQ__Discount__c,SBQQ__StartDate__c,SBQQ__EndDate__c from SBQQ__QuoteLine__c where Id in :ids];
        System.debug('Sizeids' +ids.size());
        for(SBQQ__QuoteLine__c qlRecords : qlList){
            productName = qlRecords.SBQQ__ProductName__c;
            //discount = qlRecords.SBQQ__Discount__c;
            startDate = qlRecords.SBQQ__StartDate__c;
            endDate = qlRecords.SBQQ__EndDate__c;
            System.debug('Id' +qlRecords.Id);
        }
        //Find the DiscountLevel
        List<ExperisPricing__Opt_Segment__c> guidanceList = [Select Id,Name,ExperisPricing__Green__c,ExperisPricing__Yellow__c,ExperisPricing__Red__c from ExperisPricing__Opt_Segment__c where ExperisPricing__Status__c = 'Draft' and ExperisPricing__Active__c = true and ExperisPricing__From_Date__c <= :startDate and ExperisPricing__To_Date__c >= :endDate];
        for(SBQQ__QuoteLine__c qlRecords : qlList){
            discount = qlRecords.SBQQ__Discount__c;
            if(guidanceList.size()>0){  
                for(ExperisPricing__Opt_Segment__c optRecords : guidanceList){
                    if(optRecords.Name == qlRecords.SBQQ__ProductName__c){
                        System.debug('green:' + optRecords.ExperisPricing__Green__c);
                        if(discount <= optRecords.ExperisPricing__Green__c){
                            discountLevel = 1;
                        }else if (discount <= optRecords.ExperisPricing__Yellow__c){
                            discountLevel = 2;
                        }else if (discount > optRecords.ExperisPricing__Yellow__c){
                            discountLevel = 3;
                        }else
                        {
                            discountLevel = 0;
                        }
                        qlRecords.ExperisPricing__DiscountLevel__c = discountLevel;
            			updateqlList.add(qlRecords);
            			System.debug('discountLevel:' + qlRecords.ExperisPricing__DiscountLevel__c);
        
                    }
                }
            }
        }
        
      
        try{
            update updateqlList;
        }catch (DmlException e) {
            System.debug('A DML Exception has occured on Insert:'+e.getMessage());
        }
        
    }
}