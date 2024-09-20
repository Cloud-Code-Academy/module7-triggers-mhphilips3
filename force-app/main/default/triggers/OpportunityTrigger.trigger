trigger OpportunityTrigger on Opportunity (before update, before delete) {

    If (Trigger.isbefore && Trigger.isupdate){
        OpportunityTriggerHandler.beforeUpdateOpportunityTrigger(Trigger.new);
    }
    If (Trigger.isbefore && Trigger.isdelete){
        OpportunityTriggerHandler.beforeDeleteOpportunityTrigger(Trigger.old);
    }
}

