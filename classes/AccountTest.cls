@isTest
public class AccountTest {

    @isTest
    static void testCreateDefaultContact() {
        List<Account> testAccounts = new List<Account>();
        for (Integer i = 0; i < 2; i++) {
            Account acc = new Account(
                Name = 'Test Account ' + i,
                Active_Account__c = true,
                Type = 'Customer - Direct'
            );
            testAccounts.add(acc);
        }
        insert testAccounts;

        Test.startTest();
        AccountTriggerHandler.createDefaultContact(testAccounts);
        Test.stopTest();


        List<Contact> createdContacts = [SELECT Id FROM Contact WHERE Primary_Contact__c = true];
        System.assertEquals(testAccounts.size(), createdContacts.size());

        for (Account acc : testAccounts) {
            Contact createdContact = [SELECT Id, AccountId, FirstName, LastName, Primary_Contact__c, Email, Phone
                                      FROM Contact WHERE AccountId = :acc.Id];
            System.assertEquals(acc.Id, createdContact.AccountId);
            System.assertEquals(acc.Name, createdContact.FirstName);
            System.assertEquals('Customer Representative', createdContact.LastName);
            System.assertEquals(true, createdContact.Primary_Contact__c);
            System.assertEquals(acc.Company_Email__c, createdContact.Email);
            System.assertEquals(acc.Phone, createdContact.Phone);
        }
    }
}