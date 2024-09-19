public with sharing class AccountTriggerHandler {


    public static void beforeInsertAccountHandler(List<Account> newAccounts) {
        for (Account acct : newAccounts){
            if (String.isBlank(acct.Type)){     //Question 1
                acct.Type = 'Prospect';
            } 
            if (!String.isBlank(acct.ShippingStreet) &&  // Question 2
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
            if (acct.Phone !=null && acct.Website != null && acct.Fax != null){ // Question 3
                acct.Rating = 'Hot';
            }           
        }
    }
    //Question 4
    public static void afterInsertAccountHandler(List<Account> newAccounts) {
        List<Contact> contactList = new List<Contact>();
        for (Account acct : newAccounts){
            Contact cont = new Contact(
                LastName = 'DefaultContact',
                Email = 'default@email.com',
                AccountId = acct.Id);
            contactList.add(cont);
        }
    insert contactList;
    }
}