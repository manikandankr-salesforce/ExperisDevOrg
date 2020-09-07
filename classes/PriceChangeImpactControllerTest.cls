@isTest(SeeAllData=true)
public class PriceChangeImpactControllerTest {
@isTest
    static void PCICTest(){
        	Test.startTest();
        	String recordId = [Select Pricebook2Id from PricebookEntry Order By CreatedDate desc LIMIT 1].Pricebook2Id;
        	PriceChangeImpactController impactCont = new PriceChangeImpactController();
        	impactCont.recordId = recordId;
        	impactCont.getData();
        Test.stopTest();
    }
}