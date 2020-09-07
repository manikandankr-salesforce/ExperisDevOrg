global class GenerateProductPriceList implements Database.Batchable<sObject>, Database.Stateful {
        
    global Integer recordsProcessed = 0;
    private String recordId;
    private String family = '';
    private Decimal mOverride = 0.0;
    private Date startDate;
    private Date endDate;

    public GenerateProductPriceList(String Id){
        recordId = Id;
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        
        List <ExperisPricing__Price_List__c> pbList = [SELECT ExperisPricing__Product_Family__c,ExperisPricing__Manual_Override__c,ExperisPricing__Start_Date__c,ExperisPricing__End_date__c FROM ExperisPricing__Price_List__c WHERE Id = :recordId];
        for(ExperisPricing__Price_List__c priceBook : pbList){
            family = priceBook.Product_Family__c;
            mOverride = priceBook.Manual_Override__c;
            startDate = priceBook.Start_Date__c;
            endDate = priceBook.End_date__c;
        }
    
        System.debug('Values '+mOverride +' '+family + ' ' +startDate + ' '+endDate);
        
        if (family == Null){
            //return Database.getQueryLocator([SELECT Id,Name,ExperisPricing__Density_Family__c,Family FROM Product2 WHERE IsActive = true]);
            return Database.getQueryLocator([SELECT Id,Name,Family FROM Product2 WHERE IsActive = true]);
         }
        else{
            //return Database.getQueryLocator([SELECT Id,Name,ExperisPricing__Density_Family__c,Family FROM Product2 WHERE Family = :family and IsActive = true]);
               return Database.getQueryLocator([SELECT Id,Name,Family FROM Product2 WHERE IsActive = true]);
             }
         }

    global void execute(Database.BatchableContext bc, List<Product2> scope){
        List<ExperisPricing__Price_List_Record__c> priceListRecords = new List<ExperisPricing__Price_List_Record__c>();
        
        //Fetch all Current records in Base Price Policies   
        List<ExperisPricing__Base_Price_Policy__c> basePriceList = [SELECT ExperisPricing__Product_Name__c,ExperisPricing__Base_Price__c FROM ExperisPricing__Base_Price_Policy__c WHERE 
                                             ExperisPricing__Status__c='Approved' AND ExperisPricing__Start_Date__c <= :startDate AND ExperisPricing__End_Date__c >= :endDate];
        Map<String,Decimal> mapBasePricePolicy = new Map<String,Decimal>();
        if (basePriceList.size()>0){
            for (ExperisPricing__Base_Price_Policy__c bPriceRecord :basePriceList)
            {
                mapBasePricePolicy.put(bPriceRecord.ExperisPricing__Product_Name__c, bPriceRecord.ExperisPricing__Base_Price__c);
            }
        }
            
        
       //Fetch all Current records in Family_Price_Adjustment   
        List<ExperisPricing__Family_Price_Adjustment__c> fAdjList = [SELECT ExperisPricing__Product_Family__c,ExperisPricing__Family_Adjustment__c FROM ExperisPricing__Family_Price_Adjustment__c 
                                                              WHERE ExperisPricing__State__c='Approved' AND ExperisPricing__Start_Date__c <= :startDate AND ExperisPricing__End_Date__c >= :endDate];
        Map<String,Decimal> mapFamilyAdj = new Map<String,Decimal>();
        if (fAdjList.size()>0){
            for (ExperisPricing__Family_Price_Adjustment__c fAdj : fAdjList)
            {
                mapFamilyAdj.put(fAdj.ExperisPricing__Product_Family__c, fAdj.ExperisPricing__Family_Adjustment__c);
            }
        }
        //Fetch all Current records in Product_Adjustment   
        List<ExperisPricing__Product_Adjustment__c> pAdjList = [SELECT ExperisPricing__Density__c,ExperisPricing__Product_Adjustment__c FROM ExperisPricing__Product_Adjustment__c  
                                                             WHERE ExperisPricing__State__c='Approved' AND ExperisPricing__Start_Date__c <= :startDate AND ExperisPricing__End_Date__c >= :endDate];
        Map<String,Decimal> mapProductAdj = new Map<String,Decimal>();
        if (pAdjList.size()>0){
            for (ExperisPricing__Product_Adjustment__c pAdj :pAdjList)
            {
                mapProductAdj.put(pAdj.ExperisPricing__Density__c, pAdj.ExperisPricing__Product_Adjustment__c);
            }
        }
        if (scope.size()>0){
            for(Product2 product : scope){
                ExperisPricing__Price_List_Record__c pbEntry = new ExperisPricing__Price_List_Record__c();
                pbEntry.ExperisPricing__Product2Id__c = product.Id;
                pbEntry.ExperisPricing__Price_List__c = recordId;
               // pbEntry.ExperisPricing__Density__c = product.ExperisPricing__Density_Family__c;
                 pbEntry.ExperisPricing__Density__c = 'N/A';
                pbEntry.ExperisPricing__Product_Family_Name__c = product.Family;
                String productName = product.Name;
                pbEntry.Name = productName;
                String productFamily = product.Family;
                System.debug('Product family:' + productFamily + 'productName:' +productName);
                
                Decimal basePrice = 0.0;
                Decimal bPriceValue = mapBasePricePolicy.get(productName);
                System.debug('Base price ' +bPriceValue);
                if (bPriceValue != Null){
                    basePrice = bPriceValue;
                }
                System.debug('Base Price' + basePrice);
                pbEntry.ExperisPricing__Base_Price__c = basePrice;
                
                pbEntry.ExperisPricing__Base_Price__c = basePrice;
                
                Decimal fAdjValue = mapFamilyAdj.get(productFamily);
                System.debug('Family Adj ' +fAdjValue);
                Decimal familyAdjAmt = 0.0;
                if (fAdjValue != Null){
                    familyAdjAmt =basePrice * fAdjValue * 0.01;
                }
                pbEntry.ExperisPricing__Family_Adj_Amt__c = familyAdjAmt;
                
                //Decimal pAdjValue = mapProductAdj.get(product.ExperisPricing__Density_Family__c);
                Decimal pAdjValue = 0;//;mapProductAdj.get(product.ExperisPricing__Density_Family__c);
                System.debug('Product Adj ' +pAdjValue);
                Decimal productAdjAmt = 0.0;
                if (pAdjValue != Null){
                    productAdjAmt =  basePrice  * pAdjValue * 0.01;
                }
                pbEntry.ExperisPricing__Product_Adj_Amt__c = productAdjAmt;
                System.debug('Values '+fAdjValue +' '+pAdjValue+ ' '+startDate +' '+endDate);
                
                if (mOverride == NULL)
                {
                    pbEntry.ExperisPricing__Manual_Override_Amt__c = 0;
                    Decimal listPrice = basePrice + familyAdjAmt + productAdjAmt;
                    pbEntry.ExperisPricing__UnitPrice__c = listPrice;
                }
                else
                {   
                    Decimal mOverrideAmt = mOverride * basePrice * 0.01;
                    pbEntry.ExperisPricing__Manual_Override_Amt__c = mOverrideAmt;
                    Decimal listPrice = basePrice + mOverrideAmt; 
                    pbEntry.ExperisPricing__UnitPrice__c = listPrice;
                }
                pbEntry.ExperisPricing__Start_Date__c = startDate;
                pbEntry.ExperisPricing__End_date__c = endDate;
                pbEntry.ExperisPricing__Status__c = 'Generated';
                //pbEntry.IsActive=true;
                //pbEntry.UseStandardPrice=false;
                //pbEntry = setProductRevenue(pbEntry,productName);
                /*if (pbEntry.ExperisPricing__Quantity__c != NULL){
            pbEntry.ExperisPricing__Target_Revenue__c = pbEntry.UnitPrice * pbEntry.ExperisPricing__Quantity__c;
                }*/
                priceListRecords.add(pbEntry);
                recordsProcessed = recordsProcessed + 1;
            } 
        }  
        try {
            insert priceListRecords;
        } catch (DmlException e) {
            System.debug('A DML Exception has occured on Insert:'+e.getMessage());
        }
        
    }
    
    global void finish(Database.BatchableContext bc){
        System.debug(recordsProcessed + ' records processed. Insert!');
        List<ExperisPricing__Price_List__c> priceList = [SELECT Id FROM ExperisPricing__Price_List__c WHERE Id = :recordId];
        for (ExperisPricing__Price_List__c pListRecord : priceList){
            pListRecord.ExperisPricing__Generated_Status__c = 'Generated';
            update priceList;
        }
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors, 
        JobItemsProcessed,
        TotalJobItems, CreatedBy.Email
        FROM AsyncApexJob
        WHERE Id = :bc.getJobId()];
        System.debug(bc.getJobId() + ' Job Id. Insert!');
    // call some utility to send email
    //EmailUtils.sendMessage(job, recordsProcessed);
    }
                                         
}