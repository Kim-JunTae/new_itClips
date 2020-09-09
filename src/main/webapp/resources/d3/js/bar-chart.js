//bar-chart.js
	const width = 500;
	const height = 500;
	const margin = {top: 40, left: 40, bottom: 40, right: 40};
	
	const data = [
	    {name: 'a', value: 10},
	    {name: 'b', value: 29},
	    {name: 'c', value: 32},
	    {name: 'd', value: 25},
	    {name: 'e', value: 23},
	    {name: 'f', value: 15}
	  ];
	 
	const x = d3.scaleBand()
	  // .scaleBand() 그래프의 막대의 반복되는 범위를 정해줍니다.
	  .domain(data.map(d => d.name))
	  // .domain() 각각의 막대에 순서대로 막대에 매핑합니다.
	  .range([margin.left, width - margin.right])
	  // 시작위치와 끝 위치로 눈금의 범위를 지정합니다.
	  .padding(0.2);
	  // 막대의 여백을 설정합니다.
	 
	// line chart와 동일
	const y = d3.scaleLinear()
	  .domain([0, d3.max(data, d => d.value)]).nice()
	    .range([height - margin.bottom, margin.top]);
	 
	// line chart와 동일
	const xAxis = g => g
	  .attr('transform', `translate(0, ${height - margin.bottom})`)
	  .call(d3.axisBottom(x)
	    .tickSizeOuter(0));
	 
	// line chart와 동일
	const yAxis = g => g
	  .attr('transform', `translate(${margin.left}, 0)`)
	  .call(d3.axisLeft(y))
	  .call(g => g.select('.domain').remove());
	 
	// line chart와 동일
	const svg = d3.select('body').append('svg').style('width', width).style('height', height);
	 
	svg.append('g').call(xAxis);
	svg.append('g').call(yAxis);
	svg.append('g')
	  .attr('fill', 'steelblue')
	  .selectAll('rect').data(data).enter().append('rect')
	  .attr('x', d => x(d.name))
	  .attr('y', d => y(d.value))
	  .attr('height', d => y(0) - y(d.value))
	  .attr('width', x.bandwidth());
	svg.node();