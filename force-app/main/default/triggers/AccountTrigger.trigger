trigger AccountTrigger on Account (before insert, after insert) {
    
    If (Trigger.isBefore && Trigger.isInsert){
        AccountTriggerHandler.beforeInsertAccountHandler(Trigger.new);
    }
    If (Trigger.isafter && Trigger.isInsert){
        AccountTriggerHandler.afterInsertAccountHandler(Trigger.new);
    }
}