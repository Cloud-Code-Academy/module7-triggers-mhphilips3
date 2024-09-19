trigger OpportunityTrigger on Opportunity (before update) {

    OpportunityTriggerHandler.beforeUpdateOpportunityTrigger(Trigger.new);

}