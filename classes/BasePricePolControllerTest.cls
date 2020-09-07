@isTest 
public class BasePricePolControllerTest {
static testMethod void testMethod1() 
 {
 List <Account> lstAccount = new List<Account>();
 
 Account testAccount = new Account();
 testAccount.Name='Test Account' ;
 lstAccount.add(testAccount);
 Account testAccount1 = new Account();
 testAccount1.Name='Test Account1' ;
 lstAccount.add(testAccount1);

 insert  lstAccount;
 
 Test.startTest();
  Test.setCurrentPage(Page.Base_Price_View);
  ApexPages.StandardSetController stdSetController = new ApexPages.StandardSetController(lstAccount);
  stdSetController.setSelected(lstAccount);
  BasePricePolControllerExtension ext = new BasePricePolControllerExtension(stdSetController);
 Test.stopTest();
 }
}