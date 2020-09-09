// 리뷰의 평점별 리뷰수를 막대그래프로 표현하자.
	const width = 400;
	const height = 400;
	const margin = {top: 40, left: 40, bottom: 40, right: 40};
	
	const data = [
	    {name: 'A', value: 10, color: '#5487b1'},
	    {name: 'B', value: 29, color: '#63a1af'},
	    {name: 'C', value: 32, color: '#7ab8aa'},
	    {name: 'D', value: 25, color: '#93caa8'},
	    {name: 'E', value: 23, color: '#add7a8'},
	    {name: 'F', value: 15, color: '#c6e3a7'}
	];
	
	const x = d3.scaleBand()
	  .domain(data.map(d => d.name))
	  .range([margin.left, width - margin.right])
	  .padding(0.4);
	
	const y = d3.scaleLinear()
	  .domain([0, d3.max(data, d => d.value)]).nice()
	  .range([height - margin.bottom, margin.top]);
	
	const xAxis = g => g
	  .attr('transform', `translate(0, ${height - margin.bottom})`)
	  .call(d3.axisBottom(x)
	  .tickSizeOuter(0))
	  .call(g => g.select('.domain').remove())
	  .call(g => g.selectAll('line').remove());
	
	const yAxis = g => g
	  .attr('transform', `translate(${margin.left}, 0)`)
	  .call(d3.axisLeft(y))
	  .call(g => g.select('.domain').remove())
	  .call(g => g.selectAll('line').attr('x2', width)
	    							.style('stroke', '#f5f5f5'));
	
	
	const svg = d3.select('#svg-area').append('svg').style('width', width).style('height', height);
	
	svg.append('g').call(xAxis);
	svg.append('g').call(yAxis);
	svg.append('g')
	   .selectAll('rect').data(data).enter().append('rect')
	   .attr('x', d => x(d.name))
	   .attr('y', d => y(d.value))
	   .attr('height', d => y(0) - y(d.value))
	   .attr("rx", 15)
	   .attr('width', x.bandwidth())
	   .attr('fill', d => d.color)
	   .attr('data-x', d => d.name)
	   .attr('data-y', d => d.value)
	   .attr('data-color', d=> d.color);
	
	svg.node();
	
	const rectEl = document.getElementsByTagName('rect');
	const tooltop = document.getElementById('tooltip');
	
	for(const el of rectEl) {
	  el.addEventListener('mouseover', (event) => {
	    const target = event.target;
	    const positionLeft = Number(target.getAttribute('x')) + Number(x.bandwidth()/2) - tooltop.clientWidth/2;
	    const positionTop = height - margin.top - target.getAttribute('height') - tooltop.clientHeight - 5;
	    const color = target.dataset.color;
	    const value = target.dataset.y;
	
	    tooltop.innerText = value;
	    tooltop.style.background = color;
	    tooltop.style.top = positionTop + 'px';
	    tooltop.style.left = positionLeft + 'px';
	    tooltop.style.opacity = 1;
	  });
	}