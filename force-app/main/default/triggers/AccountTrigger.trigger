trigger AccountTrigger on Account (before insert) {
    If (Trigger.isBefore){
        AccountTriggerHandler.beforeInsertAccountHandler(Trigger.new);
    }
}