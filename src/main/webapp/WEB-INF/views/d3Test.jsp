<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta http-equiv="X-UA-Compatible" content="ie=edge" />
  <title>D3-Test : Chart example</title>
  <script src="https://d3js.org/d3.v5.min.js"></script>
  <!-- API문서 : https://github.com/zziuni/d3/wiki/API-Reference -->
  <!-- <script src="/resources/d3/js/review_bar_chart.js"></script> -->
  <style type="text/css">
  	#svg-area {
  		position: relative;
	}
	
	#tooltip {
	  position: absolute;
	  opacity: 0;
	  width: 40px;
	  height: 20px;
	  line-height: 20px;
	  transition: all 0.3s;
	  border-radius: 5px;
	  text-align: center;
	  color: #fff;
	  font-size: 14px;
	  font-weight: bold;
	}
  </style>
</head>
<body>
	<div id="svg-area">
      <div id="tooltip"></div>
    </div>
</body>
</html>