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

    JSON.parse($("#contracts_json").html()).forEach(function(contract) {
        assignData(contract);
    });
    var svgArea = d3.select("#d3me")
        .append("svg")
        .attr("width", 100 + "%")
        .attr("height", 1000);
    var bars = svgArea.selectAll("rect")
        .data(dataArray)
        .enter()
        .append("rect")
    var barAttr = bars.attr("class", "bar")
        .attr("width", 2)
        .attr("height", function(d){return d / 1000000})
        .style("fill", "lightgreen")
        .style("x", function(d,i){return i * 2});
});
