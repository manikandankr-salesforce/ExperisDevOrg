@isTest(SeeAllData=true)
public class SegmentTest{
  static testmethod void test1()
     {
  	Test.startTest();
   	List<ExperisPricing__Discount_Optimization__c> segment_Obj  = [SELECT Name,ExperisPricing__Discount_Optimization_ID__c,ExperisPricing__From_Date__c,ExperisPricing__To_Date__c,ExperisPricing__Status__c,ExperisPricing__Active__c from Discount_Optimization__c];
    System.assertEquals(true,segment_Obj.size()>0);
	List<ExperisPricing__Opt_Segment__c> oSegData2 = [SELECT Name,ExperisPricing__Active__c,ExperisPricing__Status__c,ExperisPricing__X97th_Percentile__c,ExperisPricing__X3rd_Percentile__c,ExperisPricing__From_Date__c,ExperisPricing__Green__c,Margin_Amount__c,ExperisPricing__Margin_To_List__c,ExperisPricing__Max_Percentile_Discount__c,ExperisPricing__Median_Discount__c,ExperisPricing__Minimum_Percentile_Discount__c,ExperisPricing__No_Of_Transcation__c,ExperisPricing__Range_Discount__c,ExperisPricing__Red__c,ExperisPricing__Revenue__c,ExperisPricing__Discount_Optimization_PID__c,ExperisPricing__SD_Discount__c,ExperisPricing__To_Date__c,ExperisPricing__Valid__c,ExperisPricing__Yellow__c FROM ExperisPricing__Opt_Segment__c where ExperisPricing__Discount_Optimization_PID__c =: 'a215w000004IdTYAA0'];
    Segment obj01 = new Segment(new ApexPages.StandardController(segment_Obj[0]));
    obj01.getAnalyticData();
    Test.stopTest();
	 }
    @istest static  void testAnalyticData()
    {
        Segment s=new Segment();
        Test.startTest();
        ExperisPricing__Opt_Segment__c oSeg;
        List<ExperisPricing__Opt_Segment__c> oSegList=new List<ExperisPricing__Opt_Segment__c>();
		oSeg=new ExperisPricing__Opt_Segment__c(Name='Her-Factory-Law',ExperisPricing__No_Of_Transcation__c=200,ExperisPricing__Revenue__c=5000,ExperisPricing__X97th_Percentile__c=1000,
        ExperisPricing__X3rd_Percentile__c=20000,ExperisPricing__Minimum_Percentile_Discount__c=3000,ExperisPricing__Range_Discount__c=80000,ExperisPricing__Margin_Amount__c=3000
                                    ,ExperisPricing__Median_Discount__c=90000,ExperisPricing__Max_Percentile_Discount__c=5000,ExperisPricing__Margin_To_List__c=40000,ExperisPricing__SD_Discount__c=3000
                                    ,ExperisPricing__Yellow__c=20000,ExperisPricing__Green__c=9000,ExperisPricing__Red__c=80000,ExperisPricing__Valid__c='valid',
									ExperisPricing__Active__c=True,ExperisPricing__Status__c='Approved',ExperisPricing__Discount_Optimization_PID__c ='a215w000004IdTYAA0');
        oSegList.add(oseg);
    	insert oSegList;
        
       List<ExperisPricing__Opt_Segment__c> oss2=[SELECT Name,ExperisPricing__Valid__c from ExperisPricing__Opt_Segment__c where ExperisPricing__No_Of_Transcation__c >200 ];
		for(ExperisPricing__Opt_Segment__c osc : oss2) 
        if(oSeg.ExperisPricing__Valid__c=='Override')
        {oss2.add(oSeg);}
        delete oss2;
        
        Test.stopTest();
    }
     @isTest
    static void TestgetOptSegResult()
    {
    	List<ExperisPricing__Opt_Segment__c> oSegData = [SELECT Name,ExperisPricing__Active__c,ExperisPricing__Status__c,ExperisPricing__X97th_Percentile__c,ExperisPricing__X3rd_Percentile__c,ExperisPricing__From_Date__c,ExperisPricing__Green__c,Margin_Amount__c,ExperisPricing__Margin_To_List__c,ExperisPricing__Max_Percentile_Discount__c,ExperisPricing__Median_Discount__c,ExperisPricing__Minimum_Percentile_Discount__c,ExperisPricing__No_Of_Transcation__c,ExperisPricing__Range_Discount__c,ExperisPricing__Red__c,ExperisPricing__Revenue__c,ExperisPricing__Discount_Optimization_PID__c,ExperisPricing__SD_Discount__c,ExperisPricing__To_Date__c,ExperisPricing__Valid__c,ExperisPricing__Yellow__c FROM ExperisPricing__Opt_Segment__c where ExperisPricing__Discount_Optimization_PID__c =: 'a215w000004IdTYAA0'];
    
        System.assertEquals(true,oSegData.size()>0);
    	Segment.getOptSegResult('test data');
    }
    @isTest
    static  void test_updateOptSegResult(){
    List<ExperisPricing__Discount_Optimization__c> segment_Obj  = [SELECT Name,ExperisPricing__Discount_Optimization_ID__c,ExperisPricing__From_Date__c,ExperisPricing__To_Date__c,ExperisPricing__Status__c,ExperisPricing__Active__c from Discount_Optimization__c];
    System.assertEquals(true,segment_Obj.size()>0);
    List<ExperisPricing__Opt_Segment__c> oSegData2 = [SELECT Name,ExperisPricing__Active__c,ExperisPricing__Status__c,ExperisPricing__X97th_Percentile__c,ExperisPricing__X3rd_Percentile__c,ExperisPricing__From_Date__c,ExperisPricing__Green__c,Margin_Amount__c,ExperisPricing__Margin_To_List__c,ExperisPricing__Max_Percentile_Discount__c,ExperisPricing__Median_Discount__c,ExperisPricing__Minimum_Percentile_Discount__c,ExperisPricing__No_Of_Transcation__c,ExperisPricing__Range_Discount__c,ExperisPricing__Red__c,ExperisPricing__Revenue__c,ExperisPricing__Discount_Optimization_PID__c,ExperisPricing__SD_Discount__c,ExperisPricing__To_Date__c,ExperisPricing__Valid__c,ExperisPricing__Yellow__c FROM ExperisPricing__Opt_Segment__c];
      	
    try{
            System.assertEquals(true,oSegData2.size()>0);
   			Segment obj01 = new Segment(new ApexPages.StandardController(segment_Obj[0]));
            Segment.updateOptSegResult(oSegData2);}
        catch(Exception e){}
            
  }
}