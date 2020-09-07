public with sharing class PriceBookGeneration {
    private Id pricebookId;
    //private static final String Query = 'SELECT Id,Name,Density_Family__c,Family FROM Product2 WHERE IsActive = true';
    private static final String Query = 'SELECT Id,Name,Family FROM Product2 WHERE IsActive = true';
    //public static sbaa__Approval__c[] approvals {get; set;} 

    public PriceBookGeneration(ApexPages.StandardController stdController) {
        pricebookId = stdController.getId();
    }
    
    @AuraEnabled
    public static List<PricebookEntry> getInitResult(String recordId)
    {
        List<PricebookEntry> pbEntryList = [SELECT Product2Id,Name,Product_Family_Name__c,Density__c,Base_Price__c,Family_Adj_Amt__c,Product_Adj_Amt__c,Manual_Override_Amt__c,UnitPrice,Past_Revenue__c,Quantity__c,Start_Date__c,End_date__c,Status__c FROM PriceBookEntry WHERE  Pricebook2Id = :recordId];
        return pbEntryList;
    }
    
    @AuraEnabled
    public static List<PricebookEntry> getProductRecords(String recordId){
        String family = '';
        Decimal mOverride = 0.0;
        Date startDate;
        Date endDate;
        List<PricebookEntry> generatedRecords =  new List<PricebookEntry>();
        List<PricebookEntry> priceListRecords = new List<PricebookEntry>();

        //Delete all Current records in PricebookEntry
        PricebookEntry[] deletePBEntryList = [SELECT Id FROM PriceBookEntry WHERE  Pricebook2Id = :recordId];
        try {
            delete deletePBEntryList;

        } catch (DmlException e) {
            System.debug('A DML Exception has occured on Delete:'+e.getMessage());
        }
   
        List <Pricebook2> pbList = [SELECT Product_Family__c,Manual_Override__c,Start_Date__c,End_date__c FROM Pricebook2 WHERE Id = :recordId];
            for(Pricebook2 priceBook : pbList){
                family = priceBook.Product_Family__c;
                mOverride = priceBook.Manual_Override__c;
                startDate = priceBook.Start_Date__c;
                endDate = priceBook.End_date__c;
        }
        
        System.debug('Values '+mOverride +' '+family + ' ' +startDate + ' '+endDate);

        //Fetch all Current records in Family_Price_Adjustment   
        List<Family_Price_Adjustment__c> fAdjList = [SELECT Product_Family__c,Family_Adjustment__c FROM Family_Price_Adjustment__c 
                                                              WHERE State__c='Approved' AND Start_Date__c <= :startDate AND End_Date__c >= :endDate];
        Map<String,Decimal> mapFamilyAdj = new Map<String,Decimal>();
        if (fAdjList.size()>0){
            for (Family_Price_Adjustment__c fAdj : fAdjList)
            {
                mapFamilyAdj.put(fAdj.Product_Family__c, fAdj.Family_Adjustment__c);
            }
        }
        //Fetch all Current records in Product_Adjustment   
        List<Product_Adjustment__c> pAdjList = [SELECT Density__c,Product_Adjustment__c FROM Product_Adjustment__c  
                                                             WHERE State__c='Approved' AND Start_Date__c <= :startDate AND End_Date__c >= :endDate];
        Map<String,Decimal> mapProductAdj = new Map<String,Decimal>();
        if (pAdjList.size()>0){
            for (Product_Adjustment__c pAdj :pAdjList)
            {
                mapProductAdj.put(pAdj.Density__c, pAdj.Product_Adjustment__c);
            }
        }
        
        List<Product2> productRecords = Database.query(getProductQuery(family));
            if (productRecords.size()>0){
                for(Product2 product : productRecords){
                    PricebookEntry pbEntry = new PricebookEntry();
                    pbEntry.Product2Id = product.Id;
                    pbEntry.Pricebook2Id = recordId;
                    //pbEntry.Density__c = product.Density_Family__c;
                      pbEntry.Density__c = 'N/A';
                    pbEntry.Product_Family_Name__c = product.Family;
                    String productName = product.Name;
                    String productFamily = product.Family;
                    System.debug('Product family:' + productFamily + 'productName:' +productName);

                    Decimal basePrice = 0.0;
                    List <Base_Price_Policy__c> basePriceList = [SELECT Base_Price__c FROM Base_Price_Policy__c WHERE 
                    Product_Family__c = :productFamily  AND Product_Name__c = :productName AND Status__c='Approved' AND Start_Date__c <= :startDate AND End_Date__c >= :endDate];
                    for(Base_Price_Policy__c bPriceRecord : basePriceList){
                        basePrice = bPriceRecord.Base_Price__c;
                    }
                    System.debug('Base Price' + basePrice);
                    pbEntry.Base_Price__c = basePrice;
                    
                    Decimal fAdjValue = mapFamilyAdj.get(productFamily);
                    System.debug('Family Adj ' +fAdjValue);
                    Decimal familyAdjAmt = 0.0;
                    if (fAdjValue != Null){
                        familyAdjAmt =basePrice * fAdjValue * 0.01;
                    }
                    pbEntry.Family_Adj_Amt__c = familyAdjAmt;
                    
                    //Decimal pAdjValue = mapProductAdj.get(product.Density_Family__c);
                     Decimal pAdjValue = 0;//mapProductAdj.get(product.Density_Family__c);
                    System.debug('Product Adj ' +pAdjValue);
                    Decimal productAdjAmt = 0.0;
                    if (pAdjValue != Null){
                        productAdjAmt =  basePrice  * pAdjValue * 0.01;
                    }
                    pbEntry.Product_Adj_Amt__c = productAdjAmt;
                    System.debug('Values '+fAdjValue +' '+pAdjValue+ ' '+startDate +' '+endDate);
                    
                    if (mOverride == NULL)
                    {
                        pbEntry.Manual_Override_Amt__c = 0;
                        Decimal listPrice = basePrice + familyAdjAmt + productAdjAmt;
                        pbEntry.UnitPrice = listPrice;
                    }
                    else
                    {   
                        Decimal mOverrideAmt = mOverride * basePrice * 0.01;
                        pbEntry.Manual_Override_Amt__c = mOverrideAmt;
                        Decimal listPrice = basePrice + mOverrideAmt; 
                        pbEntry.UnitPrice = listPrice;
                    }
                    pbEntry.Start_Date__c = startDate;
                    pbEntry.End_date__c = endDate;
                    pbEntry.Status__c = 'Generated';
                    pbEntry.IsActive=true;
                    pbEntry.UseStandardPrice=false;
                    pbEntry = setProductRevenue(pbEntry,productName);
                    if (pbEntry.Quantity__c != NULL){
                        pbEntry.Target_Revenue__c = pbEntry.UnitPrice * pbEntry.Quantity__c;
                    }
                    priceListRecords.add(pbEntry);
                }
                    try {
                        insert priceListRecords;
                    } catch (DmlException e) {
                        System.debug('A DML Exception has occured on Insert:'+e.getMessage());
                    }
                System.debug('Generated Records'+generatedRecords);
            }
        generatedRecords = [SELECT Product2Id,Name,Product_Family_Name__c,Density__c,Base_Price__c,Family_Adj_Amt__c,Product_Adj_Amt__c,Manual_Override_Amt__c,UnitPrice,Past_Revenue__c,Quantity__c,Start_Date__c,End_date__c,Status__c FROM PriceBookEntry WHERE  Pricebook2Id = :recordId];
        System.debug('Generated Records'+generatedRecords);
        return generatedRecords;
    }
    
    private static PricebookEntry setProductRevenue(PricebookEntry pbEntry,String productName){
        List <Product_Revenue__c> prList = [SELECT Past_Revenue__c,Quantity__c FROM Product_Revenue__c WHERE Name = :productName];
        if (prList.size()>0){
            for(Product_Revenue__c prRecord : prList){
                pbEntry.Past_Revenue__c = prRecord.Past_Revenue__c;
                pbEntry.Quantity__c = prRecord.Quantity__c;
            }
            
        }
        return pbEntry;
    }

    //Based on the product family value,Query String is returned
    private static String getProductQuery(String family){
        String queryString = QUERY;
        if (family == Null){
             System.debug('Query: ' +queryString);
        }
        else{
            queryString = QUERY + ' AND Family = :family';
            System.debug('Query: ' +queryString);
        }
        return queryString;
    }

 /*   @AuraEnabled
    public static void setPBEntryRecords(String pbrecords,String recordId){
        List<Product2> wrapperList = (List<Product2>)System.JSON.deserialize(pbrecords, List<Product2>.class);
        for(Product2 product : wrapperList){
            PricebookEntry pbEntry = new PricebookEntry();
            pbEntry.Product2Id = product.Id;
            pbEntry.Pricebook2Id = recordId;
            pbEntry.UnitPrice = 7000;
            pbEntry.IsActive=true;
            pbEntry.UseStandardPrice=false;
             try {
                 insert pbEntry;
             } catch (DmlException e) {
                 System.debug('A DML Exception has occured on Insert:'+e.getMessage());
             }
        }
    }*/

    @AuraEnabled
    public static void onSubmit(String recordId) {
        if (recordId != null) {
            //sbaa.ApprovalAPI.submit(recordId, sbaa__Approval__c.Price_Book__c);
        }
    }
    
    public void onPreview() {
        if (pricebookId != null) {
            //approvals = sbaa.ApprovalAPI.preview(pricebookId, sbaa__Approval__c.Price_Book__c);
        }
    }
}