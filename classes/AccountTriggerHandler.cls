public class AccountTriggerHandler {
    
   public static void createDefaultContact(list<Account>newAccount){
       Set<Id> AccountId = new set<Id> ();
       list<Contact> newcon =new list<Contact> ();
       for(Account Acc :newAccount){
           if(Acc.Active_Account__c==True && Acc.CreatedById !=null){
             AccountId.add(Acc.Id);
           }
       }
       list<Account>Acclist =[select Id ,Name ,Active_Account__c,Type,Company_Email__c,Phone,
                              (select Id,AccountId,Name,Primary_Contact__c from Contacts where Primary_Contact__c =True)from Account WHERE id IN:AccountId ];
       For(Account acc:AcclIst){
           if(acc.Contacts.size()==0 && acc.Active_Account__c==True 
              &&acc.Type == 'Customer - Direct'||acc.Type =='Customer - Channel'){
               Contact con = new Contact();
               con.AccountId =acc.Id;
               con.FirstName =acc.Name;
               con.LastName = 'Customer Representative';
               con.Primary_Contact__c =True ;
               con.Email=acc.Company_Email__c;
               con.Phone =acc.Phone;
               newcon.add(con);
               
           }
       }
       if(!newcon.isEmpty()){
           Insert newcon;
       }
        
        
    }

}