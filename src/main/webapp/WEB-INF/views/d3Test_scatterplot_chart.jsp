<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>D3 Scatterplot with Regression Line</title>
<style>
	.line {
	    stroke: #E4002B;
	    fill: none;
	    stroke-width: 3;
	}
	
	.axis path,
	.axis line {
	    fill: none;
	    stroke: black;
	    shape-rendering: crispEdges;
	}
	
	.axis text {
	    font-size: 10px;
	    font-family: sans-serif;
	}
	
	.text-label {
	    font-size: 10px;
	    font-family: sans-serif;
	}
	
	.dot {
	    stroke: #293b47;
	    fill: #7A99AC
	}
</style>
</head>
<body>
  <div id="my_dataviz"></div>
  <script src="//cdnjs.cloudflare.com/ajax/libs/d3/3.5.6/d3.min.js"></script>
	<script>
	
	var margin = {
	        top: 20,
	        right: 20,
	        bottom: 30,
	        left: 40
	    },
	    width = 960 - margin.left - margin.right,
	    height = 500 - margin.top - margin.bottom;
	
	var x = d3.scale.linear()
	    .range([0, width]);
	
	var y = d3.scale.linear()
	    .range([height, 0]);
	
	var xAxis = d3.svg.axis()
	    .scale(x)
	    .orient("bottom");
	
	var yAxis = d3.svg.axis()
	    .scale(y)
	    .orient("left");
	
	var svg = d3.select("body").append("svg")
	    .attr("width", width + margin.left + margin.right)
	    .attr("height", height + margin.top + margin.bottom)
	    .append("g")
	    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");
	
	//var data = create_data(1000);
	/* const data = [
	    {title:'강철비2', y: 451318, x: 7400},
	    {title:'엑시트', y: 1429993, x: 14000},
	    {title:'오케이마담', y: 1715922, x: 19000},
	    {title:'살아있다', y: 1493632, x: 20000},
	    {title:'다만 악에서 구하소서', y: 378185, x: 5400},
	    {title:'정직한 후보', y: 2109377, x: 25000},
	    {title:'시동', y: 4644813, x: 32000},
	    {title:'포드v페라리', y: 546968, x: 6400},
	    {title:'반도', y: 2660216, x: 22000},
	    {title:'신의 한수', y: 1209246, x: 10000},
	    {title:'제미니맨', y: 346966, x: 4200},
	    {title:'봉오동 전투', y: 799353, x: 9300},
	    {title:'나랏말싸미', y: 220476, x: 3500},
	    {title:'테넷', y: 135212, x: 2900},
	    {title:'돈', y: 2252357, x: 14000},
	    {title:'가장보통의연애', y: 971983, x: 6600},
	    {title:'지푸라기라도잡고싶은짐승들', y: 605050, x: 4900},
	    {title:'결백', y: 445131, x: 6500}  
	]; */
	
	const data = [
		{y: 451318, x: 7400},
	    {y: 1429993, x: 14000},
	    {y: 1715922, x: 19000},
	    {y: 1493632, x: 20000},
	    {y: 378185, x: 5400}
	];
	
	data.forEach(function(d) {
	    d.x = +d.x;
	    d.y = +d.y;
	    d.yhat = +d.yhat;
	});
	
	var line = d3.svg.line()
	    .x(function(d) {
	        return x(d.x);
	    })
	    .y(function(d) {
	        return y(d.yhat);
	    });
	
	x.domain(d3.extent(data, function(d) {
	    return d.x;
	}));
	y.domain(d3.extent(data, function(d) {
	    return d.y;
	}));
	
	svg.append("g")
	    .attr("class", "x axis")
	    .attr("transform", "translate(0," + height + ")")
	    .call(xAxis)
	    .append("text")
	    .attr("class", "label")
	    .attr("x", width)
	    .attr("y", -6)
	    .style("text-anchor", "end")
	    .text("X-Value");
	
	svg.append("g")
	    .attr("class", "y axis")
	    .call(yAxis)
	    .append("text")
	    .attr("class", "label")
	    .attr("transform", "rotate(-90)")
	    .attr("y", 6)
	    .attr("dy", ".71em")
	    .style("text-anchor", "end")
	    .text("Y-Value")
	
	svg.selectAll(".dot")
	    .data(data)
	    .enter().append("circle")
	    .attr("class", "dot")
	    .attr("r", 3.5)
	    .attr("cx", function(d) {
	        return x(d.x);
	    })
	    .attr("cy", function(d) {
	        return y(d.y);
	    });
	
	svg.append("path")
	    .datum(data)
	    .attr("class", "line")
	    .attr("d", line);
	
	
	
	function create_data(nsamples) {
	    var x = [];
	    var y = [];
	    var n = nsamples;
	    var x_mean = 0;
	    var y_mean = 0;
	    var term1 = 0;
	    var term2 = 0;
	    var noise_factor = 100;
	    var noise = 0;
	    // create x and y values
	    for (var i = 0; i < n; i++) {
	        noise = noise_factor * Math.random();
	        noise *= Math.round(Math.random()) == 1 ? 1 : -1;
	        y.push(i / 5 + noise);
	        x.push(i + 1);
	        x_mean += x[i]
	        y_mean += y[i]
	    }
	    // calculate mean x and y
	    x_mean /= n;
	    y_mean /= n;
	
	    // calculate coefficients
	    var xr = 0;
	    var yr = 0;
	    for (i = 0; i < x.length; i++) {
	        xr = x[i] - x_mean;
	        yr = y[i] - y_mean;
	        term1 += xr * yr;
	        term2 += xr * xr;
	
	    }
	    var b1 = term1 / term2;
	    var b0 = y_mean - (b1 * x_mean);
	    // perform regression 
	
	    yhat = [];
	    // fit line using coeffs
	    for (i = 0; i < x.length; i++) {
	        yhat.push(b0 + (x[i] * b1));
	    }
	
	    var data = [];
	    for (i = 0; i < y.length; i++) {
	        data.push({
	            "yhat": yhat[i],
	            "y": y[i],
	            "x": x[i]
	        })
	    }
	    return (data);
	}
	</script>
</body>
</html>