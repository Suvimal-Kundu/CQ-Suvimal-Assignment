@isTest
private class AccountTrigger_TGN_TEST{
    @isTest
    private static void run(){
        Database.SaveResult dsr;
        Account drAccount;
        drAccount=new Account();
        dsr=Database.insert(drAccount,false);
        Database.update(drAccount,false);
    }
}