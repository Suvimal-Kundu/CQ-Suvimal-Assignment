trigger AccountTrigger on Account (before insert,After Insert,After Update) {
    if(trigger.isAfter & (trigger.isinsert ||trigger.isupdate)){
      AccountTriggerHandler.createDefaultContact(Trigger.new);
    }

}