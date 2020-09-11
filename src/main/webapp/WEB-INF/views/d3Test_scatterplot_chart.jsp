<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>D3-Test : Chart example</title>
  <script src="https://d3js.org/d3.v5.min.js?v=<%=System.currentTimeMillis() %>"></script>
  <!-- API문서 : https://github.com/zziuni/d3/wiki/API-Reference -->
  <!-- <script src="/resources/d3/js/scatterplot-chart.js"></script>-->
  <script type="text/javascript">
  
	  const svg = d3.select('#myDiv').svg(width, height);
	  
	  // define circle attributes
	  var circleAttrs = {
	          cx: d => xScale_scatter(d[xaxis]),
	          cy: d => yScale_scatter(d[yaxis]),
	          r: 5,
	          fill: d => colorScale(d.species),
	          stroke: d => colorScale(d.species),
	          width: 2,
	          strokeOpacity: 0.7,
	          fillOpacity: 1
	      };
	  
	  svg.append("g")
	    svg.selectAll("circle")
	    .data(iris)
	    .join("circle")
	      .attr("cx", circleAttrs.cx)
	      .attr("cy", circleAttrs.cy)
	      .attr("r", circleAttrs.r)
	      .attr('fill', circleAttrs.fill)
	      .attr('opacity', circleAttrs.fillOpacity)
	      .attr('stroke', circleAttrs.stroke)
	      .attr("stroke-width", circleAttrs.width)
	      //.attr("stroke-opacity", circleAttrs.strokeOpacity)
	      /*
	      .attr("fill", "none")
	      .attr("stroke", d => colorScale(d.species))
	      .attr("stroke-width", 2)
	      .attr("stroke-opacity", 0.7)
	      */
	      .on('mouseover', handleMouseOver)
	      .on('mouseout', handleMouseOut)
	  
	  // x axis
	    var xAxis = d3.axisBottom();
	    xAxis.scale(xScale_scatter)
	    svg.append("g")
	      .attr("transform", `translate(0, ${height- margin.bottom})`)
	      .style("font", "bold 12px sans-serif")
	      .call(xAxis)
	  // x axis label
	  svg.append("text")             
	      .attr("transform", `translate(${width/2}, ${height- margin.bottom+40})`)
	      .style("text-anchor", "middle")
	      .style("font", "bold 15px sans-serif")
	      .text(xaxis);
	  
	  // y axis
	  var yAxis = d3.axisLeft();
	    yAxis.scale(yScale_scatter)
	    svg.append("g")
	      .attr("transform", `translate(${margin.left}, 0)`)
	      .style("font", "bold 12px sans-serif")
	      .call(yAxis)
	  // y axis label
	  svg.append("text")
	      .attr("transform", `translate(${margin.left-35}, ${(height- margin.bottom)/2+25})rotate(-90)`)
	      .style("text-anchor", "middle")
	      .style("font", "bold 15px sans-serif")
	      .text(yaxis);
	  
	  // function to handle mouseover event
	  function handleMouseOver(d, i) {
	    console.log(d,i)
	    console.log(this)
	    d3.select(this)//.transition()
	      //.duration(10)
	      .attr("fill", d => colorScale(d.species))
	      .attr("stroke-width", 5)
	    svg.append("text")
	      .attr('x', this.getAttribute('cx'))
	      .attr('y', this.getAttribute('cy'))
	      .attr('id', 'tooltip')
	      .style("font", "bold 15px sans-serif")
	      .text(`(${d.sepal_length}, ${d.sepal_width})`)
	    }
	  
	  function handleMouseOut(d, i) {
	    d3.select(this).transition()
	          .attr('fill', circleAttrs.fill)
	          .attr("stroke-width", circleAttrs.width)
	    svg.select('#tooltip').remove()
	  }
	  
	  svg.node();
		
  </script>
</head>
<body>
	<div id='myDiv'></div>
</body>
</html>