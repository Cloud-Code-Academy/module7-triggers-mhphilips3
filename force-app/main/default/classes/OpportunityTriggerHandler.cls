public with sharing class OpportunityTriggerHandler {
    //Question 5
    public static void beforeUpdateOpportunityTrigger(List<Opportunity> oppList) {
        for (Opportunity opp : oppList){
            If (!(opp.Amount > 5000)){
                opp.Amount.addError('Opportunity amount must be greater than 5000');
            }
        }
    }
    //Question 6
    public static void beforeDeleteOpportunityTrigger(List<Opportunity> oppList) {
        Set<Id> acctIdSet = new Set<Id>();
        for(Opportunity opp : oppList){
            acctIdSet.add(opp.AccountId);
        }
        Map<Id, Account> acctMap = new Map<Id, Account>([SELECT Id, Industry FROM Account WHERE Id IN :acctIdSet]);
        for (Opportunity opp : oppList){
            If(opp.AccountId == null){
                continue;
            } 
            If (opp.StageName == 'Closed Won' && acctMap.get(opp.AccountId).Industry == 'Banking'){
                opp.addError('Cannot delete closed opportunity for a banking account that is won');
            }
        }
    }
}