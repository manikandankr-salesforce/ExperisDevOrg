@isTest(SeeAllData=true)
public class SegmentTriggerTest {
    
  @istest static  void triggersAnalyticData()
    {
        Segment s=new Segment();
        Test.startTest();
       // s.getAnalyticData();
        ExperisPricing__Opt_Segment__c oSeg;
        List<ExperisPricing__Opt_Segment__c> oSegList=new List<ExperisPricing__Opt_Segment__c>();
        oSeg=new ExperisPricing__Opt_Segment__c(Name='Her-Factory-Law',ExperisPricing__No_Of_Transcation__c=200,ExperisPricing__Revenue__c=5000,ExperisPricing__X97th_Percentile__c=1000,
        ExperisPricing__X3rd_Percentile__c=20000,ExperisPricing__Minimum_Percentile_Discount__c=3000,ExperisPricing__Range_Discount__c=80000,ExperisPricing__Margin_Amount__c=3000
                                    ,ExperisPricing__Median_Discount__c=90000,ExperisPricing__Max_Percentile_Discount__c=5000,ExperisPricing__Margin_To_List__c=40000,ExperisPricing__SD_Discount__c=3000
                                    ,ExperisPricing__Yellow__c=20000,ExperisPricing__Green__c=9000,ExperisPricing__Red__c=80000,ExperisPricing__Valid__c='valid',ExperisPricing__Discount_Optimization_PID__c='a215w000004IdTYAA0');
        oSegList.add(oseg);
    	insert oSegList;
        
        
       List<ExperisPricing__Opt_Segment__c> oss2=[Select Name,ExperisPricing__Valid__c from ExperisPricing__Opt_Segment__c where ExperisPricing__No_Of_Transcation__c >200 ];
		for(ExperisPricing__Opt_Segment__c osc : oss2) 
        oSeg.ExperisPricing__Valid__c='Override';
        oss2.add(oSeg);
        update osegList;

        
        Test.stopTest();
    }
}