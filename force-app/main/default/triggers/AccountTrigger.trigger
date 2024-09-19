trigger AccountTrigger on Account (before insert) {
    If (Trigger.isBefore && Trigger.isInsert){
        AccountTriggerHandler.beforeInsertAccountHandler(Trigger.new);
    }
}