public with sharing class MPUContractPriceController{
	public MPUContractPriceController(){
	}

	private static final String GET_MPU_CONTRACT_BY_ID = 'SELECT Name,Customer_Group__c,Customer_Classification__c,Product__r.ProductCode, Account__r.Name,Division__c,Effective_From__c,Effective_To__c,Auto_Approval__c,Product_Family__c,Country__r.Name,Search_Date__c  FROM Mass_Price_Update__c WHERE Id = :recordId';
	private static final String CONTRACT_PRICE_QUERY = 'SELECT Id,SBQQ__Price__c,SBQQ__OriginalQuoteLine__c, ' + 
														'SBQQ__NonDiscountable__c,SBQQ__Operator__c, SBQQ__FilterValue__c, SBQQ__FilterField__c, ' + 
														'SBQQ__OriginalQuoteLine__r.Id,SBQQ__OriginalQuoteLine__r.SBQQ__Quote__r.Name,SBQQ__OriginalQuoteLine__r.SBQQ__Quote__r.ApprovalStatus__c,SBQQ__OriginalQuoteLine__r.SBQQ__ListPrice__c, ' + 
														'SBQQ__OriginalQuoteLine__r.SBQQ__NetPrice__c,SBQQ__OriginalQuoteLine__r.New_Net_Price__c,SBQQ__OriginalQuoteLine__r.SBQQ__Discount__c, ' + 
														'SBQQ__OriginalQuoteLine__r.New_Discount__c,New_CP_Discount_Schedule__c, ' + 
														'SBQQ__ExpirationDate__c,SBQQ__EffectiveDate__c,SBQQ__Discount__c,SBQQ__DiscountSchedule__r.Name, ' + 
														'SBQQ__Description__c, SBQQ__Contract__c,SBQQ__Account__r.Name,SBQQ__Product__r.ProductCode,SBQQ__Product__r.Name,Name,Quote_Status__c,Quote_Number__c,New_CP_Price__c,New_CP_Discount__c ' + 
														'FROM SBQQ__ContractedPrice__c Where ';
	private static final String GetContractChangeDetailQuery = 'Select Name,Product_Code__c,Quote_Line_Id__c,Quote_Status__c,Quote_Number__c,List_Price__c,Net_Price__c,New_Net_Price__c,Discount__c,New_Discount__c,To_Date__c,Source_Quote__c,Contracted_Price__c,Contracted_Discount__c,Contracted_Discount_Schedule__c,Contract_Price_Id__c,New_CP_Discount__c,New_CP_Discount_Schedule__c,New_CP_Price__c,From_Date__c,Product_Name__c   from Quote_Line_Change_Detail__c';
	private static final String GetFilterCriteria = 'Select specificFilter__c,discountSchedule__c,rule2DiscountSchedule__c,rule3DiscountSchedule__c,selectedSign__c,discountPercent__c,selectedPriceColumn__c,specificRule2Filter__c,rule2DiscountPercent__c,rule2SelectedPriceColumn__c,rule2SelectedSign__c,rule1Map__C,rule2Map__c,rule3Map__c,rule3SelectedSign__c,rule3DiscountPercent__c,rule3SelectedPriceColumn__c,specificRule3Filter__c from MPU_Filter_Criteria__c';
	private static final String lineContractQuery = 'SELECT Id,SBQQ__Price__c,SBQQ__OriginalQuoteLine__c, SBQQ__NonDiscountable__c, ' + 
													'SBQQ__OriginalQuoteLine__r.Id,SBQQ__OriginalQuoteLine__r.SBQQ__Quote__r.Name,SBQQ__OriginalQuoteLine__r.SBQQ__ListPrice__c, ' + 
													'SBQQ__OriginalQuoteLine__r.SBQQ__NetPrice__c,SBQQ__OriginalQuoteLine__r.New_Net_Price__c,SBQQ__OriginalQuoteLine__r.SBQQ__Discount__c,Quote_Status__c,Quote_Number__c, ' + 
													'SBQQ__OriginalQuoteLine__r.New_Discount__c,SBQQ__OriginalQuoteLine__r.SBQQ__Quote__r.ApprovalStatus__c, ' + 
													'SBQQ__Operator__c, SBQQ__FilterValue__c, SBQQ__FilterField__c, ' + 
													'SBQQ__ExpirationDate__c,SBQQ__EffectiveDate__c,SBQQ__Discount__c,New_CP_Discount__c, ' + 
													'SBQQ__DiscountSchedule__c, SBQQ__Description__c,SBQQ__Contract__c,SBQQ__Account__r.Name, ' + 
													'SBQQ__Product__r.ProductCode,Name,SBQQ__Product__r.Name,New_CP_Discount_Schedule__c,New_CP_Price__c  ' + 
													' FROM SBQQ__ContractedPrice__c ';
	private static final String discScheduleQuery = 'SELECT Id,Name FROM SBQQ__DiscountSchedule__c order by Name asc ';
	@AuraEnabled(Cacheable = true)
	public static List<SBQQ__DiscountSchedule__c> getDiscountScheduleList(){
		List<SBQQ__DiscountSchedule__c> accList = Database.query(discScheduleQuery);
		return accList;
	}

	@AuraEnabled(Cacheable = true)
	public static List<MPUContractPriceWrapper> getContractRecordsByRecordId(String recordId, String strSearch){
		List<Mass_Price_Update__c> records = Database.query(GET_MPU_CONTRACT_BY_ID);
		Mass_Price_Update__c mpu = records.get(0);
		String productCode = mpu.Product__r.ProductCode;
		String accountName = mpu.Account__r.Name;
		String divisionName = mpu.ExperisPricing__Division__c;
		String salesRegionName = mpu.Country__r.Name;
		String productFamilyName = mpu.ExperisPricing__Product_Family__c;
		Date effectiveDate = mpu.Effective_From__c;
		Date effectiveDateTo = mpu.Effective_To__c;
		Date searchDate = mpu.Search_Date__c;
		String customerGroupName = mpu.Customer_Group__c;
		String customerClassName = mpu.Customer_Classification__c;
		System.debug('accountName ###############' + accountName);
		System.debug('productCode ###############  ' + productCode);
		System.debug('divisionName ############### ' + divisionName);
		System.debug('productFamilyName ############### ' + productFamilyName);
		System.debug('customerGroupName ############### ' + customerGroupName);
		System.debug(' Country ############### ' + salesRegionName);
		System.debug('customerClassName############### ' + customerClassName);
		//get contract price records for the product code(MPU) ,account name (MPU),search creteria on the datatable
		return getContractRecords(productCode, accountName, divisionName, salesRegionName, productFamilyName, effectiveDate, strSearch, effectiveDateTo, searchDate, customerGroupName, customerClassName);
	}

	@AuraEnabled(Cacheable = true)
	public static List<MPUContractPriceWrapper> getContractRecordsByRecordIdNew(String recordId, String strSearch){
		system.debug('Entering getContractRecordsByRecordIdNew' + recordId);
		List<Mass_Price_Update__c> records = Database.query(GET_MPU_CONTRACT_BY_ID);
		Mass_Price_Update__c mpu = records.get(0);
		String productCode = mpu.Product__r.ProductCode;
		String accountName = mpu.Account__r.Name;
		String divisionName = mpu.ExperisPricing__Division__c;
		String salesRegionName = mpu.Country__r.Name;
		String productFamilyName = mpu.ExperisPricing__Product_Family__c;
		Date effectiveDate = mpu.Effective_From__c;
		Date effectiveDateTo = mpu.Effective_To__c;
		Date searchDate = effectiveDate;
		String customerGroupName = mpu.Customer_Group__c;
		String customerClassName = mpu.Customer_Classification__c;
		System.debug('accountName ###############' + accountName);
		System.debug('productCode ###############  ' + productCode);
		System.debug('divisionName ############### ' + divisionName);
		System.debug('productFamilyName ############### ' + productFamilyName);
		System.debug('customerGroupName ############### ' + customerGroupName);
		System.debug(' Country ############### ' + salesRegionName);
		System.debug('customerClassName############### ' + customerClassName);
		//get contract price records for the product code(MPU) ,account name (MPU),search creteria on the datatable
		return getContractRecords(productCode, accountName, divisionName, salesRegionName, productFamilyName, effectiveDate, strSearch, effectiveDateTo, searchDate, customerGroupName, customerClassName);
	}

	private static List<MPUContractPriceWrapper> getContractRecords(String productCode, String accountName, String divisionName, String salesRegionName, String productFamilyName, Date effectiveDate, String strSearch, Date effectiveDateTo, Date searchDate, String customerGroupName, String customerClassName){

		String queryString = CONTRACT_PRICE_QUERY;
		String prodFamily = 'Product Family';
		String optr = 'equals';

		if (String.isNotBlank(productCode) && productCode != null){
			system.debug('Inside productCode' + productCode);
			queryString += ' SBQQ__Product__r.ProductCode  = :productCode ';
		}

		if (String.isNotBlank(accountName) && String.isNotBlank(productCode)){
			queryString += ' and  SBQQ__Account__r.Name = :accountName ';
		} else if (String.isNotBlank(accountName) && accountName != null){
			system.debug('Inside accountName' + accountName);
			queryString += '  SBQQ__Account__r.Name = :accountName ';
		}

		if (String.isNotBlank(productFamilyName) && (String.isNotBlank(productCode) || String.isNotBlank(accountName))){
			queryString += ' and SBQQ__FilterField__c = :prodFamily ';
			queryString += ' and SBQQ__Operator__c = :optr ';
			queryString += ' and SBQQ__FilterValue__c = :productFamilyName ';
		} else if (String.isNotBlank(productFamilyName) && productFamilyName != null){
			queryString += '  SBQQ__FilterField__c = :prodFamily ';
			queryString += ' and SBQQ__Operator__c = :optr ';
			queryString += ' and SBQQ__FilterValue__c = :productFamilyName ';
		}

		if (String.isNotBlank(divisionName) && (String.isNotBlank(productFamilyName) || String.isNotBlank(productCode) || String.isNotBlank(accountName))){
			system.debug('Inside divisionName' + divisionName);
			queryString += ' and SBQQ__Product__r.Division__c = :divisionName ';
		} else if (String.isNotBlank(divisionName) && divisionName != null){
			system.debug('Inside divisionName' + divisionName);
			queryString += '  SBQQ__Product__r.Division__c = :divisionName ';
		}

		if (searchDate != null && (String.isNotBlank(accountName) || String.isNotBlank(productCode) || String.isNotBlank(productFamilyName) || String.isNotBlank(divisionName))){
			queryString += ' and SBQQ__EffectiveDate__c >= :searchDate';

		} else if (searchDate != null){
			queryString += '  SBQQ__EffectiveDate__c >= :searchDate';

		} else if (searchDate == null && (String.isNotBlank(accountName) || String.isNotBlank(productCode) || String.isNotBlank(productFamilyName) || String.isNotBlank(divisionName))){
			DateTime dt = System.now();
			Date myDate = date.newinstance(dt.year(), dt.month(), dt.day());
			searchDate = myDate;
			system.debug('myDate------------' + myDate);
			queryString += ' and  SBQQ__EffectiveDate__c >= :searchDate';

		} else if (searchDate == null){
			DateTime dt = System.now();
			Date myDate = date.newinstance(dt.year(), dt.month(), dt.day());
			searchDate = myDate;
			system.debug('myDate-in null-----------' + myDate);
			queryString += ' and  SBQQ__EffectiveDate__c >= :searchDate';
		}
		if (customerGroupName != null && (String.isNotBlank(accountName) || String.isNotBlank(productCode) || String.isNotBlank(productFamilyName) || String.isNotBlank(divisionName) || searchDate != null)){
			queryString += ' and SBQQ__Account__r.Account_Channel__c = :customerGroupName';

		} else if (customerGroupName != null){
			queryString += ' SBQQ__Account__r.Account_Channel__c = :customerGroupName';
		}
		if (customerClassName != null && (String.isNotBlank(accountName) || String.isNotBlank(productCode) || String.isNotBlank(productFamilyName) || String.isNotBlank(divisionName) || searchDate != null || customerGroupName != null)){
			queryString += ' and SBQQ__Account__r.Customer_Classification__c = :customerClassName';

		} else if (customerClassName != null){
			queryString += ' SBQQ__Account__r.Customer_Classification__c = :customerClassName';
		}
		if (String.isNotBlank(strSearch)){
			strSearch = '%' + strSearch + '%';
			queryString += ' and  (SBQQ__Account__r.Name like :strSearch OR Name like :strSearch OR SBQQ__Product__r.ProductCode like :strSearch) ';
		}

		queryString += ' ORDER BY Name DESC NULLS LAST LIMIT 20';
		System.debug('Query String ###############' + queryString);
		System.debug('productFamilyName ############### ' + productFamilyName);

		//it gets all the contract price records based on all search creteria
		List<SBQQ__ContractedPrice__c> result = Database.query(queryString);
		// The contract price records will be made available in the wrapper class
		if (result.size() == 0 && String.isNotBlank(productFamilyName)){
			String familyQuery = CONTRACT_PRICE_QUERY;
			if (String.isNotBlank(productCode) && productCode != null){
				system.debug('Inside productCode' + productCode);
				familyQuery += ' SBQQ__Product__r.ProductCode  = :productCode ';
			}

			if (String.isNotBlank(accountName) && String.isNotBlank(productCode)){
				familyQuery += ' and  SBQQ__Account__r.Name = :accountName ';
			} else if (String.isNotBlank(accountName) && accountName != null){
				system.debug('Inside accountName' + accountName);
				familyQuery += '  SBQQ__Account__r.Name = :accountName ';
			}

			if (String.isNotBlank(productFamilyName) && (String.isNotBlank(productCode) || String.isNotBlank(accountName))){
				familyQuery += ' and SBQQ__Product__r.Family = :productFamilyName ';
			} else if (String.isNotBlank(productFamilyName) && productFamilyName != null){
				familyQuery += '  SBQQ__Product__r.Family = :productFamilyName ';

			}

			if (String.isNotBlank(divisionName) && (String.isNotBlank(productFamilyName) || String.isNotBlank(productCode) || String.isNotBlank(accountName))){
				system.debug('Inside divisionName' + divisionName);
				familyQuery += ' and SBQQ__Product__r.Division__c = :divisionName ';
			} else if (String.isNotBlank(divisionName) && divisionName != null){
				system.debug('Inside divisionName' + divisionName);
				familyQuery += '  SBQQ__Product__r.Division__c = :divisionName ';
			}

			if (searchDate != null && (String.isNotBlank(accountName) || String.isNotBlank(productCode) || String.isNotBlank(productFamilyName) || String.isNotBlank(divisionName))){
				familyQuery += ' and SBQQ__EffectiveDate__c >= :searchDate';

			} else if (searchDate != null){
				familyQuery += '  SBQQ__EffectiveDate__c >= :searchDate';

			} else if (searchDate == null && (String.isNotBlank(accountName) || String.isNotBlank(productCode) || String.isNotBlank(productFamilyName) || String.isNotBlank(divisionName))){
				DateTime dt = System.now();
				Date myDate = date.newinstance(dt.year(), dt.month(), dt.day());
				searchDate = myDate;
				system.debug('myDate------------' + myDate);
				familyQuery += ' and  SBQQ__EffectiveDate__c >= :searchDate';

			} else if (searchDate == null){
				DateTime dt = System.now();
				Date myDate = date.newinstance(dt.year(), dt.month(), dt.day());
				searchDate = myDate;
				system.debug('myDate-in null-----------' + myDate);
				familyQuery += ' and  SBQQ__EffectiveDate__c >= :searchDate';
			}
			if (customerGroupName != null && (String.isNotBlank(accountName) || String.isNotBlank(productCode) || String.isNotBlank(productFamilyName) || String.isNotBlank(divisionName) || searchDate != null)){
				familyQuery += ' and SBQQ__Account__r.Account_Channel__c = :customerGroupName';

			} else if (customerGroupName != null){
				familyQuery += ' SBQQ__Account__r.Account_Channel__c = :customerGroupName';
			}
			if (customerClassName != null && (String.isNotBlank(accountName) || String.isNotBlank(productCode) || String.isNotBlank(productFamilyName) || String.isNotBlank(divisionName) || searchDate != null || customerGroupName != null)){
				familyQuery += ' and SBQQ__Account__r.Customer_Classification__c = :customerClassName';

			} else if (customerClassName != null){
				familyQuery += ' SBQQ__Account__r.Customer_Classification__c = :customerClassName';
			}
			System.debug('Result is zero familyQuery' + familyQuery);

			if (String.isNotBlank(strSearch)){
				strSearch = '%' + strSearch + '%';
				familyQuery += ' and  (SBQQ__Account__r.Name like :strSearch OR Name like :strSearch OR SBQQ__Product__r.ProductCode like :strSearch) ';
			}

			familyQuery += ' ORDER BY Name DESC NULLS LAST LIMIT 20';
			System.debug('After familyQuery' + familyQuery);

			result = Database.query(familyQuery);
			System.debug('result' + result);


		}
		return createContractPricepdateList(result);
	}

	// The Quote line items will be made available in the wrapper class
	public static List<MPUContractPriceWrapper> createContractPricepdateList(List<SBQQ__ContractedPrice__c> result){
		List<MPUContractPriceWrapper> productUpdateList = new List<MPUContractPriceWrapper>();
		for (SBQQ__ContractedPrice__c quoteLine : result){
			productUpdateList.add(new MPUContractPriceWrapper(quoteLine));
		}
		System.debug('productUpdateList ###############' + productUpdateList);

		return productUpdateList;
	}

	@AuraEnabled(Cacheable = true)
	public static List<UpdatedMPUContractPriceWrapper> getContractUpdateList(String recordId){
		String QLChangeDetailQuery = GetContractChangeDetailQuery;
		QLChangeDetailQuery = QLChangeDetailQuery + ' Where Mass_Price_Update__c =\'' + recordId + '\'';
		List<Quote_Line_Change_Detail__c> QLChangeDetailRec = Database.query(QLChangeDetailQuery);

		return createContractProdChangeDetail(QLChangeDetailRec);
	}

	@AuraEnabled
	public static List<UpdatedMPUContractPriceWrapper> createContractProdChangeDetail(List<Quote_Line_Change_Detail__c> QLChnageList){
		List<UpdatedMPUContractPriceWrapper> productUpdateList = new List<UpdatedMPUContractPriceWrapper>();
		for (Quote_Line_Change_Detail__c quoteLine : QLChnageList){
			productUpdateList.add(new UpdatedMPUContractPriceWrapper(quoteLine));
		}
		return productUpdateList;
	}

	@AuraEnabled
	public static MPU_Filter_Criteria__c getMPUFilterContractCriteria(String recordId){
		String filterQuery = GetFilterCriteria;
		MPU_Filter_Criteria__c mpufilterRec;
		filterQuery = filterQuery + ' Where Mass_Price_Update__c =\'' + recordId + '\'';
		List<MPU_Filter_Criteria__c> records = Database.query(filterQuery);
		if (records.isEmpty()){
			system.debug('Entering Empty');
			return new MPU_Filter_Criteria__c();
		} else{
			mpufilterRec = records.get(0);
			return mpufilterRec;
		}
	}

	public static void createMPUContractFilterCriteria(Double dscPercent, String signValue, String priceColumn, String recordId, String specificFilter, String ruleName, List<Map<String, String>> ruleMap, String dscSchedule){
		String filterQuery = GetFilterCriteria;
		filterQuery = filterQuery + ' Where Mass_Price_Update__c =\'' + recordId + '\'';
		List<MPU_Filter_Criteria__c> mpuFilterRecords = Database.query(filterQuery);
		MPU_Filter_Criteria__c filterCriteriaRec;
		Boolean recordExist = false;
		System.debug('Disc schedule ' + dscSchedule);
		SBQQ__DiscountSchedule__c sc;
		if (dscSchedule != null){
			sc = [Select Name
			      from SBQQ__DiscountSchedule__c 
			      where Id = :dscSchedule];
		}
		if (mpuFilterRecords.size() > 0){
			system.debug('Entering existing MPU Filter Criteria');
			filterCriteriaRec = mpuFilterRecords.get(0);
			system.debug('filterCriteriaRec -------------------' + filterCriteriaRec);
			recordExist = true;
		} else{
			system.debug('Entering else of existing MPU Filter Criteria');
			filterCriteriaRec = new MPU_Filter_Criteria__c();
		}

		if (ruleName == 'Rule1'){
			filterCriteriaRec.discountPercent__c = dscPercent;
			filterCriteriaRec.selectedSign__c = signValue;
			filterCriteriaRec.selectedPriceColumn__c = priceColumn;
			filterCriteriaRec.specificFilter__c = specificFilter;
			if (dscSchedule != null){
				system.debug('DiscountSchedule name in filter ------------' + sc.Name);
				filterCriteriaRec.discountSchedule__c = sc.Name;
			} else{
				filterCriteriaRec.discountSchedule__c = null;
			}
			filterCriteriaRec.Mass_Price_Update__c = recordId;
			System.debug('ruleMap -------------' + ruleMap);
			String ruleMapData;
			for (Map<String, String> listRec : ruleMap){
				for (String mapRec : listRec.keySet()){
					if (ruleMap.indexOf(listRec) == 0){
						ruleMapData = mapRec + ':' + listRec.get(mapRec);
					} else{
						ruleMapData = ruleMapData + ',' + mapRec + ':' + listRec.get(mapRec);
					}
				}
			}
			filterCriteriaRec.rule1Map__c = ruleMapData;
		} else if (ruleName == 'Rule2'){
			filterCriteriaRec.rule2DiscountPercent__c = dscPercent;
			filterCriteriaRec.rule2SelectedSign__c = signValue;
			filterCriteriaRec.rule2SelectedPriceColumn__c = priceColumn;

			if (dscSchedule != null){
				system.debug('DiscountSchedule name in filter ------------' + sc.Name);
				filterCriteriaRec.discountSchedule__c = sc.Name;
			} else{
				filterCriteriaRec.discountSchedule__c = null;
			}
			filterCriteriaRec.specificRule2Filter__c = specificFilter;
			filterCriteriaRec.Mass_Price_Update__c = recordId;
			System.debug('ruleMap ---Rule2----------' + ruleMap);
			String rule2MapData;
			for (Map<String, String> listRec : ruleMap){
				for (String mapRec : listRec.keySet()){
					if (ruleMap.indexOf(listRec) == 0){
						rule2MapData = mapRec + ':' + listRec.get(mapRec);
					} else{
						rule2MapData = rule2MapData + ',' + mapRec + ':' + listRec.get(mapRec);
					}
				}
			}
			filterCriteriaRec.rule2Map__c = rule2MapData;
		} else if (ruleName == 'Rule3'){
			filterCriteriaRec.rule3DiscountPercent__c = dscPercent;
			filterCriteriaRec.rule3SelectedSign__c = signValue;
			filterCriteriaRec.rule3SelectedPriceColumn__c = priceColumn;
			if (dscSchedule != null){
				system.debug('DiscountSchedule name in filter ------------' + sc.Name);
				filterCriteriaRec.discountSchedule__c = sc.Name;
			} else{
				filterCriteriaRec.discountSchedule__c = null;
			}
			filterCriteriaRec.specificRule3Filter__c = specificFilter;
			filterCriteriaRec.Mass_Price_Update__c = recordId;
			System.debug('ruleMap -------Rule3------' + ruleMap);

			String rule3MapData;
			for (Map<String, String> listRec : ruleMap){
				for (String mapRec : listRec.keySet()){
					if (ruleMap.indexOf(listRec) == 0){
						rule3MapData = mapRec + ':' + listRec.get(mapRec);
					} else{
						rule3MapData = rule3MapData + ',' + mapRec + ':' + listRec.get(mapRec);
					}
				}
			}
			filterCriteriaRec.rule3Map__c = rule3MapData;
		}
		if (recordExist == false){
			system.debug('Before Inserting filterCriteriaRec' + filterCriteriaRec);
			insert filterCriteriaRec;
			system.debug('After Inserting filterCriteriaRec' + filterCriteriaRec);

		} else if (recordExist == true){
			system.debug('Before Updating filterCriteriaRec' + filterCriteriaRec);
			update filterCriteriaRec;
			system.debug('After Updating filterCriteriaRec' + filterCriteriaRec);

		}
	}

	
	public static void deleteMPUContractFilterCriteria(String recordId){
		delete [SELECT Name
		        FROM MPU_Filter_Criteria__c 
		        where Mass_Price_Update__c  = :recordId];
	}

	public static void deleteContractChangeDetail(String recordId){
		delete [SELECT Name
		        FROM Quote_Line_Change_Detail__c 
		        where Mass_Price_Update__c  = :recordId];
	}

	public static List<UpdatedMPUContractPriceWrapper> createContractQLChangeDetail(String recordId, List<SBQQ__ContractedPrice__c> updatedQuoteLinesList){
		List<Quote_Line_Change_Detail__c> updateQuoteLChnageist = new List<Quote_Line_Change_Detail__c>();
		System.debug('updated contract object list copying into quote change detail ' + updatedQuoteLinesList);
		for (SBQQ__ContractedPrice__c quoteLineRec : updatedQuoteLinesList){
			Quote_Line_Change_Detail__c quoteLineChangeRec = new Quote_Line_Change_Detail__c();
			system.debug('Update Quote_Line_Change_Detail__c------------' + quoteLineRec);
			quoteLineChangeRec.Name = quoteLineRec.SBQQ__Account__r.Name;
            quoteLineChangeRec.Product_Code__c = quoteLineRec.SBQQ__Product__r.ProductCode;
            quoteLineChangeRec.Product_Name__c = quoteLineRec.SBQQ__Product__r.Name;
			quoteLineChangeRec.Contract_Price_Id__c = quoteLineRec.Id;
			quoteLineChangeRec.Contracted_Discount_Schedule__c = quoteLineRec.SBQQ__DiscountSchedule__c;
			quoteLineChangeRec.Contracted_Price__c = (quoteLineRec.SBQQ__Price__c != null) ? quoteLineRec.SBQQ__Price__c : 0;
			quoteLineChangeRec.Contracted_Discount__c = (quoteLineRec.SBQQ__Discount__c != null) ? quoteLineRec.SBQQ__Discount__c : 0;
			quoteLineChangeRec.New_CP_Discount_Schedule__c = quoteLineRec.New_CP_Discount_Schedule__c;
			quoteLineChangeRec.New_CP_Price__c = (quoteLineRec.New_CP_Price__c != null) ? quoteLineRec.New_CP_Price__c : 0;
			quoteLineChangeRec.New_CP_Discount__c = (quoteLineRec.New_CP_Discount__c != null) ? quoteLineRec.New_CP_Discount__c : 0;
			quoteLineChangeRec.From_Date__c = quoteLineRec.SBQQ__EffectiveDate__c;
			quoteLineChangeRec.To_Date__c = quoteLineRec.SBQQ__ExpirationDate__c;
			quoteLineChangeRec.Mass_Price_Update__c = recordId;
			if (quoteLineRec.SBQQ__OriginalQuoteLine__c != null){
				String quoteId = quoteLineRec.SBQQ__OriginalQuoteLine__c;
				quoteLineChangeRec.Quote_Line_Id__c = quoteLineRec.SBQQ__OriginalQuoteLine__r.Id;
				quoteLineChangeRec.Quote_Number__c = quoteLineRec.SBQQ__OriginalQuoteLine__r.SBQQ__Quote__r.Name;
				quoteLineChangeRec.List_Price__c = quoteLineRec.SBQQ__OriginalQuoteLine__r.SBQQ__ListPrice__c;
				quoteLineChangeRec.Net_Price__c = quoteLineRec.SBQQ__OriginalQuoteLine__r.SBQQ__NetPrice__c;
				quoteLineChangeRec.New_Net_Price__c = (quoteLineRec.SBQQ__OriginalQuoteLine__r.New_Net_Price__c != null) ? quoteLineRec.SBQQ__OriginalQuoteLine__r.New_Net_Price__c : 0;
				quoteLineChangeRec.Discount__c = (quoteLineRec.SBQQ__OriginalQuoteLine__r.SBQQ__Discount__c != null) ? quoteLineRec.SBQQ__OriginalQuoteLine__r.SBQQ__Discount__c : 0;
				quoteLineChangeRec.New_Discount__c = (quoteLineRec.SBQQ__OriginalQuoteLine__r.New_Discount__c != null) ? quoteLineRec.SBQQ__OriginalQuoteLine__r.New_Discount__c : 0;
				quoteLineChangeRec.Quote_Status__c = quoteLineRec.SBQQ__OriginalQuoteLine__r.SBQQ__Quote__r.ApprovalStatus__c;
				quoteLineChangeRec.Source_Quote__c = quoteLineRec.SBQQ__OriginalQuoteLine__r.Id;
			}
			system.debug('quoteLineChangeRec before inserting------------>' + quoteLineChangeRec);
			insert quoteLineChangeRec;
			updateQuoteLChnageist.add(quoteLineChangeRec);
			system.debug('quoteLineChangeRec after inserting------------>' + updateQuoteLChnageist);

		}
		return createContractProdChangeDetail(updateQuoteLChnageist);
	}

	public static SBQQ__ContractedPrice__c findContractById(Id quoteLineId){
		List<SBQQ__ContractedPrice__c> result = [SELECT Id, SBQQ__Price__c, SBQQ__OriginalQuoteLine__c, SBQQ__NonDiscountable__c, SBQQ__Operator__c, SBQQ__FilterValue__c, SBQQ__FilterField__c, SBQQ__ExpirationDate__c, SBQQ__OriginalQuoteLine__r.Id, SBQQ__OriginalQuoteLine__r.SBQQ__Quote__r.Name, SBQQ__EffectiveDate__c, SBQQ__Discount__c, SBQQ__DiscountSchedule__r.Name, SBQQ__Description__c, New_CP_Discount__c, New_CP_Discount_Schedule__c, New_CP_Price__c, SBQQ__Contract__c, SBQQ__Account__r.Name, SBQQ__Product__r.ProductCode, SBQQ__Product__r.Name, Name, SBQQ__OriginalQuoteLine__r.SBQQ__ListPrice__c, SBQQ__OriginalQuoteLine__r.SBQQ__NetPrice__c, SBQQ__OriginalQuoteLine__r.New_Net_Price__c, SBQQ__OriginalQuoteLine__r.SBQQ__Discount__c, SBQQ__OriginalQuoteLine__r.New_Discount__c, SBQQ__OriginalQuoteLine__r.SBQQ__Quote__r.ApprovalStatus__c
		                                         FROM SBQQ__ContractedPrice__c 
		                                         WHERE Id = :quoteLineId];

		return result.get(0);
	}

	public static List<SBQQ__ContractedPrice__c> findContractByFilter(Id quoteLineId, List<Map<String, String>> ruleMap){
		String lineContractQuery = lineContractQuery;
		if (quoteLineId != null){
			lineContractQuery = lineContractQuery + ' WHERE Id = \'' + quoteLineId + '\'';
		}
		//(\'draft\')
		for (Map<String, String> listRec : ruleMap){
			for (String mapRec : listRec.keySet()){
				String keyStr = mapRec;
				system.debug('Key value Str' + keyStr);
				String valueStr = listRec.get(mapRec);
				system.debug('Key2 value Str' + valueStr);
				if (keyStr == 'Customer'){
					lineContractQuery = lineContractQuery + ' and SBQQ__Account__r.Id= \'' + valueStr + '\'';
				} else if (keyStr == 'AccountChannel'){
					lineContractQuery = lineContractQuery + ' and SBQQ__Account__r.Account_Channel__c= \'' + valueStr + '\'';
				} else if (keyStr == 'CustomerClassification'){
					lineContractQuery = lineContractQuery + ' and SBQQ__Account__r.Customer_Classification__c= \'' + valueStr + '\'';
				} else if (keyStr == 'ProductFamily'){
					lineContractQuery = lineContractQuery + ' and SBQQ__Product__r.Family= \'' + valueStr + '\'';
				} else if (keyStr == 'Division'){
					lineContractQuery = lineContractQuery + ' and SBQQ__Product__r.Division__c= \'' + valueStr + '\'';
				} else if (keyStr == 'Product'){
					lineContractQuery = lineContractQuery + ' and SBQQ__Product__r.Id= \'' + valueStr + '\'';
				}
			}
		}

		system.debug('lineContractQuery Value' + lineContractQuery);
		List<SBQQ__ContractedPrice__c> result = Database.query(lineContractQuery);

		system.debug('result Value' + result);
		if (result.isEmpty()){
			system.debug('Entering Empty');
			return new List<SBQQ__ContractedPrice__c>();
		} else{
			system.debug('Entering non Empty');
			return result;
		}
		//return result;
	}

	public static SBQQ__ContractedPrice__c getEvaluatedContLine(SBQQ__ContractedPrice__c quoteLineToUpdate, Double dscPercent, String signValue, String priceColumn, Boolean isNewLine, String dscSchedule){
		if (quoteLineToUpdate.SBQQ__OriginalQuoteLine__c == null){
			if (isNewLine == true){
				if (priceColumn == 'Contract Price'){
					System.debug('Inside ----------Contract Price- new line->' + quoteLineToUpdate.SBQQ__Price__c);

					if (signValue == 'Increase'){
						if (quoteLineToUpdate.SBQQ__Price__c == null){
							quoteLineToUpdate.New_CP_Price__c = 0;
						} else{
							quoteLineToUpdate.New_CP_Price__c = (quoteLineToUpdate.SBQQ__Price__c + ((dscPercent) / 100) * quoteLineToUpdate.SBQQ__Price__c);

						}
					} else if (signValue == 'Decrease'){
						if (quoteLineToUpdate.SBQQ__Price__c == null){
							quoteLineToUpdate.New_CP_Price__c = 0;
						} else{

							quoteLineToUpdate.New_CP_Price__c = (quoteLineToUpdate.SBQQ__Price__c - ((dscPercent) / 100) * quoteLineToUpdate.SBQQ__Price__c);

						}
					} else if (signValue == 'Replace'){
						if (quoteLineToUpdate.SBQQ__Price__c == null){
							quoteLineToUpdate.New_CP_Price__c = 0;
						}
						// quoteLineToUpdate.New_CP_Price__c = dscPercent;
						quoteLineToUpdate.New_CP_Price__c = ((dscPercent / 100) * quoteLineToUpdate.SBQQ__Price__c);

					}
					System.debug('quoteLineToUpdate.New_CP_Price__c  ------------>' + quoteLineToUpdate.New_CP_Price__c);

				}
				if (priceColumn == 'Contract Discount'){
					system.debug('Entering Additional Discount Check');
					system.debug('Sign Value aft entering' + signValue);
					system.debug('Existing SBQQ__Discount__c' + quoteLineToUpdate.SBQQ__Discount__c);

					if (signValue == 'Increase'){
						if (quoteLineToUpdate.SBQQ__Discount__c != null){
							Double latestDiscount = quoteLineToUpdate.SBQQ__Discount__c;
							dscPercent = latestDiscount + dscPercent;
							quoteLineToUpdate.New_CP_Discount__c = dscPercent;
						} else{
							quoteLineToUpdate.New_CP_Discount__c = dscPercent;
						}

					} else if (signValue == 'Decrease'){
						if (quoteLineToUpdate.SBQQ__Discount__c != null){
							Double latestDiscount = quoteLineToUpdate.SBQQ__Discount__c;
							dscPercent = latestDiscount - dscPercent;
							quoteLineToUpdate.New_CP_Discount__c = dscPercent;
						} else{
							quoteLineToUpdate.New_CP_Discount__c = dscPercent;

						}

					} else if (signValue == 'Replace'){
						quoteLineToUpdate.New_CP_Discount__c = dscPercent;
						System.debug('quoteLineToUpdate.New_CP_Discount__c  ------------>' + quoteLineToUpdate.New_CP_Discount__c);

					}
				}
				if (priceColumn == 'Contract Discount Schedule'){

					SBQQ__DiscountSchedule__c sc = [Select Name
					                                from SBQQ__DiscountSchedule__c 
					                                where Id = :dscSchedule];
					quoteLineToUpdate.New_CP_Discount_Schedule__c = sc.Name;

				}

			} else if (isNewLine == false){
				if (priceColumn == 'Contract Price'){
					System.debug('Entering new line false ----------Contract Price-->' + isNewLine);

					System.debug('Inside ---not new line-------Contract Price-->' + priceColumn);

					if (signValue == 'Increase'){
						if (quoteLineToUpdate.New_CP_Price__c != null){
							quoteLineToUpdate.New_CP_Price__c = (quoteLineToUpdate.New_CP_Price__c + ((dscPercent) / 100) * quoteLineToUpdate.New_CP_Price__c);
						}

					} else if (signValue == 'Decrease'){
						if (quoteLineToUpdate.New_CP_Price__c != null){
							quoteLineToUpdate.New_CP_Price__c = (quoteLineToUpdate.New_CP_Price__c - ((dscPercent) / 100) * quoteLineToUpdate.New_CP_Price__c);

						}

					} else if (signValue == 'Replace'){
						//quoteLineToUpdate.New_CP_Price__c = dscPercent;
						if (quoteLineToUpdate.New_CP_Price__c == null){
							quoteLineToUpdate.New_CP_Price__c = 0;
						} else{
							quoteLineToUpdate.New_CP_Price__c = ((dscPercent / 100) * quoteLineToUpdate.New_CP_Price__c);
						}
					}
					System.debug('quoteLineToUpdate.New_CP_Price__c  ------------>' + quoteLineToUpdate.New_CP_Price__c);

				}
				if (priceColumn == 'Contract Discount'){
					System.debug('Entering new line false ----------Contract Discount-->' + isNewLine);

					system.debug('Sign Value aft entering' + signValue);
					if (signValue == 'Increase'){
						if (quoteLineToUpdate.New_CP_Discount__c != null){
							Double latestDiscount = quoteLineToUpdate.New_CP_Discount__c;
							dscPercent = latestDiscount + dscPercent;
							quoteLineToUpdate.New_CP_Discount__c = dscPercent;
						} else{
							// Double latestDiscount = 0;
							//  dscPercent = latestDiscount + dscPercent;
							quoteLineToUpdate.New_CP_Discount__c = dscPercent;
						}
					} else if (signValue == 'Decrease'){
						if (quoteLineToUpdate.New_CP_Discount__c != null){
							Double latestDiscount = quoteLineToUpdate.SBQQ__Discount__c;
							dscPercent = latestDiscount - dscPercent;
							quoteLineToUpdate.New_CP_Discount__c = dscPercent;
						} else{
							//  Double latestDiscount = 0;
							// dscPercent = latestDiscount -  dscPercent;
							quoteLineToUpdate.New_CP_Discount__c = dscPercent;
						}

					} else if (signValue == 'Replace'){
						quoteLineToUpdate.New_CP_Discount__c = dscPercent;

					}
				}
				if (priceColumn == 'Contract Discount Schedule'){
					SBQQ__DiscountSchedule__c sc = [Select Name
					                                from SBQQ__DiscountSchedule__c 
					                                where Id = :dscSchedule];
					quoteLineToUpdate.New_CP_Discount_Schedule__c = sc.Name;

				}
			}
		}else{
            system.debug('In else condition');
            if(isNewLine == true){
                if(priceColumn == 'Contract Price'){
                    if(signValue == 'Increase'){
                        quoteLineToUpdate.New_CP_Price__c = (quoteLineToUpdate.SBQQ__OriginalQuoteLine__r.SBQQ__NetPrice__c + ((dscPercent) / 100) * quoteLineToUpdate.SBQQ__OriginalQuoteLine__r.SBQQ__NetPrice__c);
                        system.debug('New Net Price Value**************'+quoteLineToUpdate.New_CP_Price__c);
                        quoteLineToUpdate.New_CP_Discount__c = ((quoteLineToUpdate.SBQQ__OriginalQuoteLine__r.SBQQ__ListPrice__c - quoteLineToUpdate.New_CP_Price__c)/ quoteLineToUpdate.SBQQ__OriginalQuoteLine__r.SBQQ__ListPrice__c)*100;
                       system.debug('New Discount Value**************'+quoteLineToUpdate.New_CP_Discount__c);
                    }
                    else if (signValue == 'Decrease'){
                        quoteLineToUpdate.New_CP_Price__c = (quoteLineToUpdate.SBQQ__OriginalQuoteLine__r.SBQQ__NetPrice__c - ((dscPercent) / 100) * quoteLineToUpdate.SBQQ__OriginalQuoteLine__r.SBQQ__NetPrice__c);
                        system.debug('New CP Net Price Value**************'+quoteLineToUpdate.New_CP_Price__c);
                        quoteLineToUpdate.New_CP_Discount__c = ((quoteLineToUpdate.SBQQ__OriginalQuoteLine__r.SBQQ__ListPrice__c - quoteLineToUpdate.New_CP_Price__c)/ quoteLineToUpdate.SBQQ__OriginalQuoteLine__r.SBQQ__ListPrice__c)*100;
                        system.debug('New CP Discount Value**************'+quoteLineToUpdate.New_CP_Discount__c);
                    } else if (signValue == 'Replace'){
                        quoteLineToUpdate.New_CP_Price__c = ((dscPercent) / 100) * quoteLineToUpdate.SBQQ__OriginalQuoteLine__r.SBQQ__NetPrice__c;   //replace will set the discount percent of net price value as it is.
                        system.debug('New CP Net Price Value**************'+quoteLineToUpdate.New_CP_Price__c);
                       quoteLineToUpdate.New_CP_Discount__c = ((quoteLineToUpdate.SBQQ__OriginalQuoteLine__r.SBQQ__ListPrice__c - quoteLineToUpdate.New_CP_Price__c)/ quoteLineToUpdate.SBQQ__OriginalQuoteLine__r.SBQQ__ListPrice__c)*100;
                      system.debug('New CP Discount Value**************'+quoteLineToUpdate.New_CP_Discount__c);
                    }
                }
                system.debug('Entering Contract Discount Check');
                if(priceColumn == 'Contract Discount'){
                    if(signValue == 'Increase') {
                        if(quoteLineToUpdate.SBQQ__OriginalQuoteLine__r.SBQQ__Discount__c == null){
                            quoteLineToUpdate.New_CP_Discount__c  = dscPercent;
                        }else{
                            quoteLineToUpdate.New_CP_Discount__c  =  quoteLineToUpdate.SBQQ__OriginalQuoteLine__r.SBQQ__Discount__c + dscPercent;
                        }
                       quoteLineToUpdate.New_CP_Price__c = (quoteLineToUpdate.SBQQ__OriginalQuoteLine__r.SBQQ__ListPrice__c - ((quoteLineToUpdate.New_CP_Discount__c) / 100) * quoteLineToUpdate.SBQQ__OriginalQuoteLine__r.SBQQ__ListPrice__c);
                        
                    }
                    else if(signValue == 'Decrease') {
                        if(quoteLineToUpdate.SBQQ__OriginalQuoteLine__r.SBQQ__Discount__c == null){
                            quoteLineToUpdate.New_CP_Discount__c =  -dscPercent;
                        }else{
                            quoteLineToUpdate.New_CP_Discount__c = quoteLineToUpdate.SBQQ__OriginalQuoteLine__r.SBQQ__Discount__c - dscPercent;
                        }
                        
                        quoteLineToUpdate.New_CP_Price__c = (quoteLineToUpdate.SBQQ__OriginalQuoteLine__r.SBQQ__ListPrice__c - ((quoteLineToUpdate.New_CP_Discount__c) / 100) * quoteLineToUpdate.SBQQ__OriginalQuoteLine__r.SBQQ__ListPrice__c);
                       
                    }
                    else if(signValue == 'Replace') {
                        quoteLineToUpdate.New_CP_Discount__c = dscPercent;
                        quoteLineToUpdate.New_CP_Price__c = (quoteLineToUpdate.SBQQ__OriginalQuoteLine__r.SBQQ__ListPrice__c - ((quoteLineToUpdate.New_CP_Discount__c) / 100) * quoteLineToUpdate.SBQQ__OriginalQuoteLine__r.SBQQ__ListPrice__c);
                    
                    }
                }    
                if (priceColumn == 'Contract Discount Schedule'){
					SBQQ__DiscountSchedule__c sc = [Select Name
					                                from SBQQ__DiscountSchedule__c 
					                                where Id = :dscSchedule];
					quoteLineToUpdate.New_CP_Discount_Schedule__c = sc.Name;

				}
                
            }else if(isNewLine == false){
                if(priceColumn == 'Contract Price'){
                    if(signValue == 'Increase'){
                        quoteLineToUpdate.New_CP_Price__c = (quoteLineToUpdate.New_CP_Price__c + ((dscPercent) / 100) * quoteLineToUpdate.New_CP_Price__c);
                        system.debug('New_CP_Price__c Value**************'+quoteLineToUpdate.New_CP_Price__c);
                        quoteLineToUpdate.New_CP_Discount__c = ((quoteLineToUpdate.SBQQ__OriginalQuoteLine__r.SBQQ__ListPrice__c - quoteLineToUpdate.New_CP_Price__c)/ quoteLineToUpdate.SBQQ__OriginalQuoteLine__r.SBQQ__ListPrice__c)*100;
                        system.debug('New_CP_Discount__c Value**************'+quoteLineToUpdate.New_CP_Discount__c);
                    }
                    else if (signValue == 'Decrease'){
                        quoteLineToUpdate.New_CP_Price__c = (quoteLineToUpdate.New_CP_Price__c - ((dscPercent) / 100) * quoteLineToUpdate.New_CP_Price__c);
                        system.debug('New_CP_Price__c Value**************'+quoteLineToUpdate.New_CP_Price__c);
                        quoteLineToUpdate.New_CP_Discount__c = ((quoteLineToUpdate.SBQQ__OriginalQuoteLine__r.SBQQ__ListPrice__c - quoteLineToUpdate.New_CP_Price__c)/ quoteLineToUpdate.SBQQ__OriginalQuoteLine__r.SBQQ__ListPrice__c)*100;
                        system.debug('New_CP_Discount__c Value**************'+quoteLineToUpdate.New_CP_Discount__c);
                    } else if (signValue == 'Replace'){
                        quoteLineToUpdate.New_CP_Price__c = ((dscPercent) / 100) * quoteLineToUpdate.New_CP_Price__c;   //replace will set the discount percent of net price value as it is.
                        system.debug('New_CP_Price__c Value**************'+quoteLineToUpdate.New_CP_Price__c);
                        quoteLineToUpdate.New_CP_Discount__c = ((quoteLineToUpdate.SBQQ__OriginalQuoteLine__r.SBQQ__ListPrice__c - quoteLineToUpdate.New_CP_Price__c)/ quoteLineToUpdate.SBQQ__OriginalQuoteLine__r.SBQQ__ListPrice__c)*100;
                        system.debug('New_CP_Discount__c Value**************'+quoteLineToUpdate.New_CP_Discount__c);
                    }
                }
    
                if(priceColumn == 'Contract Discount'){
                    if(signValue == 'Increase') {
                        quoteLineToUpdate.New_CP_Discount__c  =  quoteLineToUpdate.New_CP_Discount__c + dscPercent;
                        system.debug('New_CP_Discount__c Value Rule2************** '+quoteLineToUpdate.New_CP_Discount__c);
                        quoteLineToUpdate.New_CP_Price__c = (quoteLineToUpdate.SBQQ__OriginalQuoteLine__r.SBQQ__ListPrice__c - ((quoteLineToUpdate.New_CP_Discount__c) / 100) * quoteLineToUpdate.SBQQ__OriginalQuoteLine__r.SBQQ__ListPrice__c);
                        system.debug('New_CP_Price__c Value Rule2************** '+quoteLineToUpdate.New_CP_Price__c);
                        
                    }
                    else if(signValue == 'Decrease') {
                        quoteLineToUpdate.New_CP_Discount__c = quoteLineToUpdate.New_CP_Discount__c - dscPercent;
                        system.debug('New Discount Value**************'+quoteLineToUpdate.New_CP_Discount__c);
                        quoteLineToUpdate.New_CP_Price__c = (quoteLineToUpdate.SBQQ__OriginalQuoteLine__r.SBQQ__ListPrice__c - ((quoteLineToUpdate.New_CP_Discount__c) / 100) * quoteLineToUpdate.SBQQ__OriginalQuoteLine__r.SBQQ__ListPrice__c);
                        system.debug('New_CP_Price__c Value**************'+quoteLineToUpdate.New_CP_Price__c);
                    }
                    else if(signValue == 'Replace') {
                        quoteLineToUpdate.New_CP_Discount__c = dscPercent;
                        quoteLineToUpdate.New_CP_Price__c = (quoteLineToUpdate.SBQQ__OriginalQuoteLine__r.SBQQ__ListPrice__c - ((quoteLineToUpdate.New_CP_Discount__c) / 100) * quoteLineToUpdate.SBQQ__OriginalQuoteLine__r.SBQQ__ListPrice__c);
                    
                    }
                }
                if (priceColumn == 'Contract Discount Schedule'){
					SBQQ__DiscountSchedule__c sc = [Select Name
					                                from SBQQ__DiscountSchedule__c 
					                                where Id = :dscSchedule];
					quoteLineToUpdate.New_CP_Discount_Schedule__c = sc.Name;

				}
            }
        }
		system.debug('Quote Lines to Update' + quoteLineToUpdate);
		return quoteLineToUpdate; //returns the line with new discount and new price as per rule
	}

	@AuraEnabled
	public static List<UpdatedMPUContractPriceWrapper> calculateNewContractDiscount(List<Id> lstQuoteLinesIds, Double dscPercent, String signValue, String priceColumn, String dscSchedule, Double rule2dscPercent, String rule2SignValue, String rule2PriceColumn, String dscSchedule2, String rule3SignValue, Double rule3dscPercent, String rule3PriceColumn, String dscSchedule3, List<Map<String, String>> rule1Map, List<Map<String, String>> rule2Map, List<Map<String, String>> rule3Map, String recordId, String strSearch, String specificFilter, String specificRule2Filter, String specificRule3Filter){
		try{
			system.debug('dscSchedule --------------' + dscSchedule);
			system.debug('calculateNewContractDiscount priceColumn --------------' + priceColumn);

			List<SBQQ__ContractedPrice__c> quoteLineToUpdate;
			SBQQ__ContractedPrice__c evaluatedquoteLine;
			SBQQ__ContractedPrice__c quoteLineById;
			Boolean isNewLine = false;
			List<SBQQ__ContractedPrice__c> calculatedResult = new List<SBQQ__ContractedPrice__c>();
			calculatedResult.clear();

			deleteMPUContractFilterCriteria(recordId);
			deleteContractChangeDetail(recordId);

			if (rule1Map.size() > 0 || (dscPercent != null && signValue != null) || dscSchedule != null){
				createMPUContractFilterCriteria(dscPercent, signValue, priceColumn, recordId, specificFilter, 'Rule1', rule1Map, dscSchedule);
			}
			if (rule2Map.size() > 0 || (rule2dscPercent != null && rule2SignValue != null) || dscSchedule2 != null){
				createMPUContractFilterCriteria(rule2dscPercent, rule2SignValue, rule2PriceColumn, recordId, specificRule2Filter, 'Rule2', rule2Map, dscSchedule2);
			}
			if (rule3Map.size() > 0 || (rule3dscPercent != null && rule3SignValue != null) || dscSchedule3 != null){
				createMPUContractFilterCriteria(rule3dscPercent, rule3SignValue, rule3PriceColumn, recordId, specificRule3Filter, 'Rule3', rule3Map, dscSchedule3);
			}
			for (Id quoteLineId : lstQuoteLinesIds){
				evaluatedquoteLine = null;
				//check if there is any searched line for the filter in rule1.
				system.debug('Insdie for loop Rule Map 1 *****************' + rule1Map);
				system.debug('Insdie for loop Rule Map 2 *****************' + rule2Map);
				system.debug('Insdie for loop quoteLineId *****************' + quoteLineId);
				//Add ruleMap check for other rules
				if (rule1Map.size() == 0){
					system.debug('Entering rule1Map size zero *********');

					if ((dscPercent != null && signValue != null && priceColumn != null) || dscSchedule != null){
						quoteLineById = findContractById(quoteLineId);
						system.debug('Before Evaluate Check*********' + quoteLineById);
						if (evaluatedquoteLine == null){
							system.debug('Entering Non Evaluate if *********');
							isNewLine = true;
							evaluatedquoteLine = getEvaluatedContLine(quoteLineById, dscPercent, signValue, priceColumn, isNewLine, dscSchedule);
							system.debug('After New Line*********' + evaluatedquoteLine);
						} else{
							system.debug('Entering else evaluatedquoteLine is*********' + evaluatedquoteLine);
							isNewLine = false;
							evaluatedquoteLine = getEvaluatedContLine(evaluatedquoteLine, dscPercent, signValue, priceColumn, isNewLine, dscSchedule);
						}
					}
				} else if (rule1Map.size() > 0){
					system.debug('entered rule1 map if size > 0 ' + quoteLineId);
					quoteLineToUpdate = findContractByFilter(quoteLineId, rule1Map);
					system.debug('Getting Value rule1 map' + quoteLineToUpdate);
					if (quoteLineToUpdate.size() > 0){
						system.debug('quotelinetoupdate rule1 map is ' + quoteLineToUpdate[0]);
						isNewLine = true;
						evaluatedquoteLine = getEvaluatedContLine(quoteLineToUpdate[0], dscPercent, signValue, priceColumn, isNewLine, dscSchedule);
						system.debug('evaluated rule1 map quoteline' + evaluatedquoteLine.Id);
					}
				}
				//check if rule1 is applied then send the evaluatedquoteLine else send the original.
				/*same line will be checked for the filter combination is rule2.if the line has the combination then
				 if the line is evaluated during rule1 ,the updated line has to be sent for rule2, if the line dint get evaluated in
				 rule1 then the original line from the query can be sent*/
				if (rule2Map.size() == 0){
					system.debug('Entering rule2Map size zero *********');

					if ((rule2dscPercent != null && rule2SignValue != null && rule2PriceColumn != null) || dscSchedule2 != null){
						quoteLineById = findContractById(quoteLineId);
						if (evaluatedquoteLine == null){
							system.debug('isNewLine = true*********' + evaluatedquoteLine);

							isNewLine = true;
							evaluatedquoteLine = getEvaluatedContLine(quoteLineById, rule2dscPercent, rule2SignValue, rule2PriceColumn, isNewLine, dscSchedule2);
						} else{
							isNewLine = false;
							evaluatedquoteLine = getEvaluatedContLine(evaluatedquoteLine, rule2dscPercent, rule2SignValue, rule2PriceColumn, isNewLine, dscSchedule2);
						}
					}
				} else if (rule2Map.size() > 0){
					system.debug('Entering rule2Map size > zero *********');
					quoteLineToUpdate = findContractByFilter(quoteLineId, rule2Map);
					system.debug('Getting Value in rule2' + quoteLineToUpdate);
					if (quoteLineToUpdate.size() > 0){
						system.debug('quotelinetoupdate in rul2' + quoteLineToUpdate);
						if (evaluatedquoteLine != null){
							system.debug('evaluated as not null' + evaluatedquoteLine);
							isNewLine = false;
							evaluatedquoteLine = getEvaluatedContLine(evaluatedquoteLine, rule2dscPercent, rule2SignValue, rule2PriceColumn, isNewLine, dscSchedule2);
						} else{
							system.debug('evaluated as null' + quoteLineToUpdate);
							isNewLine = true;
							evaluatedquoteLine = getEvaluatedContLine(quoteLineToUpdate[0], rule2dscPercent, rule2SignValue, rule2PriceColumn, isNewLine, dscSchedule2);
						}
					}
				}

				if (rule3Map.size() == 0){
					system.debug('Entering rule3Map size  zero *********');

					if ((rule3dscPercent != null && rule3SignValue != null && rule3PriceColumn != null) || dscSchedule3 != null){
						quoteLineById = findContractById(quoteLineId);
						if (evaluatedquoteLine == null){
							isNewLine = true;
							evaluatedquoteLine = getEvaluatedContLine(quoteLineById, rule3dscPercent, rule3SignValue, rule3PriceColumn, isNewLine, dscSchedule3);
						} else{
							isNewLine = false;
							evaluatedquoteLine = getEvaluatedContLine(evaluatedquoteLine, rule3dscPercent, rule3SignValue, rule3PriceColumn, isNewLine, dscSchedule3);
						}
					}
				} else if (rule3Map.size() > 0){
					system.debug('Entering rule3Map size >  zero *********');

					quoteLineToUpdate = findContractByFilter(quoteLineId, rule3Map);
					system.debug('Getting Value in rule3' + quoteLineToUpdate);
					if (quoteLineToUpdate.size() > 0){
						system.debug('quotelinetoupdate in rul2' + quoteLineToUpdate);
						if (evaluatedquoteLine != null){
							system.debug('evaluated as not null' + evaluatedquoteLine);
							isNewLine = false;
							evaluatedquoteLine = getEvaluatedContLine(evaluatedquoteLine, rule3dscPercent, rule3SignValue, rule3PriceColumn, isNewLine, dscSchedule3);
						} else{
							system.debug('evaluated as null' + quoteLineToUpdate);
							isNewLine = true;
							evaluatedquoteLine = getEvaluatedContLine(quoteLineToUpdate[0], rule3dscPercent, rule3SignValue, rule3PriceColumn, isNewLine, dscSchedule3);
						}
					}
				}

				//the line will be set to list after its evaluated for all the rules
				if (evaluatedquoteLine != null){
					system.debug('Inside if evaluatedquoteLine before updating calculatedResult' + evaluatedquoteLine);
					calculatedResult.add(evaluatedquoteLine);
				}

			}
			update calculatedResult;
			system.debug('calculatedResult is ' + calculatedResult);

			return createContractQLChangeDetail(recordId, calculatedResult);
			//return createProductUpdateList(calculatedResult);

		} catch (Exception ex){
			throw new AuraHandledException(ex.getStackTraceString());
		}
	}

	@AuraEnabled
	public static List<UpdatedMPUContractPriceWrapper> confirmContractDiscount(Double dscPercent, String recordId, String strSearch, String priceColumn, String dscSchedule){
		System.debug('@@@@@@@@@@@@@@@@@@@@ Inside confirm method @@@@@@@@@@@@@@@@@@@@@@@@@@' + recordId);
		List<Quote_Line_Change_Detail__c> calculatedChangeDetailResult = new List<Quote_Line_Change_Detail__c>();

		try{
			List<SBQQ__ContractedPrice__c> calculatedResult = new List<SBQQ__ContractedPrice__c>();
			String QLChnageDetailQuery = GetContractChangeDetailQuery + ' Where Mass_Price_Update__c =\'' + recordId + '\'';
			List<Quote_Line_Change_Detail__c> lstQuoteLinesIds = Database.query(QLChnageDetailQuery);
			Map<String, String> newQuoteMapping = new Map<String, String>();
            Map<String, String> quoteMapping = new Map<String, String>();
            Map<String, String> quoteMapping1 = new Map<String, String>();

            List<SBQQ__QuoteLine__c> qlines = new List<SBQQ__QuoteLine__c>();
			for (Quote_Line_Change_Detail__c quoteLineChangeDetailToUpdate : lstQuoteLinesIds){
				SBQQ__ContractedPrice__c quoteLine = [Select Id
				                                      from SBQQ__ContractedPrice__c 
				                                      where Id = :quoteLineChangeDetailToUpdate.Contract_Price_Id__c];
				system.debug('Contract Id from Query' + quoteLine);
				SBQQ__ContractedPrice__c quoteLineToUpdate = findContractById(quoteLine.Id);
				Boolean sameQuoteIdExists = false;
                Boolean sourceQuoteExists = false;
				if (quoteLineChangeDetailToUpdate != null){

					calculatedChangeDetailResult.add(quoteLineChangeDetailToUpdate);
					system.debug('quoteLineChangeDetailToUpdate -------' + quoteLineChangeDetailToUpdate);

				}
				if (quoteLineToUpdate != null){

					SBQQ__ContractedPrice__c con = [SELECT SBQQ__OriginalQuoteLine__r.Id
					                                FROM SBQQ__ContractedPrice__c 
					                                WHERE Id = :quoteLineToUpdate.Id];
					String quoteLineId = con.SBQQ__OriginalQuoteLine__r.Id;
					if (quoteLineId != null){
                        sourceQuoteExists=true;
						SBQQ__QuoteLine__c oldQuoteId = [Select SBQQ__Quote__r.Id
						                                 from SBQQ__QuoteLine__c 
						                                 where Id = :quoteLineId];
						if (quoteMapping.containsKey(oldQuoteId.SBQQ__Quote__r.Id)){
							sameQuoteIdExists = true;
							system.debug('QUOTE EXISTS ' + oldQuoteId);
						}
						quoteMapping.put(oldQuoteId.SBQQ__Quote__r.Id, quoteLineId);
						System.debug('Map having old quote id and quote line id ' + quoteMapping);

                        SBQQ__QuoteLine__c qc = createSourceQuoteObject(quoteLineToUpdate.Id, priceColumn, recordId, sameQuoteIdExists, newQuoteMapping, dscSchedule,sourceQuoteExists);
                        System.debug('Quote line '+qc.SBQQ__Quote__r.Name);

                        qlines.add(qc);

					} else{
						quoteLineToUpdate = createContractObject(quoteLineToUpdate.Id, priceColumn, recordId, sameQuoteIdExists, newQuoteMapping, dscSchedule,sourceQuoteExists);

					}
					System.debug('After Entering createContractObject quoteLineToUpdate' + quoteLineToUpdate);
					if(quoteLineToUpdate!=null)
					calculatedResult.add(quoteLineToUpdate);
				}
			}

			update calculatedResult;
            update calculatedChangeDetailResult;
            System.debug('Quote lines Final list '+qlines);
            for(SBQQ__QuoteLine__c newQuoteLine:qlines){
            	SBQQ__QuoteLine__c updateQL = [Select SBQQ__Quote__r.Id
						                                 from SBQQ__QuoteLine__c 
						                                 where Id = :newQuoteLine.Id];
						if (quoteMapping.containsKey(updateQL.SBQQ__Quote__r.Id)){
							system.debug('updateQL.SBQQ__Quote__r.Id exists' + updateQL.SBQQ__Quote__r.Id);
						}else{
                            quoteMapping1.put(updateQL.SBQQ__Quote__r.Id, updateQL.Id);
                            SBQQ__Quote__c quote = [SELECT SBQQ__Opportunity2__r.Id	FROM SBQQ__Quote__c where Id = :updateQL.SBQQ__Quote__r.Id];
                            String oppId = quote.SBQQ__Opportunity2__r.Id;
                            Opportunity newOpportunity = [SELECT  SBQQ__Contracted__c,StageName  FROM Opportunity where Id =:oppId];
							System.debug('Before updating opportunity' + newOpportunity);
							//newOpportunity.StageName = 'Closed Won';
                           // newOpportunity.SBQQ__Contracted__c = true;
				           // update newOpportunity;
				            System.debug('After updating opportunity' + newOpportunity);
                        }
             }
             System.debug('quoteMapping1 ------> ' + quoteMapping1);

			System.debug('calculatedResult ------> ' + calculatedResult);
			System.debug('calculatedChangeDetailResult ------>' + calculatedChangeDetailResult);

		} catch (Exception ex){
			System.debug('Exception ' + ex.getStackTraceString());
			System.debug('Line NUmber  ' + ex.getLineNumber());
			System.debug('Line NUmber  ' + ex.getMessage());
			// throw new AuraHandledException(ex.getMessage());


		}
		return createContractProdChangeDetail(calculatedChangeDetailResult);
	}
	public static SBQQ__QuoteLine__c createSourceQuoteObject(String contractObjectId, String priceColumn, String recordId, Boolean sameQuoteIdExists, Map<String, String> newQuoteMapping, String dscSchedule,Boolean sourceQuoteExists){
        System.debug('########### Entering  createSourceQuoteObject' + contractObjectId);
        SBQQ__ContractedPrice__c newContractObject;
        List<SBQQ__QuoteLine__c> qLines;
        try{
        String mpuQueryString = 'SELECT Effective_From__c,Effective_To__c FROM Mass_Price_Update__c where Id =\'' + recordId + '\'';
		Mass_Price_Update__c mpu = Database.query(mpuQueryString);
		Date effectiveFrom = mpu.Effective_From__c;
        Date effectiveTo = mpu.Effective_To__c;
        String contractQuery = 'SBQQ__OriginalQuoteLine__r.Id,SBQQ__OriginalQuoteLine__r.SBQQ__Quote__r.Name,SBQQ__OriginalQuoteLine__r.SBQQ__ListPrice__c,SBQQ__OriginalQuoteLine__r.SBQQ__NetPrice__c,SBQQ__OriginalQuoteLine__r.New_Net_Price__c,SBQQ__OriginalQuoteLine__r.SBQQ__Discount__c,SBQQ__OriginalQuoteLine__r.New_Discount__c,SBQQ__Account__r.Id,SBQQ__Product__r.Id';
        Map<String, Schema.SObjectField> quoteFields = Schema.SObjectType.SBQQ__ContractedPrice__c.Fields.getMap();
        for (String fld : quoteFields.keySet()){
            if (contractQuery.length() != 0){
                contractQuery += ',';
            }
            contractQuery += fld;
        }
        String queryString = 'SELECT ' + contractQuery + ' FROM SBQQ__ContractedPrice__c where Id = \'' + contractObjectId + '\'';
        SBQQ__ContractedPrice__c oldContractPriceObj = Database.query(queryString);
     	if (contractObjectId != null){
			SBQQ__ContractedPrice__c c = [SELECT SBQQ__ExpirationDate__c
			                              FROM SBQQ__ContractedPrice__c 
			                              WHERE Id = :contractObjectId];
		   DateTime dt = System.now();
           Date myDate = date.newinstance(dt.year(), dt.month(), dt.day()); 
		   c.SBQQ__ExpirationDate__c = myDate.addDays(-1);
			update c;
			System.debug('Setting old contract Object Expiration to yesterday ' + c);

		}
        if(sourceQuoteExists){
            System.debug('Source Quote Object  exists so going to create Quote object' + sourceQuoteExists);
			if (oldContractPriceObj.SBQQ__OriginalQuoteLine__c != null){
				String oldQuoteLineId = oldContractPriceObj.SBQQ__OriginalQuoteLine__c;
				String quoteLineString = 'SELECT  SBQQ__Quote__r.Id FROM SBQQ__QuoteLine__c where Id = \'' + oldQuoteLineId + '\'';
				SBQQ__QuoteLine__c quoteLineObj = Database.query(quoteLineString);
				String quoteId = quoteLineObj.SBQQ__Quote__r.Id;

				 qLines = createQuoteWithLineItems(quoteId, recordId, priceColumn, oldQuoteLineId, sameQuoteIdExists, newQuoteMapping,oldContractPriceObj);
			
				
				
            }

			}
		} catch (System.QueryException e){
			System.debug('Exception ' + e.getStackTraceString());
			System.debug('Line NUmber  ' + e.getLineNumber());
			System.debug('Line NUmber  ' + e.getMessage());


		}
		return qLines.get(0);
    }
	public static SBQQ__ContractedPrice__c createContractObject(String contractObjectId, String priceColumn, String recordId, Boolean sameQuoteIdExists, Map<String, String> newQuoteMapping, String dscSchedule,Boolean sourceQuoteExists){
		System.debug('########### Entering  createContractObject' + contractObjectId);
        SBQQ__ContractedPrice__c newContractObject;
        try{
        String mpuQueryString = 'SELECT Effective_From__c,Effective_To__c FROM Mass_Price_Update__c where Id =\'' + recordId + '\'';
		Mass_Price_Update__c mpu = Database.query(mpuQueryString);
		Date effectiveFrom = mpu.Effective_From__c;
        Date effectiveTo = mpu.Effective_To__c;
        String contractQuery = 'SBQQ__OriginalQuoteLine__r.Id,SBQQ__OriginalQuoteLine__r.SBQQ__Quote__r.Name,SBQQ__OriginalQuoteLine__r.SBQQ__ListPrice__c,SBQQ__OriginalQuoteLine__r.SBQQ__NetPrice__c,SBQQ__OriginalQuoteLine__r.New_Net_Price__c,SBQQ__OriginalQuoteLine__r.SBQQ__Discount__c,SBQQ__OriginalQuoteLine__r.New_Discount__c,SBQQ__Account__r.Id,SBQQ__Product__r.Id';
        Map<String, Schema.SObjectField> quoteFields = Schema.SObjectType.SBQQ__ContractedPrice__c.Fields.getMap();
        for (String fld : quoteFields.keySet()){
            if (contractQuery.length() != 0){
                contractQuery += ',';
            }
            contractQuery += fld;
        }
        String queryString = 'SELECT ' + contractQuery + ' FROM SBQQ__ContractedPrice__c where Id = \'' + contractObjectId + '\'';
        SBQQ__ContractedPrice__c oldContractPriceObj = Database.query(queryString);
        system.debug('oldContractPriceObj --------------' + oldContractPriceObj);
		if (contractObjectId != null){
			SBQQ__ContractedPrice__c c = [SELECT SBQQ__ExpirationDate__c
			                              FROM SBQQ__ContractedPrice__c 
			                              WHERE Id = :contractObjectId];
		   DateTime dt = System.now();
           Date myDate = date.newinstance(dt.year(), dt.month(), dt.day()); 
		   c.SBQQ__ExpirationDate__c = myDate.addDays(-1);
			update c;
		}
        if(!sourceQuoteExists){
            System.debug('Source Quote Object doesnt exists ' + sourceQuoteExists);
            System.debug('dscSchedule ' + dscSchedule);

			newContractObject = oldContractPriceObj.clone(false, true, true, false);
			newContractObject.SBQQ__Price__c = oldContractPriceObj.New_CP_Price__c;
			newContractObject.SBQQ__Discount__c = oldContractPriceObj.New_CP_Discount__c;
			if(priceColumn == 'Contract Discount Schedule')
			newContractObject.SBQQ__DiscountSchedule__c = dscSchedule;
			newContractObject.SBQQ__EffectiveDate__c = effectiveFrom;
			newContractObject.SBQQ__ExpirationDate__c = effectiveTo;
			insert newContractObject;
            System.debug('New Contract Object Inserted  and Id ' + newContractObject);
        }
       
		} catch (System.QueryException e){
			System.debug('Exception ' + e.getStackTraceString());
			System.debug('Line NUmber  ' + e.getLineNumber());
			System.debug('Line NUmber  ' + e.getMessage());


		}
		return newContractObject;
	}

	public static List<SBQQ__QuoteLine__c> createQuoteWithLineItems(String quoteId, String recordId, String priceColumn, String oldQuoteLineId, Boolean sameQuoteIdExists, Map<String, String> newQuoteMapping,SBQQ__ContractedPrice__c oldContractPriceObj){
		List<SBQQ__QuoteLine__c> newQuoteLineItemLst = new List<SBQQ__QuoteLine__c>();
	//	Opportunity newOpportunity;
		Opportunity newOpportunity = new Opportunity();
		SBQQ__Quote__c newQuote;
		try{
			String mpuQueryString = 'SELECT Auto_Approval__c,Effective_From__c,Effective_To__c,MPU_Name__c     FROM Mass_Price_Update__c where Id =\'' + recordId + '\'';
			Mass_Price_Update__c mpu = Database.query(mpuQueryString);
			if (sameQuoteIdExists){
				System.debug('This Quote  already exists so will not create Quote just adding the Line items. ' + newQuoteMapping.get(quoteId));
				String newQuoteId = newQuoteMapping.get(quoteId);
				SBQQ__QuoteLine__c qLine = new SBQQ__QuoteLine__c();
				SBQQ__QuoteLine__c newProdId = [Select SBQQ__Product__r.Id
				                                from SBQQ__QuoteLine__c 
				                                where Id = :oldQuoteLineId
				                                limit 1];
				SBQQ__Quote__c quote = [Select Id
				                        from SBQQ__Quote__c 
				                        where Id = :newQuoteId];
				qLine.SBQQ__Quote__c = quote.Id;
				qLine.SBQQ__Product__c = newProdId.SBQQ__Product__r.Id;
				qLine.SBQQ__StartDate__c = mpu.Effective_From__c;
                qLine.SBQQ__EndDate__c = mpu.Effective_To__c;
                qLine.SBQQ__Discount__c = oldContractPriceObj.New_CP_Discount__c;
				qLine.SBQQ__NetPrice__c = oldContractPriceObj.New_CP_Price__c;
			//	if(priceColumn == 'Contract Discount Schedule')
                qline.SBQQ__DiscountSchedule__c =oldContractPriceObj.New_CP_Discount_Schedule__c;
				insert qLine;
				newQuoteLineItemLst.add(qLine);
				return newQuoteLineItemLst;
			} else{
				System.debug(' Quote doesnt exists so creating Opportunity Quote and  adding the Line items. ');

				String quoteQuery = '';
				String oppQuery = '';
				Map<String, Schema.SObjectField> oppFields = Schema.SObjectType.Opportunity.Fields.getMap();
			  for(String oppFld: oppFields.keySet())
			  {
				  if(oppQuery.length() != 0)
				  {
					  oppQuery += ',';
				  }
				  oppQuery += oppFld;
			  }

				Map<String, Schema.SObjectField> quoteFields = Schema.SObjectType.SBQQ__Quote__c.Fields.getMap();
				for (String fld : quoteFields.keySet()){
					if (quoteQuery.length() != 0){
						quoteQuery += ',';
					}
					quoteQuery += fld;
				}
				String queryString = 'SELECT ' + quoteQuery + ' FROM SBQQ__Quote__c where Id = \'' + quoteId + '\'';
				SBQQ__Quote__c oldQuote = Database.query(queryString);
				String oppQueryString = 'SELECT ' + oppQuery + ' FROM Opportunity where Id = \'' + oldQuote.SBQQ__Opportunity2__c + '\'';
				Opportunity oldOpportunity = Database.query(oppQueryString);
			//	newOpportunity = oldOpportunity.clone(false,false,false,false);
				Account accountObj = [Select Id from Account where Id =:oldOpportunity.AccountId limit 1];
				newOpportunity.AccountId =accountObj.Id;
				newOpportunity.Name = mpu.MPU_Name__c+'-'+oldOpportunity.Name;
				newOpportunity.StageName = 'Proposal/Price Quote';
				DateTime dt = System.now();
				Date myDate = date.newinstance(dt.year(), dt.month(), dt.day()); 
				newOpportunity.CloseDate = myDate.addDays(10);
			//	newOpportunity.SBQQ__Contracted__c =false;
                insert newOpportunity;
                system.debug('Opportunity is created -------------> '+newOpportunity);
				Opportunity newOpportunityId = [Select Id from Opportunity where Id=:newOpportunity.Id];
			
				newQuote = oldQuote.clone(false, false, false, false);
				SBQQ__Quote__c newPriceId = [Select SBQQ__PriceBook__r.Id, SBQQ__Account__r.Id, Quote_Name__c, SBQQ__Account__r.Name
				                             from SBQQ__Quote__c 
				                             where Id = :quoteId
				                             limit 1];
				newQuote.SBQQ__PriceBook__c = newPriceId.SBQQ__PriceBook__r.Id;
				newQuote.SBQQ__Account__c = newPriceId.SBQQ__Account__r.Id;
				newQuote.SBQQ__Opportunity2__c = newOpportunityId.Id;
				newQuote.Quote_Name__c = mpu.MPU_Name__c + '-' + oldQuote.Name;
				newQuote.SBQQ__Primary__c = true;
				/*if (mpu.Auto_Approval__c != true){
					newQuote.ApprovalStatus__c = 'Pending';
				} else{
					newQuote.ApprovalStatus__c = 'Approved';

				}*/
				newQuote.SBQQ__StartDate__c = mpu.Effective_From__c;
				newQuote.SBQQ__EndDate__c = mpu.Effective_To__c;
							
				if (priceColumn == 'Contract Discount Schedule'){
					newQuote.SBQQ__GenerateContractedPrice__c = 'Discount Schedule';
				}
				else {
					newQuote.SBQQ__GenerateContractedPrice__c = 'Price';

				}

				insert newQuote;
				//newOpportunity.SBQQ__PrimaryQuote__c = newQuote.Id;
				//newOpportunity.Pricebook2Id =newQuote.SBQQ__PricebookId__c;
				//update newOpportunity;
				newQuoteMapping.put(quoteId, newQuote.Id);
				System.debug('Quote is created  ------------->' + newQuote);
				//System.debug('newOpportunity updated  ' + newOpportunity);


				SBQQ__QuoteLine__c qLine = new SBQQ__QuoteLine__c();
				SBQQ__QuoteLine__c newProdId = [Select SBQQ__Product__r.Id
				                                from SBQQ__QuoteLine__c 
				                                where Id = :oldQuoteLineId
				                                limit 1];
				qLine.SBQQ__Quote__c = newQuote.Id;
				qLine.SBQQ__Product__c = newProdId.SBQQ__Product__r.Id;
				qLine.SBQQ__StartDate__c = mpu.Effective_From__c;
				qLine.SBQQ__EndDate__c = mpu.Effective_To__c;
				//if(priceColumn == 'Contract Price')
				qLine.SBQQ__NetPrice__c = oldContractPriceObj.New_CP_Price__c;
				//if(priceColumn == 'Contract Discount')
				qLine.SBQQ__Discount__c = oldContractPriceObj.New_CP_Discount__c;
				
                qline.SBQQ__DiscountSchedule__c =oldContractPriceObj.New_CP_Discount_Schedule__c;
				insert qLine;
				newQuoteLineItemLst.add(qLine);
				System.debug('Quote line is created  ------------->' + qLine);

				//wait(15000);
				//List<SBQQ__QuoteLine__c> qlineList = [Select Name,Id from SBQQ__QuoteLine__c  where SBQQ__Quote__r.Id = :newQuote.Id];
				//System.debug('Qline List' + qlineList);
				//System.debug('Before updating newOpportunity' + newOpportunity);

				//newOpportunity = [SELECT  SBQQ__Contracted__c,StageName  FROM Opportunity where Id =:newOpportunity.Id];
				/*newOpportunity.StageName = 'Closed Won';
				newOpportunity.SBQQ__Contracted__c = true;
				update newOpportunity;
				System.debug('After updating newOpportunity' + newOpportunity);*/

				// insert newQuoteLineItemLst;
			}
		} catch (Exception e){
			System.debug('Exception ' + e.getStackTraceString());
			System.debug('Line NUmber  ' + e.getLineNumber());
			System.debug('Line NUmber  ' + e.getMessage());

		}
		return newQuoteLineItemLst;
	}
	public static void wait(Integer millisec) {
    
		if(millisec == null || millisec < 0) {
		  millisec = 0;
		}
		  
		Long startTime = DateTime.now().getTime();
		Long finishTime = DateTime.now().getTime();
		while ((finishTime - startTime) < millisec) {
		  //sleep for parameter x millisecs
		  finishTime = DateTime.now().getTime();
		}
		 System.debug('>>> Done from ' + startTime + ' to ' + finishTime);
	  }
	@AuraEnabled
	public static List<UpdatedMPUContractPriceWrapper> cancelDiscount(List<Id> lstQuoteLinesIds, Double dscPercent, String recordId, String strSearch){
		try{
			List<Quote_Line_Change_Detail__c> calculatedChangeDetailResult = new List<Quote_Line_Change_Detail__c>();
			System.debug('Inside cancelDiscount');
			String QLChnageDetailQuery = GetContractChangeDetailQuery + ' Where Mass_Price_Update__c =\'' + recordId + '\'';
			List<Quote_Line_Change_Detail__c> lstQuoteChangeDetails = Database.query(QLChnageDetailQuery);
			for (Quote_Line_Change_Detail__c quoteLineChangeDetailToUpdate : lstQuoteChangeDetails){

				if (quoteLineChangeDetailToUpdate != null){
					System.debug('In quoteLineChangeDetailToUpdate not null' + quoteLineChangeDetailToUpdate);
					quoteLineChangeDetailToUpdate.New_CP_Price__c = 0;
					quoteLineChangeDetailToUpdate.New_CP_Discount__c = 0;
					quoteLineChangeDetailToUpdate.New_CP_Discount_Schedule__c = null;
					// update quoteLineToUpdate;
					calculatedChangeDetailResult.add(quoteLineChangeDetailToUpdate);
				}
			}
			update calculatedChangeDetailResult;
			//shraddha
			return createContractProdChangeDetail(calculatedChangeDetailResult);

		} catch (Exception ex){
			throw new AuraHandledException(ex.getMessage());
		}
	}

	@AuraEnabled
	public static void createQuote(){
	}

	public class MPUContractPriceWrapper{
		@AuraEnabled
		public Id id{ get; set; }

		@AuraEnabled
		public String accountName{ get; set; }

		@AuraEnabled
		public String productName{ get; set; }

		@AuraEnabled
		public String productCode{ get; set; }

		@AuraEnabled
		public Id souceQuote{ get; set; }

		@AuraEnabled
		public Double price{ get; set; }

		@AuraEnabled
		public String discountSchedule{ get; set; }

		@AuraEnabled
		public Double discount{ get; set; }

		@AuraEnabled
		public Date effectiveDate{ get; set; }

		@AuraEnabled
		public Date expirationDate{ get; set; }

		@AuraEnabled
		public String quoteStatus{ get; set; }

		@AuraEnabled
		public String quoteName{ get; set; }

		public MPUContractPriceWrapper(SBQQ__ContractedPrice__c contractPrice){
			this.id = contractPrice.Id;
			this.accountName = contractPrice.SBQQ__Account__r.Name;
			this.productName = contractPrice.SBQQ__Product__r.Name;
			this.productCode = contractPrice.SBQQ__Product__r.ProductCode;
			this.souceQuote = contractPrice.SBQQ__OriginalQuoteLine__r.Id;
			this.price = (contractPrice.SBQQ__Price__c != null) ? contractPrice.SBQQ__Price__c : 0;
			this.discountSchedule = contractPrice.SBQQ__DiscountSchedule__r.Name;
			this.discount = (contractPrice.SBQQ__Discount__c != null) ? (contractPrice.SBQQ__Discount__c / 100) : 0;
			this.effectiveDate = contractPrice.SBQQ__EffectiveDate__c;
			this.expirationDate = contractPrice.SBQQ__ExpirationDate__c;
			this.quoteStatus = contractPrice.Quote_Status__c;
			this.quoteName = contractPrice.Quote_Number__c;
		}
	}

	public class UpdatedMPUContractPriceWrapper{
		@AuraEnabled
		public Id id{ get; set; }

		@AuraEnabled
		public String accountName{ get; set; }

		@AuraEnabled
		public String productCode{ get; set; }

		@AuraEnabled
		public String productName{ get; set; }

		@AuraEnabled
		public Id souceQuote{ get; set; }

		@AuraEnabled
		public Double price{ get; set; }

		@AuraEnabled
		public String discountSchedule{ get; set; }

		@AuraEnabled
		public Double discount{ get; set; }

		@AuraEnabled
		public Date effectiveDate{ get; set; }

		@AuraEnabled
		public Date expirationDate{ get; set; }

		@AuraEnabled
		public Double newPrice{ get; set; }

		@AuraEnabled
		public String newDiscountSchedule{ get; set; }

		@AuraEnabled
		public Double newDiscount{ get; set; }

		@AuraEnabled
		public String quoteStatus{ get; set; }

		@AuraEnabled
		public String quoteName{ get; set; }

		public UpdatedMPUContractPriceWrapper(Quote_Line_Change_Detail__c contractPrice){
			this.id = contractPrice.Contract_Price_Id__c;
			this.accountName = contractPrice.Name;
			this.productCode = contractPrice.Product_Code__c;
			this.productName = contractPrice.Product_Name__c;
			this.souceQuote = contractPrice.Source_Quote__c;
			this.price = (contractPrice.Contracted_Price__c != null) ? contractPrice.Contracted_Price__c : 0;
			this.discountSchedule = contractPrice.Contracted_Discount_Schedule__c;
			this.discount = (contractPrice.Contracted_Discount__c != null) ? (contractPrice.Contracted_Discount__c / 100) : 0;
			this.effectiveDate = contractPrice.From_Date__c;
			this.expirationDate = contractPrice.To_Date__c;
			this.newPrice = (contractPrice.New_CP_Price__c != null) ? contractPrice.New_CP_Price__c : 0;
			this.newDiscountSchedule = contractPrice.New_CP_Discount_Schedule__c;
			this.newDiscount = (contractPrice.New_CP_Discount__c != null) ? (contractPrice.New_CP_Discount__c / 100) : 0;
			this.quoteStatus = contractPrice.Quote_Status__c;
			this.quoteName = contractPrice.Quote_Number__c;
		}
	}

}