$(document).ready(function() {
    var totalNum = 0;
    var number = 0.00;
    var totalmissing = 0;
    var percentTotalMissing = 0;
    // dataArray needs to be an Array of Arrays [number, title]
    var dataArray = [];
    // var labelArray = [];
    var chartHeight = 1000;
    var barDataDivisor = 1000000;
    var initialBarColor = "lightgreen";
    var secondaryBarColor = "yellow";

    // This is populating the arrays with data on the contracts
    function assignData(contract) {
        if (!contract.dollar_amt) {
            dataArray.push([0, contract.title]);
            totalmissing++;
        } else {
            dataArray.push([parseInt(contract.dollar_amt), contract.title]);
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
        .attr("height", chartHeight);
    var bars = svgArea.selectAll("rect")
        .data(dataArray)
        .enter()
        .append("svg:rect")
    var barAttr = bars.attr("class", "bar")
        .attr("width", 2)
        .attr("height", function(d){return d[0] / barDataDivisor})
        .style("fill", initialBarColor)
        .attr("y", function(d) {
            return chartHeight - d[0] / barDataDivisor;
        })
        .style("x", function(d,i){return i * 2})
        .on("mouseover", function(){
            return d3.select(this).style("fill", secondaryBarColor)})
        .on("mouseout", function(){
            return d3.select(this).style("fill", initialBarColor)});
    var titles = barAttr.append("svg:title")
        .text(function(d) { return d[1]; });
});
