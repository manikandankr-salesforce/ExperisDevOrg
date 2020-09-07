public with sharing class QuoteLineNegotiator {
    
    @AuraEnabled
    public static String getPrimaryNeg(String recordId)
    {
        String prmNeg = [SELECT ExperisPricing__PrimaryNegotiator__c FROM SBQQ__QuoteLine__c WHERE  Id = :recordId].ExperisPricing__PrimaryNegotiator__c;
        system.debug('Quote Line eventFields :#######################  '+prmNeg);      
        return prmNeg;
    }
    
    @AuraEnabled
    public static String getQuoteId(String recordId,String qFields)
    {
        ExperisPricing__Negotiator__c[] negotiator = [SELECT Id FROM ExperisPricing__Negotiator__c WHERE Quote_Line__r.Id = :recordId]; 
        delete negotiator;
        insertNegotiator(recordId,qFields);
        return getQuoteIdfromLine(recordId);
        
    }
    public static String getQuoteIdfromLine(String recordId){
        String qID = [SELECT SBQQ__Quote__c FROM SBQQ__QuoteLine__c WHERE  Id = :recordId].SBQQ__Quote__c;
        return qID;
    }
    @AuraEnabled
    public static String getQuoteId2(String recordId,String qFields)
    {
        ExperisPricing__Negotiator_2__c[] negotiator = [SELECT Id FROM ExperisPricing__Negotiator_2__c WHERE Quote_Line__r.Id = :recordId]; 
        delete negotiator;
        insertNegotiator2(recordId,qFields);
        return getQuoteIdfromLine(recordId);
    }
    
    @AuraEnabled
    public static String getQuoteId3(String recordId,String qFields)
    {
        ExperisPricing__Negotiator_3__c[] negotiator = [SELECT Id FROM ExperisPricing__Negotiator_3__c WHERE Quote_Line__r.Id = :recordId]; 
        delete negotiator;
        insertNegotiator3(recordId,qFields);
        return getQuoteIdfromLine(recordId);
    }
    
    @AuraEnabled
    public static void insertNegotiator(String recordId,String qFields){
        SBQQ__QuoteLine__c quoteLine = (SBQQ__QuoteLine__c) System.JSON.deserialize(qFields, SBQQ__QuoteLine__c.class);
        
        ExperisPricing__Negotiator__c neg = new ExperisPricing__Negotiator__c();
        neg.ExperisPricing__Base_Price__c = quoteLine.ExperisPricing__Base_Price__c;
        neg.ExperisPricing__Family_Adjustment__c = quoteLine.ExperisPricing__Family_Adjustment__c;
        neg.ExperisPricing__Product_Adjustment__c = quoteLine.ExperisPricing__Product_Adjustment__c;
        neg.ExperisPricing__Parter_Channel_Discount__c = quoteLine.ExperisPricing__Parter_Channel_Discount__c;
        neg.ExperisPricing__Volume_Discount__c = quoteLine.ExperisPricing__Volume_Discount__c;
        neg.ExperisPricing__Freight_Charge__c = quoteLine.ExperisPricing__Freight_Charge__c;
        neg.ExperisPricing__Additional_Discount__c = quoteLine.SBQQ__Discount__c;
        neg.ExperisPricing__Additional_Discount_Amt__c = quoteLine.ExperisPricing__Additional_Discount_Amt__c;
        neg.ExperisPricing__Revenue_Rebate__c = quoteLine.ExperisPricing__Revenue_Rebate__c;
        neg.ExperisPricing__Volume_Rebate__c = quoteLine.ExperisPricing__Volume_Rebate__c;
        neg.ExperisPricing__Service_Cost__c = quoteLine.ExperisPricing__Service_Cost__c;
        neg.ExperisPricing__Freight_Cost__c = quoteLine.ExperisPricing__Fixed_Cost__c;
        neg.ExperisPricing__Standard_Cost__c = quoteLine.ExperisPricing__Standard_Cost__c;
        neg.ExperisPricing__List_Price__c = quoteLine.SBQQ__ListPrice__c;
        neg.ExperisPricing__Customer_Price1__c = quoteLine.ExperisPricing__Product_Invoice_Price__c;
        neg.ExperisPricing__Invoice_Price1__c = quoteLine.ExperisPricing__Invoice_Price__c;
        neg.ExperisPricing__Net_Price1__c = quoteLine.ExperisPricing__Net_Price__c;
        neg.ExperisPricing__Pocket_Price1__c = quoteLine.ExperisPricing__Pocket_Price__c;
        neg.ExperisPricing__Pocket_Margin1__c = quoteLine.ExperisPricing__Pocket_Margin__c;
        neg.Quote_Line__c = recordId;
        neg.Name = 'Neg-'+recordId;
        insert neg;
    }
    
    @AuraEnabled
    public static void insertNegotiator2(String recordId,String qFields){
        SBQQ__QuoteLine__c quoteLine = (SBQQ__QuoteLine__c) System.JSON.deserialize(qFields, SBQQ__QuoteLine__c.class);
        
        ExperisPricing__Negotiator_2__c neg = new ExperisPricing__Negotiator_2__c();
        neg.ExperisPricing__Base_Price__c = quoteLine.ExperisPricing__Base_Price__c;
        neg.ExperisPricing__Family_Adjustment__c = quoteLine.ExperisPricing__Family_Adjustment__c;
        neg.ExperisPricing__Product_Adjustment__c = quoteLine.ExperisPricing__Product_Adjustment__c;
        neg.ExperisPricing__Parter_Channel_Discount__c = quoteLine.ExperisPricing__Parter_Channel_Discount__c;
        neg.ExperisPricing__Volume_Discount__c = quoteLine.ExperisPricing__Volume_Discount__c;
        neg.ExperisPricing__Freight_Charge__c = quoteLine.ExperisPricing__Freight_Charge__c;
        neg.ExperisPricing__Additional_Discount__c = quoteLine.SBQQ__Discount__c;
        neg.ExperisPricing__Additional_Discount_Amt__c = quoteLine.ExperisPricing__Additional_Discount_Amt__c;
        neg.ExperisPricing__Revenue_Rebate__c = quoteLine.ExperisPricing__Revenue_Rebate__c;
        neg.ExperisPricing__Volume_Rebate__c = quoteLine.ExperisPricing__Volume_Rebate__c;
        neg.ExperisPricing__Service_Cost__c = quoteLine.ExperisPricing__Service_Cost__c;
        neg.ExperisPricing__Freight_Cost__c = quoteLine.ExperisPricing__Fixed_Cost__c;
        neg.ExperisPricing__Standard_Cost__c = quoteLine.ExperisPricing__Standard_Cost__c;
        neg.ExperisPricing__List_Price__c = quoteLine.SBQQ__ListPrice__c;
        neg.ExperisPricing__Customer_Price1__c = quoteLine.ExperisPricing__Product_Invoice_Price__c;
        neg.ExperisPricing__Invoice_Price1__c = quoteLine.ExperisPricing__Invoice_Price__c;
        neg.ExperisPricing__Net_Price1__c = quoteLine.ExperisPricing__Net_Price__c;
        neg.ExperisPricing__Pocket_Price1__c = quoteLine.ExperisPricing__Pocket_Price__c;
        neg.ExperisPricing__Pocket_Margin1__c = quoteLine.ExperisPricing__Pocket_Margin__c;
        neg.Quote_Line__c = recordId;
        neg.Name = 'Neg-'+recordId;
        insert neg;
    }
    
    @AuraEnabled
    public static void insertNegotiator3(String recordId,String qFields){
        SBQQ__QuoteLine__c quoteLine = (SBQQ__QuoteLine__c) System.JSON.deserialize(qFields, SBQQ__QuoteLine__c.class);
        
        ExperisPricing__Negotiator_3__c neg = new ExperisPricing__Negotiator_3__c();
        neg.ExperisPricing__Base_Price__c = quoteLine.ExperisPricing__Base_Price__c;
        neg.ExperisPricing__Family_Adjustment__c = quoteLine.ExperisPricing__Family_Adjustment__c;
        neg.ExperisPricing__Product_Adjustment__c = quoteLine.ExperisPricing__Product_Adjustment__c;
        neg.ExperisPricing__Partner_Channel_Discount__c = quoteLine.ExperisPricing__Parter_Channel_Discount__c;
        neg.ExperisPricing__Volume_Discount__c = quoteLine.ExperisPricing__Volume_Discount__c;
        neg.ExperisPricing__Additional_Discount_Amt__c = quoteLine.ExperisPricing__Additional_Discount_Amt__c;
        neg.ExperisPricing__Freight_Charge__c = quoteLine.ExperisPricing__Freight_Charge__c;
        neg.ExperisPricing__Additional_Discount__c = quoteLine.SBQQ__Discount__c;
        neg.ExperisPricing__Revenue_Rebate__c = quoteLine.ExperisPricing__Revenue_Rebate__c;
        neg.ExperisPricing__Volume_Rebate__c = quoteLine.ExperisPricing__Volume_Rebate__c;
        neg.ExperisPricing__Service_Cost__c = quoteLine.ExperisPricing__Service_Cost__c;
        neg.ExperisPricing__Freight_Cost__c = quoteLine.ExperisPricing__Fixed_Cost__c;
        neg.ExperisPricing__Standard_Cost__c = quoteLine.ExperisPricing__Standard_Cost__c;
        neg.ExperisPricing__List_Price1__c = quoteLine.SBQQ__ListPrice__c;
        neg.ExperisPricing__Customer_Price1__c = quoteLine.ExperisPricing__Product_Invoice_Price__c;
        neg.ExperisPricing__Invoice_Price1__c = quoteLine.ExperisPricing__Invoice_Price__c;
        neg.ExperisPricing__Net_Price1__c = quoteLine.ExperisPricing__Net_Price__c;
        neg.ExperisPricing__Pocket_Price1__c = quoteLine.ExperisPricing__Pocket_Price__c;
        neg.ExperisPricing__Pocket_Margin1__c = quoteLine.ExperisPricing__Pocket_Margin__c;
        neg.Quote_Line__c = recordId;
        neg.Name = 'Neg-'+recordId;
        insert neg;
    }
    
    @AuraEnabled
    public static List<ExperisPricing__Negotiator__c> getNegotiator1Values(String recordId){
        List<ExperisPricing__Negotiator__c> negotiator1 = [SELECT ExperisPricing__Additional_Discount__c,ExperisPricing__Additional_Discount_Amt__c,ExperisPricing__List_Price__c,ExperisPricing__Customer_Price1__c,ExperisPricing__Invoice_Price1__c,ExperisPricing__Net_Price1__c,   ExperisPricing__Pocket_Price1__c,ExperisPricing__Pocket_Margin1__c FROM ExperisPricing__Negotiator__c WHERE ExperisPricing__Quote_Line__r.Id = :recordId];
        
        //List<ExperisPricing__Negotiator__c> negotiator1 = [SELECT Additional_Discount__c,Quote_Line__c,Customer_Price__c FROM ExperisPricing__Negotiator__c WHERE ExperisPricing__Quote_Line__r.Id = :recordId];
        system.debug('Quote Line eventFields Negotiator__c:#######################  '+negotiator1);   
        return negotiator1;
    }
    
    @AuraEnabled
    public static List<ExperisPricing__Negotiator_2__c> getNegotiator2Values(String recordId){
        List<ExperisPricing__Negotiator_2__c> negotiator2 = [SELECT ExperisPricing__Additional_Discount__c,ExperisPricing__Additional_Discount_Amt__c,ExperisPricing__List_Price__c,ExperisPricing__Customer_Price1__c,ExperisPricing__Invoice_Price1__c,ExperisPricing__Net_Price1__c,ExperisPricing__Pocket_Price1__c,ExperisPricing__Pocket_Margin1__c FROM ExperisPricing__Negotiator_2__c WHERE ExperisPricing__Quote_Line__r.Id = :recordId];
        
        //List<ExperisPricing__Negotiator_2__c> negotiator2 = [SELECT Additional_Discount__c,Quote_Line__c,Customer_Price__c FROM ExperisPricing__Negotiator_2__c WHERE ExperisPricing__Quote_Line__r.Id = :recordId];
        system.debug('Quote Line eventFields Negotiator__c:#######################  '+negotiator2);   
        return negotiator2;
    }
    
    @AuraEnabled
    public static List<ExperisPricing__Negotiator_3__c> getNegotiator3Values(String recordId){
        
        
        List<ExperisPricing__Negotiator_3__c> negotiator3 = [SELECT ExperisPricing__Additional_Discount__c,ExperisPricing__Additional_Discount_Amt__c,ExperisPricing__List_Price1__c,ExperisPricing__Customer_Price1__c,ExperisPricing__Invoice_Price1__c,ExperisPricing__Net_Price1__c,ExperisPricing__Pocket_Price1__c,ExperisPricing__Pocket_Margin1__c FROM ExperisPricing__Negotiator_3__c WHERE ExperisPricing__Quote_Line__r.Id = :recordId];
        system.debug('Quote Line eventFields Negotiator__c:#######################  '+negotiator3);   
        
        
        /**Id rId = recordId;
DescribeSObjectResult describeResult = rId.getSObjectType().getDescribe();      
Map<String, Schema.SObjectField> fieldMap = describeResult.fields.getMap();        

String strFields = '';

for(String fieldName : fieldMap.keyset() )
{
if(strFields == null || strFields == '')
{
strFields = fieldName;
}else{
strFields = strFields + ' , ' + fieldName;
}
}


// Build a Dynamic Query String.
String soqlQuery = ' SELECT ' + strFields + ' FROM ' + describeResult.getName() + ' Where ExperisPricing__Quote_Line__c.Id =: rId';

// Need to return a generic list of sObject because we don't necessarily know exactly what the object is.
List<ExperisPricing__Negotiator_3__c> record = Database.query(soqlQuery);
system.debug('Quote Line eventFields Negotiator__c all fields:#######################  '+record);   */
        
        return negotiator3;
    }
    
  @AuraEnabled
    public static Decimal getFreightChargePct(String lookupId,String productFamily)
    {
        Decimal frtChgPolicy = [SELECT ExperisPricing__Freight_Charge_Percent__c FROM ExperisPricing__Freight_Charge_Policy__c WHERE ExperisPricing__Freight_Type__c = :lookupId AND ExperisPricing__Product_Family__c = :productFamily].ExperisPricing__Freight_Charge_Percent__c; 
        return frtChgPolicy;
    }
 
    @AuraEnabled
    public static Map<String, String> getPriceAdjs(String recordId) {
 
 		SBQQ__QuoteLine__c qline = [SELECT SBQQ__ProductName__c,SBQQ__ProductFamily__c,SBQQ__ListPrice__c,ExperisPricing__Product_Density__c FROM SBQQ__QuoteLine__c WHERE Id = :recordId];
        
        String pN = qline.SBQQ__ProductName__c;
        String pF = qline.SBQQ__ProductFamily__c;
        String pD = qline.ExperisPricing__Product_Density__c;
        Decimal basePrice = [SELECT ExperisPricing__Base_Price__c FROM ExperisPricing__Base_Price_Policy__c WHERE ExperisPricing__Product_Name__c = :pN].ExperisPricing__Base_Price__c; 
		
        Decimal fPriceAdh = [SELECT ExperisPricing__Family_Adjustment__c FROM ExperisPricing__Family_Price_Adjustment__c WHERE ExperisPricing__Product_Family__c = :pF].ExperisPricing__Family_Adjustment__c; 
		
        Decimal prdAdh = [SELECT ExperisPricing__Product_Adjustment__c FROM ExperisPricing__Product_Adjustment__c WHERE ExperisPricing__Density__c = :pD].ExperisPricing__Product_Adjustment__c; 
		
        List<SBQQ__QuoteLine__c> qlUpdateList = new List<SBQQ__QuoteLine__c>();
        //List<SBQQ__QuoteLine__c> qlList = [SELECT Id,SBQQ__ProductName__c FROM SBQQ__QuoteLine__c WHERE Id = :recordId];
        Map<String,Integer> analyticsData = getAnalyticData(pN);
        /**for(SBQQ__QuoteLine__c qlRecords :qlList){
            qlRecords.Service_Cost__c = analyticsData.get('ServiceCost');
            qlRecords.Standard_Cost__c = analyticsData.get('StandardCost');
            qlRecords.Volume_Rebate__c = analyticsData.get('VolumeRebate');
            qlUpdateList.add(qlRecords);
        }
        try{
            update qlUpdateList;       
        }catch (DmlException e) {
            System.debug('A DML Exception has occured on Insert:'+e.getMessage());
        }**/
        
        Map<String, String> priceAdjMap = new Map<String, String>(); 
 		priceAdjMap.put('ProductName',pN);
        priceAdjMap.put('BasePrice',String.valueOf(basePrice));
        priceAdjMap.put('FamilyPriceAdjustment',String.valueOf(fPriceAdh));
        priceAdjMap.put('ListPrice',String.valueOf(qline.SBQQ__ListPrice__c));
        priceAdjMap.put('ProductAdjustment',String.valueOf(prdAdh));
		priceAdjMap.put('ServiceCost',String.valueOf(analyticsData.get('ServiceCost')));
        priceAdjMap.put('StandardCost',String.valueOf(analyticsData.get('StandardCost')));
        priceAdjMap.put('VolumeRebate',String.valueOf(analyticsData.get('VolumeRebate')));
        priceAdjMap.put('FreightCost',String.valueOf(analyticsData.get('FreightCost')));
        priceAdjMap.put('DistrubutorRebate',String.valueOf(analyticsData.get('DistrubutorRebate')));
        return priceAdjMap;
    }
    
    public static Map<String,Integer> getAnalyticData(String productName) {   
        Map<String,Integer> revenueMap=new Map<String,Integer>();
        String query  = 'q = load "0Fb5w000000QYvxCAG/0Fc5w000004gXYACA2"; q = filter q by \'ProductName\'  == "'+productName+'"; q = group q by all; q = foreach q generate sum(q.\'VolumeRebate\') as \'VolumeRebate\', sum(q.\'FreightCost\') as \'FreightCost\', sum(q.\'ServiceCost\') as \'ServiceCost\', sum(q.\'DistrubutorRebate\') as \'DistrubutorRebate\', sum(q.\'StandardCost\') as \'StandardCost\';  ';
        ConnectApi.LiteralJson result =  ConnectApi.Wave.executeQuery(query);
        String response = result.json;
        Map<String,Object> responseMap = (Map<String,Object>)JSON.deserializeUntyped(response);
        Map<String,Object> resultMap = (Map<String,Object>)responseMap.get('results');
        //System.debug('ResultList :' +resultMap.get('records'));
        List<Object> records = (List<Object>) resultMap.get('records');
        for (Integer i = 0; i < records.size(); i++) 
    	{
        	Map<String, Object> row = (Map<String, Object>) records[i];   
            revenueMap.put('VolumeRebate',Integer.valueOf(row.get('VolumeRebate')));
            revenueMap.put('FreightCost',Integer.valueOf(row.get('FreightCost')));
            revenueMap.put('ServiceCost',Integer.valueOf(row.get('ServiceCost')));
            revenueMap.put('StandardCost',Integer.valueOf(row.get('StandardCost')));
            revenueMap.put('DistrubutorRebate',Integer.valueOf(row.get('DistrubutorRebate')));
        }
   		system.debug(''+revenueMap);
        return revenueMap;
    }
}