<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화관련 Youtube Chart 분석(scatter plot)</title>
  <!-- 참고 사이트 : https://dgkim5360.tistory.com/entry/c3-js-cheat-sheet -->
  <!-- stylesheet -->     
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/c3/0.4.11/c3.min.css"/>  
  <!-- javascript -->     
  <script src="https://d3js.org/d3.v3.min.js"></script>     
  <script src="https://cdnjs.cloudflare.com/ajax/libs/c3/0.4.11/c3.min.js"></script>
  <!-- <script src="https://d3js.org/d3.v5.min.js"></script>
  <script src="/resources/d3/js/scatterplot-chart.js"></script> -->
</head>
<body>
	<h1>예제 실험 중</h1>
	<div id="scatterplot"></div>
	<div id="bubblechart"></div>

	<script type="text/javascript">
	var chart = c3.generate({
		bindto: "#scatterplot",
	  data: {
	    xs: {
	      setosa: 'setosa_x',
	      versicolor: 'versicolor_x',
	    },
	    // iris data from R
	    columns: [
	      ["setosa_x", 3.5, 3.0, 3.2, 3.1, 3.6, 3.9, 3.4, 3.4, 2.9, 3.1, 3.7, 3.4, 3.0, 3.0, 4.0, 4.4, 3.9, 3.5, 3.8, 3.8, 3.4, 3.7, 3.6, 3.3, 3.4, 3.0, 3.4, 3.5, 3.4, 3.2, 3.1, 3.4, 4.1, 4.2, 3.1, 3.2, 3.5, 3.6, 3.0, 3.4, 3.5, 2.3, 3.2, 3.5, 3.8, 3.0, 3.8, 3.2, 3.7, 3.3],
	      ["versicolor_x", 3.2, 3.2, 3.1, 2.3, 2.8, 2.8, 3.3, 2.4, 2.9, 2.7, 2.0, 3.0, 2.2, 2.9, 2.9, 3.1, 3.0, 2.7, 2.2, 2.5, 3.2, 2.8, 2.5, 2.8, 2.9, 3.0, 2.8, 3.0, 2.9, 2.6, 2.4, 2.4, 2.7, 2.7, 3.0, 3.4, 3.1, 2.3, 3.0, 2.5, 2.6, 3.0, 2.6, 2.3, 2.7, 3.0, 2.9, 2.9, 2.5, 2.8],
	      ["setosa", 0.2, 0.2, 0.2, 0.2, 0.2, 0.4, 0.3, 0.2, 0.2, 0.1, 0.2, 0.2, 0.1, 0.1, 0.2, 0.4, 0.4, 0.3, 0.3, 0.3, 0.2, 0.4, 0.2, 0.5, 0.2, 0.2, 0.4, 0.2, 0.2, 0.2, 0.2, 0.4, 0.1, 0.2, 0.2, 0.2, 0.2, 0.1, 0.2, 0.2, 0.3, 0.3, 0.2, 0.6, 0.4, 0.3, 0.2, 0.2, 0.2, 0.2],
	      ["versicolor", 1.4, 1.5, 1.5, 1.3, 1.5, 1.3, 1.6, 1.0, 1.3, 1.4, 1.0, 1.5, 1.0, 1.4, 1.3, 1.4, 1.5, 1.0, 1.5, 1.1, 1.8, 1.3, 1.5, 1.2, 1.3, 1.4, 1.4, 1.7, 1.5, 1.0, 1.1, 1.0, 1.2, 1.6, 1.5, 1.6, 1.5, 1.3, 1.3, 1.3, 1.2, 1.4, 1.2, 1.0, 1.3, 1.2, 1.3, 1.3, 1.1, 1.3],
	    ],
	    type: 'scatter'
	  },
	  axis: {
	    x: {
	      label: 'Sepal.Width',
	      tick: {
	        fit: false
	      }
	    },
	    y: {
	      label: 'Petal.Width'
	    }
	  }
	});

	var dataRadius = [15, 12, 6, 30, 36, 9, 45];
	var chartScatter = c3.generate({
	  bindto: "#bubblechart",
	  data: {
	    x: "data_x",
	    columns: [
	      ["data_x", 5, 2, 8, 10, 25, 16, 50],
	      ["data_y", 10, 20, 30, 40, 16, 35, 8],
	    ],
	    type: "scatter",
	  },
	  point: {
	    r: function(d) {
	      return dataRadius[d.index];
	    },
	  },
	  legend: {
	    show: false,
	  },
	  grid: {
	    x: {
	      show: true,
	    },
	    y: {
	      show: true,
	    },
	  },
	});
	</script>
</body>
</html>