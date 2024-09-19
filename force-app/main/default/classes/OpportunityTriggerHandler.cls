public with sharing class OpportunityTriggerHandler {

    public static void beforeUpdateOpportunityTrigger(List<Opportunity> oppList) {
        for (Opportunity opp : oppList){
            If (!(opp.Amount > 5000)){
                opp.Amount.addError('Opportunity amount must be greater than 5000');
            }
        }
    }
}