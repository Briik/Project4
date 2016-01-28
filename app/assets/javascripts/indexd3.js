// This .js provides the d3 functionality for the index page.
// It builds the bar chart and places the missing number of days on the page.
// Should not interfere with other pages -  uses jQuery id DOM selectors.
$(document).ready(function() {
    // var totalNum = 0;
    // var number = 0.00;
    var totalmissing = 0;
    var percentTotalMissing = 0;
    // dataArray is an Array of Arrays [number, title]
    var dataArray = [];
    var chartHeight = 300;
    var barDataDivisor = 100000;
    var initialBarColor = "lightgreen";
    var secondaryBarColor = "red";

    // This is populating the arrays with data on the contracts
    function assignData(contract) {

        if (!contract.dollar_amt) {
            dataArray.push([0, contract.title]);
            totalmissing++;
        } else {
            dataArray.push([parseInt(contract.dollar_amt), contract.title]);
            // number -= parseFloat(-contract.dollar_amt).toFixed(2);
            // totalNum = (number).toLocaleString("currency", "USD");
        }
    };

    var contracts = JSON.parse($("#contracts_json").html());
    contracts.forEach(function(contract) {
        assignData(contract);
    });

    var tooltip = d3.select("body")
        .append("div")
        .style("position", "absolute")
        .style("z-index", "10")
        .style("visibility", "hidden")
        .text("a simple tooltip");

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
        .attr("height", function(d){return Math.sqrt(d[0] / barDataDivisor)})
        .style("fill", initialBarColor)
        .attr("y", function(d) {
            return chartHeight - Math.sqrt(d[0] / barDataDivisor);
        })
        .style("x", function(d,i){return i * 2});

    var titles = barAttr.append("svg:title")
        .text(function(d) { return d[1]; });

    // var linkToPage = barAttr.append("svg:a")
    //     .attr("xlink:href", function(d){
    //         $.each(contracts, function(i,data){
    //             // console.log(d[1]);
    //             if (data.title == d[1]) {
    //                 return "localhost:3000/contracts/" + data.id + "";
    //             }
    //         });
    //     });

    var barTooltips = bars
        .on("mouseover", function(){
            // console.log(d3.select(this)[0]);
            var targetHtml = d3.select(this)[0][0].textContent;
            d3.select(this).style("fill", secondaryBarColor);
            tooltip.text(targetHtml)
                .style("visibility", "visible")
                .style("background", "rgba(0, 0, 0, 0.4)");})
        .on("mousemove", function(){
            return tooltip.style("top",
(d3.event.pageY-10)+"px").style("left",(d3.event.pageX+10)+"px");})
        .on("mouseout", function(){
            d3.select(this).style("fill", initialBarColor);
            tooltip.style("visibility", "hidden");
        })
        .on("click", function(data){
            var uri = "";
            contracts.forEach(function(contract){
                    if (contract.title === data[1]) {
                        uri = "contracts/" + contract.id;
                    };
                });
            window.location = uri;
        });

    $('#numMissing').text(function(){
        percentTotalMissing = ((totalmissing / dataArray.length) * 100).toFixed(2) + "%";
        return "Records for " + totalmissing + " days are missing dollar values. Roughly " + percentTotalMissing;
    });
});
