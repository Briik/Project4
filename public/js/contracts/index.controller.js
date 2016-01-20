"use strict";
(function() {
    angular
        .module("contracts")
        .controller("ContractIndexController", [
            "ContractFactory",
            "$timeout",
            ContractIndexControllerFunction
        ]);

    function ContractIndexControllerFunction(ContractFactory, $timeout) {
        var self = this;
        self.totalNum = "LOADING";
        self.number = 0.00;
        self.totalmissing = 0;
        self.percentTotalMissing = 0;
        self.dataArray = [];
        self.labelArray = [];
        self.selectedElements = [];

        self.showDiv = function($event){
            console.log($event);
        };

        // self.getId = function(label){
        //         self.contracts.filter(function(obj) {
        //             return (obj.title == label)['id'];
        //         });
        // };

        function makeVis(contract){
            var div = document.createElement("div");
            var ds = div.style;
            div.className = "bar";
            ds.width = "2px";
            ds.height = (contract.dollar_amt / 100000) + "px";
            ds.background = "lightgreen";
            ds.margin = "0, auto";
            ds.display = "inline-block";
            d3me.appendChild(div);
        };

        function showInfo(contract){
            alert('it worked! ' + contract.title);
        };

        // This is populating the arrays with data on the contracts, used for Charts.js
        function assignData(contract) {
            self.labelArray.push(contract.title);
            if (!contract.dollar_amt) {
                self.dataArray.push(0);
                self.totalmissing++;
            } else {
                self.dataArray.push(parseInt(contract.dollar_amt));
                self.number -= parseFloat(-contract.dollar_amt).toFixed(2);
                self.totalNum = (self.number).toLocaleString("currency", "USD");
            }
        };

        self.contracts = ContractFactory.query(function(response) {
            var d3me = document.getElementById("d3me");
            d3me.style.background = "black";
            response.forEach(function(contract) {
                assignData(contract);
                makeVis(contract);
                });

            self.percentTotalMissing = ((self.totalmissing / self.contracts.length) * 100).toFixed(1);
        });
        // Charts.js below, it makes a pretty chart but is not great for many datapoints
        // $timeout(function() {
        //     angular.element(document).ready(function() {
        //         var ctx = $("#myChart").get(0).getContext("2d");
        //         Chart.defaults.global.responsive = true;
        //
        //         self.info = {
        //             labels: self.labelArray,
        //             datasets: [{
        //                 label: "Large Defense Contracts By Day",
        //                 fillColor: "rgba(220,220,220,0.2)",
        //                 strokeColor: "rgba(220,220,220,1)",
        //                 pointColor: "rgba(220,220,220,1)",
        //                 pointStrokeColor: "#fff",
        //                 pointHighlightFill: "#fff",
        //                 pointHighlightStroke: "rgba(220,220,220,1)",
        //                 data: self.dataArray,
        //             }]
        //         };
        //
        //         var contractsOverTime = new Chart(ctx).Line(self.info, {
        //             pointHitDetectionRadius: 2,
        //             scaleShowVerticalLines: false
        //         });
        //
        //         self.showDiv = function($event) {
        //             var activePoints = contractsOverTime.getPointsAtEvent($event);
        //             self.selectedElements.splice(0,self.selectedElements.length);
        //             activePoints.forEach(function(contract) {
        //                 self.selectedElements.push(contract)
        //             });
        //             console.log("selectedElements: " + self.selectedElements);
        //         };
        //     })
        // }, 1000);
    }
}());
