public with sharing class OpportunityTriggerHandler {
    
            //Question 5 -- Validation on Opportunity Amount
    public static void beforeUpdateOpportunityTrigger(List<Opportunity> oppList) {
        Set<Id> acctIdSet = new Set<Id>();  //develop unique set of AccountIds for Question 7
        for (Opportunity opp : oppList){
            If (!(opp.Amount > 5000)){
                opp.Amount.addError('Opportunity amount must be greater than 5000');
            }
            acctIdSet.add(opp.AccountId); // Fill AccountId Set for Question 7
        }    // End Opportunity Amount Validation process        

            //  Question 7 -- Set Primary Contact on Opportunity Update process        
        Map<Id, Id> accIdToContIdMap = new Map<Id,Id>();  // Map of opps AccountIds to Primary_Contact__c Ids
        List<Contact> contList = new List<Contact>([SELECT Id, Name, AccountId, Title 
                                                    FROM Contact 
                                                    WHERE AccountId 
                                                    IN :acctIdSet 
                                                    AND Title = 'CEO']);
        
        for (Contact cont : contList){  //contList limited to CEOs from related Accounts
            accIdToContIdMap.put(cont.AccountId, cont.Id); 
        }        
        for (Opportunity opp : oppList){    // changes primary contact for only those opps with an account that has a contact with CEO title
            If (opp.AccountId != null && accIdToContIdMap.containsKey(opp.AccountId)){
                opp.Primary_Contact__c = accIdToContIdMap.get(opp.AccountId);    
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
