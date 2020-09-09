// line-chart.js
	//그려질 차트의 너비, 높이, 여백값, 그래프를 그릴 데이터
	const width = 500;
	const height = 500;
	const margin = {top: 40, right: 40, bottom: 40, left: 40};
	
	const data = [
	  {date: new Date('2020-01-01'), value: 10},
	  {date: new Date('2020-02-01'), value: 20},
	  {date: new Date('2020-03-01'), value: 30},
	  {date: new Date('2020-04-01'), value: 25},
	  {date: new Date('2020-05-01'), value: 35},
	  {date: new Date('2020-06-01'), value: 45},
	  {date: new Date('2020-07-01'), value: 60},
	  {date: new Date('2020-08-01'), value: 50}
	];
	
	//x축으로 사용될 값 설정
	//scaleTime() : 데이터 값을 시간으로 변경 (create a linear scale for time)
	//extent() : 데이터 값 중 가장 작은 값과 큰 값을 배열로 응답 (compute the minimum and maximum value in an iterable)
	//domain() : 
	//range() : 숫자 범위로 변환(generate a range of numeric values)
	const x = d3.scaleTime()
	  .domain(d3.extent(data, d => d.date))
	  .range([margin.left, width - margin.right]);
	
	//scaleLinear() : 정량적 선형 척도 생성 (create a quantitative linear scale)
	const y = d3.scaleLinear()
	  .domain([0, d3.max(data, d => d.value)]).nice()
	  .range([height - margin.bottom, margin.top]);
	
	//x축 y축 구성
	// attr() : 속성 얻거나 설정 (get or set an attribute)
	const xAxis = g => g
	  .attr("transform", `translate(0,${height - margin.bottom})`)
	  .call(d3.axisBottom(x).ticks(width / 90).tickSizeOuter(0));
	 
	const yAxis = g => g
	  .attr("transform", `translate(${margin.left},0)`)
	  .call(d3.axisLeft(y))
	  .call(g => g.select(".domain").remove())
	  .call(g => {
	    return g.select(".tick:last-of-type text").clone()
	      .attr("x", 3)
	      .attr("text-anchor", "start")
	      .attr("font-weight", "bold")
	      .attr("font-size", '20px')
	      .text('Y축')
	    });
	
	//line() : 라인 생성!(create a new line generator)
	//defined(d => !isNaN(d.value)) : 값이 숫자가 아니면 선이 끈겨서 출력
	const line = d3.line()
	  .defined(d => !isNaN(d.value))
	  .x(d => x(d.date))
	  .y(d => y(d.value));
	 
	const svg = d3.select('body').append('svg').style('width', width).style('height', height);
	svg.append("path")
	  .datum(data)
	  .attr("fill", "none")
	  .attr("stroke", "steelblue")
	  .attr("stroke-width", 1)
	  .attr("stroke-linejoin", "round")
	  .attr("stroke-linecap", "round")
	  .attr("d", line);
	svg.append('g').call(xAxis);
	svg.append('g').call(yAxis);
	
	svg.node();