"use strict";
(function(){
    angular
    .module("contracts")
    .controller("ContractShowController", [
        "ContractFactory",
        "$stateParams",
        "$filter",
        ContractShowControllerFunction
    ]);
    function ContractShowControllerFunction(ContractFactory, $stateParams, $filter){
        self = this;
        self.cost = "LOADING";
        self.contract = ContractFactory.get({id: $stateParams.id}, function(response){
            if (!response.dollar_amt) {
                self.cost = "Could not parse a dollar ammount from this record."
            } else {
                self.cost = $filter('currency')(response.dollar_amt, "$", 2);
            }
        });
    }
}());
