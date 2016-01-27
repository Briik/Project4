$(document).ready(function() {
    var totalNum = 0;
    var number = 0.00;
    var totalmissing = 0;
    var percentTotalMissing = 0;
    var dataArray = [];
    var labelArray = [];

    // This is populating the arrays with data on the contracts
    function assignData(contract) {
        labelArray.push(contract.title);
        if (!contract.dollar_amt) {
            dataArray.push(0);
            totalmissing++;
        } else {
            dataArray.push(parseInt(contract.dollar_amt));
            number -= parseFloat(-contract.dollar_amt).toFixed(2);
            totalNum = (number).toLocaleString("currency", "USD");
        }
    };

    d3.select("#d3me").append("svg").attr("width", 50).attr("height", 50)

    JSON.parse($("#contracts_json").html()).forEach(function(contract) {
        assignData(contract);
        d3.select("svg")
            .append("svg")
            .append("rect")
            .attr("class", "bar")
            .attr("width", 2)
            .attr("height", 25)
            .style("fill", "lightgreen");
    });
});
