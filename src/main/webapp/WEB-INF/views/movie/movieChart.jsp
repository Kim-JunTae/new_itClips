<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화관련 Youtube Chart 분석(scatter plot)</title>
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<link rel="stylesheet" href="/resources/user/assets/css/main.css"/>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://d3js.org/d3.v5.min.js"></script>
<!-- 참고 사이트 : https://dgkim5360.tistory.com/entry/c3-js-cheat-sheet 
                https://www.d3-graph-gallery.com/index.html -->
<script type="text/javascript">
	<!--검색-->
	function getMovieList(){
		
		if(!$("#keyword").val()){
			alert("영화명을 입력하세요");
			return false;
		}
		
		searchForm.submit();
	}
</script>

<style>
/* 그래프 관련 css */
/* body {
  font: 11px sans-serif;
} */
.line {
    stroke: #E4002B;
    fill: none;
    stroke-width: 3;
}

.axis path,
.axis line {
  fill: none;
  stroke: #000;
  shape-rendering: crispEdges;
}

.dot {
  stroke: #000;
}

.tooltip {
  position: absolute;
  width: 200px;
  height: 28px;
  pointer-events: none;
}
</style>
</head>
<body>
<!-- Wrapper -->
		<div id="wrapper">
		
			Main
				<div id="main">
					<div class="inner">
					<!-- Header -->
							<header id="header">
								<a href="/userHome" class="logo"><strong><span>itClips</span></strong></a>
								<!-- NAV : 영화 목록 보기(three.js), 영화 분석 페이지 -->
								<input type="button" style="flex: 0.1;" value="무비 포스터로!" onclick="location.href='/movie/moviePoster'">
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="button" style="flex: 0.1;" value="전체 영화 관련 YouTube 분석" onclick="location.href='/movie/movieChart'">
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<form id="searchForm" method="get" action="/movie/movieList">
									  <input type="text" name="keyword" class="form-control" placeholder="영화 분석 페이지로">
								</form>
								<input type="button" style="flex: 0.1;" id="analysis" value="search" onclick="getMovieList()">
							</header>
						
						<section id="banner">
							<div class="content">
								<h2>전체 영화 분석</h2><br>
								<p>현 문제점(해결과제) : 툴팁 위치, 데이터 추가, y축, x축 변동 움직임</p>
								<div id="my_dataviz"></div>
							</div>
						</section>
					</div>
				</div>
		</div>
		
		<!-- Scripts -->
		<script src="/resources/user/assets/js/browser.min.js"></script>
		<script src="/resources/user/assets/js/breakpoints.min.js"></script>
		<script src="/resources/user/assets/js/util.js"></script>
		<script src="/resources/user/assets/js/main.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>			 
		<!-- <script src="/resources/user/js/sidebar.js"></script> -->
<script>
//데이터 : YouTube 채널 [지무비 : G Moive]
	const youtubeData = [
		    {title:'강철비2', viewCount: 451318, like: 7400},
		    {title:'엑시트', viewCount: 1429993, like: 14000},
		    {title:'오케이마담', viewCount: 1715922, like: 19000},
		    {title:'살아있다', viewCount: 1493632, like: 20000},
		    {title:'다만 악에서 구하소서', viewCount: 378185, like: 5400},
		    {title:'정직한 후보', viewCount: 2109377, like: 25000},
		    {title:'시동', viewCount: 4644813, like: 32000},
		    {title:'포드v페라리', viewCount: 546968, like: 6400},
		    {title:'반도', viewCount: 2660216, like: 22000},
		    {title:'신의 한수', viewCount: 1209246, like: 10000},
		    {title:'제미니맨', viewCount: 346966, like: 4200},
		    {title:'봉오동 전투', viewCount: 799353, like: 9300},
		    {title:'나랏말싸미', viewCount: 220476, like: 3500},
		    {title:'테넷', viewCount: 135212, like: 2900},
		    {title:'돈', viewCount: 2252357, like: 14000},
		    {title:'가장보통의연애', viewCount: 971983, like: 6600},
		    {title:'지푸라기라도잡고싶은짐승들', viewCount: 605050, like: 4900},
		    {title:'결백', viewCount: 445131, like: 6500}  
	];

	var margin = {top: 10, right: 30, bottom: 40, left: 50},
    width = 520 - margin.left - margin.right,
    height = 520 - margin.top - margin.bottom;
	
	// append the svg object to the body of the page
	var svg = d3.select("#my_dataviz")
				.append("svg")
				  .attr("width", width + margin.left + margin.right)
				  .attr("height", height + margin.top + margin.bottom)
				 .append("g")
				  .attr("transform",
				        "translate(" + margin.left + "," + margin.top + ")");


	// Add X axis
	var x = d3.scaleLinear()
	    	  .domain([0, d3.max(youtubeData, d => d.like)])
	    	  .range([ 0, width]);
	
	svg.append("g")
	   .attr("transform", "translate(0," + height + ")")
	   .call(d3.axisBottom(x));

	// Add Y axis
	var y = d3.scaleLinear()
	  		  .domain([0, d3.max(youtubeData, d => d.viewCount)])
	  		  .range([ height, 0]);
	
	svg.append("g")
	   .call(d3.axisLeft(y));
 	
	
	// Add a tooltip div. Here I define the general feature of the tooltip: stuff that do not depend on the data point.
	// Its opacity is set to 0: we don't see it by default.
	 var tooltip = d3.select("#my_dataviz")
				     .append("div")
				     .style("opacity", 0)
				     .attr("class", "tooltip")
				     .style("background-color", "white")
				     .style("border", "solid")
				     .style("border-width", "1px")
				     .style("border-radius", "5px")
				     .style("padding", "10px")
	
	var mouseover = function(d) {tooltip.style("opacity", 1)}
	
	
	var mousemove = function(d) {
		    	    	tooltip
					      .html("Title: " + d.title)
					      .style("left", (d3.mouse(this)[0]+90) + "px") // It is important to put the +90: other wise the tooltip is exactly where the point is an it creates a weird effect
					      .style("top", (d3.mouse(this)[1]-50) + "px")
		  			}
	
	var mouseleave = function(d) {
					 	tooltip
					      .transition()
					      .duration(200)
					      .style("opacity", 0)
					 }
	
	// Add dots
	svg.append('g')
	  .selectAll("dot")
	  .data(youtubeData)
	  .enter()
	  .append("circle")
	    .attr("cx", function (d) { return x(d.like); } )
	    .attr("cy", function (d) { return y(d.viewCount); } )
	    .attr("r", 7)
	    .style("fill", "#69b3a2")
	    .style("opacity", 0.6)
	    .style("stroke", "white")
	  .on("mouseover", mouseover )
      .on("mousemove", mousemove )
      .on("mouseleave", mouseleave );
	
	var yMax = d3.max(youtubeData, d => d.viewCount);
	var xMax = d3.max(youtubeData, d => d.like);
	
	console.log(yMax);
	console.log(xMax);
	
	var yAvg = (d3.sum(youtubeData, d => d.viewCount))/youtubeData.length;
	var xAvg = (d3.sum(youtubeData, d => d.like))/youtubeData.length;
	
	console.log(yAvg);
	console.log(xAvg);
	
	
	
</script>
<script type="text/javascript">
//전체 평균 선 그리기 Regression

svg.append("svg:line")
   .style("stroke", "black")
   .attr("x1", 0)
   .attr("y1", yAvg)
   .attr("x2", xAvg)
   .attr("y2", 1000);
</script>
</body>
</html>