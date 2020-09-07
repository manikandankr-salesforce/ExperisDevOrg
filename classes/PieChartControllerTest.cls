@isTest(SeeAllData=true)
public class PieChartControllerTest {
@isTest
    static void PCCTest(){
        Test.startTest();
        PieChartController pcc = new PieChartController();
        pcc.getPieData();
        Test.stopTest();
    }
}