"use strict";
(function(){
    angular
    .module("contracts")
    .factory("ContractFactory", [
        "$resource",
        ContractFactoryFunction
    ]);
    function ContractFactoryFunction($resource){
        return $resource( "http://localhost:3000/json/:id" );
    };
}());
