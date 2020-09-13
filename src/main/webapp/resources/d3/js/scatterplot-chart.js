//scatterplot-chart.js
//데이터 예시
	const data = [
		    {title:'강철비2', viewCount: 4159, like: 323},
		    {title:'기생충', viewCount: 3498, like: 170},
		    {title:'남산의 부장들', viewCount: 19837, like: 485},
		    {title:'터미네이터 다크페이트', viewCount: 18682, like: 259},
		    {title:'다만 악에서 구하소서', viewCount: 47713, like: 1075},
		    {title:'포드vs페라리', viewCount: 18737, like: 661},
		    {title:'반도', viewCount: 15060, like: 202},
		    {title:'82년생 김지영', viewCount: 10313, like: 233},
		    {title:'가장 보통의 연애', viewCount: 9243, like: 76},
		    {title:'나이브스 아웃', viewCount: 9176, like: 332},
		    {title:'메멘토', viewCount: 1804, like: 13}
	];

	const width = 500;
	const height = 500;
	const padding = 20;
	
	var yMax = d3.max(data, d => d.viewCount);
	var yMin = d3.min(data, 0);
	var yScale = d3.scaleLinear()
				   .domain([yMin, yMax])
				   .range([height - padding, padding]);
	
	var xScale = d3.scaleLinear()
				   .domain(d3.extent(data, d => data.like))
				   .range([padding, width - padding]);
	
	const svg = d3.select('body')
				  .attr("width", width)
				  .attr("height", height)
				  .selectAll("circle")
				  .data(data)
				  .enter()
				  .append("circle")
				  .attr("cx", d => xScale(d.like))
				  .attr("cy", d => yScale(d.viewCount))
				  .atrr("r", 5);
		
	svg.node();