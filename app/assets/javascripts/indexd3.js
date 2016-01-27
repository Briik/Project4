$(document).ready(function(){
    var contractsJSON = $("#contracts_json").html();
    var response = JSON.parse(contractsJSON);
    var totalNum = 0;
    var numMising = 0;

    d3.select("#d3me").append("svg").attr("width", 50).attr("height", 50)

    response.forEach(function(contract){
        totalNum++;
        if (!contract.dollar_amt) {
            numMising++;
        };
            $("#numMising").innerText = String(numMising);
        d3.select("svg").append("svg").append("rect").attr("width", 2).attr("class", "bar").attr("height", (contract.dollar_amt / 1000000));
    });
});
