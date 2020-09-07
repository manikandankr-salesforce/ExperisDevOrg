public with sharing class PriceChangeImpactController {

    private static final String OverallPriceImpactQuery = 'Select sum(Past_Revenue__c) PastRevenue,sum(Target_Revenue__c) TargetRevenue from PricebookEntry';
    private static final String PrdFamPriceImpactQuery = 'Select Product_Family_Name__c ProductFamily,sum(Past_Revenue__c) PastRevenue,sum(Target_Revenue__c) TargetRevenue from PricebookEntry';
    public Id recordId{get;set;}
    
    public PriceChangeImpactController() {
       recordId  = ApexPages.CurrentPage().getparameters().get('id');
       system.debug('PriceBook Id **********************'+recordId);
    }

    public List<Data> getData(){
        //For Overall Price Change Impact
        List<Data> data = new List<Data>();

        String PriceImpactQuery = OverallPriceImpactQuery + ' Where Pricebook2Id =\''+recordId+'\' Group by Pricebook2Id';
        List<AggregateResult> results = Database.query(PriceImpactQuery);

        for(AggregateResult record:results){
            data.add(new Data('Overall',(Decimal)record.get('PastRevenue'),(Decimal)record.get('TargetRevenue'),((Decimal)record.get('TargetRevenue') - (Decimal)record.get('PastRevenue'))));
        }
        
        //For Product Family based Price Change Impact
        String PriceImpactQuery2 = PrdFamPriceImpactQuery + ' Where Pricebook2Id =\''+recordId+'\' Group by Product_Family_Name__c';
        List<AggregateResult> results2 = Database.query(PriceImpactQuery2);

        for(AggregateResult record:results2){
            data.add(new Data((String)record.get('ProductFamily'),(Decimal)record.get('PastRevenue'),(Decimal)record.get('TargetRevenue'),((Decimal)record.get('TargetRevenue') - (Decimal)record.get('PastRevenue'))));
        }
        
        return data;
    }

    public class Data{
        public String name { get; set; }
        public Decimal data1 { get; set; }
        public Decimal data2 { get; set; }
        public Decimal data3 { get; set; }

        public Data(String name,Decimal data1, Decimal data2, Decimal data3){
            this.name = name;
            this.data1 = data1;
            this.data2 = data2;
           this.data3 = data3;

        }
    }

}