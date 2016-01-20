"use strict";
(function(){
    angular
    .module("milContracts", [
        "ui.router",
        "contracts"
    ])
    .config([
        "$stateProvider",
        RouterFunction
    ]);
    function RouterFunction($stateProvider){
        $stateProvider
        .state("contractIndex", {
            url: "/contracts",
            templateUrl: "./contracts/index.html",
            controller: "ContractIndexController",
            controllerAs: "ContractIndexViewModel"
        })
        .state("contractShow", {
            url: "/contracts/:id",
            templateUrl: "./contracts/show.html",
            controller: "ContractShowController",
            controllerAs: "ContractShowViewModel"
        });
    }
}());
