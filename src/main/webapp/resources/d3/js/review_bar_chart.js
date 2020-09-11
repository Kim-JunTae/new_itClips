// 리뷰의 평점별 리뷰수를 막대그래프로 표현하자.
	$(document).ready(function(){
		/*var movieId = '${movieId}';
		console.log('${movieId}')
		console.log(movieId)*/
		
		var movieId = document.getElementById('movieId').value;
		
		$.ajax({
			url: "getChartData",
			type: "GET",
			dataType: "JSON",
			data: "movieId="+encodeURIComponent(movieId)
			
		}).done(function(data){
			console.log(data);
			
			const width = 400;
			const height = 400;
			const margin = {top: 40, left: 40, bottom: 40, right: 40};
			
			const x = d3.scaleBand()
			  // .scaleBand() 그래프의 막대의 반복되는 범위를 정해줍니다..domain(data.map(d => d.grade)).domain(d3.extent(data, d => d.grade))	
			  .domain(data.map(d => d.grade))		  
			  // .domain() 각각의 막대에 순서대로 막대에 매핑합니다.
			  .range([margin.left, width - margin.right])
			  // 시작위치와 끝 위치로 눈금의 범위를 지정합니다.
			  .padding(0.4);
			  // 막대의 여백을 설정합니다.
			 
			// line chart와 동일
			const y = d3.scaleLinear()
			  .domain([0, d3.max(data, d => d.value)]).nice()
			  .range([height - margin.bottom, margin.top]);
			 
			// line chart와 동일
			const xAxis = g => g
			  .attr('transform', `translate(0, ${height - margin.bottom})`)
			  .call(d3.axisBottom(x)
			    .tickSizeOuter(0))
			  .call(g => g.select('.domain').remove())
			  .call(g => g.selectAll('line').remove());
			 
			// line chart와 동일
			const yAxis = g => g
			  .attr('transform', `translate(${margin.left}, 0)`)
			  .call(d3.axisLeft(y))
			  .call(g => g.select('.domain').remove())
			  .call(g => g.selectAll('line')
    		  .attr('x2', width)
    		  .style('stroke', '#f5f5f5'));

			// line chart와 동일
			const svg = d3.select('#chart')
			              .append('svg').style('width', width).style('height', height);
			 
			svg.append('g').call(xAxis);
			svg.append('g').call(yAxis);
			svg.append('g')
			  .selectAll('rect').data(data).enter().append('rect')
			  .attr('x', d => x(d.grade))
			  .attr('y', d => y(d.value))
			  .attr('height', d => y(0) - y(d.value))
			  .attr("rx", 15)
			  .attr('width', x.bandwidth())
			  .attr('fill', d => d.color)
			  .attr('data-x', d => d.grade)
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
		}).fail(function(err){
			console.log(err);
		});

		$.ajax({
			url: "getAvg",
			type: "GET",
			dataType: "JSON",
			data: "movieId="+encodeURIComponent(movieId)
	
		}).done(function(data){
			console.log(data);
			var abf = data.AvgBeforeFilter.substring(0,4);
			var aaf = data.AvgAfterFilter.substring(0,4);
			var cr = String(((abf-aaf)/abf)*100).substring(0,4);
			$('#AvgBefore').append(abf);
			$('#AvgAfter').append(aaf);
			$('#ChangeRate').append(cr);
			/*$('#AvgBefore').val(data.AvgBeforeFilter);
			$('#AvgAfter').val(data.AvgAfterFilter);*/
		});
		
	});
	
	