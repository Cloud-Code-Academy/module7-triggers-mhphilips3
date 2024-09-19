public with sharing class AccountTriggerHandler {


    public static void beforeInsertAccountHandler(List<Account> newAccounts) {
        for (Account acct : newAccounts){
            if (String.isBlank(acct.Type)){     //Question 1
                acct.Type = 'Prospect';
            } 
            if (!String.isBlank(acct.ShippingStreet) &&
                !String.isBlank(acct.ShippingCity) &&
                !String.isBlank(acct.ShippingState) &&
                !String.isBlank(acct.ShippingPostalCode) &&
                !String.isBlank(acct.ShippingCountry)){

                acct.BillingStreet = acct.ShippingStreet;
                acct.BillingCity = acct.ShippingCity;
                acct.BillingState = acct.ShippingState;
                acct.BillingPostalCode = acct.ShippingPostalCode;
                acct.BillingCountry = acct.ShippingCountry;
            }           
        }
    }
}