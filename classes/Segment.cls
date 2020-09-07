public class Segment{
    private Discount_Optimization__c segm;
    private String sId;
    private String segName,segAutoId,status;
    private date fromDate,toDate;
    private Boolean act;
    public Segment(ApexPages.StandardController controller)
    {
        sId=controller.getId();
        segm=[SELECT Name,ExperisPricing__Discount_Optimization_ID__c,ExperisPricing__From_Date__c,ExperisPricing__To_Date__c,ExperisPricing__Status__c,ExperisPricing__Active__c from Discount_Optimization__c where Id=:sid];
        segName=segm.Name;
        segAutoId=segm.ExperisPricing__Discount_Optimization_ID__c;
        fromDate=segm.ExperisPricing__From_Date__c;
        toDate=segm.ExperisPricing__To_Date__c;
        status=segm.ExperisPricing__Status__c;
        act=segm.ExperisPricing__Active__c;
        //System.debug('++Segment++'+segm);
        
    }
    public Segment(){}
    List<ExperisPricing__Opt_Segment__c> oSegList=new List<ExperisPricing__Opt_Segment__c>();
	List<object> delList=new List<object>();
	public void getAnalyticData()
	{
	   //String query = 'q = load "0Fb5w000000QfK0CAK/0Fc5w000005Q01LCAS";q = group q by \'MarketSegments\';q=foreach q generate q.\'MarketSegments\' as \'MarketSegments\',100.00 as \'Red\',count(q) as \'No-of-Transcation\', sum(q.\'PocketMargin\') as \'Margin Amount\', sum(q.\'InvoicePrice\') as \'Revenue\',sum(q.\'ListPrice\') as \'ListPrice\',percentile_disc(0.97) within group (order by q.\'NegotiatedPercent\') as \'97thPercentile\',percentile_disc(0.03) within group (order by q.\'NegotiatedPercent\') as \'3rdpercentile\',percentile_disc(0.5) within group (order by q.\'NegotiatedPercent\') as \'50thpercentile\';q = foreach q generate \'MarketSegments\',\'Red\',\'No-of-Transcation\', \'Margin Amount\',\'Revenue\',\'ListPrice\',\'97thPercentile\',\'3rdpercentile\',\'3rdpercentile\'as \'Min Discount\',\'97thPercentile\'-\'3rdpercentile\'as\'Range\',\'50thpercentile\' as \'Median Discount\',\'97thPercentile\' as\'Max Discount\',\'Margin Amount\'/\'ListPrice\' as \'MarginList\',(\'97thPercentile\'-\'3rdpercentile\')/ 4 as \'SD Discount\',\'50thpercentile\'+(\'97thPercentile\'-\'3rdpercentile\')/ 4 as \'Yellow%\',\'50thpercentile\'+((\'97thPercentile\'-\'3rdpercentile\')/ 4)/2 as \'Green%\',(case when (\'50thpercentile\'+((\'97thPercentile\'-\'3rdpercentile\')/ 4)/2) > 100 || (\'50thpercentile\'+((\'97thPercentile\'-\'3rdpercentile\')/ 4)/2) < 0  then "Invalid"  when \'No-of-Transcation\' >200 then "Valid" when \'No-of-Transcation\' <200 then "No Data" else "Valid" end) as \'valid\';q = order q by (\'No-of-Transcation\' desc)';                                    
       String query = 'q = load "0Fb5w000000QfK0CAK/0Fc5w000005Q01LCAS";q = group q by \'ProductName\';q=foreach q generate q.\'ProductName\' as \'ProductName\',100.00 as \'Red\',count(q) as \'No-of-Transcation\', sum(q.\'PocketMargin\') as \'Margin Amount\', sum(q.\'InvoicePrice\') as \'Revenue\',sum(q.\'ListPrice\') as \'ListPrice\',percentile_disc(0.97) within group (order by q.\'NegotiatedPercent\') as \'97thPercentile\',percentile_disc(0.03) within group (order by q.\'NegotiatedPercent\') as \'3rdpercentile\',percentile_disc(0.5) within group (order by q.\'NegotiatedPercent\') as \'50thpercentile\';q = foreach q generate \'ProductName\',\'Red\',\'No-of-Transcation\', \'Margin Amount\',\'Revenue\',\'ListPrice\',\'97thPercentile\',\'3rdpercentile\',\'3rdpercentile\'as \'Min Discount\',\'97thPercentile\'-\'3rdpercentile\'as\'Range\',\'50thpercentile\' as \'Median Discount\',\'97thPercentile\' as\'Max Discount\',\'Margin Amount\'/\'ListPrice\' as \'MarginList\',(\'97thPercentile\'-\'3rdpercentile\')/ 4 as \'SD Discount\',\'50thpercentile\'+(\'97thPercentile\'-\'3rdpercentile\')/ 4 as \'Yellow%\',\'50thpercentile\'+((\'97thPercentile\'-\'3rdpercentile\')/ 4)/2 as \'Green%\',(case when (\'50thpercentile\'+((\'97thPercentile\'-\'3rdpercentile\')/ 4)/2) > 100 || (\'50thpercentile\'+((\'97thPercentile\'-\'3rdpercentile\')/ 4)/2) < 0  then "Invalid"  when \'No-of-Transcation\' >200 then "Valid" when \'No-of-Transcation\' <200 then "NoData" else "Valid" end) as \'valid\';q = order q by (\'No-of-Transcation\' desc);q=limit q 2000';
         
       ConnectApi.LiteralJson result = ConnectApi.Wave.executeQuery(query);
		String response = result.json;	
		Map<String,Object> responseMap = (Map<String,Object>)JSON.deserializeUntyped(response);
		Map<String,Object> resultMap = (Map<String,Object>)responseMap.get('results');
    	List<Object> records = (List<Object>) resultMap.get('records');
        //system.debug('*'+records);
        List<ExperisPricing__Opt_Segment__c> oss=[Select Name,ExperisPricing__Valid__c from ExperisPricing__Opt_Segment__c where ExperisPricing__Discount_Optimization_PID__c=: sId];
        List<ExperisPricing__Opt_Segment__c> updatedList=new List<Opt_Segment__c>();
        for(ExperisPricing__Opt_Segment__c osc : oss) 
                    {
                        if(osc.Valid__c =='Override')
                            { 
                                 osc.ExperisPricing__Active__c=act;
                                 osc.ExperisPricing__From_Date__c=fromDate;
                                 osc.ExperisPricing__To_Date__c=toDate;  
                                 osc.ExperisPricing__Status__c=status;
                                updatedList.add(osc);
                            }
                        update updatedList;
                    }
       
        List<ExperisPricing__Opt_Segment__c> delList=[select Name from ExperisPricing__Opt_Segment__c where ExperisPricing__Valid__c !='Override' AND ExperisPricing__Discount_Optimization_PID__c=: sId ];  
        if(delList.size()>0){ system.debug('dellist'+delList.size());
                             Delete delList;}

		for (Integer i = 0; i < records.size(); i++) 
    	{
            ExperisPricing__Opt_Segment__c oSeg=new ExperisPricing__Opt_Segment__c();
        	Map<String, Object> row = (Map<String, Object>) records[i];        
            
            oseg.ExperisPricing__Discount_Optimization_PID__c=sId;
            oseg.ExperisPricing__From_Date__c=fromDate;
            oseg.ExperisPricing__To_Date__c=toDate;  
            oseg.ExperisPricing__Status__c=status;
            oseg.ExperisPricing__Active__c=act;
            
            oSeg.Name=(string) row.get('ProductName');
            oSeg.ExperisPricing__No_Of_Transcation__c=(Integer) row.get('No-of-Transcation');
            oSeg.ExperisPricing__Revenue__c=(double) row.get('Revenue');
            oSeg.ExperisPricing__X97th_Percentile__c=(double) row.get('97thPercentile');
            oSeg.ExperisPricing__X3rd_Percentile__c=(double) row.get('3rdpercentile');
            oSeg.ExperisPricing__Minimum_Percentile_Discount__c=(double) row.get('Min Discount');
            oSeg.ExperisPricing__Range_Discount__c=(double) row.get('Range');
            oSeg.ExperisPricing__Margin_Amount__c=(double) row.get('Margin Amount');
            oSeg.ExperisPricing__Median_Discount__c	=(double) row.get('Median Discount');
            oSeg.ExperisPricing__Max_Percentile_Discount__c=(double) row.get('Max Discount');
            oSeg.ExperisPricing__Margin_To_List__c=(double) row.get('MarginList');
            oSeg.ExperisPricing__SD_Discount__c=(double) row.get('SD Discount');
            oSeg.ExperisPricing__Yellow__c=(double) row.get('Yellow%');
            oSeg.ExperisPricing__Green__c=(double) row.get('Green%');
            oSeg.ExperisPricing__Red__c=(double) row.get('Red');
            oSeg.ExperisPricing__Valid__c=(string)row.get('valid');
            if(oss.size() == 0){ oSegList.add(oseg);}           
            else{
                    for(Opt_Segment__c osc : oss) 
                    {
                        if((osc.Name == row.get('ProductName') && osc.ExperisPricing__Valid__c !='Override'))
                            { oSegList.add(oseg);}
                    }
                }
        }

   		//system.debug(''+oSegList);
    	insert oSegList;
    	//System.debug('*****Inserted new Records successfully*****');
    }
    @AuraEnabled
    public static List<ExperisPricing__Opt_Segment__c> getOptSegResult(String recordId)
    { 
        List<ExperisPricing__Opt_Segment__c> oSegData = [SELECT Name,ExperisPricing__Active__c,ExperisPricing__Status__c,ExperisPricing__X97th_Percentile__c,ExperisPricing__X3rd_Percentile__c,ExperisPricing__From_Date__c,ExperisPricing__Green__c,Margin_Amount__c,ExperisPricing__Margin_To_List__c,ExperisPricing__Max_Percentile_Discount__c,ExperisPricing__Median_Discount__c,ExperisPricing__Minimum_Percentile_Discount__c,ExperisPricing__No_Of_Transcation__c,ExperisPricing__Range_Discount__c,ExperisPricing__Red__c,ExperisPricing__Revenue__c,ExperisPricing__Discount_Optimization_PID__c,ExperisPricing__SD_Discount__c,ExperisPricing__To_Date__c,ExperisPricing__Valid__c,ExperisPricing__Yellow__c FROM Opt_Segment__c where ExperisPricing__Discount_Optimization_PID__c =: recordId];
        //System.debug('+'+osegData);
        return oSegData;
    }
    @AuraEnabled
    public static boolean updateOptSegResult(List<ExperisPricing__Opt_Segment__c> osc){
        try
        {update osc; return true;}
        catch(Exception e){return false;}
    }
}