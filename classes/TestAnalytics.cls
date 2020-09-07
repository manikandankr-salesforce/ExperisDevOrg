public class TestAnalytics {
    /*public static void getProductRecords() {
        String query = 'q = load "0Fb5w000000QW3YCAW/0Fc5w000004OfGOCA0";q = group q by Name_brand_Grade;q = foreach q generate \'Name_brand_Grade\' as \'Product\', sum(\'ListPrice\') as \'ListPrice\', sum(\'Quantity\') as \'Quantity\';q = filter q by Product == "Hydrocarbons C5 Rich";'; 
        ConnectApi.LiteralJson result =  ConnectApi.Wave.executeQuery(query);
        String response = result.json;
        Map<String,Object> responseMap = (Map<String,Object>)JSON.deserializeUntyped(response);
        Map<String,Object> resultMap = (Map<String,Object>)responseMap.get('results');
        System.debug('ResultList :' +resultMap.get('records'));
        List<Object> recordList = (List<Object>)resultMap.get('records');
        System.debug('RecordList :' +recordList.get(0));
        Map<String,Object> recordMap = (Map<String,Object>)recordList.get(0);
        System.debug('List Price' +recordMap.get('ListPrice'));
		System.debug('List Price' +recordMap.get('Quantity'));
}*/
}